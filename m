Return-Path: <netdev+bounces-254610-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMdrLNAWe2kZBQIAu9opvQ
	(envelope-from <netdev+bounces-254610-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 09:14:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 323AAAD541
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 09:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F7E430215B2
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 08:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F2437FF5B;
	Thu, 29 Jan 2026 08:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M6nosDk8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2545237BE6E;
	Thu, 29 Jan 2026 08:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769674111; cv=none; b=hlXhmLMEHFa7WfMsXIZa1yp/YRkGxeE1zXPaeqM975JOL6/ZfBhodraEp1j5/z3hDCtfyOOg669OMI/WjFMH8xXg/jKZNyG77XYqpVPZggB6MqPquq036my7/Fuz08yLV6oKRVAm81dAign2Z1vTZLlU78VMjcIaw+MuPh5k+ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769674111; c=relaxed/simple;
	bh=Mtp3U2b4BAZhIQ5Am742/0g+jFDD4JwsLEBjzPmmPH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gT/CNH5jhNnLrTf6PYDQA3rcmDGt/nwQ32Hwn+khr+PFO/5/Md2wxh+ZyB64p4Q4ZE2WIBtxukxw2V3NR9mfPWdbZJarD+h+gkypSHlh2Nwp7yMvqR5z973qhJfioxGOWRRVaBtQgNPVnKwqbpVaJxixusWmzEWWnlSGOG/GA0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M6nosDk8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B54CBC2BCB0;
	Thu, 29 Jan 2026 08:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769674110;
	bh=Mtp3U2b4BAZhIQ5Am742/0g+jFDD4JwsLEBjzPmmPH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M6nosDk8fYDIsSlp6ATV417qFSFvZLeDrcJ0DFLzhIxpdgYZLsQidMIQGQwl45cOQ
	 yfjBTYWAgl3mzRxHYG34D8EPENzj1qPGR0sCNr2yefv5CRmvtXxpiQZ7TivRqgM4Y5
	 +lw6ZFuHoPr1vtv8JL6yf3fwB+xmIz4ro22Y1lv8sB7PxDkFi+5B/6vQfy5RHBvdAT
	 4mwuWbPdeF1Ah5KSBYonlVIEUjl3Zj1Urv5wyjh5XNmq0EfxtDBsCOQZGnQg4VGGVP
	 6ILcnW9OT5nOXRqIY7VZvPRhbx5VgyhH/ptwuqGPPtZaOdzwv6IRTANelkqWi80P36
	 UjSi6lN6ygKSg==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vlN4m-0000000ERMb-2ntt;
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
Subject: [PATCH v3 01/30] docs: kdoc_re: add support for groups()
Date: Thu, 29 Jan 2026 09:07:52 +0100
Message-ID: <c9bc631eb90afcb0bfcba53c806c9829fe0bc43f.1769673038.git.mchehab+huawei@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254610-lists,netdev=lfdr.de,huawei];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mchehab@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,huawei];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:email]
X-Rspamd-Queue-Id: 323AAAD541
X-Rspamd-Action: no action

Add an equivalent to re groups() method.
This is useful on debug messages.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
---
 tools/lib/python/kdoc/kdoc_re.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/lib/python/kdoc/kdoc_re.py b/tools/lib/python/kdoc/kdoc_re.py
index 2816bd9f90f8..19e777e2c97e 100644
--- a/tools/lib/python/kdoc/kdoc_re.py
+++ b/tools/lib/python/kdoc/kdoc_re.py
@@ -106,6 +106,13 @@ class KernRe:
 
         return self.last_match.group(num)
 
+    def groups(self):
+        """
+        Returns the group results of the last match
+        """
+
+        return self.last_match.groups()
+
 
 class NestedMatch:
     """
-- 
2.52.0


