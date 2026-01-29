Return-Path: <netdev+bounces-254625-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHGBJJcXe2lCBQIAu9opvQ
	(envelope-from <netdev+bounces-254625-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 09:17:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C0646AD605
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 09:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5677A3041B0F
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 08:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BF53859F2;
	Thu, 29 Jan 2026 08:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUAsCq5q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7187C37C0EB;
	Thu, 29 Jan 2026 08:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769674111; cv=none; b=TOd4AggQaMUJfoyo/8f4e8y8365XmchUXaaGEnN+IYIPLCkbAlLT1/OqE1T9PE3NI0je94cUpDzUU2/oih5g1DEAemraOPudjrMt5dLumaW+GpEQJuBUgJMYxZ2msRzRjAVyyc7kmrgLMVFc99UhuWP+mHzFdtjT3H9oVar8Xgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769674111; c=relaxed/simple;
	bh=rCmGw1Wb+1Jckq+xhR2lN4gdNL9na4qiJFEWwkWiJR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m0VNCtN6Vu0Ec/iFJkl6sMcdnqKhBzjb7OhYhB8/FKCLkb0C4BrGsg11uKvvdf1W5U8IIm+EoFELYIuJKuMSDFOVnqLdeBFNA78AXG4cKFVlH/MlH//pAqnuZqFywW32OB+rtoeGvzrtBcjMPMm2ptvXRVv03hlOg32VUk0cBtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUAsCq5q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E68C7C32781;
	Thu, 29 Jan 2026 08:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769674111;
	bh=rCmGw1Wb+1Jckq+xhR2lN4gdNL9na4qiJFEWwkWiJR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IUAsCq5qj7DiIxihFXTCS1JgP1c4yGGiUCww/qZKGIPCTSyxdMq+eAMsid9MGZ4DC
	 RpdvbLFm2ssU03DL9ukwFVfGeTabsDkCSNjPNpbvcP/CvtIihKcWgMpjzuEQywSt80
	 h3kAKbpm1rr+cRlZfuRxabolUJ12tKi6lyPNtWNSUG/FLyB4ZxIrZRZ0V6NdvZeBdU
	 08CtnRJG7Fxs6NmE4RVKOoyNhp6dY6v14omfHGlaytD1BashrOX8Z3Snr7aUgs7Rmf
	 zPjJ3h8P1OEN7y4S7XzrxynaOBumW/Rn9dEEENjcCR1R5QrzJyIiJLdF2MUVEr78LD
	 V+dmCTRqoiLDA==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vlN4n-0000000ERNh-0eOz;
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
Subject: [PATCH v3 18/30] docs: kdoc_re: Change NestedMath args replacement to \0
Date: Thu, 29 Jan 2026 09:08:09 +0100
Message-ID: <04552ce2ac1a426e74bf7353e1ba1586e2af4f36.1769673038.git.mchehab+huawei@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-254625-lists,netdev=lfdr.de,huawei];
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
X-Rspamd-Queue-Id: C0646AD605
X-Rspamd-Action: no action

Future patches will allow parsing each argument instead of the
hole set. Prepare for it by changing the replace all args from
\1 to \0.

No functional changes.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/lib/python/kdoc/kdoc_parser.py | 2 +-
 tools/lib/python/kdoc/kdoc_re.py     | 9 +++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index db140363104a..4d52a00acfad 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -160,7 +160,7 @@ struct_xforms = [
 # is allowed.
 #
 struct_nested_prefixes = [
-    (re.compile(r'\bSTRUCT_GROUP\('), r'\1'),
+    (re.compile(r'\bSTRUCT_GROUP\('), r'\0'),
 ]
 
 #
diff --git a/tools/lib/python/kdoc/kdoc_re.py b/tools/lib/python/kdoc/kdoc_re.py
index 7b7ddc50ac36..8933e1a62776 100644
--- a/tools/lib/python/kdoc/kdoc_re.py
+++ b/tools/lib/python/kdoc/kdoc_re.py
@@ -289,8 +289,9 @@ class NestedMatch:
         It matches a regex that it is followed by a delimiter,
         replacing occurrences only if all delimiters are paired.
 
-        if r'\1' is used, it works just like re: it places there the
-        matched paired data with the delimiter stripped.
+        if r'\0' is used, it works on a similar way of using re.group(0):
+        it places the entire args of the matched paired data, with the
+        delimiter stripped.
 
         If count is different than zero, it will replace at most count
         items.
@@ -306,9 +307,9 @@ class NestedMatch:
             # Value, ignoring start/end delimiters
             value = line[end:pos - 1]
 
-            # replaces \1 at the sub string, if \1 is used there
+            # replaces \0 at the sub string, if \0 is used there
             new_sub = sub
-            new_sub = new_sub.replace(r'\1', value)
+            new_sub = new_sub.replace(r'\0', value)
 
             out += new_sub
 
-- 
2.52.0


