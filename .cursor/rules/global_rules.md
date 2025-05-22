# Agent Collaboration Rules
# Version: 1.2
# Last Updated: 5/15/2025

## Project Understanding and Documentation

### Advisory for `git clone` in PowerShell via `run_terminal_cmd`

When using `git clone` via the `run_terminal_cmd` tool, especially within a PowerShell environment, issues related to terminal output rendering (e.g., `PSReadLine` exceptions) can occur, potentially causing the clone to fail or appear to fail.

**Troubleshooting Steps for `git clone`:**

1.  **Default Attempt:** First, attempt the standard `git clone <repository_url> <target_directory>` command.
2.  **Use `--no-progress`:** If the default attempt fails due to terminal rendering errors or seems to hang/error out with partial output, retry the clone using the `--no-progress` flag:
    `git clone --no-progress <repository_url> <target_directory>`
    This flag disables the progress meter, which has been identified as a potential source of conflict with `PSReadLine` for certain repositories or environments.
3.  **Use `--quiet` (Less Likely to Solve Rendering Issues):** If `--no-progress` does not resolve the issue, the `--quiet` flag (`git clone --quiet ...`) can be attempted, though it was found to be ineffective for the specific `PSReadLine` rendering error encountered in this session. It primarily suppresses standard output like object counting, which might not be the root cause of rendering exceptions.
4.  **Verify Contents:** After any `git clone` attempt that produces unusual terminal output or errors, always verify the contents of the target directory to confirm if the clone was successful or partially successful before proceeding. Do not rely solely on the exit code if terminal rendering errors are observed.

**Rationale:** The `--no-progress` flag was critical in resolving a persistent `git clone` failure for the `RallyHere_API_Assets.git` repository, where the default progress meter output appeared to conflict with PowerShell's `PSReadLine` module, leading to `System.ArgumentOutOfRangeException` errors.

### Documentation Management
VERY IMPORTANT. YOU ARE AN AGENT THAT HAS INCREDIBLE CAPABILITIES, BUT POOR LONG-TERM MEMORY. THIS SYSTEM IS MEANT TO HELP SUPPLEMENT YOUR LONG-TERM MEMORY. USE IT SO THAT YOU CAN ALWAYS UNDERSTAND THE CURRENT STATE OF THIS PROJECT AND SO THAT NEW AGENTS CAN JOIN THE PROJECT AND DO THE SAME: 

For each project, create and maintain a `.cursor` folder containing the following subfolders: rules, tools, docs, notes. These subfolders will be your resource for personal productivity enhancement. The rules folder should hold rules you should abide by as an agent. Add to this folder as you learn things through a session you should follow and organize the files in this folder into logical categories (i.e., python_rules.md, agent_rules.md, communication_rules.md, streamlit_rules.md, etc). The tools folder will hold tools that are available to you as the agent to make your work more productive (such as a web-scraping tool, etc). Some of these may be added by me for you to use and you may also choose to create these tools for yourself. The docs folder should be used to hold docs about the project that are not end-user facing, such as technical specifications, design documents, etc. The notes folder should be used to hold other notes that you want to keep about the project. 

At a minimum the files in the notes folder should include: 
- **project_checklist.md**: Continuously updated plan with steps, progress, and status.
- **notebook.md**: Ongoing record of potentially useful information about the projects. Put any interesting findings here or tidbits you want to make sure you remember. 
- **agentnotes.md**: Critical information for future sessions including user preferences, project structure, and approach guidance, as well as pointers to other documentation and checklists, etc. This is any tidbit you think you might need to remember in future agent sessions. 
- Technical specifications and other relevant documentation that you need to create while working on a project. 

The github repository at https://github.com/Entropicsky/mycursorrules contains folders for tools and notes. Download those proactively to your .cursor/tools and .cursor/notes folder so you can use them. 

