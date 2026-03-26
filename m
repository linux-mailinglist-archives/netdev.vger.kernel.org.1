Return-Path: <netdev+bounces-272173-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +C5vHglvxWl1+AQAu9opvQ
	(envelope-from <netdev+bounces-272173-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 18:38:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5C9339430
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 18:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 401D23007899
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 17:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DC9423153;
	Thu, 26 Mar 2026 17:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="oDctDRaT"
X-Original-To: netdev@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2996F426EB8
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 17:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774546304; cv=none; b=XYUPNvY1PQKw3NmriwRotN96Xa2k03R1MJ4NMFG7sLQdcjJ0WpG6mdS5/zkq5yGKkJ1LjJkRg80HA1bIlcDY7Fpzx8+CrF278H5e76TcvMwfKswKt2LD78p6yRdKjmDEKACyr8XhdXbOigEMQCKwoLy3VuRmkk0N2VXYXI5WCGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774546304; c=relaxed/simple;
	bh=mHuz9dD/zD769Vzc3Oy2YrsHQDGOSHJorSKK6FwAkVo=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=pSqWUxRXLkl8BvQD+BO2h/IZO7z5nzKwRWCBV5TNkECt88GnZQmHJdgWv3Qai+h9fKsusejSqOdU3+r/3lMC1T5sU/oncQOfvHv4dhcvDxw6e4NQRualudZF4lgVqRZTvOVwsCUMZMmQyhQylxsZfSOdiaozCVwXSsNsZBwubxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=oDctDRaT; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from monstersaurus.ideasonboard.com (cpc89244-aztw30-2-0-cust6594.18-1.cable.virginm.net [86.31.185.195])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id CA2779A9;
	Thu, 26 Mar 2026 18:30:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1774546212;
	bh=mHuz9dD/zD769Vzc3Oy2YrsHQDGOSHJorSKK6FwAkVo=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=oDctDRaTumN+rKqm1apL6hQ5EeJKBozOuxXux4FR1BLSspMbcjhIASsgEkGV0F3K4
	 S9wn6jEcBNcS5x2bsCtPTCRMYaP/XciJ/0RN0C/0I4+YSEXceKjAw6XVpioelgjzBV
	 +jPuoWkcfkVapeJfhzE/BMxSFi8DeArKke7dxYgs=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260325210003.2752013-2-laurent.pinchart@ideasonboard.com>
References: <20260325210003.2752013-1-laurent.pinchart@ideasonboard.com> <20260325210003.2752013-2-laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH net-next v4 1/2] net: stmmac: provide flag to disable EEE
From: Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Fabio Estevam <festevam@gmail.com>, Francesco Dolcini <francesco.dolcini@toradex.com>, Frank Li <Frank.Li@nxp.com>, Jakub Kicinski <kuba@kernel.org>, Joy Zou <joy.zou@nxp.com>, Marco Felsch <m.felsch@pengutronix.de>, Paolo Abeni <pabeni@redhat.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Stefan Klug <stefan.klug@ideasonboard.com>, linux-arm-kernel@lists.infradead.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, imx@lists.linux.dev, netdev@vger.kernel.org
Date: Thu, 26 Mar 2026 17:31:29 +0000
Message-ID: <177454628933.1078312.13488207016388509694@ping.linuxembedded.co.uk>
User-Agent: alot/0.9.1
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ideasonboard.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[ideasonboard.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272173-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,gmail.com,toradex.com,nxp.com,kernel.org,pengutronix.de,redhat.com,armlinux.org.uk,ideasonboard.com,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kieran.bingham@ideasonboard.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[ideasonboard.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,ideasonboard.com:dkim,ideasonboard.com:email,renesas.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AB5C9339430
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Quoting Laurent Pinchart (2026-03-25 21:00:02)
> From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
>=20
> Some platforms have problems when EEE is enabled, and thus need a way
> to disable stmmac EEE support. Add a flag before the other LPI related
> flags which tells stmmac to avoid populating the phylink LPI
> capabilities, which causes phylink to call phy_disable_eee() for any
> PHY that is attached to the affected phylink instance.
>=20
> iMX8MP is an example - the lpi_intr_o signal is wired to an OR gate
> along with the main dwmac interrupts. Since lpi_intr_o is synchronous
> to the receive clock domain, and takes four clock cycles to clear, this
> leads to interrupt storms as the interrupt remains asserted for some
> time after the LPI control and status register is read.
>=20
> This problem becomes worse when the receive clock from the PHY stops
> when the receive path enters LPI state - which means that lpi_intr_o
> can not deassert until the clock restarts. Since the LPI state of the
> receive path depends on the link partner, this is out of our control.
> We could disable RX clock stop at the PHY, but that doesn't get around
> the slow-to-deassert lpi_intr_o mentioned in the above paragraph.
>=20
> Previously, iMX8MP worked around this by disabling gigabit EEE, but
> this is insufficient - the problem is also visible at 100M speeds,
> where the receive clock is slower.
>=20
> There is extensive discussion and investigation in the thread linked
> below, the result of which is summarised in this commit message.

This one has been a roller coaster, but I'm glad we got to the bottom of
it.

I hope someone from synopsis takes note and and documents this for
future silicon integrations.

Can't wait to see where else this pops up.


Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>

>=20
> Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Closes: https://lore.kernel.org/r/20251026122905.29028-1-laurent.pinchart=
@ideasonboard.com
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Tested-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |  7 ++++++-
>  include/linux/stmmac.h                            | 13 +++++++------
>  2 files changed, 13 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> index 9b6b49331639..ce51b9c22129 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -1438,7 +1438,12 @@ static int stmmac_phylink_setup(struct stmmac_priv=
 *priv)
>                                  config->supported_interfaces,
>                                  pcs->supported_interfaces);
> =20
> -       if (priv->dma_cap.eee) {
> +       /* Some platforms, e.g. iMX8MP, wire lpi_intr_o to the same inter=
rupt
> +        * used for stmmac's main interrupts, which leads to interrupt st=
orms.
> +        * STMMAC_FLAG_EEE_DISABLE allows EEE to be disabled on such plat=
forms.
> +        */
> +       if (priv->dma_cap.eee &&
> +           !(priv->plat->flags & STMMAC_FLAG_EEE_DISABLE)) {
>                 /* The GMAC 3.74a databook states that EEE is only suppor=
ted
>                  * in MII, GMII, and RGMII interfaces.
>                  */
> diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> index 5b2bece81448..e62d21afd56d 100644
> --- a/include/linux/stmmac.h
> +++ b/include/linux/stmmac.h
> @@ -207,12 +207,13 @@ enum dwmac_core_type {
>  #define STMMAC_FLAG_MULTI_MSI_EN               BIT(7)
>  #define STMMAC_FLAG_EXT_SNAPSHOT_EN            BIT(8)
>  #define STMMAC_FLAG_INT_SNAPSHOT_EN            BIT(9)
> -#define STMMAC_FLAG_RX_CLK_RUNS_IN_LPI         BIT(10)
> -#define STMMAC_FLAG_EN_TX_LPI_CLOCKGATING      BIT(11)
> -#define STMMAC_FLAG_EN_TX_LPI_CLK_PHY_CAP      BIT(12)
> -#define STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY   BIT(13)
> -#define STMMAC_FLAG_KEEP_PREAMBLE_BEFORE_SFD   BIT(14)
> -#define STMMAC_FLAG_SERDES_SUPPORTS_2500M      BIT(15)
> +#define STMMAC_FLAG_EEE_DISABLE                        BIT(10)
> +#define STMMAC_FLAG_RX_CLK_RUNS_IN_LPI         BIT(11)
> +#define STMMAC_FLAG_EN_TX_LPI_CLOCKGATING      BIT(12)
> +#define STMMAC_FLAG_EN_TX_LPI_CLK_PHY_CAP      BIT(13)
> +#define STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY   BIT(14)
> +#define STMMAC_FLAG_KEEP_PREAMBLE_BEFORE_SFD   BIT(15)
> +#define STMMAC_FLAG_SERDES_SUPPORTS_2500M      BIT(16)
> =20
>  struct mac_device_info;
> =20
> --=20
> Regards,
>=20
> Laurent Pinchart
>

