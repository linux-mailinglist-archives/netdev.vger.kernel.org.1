Return-Path: <netdev+bounces-253100-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOHfFnwkdWnZBAEAu9opvQ
	(envelope-from <netdev+bounces-253100-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 20:58:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8159F7EC90
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 20:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC43B3013270
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 19:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B18122B8CB;
	Sat, 24 Jan 2026 19:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="rEXrZFqE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539B016132A
	for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 19:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769284714; cv=none; b=YegRXZBE1HnqxYXE3O3gLh3yyUcnSH7VGcs+Om19tFNGUHAfB3e4xCbJvZctnqfjaKnfsZ1JyWeCdABIT4G37VKbdFQYny2Jhr+f0J2+nS5jNH1fH5kZbTKi9MjWAY3YfHuO/Vd23Uzpr4tZfk3hr/steD+2R4hGFGyeOriE10k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769284714; c=relaxed/simple;
	bh=pJUODHpONt/09rJXakcvzDxGAb4W7bEYhMQoqGIhf60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nuWxSK0CZ06jYUKh+VidnQ1uG9FP0SIT3Bjp+61xep9fuB70WEERuHGTPCLyCqBocv0UF30v/6HLNTryAYTPfsmIM2FTPCLxbT+NV7mkxioJzg9e6m8U7N6H/PfF1GLxWDydwiuSRowKGvE0pqmtXfG+IzblNhdN14fnUe/m9S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=rEXrZFqE; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47ee07570deso25173405e9.1
        for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 11:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769284711; x=1769889511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Thxg1+3ZmYvafMc+WeKYQSiOm5o0FnQwdAIYLXWQxQ=;
        b=rEXrZFqEgzNtq5l2wRATerAGzfCzajgdkFLcAi2NOKSXPV58xbSMh5UDWbIJeMCreO
         zbYinUoYnHdqKdViQoJY0RvVWZbVqL4OnCxHr12Jl6/XaLtgq1ijsr1fLh+Xep9SKNzG
         tH+czG/Rqw8biEmU/SUN2kQQ+ZRRAtHEYI+Q23rHhkjHFedUuf5QrDlu9r1cLlVhdVr4
         lHIlSltBl9F8sXOa6kbA/ZbWWJ1AD2Sus5Tz7b3BHUXbvTgmbahP4GM2P3QS9f7fsqnm
         H0wHAlLVdMTyeCT6wY0iWysUYGcUo1u6iS+B/jDgl6cM2oTWpc8YLD4q85WlxuXGD06N
         apfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769284711; x=1769889511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2Thxg1+3ZmYvafMc+WeKYQSiOm5o0FnQwdAIYLXWQxQ=;
        b=oHtslMSrkRqCtjEu8yncJPQ9SS2Q518xDzPsYXC4NdFdhxtINHEztQNBTz0Zol+d8c
         lLtza7ZOoIPamBVeQyVUlpu/ZdpHvxVMM++ew0ZB2LSS/5yadfVpeEE/RvHydUaInvT9
         ecil/uqvY/nL91q03J6MxIjR6lod+noOnVNkUCLLoeo3vjn6w/pDTI0yQY/fCIVVJ5bd
         q3nmkJ8yAH6nQRjIod2COJha/7tuK1t1xBqaDf6RHuycD/llGiudTbI5WarOLeFbUi64
         JtVIqmA06fVvgkoYyoWRr/YAtiOc9mLE2r/rixKQrbK0FBtLJX3aNXJrwjO6YUMO6DFU
         clfA==
X-Gm-Message-State: AOJu0YwMG2iifq6J4gBpVi2IiVK+ziRiEwf9IE1krsDxF37z5ZjFX6QI
	lxadkeAMqS3diakcBHZqT6YMT6+nbHfnkm74MTxXbch1rYwkNQNtWm3HhCBje7s975iW/+lv69V
	GWEKR
X-Gm-Gg: AZuq6aJ8fWqbYZR6PILeCpeEtExqUR8Ozr4u+NVd+a4Kr7fgRYNH/U5LqgN77wv6VoY
	DrX5vjzp28iHVPA12KPU/Jq0bHyqmkXY7tV1SIhKsJdppje+y8dS5DbX9H4CzkKmqwhcUhYBtJ4
	y8ajg5EfK+sRpToPbjPPuj+SlFJtGqPmKX9o0nk/3RHBR0nHEhCKuAWfeQ/PaOh5iFKJZ/iUyxb
	PpdUO3idcVRqWV288+JtLAU5bvfHR1Z1LtgP9vwzf/LIEMJ+ujkTn5R5d4aSwRvs2C8dEhkKA54
	dN+qPFbYrSYOzbxH+JzoLoIdiMtjLdCXNzFPmBBxE7BMbzcE0uTqNMC/jyxJ/p7AoCI6x+A+YJw
	Afba/H7ewsXG0KRU6XG1T8WgSF0CJdI/ZooVmXgtVtl+UyMc4DK4V4pZtJf0nTpe4n5vkwlqqB+
	Bmk6+AdOvnYzrL82pm7qdlgFFDTm/eJ06nQRmvhiiTXRjynsYzTQ==
X-Received: by 2002:a05:600c:6748:b0:47e:e20e:bbb0 with SMTP id 5b1f17b1804b1-4804c9a4690mr114034795e9.6.1769284710681;
        Sat, 24 Jan 2026 11:58:30 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804d85cff5sm144573525e9.7.2026.01.24.11.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jan 2026 11:58:30 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2-next 1/7] dcb: fix grammar and style issues in man pages
