Return-Path: <netdev+bounces-70996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEBC85183D
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 16:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12B122866A9
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 15:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8553C47A;
	Mon, 12 Feb 2024 15:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="AloD6gos"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D328D3C088
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 15:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707752281; cv=none; b=feRgbJD+Ra9OMyxT639krZVvsM9lRJ6rzbMq5lfuX4oUaQxEwlItKTGCsRJ4aJ7Pah4esDObgzRGqWMAw85N769ktcDOdCGqkkE/hRC67uV6k44S6kh149d7tk5VFJjSngL+fb7V8xaGo14Fs8pp+t3eaClZUDIhEqP7Yd3Y6hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707752281; c=relaxed/simple;
	bh=A9DNA7kWq3oEGOVZou5927ByRhdtpHAtenaH9pmfwxw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SmXUQMyVVe6tfmK2AkdMXS5m3+aSMsSAVX9ghOK19Ntkv8RHDDmYyxQlBo5s8MC2CK9insiG6f7EOOp2eThhO+jyBo4Bl+hv04FOt6psewwGBKwYpsYmognwhbJ1fUPIu6qYbcdyBzNdb3aXuVXZyA0+pA3zHfBtyvH3Xhtj5bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=AloD6gos; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 2E2A2A02FA;
	Mon, 12 Feb 2024 16:37:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=16+QpPBtUhBKi6LOHpBB
	NLQcxXsGspRFs8sxqjcbNXQ=; b=AloD6gosY3OasY9fAaOMIxoZYS6qdZtWJAkF
	bL+oOYwBQB/fMcmpU662bvApT5oHTH5gyXLp+ZBCiaqbk4Elqznj8RlOBjgYzqVb
	/2Ko5DwHgRgT+Gn9YhfTzGtfTIL7G5uToPC+I5pm6ZV/SO7JKh17Lv1aZpXqHizS
	53U/tPOCMD/6mayUsu5o58aTNu10d1a0uq9zsu8Rn8bo6Oo1zhy+5EyWx01vBT+9
	4sU/9c0gr4/ZS94cdkOXHeySTDcCzrN4sWce9jtsNTcNXSHvdD+1kH4Y0ghuAYZs
	4QwbDe6cn0QDuXJEgLgNbWHIhUpcWekHBv4FIRww3UF6q+72uk6ZcWJaV88kY219
	o6Deg8v9SsOdYnEcJT1NaMEQ9DZIzKcQGOIKAHzlbrwfzde518cgwNpCWrh7pM34
	85v4u1ahtf7eSkR+6M5fsLTuxHQXxNjOe3bAmlW20R8NKicIMmEaKoCdjdoSxRfM
	DWHCUHJVfeXwBD1NSZ2loebSTcw3Ouuyvg+ihMNwET9v8jxtv0FmkF1GGbaEyssh
	HnA/HP5H+FTMKikPQ2VNQQTzk3kwxCTGMgR7J2OXe8XdQ15v29UIhAfoMLpBqHpY
	RF+aQvN3hLKtUjbB5tHEiGx0dQn8uWIaU1PBEEAQZnt9EFKpnEF2Iud3V1GnrTCC
	VIz2kgg=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>
To: <netdev@vger.kernel.org>
CC: Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, NXP Linux Team <linux-imx@nxp.com>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Francesco Dolcini
	<francesco.dolcini@toradex.com>, Andrew Lunn <andrew@lunn.ch>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, Denis Kirjanov <dkirjanov@suse.de>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>
Subject: [PATCH net-next v4 2/2] net: fec: Refactor: Replace FEC_ENET_FCE with FEC_RCR_FLOWCTL
Date: Mon, 12 Feb 2024 16:37:19 +0100
Message-ID: <20240212153717.10023-2-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240212153717.10023-1-csokas.bence@prolan.hu>
References: <20240212153717.10023-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1707752276;VERSION=7967;MC=1325273951;ID=761215;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29916D3B55617C60

FEC_ENET_FCE is the Flow Control Enable bit (bit 5) of the RCR.
This is now defined as FEC_RCR_FLOWCTL.

Signed-off-by: Csókás Bence <csokas.bence@prolan.hu>
---

Notes:
    Changes in v4:
    * factored out the removal of FEC_ENET_FCE
    
    Changes in v3:
    * remove `u32 ecntl` from `fec_stop()`
    * found another ETHEREN in `fec_restart()`

 drivers/net/ethernet/freescale/fec_main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 52c674ecbebf..84f24a0fe278 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -85,8 +85,6 @@ static int fec_enet_xdp_tx_xmit(struct fec_enet_private *fep,
 
 static const u16 fec_enet_vlan_pri_to_queue[8] = {0, 0, 1, 1, 1, 2, 2, 2};
 
-/* Pause frame feild and FIFO threshold */
-#define FEC_ENET_FCE	(1 << 5)
 #define FEC_ENET_RSEM_V	0x84
 #define FEC_ENET_RSFL_V	16
 #define FEC_ENET_RAEM_V	0x8
@@ -1196,7 +1194,7 @@ fec_restart(struct net_device *ndev)
 	if ((fep->pause_flag & FEC_PAUSE_FLAG_ENABLE) ||
 	    ((fep->pause_flag & FEC_PAUSE_FLAG_AUTONEG) &&
 	     ndev->phydev && ndev->phydev->pause)) {
-		rcntl |= FEC_ENET_FCE;
+		rcntl |= FEC_RCR_FLOWCTL;
 
 		/* set FIFO threshold parameter to reduce overrun */
 		writel(FEC_ENET_RSEM_V, fep->hwp + FEC_R_FIFO_RSEM);
@@ -1207,7 +1205,7 @@ fec_restart(struct net_device *ndev)
 		/* OPD */
 		writel(FEC_ENET_OPD_V, fep->hwp + FEC_OPD);
 	} else {
-		rcntl &= ~FEC_ENET_FCE;
+		rcntl &= ~FEC_RCR_FLOWCTL;
 	}
 #endif /* !defined(CONFIG_M5272) */
 
-- 
2.25.1