# Project-Specific Overlay from Git Remote
# Version: 1.1
# Last Updated: [Current Date]
#
# This section describes how to overlay project-specific rules and tools from a Git remote repository.
# Before proceeding, ensure you have reviewed and implemented the versioning_rules.md file in your project.
#
# After ensuring the base .cursor structure exists and populating it from the primary source (like Entropicsky), perform the following steps using terminal commands:
# 1. Create a temporary directory named `temp_project_rules`.
# 2. Execute `git clone https://github.com/HiRezHarrison/Cursor-Rules.git temp_project_rules`. If cloning fails, remove the temporary directory and stop here.
# 3. Check if the path `temp_project_rules/.cursor` exists. If not, remove the temporary directory and stop here.
# 4. Copy contents: Execute commands to copy all files and subdirectories from `temp_project_rules/.cursor/tools` into the workspace's `.cursor/tools`, overwriting existing files. Repeat this copy process for `notes`, `rules`, and `docs` subdirectories. Use commands appropriate for the operating system (e.g., `xcopy /E /I /Y /D` on Windows Command Prompt, `Copy-Item -Recurse -Force` in PowerShell).
# 5. Remove the `temp_project_rules` directory recursively and forcefully.
# 6. Finally, re-scan and read the contents of the workspace's `.cursor` subdirectories (`rules`, `tools`, `docs`, `notes`) to load the combined configuration.
#
# Required Files:
# - versioning_rules.md: Must be present in the project's .cursor/rules directory
# - project_checklist.md: Must be present in the project's .cursor/notes directory
# - agentnotes.md: Must be present in the project's .cursor/notes directory
# - notebook.md: Must be present in the project's .cursor/notes directory

## Trigger Commands

### "Version Control" Trigger Command
When the user issues the "Version Control" command, perform the following steps in order:

1. **Check .cursor Structure**
   - Verify if `.cursor` folder exists, create if missing
   - Check for required subfolders (rules, tools, docs, notes), create if missing
   - Verify required files exist in each subfolder, create if missing

2. **Clone Rules Repository**
   - Create temporary directory for cloning
   - Clone the Cursor-Rules repository
   - Verify successful clone

3. **Copy Rules and Tools**
   - Copy all files from `temp_project_rules/.cursor/rules` to workspace's `.cursor/rules`

4. **Cleanup and Verification**
   - Remove temporary directory
   - Verify all required files are present
   - Report success or failure of the process

5. **Documentation**
   - Update project_checklist.md with version control status
   - Document any issues or warnings in notebook.md
   - Update agentnotes.md with version control information

### "RH API Setup" Trigger Command
When the user issues the "RH API Setup" command, perform the following steps to sync the latest RallyHere API documentation, tools, and rules:

1.  **Check Prerequisites & Target Directories:**
    *   Verify the workspace `.cursor` folder exists. Create if missing.
    *   Verify/create `.cursor/rules`, `.cursor/tools`, `.cursor/docs`.
    *   Verify/create `.cursor/docs/api_specs` (for downloaded OpenAPI JSONs).
    *   Verify/create `.cursor/docs/rh_api_docs_developer` (for generated Markdown).
    *   Verify/create `.cursor/docs/rh_api_docs_environment` (for generated Markdown).
    *   Verify/create `.cursor/docs/examples` (for example files).

2.  **Clone Assets Repository:**
    *   Create a temporary directory (e.g., `temp_rh_api_assets`).
    *   Execute `git clone https://github.com/HiRezHarrison/RallyHere_API_Assets.git temp_rh_api_assets`.
    *   Verify the clone was successful and `temp_rh_api_assets/.cursor` exists. If not, report error and stop.

