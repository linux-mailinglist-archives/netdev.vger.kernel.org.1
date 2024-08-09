Return-Path: <netdev+bounces-117135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CDE94CD2E
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 11:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7360E1C20E61
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 09:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F381917E4;
	Fri,  9 Aug 2024 09:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="S5vGPXQg"
X-Original-To: netdev@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E18191494;
	Fri,  9 Aug 2024 09:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723195135; cv=none; b=LJePbAdw/5jjp+xrJbcMap1bFF+aoTO5rXj1aPCHLhHn3/wA2saGDkHpchr7NLGMEldbxKemnu1uDfB7WnLfigRBNruPwPaHVbVBtWnJhpU24LmFUG3G8OHPB5Cjj4X4SrbqbWKXvy0xfCM5qmS+HzV1pA+OTDaPGpVcjPjt2TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723195135; c=relaxed/simple;
	bh=QM5RqrqcktqXeIDfRBP175DXMqiPVEAu+7zAxCxcFnk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TK8fjf71Vc8Pwp8VYTQB9+RirMAcCwcypus4Y8OSCg5OSAIZ6XslSkM0aOVDTErnjH6dDcEldioqG9WXdpzqVsctyshSkBz5QdRbQHJZ2MCRUEyUMEgTsNMljchvge7zsTEXeO1nVsnYJ1FCAjV/Y+Dhl6L6J9bnMYXCUlbpntI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=S5vGPXQg; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 8AB5E2225F;
	Fri,  9 Aug 2024 11:18:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1723195132;
	bh=/l2VIPtGJZdoH2vVzcshpCeh2OG0Hg9867gp1xRmQ5w=; h=From:To:Subject;
	b=S5vGPXQgRtjy8WhmdLXPZF2mVZEi6QOqGFONWI/RSjxDQTFzbo/VIHJlfgEm2eLaV
	 Mh8jUviJBWt2yYNzZDMS7RskV63dOqeamt4kof1+GcHwMbNtE23k2X8wJNlQGelsEW
	 nzrS2vRZy2AQqrN21DsdBgfEetgTLIAr7TGlyuqgXX1VaUtCf6ZT9y5YBrMjUl3mnz
	 FfGhZ46Hn3VDbLlUwoqeNN59NiHTTBJRGpjFOn9yJ9y9AFHs/AnR/mGyWf9nO5WMnS
	 jz6zbj0nFCreDnXyR0uonQGZKU+EGyrYwfCtUSs41n/cz7zJgZ94wgHDSoc1UgFrh5
	 rBqYv5VcraVpg==
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
	linux-kernel@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>,
	Rafael Beims <rafael.beims@toradex.com>
Subject: [PATCH v2 3/3] net: fec: make PPS channel configurable
Date: Fri,  9 Aug 2024 11:18:44 +0200
Message-Id: <20240809091844.387824-4-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240809091844.387824-1-francesco@dolcini.it>
References: <20240809091844.387824-1-francesco@dolcini.it>
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

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Tested-by: Rafael Beims <rafael.beims@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
v2: add Reviewed|Tested-by
---
 drivers/net/ethernet/freescale/fec_ptp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
index 25f988b9c7cf..2e05083cbf29 100644
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


