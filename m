Return-Path: <netdev+bounces-254353-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJEwIXBEemn34wEAu9opvQ
	(envelope-from <netdev+bounces-254353-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 18:16:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B587A6AC8
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 18:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD7D3315EB10
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 16:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9940136EA84;
	Wed, 28 Jan 2026 16:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1Plv/sD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D851350A09;
	Wed, 28 Jan 2026 16:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769619033; cv=none; b=jwZ83l89cAr5LU7QRKUHWLkdoFiRfyJPNlfRACo9uNYEpr1RzUed9AWCv0yGXjx4jylHLLpvRixbFZDKqtBGrRfPPJM89F4unN024JPTw1HOG/KWLPKZ1/eurHzE/OzLzcQ6OVToSSP7t8z0Fr3JwoHiDkAFq73rY8oUJAKWj0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769619033; c=relaxed/simple;
	bh=kiVn8gJsa15hW54tTb5XhUjmr8gdDA7uMvhSg2gJwFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DhXDdr3yYQX1aiI6EaL3QVLH9QzoB4zJexkGdqFmxAydYMTV05JL48dSbL0dO/zhHbtSJ4vkN96oamgwUiTZrg84KBupOVry9HG08Rq5r5wp/XGkqI7OtW+n76PjMMOhKo8il53YpHcowO7Fxz2e9Oa4F6eCk4p8hNKKOSHQYEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1Plv/sD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D9ADC4CEF1;
	Wed, 28 Jan 2026 16:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769619033;
	bh=kiVn8gJsa15hW54tTb5XhUjmr8gdDA7uMvhSg2gJwFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I1Plv/sDNNLqEuYlpf96nRMOHVctQMqw1/gHSPz20Wefhsilu6hzo6TplPo0fPvzB
	 IZ95bftdX1wqWOUsgGwGHIbXXNtVX8YT98XyB9kDrIDJqeBLxO+QQu5L+T23vvAAoK
	 rnieO7iSHT/5d3BlzchDtUFKMlj5hYRvkmkyfUzzc2ROe+KkM27VQEp+bWfPJa6rzv
	 6s7VjUAfbxCqG/fLCX877/GrAFAvdDVIZme9Pnssxu37AuYzdWt0xN5J52xWQFjar/
	 HFH6BksW/Q+6cM8Lt3UVUe1oAnp1aeGeH4DUxK7AaNLRhvpm6mboJIa4g6H+vVQcRf
	 mNTfSACMShHww==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vl8kR-0000000DAuD-0xVA;
	Wed, 28 Jan 2026 17:50:31 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH v2 09/25] docs: kdoc_parser: add some debug for variable parsing
Date: Wed, 28 Jan 2026 17:50:07 +0100
Message-ID: <e7d2dcabb0211447772127b6f32483184cd577ca.1769617841.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769617841.git.mchehab+huawei@kernel.org>
References: <cover.1769617841.git.mchehab+huawei@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254353-lists,netdev=lfdr.de,huawei];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mchehab@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,huawei];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:email]
X-Rspamd-Queue-Id: 1B587A6AC8
X-Rspamd-Action: no action

This is a new parser that we're still fine-tuning. Add some
extra debug messages to help addressing issues over there.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
---
 tools/lib/python/kdoc/kdoc_parser.py | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index cbfdaba39494..ccee4e0bcaab 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -1033,11 +1033,19 @@ class KernelDoc:
                 declaration_name = r.group(1)
 
             default_val = r.group(2)
+
+            self.config.log.debug("Variable proto parser: %s from '%s'",
+                                  r.groups(), proto)
+
         else:
             r= KernRe(OPTIONAL_VAR_ATTR + r"(?:[\w_]*)?\s+(?:\*+)?(?:[\w_]+)\s*[\d\]\[]*\s*(=.*)?")
 
             if r.match(proto):
                 default_val = r.group(1)
+
+        if default_val:
+            self.config.log.debug("default: '%s'", default_val)
+
         if not declaration_name:
            self.emit_msg(ln,f"{proto}: can't parse variable")
            return
@@ -1045,6 +1053,9 @@ class KernelDoc:
         if default_val:
             default_val = default_val.lstrip("=").strip()
 
+        self.config.log.debug("'%s' variable prototype: '%s', default: %s",
+                              declaration_name, proto, default_val)
+
         self.output_declaration("var", declaration_name,
                                 full_proto=full_proto,
                                 default_val=default_val,
-- 
2.52.0


