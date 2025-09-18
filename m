Return-Path: <netdev+bounces-224465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9A6B8557E
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 16:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7F855803BB
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 14:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21269308F08;
	Thu, 18 Sep 2025 14:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="RjyWq/xP"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5589B2FBDEB;
	Thu, 18 Sep 2025 14:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758206956; cv=none; b=epCiZwAA1EwdPQpEV9SgkvkAdm46zsma/23V1FQ+QdF8bGeqeVE1DY2VI80b16Y5TgQSY2hv1azBbl32RWYYcSolcgHpNCui1AcWt1zGzVbUkmgB5yiWj9LiOqg31NoKKHye+z2ey2jmx1iVKOQoxYHOQXFe7gKm5jcWjhZBWpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758206956; c=relaxed/simple;
	bh=d3nGAMwc0Ca6x+mLjsT3ZNLtBhtVTH6Kz432wyRjh4M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iJb20QXtdtDAG2rT4NKonLTO43JzYTulfWP5z39RusiaoJNwekHtOao4orZRWrT88JeObHVWdX2K4KmAtzAHPfTMgP2wSuZ07aANR6/Az/vOb07wAM4T2sjFua7ZNXC7Nm/bgg2LksU/ET3Ur5EnAfcLu1KDLAt8munYOHxcyWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=RjyWq/xP; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IEPnsm021585;
	Thu, 18 Sep 2025 07:49:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=K
	Q3rphXddI2Lg4oJm/fyhu6JkwPEiwUj7vyGSm+CrWY=; b=RjyWq/xPG+AZvgRME
	ZXziVgZuYc56QAxOgkpViSPhYZLQI2diYdmS0Lik6ZeB89PtgbNsbIEf7nPpdsAG
	WZQC1yoRrXwPV7OuOJn2L2IafenM9OABohUhr7TUf5d7B76RiVSt108cfmz1cd21
	tWwCVWbEXt0skQ0L2UD1VzpiFnkqzqHNLqwBxvqfrdrUt5qw1BXLod8ztaXldUP4
	ZtyqAdb3d4HYe/rw3LTAuA6k9WfzUKIPZPIardI5fkURMwHUUOlHKOkieckTTm/G
	AM1W9O2adxj01i2fD7WszxhzZv2M9Lh8pzTNtW+tXdGh+yb+hy35kwnvXV9olxoq
	Ib5Vg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 498ktj81p7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 07:49:03 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 18 Sep 2025 07:49:02 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 18 Sep 2025 07:49:02 -0700
Received: from sburla-PowerEdge-T630.sclab.marvell.com (unknown [10.106.27.217])
	by maili.marvell.com (Postfix) with ESMTP id 50BEF5C68EA;
	Thu, 18 Sep 2025 07:49:02 -0700 (PDT)
From: Sathesh B Edara <sedara@marvell.com>
To: <linux-kernel@vger.kernel.org>, <sburla@marvell.com>, <vburru@marvell.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>, <hgani@marvell.com>,
        <andrew@lunn.ch>, <srasheed@marvell.com>
CC: <sedara@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Subject: [net-next PATCH v1 1/2] octeon_ep: Add support to retrieve hardware channel information
Date: Thu, 18 Sep 2025 07:48:57 -0700
Message-ID: <20250918144858.29960-2-sedara@marvell.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20250918144858.29960-1-sedara@marvell.com>
References: <20250918144858.29960-1-sedara@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE4MDEzMCBTYWx0ZWRfX87rl3SWEhVi1 yzXQyAXITJ3ZmiLRvX12QhW6q8mnG57i+5jWU3DmZNBCUyEJgyhDwaWI4vh0xyT8n0WPFuRS//Z rNvTAGmtnwT+WKaS8jI0iqhUFAKFJXLq8FHU5TVVBz62atMy5fx6xlJmBmvzq63ZvWOHgDSxX22
 c5+jDz79qSuJbvJECTVR7/z+Hv4pBlWEhLV3RNLEiT57CIdUodBj69/YVmUe6N7XyZw4HD2gPeR OUt6VBK33Az5eZQafjkUzbMXMofVzI8ZJspHt9/mms1aub0yiPZJrQ/MzpWBA8wDUFiW+VWepLf aQc+FZ1qONWndsjjbv2c38FPbVduzKUnI2Z/Fb56yXtBFb+55/k3SUR6FuCstKrK7tm5MgSXNwI +6S+QKW/
X-Proofpoint-GUID: TVCcy4UzC1gpWoyPstkrdX-XzBWyHBfW
X-Authority-Analysis: v=2.4 cv=JYC8rVKV c=1 sm=1 tr=0 ts=68cc1bdf cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=yJojWOMRYYMA:10 a=M5GUcnROAAAA:8 a=TVuIt4C9u-c0JxYYBQ0A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: TVCcy4UzC1gpWoyPstkrdX-XzBWyHBfW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_01,2025-09-18_02,2025-03-28_01

This patch introduces support for retrieving hardware channel
configuration through the ethtool interface.

Signed-off-by: Sathesh B Edara <sedara@marvell.com>
---
 .../net/ethernet/marvell/octeon_ep/octep_ethtool.c   | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_ethtool.c b/drivers/net/ethernet/marvell/octeon_ep/octep_ethtool.c
index a88c006ea65b..9d57e2da0b4b 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_ethtool.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_ethtool.c
@@ -437,6 +437,17 @@ static int octep_set_link_ksettings(struct net_device *netdev,
 	return 0;
 }
 
+static void octep_get_channels(struct net_device *dev,
+			       struct ethtool_channels *channel)
+{
+	struct octep_device *oct = netdev_priv(dev);
+
+	channel->max_rx = CFG_GET_PORTS_MAX_IO_RINGS(oct->conf);
+	channel->max_tx = CFG_GET_PORTS_MAX_IO_RINGS(oct->conf);
+	channel->rx_count = CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf);
+	channel->tx_count = CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf);
+}
+
 static const struct ethtool_ops octep_ethtool_ops = {
 	.get_drvinfo = octep_get_drvinfo,
 	.get_link = ethtool_op_get_link,
@@ -445,6 +456,7 @@ static const struct ethtool_ops octep_ethtool_ops = {
 	.get_ethtool_stats = octep_get_ethtool_stats,
 	.get_link_ksettings = octep_get_link_ksettings,
 	.set_link_ksettings = octep_set_link_ksettings,
+	.get_channels = octep_get_channels,
 };
 
 void octep_set_ethtool_ops(struct net_device *netdev)
-- 
2.36.0


