Return-Path: <netdev+bounces-259290-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKSMCdWSlWn1SQIAu9opvQ
	(envelope-from <netdev+bounces-259290-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 11:22:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB4B155550
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 11:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E834A303B194
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 10:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E3D3590A4;
	Wed, 18 Feb 2026 10:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jab6p8eK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A653587B0;
	Wed, 18 Feb 2026 10:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771409615; cv=none; b=GBgDQbZPSuMd+PyPNJxH9tuLcgY0WNB7n6D+G5KrbeGqyzjGRvH/+fdrXG++gs+hiuByY7OPogJ6HPiGyuFu5MZ6F8UMQfbsUiq/I84cNg8PVmts1Y8vwCMWrto7IOkfHS4wtj3LQPOuoZCwIrIUMSHyaj0MM3X3b7hhCeWl3Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771409615; c=relaxed/simple;
	bh=xc3bdeTKA4gaQTm1QPUjzckBF1/Bc6XutKPIezxeXB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uvZvpp0iesc7hH63ELS2hcFAER9nSZoOwoTc5RGW8HwPmpq6HCl/DNzP4glWkD70k7idiunlm0cAdJYAhvxmrpgSP8KdWaJKofDdjDC/1hUio7Eh07MF2ejMSx3jG2x2Y8Rb2HwTdVBcZRQLyMm8DWSNPQbUISIGhsknWLOYOPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jab6p8eK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B929C2BC86;
	Wed, 18 Feb 2026 10:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771409612;
	bh=xc3bdeTKA4gaQTm1QPUjzckBF1/Bc6XutKPIezxeXB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jab6p8eK+HQmF5tjAbh1RwIRwC3EdK+p02whFrMgbAKP5lSvhER9feNwMXqDPhc64
	 5X/4X/2/pOuXsOEBQOFIsKPAWmqp4gzDoGrw/PO9uw40FhAnPGF+VPeeKS3BTzLXAN
	 pYvBkQSIcAuYbQGeyADrf27SKdnKYZTlNDdQNMgSHggfqjf856QeIpSSyjq2QcU+yu
	 GhayWNugcI4K+ZCL9cpld4j91yvFK4FdZBuGZQLYW6AifoGFcp1256O6OeeenYWM1C
	 DXwKXObNYv3LLa6/PkV+FB9mmUazt1sW2jhvDvyhKsfmG8Q4bNGTL4bAf77fgQJ6d+
	 vTWUOohGPS+Dw==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vseYk-00000000M1F-2cOl;
	Wed, 18 Feb 2026 11:13:30 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH 35/38] docs: kdoc_output: use a more standard order for .TH on man pages
Date: Wed, 18 Feb 2026 11:13:05 +0100
Message-ID: <eb899b9ae899ba044031d551860a9c970ea2b5b4.1771408406.git.mchehab+huawei@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259290-lists,netdev=lfdr.de,huawei];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mchehab@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,huawei];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,self.data:url,self.date:url]
X-Rspamd-Queue-Id: 0BB4B155550
X-Rspamd-Action: no action

The generated man pages are not following the current standards
for Linux documentation. Reorder .TH fields for them to look
like other Linux man pages.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/docs/sphinx-build-wrapper      | 2 +-
 tools/lib/python/kdoc/kdoc_output.py | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/docs/sphinx-build-wrapper b/tools/docs/sphinx-build-wrapper
index e6418e22e2ff..ac6852e3dd8c 100755
--- a/tools/docs/sphinx-build-wrapper
+++ b/tools/docs/sphinx-build-wrapper
@@ -625,7 +625,7 @@ class SphinxBuilder:
 
                 # Use shlex here, as it handles well parameters with commas
                 args = shlex.split(line)
-                fname = f"{output_dir}/{args[3]}.{args[2]}"
+                fname = f"{output_dir}/{args[1]}.{args[2]}"
 
                 if self.verbose:
                     print(f"Creating {fname}")
diff --git a/tools/lib/python/kdoc/kdoc_output.py b/tools/lib/python/kdoc/kdoc_output.py
index fe3fc0dfd02b..fb44cc8e0770 100644
--- a/tools/lib/python/kdoc/kdoc_output.py
+++ b/tools/lib/python/kdoc/kdoc_output.py
@@ -611,8 +611,8 @@ class ManFormat(OutputFormat):
         """Emit a title header line."""
         name = name.strip()
 
-        self.data += f'.TH "{self.modulename}" {self.section} "{name}" '
-        self.data += f' "{self.date}" "{self.manual}"\n'
+        self.data += f'.TH "{name}" {self.section} "{self.date}" '
+        self.data += f' "{self.modulename}" "{self.manual}"\n'
 
     def __init__(self, modulename, section="9", manual="Kernel API Manual"):
         """
-- 
2.52.0


