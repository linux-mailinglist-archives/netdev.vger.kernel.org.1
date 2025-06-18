Return-Path: <netdev+bounces-198962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E563AADE6E4
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 11:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 544B9188F27B
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 09:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C31284B4E;
	Wed, 18 Jun 2025 09:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="RXinS2s4"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51FB28468C;
	Wed, 18 Jun 2025 09:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750238722; cv=none; b=rPXgNZo649txbt/PDGP/uu3toDLaMv5WGbjmYG+ouElghKk8BQ+kGpVu2Dvy/DHvcqutMTyZRtm6wbcFO8vN4DyeOG2Jto1y3GfhJvfGd43+vFU2FCGDt0WsB5PYhs8splKCrbsvovsUXcZy2lV7j0X6UnDld7wqPD3i8h9N4bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750238722; c=relaxed/simple;
	bh=QMiZQXO2s15SivKQEmdA9dLxjnHUl+vQ8Bh2DEFw1Ws=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date:
	 In-Reply-To:References; b=PEPlA2oh8lM8LsbDOfErcHr7tfUWk0rAdRDL9xgmk7NIF8bemn08iLol2S6nrr1uVqvPBT++yjBwWP4Cs4MsAvjTSXcBnH0sJdY0j+tYfHNLtePR7W+5mnjG89LOPetZuLBjly3Oh4bvkvslXBhDKQvwmuL9CGxJq5jP5VVe6RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=RXinS2s4; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1750238697; x=1750843497; i=frank-w@public-files.de;
	bh=GxgvbzOVdrAxEczG7xt+lBT38YUbQ/6F50glMQK2gS8=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:Date:In-Reply-To:References:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=RXinS2s4dUx7F0b10RU0gjtLMM/jHOobjIwjR7+FFu0k21bTFRS6s1wR1la+tfS4
	 iSNXB2EoSRieOFm6DTbNXATK/JioDvA1uWGi1dTpKn9llWpq7iKoaE3Q/6O6x3pYB
	 yhP5QabHmfeDXHsXckEkqRhtHTUBHOmuDut6K+AfaaLXD4oh/7pyGeTs86A6DTYQX
	 UuxAAwdirs1IAjnj4PqQzKxuZYF4f9F1AwgCRa4q2TQhGGgtvWFY0EzZBgoTFntt0
	 stLhUN6MjTaGPKkZwnDCC8rKQ3DgyjLfirHTkw+t9/jNEEL21VXl8asksh22Y5Bdu
	 nDzJJBzqdSn7h1t5iQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [100.71.197.97] ([100.71.197.97]) by
 trinity-msg-rest-gmx-gmx-live-b647dc579-2m42j (via HTTP); Wed, 18 Jun 2025
 09:24:57 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-86a5b58b-a74a-48be-80ae-aa306e95f214-1750238697100@trinity-msg-rest-gmx-gmx-live-b647dc579-2m42j>
From: Frank Wunderlich <frank-w@public-files.de>
To: horms@kernel.org, linux@fw-web.de
Cc: nbd@nbd.name, sean.wang@mediatek.com, lorenzo@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, daniel@makrotopia.org,
 arinc.unal@arinc9.com
Subject: Aw: Re: [net-next v4 2/3] net: ethernet: mtk_eth_soc: add consts
 for irq index
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Jun 2025 09:24:57 +0000
In-Reply-To: <20250618083623.GF2545@horms.kernel.org>
References: <20250616080738.117993-1-linux@fw-web.de>
 <20250616080738.117993-3-linux@fw-web.de>
 <20250618083623.GF2545@horms.kernel.org>
X-UI-CLIENT-META-MAIL-DROP: W10=
X-Provags-ID: V03:K1:hP8Ld9j2b2oQo62lTxD2sCQh/QnH0JXI+WPy/BMcds2Ntuk8dEcRGZiuxLul4i8uviVP/
 Gc3OpxiyxTkJ5snhLk27+9yx6JOkwGE8tx83eeW+ww+ekrhnEJBeajVyVfcJoamUQrrTOhlcYuba
 9GSVI/xPIiORJOgwP/t+pM7SZouPHN//M4Lqdnnz9i0NwgcEDHqPwm+t/XmBkcyf/faxCjU7Vpwg
 vxcPLEC25tlWBrU+sMVA3c4UtEBBBukS+CTBVxzGpXR1pxyPX7GUJiaXqfrmOLBaXHiLVIeX40Ld
 eAqo2c6X98jWbXosLybPPrGBZeIt0MHrQgSCN6M2xP6GHQsZWy+VgOy2bCU50VJIe4=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:N5Nc5QCAEMY=;gkTcsL6tpsiJN4jeXPaqRfUbu6v
 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
Content-Transfer-Encoding: quoted-printable

Hi,

> Gesendet: Mittwoch, 18. Juni 2025 um 10:36
> Von: "Simon Horman" <horms@kernel.org>
> Betreff: Re: [net-next v4 2/3] net: ethernet: mtk_eth_soc: add consts fo=
r irq index
>
> On Mon, Jun 16, 2025 at 10:07:35AM +0200, Frank Wunderlich wrote:
> > From: Frank Wunderlich <frank-w@public-files.de>
> >=20
> > Use consts instead of fixed integers for accessing IRQ array.
> >=20
> > Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> > ---
> > v4:
> > - calculate max from last (rx) irq index and use it for array size too
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>

thanks for review and the RB

i thinking about changing the const names to this:

MTK_ETH_IRQ_SHARED	=3D> MTK_FE_IRQ_SHARED
MTK_ETH_IRQ_TX		=3D> MTK_FE_IRQ_TX
MTK_ETH_IRQ_RX		=3D> MTK_FE_IRQ_RX
MTK_ETH_IRQ_MAX		=3D> MTK_FE_IRQ_NUM

because of i currently working on RSS/LRO patches and here MTK_FE_IRQ_NUM =
is used as name=20
with same meaning like my current MTK_ETH_IRQ_MAX (where max should be sam=
e as RX and NUM
is one more because it is a count).
Current IRQs also target the MTK frame-engine which is different to the PD=
MA RX engine
used for RSS/LRO later, so MTK_ETH_IRQ_RX and MTK_ETH_IRQ_MAX are maybe mi=
sleading when RSS/LRO=20
support will come in.

can i change the consts like this and keep your RB?

regards Frank

