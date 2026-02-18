Return-Path: <netdev+bounces-259256-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HwsNfmQlWn1SQIAu9opvQ
	(envelope-from <netdev+bounces-259256-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 11:14:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 823AC155360
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 11:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CA07303CC37
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 10:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CFA33E369;
	Wed, 18 Feb 2026 10:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="htrE8c65"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E290233E352;
	Wed, 18 Feb 2026 10:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771409599; cv=none; b=WcJADPfqUEu2JUypT7FQ9O9vKGHKdJenPIz8w9CAWecOEpml9IacIrayLD9+B8bUNEu2UjyJ6z2CJfsIhlIcR5c3z32SsxYJkBo9IcRqVSPuqueOaCGQaf6XzGM7gJXzWy+ZerCtKUpGB0HHNyyC6upNDA1zW637Iwzq0rawiZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771409599; c=relaxed/simple;
	bh=ftCwoMytpLULQWEXGblskf53KEc3VuT0xZwVGahX9Ic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EOM0qPmGyIOToa+PheOx9ygwAYAiBLy2GrQIAms9Fo4VH1PaP9lBFB3+uALjaoxjiYiu7tkh6nf1OlkcVfeJxKAEQshLVPO7WdYRlfOTkBpxh50MeWs3iOgxSg16BJ1Y+KkfCqgY4TpUKS1zhvm7B+OxRohOaZv8p1Yj2HOaYpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=htrE8c65; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3BADC19423;
	Wed, 18 Feb 2026 10:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771409598;
	bh=ftCwoMytpLULQWEXGblskf53KEc3VuT0xZwVGahX9Ic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=htrE8c65anRRdCdgeXC+2Nbg4/ppJ2ESBk6Jall7k/31EPTkYE2jsmZOkuMfS2f4z
	 lBFZfKFDKoF+Yqf/85WHAeeJ03wqcoIjc9A4pqR4zU1GSmMEHpAAXxw4RY0i1mzWMH
	 +Y8yKyZBC3ufsnEpSDq/1q9mZSIotnQ+fpO7j1KOY5Niw/Oxxapcq5CKa1A1ERcUch
	 Nbjua0ThtkFERx5aSDmqY9rZSL2PCavnNs4iQMRhyssRwl1tWaihKZ7e7EiBnRgt6q
	 cEI0Kpa04uQF7QY63Udc/i241ILXUXnTIYlVhz3PZmzgxO5wtpnJ1nAVlwp9fRtL36
	 iu1LUzH9VR04g==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vseYW-00000000LNN-3rfW;
	Wed, 18 Feb 2026 11:13:16 +0100
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
Subject: [PATCH 03/38] docs: kdoc_parser: move var transformers to the beginning
Date: Wed, 18 Feb 2026 11:12:33 +0100
Message-ID: <117d010f42434c437284e37cb78a4590b84eb1c6.1771408406.git.mchehab+huawei@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259256-lists,netdev=lfdr.de,huawei];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mchehab@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,huawei];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,infradead.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 823AC155360
X-Rspamd-Action: no action

Just like functions and structs had their transform variables
placed at the beginning, move variable transforms to there
as well.

No functional changes.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 tools/lib/python/kdoc/kdoc_parser.py | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index ca00695b47b3..68a5aea9175d 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -192,6 +192,18 @@ function_xforms  = [
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
@@ -972,15 +984,6 @@ class KernelDoc:
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
@@ -1004,7 +1007,7 @@ class KernelDoc:
         # Drop comments and macros to have a pure C prototype
         #
         if not declaration_name:
-            for r, sub in sub_prefixes:
+            for r, sub in var_xforms:
                 proto = r.sub(sub, proto)
 
         proto = proto.rstrip()
-- 
2.52.0


