Return-Path: <netdev+bounces-254351-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMSLBgo/emlB4wEAu9opvQ
	(envelope-from <netdev+bounces-254351-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 17:53:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 861AEA6518
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 17:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9DF84301BA41
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 16:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7581C36C589;
	Wed, 28 Jan 2026 16:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXBvlD1Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FD22DECDF;
	Wed, 28 Jan 2026 16:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769619032; cv=none; b=oKTRdMcihEqT3AKSgBWkjoUnxdmG/du5J50MQtLRsxav1u1U+mbt1W1NUUx9NG8f1Vy1RMLQl9c1oqYZXfrknjhmDbeYTRpYthgbW/86IdnXgSVG79JWi/bVoZZIR2uz9tk0+Pl9hVlfigcj8WeLjcXS75UKKvBhH/06aE8uQaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769619032; c=relaxed/simple;
	bh=1UyEpa3PQCXAaiGwapZKBeWnBxx40S80+WhX3uQJt4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XJRpokZSjemknL5aYB3lHGhCBelsbKyeps7CrwaKQemCgAvG5F5bp+EYf8KgjUQLijj5dg8YbxS2vEO3icRFhmT/S+IQ1sEIZnVKmIjOqju1Ky1Ght5koZLWCsYmX566n7kuloSd9PPMfJZ05O+e38WKt53VyU2nPRV3myDIUqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KXBvlD1Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62FC9C4CEF1;
	Wed, 28 Jan 2026 16:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769619032;
	bh=1UyEpa3PQCXAaiGwapZKBeWnBxx40S80+WhX3uQJt4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KXBvlD1YlPUkuhCdRNoOlAMLVwBTw2cEK/blQt2z+tT6+6xhg/bb/acS8rd7SM5Qt
	 XBqvwMDb/YXDBAn/cuwuy5rjpHfmBF3YVCKWiKRE7mSussyKmfWaRlkngZSYZNXwJL
	 Scrgtfdb1ppIWwWXuBShOIh5H3y5CQ9k7vJSEM9FsltuL2STrp4Mt7MxHTco1JsqYh
	 cStQhhCFszwUTKZkTUVUfsB24IxOhEQQ8WVcuauqr0++QiLuSCOr0DNhdbTOSlJDRL
	 FScuHqnceVeZ0E/N++vKAczeV9305tVX7xsDoV59JcxzFAbwMssB+sMXahhne29zKR
	 mTBODpcVzijsw==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vl8kQ-0000000DApU-0X8N;
	Wed, 28 Jan 2026 17:50:30 +0100
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
Subject: [PATCH v2 05/25] docs: kdoc_parser: add functions support for NestedMatch
Date: Wed, 28 Jan 2026 17:50:03 +0100
Message-ID: <43b1fb838ba73c3efc18ab605b892f531ffbed01.1769617841.git.mchehab+huawei@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254351-lists,netdev=lfdr.de,huawei];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mchehab@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,huawei];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 861AEA6518
X-Rspamd-Action: no action

Some annotations macros may have nested parenthesis, causing normal
regex parsing to fail.

Extend apply_transforms to also use NestedMatch and add support
for nested functions.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
---
 tools/lib/python/kdoc/kdoc_parser.py | 38 ++++++++++++++++++----------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index 3ba2cda2487a..ae5b2ef80f75 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -152,7 +152,7 @@ struct_xforms = [
     (KernRe(r'DEFINE_DMA_UNMAP_LEN\s*\(' + struct_args_pattern + r'\)', re.S), r'__u32 \1'),
 ]
 #
-# Regexes here are guaranteed to have the end delimiter matching
+# Struct regexes here are guaranteed to have the end delimiter matching
 # the start delimiter. Yet, right now, only one replace group
 # is allowed.
 #
@@ -160,6 +160,13 @@ struct_nested_prefixes = [
     (re.compile(r'\bSTRUCT_GROUP\('), r'\1'),
 ]
 
+#
+# Function Regexes here are guaranteed to have the end delimiter matching
+# the start delimiter.
+#
+function_nested_prefixes = [
+]
+
 #
 # Transforms for function prototypes
 #
@@ -207,13 +214,6 @@ var_xforms = [
 # Ancillary functions
 #
 
-def apply_transforms(xforms, text):
-    """
-    Apply a set of transforms to a block of text.
-    """
-    for search, subst in xforms:
-        text = search.sub(subst, text)
-    return text
 
 multi_space = KernRe(r'\s\s+')
 def trim_whitespace(s):
@@ -408,6 +408,8 @@ class KernelDoc:
         # Place all potential outputs into an array
         self.entries = []
 
+        self.nested = NestedMatch()
+
         #
         # We need Python 3.7 for its "dicts remember the insertion
         # order" guarantee
@@ -505,6 +507,16 @@ class KernelDoc:
         # State flags
         self.state = state.NORMAL
 
+    def apply_transforms(self, regex_xforms, nested_xforms, text):
+        """Apply a set of transforms to a block of text."""
+        for search, subst in regex_xforms:
+            text = search.sub(subst, text)
+
+        for search, sub in nested_xforms:
+            text = self.nested.sub(search, sub, text)
+
+        return text.strip()
+
     def push_parameter(self, ln, decl_type, param, dtype,
                        org_arg, declaration_name):
         """
@@ -881,11 +893,9 @@ class KernelDoc:
         # Go through the list of members applying all of our transformations.
         #
         members = trim_private_members(members)
-        members = apply_transforms(struct_xforms, members)
+        members = self.apply_transforms(struct_xforms, struct_nested_prefixes,
+                                        members)
 
-        nested = NestedMatch()
-        for search, sub in struct_nested_prefixes:
-            members = nested.sub(search, sub, members)
         #
         # Deal with embedded struct and union members, and drop enums entirely.
         #
@@ -1088,7 +1098,9 @@ class KernelDoc:
             #
             # Apply the initial transformations.
             #
-            prototype = apply_transforms(function_xforms, prototype)
+            prototype = self.apply_transforms(function_xforms,
+                                              function_nested_prefixes,
+                                              prototype)
 
         # Yes, this truly is vile.  We are looking for:
         # 1. Return type (may be nothing if we're looking at a macro)
-- 
2.52.0


