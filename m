Return-Path: <netdev+bounces-254359-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBU+OZk/emlB4wEAu9opvQ
	(envelope-from <netdev+bounces-254359-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 17:55:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E02AA65B7
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 17:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6825C309E59D
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 16:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC1836D4F5;
	Wed, 28 Jan 2026 16:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iTNz+5Ib"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F6A371073;
	Wed, 28 Jan 2026 16:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769619034; cv=none; b=G+6erNdu/3dqK0Qj6rKtVKLX7iHiJQ81n7DXcv4el95gXsGjvno3LgRLQe/Rv3BC72E+CC44KqM5Sc5wdGqsMkh2zl1i6F5AHIIJ4J7U1GLY/UirDBkkruFhGT5yHvajp+vLkBwCYGjmgjz2N5dy+W+Va8PH3rB9dE2ByqMlEmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769619034; c=relaxed/simple;
	bh=FAGo3vp1MYKDT8O2fN+VyX3S2nX5qeOzVDn265Hyrg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EIS838pQ7ItFS6NQG/dkRCHQsc4L/EezXfn312BXS3hMbG9yxUYjJ4C/QCuy4Fa4W7hMa5vj9twGZQuzYqLBtI+xiXlYeQjZ9ebGV1AS10G6DrQDPQLyCi1W8IXcjaebLVY6PpN6zAXgCdY+NpfUQq3J7JWZ7fF5lF6ufeNYM3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iTNz+5Ib; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72557C4CEF1;
	Wed, 28 Jan 2026 16:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769619034;
	bh=FAGo3vp1MYKDT8O2fN+VyX3S2nX5qeOzVDn265Hyrg0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iTNz+5IbtqRIFaEc3wxSMvLY4SGuhWXsaG89cnQ7zvyLdiQjiwGK7SyqAh736rE+N
	 bq0nFWFbkQyIclENSlnsAslMX0nndJLWweiWGEq48jLK77CMmR2n4xjkMP4r6inXuY
	 hYlDZHQhXwoqNzH11802AHQVgs/ggt7ggOEy54P9JTAlpf7HjSapRTZoAm7YI44Dx1
	 tLaQM/QP4uoFa7DpygKbwfbNMMm28MDTuJ5ixH2QY3yYzx5O5b3ZdWmYPbxAyQ/Dop
	 H8Yu30QB9FuZUfqgruAVZWYH7beCrBSDQq0FWP+Nivr0nFzBUuOCgTJUmBHVjBZC8m
	 w+hyavb/Kdgcw==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vl8kS-0000000DAz1-1wI7;
	Wed, 28 Jan 2026 17:50:32 +0100
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
Subject: [PATCH v2 13/25] docs: kdoc_parser: add support for LIST_HEAD
Date: Wed, 28 Jan 2026 17:50:11 +0100
Message-ID: <7a254f627ed79e2a7ffaf3e91bbb5ab269595d20.1769617841.git.mchehab+huawei@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254359-lists,netdev=lfdr.de,huawei];
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
X-Rspamd-Queue-Id: 5E02AA65B7
X-Rspamd-Action: no action

Convert LIST_HEAD into struct list_head when handling its
prototype.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
---
 tools/lib/python/kdoc/kdoc_parser.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index 92b550189988..33710c4be145 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -219,6 +219,7 @@ var_xforms = [
     (KernRe(r"__ro_after_init"), ""),
     (KernRe(r'\s*__guarded_by\s*\([^\)]*\)', re.S), ""),
     (KernRe(r'\s*__pt_guarded_by\s*\([^\)]*\)', re.S), ""),
+    (KernRe(r"LIST_HEAD\(([\w_]+)\)"), r"struct list_head \1"),
     (KernRe(r"(?://.*)$"), ""),
     (KernRe(r"(?:/\*.*\*/)"), ""),
     (KernRe(r";$"), ""),
-- 
2.52.0


