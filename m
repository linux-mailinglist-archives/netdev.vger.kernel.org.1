Return-Path: <netdev+bounces-255406-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIENINkQfmkbVQIAu9opvQ
	(envelope-from <netdev+bounces-255406-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 15:25:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C58FC23CF
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 15:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E98B63003D2C
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 14:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B9C357A37;
	Sat, 31 Jan 2026 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6u5o/al"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7014354ACE;
	Sat, 31 Jan 2026 14:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769869521; cv=none; b=Lk4uuYVRkEeWi9vjM4viKrRgmIANj3DoDkFMcsBYs5Ltjg1B4evuoHTANOY1NsRKcHqA46Pi5Yxg/GodJc1xzJM0+Y4vq4eHSNs2sqW1ZLf7uC1uD4dx1v2qFm2l9T18Xj4eW3t1nrYq/qUeSKEe3Cs1ptgkVyCV3d2hXG2tUFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769869521; c=relaxed/simple;
	bh=a6lkkyCGl+XetcnP8/XAHQbs/mIXiTfJmq3uiOJoYsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vh0TT3K/Dfsu1UiSfHmkThKNo/Ho2vOowcaVoDT+9356GDVaNapqDCz/8WYsjSJbiqUqHfu3z01LWXS6E52e/9bEgX2bWrKXuw+I0tg6mgVrI72wXXemKaH8X39af8CZ6CCuyTGljJL5g3GVn/G35z55Dr0DBWu6rjwJrH+L6Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6u5o/al; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F0EC19425;
	Sat, 31 Jan 2026 14:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769869521;
	bh=a6lkkyCGl+XetcnP8/XAHQbs/mIXiTfJmq3uiOJoYsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B6u5o/alVJagTQ7ZiNo2WcIAEFBEGkXfokP+2uYASByjtfTxwyk4pFLgDCtEPwoHr
	 PxMm7Obl/uy0ipJ7M6zAVf/yoPOKjLXRsk1gnyUlJufdMYVq0bZ4fVqsDthHPI/hmI
	 uN0Bo89oKezlv53rTBHOcm3k+gPbNcXVmoOiPZX7v79oPVd1M2rEt3CJEYTYuuS0lB
	 mg15INJEDvO4ZYZksPOARNdQ0Vqx73OD9BYq2szwL54HODmw6BpQP0GrlhkrZ0D5yM
	 A4/IiKDCshiFpZO1MxXrSnvXIav2dhiKhO2zvtV3ByZzOBXWbrH9o1YCqJh2j9IHUA
	 V/BF+NoiyZC/Q==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vmBuZ-0000000AVjw-1c9g;
	Sat, 31 Jan 2026 15:25:19 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v4 03/41] docs: kdoc_parser: move var transformers to the beginning
Date: Sat, 31 Jan 2026 15:24:37 +0100
Message-ID: <f35657cd289db4dd5868f879bbd889bb24c150f6.1769867953.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769867953.git.mchehab+huawei@kernel.org>
References: <cover.1769867953.git.mchehab+huawei@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255406-lists,netdev=lfdr.de,huawei];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mchehab@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,huawei];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6C58FC23CF
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


