Return-Path: <netdev+bounces-199408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D2DAE02B7
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 12:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 685BA3B2157
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 10:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2EC223302;
	Thu, 19 Jun 2025 10:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="Nw2ZDB1M"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752AF221DA5;
	Thu, 19 Jun 2025 10:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750329161; cv=none; b=PpvcC4Gc10sb7fI6ReoN6WNynH1o7zS95nVd7xvtfBCi6onObfta5DjRwwVoQY1brgceOeXamfny98lRyB/zxj3N5M4y+rFGEoNLUprKHsbptUK8y5RRAH/oYjosXrRpQZRM3w+QrNQh/nM9lrGMZyRP4DlMTBUBxXe/cEhAUW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750329161; c=relaxed/simple;
	bh=R85HTAitpNtPtiN/A06M7DxLOGRv35n/I0Z6WFxnOII=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date:
	 In-Reply-To:References; b=DSwq4V5Gw/eia/lvHEkn4nsDThEMBRsE2hE/R94JcHn9HZ/4nWESVMHbv4Jez93JNbLZwm1rNXZJ7sOMkyaZYnjjtHgBOFxwF2HmbjPyqrxfhF4zCfQ/VbOsPvBFaag8ImTKLvgpPrddNLH7g0HNnOISHwAGg1O9tHcQ/Bfb40w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=Nw2ZDB1M; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1750329125; x=1750933925; i=frank-w@public-files.de;
	bh=OcYH8hblyOqphSxkfLeFjpUcClvEpIu8NxtFsTsW5Nw=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:Date:In-Reply-To:References:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Nw2ZDB1MJgjSypAStXwuh1Gbt5FKe1o2iDNYFgB1Mb38X1cBM9/DUysb1uHHLEpL
	 tUjH9krcooMov1LXLi6BTJfbuC4HVG2c2/gqkh95BFC5OQCJaU8SKZbzpxI0ngiqq
	 Mu+mOgQYjGcQFggN3UnUq78OEOjA2g9sWXrCpjmfXO+Qq/ArF2qjUo39VS5vIZgFG
	 wrynAUod06o9TDLTYIo9xGId/GX3KQoh8XTrRq7bPlqjZWwq7egt5ti6xhuLI6jUH
	 QauFfSnJ9zjX8zG8+mxrpOmWVwifPWr2AlQkHaXu8uZ30kqeFgi/vdxO2u7qD2IG2
	 UcenJ0Tpj7apFQo2Ug==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [100.64.250.227] ([100.64.250.227]) by
 trinity-msg-rest-gmx-gmx-live-b647dc579-9795v (via HTTP); Thu, 19 Jun 2025
 10:32:05 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-98eee496-129f-43c7-8d3f-4a77f4a183b9-1750329125336@trinity-msg-rest-gmx-gmx-live-b647dc579-9795v>
From: Frank Wunderlich <frank-w@public-files.de>
To: horms@kernel.org, linux@fw-web.de
Cc: nbd@nbd.name, sean.wang@mediatek.com, lorenzo@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, daniel@makrotopia.org,
 arinc.unal@arinc9.com
Subject: Aw: Re: [net-next v5 3/3] net: ethernet: mtk_eth_soc: skip first
 IRQ if not used
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Jun 2025 10:32:05 +0000
In-Reply-To: <20250619100309.GC1699@horms.kernel.org>
References: <20250618130717.75839-1-linux@fw-web.de>
 <20250618130717.75839-4-linux@fw-web.de>
 <20250619100309.GC1699@horms.kernel.org>
X-UI-CLIENT-META-MAIL-DROP: W10=
X-Provags-ID: V03:K1:ifZaB0TqILOfFP6+5o3LfKPHICLlxtenulQfOOEgY2f7tACewlBl3QLnsAj1aMLZYtvH6
 npjRu0EOI51tAGdS9VkCwnbATYO+ViMaRfHy0GeW3oHCqjXq2X0EYFFF/2jxfEuwKq46BGz05UKu
 GKZDt+Qva4mWA9Dk14indJ8u5jWlEWhPkSjyrsIgWl7eQk7ngpQ8ACY327QoBnIHw7RSyZ6q1kCR
 ht9Hn9Zk2u0Bz3Sw2jVbc1iW2A8/3K/1W7+B8j8hhW14tZRd+hMWNokDLsjCeve8ThOTO5SWJkWF
 8fTQ48zmuNnOSPwKxv+9VXdWh6QWqBU5SaRA6u746ln8ZDQ2fvBpb7C1yJiCU9XX8Q=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hCRhkC8HBc4=;DGXBDvuDhiJCdGE8BCakk/+Hi/v
 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
Content-Transfer-Encoding: quoted-printable

Hi Simon

> Gesendet: Donnerstag, 19. Juni 2025 um 12:03
> Von: "Simon Horman" <horms@kernel.org>
> Betreff: Re: [net-next v5 3/3] net: ethernet: mtk_eth_soc: skip first IR=
Q if not used
>
> On Wed, Jun 18, 2025 at 03:07:14PM +0200, Frank Wunderlich wrote:
> > From: Frank Wunderlich <frank-w@public-files.de>
> >=20
> > On SoCs without MTK_SHARED_INT capability (all except mt7621 and
> > mt7628) platform_get_irq() is called for the first IRQ (eth->irq[0])
> > but it is never used.
> > Skip the first IRQ and reduce the IRQ-count to 2.
> >=20
> > Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> > ---
> > v5:
> > - change commit title and description
> > v4:
> > - drop >2 condition as max is already 2 and drop the else continue
> > - update comment to explain which IRQs are taken in legacy way
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>

thank you very much

i guess RB is still valid with changes requested by Daniel?

    net: ethernet: mtk_eth_soc: skip first IRQ if not used
   =20
    On SoCs with dedicated RX and TX interrupts (all except MT7621 and
    MT7628) platform_get_irq() is called for the first IRQ (eth->irq[0])
    but it is never used.
    Skip the first IRQ and reduce the IRQ-count to 2.

code (changed condition "if (i =3D=3D MTK_FE_IRQ_SHARED)")
        for (i =3D 0; i < MTK_FE_IRQ_NUM; i++) {
-               if (MTK_HAS_CAPS(eth->soc->caps, MTK_SHARED_INT) && i > 0)
-                       eth->irq[i] =3D eth->irq[MTK_FE_IRQ_SHARED];
-               else
-                       eth->irq[i] =3D platform_get_irq(pdev, i);
+               if (MTK_HAS_CAPS(eth->soc->caps, MTK_SHARED_INT)) {
+                       if (i =3D=3D MTK_FE_IRQ_SHARED)
+                               eth->irq[MTK_FE_IRQ_SHARED] =3D platform_g=
et_irq(pdev, i);
+                       else
+                               eth->irq[i] =3D eth->irq[MTK_FE_IRQ_SHARED=
];
+               } else {
+                       eth->irq[i] =3D platform_get_irq(pdev, i + 1);
+               }

regards Frank

