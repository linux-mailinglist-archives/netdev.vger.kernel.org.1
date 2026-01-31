Return-Path: <netdev+bounces-255437-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCnSDfUSfml6VQIAu9opvQ
	(envelope-from <netdev+bounces-255437-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 15:34:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B9262C277D
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 15:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE2E53031F1C
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 14:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D85366DA6;
	Sat, 31 Jan 2026 14:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mElXao9y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BE6359FB8;
	Sat, 31 Jan 2026 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769869522; cv=none; b=Efownj+km/LgUsdaNtoYyHUualt/GBfekxGhlNnYC6FO2Dmv8ilFIm98iEf9oR9aZLHEVo9UPnqBareRuA34x8HsyclZHAZZNyk4gaNMUiD1ccrGWGjxUGD6ncPFMnuTKTm35h6eK3OjSvw4qMF3/DT5ZEZfhT5kneuDMIEQwEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769869522; c=relaxed/simple;
	bh=ZDgtUhg2xj+M7eiW7ljRE3PrlESL14jiN0cCN9aIl+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aunS0ROcIhAD3mznRfkBS2nIfMxNnTbXEWrRTi5twQb9D4NRyAeNOwyxZ0eeImfGzvHzigMRz/vOW+seNSwLVLEFL0e+U4IT6sknHzYdlCmzwR+ErdzwWWhgGLnwq0HHyH+u7qsc+nQdpImXaFWLBm6Ygd+hipouxgRSMb0007c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mElXao9y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19B8C4AF5F;
	Sat, 31 Jan 2026 14:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769869522;
	bh=ZDgtUhg2xj+M7eiW7ljRE3PrlESL14jiN0cCN9aIl+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mElXao9y30lRlSfpVtg3eDT9wtAXjfGnpkDTDKoe7L5Ol/J9zWWyaPRjl6FMGl/hS
	 PMRQFW2NrYPDGbhoOyZd0RnmHVSOctMhQx3ZZOn1b2OHrh0xvTYKGPq6zFsWh4q5N8
	 JxfowYerQf7tcIjQLaPz+9C+UD++YeKeBkS3mzQtBOFvIEcOolGenu/C26lSdUp/6u
	 +t0OI3hXqZzbzZXKg0QrRaUHEK34jZ+c+XoZIt+nCfuEXPj7zOz0NAuqQFFAbhOpIE
	 z9b9KaCdLxwp4sgFRd3/leU3c2swVljHE2LoKoEYmibadeYizGwhwXZNHS+ngpQJcl
	 UalErO7YsO7jA==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vmBua-0000000AVln-0hEO;
	Sat, 31 Jan 2026 15:25:20 +0100
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
	Randy Dunlap <rdunlap@infradead.org>,
	Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH v4 31/41] docs: kdoc_re: Fix NestedMatch.sub() which causes PDF builds to break
Date: Sat, 31 Jan 2026 15:25:05 +0100
Message-ID: <47bbc4753235edb31c9faec00bfa790f798a2ca0.1769867953.git.mchehab+huawei@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lists.osuosl.org,vger.kernel.org,intel.com,infradead.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-255437-lists,netdev=lfdr.de,huawei];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mchehab@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,huawei];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B9262C277D
X-Rspamd-Action: no action

Having a "\digit"  inside a docstring with normal strings causes
PDF output to break, as it will add a weird character inside the
string. It should be using a raw string instead.

Yet, having r"\0" won't solve, as this would be converted in
Sphinx as "0". So, this has to be inside a pre formatted text.

That's said, the comment itself is probably not the best one.

Rewrite the entire comment to properly document each parameter
and add a "delim" parameter that will be passed to the
ancillary function.

Reported-by: Akira Yokosawa <akiyks@gmail.com>
Closes: https://lore.kernel.org/linux-doc/63e99049-cc72-4156-83af-414fdde34312@gmail.com/
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/lib/python/kdoc/kdoc_re.py | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/tools/lib/python/kdoc/kdoc_re.py b/tools/lib/python/kdoc/kdoc_re.py
index 886e33ffd2b9..f67ebe86c458 100644
--- a/tools/lib/python/kdoc/kdoc_re.py
+++ b/tools/lib/python/kdoc/kdoc_re.py
@@ -323,19 +323,28 @@ class NestedMatch:
 
         return args
 
-    def sub(self, sub, line, count=0):
-        """
-        This is similar to re.sub:
+    def sub(self, sub, line, delim=",", count=0):
+        r"""
+        Perform a regex‑based replacement on ``line`` for all matches with
+        the ``self.regex`` pattern. It uses the following parameters:
 
-        It matches a regex that it is followed by a delimiter,
-        replacing occurrences only if all delimiters are paired.
+        ``sub``
+            Replacement string that may contain placeholders in the form
+            ``\{digit}``, where  ``digit`` is an integer referring to the regex
+            capture group number.
 
-        if r'\0' is used, it works on a similar way of using re.group(0):
-        it places the entire args of the matched paired data, with the
-        delimiter stripped.
+            ``\{0}`` is a special case that expands to the entire matched text.
 
-        If count is different than zero, it will replace at most count
-        items.
+        ``line``
+            The string to operate on.
+
+        ``delim``
+            The delimiter used by identify the placeholder groups
+            (defaults to ",").
+
+        ``count``
+            Maximum number of replacements per match.  If 0 or omitted,
+            all matches are replaced.
         """
         out = ""
 
@@ -355,7 +364,7 @@ class NestedMatch:
             # replace arguments
             new_sub = sub
             if "\\" in sub:
-                args = self._split_args(value)
+                args = self._split_args(value, delim=delim)
 
                 new_sub = re.sub(r'\\(\d+)',
                                  lambda m: args[int(m.group(1))], new_sub)
-- 
2.52.0


