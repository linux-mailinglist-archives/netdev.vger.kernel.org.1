Return-Path: <netdev+bounces-116372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2574094A317
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 10:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27CC9B2D47D
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 08:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C78F364A0;
	Wed,  7 Aug 2024 08:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="M2yY2/3w"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A751C9DF9;
	Wed,  7 Aug 2024 08:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723019403; cv=none; b=IPtqf5l6stD/9bSp3S1iM4BvSRiic5VMKOSTijiEs3tx1iX0sy9AaKC++8fW3qbBfOnSF5z51klhYiob7LNsoryvBNR1yKtJ9MHdWNnt3wUhVToKQ7Q9FfdB5rKmbpwD8DCo2wBovHCcKa3P1xs58pzGTStOAdt48yUr54oMtno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723019403; c=relaxed/simple;
	bh=pfjwYai1kDEFlMTRwq1zDwxzrf113UCZwO0Y3kDOyc4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=farmwUVOdP0rjYbzSsBCH3VicbQJ4EnMF/ZzuI7P/ESwbHCJjZBxZ/h9masZyzurIZUwmMOTZMEWBPcv5o1nXOYx9zY4iinBqh2rN8lShIsvladlGmN9TljjrgMJCtPvqod5xC7fGFqgZllqpn0DMDQ9B8KO2tG/LUslMxkk2Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=M2yY2/3w; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 30E31A050F;
	Wed,  7 Aug 2024 10:30:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=Ba0CST7W2CinJDo4EiMn
	4wDfsciaCg1eeQIJj73GLgM=; b=M2yY2/3w6JEsqO7f48Y3Ks4T3Jlfm4dCLv19
	YNx6dkipbwulcnrC1MOBskP27lNBIGaQsdIUilhAQjYDzEfJ+Cos8d5dAj1xt0O9
	E9S8knLX13wOXoosVOzhKSuxjqDf4fFIkpTlnw7UjM6jQe7Nn69PbmK5GMSXYeVt
	PyO0mikWaKdSumY/yPP9Aua1zndVfByVbLMoUugIwfKuPI/7DZRBrTKTjmB/roKt
	mj0ADJ+RKQ93Gz81//L5UhNqgvI9ioJVJCZb5GAvUVL2lLr/eg/y6Fe6FT3dgiTX
	opC3P9/6225x2PWMsTtCFzMC9j8/oR/yUBXA0eUI8Xhy8rPl47m5EOmL0AZo4CXV
	0tWIkJxtGT+X3vZ7PUrW1S930UXgjACPxB/KsAjpFFnHmUEExEbweNj6fAAcGnh4
	6fYggHzDxf86OKeOn61+q6isdx5hL7SR/BcPAMl/Rd5M3nvsEPG50VrhS6QGAPnz
	kln+a/f/8kZwy/Bhhb8zi4PYlafCe32nnk0eNNzX3H10xnLaclR3s/EKENYjpqKz
	Tf9+1Ytt2jlvX0HZtCx8B4/MooCbeby0P1g0qbKARNm3UFwiXouGG5A1131BEVyV
	izgXwoq7dsBJJ9uwbKNmadAoUCVRwosCmEfMsILUOr7uL5TfjGT8fDXOksujGOxH
	D7gCUAo=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <imx@lists.linux.dev>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, Wei Fang
	<wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH resubmit net 2/2] net: fec: Remove duplicated code
Date: Wed, 7 Aug 2024 10:29:19 +0200
Message-ID: <20240807082918.2558282-2-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807082918.2558282-1-csokas.bence@prolan.hu>
References: <20240807082918.2558282-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1723019399;VERSION=7975;MC=3677061131;ID=189168;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD94854617461

`fec_ptp_pps_perout()` reimplements logic already
in `fec_ptp_read()`. Replace with function call.

Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
---
 drivers/net/ethernet/freescale/fec_ptp.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
index fdbf61069a05..91b0804142e4 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -213,13 +213,7 @@ static int fec_ptp_pps_perout(struct fec_enet_private *fep)
 	timecounter_read(&fep->tc);
 
 	/* Get the current ptp hardware time counter */
-	temp_val = readl(fep->hwp + FEC_ATIME_CTRL);
-	temp_val |= FEC_T_CTRL_CAPTURE;
-	writel(temp_val, fep->hwp + FEC_ATIME_CTRL);
-	if (fep->quirks & FEC_QUIRK_BUG_CAPTURE)
-		udelay(1);
-
-	ptp_hc = readl(fep->hwp + FEC_ATIME);
+	ptp_hc = fec_ptp_read(&fep->cc);
 
 	/* Convert the ptp local counter to 1588 timestamp */
 	curr_time = timecounter_cyc2time(&fep->tc, ptp_hc);
-- 
2.34.1



