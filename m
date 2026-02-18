Return-Path: <netdev+bounces-259278-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHZ0AmCTlWn1SQIAu9opvQ
	(envelope-from <netdev+bounces-259278-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 11:24:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 519841555CF
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 11:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CB6E1302CE15
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 10:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE88934CFB8;
	Wed, 18 Feb 2026 10:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4jW1HQE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BEB33EB10;
	Wed, 18 Feb 2026 10:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771409607; cv=none; b=rPTVrYLrAfNyKltEPRnuw0T1wELaLrSlvB/Q3x5+qlg97Dm09hNSSufiSHdwwGFX0SLCTAZdK4qmt9dWD3YzKpY5AGl7MEOC1eWvUWnwZEJPsM0ePdqO2m35V1uoVvcdeGcWGEwJ8wYiSsbavNrHj7VX5aBsw7cMpYFd81csMXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771409607; c=relaxed/simple;
	bh=ClRhaNpIRp4d1LeCk51dHxLXX4FD+ZDnmDB3anBLh9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TBAYISBltoNqc1HdZPIVMsnEpHkrI2A/ZkmJvp9GqvBN/Je6sMMvUgfksZ5FZSCSFe6D2sYJrDp4TWhbUKWqP28kRSqBgf+ni5DD1e/EQmTK85f7+Q9bOD4bogX3f+rZa5TvwDXRS7WzDe9CfuJQAyPDNMoeaW310ouxy5YOOSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E4jW1HQE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ACFAC19423;
	Wed, 18 Feb 2026 10:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771409607;
	bh=ClRhaNpIRp4d1LeCk51dHxLXX4FD+ZDnmDB3anBLh9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E4jW1HQEiNJGt9nxlWI7HPbPRCzBmC2z4/0V+SKXwbQCMFGfYkQQdUPUjxfK1785C
	 8peGmSJYA1db+nfNkQZMKfH8b2Jx6r0pjKIdjcmerVlhmbqNBDlRsD2+rdABgs2eiR
	 dPC5cgWXdTKvgafq8jxD1ZeEdx0Xg6icPuDtdvyKN56CaKv0d/rOZIPUKwMZAPrOX5
	 ZsSIDLz68gsR3V/uCbF1dfdeYRAIWg9Kt1L5UnaW9MkDpZdowBgPVyvnbjpw7tRCzX
	 x24RT1AdesyHRv3ptd19n8jamK067eY76BDnbcadlv/NTBPSMYfPhO3lByB7I9VNp9
	 8CEgVb48qVKBg==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vseYf-00000000Loe-3OFS;
	Wed, 18 Feb 2026 11:13:25 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 25/38] docs: kdoc_parser: minimize differences with struct_group_tagged
Date: Wed, 18 Feb 2026 11:12:55 +0100
Message-ID: <7b6f6ba86ebeab3d62735eb5b851631d042a361c.1771408406.git.mchehab+huawei@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-259278-lists,netdev=lfdr.de,huawei];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mchehab@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,huawei];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 519841555CF
X-Rspamd-Action: no action

While the previous version does a better job representing
the actual struct, it ends losing documentation from each
member.

Change the replacements to minimize such changes. With that,
the only differences before/after using NestedMatch new
replacement logic are (at man page output):

    --- before.log  2026-01-29 06:14:20.163592584 +0100
    +++ after.log   2026-01-29 06:32:04.811370234 +0100
    @@ -1573701 +1573701 @@
    -.BI "    struct ice_health_tx_hang_buf  tx_hang_buf;"
    +.BI "    struct ice_health_tx_hang_buf tx_hang_buf;"
    @@ -4156451 +4156451 @@
    -.BI "    struct libeth_fq_fp  fp;"
    +.BI "    struct libeth_fq_fp fp;"
    @@ -4164041 +4164041 @@
    -.BI "    struct libeth_xskfq_fp  fp;"
    +.BI "    struct libeth_xskfq_fp fp;"
    @@ -4269434 +4269434 @@
    -.BI "    struct page_pool_params_fast  fast;"
    +.BI "    struct page_pool_params_fast fast;"
    @@ -4269452 +4269452 @@
    -.BI "    struct page_pool_params_slow  slow;"
    +.BI "    struct page_pool_params_slow slow;"
    @@ -4269454 +4269454 @@
    -.BI "    STRUCT_GROUP( struct net_device *netdev;"
    +.BI "    struct net_device *netdev;"

e.g. basically whitespaces, plus a fix NestedMatch to
better handle /* private */ comments.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 tools/lib/python/kdoc/kdoc_parser.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index e1914b2a6ab7..e735e79b5061 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -126,7 +126,7 @@ struct_xforms = [
     #
     (CFunction('struct_group'), r'\2'),
     (CFunction('struct_group_attr'), r'\3'),
-    (CFunction('struct_group_tagged'), r'struct \1 { \3 } \2;'),
+    (CFunction('struct_group_tagged'), r'struct \1 \2; \3'),
     (CFunction('__struct_group'), r'\4'),
 
     #
-- 
2.52.0


