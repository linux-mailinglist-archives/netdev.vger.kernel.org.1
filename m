Return-Path: <netdev+bounces-254365-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FGaByNAemm14wEAu9opvQ
	(envelope-from <netdev+bounces-254365-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 17:58:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F15A6691
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 17:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B929630D9A9D
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 16:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F1837649C;
	Wed, 28 Jan 2026 16:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCWNel7W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D2437647F;
	Wed, 28 Jan 2026 16:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769619036; cv=none; b=VhUb1ZE9gZbioRC7ZhhDmxvBVCkSnTdg82qZsP0fwDUmI5x7xnYq3BE59o+Lo6LkUEXnbOc+xZhFpyvCFsrZ1Ru5EU2FfS3osFs5+6M4C9y1Xr15arzfAuxWNCctVosh3azo6Hidv6ZWVvh8UK+bpiaBaqmwpFUjjsU76wssHIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769619036; c=relaxed/simple;
	bh=0ot0R67HaXRc1V/itdeBaIZAxY2fnyJVatiNePQaLeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WXn1zCtEHBJvRigOL0WzwIsU9yBTEo1zUh7d4DGzHqLBCCFB4ox9XL+Kdcg2a0cB6AluOnJb/fltqgiyYQcFJrO0Bag0dL+rFa5tBn02Wxm8NmNPfW1vcPGT0kqaOPDtG40kif1hM7vjcJ8OGwrYDLipC8//LSIFVABmz2sqUwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LCWNel7W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AFACC4CEF7;
	Wed, 28 Jan 2026 16:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769619036;
	bh=0ot0R67HaXRc1V/itdeBaIZAxY2fnyJVatiNePQaLeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LCWNel7W+vLM6dl/jinSacwdQxpfjma+Mnc2KSAAOYfec6Qvlw8DJOtrX6eKffEVv
	 t5xlaeZAN8mnyGOXevISJ9p50QMyZDe3d9cygCfaFOKQEyfTJ4/DgiBfAv44qS4SMX
	 UYXxWwiEhp5OJrf73W/gnMJcanu0nwCjOc19IiyFpnB2fKte+fWpzK24b9BLvh/iMd
	 CrMZxvxXLV4kzEAInJApk+N6Ma+aAsx16YoBB/LEXyHU1VfwcXRUXKqFsY9WidTlKC
	 NYNPcqqpuRmFKGae/I/KfL3i7ZHLHtAdaIu5kzLHIRLhEyavK5qXRXfzP6EVBfX2HF
	 SRxv+bO8kaFPQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vl8kU-0000000DB6E-1TqQ;
	Wed, 28 Jan 2026 17:50:34 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH v2 19/25] docs: kdoc_re: make NextedMatch use KernRe
Date: Wed, 28 Jan 2026 17:50:17 +0100
Message-ID: <da1582cddce141b76692d9a3a778613a75fe8682.1769617841.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769617841.git.mchehab+huawei@kernel.org>
References: <cover.1769617841.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254365-lists,netdev=lfdr.de,huawei];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mchehab@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,huawei];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 96F15A6691
X-Rspamd-Action: no action

Instead of using re_compile, let's create the class with the
rejex and use KernRe to keep it cached.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/lib/python/kdoc/kdoc_parser.py | 55 ++++++++--------------------
 tools/lib/python/kdoc/kdoc_re.py     | 15 +++++---
 2 files changed, 25 insertions(+), 45 deletions(-)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index 4d52a00acfad..3a5614106af7 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -153,32 +153,7 @@ struct_xforms = [
     (KernRe(r'DEFINE_DMA_UNMAP_ADDR\s*\(' + struct_args_pattern + r'\)', re.S), r'dma_addr_t \1'),
     (KernRe(r'DEFINE_DMA_UNMAP_LEN\s*\(' + struct_args_pattern + r'\)', re.S), r'__u32 \1'),
     (KernRe(r'VIRTIO_DECLARE_FEATURES\(([\w_]+)\)'), r'union { u64 \1; u64 \1_array[VIRTIO_FEATURES_U64S]; }'),
-]
-#
-# Struct regexes here are guaranteed to have the end delimiter matching
-# the start delimiter. Yet, right now, only one replace group
-# is allowed.
-#
-struct_nested_prefixes = [
-    (re.compile(r'\bSTRUCT_GROUP\('), r'\0'),
-]
-
-#
-# Function Regexes here are guaranteed to have the end delimiter matching
-# the start delimiter.
-#
-function_nested_prefixes = [
-    (re.compile(r"__cond_acquires\s*\("), ""),
-    (re.compile(r"__cond_releases\s*\("), ""),
-    (re.compile(r"__acquires\s*\("), ""),
-    (re.compile(r"__releases\s*\("), ""),
-    (re.compile(r"__must_hold\s*\("), ""),
-    (re.compile(r"__must_not_hold\s*\("), ""),
-    (re.compile(r"__must_hold_shared\s*\("), ""),
-    (re.compile(r"__cond_acquires_shared\s*\("), ""),
-    (re.compile(r"__acquires_shared\s*\("), ""),
-    (re.compile(r"__releases_shared\s*\("), ""),
-    (re.compile(r"__attribute__\s*\("), ""),
+    (NestedMatch(r'\bSTRUCT_GROUP\('), r'\0'),
 ]
 
 #
