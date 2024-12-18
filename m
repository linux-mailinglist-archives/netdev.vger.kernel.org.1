Return-Path: <netdev+bounces-152919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C88FF9F6554
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 12:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21BCC188BD24
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 11:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0AA1A01BF;
	Wed, 18 Dec 2024 11:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="J+P2eELO"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B5D19FA92;
	Wed, 18 Dec 2024 11:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734522694; cv=none; b=uuPoLkb98iCX5aXVwRnLxnMLIySsEJH/i4V0m2w9uZ+BCWhD/0X4ZyDBg/dpLW/dRRFO9CLv6bwGDh3JTx8wQLksb5jfw+089NrsohCzGBdpHNgcjlNTRJWqTPA7TETl5vK653OI6V7Ke29QU0jYRPd+wF13aKBf3zvsohFja/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734522694; c=relaxed/simple;
	bh=NZhaB+UEmMnKLHiJAumVCq88FfI0Rm+jiZaefdkg2QA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XFAP1Ggl2KrkVd3xHxKJkBlke+CsN6+hOPO6Lhlf27pC2+KtrrdFtLPZLPucG8LZPKrUCXJxuEjTye5cvP8ldSP5CoZA888tPFUN7jsluipI4+SZXd7NQ0lyZgDeMLfsgLe2sl2cNNL+VzPD8VLuyHQmBW/MQqT9fYnHll/pGTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=J+P2eELO; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BI9vMJU030754;
	Wed, 18 Dec 2024 03:51:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=n
	av91Ly0/uh9EQJD8b4swuC8q8IinqPy5JzxZcEOL7Y=; b=J+P2eELOvtWwDkoE6
	h1nEqI47i330RuGPVy6m1maM2/aBJbv2oD2oFA70RRBJd/WcVGGsDxEVY+RAHxrO
	bzT5UQtJ9jETMxl5enV/Ysa5sXUaTYFgHrtMMH2KWR08EggCSwQ5WAU4NtLJzDdN
	80f5CCzjC5tVUY5/ztYU9rJP+iKr9BbEBIcqCxja/JRKH/cY8RHJeJMGM9IIPDg/
	WXBxVGX/Sx3V8NPaJLI2EW1qyuBcaKCvv9+fniO08g6neAPN6CF4g376OrkiQvFD
	0TiP1CT+7zJQ3qyHZWteomFNGDZWiwBSAbvVzHxkG8VUsoF0gpCuCLtaExBEgbVj
	xThHw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 43kv6pg5x0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 03:51:17 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 18 Dec 2024 03:51:16 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 18 Dec 2024 03:51:16 -0800
Received: from ubuntu-PowerEdge-T110-II.sclab.marvell.com (unknown [10.106.27.86])
	by maili.marvell.com (Postfix) with ESMTP id A0C5D3F7075;
	Wed, 18 Dec 2024 03:51:15 -0800 (PST)
From: Shinas Rasheed <srasheed@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <hgani@marvell.com>, <sedara@marvell.com>, <vimleshk@marvell.com>,
        <thaller@redhat.com>, <wizhao@redhat.com>, <kheib@redhat.com>,
        <konguyen@redhat.com>, <horms@kernel.org>, <einstein.xue@synaxg.com>,
        "Shinas
 Rasheed" <srasheed@marvell.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        "Paolo
 Abeni" <pabeni@redhat.com>,
        Satananda Burla <sburla@marvell.com>,
        "Abhijit
 Ayarekar" <aayarekar@marvell.com>
Subject: [PATCH net v3 1/4] octeon_ep: fix race conditions in ndo_get_stats64
Date: Wed, 18 Dec 2024 03:51:08 -0800
Message-ID: <20241218115111.2407958-2-srasheed@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241218115111.2407958-1-srasheed@marvell.com>
References: <20241218115111.2407958-1-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: CXm-UsbWJ_JCSJAKCmGii_6d0FZbrb5n
X-Proofpoint-GUID: CXm-UsbWJ_JCSJAKCmGii_6d0FZbrb5n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

ndo_get_stats64() can race with ndo_stop(), which frees input and
output queue resources. Call synchronize_net() to avoid such races.

Fixes: 6a610a46bad1 ("octeon_ep: add support for ndo ops")
Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
---
V3: 
  - No changes 

V2: https://lore.kernel.org/all/20241216075842.2394606-2-srasheed@marvell.com/
  - Changed sync mechanism to fix race conditions from using an atomic
    set_bit ops to a much simpler synchronize_net()

V1: https://lore.kernel.org/all/20241203072130.2316913-2-srasheed@marvell.com/

 drivers/net/ethernet/marvell/octeon_ep/octep_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
index 549436efc204..941bbaaa67b5 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
@@ -757,6 +757,7 @@ static int octep_stop(struct net_device *netdev)
 {
 	struct octep_device *oct = netdev_priv(netdev);
 
+	synchronize_net();
 	netdev_info(netdev, "Stopping the device ...\n");
 
 	octep_ctrl_net_set_link_status(oct, OCTEP_CTRL_NET_INVALID_VFID, false,
-- 
2.25.1