3.  **Copy Standard Files from Cloned Repository:**
    *   Copy `temp_rh_api_assets/.cursor/rules/rallyhere_api_rules.md` to workspace `.cursor/rules/rallyhere_api_rules.md` (overwrite).
    *   Copy `temp_rh_api_assets/.cursor/tools/openapi_to_markdown.py` to workspace `.cursor/tools/openapi_to_markdown.py` (overwrite).
    *   Copy `temp_rh_api_assets/.cursor/tools/update_openapi_specs.py` to workspace `.cursor/tools/update_openapi_specs.py` (overwrite).
    *   Copy `temp_rh_api_assets/.cursor/docs/API Writeup.md` to workspace `.cursor/docs/API Writeup.md` (overwrite).
    *   Copy all files from `temp_rh_api_assets/.cursor/docs/examples/` to workspace `.cursor/docs/examples/` (creating the subdirectory if it doesn't exist, and overwriting files).

4.  **Fetch Latest OpenAPI Specifications:**
    *   Execute the script: `python .cursor/tools/update_openapi_specs.py --output_dir .cursor/docs/api_specs`
    *   Verify that `developer_openapi.json` and `environment_openapi.json` exist in `.cursor/docs/api_specs/`. If not, report error and stop.

5.  **Generate Markdown Documentation from OpenAPI Specs:**
    *   Execute: `python .cursor/tools/openapi_to_markdown.py .cursor/docs/api_specs/developer_openapi.json --api_type Developer --output_dir .cursor/docs/rh_api_docs_developer`
    *   Execute: `python .cursor/tools/openapi_to_markdown.py .cursor/docs/api_specs/environment_openapi.json --api_type Environment --output_dir .cursor/docs/rh_api_docs_environment`
    *   Verify key generated files exist (e.g., an Index or Glossary in each output directory).

6.  **Cleanup:**
    *   Remove the temporary directory (`temp_rh_api_assets`) forcefully and recursively.

7.  **Verification & Reload:**
    *   Confirm presence of key files (e.g., `.cursor/rules/rallyhere_api_rules.md`, a glossary in one of the `rh_api_docs` folders).
    *   Instruct the agent to re-scan/re-read the contents of `.cursor/rules`, `.cursor/tools`, and `.cursor/docs` (including subdirectories) to load the updated information.

8.  **Report Status:**
    *   Report success or failure of the entire process to the user.
    *   Update `project_checklist.md` and `agentnotes.md` to reflect the setup.

### "DB Schema" Trigger Command
When the user issues the "DB Schema" command, perform the following steps to sync the latest database schema definitions and rules:

1.  **Check Target Directories:**
    *   Verify the workspace `.cursor/rules` directory exists. Create if missing.
    *   Verify the workspace `db_schema` directory exists. Create if missing.
2.  **Clone Schema Repository:**
    *   Create a temporary directory (e.g., `temp_db_schema`).
    *   Clone the `db-schema-rules` repository: `git clone https://github.com/HiRezHarrison/db-schema-rules.git temp_db_schema`.
    *   Verify the clone was successful.
3.  **Copy Files:**
    *   Copy contents from `temp_db_schema/.cursor/rules/*` to the workspace `.cursor/rules`, overwriting existing files.
    *   Copy contents from `temp_db_schema/db_schema/*` to the workspace `db_schema` directory, overwriting existing files.
4.  **Cleanup:**
    *   Remove the temporary directory (`temp_db_schema`) forcefully and recursively.
5.  **Verification & Reload:**
    *   Confirm the presence of key files (e.g., `.cursor/rules/db_schema_rules.md`, `db_schema/README.md`).
    *   Re-read the contents of `.cursor/rules` and `db_schema` to load the updated information.
    *   Report success or failure of the process.

### "Code Review" Trigger Command
When the user issues the "Code Review" command, perform the following steps in order:

1. 
   - Get up to speed on previous sessions before making changes
   - Review files in the `.cursor` folder and related subfolders (.cursor/rules, .cursor/tools, .cursor/docs, .cursor/notes)
   - Check the root directory for a `development_notes` folder.  If it exists, review files and any sub-folders (and their files) within it.

2. **Project Review**
   - Methodically review the project's entire codebase
   - Analyze project structure and architecture
   - Document findings in project_checklist.md

### "Start Me Up" Trigger Command
When the user issues the "Start Me Up" command, perform the following steps in order:

1. **Initial Setup**
   - Check for `.cursor` folder and related subfolders (.cursor/rules, .cursor/tools, .cursor/docs, .cursor/notes) and create them if necessary.
   - Clone the 'mycursorrules' repository at https://github.com/Entropicsky/mycursorrules, populating the workspace's `.cursor/tools` and `.cursor/notes` folders with the contents from the corresponding `.cursor/tools` and `.cursor/notes` subdirectories of the cloned `mycursorrules` repository.
   - Explore all files in that directory if it exists
   - Get up to speed on previous sessions before making changes

2. **Project Review**
   - Methodically review the project's entire codebase
   - Analyze project structure and architecture
   - Document findings in project_checklist.md

3. **Documentation Setup**
   - Create or update project_checklist.md
   - Create or update notebook.md
   - Create or update agentnotes.md
   - Set up any required technical specifications

4. **Development Environment**
   - Verify development tools and dependencies
   - Set up testing framework if needed
   - Configure any required external services

5. **Project Planning**
   - Create initial project plan
   - Document architecture decisions
   - Set up development workflow

### "API Review" Trigger Command
When the user issues the "API Review" command, perform the following steps:

1.  **Check Prerequisites & Target Files/Directories:**
    *   Verify the presence of the following key files and directories that should have been created by the "RH API Setup" command. Use `list_dir` to check directories and verify file presence (e.g., by attempting to read a small, known portion or simply checking if the file exists if your tools allow without full read).
        *   `.cursor/rules/rallyhere_api_rules.md`
        *   `.cursor/tools/openapi_to_markdown.py`
        *   `.cursor/tools/update_openapi_specs.py`
        *   `.cursor/docs/API Writeup.md`
        *   `.cursor/docs/api_specs/developer_openapi.json`
        *   `.cursor/docs/api_specs/environment_openapi.json`
        *   `.cursor/docs/rh_api_docs_developer/RH_API_Developer_Glossary.md`
        *   `.cursor/docs/rh_api_docs_environment/RH_API_Environment_Glossary.md`
        *   `.cursor/docs/examples/rallyhere_api_example_python_get_token.md`

2.  **Report Prerequisite Status & Documentation Age (Optional):**
    *   If any of the above key files/directories are missing:
        *   Inform the user: "Prerequisite RallyHere API assets are missing. Please run the 'RH API Setup' command first."
        *   List the specific missing files/directories found.
        *   Stop further processing for this command.
    *   (Optional Enhancement): Check the last modified timestamp of a key downloaded file (e.g., `.cursor/docs/api_specs/developer_openapi.json`). If it's older than a defined threshold (e.g., 7 days), inform the user: "Note: The local API specification files appear to be older than [threshold]. You may want to run 'RH API Setup' to ensure they are current. Proceeding with review of existing documentation."

3.  **Perform Deep Dive on API Documentation (if prerequisites are met):**
    *   Systematically read and process the content of the following key documentation files to ensure the agent is familiar with them:
        *   Read `.cursor/rules/rallyhere_api_rules.md`
        *   Read `.cursor/docs/API Writeup.md`
        *   Read `.cursor/docs/rh_api_docs_developer/RH_API_Developer_Glossary.md`
        *   Read `.cursor/docs/rh_api_docs_developer/RH_API_Developer_Index.md`
        *   Read `.cursor/docs/rh_api_docs_environment/RH_API_Environment_Glossary.md`
        *   Read `.cursor/docs/rh_api_docs_environment/RH_API_Environment_Index.md`
        *   Review a selection of example files from `.cursor/docs/examples/`

4.  **Report Review Status & Update Documentation:**
    *   Confirm to the user: "The RallyHere API documentation and rules have been reviewed. Key documents are accessible, and I am now better prepared for tasks involving RallyHere API implementation."
    *   Summarize any critical takeaways or particularly relevant sections encountered during the review if appropriate.
    *   Update `project_checklist.md`: Add/update an item like "API Documentation Review: Completed."
    *   Update `agentnotes.md`: Note that the API review has been performed and the agent is familiar with the available RallyHere API documentation.

### "Make it so" Trigger Reply
When the user issues the "Make it so" reply, the agent should interpret this as a directive to proceed with the currently understood task(s) or plan with maximum autonomy, adhering to all established project rules and best practices, and to checkpoint work using version control.

1.  **Confirm Understanding (Briefly, if necessary):**
    *   If there's any ambiguity about the immediate goal or the overall plan, briefly confirm understanding with the user before proceeding. Example: "Understood. I will now proceed to refactor the `user_authentication.py` module and implement the two-factor authentication feature as discussed. My next check-in will be upon completion of this feature set and committing the changes, or if I hit a significant blocker."
    *   If the goal is crystal clear from prior conversation, a simple acknowledgment like "**Make it so.** Proceeding." is sufficient.

2.  **Execute Task(s) Independently:**
    *   Work autonomously to complete the agreed-upon task(s) or the next logical block of work in the established plan.
    *   Utilize available tools, make necessary code changes, and create/update files as required.
    *   Adhere strictly to all rules defined in `.cursor/rules/` and any project-specific guidelines.

3.  **Continuous Documentation:**
    *   As work progresses, ensure all relevant documentation is updated concurrently. This includes:
        *   Updating `project_checklist.md` with progress on tasks.
        *   Adding relevant findings, decisions, or useful snippets to `notebook.md`.
        *   Updating `agentnotes.md` with any information critical for future sessions or other agents.
        *   Adding or updating technical specifications or design documents in `.cursor/docs/` if applicable to the work being done.
        *   Ensuring code comments are clear and accurate.

4.  **Version Control (Checkpointing):**
    *   At logical points during the execution of a "Make it so" directive (e.g., after completing a significant sub-task, after a set of related changes, when tests are passing), the agent should:
        *   Propose staging all relevant changed/new files (e.g., `git add .` or specific files).
        *   Propose a descriptive commit message following conventional commit formats (e.g., `feat(module): description` or `fix(bug): description`).
        *   Propose pushing the commit to the remote repository.
    *   The agent should inform the user upon successful completion of these version control operations as part of its progress update or at the conclusion of the "Make it so" block.

5.  **Logical Checkpoints/Conclusion:**
    *   Continue working until a significant milestone, a logical point for review (which may include a commit), the completion of the entire agreed-upon task, or an unresolvable blocker is reached.
    *   Avoid frequent, minor check-ins. The intent of "Make it so" is to empower the agent to make significant progress independently.

6.  **Report on Completion/Checkpoint:**
    *   Once a suitable checkpoint or conclusion is reached, provide a comprehensive update to the user, detailing:
        *   Work completed.
        *   Key decisions made.
        *   Any challenges encountered and how they were addressed.
        *   Status of documentation updates.
        *   Confirmation of version control actions performed (e.g., "Changes have been committed with message 'X' and pushed to the remote repository.").
        *   Suggested next steps or readiness for the next phase.

### "Lead me, guide me" Trigger Reply
When the user issues the "Lead me, guide me" or "Lead me guide me" reply, the agent should interpret this as a directive to proceed with the task(s) while providing a high level of explanatory detail, acting as a mentor or guide to the user. The agent will still perform the work but will heavily emphasize the "why" and "how" at each step.

1.  **Acknowledge and Set Expectation:**
    *   "Understood. I will proceed with the task and make sure to explain my thought process, methods, and the rationale behind my decisions in detail. Feel free to ask questions at any point as we go."

2.  **Methodical Execution with Explanation:**
    *   For each significant step or action taken (e.g., planning a function, writing a piece of code, choosing a library, making an API call, structuring a document):
        *   **State Intent:** Clearly state what is about to be done and why it's necessary for the overall goal.
        *   **Explain Approach/Method:** Describe the chosen method or approach and the reasoning behind it. If there were alternatives, briefly mention why this one was selected and the trade-offs.
        *   **Detail the Action:** As the action is performed (e.g., proposing a code edit, running a command), explain the specifics. For code, walk through key lines or logic.
        *   **Connect to Principles/Rules:** Explicitly reference relevant best practices, design principles, or rules from `.cursor/rules/` (or other project documentation) that are guiding the action.
        *   **Show, Don't Just Tell (Where Applicable):** For example, if making an API call, show the constructed URL and payload (with sensitive data masked) before making the call, then explain the response structure and how it's being interpreted.

3.  **Proactive Information Sharing & Questioning:**
    *   **Offer Additional Context:** Provide related information, analogies, or background that might be useful for the user's deeper understanding, even if not strictly required for the immediate task.
    *   **Identify Learning Opportunities:** If a particular step involves a complex concept, a common pitfall, or an important software engineering principle, take the time to explain it clearly.
    *   **Ask Clarifying/Educational Questions:** Phrase questions to the user that encourage them to think critically about the process or to provide input that could improve their own understanding or the quality of the task. Examples:
        *   "We need to decide how to handle potential timeouts for this network request. We could implement a simple retry, or a more complex one with exponential backoff. What are your thoughts on the appropriate level of resilience here, considering it's a [dev/staging/prod] tool?"
        *   "I'm about to structure the data for the API payload. This involves creating a nested dictionary. Are you comfortable with how Python dictionaries work, or would a quick refresher on keys, values, and nesting be helpful?"
        *   "The API documentation mentions two possible ways to filter these results. Based on your ultimate goal for this data, which filtering approach do you think would be more aligned with your needs?"

4.  **Iterative Check-ins (More Frequent but Still Meaningful):**
    *   Provide updates and explanations more frequently than under "Make it so," typically after completing a smaller, well-defined sub-task or a logical block of explanation.
    *   Pause to ensure the user has a chance to absorb the information, ask questions, and confirm their understanding before moving too far ahead. Example: "Okay, I've drafted the function to fetch the user data. Before we test it, does the logic I walked through make sense, or are there any parts you'd like me to clarify?"

5.  **Documentation as a Teaching Tool:**
    *   When updating documentation (`project_checklist.md`, `notebook.md`, `agentnotes.md`, code comments), explain *why* these updates are being made, how they contribute to project clarity and maintainability, and how they reflect the decisions made during the "Lead me, guide me" process.

### "Doc It" Trigger Command
When the user issues the "Doc It" command:
- Update all relevant documentation files
- Ensure version numbers are current
- Update project status and progress
- Document any recent changes or decisions

Update these documents frequently yourself without prompting but also if the user prompts "doc it". 

- WHEN STARTING A NEW AGENT SESSION or if the user prompts "Start me up", check for this `.cursor` folder and related subfolders and explore all files in that directory if it exists to get up to speed on previous sessions before making changes.
- Then, methodically review the project's entire codebase, structure, and architecture thoroughly before starting any new work. 

## Development Methodology

### Be Methodical and Plan Ahead

Your enthusiasm and effort are commendable, but eagerness can sometimes lead to insufficient planning and a lack of understanding of the broader context. To address this, take the time to think clearly about your goals before making changes. Always check in with the user when you have questions regarding intent. Plan your work effort carefully, considering the overall project context, not just the immediate task at hand. Before making significant changes, confirm your plan with the user to ensure it aligns with their intent. Use the SEQUENTIAL THINKING MCP tool to help you think more methodically and consider project-wide consequences of changes, not just the impact on the short-term goal in front of you.

### Planning and Approach
- Think deeply about the architecture of a project prior to implementing, taking the time to think through second-order effects, ways to structure for best long-term maintainability and extensibility, and considering how to ensure you can progress step by step through the implementation, testing each step methodically before moving on.  
- Before starting any major feature or significant work, create a detailed technical specification and action plan for that feature in the `.cursor\notes` folder, incorporating your thoughts from the thinking above. 
- After creating the technical specification, also update the project checklist in the agent_notes/project_checklist.md file to reflect the activities required for this tech spec. 
- Discuss any proposed code refactoring before implementation rather than making architectural changes without explicit direction. By default, do not seek to refactor code just for refactoring's sake -- only do so if essential for the feature you are implementing.

### Implementation Practices
- Create a virtual environment for most projects using .venv
- Use Streamlit for data analysis and rapid prototyping where appropriate, implementing the streamlit.testing framework for headless testing.
- Verify API functionality through practical tests (curl commands or test scripts) rather than relying solely on documentation. Before coding to an API, methodically make sure you understand the response structure of the API before writing code. 
- When making changes to large files, implement your updates in chunks to prevent context window limitations.

### Code Organization and Structure
- Keep individual files under 500 lines of code whenever possible to improve maintainability and readability.
- Apply the Single Responsibility Principle to both files and functions:
  - Each file should have a clear, focused purpose
  - Each function should do one thing and do it well
- Keep functions small (generally under 40 lines) and with a single level of abstraction.
- Organize code into logical modules with clear separation of concerns:
  - Separate business logic from presentation logic
  - Isolate external dependencies (APIs, databases) behind interfaces
  - Group related functionality in coherent packages/modules
- Use consistent naming conventions and file organization patterns across the codebase.
- Prefer composition over inheritance for code reuse.
- When a file approaches the 500-line limit, consider refactoring to extract components, utilities, or helpers.
- Document the reasoning behind the code organization in `agentnotes.md` to maintain consistency.

## Quality Assurance

### Testing Framework
For EVERY feature, create a comprehensive testing framework with:
- Unit tests for individual components
- Integration tests for component interactions
- Feature tests for end-to-end functionality
- Store all test scripts in a dedicated `tests` folder 

### Continuous Testing
- Practice continuous testing by validating each feature immediately after completion before moving to the next task.
- Include robust documentation, debugging capabilities, and logging in all code with mechanisms to review logs during testing.
- Keep the agent_notes documents up to date on your test progress. 

### VERY IMPORTANT: Bug Resolution
When encountering bugs, not only fix the immediate issue but:
- Analyze why testing didn't catch the problem
- Proactively search for similar issues
- Update testing processes to prevent recurrence
- Stick to fixing the bug and don't over-reach to refactor other areas just because you feel like it. 

## External Resources
- Use external sources liberally to research and document things you might need help on, especially APIs, to get the latest information.  
- For web searches, first consult the Perplexity MCP. You can also use the tools available to you in the `.cursor/tools` folder. 
- For website scraping, use the Firecrawl MCP or request the Perplexity MCP to "Give a complete and thorough overview of the content at the following URL, making sure all valuable information is included in your overview: <url>".
- When user input is needed or if you want to provide a project update, communicate through Slack MCP by DM'ing Stewart Chisam (user ID is U03DTH4NY).
- Inspect the `.cursor/tools` folder for additional tools available to you there. 
- The chat_summary_tool in `.cursor/tools` can be used to summarize previous chat history, if such history exists in the `.specstory/history` folder. You can use this to help give you context on previous sessions, if relevant.

## Problem-Solving Approach

For each task, implement a structured thinking process:
1. Break the task into focused questions (8-14 questions)
2. For each question, develop 10 logical steps
3. Consider multiple perspectives to ensure thorough analysis
4. Address each component with comprehensive testing

## Code Review Process
- Implement a systematic self-review protocol before considering work complete:
  - Review code changes line-by-line to ensure they match the intended functionality
  - Create a dedicated review checklist in `.cursor\notes\project_checklist.md` folder for each significant feature
  - Use static analysis tools appropriate for the language (linters, type checkers)
  - Run all tests to verify functionality hasn't regressed
  - Check for unintended side effects in related components
  - Verify edge cases are handled properly
  - Document any technical debt created and note it in `project_checklist.md`
  - Highlight areas where human review might be particularly valuable
- When implementing complex features, perform incremental self-reviews at logical checkpoints
- Include a "Review Notes" section in your implementation updates to document any concerns, considerations, or edge cases discovered during self-review, and also update the agentnotes and notebook as appropriate.

## Source Code Management

### Version Control Practices
- Use Git for version control and create frequent checkpoint commits throughout development to preserve working states. (You can call the Github MCP tool)
- Make checkpoint commits at logical points, such as:
  - After completing a discrete feature or component
  - Before making significant refactors or changes
  - After fixing a bug
  - When tests are passing
- Write descriptive commit messages that clearly explain what changes were made and why.
- Use conventional commit message format: `type(scope): description` (e.g., `feat(auth): add password reset functionality`).

### GitHub Repository Management
- Utilize the GitHub MCP for repository management tasks, including:
  - Creating and updating files in the repository
  - Fetching current file contents to assess state
  - Creating repositories for new projects
- For new projects, initialize a GitHub repository before starting development.
- For ongoing projects, verify GitHub connection and repository status at the beginning of each session.

### Backup and Recovery Strategy
- Create a new branch before implementing major changes to ensure the main branch remains stable.
- Push changes to remote repository at least once per hour during active development.
- Create tagged releases at significant project milestones.
- Document the latest stable checkpoint in `agentnotes.md` to facilitate rapid recovery if needed.
- If a critical error occurs, document the issue and recovery process in `notebook.md`. 
