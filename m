Return-Path: <netdev+bounces-254626-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDeEIZoXe2lCBQIAu9opvQ
	(envelope-from <netdev+bounces-254626-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 09:17:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F18FAAD613
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 09:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 59E603019322
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 08:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564EA37BE65;
	Thu, 29 Jan 2026 08:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GSjxV5N8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E3837C0F2;
	Thu, 29 Jan 2026 08:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769674111; cv=none; b=uTTqEy8ob3UXH3Bqba3/XsxFhrRgfAev9XVomCJRKIhqjiimQ0+Xv/HsoXxyrIZCpmpX3lagsycv2p8XYVxlF0s0jV6fSZ1vdxrmUMVV/vNn7ux4ndj2XK86fktcDf/8zlsMw7CYDKQnngV7I6jpLpjONpuaGPaGbHcIwNJSr+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769674111; c=relaxed/simple;
	bh=HZIWPQtHuKRBHDG4lIuIJ9k4nhNjGP3jcqbI9/NYBFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j2nvXdTkWTG2kS9CeK+RZfOHWYpUhARvzwzASi1rD/xPERbLJgQfAURROynFDfyObg00FSTYtut6+bBCbdXfeXOkaZLTaZttbVVqMIkZSNwBc2AG6b/IB6Ftkq6PbGlETZ5Lupga0Eh51llD+J9/jy5L0lXvTfm++Iehmab5lhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GSjxV5N8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26799C2BCFC;
	Thu, 29 Jan 2026 08:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769674111;
	bh=HZIWPQtHuKRBHDG4lIuIJ9k4nhNjGP3jcqbI9/NYBFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GSjxV5N8m6DyFxui8ZZdGu4+xPizuar3wU0AtGMsI1qMuSXRq0l1WC9X+Zm3hRWAb
	 uHyt5mVPJxNtLtSoi/g5xBZ+XgycQK5IV5d3TCaY/cONDpBFpi5AZyMGEDMZSMAaS7
	 PvNQ9d8qwDoZkcH6vynHxk5dHtdrfMEC/byQCk12jutLU9F/f4tGSLoCiUvVb+ZNzT
	 3plvFnws7sQ+qDOtrTZrwPZvo0lOixx671zZ3a8i3gmYGclELOt1gfZs/iCquZRctV
	 r9AB9hYU9TzKNAtgXBplJu0RrpHkoOish+Q/YVMq167JVSHF23onkBcndBpuq5xnaA
	 thMRLBM+FNnVg==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vlN4n-0000000EROD-1cdk;
	Thu, 29 Jan 2026 09:08:29 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v3 26/30] docs: kdoc_parser: use the new CFunction class
Date: Thu, 29 Jan 2026 09:08:17 +0100
Message-ID: <4ca4e256922bc42ce1c86e70c20e6a35a599fcfd.1769673038.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769673038.git.mchehab+huawei@kernel.org>
References: <cover.1769673038.git.mchehab+huawei@kernel.org>
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
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254626-lists,netdev=lfdr.de,huawei];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mchehab@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,huawei];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F18FAAD613
X-Rspamd-Action: no action

The match logic for transforms becomes a lot clearer if we use
CFunction convenient alias class instead of NestedMatch.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/lib/python/kdoc/kdoc_parser.py | 38 ++++++++++++++--------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index d2eb93f9d489..50d57c6799bb 100644
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
@@ -185,17 +185,17 @@ function_xforms = [
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


