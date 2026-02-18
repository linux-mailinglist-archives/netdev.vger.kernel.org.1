Return-Path: <netdev+bounces-259269-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAi2AemTlWn1SQIAu9opvQ
	(envelope-from <netdev+bounces-259269-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 11:26:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7814B155669
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 11:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D536304D25B
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 10:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E52F346A0C;
	Wed, 18 Feb 2026 10:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AjCHRstY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBE233E35C;
	Wed, 18 Feb 2026 10:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771409603; cv=none; b=PLZfnINWIBnrvTop/Tm1BwqdMKTn0Gl0oQo7pVybJQdMhl/FFSJD+r9zJSrdEaFejYscxoh011ZsX9LeonrBaLCnvYKIKZqa6a+F4ieX3ftHuqsA9IbBY6rdFOwEQAfTMs8FjTL/pTMHVibmOg5gjQaawhgXOV7AJ6C+syshFfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771409603; c=relaxed/simple;
	bh=KU0YswEvwG2VkW3AG45CjZ2okRV/mwbS3lMGf4DpG8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lbM5OTS/e1P+ImQ/MVdpMxsO1QOGbXz12sB+5uDfQbkw7QmqNG8f0vu/o1x7krSaBeK383O/DRW+Vo/ks0Q2YyVekanUQMt84j99hvYUKsU4TUiAMy5fhfIxqfM5fyQKchshNTk4q2PZBMaRxwG7Vh1NdZjTv/AYBR5ro4U4vvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AjCHRstY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB684C2BC86;
	Wed, 18 Feb 2026 10:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771409603;
	bh=KU0YswEvwG2VkW3AG45CjZ2okRV/mwbS3lMGf4DpG8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AjCHRstYcLRm3u4c4fawaisKaLhZHmBhWg1udI9djeLJzP+35BeRm04ViNsvVOyD0
	 70qhKifzCF6HrgWSr4hOtipPfZCZaNRUU7aqN1IncQgLe+2n/Tw3X+SD3urp81/ePC
	 YPgVS8R1DVFQh3bvniBmgDDJhr3Nvw/IWOgTEbgf1vRfmgd3c20bSQej5CgOJVUU2e
	 iQF4d1sN+7KFL3RjyHWrn6Xx3QxAJkvJOGhHnG6vTd0kgQZFpB0CRavnDHQOy6PVtm
	 zCfrnRzDgiIQRXoZeRCysOMYeNVQPwGsZ7pMzX/mRSvdXRUcUo11ZVxiWa+FtsfkAl
	 z3Iqswua2f2vA==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vseYb-00000000LdF-46Fo;
	Wed, 18 Feb 2026 11:13:21 +0100
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
Subject: [PATCH 16/38] docs: kdoc_re: better show KernRe() at documentation
Date: Wed, 18 Feb 2026 11:12:46 +0100
Message-ID: <497fbbcd66ab400c323c8840f917a8552fa801f3.1771408406.git.mchehab+huawei@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-259269-lists,netdev=lfdr.de,huawei];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7814B155669
X-Rspamd-Action: no action

the __repr__() function is used by autodoc to document macro
initialization.

Add a better representation for them.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 tools/lib/python/kdoc/kdoc_re.py | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/tools/lib/python/kdoc/kdoc_re.py b/tools/lib/python/kdoc/kdoc_re.py
index 420cb8879ba3..0a7f12616f9f 100644
--- a/tools/lib/python/kdoc/kdoc_re.py
+++ b/tools/lib/python/kdoc/kdoc_re.py
@@ -52,7 +52,28 @@ class KernRe:
         return self.regex.pattern
 
     def __repr__(self):
-        return f're.compile("{self.regex.pattern}")'
+        """
+        Returns a displayable version of the class init.
+        """
+
+        flag_map = {
+            re.IGNORECASE: "re.I",
+            re.MULTILINE: "re.M",
+            re.DOTALL: "re.S",
+            re.VERBOSE: "re.X",
+        }
+
+        flags = []
+        for flag, name in flag_map.items():
+            if self.regex.flags & flag:
+                flags.append(name)
+
+        flags_name = " | ".join(flags)
+
+        if flags_name:
+            return f'KernRe("{self.regex.pattern}", {flags_name})'
+        else:
+            return f'KernRe("{self.regex.pattern}")'
 
     def __add__(self, other):
         """
-- 
2.52.0


