Return-Path: <netdev+bounces-255417-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEr/ImMRfmkqVQIAu9opvQ
	(envelope-from <netdev+bounces-255417-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 15:27:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFBAC2640
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 15:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2D86C301150A
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 14:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A683624CC;
	Sat, 31 Jan 2026 14:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1p0q3/r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D77E3587C3;
	Sat, 31 Jan 2026 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769869522; cv=none; b=cIrUiTpgrt63aDcfyVob8HkEMzuTGKawiGRzwjka6Rdtl92/JzBDSDAzMDMbu1VPUbXDCERGdYD941inhuaczBxrBmv8xFXZHXdKON3krcK+r+/9UbfeNKeOMwuXDgh1nhP8T8J1+bGTCGgMQPAojuY9gbC5/3wghV8/Hjdsu0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769869522; c=relaxed/simple;
	bh=f75PYMG6ddvHOj0au37tuHra8a1RYsJ5qmzwD4SUTjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AbfqDGrSyjEwvJtdgeNzhXcTgTHTfU0apN5OB9zuFSLmEFp/HosC2LgNmPJOUSWDHXBjKX01t2hmgvYBLA/fQm6zTukbQCTcOk9Ji6LbSOtlcjUBGd/31S8uliPiQFe7tSz0FlpwPBhfh/wtg3h3E+niesbgcYewrBmz9WhrgGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1p0q3/r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80AF9C2BCB8;
	Sat, 31 Jan 2026 14:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769869521;
	bh=f75PYMG6ddvHOj0au37tuHra8a1RYsJ5qmzwD4SUTjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f1p0q3/rMjMPWREONbC8rMKcph3t8I45QF2IDKfCfUrKuKcq9HvyuMUORKQSeqoSO
	 l/62TEU6GDqm5+sXuxKGCu0LxVoCSrMoZXv2aqGSvk9sE7IJH9Tmbgk4NbnGj+4Lwh
	 8Ou4aS6bDve+hsKdq6rSEM7nYXRLhxTkimeNGhQ1Pni0UxA4PFIoiWWL9styvraMjs
	 Qah5GB1BvxahKCe7e08+hwOouK12F1U8SnWGsM1NVhN3sxI7zByxNEyBojHHYbsiHv
	 Kb9ZpHitHaOKYubFpvnmr9xVxu+qqOv27H50IN3bSXkof4Ek9bU9TQR9HS9KVQEHgs
	 GhEdoBGmIK8BA==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vmBuZ-0000000AVkm-38lv;
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
Subject: [PATCH v4 16/41] docs: kdoc_re: better show KernRe() at documentation
Date: Sat, 31 Jan 2026 15:24:50 +0100
Message-ID: <affc3bcc500311dcebc0ded047cff134a7095968.1769867953.git.mchehab+huawei@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255417-lists,netdev=lfdr.de,huawei];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mchehab@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,huawei];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: AFFBAC2640
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
index 1861799f1966..3f405addcc58 100644
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