Date: Sat, 24 Jan 2026 11:49:25 -0800
Message-ID: <20260124195824.221305-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260124195824.221305-1-stephen@networkplumber.org>
References: <20260124195824.221305-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253100-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,networkplumber.org:mid,networkplumber.org:email,networkplumber-org.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 8159F7EC90
X-Rspamd-Action: no action

This patch addresses various grammatical errors, style inconsistencies,
and clarity issues across the DCB man page documentation.

Changes by file:

dcb.8:
  - Capitalize first word of -n option description
  - Add missing article "The" in -b option description
  - Fix verb form "shown" -> "show" in -s option description
  - Add missing dcb-dcbx(8) reference in SEE ALSO section

dcb-app.8:
  - Add missing article "the" before "APP table"
  - Fix singular/plural: "value" -> "values"
  - Improve phrasing: "priority of both 1 and 2" -> "priorities 1 and 2"
  - Make command descriptions consistent (present tense)
  - Simplify relative clause construction in default-prio description
  - Fix PCP/DEI description formatting and punctuation

dcb-apptrust.8:
  - Remove inappropriate period in NAME section
  - Improve clarity by removing unnecessary commas and redundant phrasing
  - Use present tense instead of future in DESCRIPTION
  - Make command descriptions consistent with proper articles

dcb-buffer.8:
  - Remove unnecessary "be" in DESCRIPTION
  - Add missing comma in prio-buffer parameter description

dcb-dcbx.8:
  - Capitalize first word of static parameter description

dcb-ets.8:
  - Add missing commas after introductory phrases in prio-tc and
    tc-tsa parameter descriptions

dcb-rewr.8:
  - Capitalize month name in TH date
  - Fix subject-verb agreement and plural forms in DESCRIPTION
  - Make command descriptions consistent (present tense)
  - Fix PCP/DEI description formatting and punctuation
  - Add missing commas in SEE ALSO section
  - Fix spacing in REPORTING BUGS section

No functional changes. All technical content remains accurate.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 man/man8/dcb-app.8      | 24 ++++++++++++------------
 man/man8/dcb-apptrust.8 | 16 ++++++++--------
 man/man8/dcb-buffer.8   |  4 ++--
 man/man8/dcb-dcbx.8     |  2 +-
 man/man8/dcb-ets.8      |  4 ++--
 man/man8/dcb-rewr.8     | 34 +++++++++++++++++-----------------
 man/man8/dcb.8          |  7 ++++---
 7 files changed, 46 insertions(+), 45 deletions(-)

diff --git a/man/man8/dcb-app.8 b/man/man8/dcb-app.8
index be505a0b..dea36a2f 100644
--- a/man/man8/dcb-app.8
+++ b/man/man8/dcb-app.8
@@ -81,9 +81,9 @@ the DCB (Data Center Bridging) subsystem
 .SH DESCRIPTION
 
 .B dcb app
