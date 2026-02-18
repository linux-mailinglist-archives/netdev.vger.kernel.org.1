Return-Path: <netdev+bounces-259277-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gA66DE+TlWn1SQIAu9opvQ
	(envelope-from <netdev+bounces-259277-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 11:24:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD361555B9
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 11:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A86623030068
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 10:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48A334CFA8;
	Wed, 18 Feb 2026 10:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fd3Y2AfS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBEF34C81F;
	Wed, 18 Feb 2026 10:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771409607; cv=none; b=mJv8jmGuRkIPF8hEIN50NkxTEuY/MHhXqNxCRXI7FfwNHdDK9t06FDkjQ538XOGVQsQeA9mcQwbjAR3g17BXih+zog9qGabPO9St0/xx2+DWGCwpi9H8slSpWYMkB9yiDzF/fRTaQjHM8Q2wOKOneO4XmkBK9TBwc+KQuIThPzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771409607; c=relaxed/simple;
	bh=LSo+D03oZi5uYnZP1zzS1JgRumV9SCEqB+7zq9VZC18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L7+TUsF4OHNlaHOLpEjMBKiSxewELSTS58e4pFc3sWBgANDRvjp9zt422wl2PFHDAv7yZMhdinj6u5JPP5Yn1mQWaIWmtsQzlF86urJ4t2+gHBWIc04FZoBtjDVbcmHmXwOrYGIvRLrcW+XNTBo2+ktV0mz3essTjOHm//AB1Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fd3Y2AfS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59838C19421;
	Wed, 18 Feb 2026 10:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771409607;
	bh=LSo+D03oZi5uYnZP1zzS1JgRumV9SCEqB+7zq9VZC18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fd3Y2AfSZCLVb5ho0UWRUs58DTPrrOkIU7PSANmR8ki1jLt2DsXQ2ROs4qWey8qkA
	 J50SoWlEXy1c02lhZfVCQnSD8wdxJclhGd1SGwaZi2YAoS4/vGmi+qQp9sgg+/EwZC
	 ZkVhNcSvjx2gh4MVquWOXQ0g1bmybFGBRklgB7c2XYzLfQaxh1z+0B8n/PLSoWgXbK
	 4wVBJBNy1Rr2jw+rNVPFdTCByZ6wyMv7tZLaNMP9+ThwXv1Ppz3BoRY90kHq1RyVA5
	 fBhWlrLWbEnhUupj4ZE1juMVzNYwPg87WERnqEzAklV+uq0H2UdQC4d9AziGWxIAWa
	 b2c4EWOzUHEEQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vseYf-00000000LnT-1nte;
	Wed, 18 Feb 2026 11:13:25 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 24/38] docs: kdoc_parser: use the new CFunction class
Date: Wed, 18 Feb 2026 11:12:54 +0100
Message-ID: <7c62d09dfbdfa1c9ff26817cdd3a291775fa9199.1771408406.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1771408406.git.mchehab+huawei@kernel.org>
References: <cover.1771408406.git.mchehab+huawei@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259277-lists,netdev=lfdr.de,huawei];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mchehab@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,huawei];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 5DD361555B9
X-Rspamd-Action: no action

The match logic for transforms becomes a lot clearer if we use
CFunction convenient alias class instead of NestedMatch.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 tools/lib/python/kdoc/kdoc_parser.py | 38 ++++++++++++++--------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index b63a70f184eb..e1914b2a6ab7 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -13,7 +13,7 @@ import sys
 import re
 from pprint import pformat
 
-from kdoc.kdoc_re import NestedMatch, KernRe
+from kdoc.kdoc_re import CFunction, KernRe
 from kdoc.kdoc_item import KdocItem
 
 #
@@ -119,22 +119,22 @@ struct_xforms = [
     #
     # As it doesn't properly match the end parenthesis on some cases.
     #
-    # So, a better solution was crafted: there's now a NestedMatch
+    # So, a better solution was crafted: there's now a CFunction
     # class that ensures that delimiters after a search are properly
     # matched. So, the implementation to drop STRUCT_GROUP() will be
     # handled in separate.
     #
-    (NestedMatch(r'\bstruct_group\s*\('), r'\2'),
-    (NestedMatch(r'\bstruct_group_attr\s*\('), r'\3'),
-    (NestedMatch(r'\bstruct_group_tagged\s*\('), r'struct \1 { \3 } \2;'),
-    (NestedMatch(r'\b__struct_group\s*\('), r'\4'),
+    (CFunction('struct_group'), r'\2'),
+    (CFunction('struct_group_attr'), r'\3'),
+    (CFunction('struct_group_tagged'), r'struct \1 { \3 } \2;'),
+    (CFunction('__struct_group'), r'\4'),
 
     #
     # Replace macros
     #
-    # TODO: use NestedMatch for FOO($1, $2, ...) matches
+    # TODO: use CFunction on all FOO($1, $2, ...) matches
     #
-    # it is better to also move those to the NestedMatch logic,
+    # it is better to also move those to the CFunction logic,
     # to ensure that parentheses will be properly matched.
     #
     (KernRe(r'__ETHTOOL_DECLARE_LINK_MODE_MASK\s*\(([^\)]+)\)', re.S),
@@ -186,17 +186,17 @@ function_xforms = [
     (KernRe(r"DECL_BUCKET_PARAMS\s*\(\s*(\S+)\s*,\s*(\S+)\s*\)"), r"\1, \2"),
     (KernRe(r"__no_context_analysis\s*"), ""),
     (KernRe(r"__attribute_const__ +"), ""),
-    (NestedMatch(r"__cond_acquires\s*\("), ""),
-    (NestedMatch(r"__cond_releases\s*\("), ""),
-    (NestedMatch(r"__acquires\s*\("), ""),
-    (NestedMatch(r"__releases\s*\("), ""),
-    (NestedMatch(r"__must_hold\s*\("), ""),
-    (NestedMatch(r"__must_not_hold\s*\("), ""),
-    (NestedMatch(r"__must_hold_shared\s*\("), ""),
-    (NestedMatch(r"__cond_acquires_shared\s*\("), ""),
-    (NestedMatch(r"__acquires_shared\s*\("), ""),
-    (NestedMatch(r"__releases_shared\s*\("), ""),
-    (NestedMatch(r"__attribute__\s*\("), ""),
+    (CFunction("__cond_acquires"), ""),
+    (CFunction("__cond_releases"), ""),
+    (CFunction("__acquires"), ""),
+    (CFunction("__releases"), ""),
+    (CFunction("__must_hold"), ""),
+    (CFunction("__must_not_hold"), ""),
+    (CFunction("__must_hold_shared"), ""),
+    (CFunction("__cond_acquires_shared"), ""),
+    (CFunction("__acquires_shared"), ""),
+    (CFunction("__releases_shared"), ""),
+    (CFunction("__attribute__"), ""),
 ]
 
 #
-- 
2.52.0


