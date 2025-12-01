Return-Path: <netdev+bounces-242921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCAEC96648
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 10:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 64BE9341151
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 09:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456253009FE;
	Mon,  1 Dec 2025 09:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="wRtm4pmv"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A83F2FE578
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 09:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764581691; cv=none; b=sgWeGXZpFPaUG6zewQoA88wiydFR68Kxo1WeGZLfZZX6MPhERil78Ns88S/Bzt1Rh4IXrY5BBOpsqyY6TpfKh0h9jaLtgi9YangrKX+izwKaGKuomhjlkw0RX5Za2Vd0qh17r0p+nGNCsdT1RJ4HUnP9/x/Sq4yXtpOjS8eVEZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764581691; c=relaxed/simple;
	bh=ez676cIEUCsuJPcycXJ9bSGkXWl3dWQM7H/IWWAM564=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AitWxgrRzgRw++YQREQzdMNANG1wDBGtmd8iUhV/R5DdtHXeBqjQD8h32qhULoZp6TO4SArwdcHp2yh3p9uzywLNrVRofXfXc+0D8/h/0f1r/Lc4PYmh8HeDstqn/pM76/sntS4ezOMwAYajYbLYgZkkvfi6jjKFcWGdU7csYQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=wRtm4pmv; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 108FC1A1E7E;
	Mon,  1 Dec 2025 09:34:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D60AA606BB;
	Mon,  1 Dec 2025 09:34:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 130DE119124B1;
	Mon,  1 Dec 2025 10:34:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764581686; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=A1mbSFClOZbqIBNWltC8XTJus2Cais4KJBkrqiW0QOw=;
	b=wRtm4pmvunpWG3gPAHJD7LeJnqkX8+NA01oU7UtUYbixe6wcdt83p7ZSlCWrfE/5s7Gf0D
	I2XwvHPgY9qLFHaCt5k2Th3p0HBX/rFmuxP68fcOK5PQL77oQO7ArXIm2kJbRDnpD2k3pW
	J5FR61e53oXp/ciyyebJMI7lQLpGWwZfWoQjJPknsT/ga1uLhc4+gGR1zrjbh+kcjUDGec
	93b9ttmrZnu+J6hDwHiB9gC3SQX3lEOwUFAEnaW5psaYvI7EM2Ii1Oexzq3xsTNut1vuGs
	2ZMedfB1IQmFcM1/o1Yb1ySG1nO5lTBNyleFnC0cAmXIO9gwY+HrCT4UfThDpQ==
Date: Mon, 1 Dec 2025 10:34:40 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Russell King
 <linux@armlinux.org.uk>, Heiner Kallweit <hkallweit1@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Simon
 Horman <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>, Jacob
 Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/4] net: phy: microchip_rds_ptp: improve HW
 ts config logic
Message-ID: <20251201103440.0ddf9c42@kmaincent-XPS-13-7390>
In-Reply-To: <20251129195334.985464-4-vadim.fedorenko@linux.dev>
References: <20251129195334.985464-1-vadim.fedorenko@linux.dev>
	<20251129195334.985464-4-vadim.fedorenko@linux.dev>
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

On Sat, 29 Nov 2025 19:53:33 +0000
Vadim Fedorenko <vadim.fedorenko@linux.dev> wrote:

> The driver stores new HW timestamping configuration values
> unconditionally and may create inconsistency with what is actually
> configured in case of error. Improve the logic to store new values only
> once everything is configured.
>=20
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> ---
>  drivers/net/phy/microchip_rds_ptp.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/phy/microchip_rds_ptp.c
> b/drivers/net/phy/microchip_rds_ptp.c index 4c6326b0ceaf..6a7a0bb95301 10=
0644
> --- a/drivers/net/phy/microchip_rds_ptp.c
> +++ b/drivers/net/phy/microchip_rds_ptp.c
> @@ -488,9 +488,6 @@ static int mchp_rds_ptp_hwtstamp_set(struct
> mii_timestamper *mii_ts, unsigned long flags;
>  	int rc;
> =20
> -	clock->hwts_tx_type =3D config->tx_type;
> -	clock->rx_filter =3D config->rx_filter;
> -
>  	switch (config->rx_filter) {
>  	case HWTSTAMP_FILTER_NONE:
>  		clock->layer =3D 0;
> @@ -518,6 +515,15 @@ static int mchp_rds_ptp_hwtstamp_set(struct
> mii_timestamper *mii_ts, return -ERANGE;
>  	}
> =20
> +	switch (config->rx_filter) {

You want to check tx_type here not rx_filter.

> +	case HWTSTAMP_TX_ONESTEP_SYNC:
> +	case HWTSTAMP_TX_ON:
> +	case HWTSTAMP_TX_OFF:
> +		break;
> +	default:
> +		return -ERANGE;
> +	}
> +

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

