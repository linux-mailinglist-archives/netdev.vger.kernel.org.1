Return-Path: <netdev+bounces-161908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB29A248F2
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 13:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C19411885E57
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 12:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF0815A863;
	Sat,  1 Feb 2025 12:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="dG6wxZfy"
X-Original-To: netdev@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2327520318;
	Sat,  1 Feb 2025 12:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738412261; cv=none; b=IsJNeAkMRRRkn49oiKnBdmXDmfK289o/S0CNe7t++sS0aJBSkvl4ZD8hRzA36IsY5Lbz7qT05iG85l6U4uTeJLiPgQJ0Eju0MlKzec8XfOmzOF+4TSQEX5FAzJLLThsi6NEdAXTbbUqblSztUCmVmi0MEXFc7rF0hsOSvZUQ0Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738412261; c=relaxed/simple;
	bh=E7AIWVikmLx5OjWSac1buxR1TkYCXTtBgo8SmbamIYw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lMdHOEduqcrKM6dFlHL+TtcWG8mjuDYm9B5m/FBb9TqvO8EkT0Ld3TAezlFWqzs9vAjdCSBEznmN1O0EcDATc4vvsL5SbXpeoZKTJRkI+Pn6x6gJgmuiHl4nbB+XuHXPB8mYCkzE9rdYKtgvf48/KZF6pZ1XLZ1WOnM6jLyph6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=dG6wxZfy; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1738411807;
	bh=+F9e2eSKnh2+Y4iyTdF8FFqTluZvhsczOMsVqukdasQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=dG6wxZfybt+l+pgpPWlWswu882CC1eMmaP+4+fBlF1NrStZt/BsqbxMWlEsSnGyRv
	 bLgKUHm/ppMsEgSB6P8+zViETFSMUq9PIXup5jVL00zilC4i5s1Xn9wpe4W5EYns57
	 NXE7NkJwpiElw4Ja3WXgPJN2lP/KxlZQ3hHeaakU=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 8EE98665A5;
	Sat,  1 Feb 2025 07:10:03 -0500 (EST)
Message-ID: <54f00871f7f4043474a4e83bea6b8935fcf5af88.camel@xry111.site>
Subject: Re: [PATCH net v4 3/3] net: stmmac: Specify hardware capability
 value when FIFO size isn't specified
From: Xi Ruoyao <xry111@xry111.site>
To: Steven Price <steven.price@arm.com>, Andrew Lunn <andrew@lunn.ch>
Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, Alexandre Torgue	
 <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, Andrew
 Lunn	 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet	 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni	 <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Russell King	 <linux@armlinux.org.uk>, Yanteng
 Si <si.yanteng@linux.dev>, Furong Xu	 <0x1207@gmail.com>, Joao Pinto
 <Joao.Pinto@synopsys.com>, 	netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, 	linux-kernel@vger.kernel.org
Date: Sat, 01 Feb 2025 20:10:00 +0800
In-Reply-To: <915713e1-b67f-4eae-82c6-8dceae8f97a7@arm.com>
References: <20250127013820.2941044-1-hayashi.kunihiko@socionext.com>
	 <20250127013820.2941044-4-hayashi.kunihiko@socionext.com>
	 <07af1102-0fa7-45ad-bcbc-aef0295ceb63@arm.com>
	 <fc08926d-b9af-428f-8811-4bfe08acc5b7@lunn.ch>
	 <f343c126-fed9-4209-a18d-61a4e604db2f@arm.com>
	 <a4e31542-3534-4856-a90f-e47960ed0907@lunn.ch>
	 <d6265f8e-51bc-4556-9ecb-bfb73f86260d@arm.com>
	 <2ed9e7c7-e760-409e-a431-823bc3f21cb7@lunn.ch>
	 <915713e1-b67f-4eae-82c6-8dceae8f97a7@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-01-31 at 15:54 +0000, Steven Price wrote:
