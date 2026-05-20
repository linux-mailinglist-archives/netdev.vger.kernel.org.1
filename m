Return-Path: <netdev+bounces-289681-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLfLFAUKDWrysQUAu9opvQ
	(envelope-from <netdev+bounces-289681-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 03:10:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC16158678B
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 03:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53B7F30191B7
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 01:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F442C0299;
	Wed, 20 May 2026 01:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ln7+b2WU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6132B2652B0
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 01:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779239409; cv=none; b=gov8EGmf8FBzzREaNdDdYA+tEaOEvBIlOe7SFcou1eku+Tlu/IgVInqkUoPNpiFXDMeR5OkMPDnEQ2HBnYYLYLkti5uZZtIFz+GUiZiAHuoOiM+F9edVF6T+XhK9DNu1ElLsR5XxBkZTmqlPQmYMCz8vCugyvhUC8U62zZCorh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779239409; c=relaxed/simple;
	bh=XbR+zrQDIizkBzsj9EYCe0njUKFGJ0Y0Y53O0fge1Ow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZmWNsbuXQln3C6c7Uh/rWO7zEHoEJapxOgB/QmJQ92AaWhN11+JAOWTZsb97WgXHZImzu8mOJRKJIK+BFtomr93N0rVXy7krXPBYxJ9dFZbUM6I8HmVIXRDz7AGlr7dT3nlbkElN0pNOisAEUqVAiFvWZ5WfTWfV+FbfvzuD1XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ln7+b2WU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B411F000E9;
	Wed, 20 May 2026 01:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779239408;
	bh=+WXklrEMz4WOMJ43ugx5LpuHCOSD7tZgDQ0FPEiyNhk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ln7+b2WUptEeuXgcgZ7TFTu49UQyr/3wMdSQM3B3wAJFVNnIXQjCe9KHtOxuxJ1yK
	 S+4I7znLGXfCQ5NQJHB552xO823s2rjzM0RUbI7seYPgVOZGp7kMOT36VqYHzfLOhl
	 FMuCuk4U/dGEZimx2axnsc4BeGlIv8+O0PuC48U4izLfpyDBIULLjXYZLEYxKjBuAO
	 6URACnMpwFlI+USTL0aCyI95KIvGmcbpT2zWgPMsIfVorcWGeDjlXkWqHGCFqFs4A6
	 81Cm2M5aRCqwlt9IyP7oGsYHlZW5D9vVLAgBmH79fmN1HssW6e3QY/QfcQ0QZkeE5n
	 GHHPe7Irs2JRg==
Message-ID: <88ec611d-53c1-447b-b236-67523532cfaa@kernel.org>
Date: Tue, 19 May 2026 19:10:07 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [iproute2-next V4 0/6] netshaper: Extend netshaper support
Content-Language: en-US
To: Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org
Cc: alexander.duyck@gmail.com, stephen@networkplumber.org, pabeni@redhat.com,
 kuba@kernel.org, ernis@linux.microsoft.com
References: <20260518202353.390827-1-mohsin.bashr@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260518202353.390827-1-mohsin.bashr@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289681-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,networkplumber.org,redhat.com,kernel.org,linux.microsoft.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: AC16158678B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/18/26 2:23 PM, Mohsin Bashir wrote:
> From: Mohsin Bashir <hmohsin@meta.com>
> 
> This series extends the netshaper CLI with missing parameter support
> and adds the group command for building scheduling hierarchies.
> 
> The existing netshaper tool only supports setting bw-max on individual
> shapers. This series adds the remaining shaper attributes (bw-min,
> weight) needed for TX scheduling, and introduces the group command
> which ties leaf shapers to a parent node in a single operation.
> 
> Changelog:
> V4:
>   Patch 2:
>   - Reorder BW_MAX/BW_MIN to BW_MIN/BW_MAX in usage text
> 
>   Patch 5:
>   - Extract parse_scope_id() to share handle/parent scope+id parsing
>   - Extract parse_leaves() with dynamic allocation, removing the
>     static NET_SHAPER_MAX_LEAVES limit
>   - Add per-leaf weight and priority support in group command
>   - Remove inline declarations
>   - Skip parent nest when parent not specified
>   - Use goto free_leaves for error cleanup
> 
>   Patch 6:
>   - Document per-leaf weight and priority usage
> 
> V3: https://lore.kernel.org/netdev/20260511183915.797792-1-mohsin.bashr@gmail.com/
> V2: https://lore.kernel.org/netdev/20260509022353.3470738-1-mohsin.bashr@gmail.com/
> V1: https://lore.kernel.org/netdev/20260501011611.3533573-1-mohsin.bashr@gmail.com/
> 
> Mohsin Bashir (6):
>   netshaper: Extract parse_scope() and parse_rate() helpers
>   netshaper: Add bw-min and weight parameter support
>   netshaper: Extend show output with parent, bw-min and weight
>   netshaper: Extract struct shaper_args and parse_shaper_arg() helper
>   netshaper: Add group command for creating scheduling hierarchies
>   netshaper: Update man page for new parameters and group command
> 
>  include/utils.h       |   1 +
>  man/man8/netshaper.8  | 150 ++++++++++--
>  netshaper/netshaper.c | 554 +++++++++++++++++++++++++++++++++++-------
>  3 files changed, 597 insertions(+), 108 deletions(-)
> 

Applied the set to iproute2-next.

With those patches applied, I asked Claude (model is Opus 4.7) "check
man/man8/netshaper.8 for errors"; output below. Please send followup
patches or address why current state is ok (ie., why claude is wrong).
Thanks,


● I read the page and compared it against netshaper/netshaper.c. The
page renders without man warnings, so the issues below are content /
accuracy:

  Substantive issues

  1. Missing parent scope restriction. In the PARAMETERS description
(man/man8/netshaper.8:188-198) parent is said to "use the same scope/id
syntax as handle." But the code
  (netshaper/netshaper.c:357-360, parse_scope_id()) rejects anything
other than node or netdev. The man page never says that queue is invalid
as a parent scope. The synopsis at
  man/man8/netshaper.8:52-55 also uses an unrestricted PARENT_SCOPE token.

  2. Missing leaf scope restriction. parse_leaves() at
netshaper/netshaper.c:416-420 rejects any leaf whose scope is not queue.
The PARAMETERS section for leaves
  (man/man8/netshaper.8:200-209) only implies this by example ("Each
leaf is given as scope queue id ID") rather than stating the constraint.
Worth saying it explicitly so the reader
  doesn't think they can drop in a node leaf.

  3. Confusing "scheduling groups" wording on the node scope. Line
95-96: "Shapers representing scheduling groups that can be placed at
arbitrary locations..." — group is also a
  command name, so calling a node "a scheduling group" muddles the
terminology. "Intermediate scheduling nodes" (matching tc-style
language) would be clearer and matches what's said
  two paragraphs later ("scheduling node shaper").

  4. show / delete synopsis shows id as optional for all scopes. Lines
36-42 give [ id HANDLE_ID ] for both commands, but the code requires id
for queue and node scopes on every
  command (netshaper.c:268-282, called from do_cmd() for SET/GET/DELETE
alike). The description does spell this out under the scope list, but
readers who only glance at the synopsis
  will be misled. The set synopsis at line 26-27 has the same problem.

  5. -help synopsis is incomplete. main() strips a leading -
(netshaper.c:608-609), so --help, --Version, --color all work too. The
man page only documents the single-dash forms.
  Minor — but inconsistent with what the binary accepts.


  Style / formatting nits

  6. Bold/italic mixed on literal keywords in the synopsis. dev, handle,
scope, and the scope values are bold; but bw-min, bw-max, weight, id,
parent, leaves get italicized via .RI
  (e.g. lines 26-33, 50-61). Convention in iproute2 man pages is bold
for literal keywords. The page renders fine but the typography is
inconsistent.

  7. { … } [ … ] for leaves is unusual (lines 62-64). Renders as leaves
{ scope queue id ID [ weight WEIGHT ] [ priority PRIO ] } [ ... ]. Curly
braces normally denote a required
  choice; here they're being used as repeat-group brackets. A plain
comment in the description or leaves SPEC [ SPEC ... ] with SPEC defined
separately would be clearer.

  8. .IR DEV etc. Single-argument uses of .IR / .BR (lines 23, 25, 27,
29, 31, 33, 38, 40, 42, …) are equivalent to .I / .B. Cosmetic.

  9. Date in .TH ("7 Oct 2025", line 1) hasn't been bumped despite later
commits (e14b336, 2638fef) updating the man page.

  10. Example 4 wording is slightly ambiguous. "Creates a node shaper
under the netdev parent with a 10 Gbit/s cap" — bw-max 10gbit applies to
the node (handle), but a reader could
  attach it to "netdev parent." Tightening to "…with a 10 Gbit/s cap on
the node" would remove the ambiguity.

  The most worth-fixing items are #1, #2, #3, and #9.

