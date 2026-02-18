Return-Path: <netdev+bounces-259281-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0A/gEvGTlWn1SQIAu9opvQ
	(envelope-from <netdev+bounces-259281-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 11:26:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A014155682
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 11:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 557CF303B14A
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 10:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B67334E754;
	Wed, 18 Feb 2026 10:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYJ1wD6t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A8333F395;
	Wed, 18 Feb 2026 10:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771409609; cv=none; b=iE/OHayV76cyXuUKaDFjarPZbyBB8gi16A+42M1cWAwhO8nbuqJ0YI0xbgJg+c59nRo5wRjPoKEj7nZd0rmVZqpI+a6nhV7c1NIEmjUt94bxwFbZYbOulO9xXb2e/6ei8QTJJHeZUvmZ2rNULxC299/1JcPo7gLC2U0qLUKBjTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771409609; c=relaxed/simple;
	bh=yQBydwNaRIYMlzU4Ubfa3gdUJcPIj4ppbNTFE+NM7Rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tqLA3auLJr8k9jxDJrL0NMybMItxBnRRnbFOSxHJj/XOl31TVK5PJ70zpj/WfM9s/57qFLUaN+7JZjyn86/9GH6JlBP8o7NyGkbZnHYnicIBPIsyckyNpAMxlOKs5br+tPuDQJGzuolj62S/kD/cylnePRXhSC+xlgz3rY4wCDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nYJ1wD6t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39346C19421;
	Wed, 18 Feb 2026 10:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771409609;
	bh=yQBydwNaRIYMlzU4Ubfa3gdUJcPIj4ppbNTFE+NM7Rg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nYJ1wD6tseePJcKQKbRGVSxpEMfowqnIii6b7lTyIP7X3gOW6ouyFqT1d4g2obgZv
	 D9EJKHEKg0KjkEPQgzNK+VHrRWm1pRD14A1yuHHb7FuejYCUasnbNPvJg74BF6NDt0
	 dXFEtVaASa+GJ4ENq4tXcaAyeo4B/TGRDlH0lzvWf7fHgdZTwX99oitgxNz0WSoSKT
	 NUliYg2dFgzC/x+JPjBH55K/Th7gDFo71E9xxwtZAMfhu/xxLE7yCMJ4ZBrOSiCVQG
	 rDvH/6/76wu+waqE+8vV+xRu/447e+OIlRnu3w7/+UPaTT1Js5edtbT/Qx8ik1sIoI
	 67z4X3b9j1WXQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vseYh-00000000LsZ-1yLx;
	Wed, 18 Feb 2026 11:13:27 +0100
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
Subject: [PATCH 28/38] docs: kdoc_re: prevent adding whitespaces on sub replacements
Date: Wed, 18 Feb 2026 11:12:58 +0100
Message-ID: <24cce8e6d41b2f16698ac9f683b3f1df125e306e.1771408406.git.mchehab+huawei@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-259281-lists,netdev=lfdr.de,huawei];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mchehab@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,huawei];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7A014155682
X-Rspamd-Action: no action

When NestedMatch is used, blank whitespaces may be placed after
substitutions. As such spaces are part of the C syntax, we can
safelly drop them, improving the quality of the output.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/lib/python/kdoc/kdoc_re.py | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/lib/python/kdoc/kdoc_re.py b/tools/lib/python/kdoc/kdoc_re.py
index e3809aaa0310..44af43aa1e93 100644
--- a/tools/lib/python/kdoc/kdoc_re.py
+++ b/tools/lib/python/kdoc/kdoc_re.py
@@ -344,8 +344,12 @@ class NestedMatch:
 
         cur_pos = 0
         n = 0
+        l = len(line)
 
         for start, end, pos in self._search(line):
+            while cur_pos < l and line[cur_pos] == ' ':
+                cur_pos += 1
+
             out += line[cur_pos:start]
 
             # Value, ignoring start/end delimiters
@@ -368,7 +372,9 @@ class NestedMatch:
                 break
 
         # Append the remaining string
-        l = len(line)
+        while cur_pos < l and line[cur_pos] == ' ':
+            cur_pos += 1
+
         out += line[cur_pos:l]
 
         return out
-- 
2.52.0