-is used to configure APP table, or application priority table in the DCB (Data
+is used to configure the APP table, or application priority table in the DCB (Data
 Center Bridging) subsystem. The APP table is used to assign priority to traffic
-based on value in one of several headers: EtherType, L4 destination port, or
+based on values in one of several headers: EtherType, L4 destination port, or
 DSCP. It also allows configuration of port-default priority that is chosen if no
 other prioritization rule applies.
 
@@ -99,7 +99,7 @@ The APP table is a set of DCB APP entries. The only requirement is that
 duplicate entries are not added. Notably, it is valid to have conflicting
 priority assignment for the same selector and protocol ID. For example, the set
 of two APP entries (DSCP, 10, 1) and (DSCP, 10, 2), where packets with DSCP of
-10 should get priority of both 1 and 2, form a well-defined APP table. The
+10 should get priorities 1 and 2, form a well-defined APP table. The
 .B dcb app
 tool allows low-level management of the app table by adding and deleting
 individual APP 3-tuples through
@@ -116,12 +116,12 @@ prioritization is in effect for a given selector and protocol ID.
 
 .TP
 .B show
-Display all entries with a given selector. When no selector is given, shows all
+Displays all entries with a given selector. When no selector is given, shows all
 APP table entries categorized per selector.
 
 .TP
 .B flush
-Remove all entries with a given selector. When no selector is given, removes all
+Removes all entries with a given selector. When no selector is given, removes all
 APP table entries.
 
 .TP
@@ -133,11 +133,11 @@ table.
 
 .TP
 .B replace
-Take the list of entries mentioned as parameter, and add those that are not
-present in the APP table yet. Then remove those entries, whose selector and
+Takes the list of entries mentioned as parameter, and adds those that are not
+present in the APP table yet. Then removes those entries, whose selector and
 protocol ID have been mentioned as parameter, but not with the exact same
 priority. This has the effect of, for the given selector and protocol ID,
-causing that the table only contains the priority (or priorities) given as
+ensuring that the table only contains the priority (or priorities) given as
 parameter.
 
 .SH PARAMETERS
@@ -148,7 +148,7 @@ the parameter name is to be used as a simple keyword without further arguments.
 
 .TP
 .B default-prio \fIPRIO-LIST
-The priority to be used for traffic the priority of which is otherwise
+The priority to be used for traffic whose priority is otherwise
 unspecified. The argument is a list of individual priorities. Note that
 .B default-prio
 rules are configured as triplets (\fBEtherType\fR, \fB0\fR, \fIPRIO\fR).
@@ -198,9 +198,9 @@ turns the show translation off.
 \fIPCP-MAP\fR uses the array parameter syntax, see
 .BR dcb (8)
 for details. Keys are PCP/DEI. Values are priorities assigned to traffic with
-matching PCP/DEI. PCP/DEI values are written as a combination of numeric- and
-symbolic values, to accommodate for both. PCP always in numerical form e.g
-0 .. 7 and DEI in symbolic form e.g 'de' (drop-eligible), indicating that the
+matching PCP/DEI. PCP/DEI values are written as a combination of numeric and
+symbolic values, to accommodate both. PCP is always in numerical form, e.g.,
+0 .. 7 and DEI in symbolic form, e.g., 'de' (drop-eligible), indicating that the
 DEI bit is 1 or 'nd' (not-drop-eligible), indicating that the DEI bit is 0.
 In combination 2de:1 translates to a mapping of PCP=2 and DEI=1 to priority 1.
 
diff --git a/man/man8/dcb-apptrust.8 b/man/man8/dcb-apptrust.8
index ddc2133f..77ac0a4a 100644
--- a/man/man8/dcb-apptrust.8
+++ b/man/man8/dcb-apptrust.8
@@ -1,7 +1,7 @@
 .TH DCB-APPTRUST 8 "22 November 2022" "iproute2" "Linux"
 .SH NAME
 dcb-apptrust \- show / configure per-selector trust and trust order of the
-application priority table of the DCB (Data Center Bridging) subsystem.
+application priority table of the DCB (Data Center Bridging) subsystem
 .SH SYNOPSIS
 .sp
 .ad l
@@ -39,21 +39,21 @@ Application Priority Table, see
 .BR dcb-app (8)
 for details on how to configure app table entries.
 
-Selector trust can be used by the
-software stack, or drivers (most likely the latter), when querying the APP
-table, to determine if an APP entry should take effect, or not. Additionally, the
-order of the trusted selectors will dictate which selector should take
-precedence, in the case of multiple different APP table selectors being present.
+Selector trust can be used by the software stack or drivers (most likely the
+latter) when querying the APP table, to determine whether an APP entry should
+take effect. Additionally, the order of the trusted selectors dictates which
+selector should take precedence, in the case of multiple different APP table
+selectors being present.
 
 .SH COMMANDS
 
 .TP
 .B show
-Display all trusted selectors.
+Displays all trusted selectors.
 
 .TP
 .B set
-Set new list of trusted selectors. Empty list is effectively the same as
+Sets a new list of trusted selectors. An empty list is effectively the same as
 removing trust entirely.
 
 .SH PARAMETERS
diff --git a/man/man8/dcb-buffer.8 b/man/man8/dcb-buffer.8
index c7ba6a99..4d9e6f40 100644
--- a/man/man8/dcb-buffer.8
+++ b/man/man8/dcb-buffer.8
@@ -52,7 +52,7 @@ the DCB (Data Center Bridging) subsystem
 
 .B dcb buffer
 is used to configure assignment of traffic to port buffers based on traffic
-priority, and sizes of those buffers. It can be also used to inspect the current
+priority, and sizes of those buffers. It can also be used to inspect the current
 configuration, as well as total device memory that the port buffers take.
 
 .SH PARAMETERS
@@ -73,7 +73,7 @@ there are any hidden or internal buffers.
 .B prio-buffer \fIPRIO-MAP
 \fIPRIO-MAP\fR uses the array parameter syntax, see
 .BR dcb (8)
-for details. Keys are priorities, values are buffer indices. For each priority
+for details. Keys are priorities, values are buffer indices. For each priority,
 sets a buffer where traffic with that priority is directed to.
 
 .TP
diff --git a/man/man8/dcb-dcbx.8 b/man/man8/dcb-dcbx.8
index bafc18f6..b06617ad 100644
--- a/man/man8/dcb-dcbx.8
+++ b/man/man8/dcb-dcbx.8
@@ -74,7 +74,7 @@ does not mandate this.
 
 .TP
 .B static
-indicates the engine supports static configuration. No actual negotiation is
+Indicates the engine supports static configuration. No actual negotiation is
 performed, negotiated parameters are always the initial configuration.
 
 .SH EXAMPLE & USAGE
diff --git a/man/man8/dcb-ets.8 b/man/man8/dcb-ets.8
index 9c64b33e..9373d640 100644
--- a/man/man8/dcb-ets.8
+++ b/man/man8/dcb-ets.8
@@ -101,7 +101,7 @@ Whether local host should accept configuration from peer TLVs.
 .B reco-prio-tc \fIPRIO-MAP
 \fIPRIO-MAP\fR uses the array parameter syntax, see
 .BR dcb (8)
-for details. Keys are priorities, values are traffic classes. For each priority
+for details. Keys are priorities, values are traffic classes. For each priority,
 sets a TC where traffic with that priority is directed to.
 
 .TP
@@ -111,7 +111,7 @@ sets a TC where traffic with that priority is directed to.
 \fITSA-MAP\fR uses the array parameter syntax, see
 .BR dcb (8)
 for details. Keys are TCs, values are Transmission Selection Algorithm (TSA)
-keywords described below. For each TC sets an algorithm used for deciding how
+keywords described below. For each TC, sets an algorithm used for deciding how
 traffic queued up at this TC is scheduled for transmission. Supported TSAs are:
 
 .B strict
diff --git a/man/man8/dcb-rewr.8 b/man/man8/dcb-rewr.8
index 03b59cf4..a2ee704c 100644
--- a/man/man8/dcb-rewr.8
+++ b/man/man8/dcb-rewr.8
@@ -1,4 +1,4 @@
-.TH DCB-REWR 8 "15 may 2023" "iproute2" "Linux"
+.TH DCB-REWR 8 "15 May 2023" "iproute2" "Linux"
 .SH NAME
 dcb-rewr \- show / manipulate the rewrite table of
 the DCB (Data Center Bridging) subsystem
@@ -59,11 +59,11 @@ ID, and priority. Selector is an enumeration that picks one of the
 prioritization namespaces. Currently, only the DSCP and PCP selector namespaces
 are supported by dcb rewr.
 
-The rewrite table is a list of DCB rewrite rules, that applies to packets
-with matching priority.  Notably, it is valid to have conflicting rewrite
-assignment for the same selector and priority. For example, the set of two
+The rewrite table is a list of DCB rewrite rules that applies to packets
+with matching priority. Notably, it is valid to have conflicting rewrite
+assignments for the same selector and priority. For example, the set of two
 rewrite entries (DSCP, 10, 1) and (DSCP, 11, 1), where packets with priority 1
-should have its DSCP value rewritten to both 10 and 11, form a well-defined
+should have their DSCP values rewritten to both 10 and 11, form a well-defined
 rewrite table.
 .B dcb rewr
 tool allows low-level management of the rewrite table by adding and deleting
@@ -81,12 +81,12 @@ rewrite rule is in effect for a given selector and priority.
 
 .TP
 .B show
-Display all entries with a given selector. When no selector is given, shows all
+Displays all entries with a given selector. When no selector is given, shows all
 rewrite table entries categorized per selector.
 
 .TP
 .B flush
-Remove all entries with a given selector. When no selector is given, removes all
+Removes all entries with a given selector. When no selector is given, removes all
 rewrite table entries.
 
 .TP
@@ -98,11 +98,11 @@ rewrite table.
 
 .TP
 .B replace
-Take the list of entries mentioned as parameter, and add those that are not
-present in the rewrite table yet. Then remove those entries, whose selector and
+Takes the list of entries mentioned as parameter, and adds those that are not
+present in the rewrite table yet. Then removes those entries, whose selector and
 priority have been mentioned as parameter, but not with the exact same
 protocol ID. This has the effect of, for the given selector and priority,
-causing that the table only contains the protocol ID (or ID's) given as
+ensuring that the table only contains the protocol ID (or IDs) given as
 parameter.
 
 .SH PARAMETERS
@@ -134,10 +134,10 @@ turns the show translation off.
 \fIPCP-MAP\fR uses the array parameter syntax, see
 .BR dcb (8)
 for details. Keys are priorities. Values are PCP/DEI for traffic with
-matching priority. PCP/DEI values are written as a combination of numeric- and
-symbolic values, to accommodate for both. PCP always in numeric form e.g 0 ..
-7 and DEI in symbolic form e.g 'de' (drop-eligible), indicating that the DEI
-bit is 1 or 'nd' (not-drop-eligible), indicating that the DEI bit is 0.  In
+matching priority. PCP/DEI values are written as a combination of numeric and
+symbolic values, to accommodate both. PCP is always in numeric form, e.g., 0 ..
+7 and DEI in symbolic form, e.g., 'de' (drop-eligible), indicating that the DEI
+bit is 1 or 'nd' (not-drop-eligible), indicating that the DEI bit is 0. In
 combination 1:2de translates to a mapping of priority 1 to PCP=2 and DEI=1.
 
 .SH EXAMPLE & USAGE
@@ -192,14 +192,14 @@ prio-pcp 1:1nd 2:2de
 Exit status is 0 if command was successful or a positive integer upon failure.
 
 .SH SEE ALSO
-.BR dcb (8)
-.BR dcb-app (8)
+.BR dcb (8),
+.BR dcb-app (8),
 .BR dcb-apptrust (8)
 
 .SH REPORTING BUGS
 Report any bugs to the Network Developers mailing list
 .B <netdev@vger.kernel.org>
-where the development and maintenance is primarily done.  You do not have to be
+where the development and maintenance is primarily done. You do not have to be
 subscribed to the list to send a message there.
 
 .SH AUTHOR
diff --git a/man/man8/dcb.8 b/man/man8/dcb.8
index a1d6505e..f04fa7b7 100644
--- a/man/man8/dcb.8
+++ b/man/man8/dcb.8
@@ -29,7 +29,7 @@ dcb \- show / manipulate DCB (Data Center Bridging) settings
 
 .TP
 .BR "\-n" , " \--netns " <NETNS>
-switches
+Switches
 .B dcb
 to the specified network namespace
 .IR NETNS .
@@ -42,7 +42,7 @@ utility and exit.
 
 .TP
 .BR "\-b", " --batch " <FILENAME>
-Read commands from provided file or standard input and invoke them. First
+Read commands from provided file or standard input and invoke them. The first
 failure will cause termination of dcb.
 
 .TP
@@ -70,7 +70,7 @@ When combined with -j generate a pretty JSON output.
 
 .TP
 .BR "\-s" , " --statistics"
-If the object in question contains any statistical counters, shown them as
+If the object in question contains any statistical counters, show them as
 part of the "show" output.
 
 .SH OBJECTS
@@ -142,6 +142,7 @@ Exit status is 0 if command was successful or a positive integer upon failure.
 .BR dcb-app (8),
 .BR dcb-apptrust (8),
 .BR dcb-buffer (8),
+.BR dcb-dcbx (8),
 .BR dcb-ets (8),
 .BR dcb-maxrate (8),
 .BR dcb-pfc (8),
-- 
2.51.0


