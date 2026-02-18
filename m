Return-Path: <netdev+bounces-259276-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHA2Jh+TlWn1SQIAu9opvQ
	(envelope-from <netdev+bounces-259276-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 11:23:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C3106155593
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 11:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 423B9301072F
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 10:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3285534B682;
	Wed, 18 Feb 2026 10:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJgsNj1I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085C334B1B0;
	Wed, 18 Feb 2026 10:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771409607; cv=none; b=q5w05Sqp7XeB9O7g+WEhSieWMN/Hv16Y6FZp+Zjtos85R1VKtPEYi6+3Ka4MUMQXbmld6m06e8oXuXwxLgb3yGp/tVBAulthsxZyB8NWww2+ziBUS+/dHEFtNe9RgJtjHjIzeQp90u2AE6wJci+6D7p28TbJsChhdJqXGmTTk5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771409607; c=relaxed/simple;
	bh=86xDsz00XoZv72qsVxrMGG+DckqmwvjpK6jYFBlRKlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YmKURQRFtN4FSMvSRxb7X+EX8rHmQq9wMOHgxrsSO0KpGL2BLsQ8cXGpseGB4Zug+UdhyjXLX502eudD+9j2B97K9ey3IK5/mKzT0cnF18p92gUoSZMzhopXcXD53y0EzKVHG8bdsOV0TZeowq/B2C0kx6xtCoqUjTDTjXKs76s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJgsNj1I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFFA8C19421;
	Wed, 18 Feb 2026 10:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771409606;
	bh=86xDsz00XoZv72qsVxrMGG+DckqmwvjpK6jYFBlRKlc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iJgsNj1ILFH/W404vgqOOGidsNLkMe7JdUEX16v4Uau/P2nB9asfrZh/MsBF6mG1p
	 +dXmaF+m95974ysB4gS0Hdt73+2d0dETu3C4BvovzUrKcfvucv2NqxnM0kbuNcv1g+
	 yT/AEh39PjncL/tuEIYKGo6UfJVkKSh/W04IAWASLWUxWHrSokyUNVLThZiCIwgSNP
	 X9tTUZq41lIw4eb4XKnGUr+/yWpCMbdQEU2VHjZh3G+tRj4bD+P1j/DRuPgijn6vW8
	 wczH34zjTznei9NFRqdXI6agVnpnSHAK5GvxBwwPB9G3X5Msy+nfKKFHtdlRFHwpo0
	 YlzAUxHzoIZAw==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vseYf-00000000Llw-00lq;
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
Subject: [PATCH 23/38] docs: kdoc_re: add a helper class to declare C function matches
Date: Wed, 18 Feb 2026 11:12:53 +0100
Message-ID: <a20aa001f4a0c8051f2d004aa21ca73d1db14613.1771408406.git.mchehab+huawei@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-259276-lists,netdev=lfdr.de,huawei];
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
X-Rspamd-Queue-Id: C3106155593
X-Rspamd-Action: no action

Add a more convenient class to match C functions and avoiding
issues at the beginning and ending of NestedMatch inits.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 tools/lib/python/kdoc/kdoc_re.py | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/lib/python/kdoc/kdoc_re.py b/tools/lib/python/kdoc/kdoc_re.py
index cdc842f5fc8f..f72b80ea4f1b 100644
--- a/tools/lib/python/kdoc/kdoc_re.py
+++ b/tools/lib/python/kdoc/kdoc_re.py
@@ -383,3 +383,14 @@ class NestedMatch:
         """
 
         return f'NestedMatch("{self.regex.regex.pattern}")'
+
+
+class CFunction(NestedMatch):
+    r"""
+    Variant of NestedMatch.
+
+    It overrides the init method to ensure that the regular expression will
+    start with a ``\b`` and end with a C function delimiter (open parenthesis).
+    """
+    def __init__(self, regex):
+        self.regex = KernRe(r"\b" + regex + r"\s*\(")
-- 
2.52.0


