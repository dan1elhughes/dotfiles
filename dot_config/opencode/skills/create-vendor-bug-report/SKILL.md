---
name: create-vendor-bug-report
description: Use when asked to escalate to a vendor, report a bug to a manufacturer, file a ticket with an OEM, or write up API or device evidence for vendor support. Do not use for internal tickets or customer-facing replies.
---

# Create Vendor Bug Report

Create a concise Markdown report that gives the vendor enough evidence to reproduce and investigate a bug without exposing unrelated customer or internal details. Copy the finished report to the clipboard.

## Workflow

1. Read the investigation, logs, and issue context. Retrieve missing evidence when tools can provide it; do not invent it.
2. Write the report with these required sections, in order:
   - `### Expected behaviour`
   - `### Actual behaviour`
   - `### Metadata`
   - `### Impact`
3. Under **Actual behaviour**, include 1-3 representative UTC-timestamped request/response pairs. Put labels outside fences. Use valid, indented JSON, or a suitable `text`/`xml` fence for non-JSON. Write `Response body: empty` when applicable.
4. Put correlation details under **Metadata**: first/last observed UTC time, vendor device identifiers, model, firmware, endpoint, and other relevant environment details. Omit unavailable fields.
5. If questions could help, show the proposed wording to the user separately. Add `### Questions` after **Impact** only after explicit approval.
6. End with `Internal reference: <URL>`. This is the only permitted internal URL. Include no issue title or details; omit the line when no URL exists.
7. Validate each JSON body with `jq -e .`.
8. Write the report to `mktemp "${TMPDIR}/vendor-bug-report.XXXXXX.md"`, copy it with `pbcopy < "$REPORT_FILE"`, verify with `cmp -s "$REPORT_FILE" <(pbpaste)`, then delete the file. Confirm success only after the comparison passes.

## Content Rules

- State only facts supported by the evidence.
- In **Metadata**, prefer vendor-correlatable identifiers: device serial, model, firmware, endpoint, vendor-visible request/trace ID, timestamp, status, error code, and latency.
- Exclude client/customer names, organization IDs, internal user/action IDs, and internal asset IDs unless we need an asset ID for safe internal traceability.
- Exclude credentials, tokens, authorization and internal correlation headers, customer domains, internal hostnames except the final reference, user agents, IP addresses, and unrelated fields.
- Exclude personal data: names, emails, usernames, phone numbers, addresses, precise locations, and registration plates. Keep a vendor device serial or VIN only when needed for investigation.
- Redact JSON values as `"<redacted>"`; never invent replacements. Use `"<truncated>"` for omitted long values and note truncation outside the fence.
- Do not add assessment, root cause, recommendation, or speculation. Put observed comparisons under **Actual behaviour**.
- Do not assume what we should ask the vendor. Questions require explicit approval.
- Normalize timestamps to UTC ISO 8601.
- Use standard Markdown, not Slack-specific formatting.

## Report Contract

````markdown
## [Vendor or product]: [specific failure]

### Expected behaviour

[The observable successful result. Include the expected response only when known.]

### Actual behaviour

[Short evidence-backed summary and vendor-relevant identifiers.]

#### [Operation] - [UTC ISO 8601 timestamp] ([latency])

Request:

```json
{
  "example": "properly formatted"
}
```

Response (HTTP [status]):

```json
{
  "code": 0,
  "message": "example"
}
```

### Metadata

- First observed: [UTC ISO 8601 timestamp]
- Last observed: [UTC ISO 8601 timestamp]
- Device identifier: [vendor-visible identifier]
- Model: [model]
- Firmware: [firmware]
- Endpoint: [method and path]

### Impact

[Concrete effect on the affected device, operation, or integration.]

[Scope and duration, without identifying the customer.]

Internal reference: https://issues.example.com/issue/ABC-123
````

After approval, insert `### Questions` between **Impact** and the internal reference.

## Final Check

Before copying, confirm that:

- Expected behaviour, actual behaviour, metadata, and impact are distinct.
- JSON is valid and contains no comments or ellipses.
- No customer identity, secret, personal data, unnecessary internal ID/domain, or unsupported claim remains.
- Any question was approved, and the issue URL appears only in the final internal-reference line.

If any check fails, fix the report and repeat the checks before copying it.