> On 31/01/2025 15:29, Andrew Lunn wrote:
> > On Fri, Jan 31, 2025 at 03:03:11PM +0000, Steven Price wrote:
> > > On 31/01/2025 14:47, Andrew Lunn wrote:
> > > > > > I'm guessing, but in your setup, i assume the value is never wr=
itten
> > > > > > to a register, hence 0 is O.K. e.g. dwmac1000_dma_operation_mod=
e_rx(),
> > > > > > the fifosz value is used to determine if flow control can be us=
ed, but
> > > > > > is otherwise ignored.
> > > > >=20
> > > > > I haven't traced the code, but that fits my assumptions too.
> > > >=20
> > > > I could probably figure it out using code review, but do you know
> > > > which set of DMA operations your hardware uses? A quick look at
> > > > dwmac-rk.c i see:
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* If the stmmac is not =
already selected as gmac4,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * then make sure w=
e fallback to gmac.
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!plat_dat->has_gmac4=
)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 plat_dat->has_gmac =3D true;
> > >=20
> > > has_gmac4 is false on this board, so has_gmac will be set to true her=
e.
> >=20
> > Thanks. Looking in hwif.c, that means dwmac1000_dma_ops are used.
> >=20
> > dwmac1000_dma_operation_mode_rx() just does a check:
> >=20
> > 	if (rxfifosz < 4096) {
> > 		csr6 &=3D ~DMA_CONTROL_EFC;
> >=20
> > but otherwise does not use the value.
> >=20
> > dwmac1000_dma_operation_mode_tx() appears to completely ignore fifosz.
> >=20
> > So i would say all zero is valid for has_gmac =3D=3D true, but you migh=
t
> > gain flow control if a value was passed.
> >=20
> > A quick look at dwmac100_dma_operation_mode_tx() suggests fifosz is
> > also ignored, and dwmac100_dma_operation_mode_rx() does not exist. So
> > all 0 is also valid for gmac =3D=3D false, gmac4 =3D=3D false, and xgma=
c =3D=3D
> > false.
> >=20
> > dwmac4_dma_rx_chan_op_mode() does use the value to determine mtl_rx_op
> > which gets written to a register. So gmac4 =3D=3D true looks to need
> > values. dwxgmac2_dma_rx_mode() is the same, so xgmac =3D true also need
> > valid values.
> >=20
> > Could you cook up a fix based on this?
>=20
> The below works for me, I haven't got the hardware to actually test the=
=20
> gmac4/xgmac paths:
>=20
> ----8<----
> > From 1ff2f1d5c35d95b38cdec02a283b039befdff0a4 Mon Sep 17 00:00:00 2001
> From: Steven Price <steven.price@arm.com>
> Date: Fri, 31 Jan 2025 15:45:50 +0000
> Subject: [PATCH] net: stmmac: Allow zero for [tr]x_fifo_size
>=20
> Commit 8865d22656b4 ("net: stmmac: Specify hardware capability value
> when FIFO size isn't specified") modified the behaviour to bail out if
> both the FIFO size and the hardware capability were both set to zero.
> However devices where has_gmac4 and has_xgmac are both false don't use
> the fifo size and that commit breaks platforms for which these values
> were zero.
>=20
> Only warn and error out when (has_gmac4 || has_xgmac) where the values
> are used and zero would cause problems, otherwise continue with the zero
> values.
>=20
> Fixes: 8865d22656b4 ("net: stmmac: Specify hardware capability value when=
 FIFO size isn't specified")
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
> =C2=A0drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> index d04543e5697b..821404beb629 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -7222,7 +7222,7 @@ static int stmmac_hw_init(struct stmmac_priv *priv)
> =C2=A0	if (!priv->plat->rx_fifo_size) {
> =C2=A0		if (priv->dma_cap.rx_fifo_size) {
> =C2=A0			priv->plat->rx_fifo_size =3D priv->dma_cap.rx_fifo_size;
> -		} else {
> +		} else if (priv->plat->has_gmac4 || priv->plat->has_xgmac) {
> =C2=A0			dev_err(priv->device, "Can't specify Rx FIFO size\n");
> =C2=A0			return -ENODEV;
> =C2=A0		}
> @@ -7236,7 +7236,7 @@ static int stmmac_hw_init(struct stmmac_priv *priv)
> =C2=A0	if (!priv->plat->tx_fifo_size) {
> =C2=A0		if (priv->dma_cap.tx_fifo_size) {
> =C2=A0			priv->plat->tx_fifo_size =3D priv->dma_cap.tx_fifo_size;
> -		} else {
> +		} else if (priv->plat->has_gmac4 || priv->plat->has_xgmac) {
> =C2=A0			dev_err(priv->device, "Can't specify Tx FIFO size\n");
> =C2=A0			return -ENODEV;
> =C2=A0		}

Works for me on TH1520 (arch/riscv/boot/dts/thead/th1520.dtsi).

Tested-by: Xi Ruoyao <xry111@xry111.site>

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

