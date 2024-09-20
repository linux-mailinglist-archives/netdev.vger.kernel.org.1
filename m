Return-Path: <netdev+bounces-129051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFD697D38E
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 11:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 295F4289192
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 09:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7063513AD06;
	Fri, 20 Sep 2024 09:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="h06ZOlvD"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A048313A26F;
	Fri, 20 Sep 2024 09:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726824230; cv=none; b=e1dog91ezygIKGaxsCRzE6x5rPORLLyEuI0tJsYKOlLj3lBpTHkznNAYe7FsFt4/U9ZfE+R/BA7qBlkHDCz/tsAoAdjOAShDDwn8x53IWSYsygCO531UWvaxZHMxUHaiCmf36LAACsVDT42aqwnWC6f3ePxnMhuM0PQ911MRA7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726824230; c=relaxed/simple;
	bh=z7EK3Y+jI+Y9vSsJ8RV5RD3d8BgZdIrppSI6/TWCLPM=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=nV4do8dwy5v/OuwdGYTLXre/duXB7Gj+8Iwxq1QEbHJZw/VK4WmEzLtOV/og9DMDqBgacMnk1sqD2gInVcWC/FBMmE3+T3adnXeCVie9NVSETAoPqHO4kXIWd73Ja2AatviMbyEafHylYYI/TCESnCTMKfhBteqQVIE11sFT+aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=h06ZOlvD; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1726824180; x=1727428980; i=markus.elfring@web.de;
	bh=0nNySQPv5JuvvUtnUvrue6tL+e8BSoi+EfKgAvmGzsI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=h06ZOlvDpqKN9GEI6OZpQjV7HDyzb5JY+L8OmetS07KvIwK9pAHfbbwoGhxrKbJ/
	 rPQjrVS4OHjhlr4+k/tE5JRtWNfe1E0I0jMQKArNXNrVfj4uN0XgZ3mc+Gzu7lnfZ
	 OsjzaoFrXN8EPZ6ihqadVZ5jks6slmtCkxyyds5arz6+ra8U1lu70zeRJATPbPnzN
	 6Zgtbm1i90EXfP3gbnKJZAv4/LVkdr00ncgm9G7IaZJZuMm2N9Q4IIMjmjyOYEK2R
	 7tqsKlxeKSG4KrQiLYpKtfjFmIp0y54l+S2FnCF4EuuT1VSusLMO+W28qXMZQxUbx
	 xMy8sShQwWNMajJ3PQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M91Po-1svP4E05Sw-009s7C; Fri, 20
 Sep 2024 11:23:00 +0200
Message-ID: <2e6f6f8f-89de-4b75-a0af-3a55bc046ab7@web.de>
Date: Fri, 20 Sep 2024 11:22:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Andy Chiu <andy.chiu@sifive.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Michal Simek <michal.simek@amd.com>, Paolo Abeni <pabeni@redhat.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Sean Anderson <sean.anderson@linux.dev>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] net: xilinx: axienet: Reduce scopes for two resources in
 axienet_probe()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4TFXBdP/6ppeVrRdSDKHEfkmbT/q5U55VcdfqXXjsKvxrj4eEXo
 kWDIihbCgMzIicmxVfxxuPDNbibnklTw5H1Edwnskbp+uC26PMd2wLBHC0OGkH7DwBywFtP
 qkgYT70FOAuv8iuoDnW11YwXEkxTyYoKFbr09y49dapy2qmvBhXhAjCmH//nZ7zly4HwR6F
 /gojlhYsSlRIDhCNxIZmg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:X7tOIUn4bU0=;1LorCimN8vn4JkCAiX8UOd23rws
 M7+uwCuqghvLX2Zht/5EmNBL7lr7ER9Ln6No0Vl/MsJzya5DAkH+fo/MI89ysAvFrgzdN17uW
 LOo4adbutwdio3PWz8jOj0tu31p7o8egRZpcV7bL1c/ZOpPX/yQZASUMjhBTckIUJai05gzTq
 ZMw1fALTx1A5f9/Ws7XaiZoSUrHaZdtZ1t+9VK52hM3Sf1oEeT1T9EO4LKi+Xa5olaZMV+y9d
 ugDbAYCZudQK8DJvYUvVJH1qjorB3c7c6qqGpVv9p2FmAmjIEl1JkEsyV9/Hsjeln0Jvb4dwT
 aLezLOBQUsMxtc79/Z+aNFGz37T2417RZS0K321PV7JUp9QBPIAA5CncP+/DeJ0CvEfHXw5NS
 Cr4L9pOtcT7ToPojiG8HelAKwP7YiJ7Al4Phgl09hKrhJzYKeKZt7rYmrT/rYMjBoiJckd03D
 qXr3Avikvqis+4I0yW1dooPbYtwO63kj2jPZIkKIkUKswRbb8LKcrA4QhvYd3iIjoN5hms9/u
 LMOhRwCNS2lvJoMHoM1NEzlFiGkuIdjsBANKVcxEtHI0RwNTlbV6ZncZ2I+ZM3avlhzTT0kEE
 YSBtF3bxs7X5ikPO8zolWmKF/hn2vq4S6ZJeFE3/FdsRvLrIMewfxUlKIoYXp7S9eK7iVRiZJ
 2NOALEMHg70q7/C7R20ewptkeRo47D0ouZ/VUvd+Dcb3PNARZudgzNYLR4Nq3fa2QibpUpP6Y
 6nqbmSirpQ7weoELnfEmlIdbpGCX0DbKc4zkgMnzz1WPfHYhg/UEjXuLC0KkTXrA3ugMhWGFP
 NdTt2n41GhI+XgvbZglbELzA==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 20 Sep 2024 11:08:10 +0200

The calls =E2=80=9Cdma_release_channel(tx_chan)=E2=80=9D and =E2=80=9Cof_n=
ode_put(np)=E2=80=9D
were immediately used after return value checks in this
function implementation.
Thus use such function calls only once instead directly before the checks.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/n=
et/ethernet/xilinx/xilinx_axienet_main.c
index ea7d7c03f48e..e3d9801ad17e 100644
=2D-- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -2806,13 +2806,12 @@ static int axienet_probe(struct platform_device *p=
dev)
 		cfg.reset =3D 1;
 		/* As name says VDMA but it has support for DMA channel reset */
 		ret =3D xilinx_vdma_channel_set_config(tx_chan, &cfg);
+		dma_release_channel(tx_chan);
 		if (ret < 0) {
 			dev_err(&pdev->dev, "Reset channel failed\n");
-			dma_release_channel(tx_chan);
 			goto cleanup_clk;
 		}

-		dma_release_channel(tx_chan);
 		lp->use_dmaengine =3D 1;
 	}

@@ -2860,12 +2859,12 @@ static int axienet_probe(struct platform_device *p=
dev)
 			goto cleanup_mdio;
 		}
 		lp->pcs_phy =3D of_mdio_find_device(np);
+		of_node_put(np);
 		if (!lp->pcs_phy) {
 			ret =3D -EPROBE_DEFER;
-			of_node_put(np);
 			goto cleanup_mdio;
 		}
-		of_node_put(np);
+
 		lp->pcs.ops =3D &axienet_pcs_ops;
 		lp->pcs.neg_mode =3D true;
 		lp->pcs.poll =3D true;
=2D-
2.46.0


