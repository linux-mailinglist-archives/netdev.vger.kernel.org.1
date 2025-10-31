Return-Path: <netdev+bounces-234720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9302C266F2
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 18:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B618467672
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 17:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8452F9C3D;
	Fri, 31 Oct 2025 17:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="keIn0ekH"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFACD301465
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 17:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761932137; cv=none; b=XwL8mg7aFfku4lvAtiGXqj13D1/C2sggrSzKZN25klw7Ny3GSmpLOKJyqrfsgXhPHXIGwjZTUJzp7lfwmx4p6p4uFXcPbeTNh/SQOYyZCCJjYH0mjiEGtR5groQpecbBbNFSOST+TNeNFX7yuPw9iPxmYTnHf9mv5HcwuJRWnAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761932137; c=relaxed/simple;
	bh=4uXC2wmULze2lb7WYp6d4RQ6ulDn9qxgCGrSs11FOGE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vkj33p10LAM3z9XqYii8ZNB4D4hayn3d+67oAXtfk0DizdwR6eyoNbs2IpbdfyMQKCrNaobaIsFKUd3zGeWcTgorkk+qGLrq/5rspsqFTF/dgegUzXjEviAjg70WoItGcL8Hdqqr5MCgLoCfC9TjOHgd63aOrH4jfiO6X2LcDps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=keIn0ekH; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 2A8081A17B1;
	Fri, 31 Oct 2025 17:35:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E1FD360710;
	Fri, 31 Oct 2025 17:35:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C799C11818007;
	Fri, 31 Oct 2025 18:35:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761932131; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=teo/tPQKbj+eqyN8v2WFrPYQgfwcLLLvEpHLsfU/D9k=;
	b=keIn0ekHPTx73WLzGzd9c4dsLHU9DVD9o5X2yeoQnwyT/aPiv8EHkw2ukThiZr1ymLnMsC
	rfORmkZJOJGlYscSpk2j919AMcD83vOu/fZhcrVORgLkTPHqlaygLDn2IFdlOVoczikdVN
	oW1LKuuNfBOR271crLqJoh4Si6TPrzsgZQrJZBpolvuy6D4LiiNchooDIVqNbCfI9d4+nT
	hTVC0KeRyAGZivZAGL8G5fBNDNwgW73xcKJ3+bI93xguELqLvBVNje6z1/MsFLsgzA90fy
	QUaUDfgNQq8zF81bL3LEUf/CPcu8TR6vTwXE5/mfcgNnztqSPqxlIhPYAJMScQ==
Date: Fri, 31 Oct 2025 18:35:25 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Sudarsana Kalluru <skalluru@marvell.com>, Manish Chopra
 <manishc@marvell.com>, Marco Crivellari <marco.crivellari@suse.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Sunil Goutham <sgoutham@marvell.com>, Richard
 Cochran <richardcochran@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Simon Horman <horms@kernel.org>,
 Jacob Keller <jacob.e.keller@intel.com>,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 6/7] net: pch_gbe: convert to use ndo_hwtstamp
 callbacks
Message-ID: <20251031183525.5b8b8110@kmaincent-XPS-13-7390>
In-Reply-To: <20251031004607.1983544-7-vadim.fedorenko@linux.dev>
References: <20251031004607.1983544-1-vadim.fedorenko@linux.dev>
	<20251031004607.1983544-7-vadim.fedorenko@linux.dev>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On Fri, 31 Oct 2025 00:46:06 +0000
Vadim Fedorenko <vadim.fedorenko@linux.dev> wrote:

> The driver implemented SIOCSHWTSTAMP ioctl command only, but it stores
> configuration in the private data, so it is possible to report it back
> to users. Implement both ndo_hwtstamp_set and ndo_hwtstamp_get
> callbacks. To properly report RX filter type, store it in hwts_rx_en
> instead of using this field as a simple flag. The logic didn't change
> because receive path used this field as boolean flag.
>=20
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> ---
>  .../ethernet/oki-semi/pch_gbe/pch_gbe_main.c  | 40 +++++++++++--------
>  1 file changed, 24 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
> b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c index
> e5a6f59af0b6..4049137abc40 100644 ---
> a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c +++
> b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c @@ -198,42 +198,40=
 @@
> pch_tx_timestamp(struct pch_gbe_adapter *adapter, struct sk_buff *skb)
> pch_ch_event_write(pdev, TX_SNAPSHOT_LOCKED); }
> =20
> -static int hwtstamp_ioctl(struct net_device *netdev, struct ifreq *ifr, =
int
> cmd) +static int pch_gbe_hwtstamp_set(struct net_device *netdev,
> +				struct kernel_hwtstamp_config *cfg,
> +				struct netlink_ext_ack *extack)
>  {
> -	struct hwtstamp_config cfg;
>  	struct pch_gbe_adapter *adapter =3D netdev_priv(netdev);
>  	struct pci_dev *pdev;
>  	u8 station[20];
> =20
> -	if (copy_from_user(&cfg, ifr->ifr_data, sizeof(cfg)))
> -		return -EFAULT;
> -
>  	/* Get ieee1588's dev information */
>  	pdev =3D adapter->ptp_pdev;
> =20
> -	if (cfg.tx_type !=3D HWTSTAMP_TX_OFF && cfg.tx_type !=3D HWTSTAMP_TX_ON)
> +	if (cfg->tx_type !=3D HWTSTAMP_TX_OFF && cfg->tx_type !=3D
> HWTSTAMP_TX_ON) return -ERANGE;
> =20
> -	switch (cfg.rx_filter) {
> +	switch (cfg->rx_filter) {
>  	case HWTSTAMP_FILTER_NONE:
>  		adapter->hwts_rx_en =3D 0;
>  		break;
>  	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
> -		adapter->hwts_rx_en =3D 0;
> +		adapter->hwts_rx_en =3D cfg->rx_filter;

It seems there is a functional change here.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

