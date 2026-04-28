Return-Path: <netdev+bounces-281782-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEXUGnuL8GkRUwEAu9opvQ
	(envelope-from <netdev+bounces-281782-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 12:27:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D753848292F
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 12:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B8B6A3023A70
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 10:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3F13ECBFB;
	Tue, 28 Apr 2026 10:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="O3uvXprD"
X-Original-To: netdev@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C483E717F
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 10:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777372020; cv=none; b=LWuzTw9KSWwZV3M2bRLC4AOCdgj2CHGqLH494s74W3aDGklJLmteKVLHKrfuP/zeK+GCf7fPSqCEhRIXDSy3h0NYyEwNH04zwi7K0+/+ZW28uBzSwfLDff7+Z0zZpkbJT/2gKNxEJ54nK8PafnovsO0sga14PqpFzcnWidpu4F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777372020; c=relaxed/simple;
	bh=tmh28N7EqAh47yW39PAljeH9qczgHiXAOMMOAKLBQMg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=THG+trBHmtJqXBEGtxV/ArCZXlKrIe9zbnnOICZiFeyPPxm0xMkLfPRWreqN5Sq/4WX4wOeywbiZbWQKB/qPXdWVQFLgn3Mz0neWh6T8AVh+RmmYLUTlGHgf5oMBg/6Dm9aQhsgvkA/JpJDhanWD9sQ1mirn1Jl8RC+ZrBVKGX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=O3uvXprD; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260428102655euoutp02505ab2a2d713567e4d0f0791a5705042~qfm5VDcWq1545315453euoutp02Z
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 10:26:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260428102655euoutp02505ab2a2d713567e4d0f0791a5705042~qfm5VDcWq1545315453euoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1777372015;
	bh=70jEdzIKV8HR08JHZkS91QEFnkGBbri7q7JyRmu8yWw=;
	h=From:To:Cc:Subject:Date:References:From;
	b=O3uvXprDJF4RCcnci6yxa+BnE1Qj9l+KcAWn9Dgh57wE/Mw1Yu6a/yEliQOMpTokY
	 1vSFQxtuXSDjgWhAEglhDiyRaXyeOF9VKToh9/4BWDy244XxaTHD95KeuMeE83wNMc
	 TvX4GIARBhZ/IUXyUZHqn/9MAGBO73p/gmzXT9zo=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260428102655eucas1p1786b9974056b896017eed056a1fbac91~qfm5Ee_kS0922509225eucas1p1z;
	Tue, 28 Apr 2026 10:26:55 +0000 (GMT)
Received: from AMDC4843.eu.corp.samsungelectronics.net (unknown
	[106.120.77.61]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260428102654eusmtip29c457fc20de20d69e1c614b17bc5f587~qfm4zfn3n3137031370eusmtip2E;
	Tue, 28 Apr 2026 10:26:54 +0000 (GMT)
From: Jakub Raczynski <j.raczynski@samsung.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, Jakub Raczynski <j.raczynski@samsung.com>
Subject: [PATCH RESEND net-next] net/intel/e100: Make read-only param_range
 struct static const
Date: Tue, 28 Apr 2026 12:26:30 +0200
Message-Id: <20260428102629.3537960-1-j.raczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260428102655eucas1p1786b9974056b896017eed056a1fbac91
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260428102655eucas1p1786b9974056b896017eed056a1fbac91
X-EPHeader: CA
X-CMS-RootMailID: 20260428102655eucas1p1786b9974056b896017eed056a1fbac91
References: <CGME20260428102655eucas1p1786b9974056b896017eed056a1fbac91@eucas1p1.samsung.com>
X-Rspamd-Queue-Id: D753848292F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281782-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[samsung.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j.raczynski@samsung.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,samsung.com:email,samsung.com:dkim,samsung.com:mid]

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


