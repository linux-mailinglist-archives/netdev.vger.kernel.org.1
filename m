Return-Path: <netdev+bounces-116524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B83994AA98
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 16:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87100B290BC
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 14:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0EF5824AC;
	Wed,  7 Aug 2024 14:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="J7auRFE4"
X-Original-To: netdev@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F6A80BEC;
	Wed,  7 Aug 2024 14:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723041854; cv=none; b=s1T2vn98RGtbJ312+1wsnVEZTPqcDv52POPTI92cf00JS+xu7HPXhuh7flZg5R0FGPqZlLGJAubmGRvU4FhDlPcF6ZA8xAm3RTj6tt3yvnyUzutycPDlXivZQ2nQHw+HpqRpvEhSKs7LXDMX6rn+3XeHdufC9WMXjp6n9KKxVZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723041854; c=relaxed/simple;
	bh=y/jffoFIybGv4O9jKBf4bavvf0HlaLqCKtoOa6vrEj4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RneAFAy6jy0RUBubcdDEC1RwEofTixMhPdb8mIKbllYTLKW63YsMn/ljnsLVv0aHqhp6vheTNA/CgZCOjC3HBQgyoel+kkTOJ2Di6Ac0At5/KJJFx2/NspmjP/XUVGGwDD2ncGHa3ib8jGbxkDOBW/SeJH6j7+C1eRnvSWf2Kmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=J7auRFE4; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 8F0B721B19;
	Wed,  7 Aug 2024 16:44:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1723041844;
	bh=sKOb31r/3Cf+dBRphbkBxUG2Eb1AmfV4cp8ruJ72OgM=; h=From:To:Subject;
	b=J7auRFE4BpY4chPpWRiWdRzVsT9BK6XF2c97xjtEatuLUlyDQ5FaegGsiGE2UfnM/
	 AfWfQxKHakLlq5bFKvdijs7BVtBlAXZYxVMPbxdlSqZfLZZKQajReXH4HiQW+8+rml
	 nU9lxAyxkiioUrxa6/Qc0HjegOBtb0ZlVRx+Mnl+Wb0S8nn6wakGQmB9izL8DQt3WX
	 6BcffeQsAE8622Ur/uvyWUmUnOGl/3DhRluKz4sD3N0zHeEc5betIx2HwPl/UMiO4F
	 MHBTETgU3C2+9zlbaMclie+keM54znSdUhfewuZVYgTrnu/vGQKI5ARJ47M9Z3gUc4
	 hQDvN6N8mTo9Q==
From: Francesco Dolcini <francesco@dolcini.it>
To: Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/4] net: fec: make PPS channel configurable
Date: Wed,  7 Aug 2024 16:43:48 +0200
Message-Id: <20240807144349.297342-4-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240807144349.297342-1-francesco@dolcini.it>
References: <20240807144349.297342-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Depending on the SoC where the FEC is integrated into the PPS channel
might be routed to different timer instances. Make this configurable
from the devicetree.

When the related DT property is not present fallback to the previous
default and use channel 0.

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 drivers/net/ethernet/freescale/fec_ptp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
index 6f0f8bf61752..8e17fd0c8e6d 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -529,8 +529,6 @@ static int fec_ptp_enable(struct ptp_clock_info *ptp,
 	unsigned long flags;
 	int ret = 0;
 
-	fep->pps_channel = DEFAULT_PPS_CHANNEL;
-
 	if (rq->type == PTP_CLK_REQ_PPS) {
 		fep->reload_period = PPS_OUPUT_RELOAD_PERIOD;
 
@@ -712,12 +710,16 @@ void fec_ptp_init(struct platform_device *pdev, int irq_idx)
 {
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct fec_enet_private *fep = netdev_priv(ndev);
+	struct device_node *np = fep->pdev->dev.of_node;
 	int irq;
 	int ret;
 
 	fep->ptp_caps.owner = THIS_MODULE;
 	strscpy(fep->ptp_caps.name, "fec ptp", sizeof(fep->ptp_caps.name));
 
+	fep->pps_channel = DEFAULT_PPS_CHANNEL;
+	of_property_read_u32(np, "fsl,pps-channel", &fep->pps_channel);
+
 	fep->ptp_caps.max_adj = 250000000;
 	fep->ptp_caps.n_alarm = 0;
 	fep->ptp_caps.n_ext_ts = 0;
-- 
2.39.2


