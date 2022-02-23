---
sidebar_position: 1
---

# Pages

An object that behaves identically to the Pages instance.

## Constructor

```lua
local pages = Pages.new(array content[, int pageSize[, function callback]])
```

### Parameters

|Type|Name|Default|Description|
|-|-|-|-|
|array|content||The content to pagify.|
|int|pageSize|0|The maximum number of elements in each page. If 0 or nil, all contents will be in the first page.|
|function|callback|nil|The function to run when calling `AdvanceToNextPageAsync`|

## Properties

|Type|Name|Description|
|-|-|-|-|
|bool|`IsFinished`|Whether or not the last page has been reached.|

## Functions

|Return Type|Signature|Description|
|-|-|-|
|void|[`AdvanceToNextPageAsync()`](#advancetonextpageasync)|Move to the next page in the sequence.|
|array|[`GetCurrentPage()`](#getcurrentpage)|Get the contents of the current page.|

## AdvanceToNextPageAsync

Moves to the next page in the sequence. The provided callback, if any, will be run before returning. If the final page has already been reached, this will throw an error.

## GetCurrentPage

Returns the contents of the current page.
