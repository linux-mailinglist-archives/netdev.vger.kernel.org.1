Return-Path: <netdev+bounces-117146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 320DB94CDDE
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 11:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E51C6281005
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 09:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E88619EEBF;
	Fri,  9 Aug 2024 09:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="bJiwDo2g"
X-Original-To: netdev@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E7219E7F9;
	Fri,  9 Aug 2024 09:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723196894; cv=none; b=phRlzprTPWeL1LMwoNI2s2s1p3UXXSmGgvEFsoHVTr1ZTioeIidHwv4QXvW/o8yZuy8aFO0UbrU5sXgovTkmLe2gwgKF2BnYB6Bny0pwLDj5sEH3vRDnugGZpNHgfB2AZAr+cuOWfxvaRM18f2T6iVrF07Dls4o9TMvXk+csQBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723196894; c=relaxed/simple;
	bh=JfrSTDupAEFNzJ0NTGgYxinFFwD+sj0VT9HNe7eYu8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gXtMJ+e8eyosC0BHobjG3HiaFiSrmxVNJ3gDg0bNQWf/Y8tS1qYRJZyXudmqai/4tdk3Sdl86z6vUkW6IHqjh5NQFEIt/pSKCeduowc4WkedDNFjvir7GPxkQGnM+2WTiU+V/aQz4mE0qNzIogkrdjBUwk/VAPttcqXVPdqkL8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=bJiwDo2g; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id AD3E822295;
	Fri,  9 Aug 2024 11:48:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1723196891;
	bh=EUM89Z92ylZOhefElMUwK8siDmQ2624apyQbZLSedCM=; h=From:To:Subject;
	b=bJiwDo2gIv83wOVzcz+S1rzJiPKEUefi0EoEDJ133lkgcwlHWlauDehQNc6TKy95q
	 cLUjJ2y9QnLOxIbEPxno5fjQPaK3ggciUr7Oao6PtzqklcI3WOMbFH7J1oCc0LvqF9
	 +anlp4PRUXfcBLsPjKVY/fb7Cl5tvKkSFAjM71lhTEQ8RCiCUrg9QcbjFNJM558wiC
	 kZWpgrEJYS+CUXQaQRbnlEN/v2DUhuS6N2kwnvPO0OK52ABKOSMyZ5b0PTqC0Hevn/
	 B6NyHD1UjjJI1f0/HwOMj//273XxrWlYIC+NKQl8FovT9qF5fPQoaivXNrsJajOMlc
	 Hd4k8FDCFxGVA==
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
Subject: [PATCH net-next v3 3/3] net: fec: make PPS channel configurable
Date: Fri,  9 Aug 2024 11:48:04 +0200
Message-Id: <20240809094804.391441-4-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240809094804.391441-1-francesco@dolcini.it>
References: <20240809094804.391441-1-francesco@dolcini.it>
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
v3: added net-next subject prefix
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


