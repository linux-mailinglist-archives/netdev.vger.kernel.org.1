Return-Path: <netdev+bounces-265548-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBWFNNnFrmn2IgIAu9opvQ
	(envelope-from <netdev+bounces-265548-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 14:06:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B968239677
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 14:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E6E8B3037499
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 13:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1E13C278B;
	Mon,  9 Mar 2026 13:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="VHI8XV/j"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AA23ACF05;
	Mon,  9 Mar 2026 13:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773061509; cv=none; b=YEIxmaEv6Z4SCIncYIkNveUJWhrVr3lt4647tRmf6wVRbFHYeI9wqMdHew0vV3xKrYWXsFehdWbtHisZpW1DMRzpbJJUIvNwFIqvoUoX5TVpZ0KwkVkvc8LUOGikEYdfENJ0cXbrvXnTbQd0o0vUGk7uBDwceQD3EZbsrrqVZiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773061509; c=relaxed/simple;
	bh=bL85DciU1+JCk6Arm+f6sGDTfQT0oLlhH9PIsvhFCr8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iMSBhJHNx+dXQg1PBBC3nkhKdKBj10tkN5YXB1LvOXToQkirggfOael5WTTZbzPhpecp0Lpd96DDTOe6L/CPpEp/aqRatWA3S5FbV9bCEF/KjyLyT8uDzaqmgbeZc1wibqrtdBarF3Brlhq2mDnQrWQUAkqWlJdKKIDmK0V6FJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=VHI8XV/j; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=nBvMacVMJ3eoqb13J8JgKyxYOCUAcGevHK68ZuR+0/M=;
	b=VHI8XV/jwCLbFPauTuaO+7vLrclUQVMoxo+k+2kEfYF2kuEvxMXB17/MW/ZGTNppAQLw0SEGd
	MURQR2eBqzsAZYNlW7nyyHPYqspsos5JOcEgMZkjD9H+RgGEHjsml2E6sTESbQ6fhwHAOifPRZC
	Vpy7AnbT76Vhh9lCCSuSul0=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4fTxtf05RZz1T4GG;
	Mon,  9 Mar 2026 20:59:54 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id D893B40561;
	Mon,  9 Mar 2026 21:05:02 +0800 (CST)
Received: from kwepemq200017.china.huawei.com (7.202.195.228) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 9 Mar 2026 21:05:02 +0800
Received: from hulk-vt.huawei.com (10.67.174.72) by
 kwepemq200017.china.huawei.com (7.202.195.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 9 Mar 2026 21:05:02 +0800
From: Cai Xinchen <caixinchen1@huawei.com>
To: <ioana.ciornei@nxp.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<caixinchen1@huawei.com>
Subject: [PATCH v2 -next 2/2] dpaa2: compile dpaa2 even CONFIG_FSL_DPAA2_ETH=n
Date: Mon, 9 Mar 2026 12:50:18 +0000
Message-ID: <20260309125018.420275-3-caixinchen1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260309125018.420275-1-caixinchen1@huawei.com>
References: <20260309125018.420275-1-caixinchen1@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemq200017.china.huawei.com (7.202.195.228)
X-Rspamd-Queue-Id: 6B968239677
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	TAGGED_FROM(0.00)[bounces-265548-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nxp.com:email,huawei.com:dkim,huawei.com:email,huawei.com:mid];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[caixinchen1@huawei.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

CONFIG_FSL_DPAA2_ETH and CONFIG_FSL_DPAA2_SWITCH are not
associated, but the compilation of FSL_DPAA2_SWITCH depends on
the compilation of the dpaa2 folder. The files controlled by
CONFIG_FSL_DPAA2_SWITCH in the dpaa2 folder are not controlled
by CONFIG_FSL_DPAA2_ETH, except for the files controlled by
CONFIG_FSL_DPAA2_SWITCH. Therefore, removing the restriction will
not affect the compilation of the files in the directory.

Fixes: f48298d3fbfaa ("staging: dpaa2-switch: move the driver out of staging")
Suggested-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>
---
 drivers/net/ethernet/freescale/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/Makefile b/drivers/net/ethernet/freescale/Makefile
index de7b31842233..d0a259e47960 100644
--- a/drivers/net/ethernet/freescale/Makefile
+++ b/drivers/net/ethernet/freescale/Makefile
@@ -22,6 +22,5 @@ ucc_geth_driver-objs := ucc_geth.o ucc_geth_ethtool.o
 obj-$(CONFIG_FSL_FMAN) += fman/
 obj-$(CONFIG_FSL_DPAA_ETH) += dpaa/
 
-obj-$(CONFIG_FSL_DPAA2_ETH) += dpaa2/
-
+obj-y += dpaa2/
 obj-y += enetc/
-- 
2.34.1


