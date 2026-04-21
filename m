Return-Path: <netdev+bounces-280085-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANB2LB5j52l07gEAu9opvQ
	(envelope-from <netdev+bounces-280085-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 13:44:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 068C543A2FA
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 13:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97B3330421E6
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 11:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97B5286891;
	Tue, 21 Apr 2026 11:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CM+rBnjt"
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5F9273D8D
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 11:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776771687; cv=none; b=hS1MArXTcdbOW6Kii70PzO7MgOiKCwJwStwdnSp/VUqDwQcdVFQkINaSC8yyDiBjNQSgOPp9ditBObj2e7R3r3qTpAUa42CZ5Lpk4ZxTP9f30HVQfNCyPiXcrUzK9Rolso7FeUHx2Z3BHbKuTkCzgxqn8QT8SzrOOy2ld+cEQeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776771687; c=relaxed/simple;
	bh=tmh28N7EqAh47yW39PAljeH9qczgHiXAOMMOAKLBQMg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=aTdoHpFnQhH3Xp3Gsc5vfRMRK0Oq1eAQck48GVSn/pQLUoyqgn09w4dFJlYDIkNZ9Wyum1bT33do2Cd9SOprEorasyGTI34Rihv6TzQ2q0LZ4uqK5PLnEyW8uFScF9hty1eXBCbdknZTX0W/qidlg6v7mTpnxXOUg9bZeIlq/Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=CM+rBnjt; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260421114124euoutp01809a80545ce7db60461cda27845d1c58~oXG7vd0pz0679706797euoutp01H
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 11:41:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260421114124euoutp01809a80545ce7db60461cda27845d1c58~oXG7vd0pz0679706797euoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1776771684;
	bh=70jEdzIKV8HR08JHZkS91QEFnkGBbri7q7JyRmu8yWw=;
	h=From:To:Cc:Subject:Date:References:From;
	b=CM+rBnjt/04mUCui/mZOpnL19hW9TGmmquJoEHYCxn+icLfiNnXWNo3AmLkHr2IOa
	 aHAiLVU6vmYbiIkkIX4fYSlv0WejZPtNscBQLIj2TfQnjODwlKff6U5rzftVJGoGT+
	 0w4/jn6iCyqaL43dLZXk+fK6IyCE0kWVQ6XwbISw=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260421114124eucas1p1198b3e8dd272702a5f717b818729a978~oXG7YEEeM1149611496eucas1p1Q;
	Tue, 21 Apr 2026 11:41:24 +0000 (GMT)
Received: from AMDC4843.eu.corp.samsungelectronics.net (unknown
	[106.120.77.61]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260421114122eusmtip218a09934226ad44030fc9000a5445d85~oXG6QV7iK1631316313eusmtip2j;
	Tue, 21 Apr 2026 11:41:22 +0000 (GMT)
From: Jakub Raczynski <j.raczynski@samsung.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com, kernel-janitors@vger.kernel.org, Jakub Raczynski
	<j.raczynski@samsung.com>
Subject: [PATCH] net/intel/e100: Make read-only param_range struct static
 const
Date: Tue, 21 Apr 2026 13:41:17 +0200
Message-Id: <20260421114117.2690342-1-j.raczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260421114124eucas1p1198b3e8dd272702a5f717b818729a978
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260421114124eucas1p1198b3e8dd272702a5f717b818729a978
X-EPHeader: CA
X-CMS-RootMailID: 20260421114124eucas1p1198b3e8dd272702a5f717b818729a978
References: <CGME20260421114124eucas1p1198b3e8dd272702a5f717b818729a978@eucas1p1.samsung.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280085-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[samsung.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j.raczynski@samsung.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 068C543A2FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

No need to use stack for single use read-only struct,
just make it static const.

Signed-off-by: Jakub Raczynski <j.raczynski@samsung.com>
---
 drivers/net/ethernet/intel/e100.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
index 9074b558de35..6bce22e15a97 100644
--- a/drivers/net/ethernet/intel/e100.c
+++ b/drivers/net/ethernet/intel/e100.c
@@ -1034,8 +1034,8 @@ static inline int e100_phy_supports_mii(struct nic *nic)
 
 static void e100_get_defaults(struct nic *nic)
 {
-	struct param_range rfds = { .min = 16, .max = 256, .count = 256 };
-	struct param_range cbs  = { .min = 64, .max = 256, .count = 128 };
+	static const struct param_range rfds = { .min = 16, .max = 256, .count = 256 };
+	static const struct param_range cbs  = { .min = 64, .max = 256, .count = 128 };
 
 	/* MAC type is encoded as rev ID; exception: ICH is treated as 82559 */
 	nic->mac = (nic->flags & ich) ? mac_82559_D101M : nic->pdev->revision;
-- 
2.34.1


