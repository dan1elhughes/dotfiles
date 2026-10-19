#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/../.."

check_routing() {
  local data="$1"
  local expected="$2"
  chezmoi execute-template --override-data "$data" --file dot_config/openchamber/routing.json.tmpl |
    jq -e --argjson expected "$expected" '
      def model: .providerID + "/" + .modelID;
      ([.categories.trivial.model, .categories.research.model,
        .categories.implement.model, .categories.hard.model] | map(model)) == $expected
      and .fallback.model == .categories.research.model
      and .enabled == true and .preserveCache == true
      and .minConfidence == 0.6 and .safetyNet.enabled == false
    '
}

check_routing \
  '{"routingTrivialModel":"codex/gpt-6-luna-fast","routingResearchModel":"codex/gpt-5.6-terra-fast","routingImplementModel":"codex/gpt-6.1-sol-fast","routingHardModel":"codex/gpt-6-astra-fast"}' \
  '["codex/gpt-6-luna-fast","codex/gpt-5.6-terra-fast","codex/gpt-6.1-sol-fast","codex/gpt-6-astra-fast"]'

check_routing \
  '{"routingTrivialModel":"opencode-go/mimo-v2.6-flash","routingResearchModel":"opencode-go/deepseek-v4.1-flash","routingImplementModel":"opencode-go/glm-5.3-flash","routingHardModel":"opencode-go/glm-5.3"}' \
  '["opencode-go/mimo-v2.6-flash","opencode-go/deepseek-v4.1-flash","opencode-go/glm-5.3-flash","opencode-go/glm-5.3"]'

check_routing \
  '{"routingTrivialModel":"one/small","routingResearchModel":"two/research","routingImplementModel":"three/build","routingHardModel":"four/hard"}' \
  '["one/small","two/research","three/build","four/hard"]'

check_routing \
  '{"routingTrivialModel":"","routingResearchModel":"","routingImplementModel":"","routingHardModel":""}' \
  '["opencode-go/mimo-v2.6-flash","opencode-go/deepseek-v4.1-flash","opencode-go/glm-5.3-flash","opencode-go/glm-5.3"]'

if chezmoi execute-template --override-data '{"routingHardModel":"invalid"}' \
  --file dot_config/openchamber/routing.json.tmpl; then
  echo "Invalid model format was accepted" >&2
  exit 1
fi