@@ -210,6 +185,17 @@ function_xforms = [
     (KernRe(r"DECL_BUCKET_PARAMS\s*\(\s*(\S+)\s*,\s*(\S+)\s*\)"), r"\1, \2"),
     (KernRe(r"__no_context_analysis\s*"), ""),
     (KernRe(r"__attribute_const__ +"), ""),
+    (NestedMatch(r"__cond_acquires\s*\("), ""),
+    (NestedMatch(r"__cond_releases\s*\("), ""),
+    (NestedMatch(r"__acquires\s*\("), ""),
+    (NestedMatch(r"__releases\s*\("), ""),
+    (NestedMatch(r"__must_hold\s*\("), ""),
+    (NestedMatch(r"__must_not_hold\s*\("), ""),
+    (NestedMatch(r"__must_hold_shared\s*\("), ""),
+    (NestedMatch(r"__cond_acquires_shared\s*\("), ""),
+    (NestedMatch(r"__acquires_shared\s*\("), ""),
+    (NestedMatch(r"__releases_shared\s*\("), ""),
+    (NestedMatch(r"__attribute__\s*\("), ""),
 ]
 
 #
@@ -230,7 +216,6 @@ var_xforms = [
 # Ancillary functions
 #
 
-
 multi_space = KernRe(r'\s\s+')
 def trim_whitespace(s):
     """
@@ -424,8 +409,6 @@ class KernelDoc:
         # Place all potential outputs into an array
         self.entries = []
 
-        self.nested = NestedMatch()
-
         #
         # We need Python 3.7 for its "dicts remember the insertion
         # order" guarantee
@@ -523,14 +506,11 @@ class KernelDoc:
         # State flags
         self.state = state.NORMAL
 
-    def apply_transforms(self, regex_xforms, nested_xforms, text):
+    def apply_transforms(self, xforms, text):
         """Apply a set of transforms to a block of text."""
-        for search, subst in regex_xforms:
+        for search, subst in xforms:
             text = search.sub(subst, text)
 
-        for search, sub in nested_xforms:
-            text = self.nested.sub(search, sub, text)
-
         return text.strip()
 
     def push_parameter(self, ln, decl_type, param, dtype,
@@ -909,8 +889,7 @@ class KernelDoc:
         # Go through the list of members applying all of our transformations.
         #
         members = trim_private_members(members)
-        members = self.apply_transforms(struct_xforms, struct_nested_prefixes,
-                                        members)
+        members = self.apply_transforms(struct_xforms, members)
 
         #
         # Deal with embedded struct and union members, and drop enums entirely.
@@ -1125,9 +1104,7 @@ class KernelDoc:
             #
             # Apply the initial transformations.
             #
-            prototype = self.apply_transforms(function_xforms,
-                                              function_nested_prefixes,
-                                              prototype)
+            prototype = self.apply_transforms(function_xforms, prototype)
 
         # Yes, this truly is vile.  We are looking for:
         # 1. Return type (may be nothing if we're looking at a macro)
diff --git a/tools/lib/python/kdoc/kdoc_re.py b/tools/lib/python/kdoc/kdoc_re.py
index 28ca5032f40c..aabfd6c4fd71 100644
--- a/tools/lib/python/kdoc/kdoc_re.py
+++ b/tools/lib/python/kdoc/kdoc_re.py
@@ -182,7 +182,10 @@ class NestedMatch:
     #
     #   FOO(arg1, arg2, arg3)
 
-    def _search(self, regex, line):
+    def __init__(self, regex):
+        self.regex = KernRe(regex)
+
+    def _search(self, line):
         """
         Finds paired blocks for a regex that ends with a delimiter.
 
@@ -204,7 +207,7 @@ class NestedMatch:
 
         stack = []
 
-        for match_re in regex.finditer(line):
+        for match_re in self.regex.finditer(line):
             start = match_re.start()
             offset = match_re.end()
             string_char = None
@@ -252,7 +255,7 @@ class NestedMatch:
                         yield start, offset, pos + 1
                         break
 
-    def search(self, regex, line):
+    def search(self, line):
         """
         This is similar to re.search:
 
@@ -260,11 +263,11 @@ class NestedMatch:
         returning occurrences only if all delimiters are paired.
         """
 
-        for t in self._search(regex, line):
+        for t in self._search(line):
 
             yield line[t[0]:t[2]]
 
-    def sub(self, regex, sub, line, count=0):
+    def sub(self, sub, line, count=0):
         """
         This is similar to re.sub:
 
@@ -283,7 +286,7 @@ class NestedMatch:
         cur_pos = 0
         n = 0
 
-        for start, end, pos in self._search(regex, line):
+        for start, end, pos in self._search(line):
             out += line[cur_pos:start]
 
             # Value, ignoring start/end delimiters
-- 
2.52.0


