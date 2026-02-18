Return-Path: <netdev+bounces-259289-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CP7cHAGWlWk1SgIAu9opvQ
	(envelope-from <netdev+bounces-259289-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 11:35:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E12AF155849
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 11:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CCD563052BC9
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 10:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E85D3590D3;
	Wed, 18 Feb 2026 10:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6zqkt/3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019A33587A9;
	Wed, 18 Feb 2026 10:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771409615; cv=none; b=DIKXpX0Gtcq5SNvPakPR6vyfcvhci2X2ASjFmYTOa5MIBTrZ2nzA++jTwcR21wimk6SE9KpSlSNy+aNiDEmSjxpVRUI1aX08JyskSfduL+clkkkIe1LVY5cZv39gTMuBsfBUH3FN1K5spWmtiMS14yrKbaJIGYPYIE3G/aFX4pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771409615; c=relaxed/simple;
	bh=93FI6HCbFuKLoTGysvIesP/671jVJYX05qdlxtKR9Kk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I6gkn67e6PwvL3n6c2Hfda+AnQOK8yqxVJTKbjlprcmjl1Y5edSIX2Cm6iCeiYhNNJPXo4ZK/Gjz2fzMZvgmKDDrtxU2PtpMx50Izm0ybIRlnV3oNDOV+fq9Zh3bCvFLlpIdFxtcUVuVqjm5plSsx1M5s8/raEmT794ZjyhzHmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6zqkt/3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B82C19421;
	Wed, 18 Feb 2026 10:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771409611;
	bh=93FI6HCbFuKLoTGysvIesP/671jVJYX05qdlxtKR9Kk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D6zqkt/3NUB6EpxHEputgfvaw1vHtc0NsZ65QNN3AAKsJuHWSBcq82NKFzJu8llkR
	 S+1bk/UPxulyqkqcMbYtUMX/IIRr09HFtRuwNOA1NPlhPHsSPUiXhECDzbmymTKCPU
	 JmPJyAld8CPADXng3h49bxxTnDEx8O6tZ/7uUMOx2P8DlevrZHSEFbuD7SA01tAoZe
	 Wy2GDlPrU1hQLkRN135ojO5oHWcW9ckY5i4kcvDUXG5i7xXrBHkp+i3T/cZga64Syq
	 yIzxySQ3SnLG+PqvN40MnLlrYGZ278mb8gxtsx2bB1lNqpGUgxCJ6tFZMhIOwetkTl
	 /MxbF5cjFyQRg==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vseYj-00000000Lxe-1kJB;
	Wed, 18 Feb 2026 11:13:29 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 32/38] docs: kdoc_files: document KernelFiles() ABI
Date: Wed, 18 Feb 2026 11:13:02 +0100
Message-ID: <ca064642fd70b1dd2fa2c72a119a3a579ef0a3c2.1771408406.git.mchehab+huawei@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259289-lists,netdev=lfdr.de,huawei];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mchehab@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,huawei];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E12AF155849
X-Rspamd-Action: no action

The KernelFiles is the main entry point to run kernel-doc,
being used by both tools/docs/kernel-doc and
Documentation/sphinx/kerneldoc.py.

It is also used on QEMU, which also uses the kernel-doc
libraries from tools/lib/python/kdoc.

Properly describe its ABI contract.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/lib/python/kdoc/kdoc_files.py | 44 ++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/tools/lib/python/kdoc/kdoc_files.py b/tools/lib/python/kdoc/kdoc_files.py
index c35e033cf123..8c2059623949 100644
--- a/tools/lib/python/kdoc/kdoc_files.py
+++ b/tools/lib/python/kdoc/kdoc_files.py
@@ -91,7 +91,49 @@ class KernelFiles():
     """
     Parse kernel-doc tags on multiple kernel source files.
 
-    There are two type of parsers defined here:
+    This is the main entry point to run kernel-doc. This class is initialized
+    using a series of optional arguments:
+
+    ``verbose``
+        If True, enables kernel-doc verbosity. Default: False.
+
+    ``out_style``
+        Class to be used to format output. If None (default),
+        only report errors.
+
+    ``xforms``
+        Transforms to be applied to C prototypes and data structs.
+        If not specified, defaults to xforms = CFunction()
+
+    ``werror``
+        If True, treat warnings as errors, retuning an error code on warnings.
+
+        Default: False.
+
+    ``wreturn``
+        If True, warns about the lack of a return markup on functions.
+
+        Default: False.
+    ``wshort_desc``
+        If True, warns if initial short description is missing.
+
+        Default: False.
+
+    ``wcontents_before_sections``
+        If True, warn if there are contents before sections (deprecated).
+        This option is kept just for backward-compatibility, but it does
+        nothing, neither here nor at the original Perl script.
+
+        Default: False.
+
+    ``logger``
+        Optional logger class instance.
+
+        If not specified, defaults to use: ``logging.getLogger("kernel-doc")``
+
+    Note:
+        There are two type of parsers defined here:
+
         - self.parse_file(): parses both kernel-doc markups and
           ``EXPORT_SYMBOL*`` macros;
         - self.process_export_file(): parses only ``EXPORT_SYMBOL*`` macros.
-- 
2.52.0


