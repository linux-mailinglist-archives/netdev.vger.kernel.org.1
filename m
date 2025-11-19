Return-Path: <netdev+bounces-240036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A35C6F8BB
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 16:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 20E6428BD0
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 15:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C7A3563DF;
	Wed, 19 Nov 2025 15:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="x/eUr1Jl"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427C8277818
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 14:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763564401; cv=none; b=EtBZbn64kCnrLaGeUACDSuJRcjOCdB6sJpcXg3rCHjs1iH7M0G4RiCAFuFNaTcD9mAcqOiEKlpaxEnjGEhBgM97cuZ6+8bJMRiDQb7UZD/2FhYMH7lbvq6KNqaMrolmHxSxW3zofLhDnvJ4lSokZTBnSyhoNNf1PxqAooeYMEvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763564401; c=relaxed/simple;
	bh=RjnRd+MkeqBnTBJ7OP6wUAf+fTc6fpkuf7GFbqBuAUc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AZUWgIn8LZEx+ggsQEHKKqWuG+evdzfG2LZzI1ixAHH1wWrDkSxOiLD7TmyQBTOlvg7RD2eThus8yf20dY02ipO1wakwMXQ+xnZ5OTWhnw8BDrqa7jVqu17tj79ywnB+PVhoYVcAGGXiI/pAPXQaXb+93lutXy96e7YnGCLnPcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=x/eUr1Jl; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 8632C1A1BB0;
	Wed, 19 Nov 2025 14:59:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5947860699;
	Wed, 19 Nov 2025 14:59:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3865C10371A77;
	Wed, 19 Nov 2025 15:59:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763564394; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=wCQvgoYzQFunsLd9+4kACeDKho09udz3bZbXHNq46t4=;
	b=x/eUr1JlN8RUvyyErRjjU87h+bdqCrQL8OMrvWXxRanDkOE+cn2HDJ798FePYUnAAKuaik
	oWX0cTVxFdp9Bn5kwXOIqL9egoIcvbxedBstmm1yNvi6G9uuQ04VZU1+Z76NUfgFHtNYyt
	PU8SfC6HMVUc5uJS8ycUKVMZ4bnTIHTUJTD3PI4UB00pQQxtdFgVUK9Zo0u2ZD/I5dOE6E
	82cDnxG7NXc5973i6QOYdqO7t8OnAjscZqrRSFnsHdD4Y1MTlO+iZLakK2yf/Z4cDPe2RD
	UUeT9GWgYlm83iOp/ShKAU4k/ezjfc9f8dXBkYkC4XvUhD+mhs+xg0qBMaTQYQ==
Date: Wed, 19 Nov 2025 15:59:49 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Russell King <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrei Botila
 <andrei.botila@oss.nxp.com>, Richard Cochran <richardcochran@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Jacob Keller <jacob.e.keller@intel.com>,
 bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 9/9] ptp: ptp_ines: add HW timestamp
 configuration reporting
Message-ID: <20251119155949.5a69551f@kmaincent-XPS-13-7390>
In-Reply-To: <20251119124725.3935509-10-vadim.fedorenko@linux.dev>
References: <20251119124725.3935509-1-vadim.fedorenko@linux.dev>
	<20251119124725.3935509-10-vadim.fedorenko@linux.dev>
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

On Wed, 19 Nov 2025 12:47:25 +0000
Vadim Fedorenko <vadim.fedorenko@linux.dev> wrote:

> The driver partially stores HW timestamping configuration, but missing
> pieces can be read from HW. Add callback to report configuration.
>=20
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> ---
>  drivers/ptp/ptp_ines.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>=20
> diff --git a/drivers/ptp/ptp_ines.c b/drivers/ptp/ptp_ines.c
> index 56c798e77f20..790eb42b78db 100644
> --- a/drivers/ptp/ptp_ines.c
> +++ b/drivers/ptp/ptp_ines.c
> @@ -328,6 +328,28 @@ static u64 ines_find_txts(struct ines_port *port, st=
ruct
> sk_buff *skb) return ns;
>  }
> =20
> +static int ines_hwtstamp_get(struct mii_timestamper *mii_ts,
> +			     struct kernel_hwtstamp_config *cfg)
> +{
> +	struct ines_port *port =3D container_of(mii_ts, struct ines_port,
> mii_ts);
> +	unsigned long flags;
> +	u32 port_conf;
> +
> +	cfg->rx_filter =3D port->rxts_enabled ? HWTSTAMP_FILTER_PTP_V2_EVENT
> +					    : HWTSTAMP_FILTER_NONE;
> +	if (port->txts_enabled) {
> +		spin_lock_irqsave(&port->lock, flags);
> +		port_conf =3D ines_read32(port, port_conf);
> +		spin_unlock_irqrestore(&port->lock, flags);
> +		cfg->tx_type =3D (port_conf & CM_ONE_STEP) ?
> HWTSTAMP_TX_ONESTEP_P2P
> +							 : HWTSTAMP_TX_OFF;

You could also update txts_enabled to int and save the tx type as you did in
other patches. I don't know what the best approach is, but in either way, t=
his
is ok to me.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

