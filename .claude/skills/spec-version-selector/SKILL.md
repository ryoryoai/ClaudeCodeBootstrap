---
name: spec-version-selector
description: Select optimal spec/API/library versions from candidates. Use when spec/REQ.md contains version options or external dependencies need evaluation.
---

# spec-version-selector

## When to Use

- spec/REQ.md contains multiple version candidates (APIs, libraries, frameworks)
- External dependencies need version pinning
- Migration between versions is being considered

## Process

1. **Gather Candidates**
   - List all version options from spec/REQ.md
   - Identify external API versions, library versions, runtime versions

2. **Analyze Repository Constraints**
   - Check existing lock files (package-lock.json, pnpm-lock.yaml, yarn.lock, Cargo.lock, go.sum, etc.)
   - Check runtime version files (.nvmrc, .python-version, rust-toolchain.toml, go.mod)
   - Check CI configuration for version constraints
   - Check existing imports/usages for compatibility

3. **Evaluate Each Candidate**
   - LTS status and end-of-life dates
   - Deprecated features or breaking changes
   - Compatibility with existing code
   - Migration cost (breaking changes, refactoring needed)
   - Security advisories

4. **Selection Criteria (Priority Order)**
   - (1) Compatibility with existing codebase
   - (2) Security (no known vulnerabilities, active maintenance)
   - (3) Stability (prefer LTS over bleeding edge)
   - (4) Migration cost (lower is better)
   - (5) Feature completeness for requirements

## Output

### 1. spec/SPEC_LOCK.yml

```yaml
# Spec Version Lock
# Generated: YYYY-MM-DD
# Do not edit manually - managed by spec-version-selector

locked_versions:
  - name: '<dependency-name>'
    version: '<selected-version>'
    type: 'api|library|runtime|framework'
    reason: '<brief selection reason>'
    alternatives_considered:
      - version: '<alt-version>'
        rejected_because: '<reason>'

metadata:
  selector_run: 'YYYY-MM-DD'
  next_review: 'YYYY-MM-DD' # +6 months or at next major release
```

### 2. docs/SPEC_SELECTION.md

- Candidates compared (table format)
- Selection rationale for each locked version
- Compatibility analysis results
- Migration costs (if switching from existing)
- Risks and mitigations
- Review schedule

### 3. harness/DECISIONS.md (append)

- Short ADR entry for version selection

## Rules

- "Latest" is NOT automatically "optimal"
- Prefer LTS versions unless features require newer
- Document rejected alternatives with clear reasons
- Set a review date for version reassessment
- Never select deprecated or EOL versions
