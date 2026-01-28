Return-Path: <netdev+bounces-254348-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHs9HztEemn34wEAu9opvQ
	(envelope-from <netdev+bounces-254348-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 18:15:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2924AA6A90
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 18:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32536306898B
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 16:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEA93191C9;
	Wed, 28 Jan 2026 16:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjfXEptm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F6030BF4F;
	Wed, 28 Jan 2026 16:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769619031; cv=none; b=IVI42wVNz9uq89QSE/oB9WqKJ3F+4zMPjNkiKZtJ7ZX1ABaotZ+E1EUBB3qCDT1zzwB3MZMmA1pGf1mPGioBTFws7XIHbzBbiGJLn4C9/fuec/8TxYAaX5vFx8ESfeIXERg8qirwBvxNgXcCE7mXLGcb6qx+zdo0o6Y3r7Dg0V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769619031; c=relaxed/simple;
	bh=1OHigLaB0I9Gr4pd6M4Zc3FWOaEqquAXFRRO/Gxw3CM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NOMki0x03rCpl/PMz7iaMApdLBt5k5N6uCu8Wncl02TO5Uw0iuiAArGfynuERVWBBJVNMzg+XGs3SwIhclhSMggbN/0rA8rDxXWveK/s56bZraGVAL+0iNT2reY/CYvoBD49uoJNlXRyVOyE0xNGhKKVRYi0hJ3r9MYo4KOUIGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TjfXEptm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA2BC2BC86;
	Wed, 28 Jan 2026 16:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769619031;
	bh=1OHigLaB0I9Gr4pd6M4Zc3FWOaEqquAXFRRO/Gxw3CM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TjfXEptm0ADY3ifgqaYHKezKdvmZ0vdiu4HJLMBS7TERWWChwTE1Xzyeiuawdcaau
	 7989W1/+LpY6k5kTjByO0/pedG+2Fau/rP7VQrEFfnNa21MOP98mp6x+tpR/0t8g1F
	 ZZUyM2fgjTeBFBBGeu53u1D/WrM7HHTeTKuNF32yRhacr0ydl40FC6ViV+OKZfx9Cp
	 cVe49eQdgNKHSOAJr+sb8eo5n6T5Le49xwuw8FTQrCTdAbEUDlwa9IwlwPQZLTaOdC
	 zEw58RSxgeWu+Nrfi6iiYe0ALr0VH7//l/jWCLXmAZRGQXl/rrV9BkB0gorneZ3QFh
	 fMboor8w+ReGw==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vl8kP-0000000DAn7-2H9M;
	Wed, 28 Jan 2026 17:50:29 +0100
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
Subject: [PATCH v2 03/25] docs: kdoc_parser: move var transformers to the beginning
Date: Wed, 28 Jan 2026 17:50:01 +0100
Message-ID: <ee823af3eebc4ece0278c9859f4d109dd0de54ab.1769617841.git.mchehab+huawei@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254348-lists,netdev=lfdr.de,huawei];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mchehab@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,huawei];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:email]
X-Rspamd-Queue-Id: 2924AA6A90
X-Rspamd-Action: no action

Just like functions and structs had their transform variables
placed at the beginning, move variable transforms to there
as well.

No functional changes.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
---
 tools/lib/python/kdoc/kdoc_parser.py | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index fd57944ae907..0b68b140cd02 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -191,6 +191,18 @@ function_xforms  = [
     (KernRe(r"__attribute__\s*\(\((?:[\w\s]+(?:\([^)]*\))?\s*,?)+\)\)\s+"), ""),
 ]
 
+#
+# Transforms for variable prototypes
+#
+var_xforms = [
+    (KernRe(r"__read_mostly"), ""),
+    (KernRe(r"__ro_after_init"), ""),
+    (KernRe(r"(?://.*)$"), ""),
+    (KernRe(r"(?:/\*.*\*/)"), ""),
+    (KernRe(r";$"), ""),
+    (KernRe(r"=.*"), ""),
+]
+
 #
 # Ancillary functions
 #
@@ -971,15 +983,6 @@ class KernelDoc:
         ]
         OPTIONAL_VAR_ATTR = "^(?:" + "|".join(VAR_ATTRIBS) + ")?"
 
-        sub_prefixes = [
-            (KernRe(r"__read_mostly"), ""),
-            (KernRe(r"__ro_after_init"), ""),
-            (KernRe(r"(?://.*)$"), ""),
-            (KernRe(r"(?:/\*.*\*/)"), ""),
-            (KernRe(r";$"), ""),
-            (KernRe(r"=.*"), ""),
-        ]
-
         #
         # Store the full prototype before modifying it
         #
@@ -1003,7 +1006,7 @@ class KernelDoc:
         # Drop comments and macros to have a pure C prototype
         #
         if not declaration_name:
-            for r, sub in sub_prefixes:
+            for r, sub in var_xforms:
                 proto = r.sub(sub, proto)
 
         proto = proto.rstrip()
-- 
2.52.0


