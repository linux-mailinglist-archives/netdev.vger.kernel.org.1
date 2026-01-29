Return-Path: <netdev+bounces-254611-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDyPBNMWe2kZBQIAu9opvQ
	(envelope-from <netdev+bounces-254611-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 09:14:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA6FAD549
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 09:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A8ACC308BBE1
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 08:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052F037FF5D;
	Thu, 29 Jan 2026 08:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUNW7Yi6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2539C37BE6D;
	Thu, 29 Jan 2026 08:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769674111; cv=none; b=iU9E+wpAa2TM7f7uR8ViGpB1IeoOx8Ehj63KdthEIg8ppPGTPm5alnLXZigxzVU89HBEW2LdbIXv4YjGmEjoTAS5y2I4oRpN+U/akT336I/3LIMJyp2sp6cuH9VLLeekHLEWWtOuBzWPGxfP97YEcvhoTEHuAdgP4OXn3LpaSNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769674111; c=relaxed/simple;
	bh=cuKy1d1D0xiQwJcdcAdfKB7F5IpylCi/Hc8WUScKfcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rz7E7w3I+xIcGCRrTLINDsSpOMuif/vpxtsdKj7YCVWRjTZseGGh54/QTmgMCbl3GKg/6PoKSaXUD8FBBkjSqdlyGCE4YXrkNnq8MHDd0n8xSsf+aAVnKwbay6kPc1MPqq4DRZIVoqPA5+s8RJ2K1RUV0FOr0qcZm4JbufV1LQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUNW7Yi6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC83C2BC86;
	Thu, 29 Jan 2026 08:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769674110;
	bh=cuKy1d1D0xiQwJcdcAdfKB7F5IpylCi/Hc8WUScKfcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eUNW7Yi6qDRcBxZQKGIHv++h7jftY5Lx/5e9cAaUluz/uZ8XGowG9rSE6Mepe+JDU
	 erKZXjV6Tutztg/t4R5NmsUHiB6lJ299VMSnJyG6bbvCRPbU1dEp2GWiZj4n4O6Y7M
	 /Zble7cP/kNtngyHwf4ElaBiFdmdGNmQuxuiNtx+dql6V8/rz8yvHjmDxhWyz3O9+d
	 YtVzOetnKAyoaF9yDiesoRwnu1VthNIm1USEZ2KAEr7ZwP+yoZjKCIyQUxHP2ptd37
	 M85qR2ZpPvcsi8MQpuYc3eoV2ackZb4iycU2i4x4bL4/p/Is74sWcGoVOQmUOokcBf
	 NUdW53gSasH3w==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vlN4m-0000000ERMn-3AIc;
	Thu, 29 Jan 2026 09:08:28 +0100
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
Subject: [PATCH v3 04/30] docs: kdoc_parser: don't mangle with function defines
Date: Thu, 29 Jan 2026 09:07:55 +0100
Message-ID: <33b532261e00197d24d581be48db37a229b018fa.1769673038.git.mchehab+huawei@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254611-lists,netdev=lfdr.de,huawei];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:email]
X-Rspamd-Queue-Id: BCA6FAD549
X-Rspamd-Action: no action

Mangling with #defines is not nice, as we may end removing
the macro names, preventing several macros from being properly
documented.

Also, on defines, we have something like:

	#define foo(a1, a2, a3, ...)			 \
		/* some real implementation */

The prototype part (first line on this example) won't contain
any macros, so no need to apply any regexes on it.

With that, move the apply_transforms() logic to ensure that
it will be called only on functions.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
---
 tools/lib/python/kdoc/kdoc_parser.py | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index 0b68b140cd02..3ba2cda2487a 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -163,7 +163,7 @@ struct_nested_prefixes = [
 #
 # Transforms for function prototypes
 #
-function_xforms  = [
+function_xforms = [
     (KernRe(r"^static +"), ""),
     (KernRe(r"^extern +"), ""),
     (KernRe(r"^asmlinkage +"), ""),
@@ -1065,10 +1065,7 @@ class KernelDoc:
         found = func_macro = False
         return_type = ''
         decl_type = 'function'
-        #
-        # Apply the initial transformations.
-        #
-        prototype = apply_transforms(function_xforms, prototype)
+
         #
         # If we have a macro, remove the "#define" at the front.
         #
@@ -1087,6 +1084,11 @@ class KernelDoc:
                 declaration_name = r.group(1)
                 func_macro = True
                 found = True
+        else:
+            #
+            # Apply the initial transformations.
+            #
+            prototype = apply_transforms(function_xforms, prototype)
 
         # Yes, this truly is vile.  We are looking for:
         # 1. Return type (may be nothing if we're looking at a macro)
-- 
2.52.0


