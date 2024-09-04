Return-Path: <netdev+bounces-124906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB0196B5C2
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 11:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D1BEB23537
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 09:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D968D19B3F6;
	Wed,  4 Sep 2024 09:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=martyn.welch@collabora.com header.b="VfuzVa6k"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A33A19E978;
	Wed,  4 Sep 2024 09:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725440416; cv=pass; b=RVLmMGS3AZvz4r8o16sWsyUwQO6uzTWRLUqvQ1SrJTPzyjHR+pDRAHk1sFQ48eqg6KIXZV9C6AjRtAkulolQDV7d5J+N/5K5HpKV/nqZPRtwiW+MfoKHmIvEXAanKT7uRzGH7FbazDFRMvn5fy7smxA+VnbLY2REvoVJWmNSVto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725440416; c=relaxed/simple;
	bh=Lp0gBNesqxQ+K33T6nMjVSgmPxNP5KTCyAoMqtWyhDI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RKPyTM0KlNH96+vbx30rG9u79tRwEDsyopzxXrsx2TvVBXhjcWeFUXOZvchOBu+3jDNfl1RdAjrdyrLUitdn2PTsUdmiLI2oK1yPTTD0FVFW2w2alIcZu/dYNtPHZIUfWVsezuVfNA8gCPA0Ax0NIbVXt00ApDTisv/7C4o5heI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=martyn.welch@collabora.com header.b=VfuzVa6k; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: kernel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1725440392; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZOOsPEfsq0GG5SO4/jV+/TBmNx0EpQ6rkvyLuLN944REbgMRsOASlxmEfo+mgWS6LzOm74kxZK7EL2d52HMm8gjmTGdRX7FrMNE5+NeLBVAylNDWzFXdyHQZ74kYy4qnnR2579foizEusgAtUw4NKSXP4seBHE0PceUY73GD5lM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1725440392; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=unf5BXO1eXr3zeJIlRY5jBawrMyT2TEVnNXQVsGG8HI=; 
	b=c1FjNBivKY9ExJEg1mBFw+66qpj+Ab0XqUzmYlgvcMMWAyl3x07zUiuvX7ucxrI/SLrDYl1BOwnlAgwVr+BcGQs57zqJgEHMkYJ+mv2VzRXPCH3c3Rz6OxxnczKN8SMXSo9mkhr6vhAkkFb3SEuKXeBG5IEM0FDf5kbsG0S2Xec=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=martyn.welch@collabora.com;
	dmarc=pass header.from=<martyn.welch@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1725440392;
	s=zohomail; d=collabora.com; i=martyn.welch@collabora.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=unf5BXO1eXr3zeJIlRY5jBawrMyT2TEVnNXQVsGG8HI=;
	b=VfuzVa6kFdBfM1gBqYC5uNpfT7lpgLoGlAymnyFjPEyHTlO3xAfcfDlNIYTkFoy4
	nRo2zjnL8nQCrWDF2x8O6f4ZWt+PLMDRFE0BJ/HitwBKXU4Xzn3vlQvL9g+EmHx0y0B
	eMh6JQJPLFfbpuLdG85NohDDTSfKcYt5SY0lX65Q=
Received: by mx.zohomail.com with SMTPS id 1725440390150559.3459130722702;
	Wed, 4 Sep 2024 01:59:50 -0700 (PDT)
Message-ID: <028169559976d3daecb754cddf4ca96928819538.camel@collabora.com>
Subject: Re: [PATCH v2] net: enetc: Replace ifdef with IS_ENABLED
From: Martyn Welch <martyn.welch@collabora.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>, "David S. Miller"	
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski	
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, kernel@collabora.com, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 04 Sep 2024 09:59:46 +0100
In-Reply-To: <20240903224446.mp55dvria3rrtope@skbuf>
References: <20240903140420.2150707-1-martyn.welch@collabora.com>
	 <20240903140420.2150707-1-martyn.welch@collabora.com>
	 <20240903224446.mp55dvria3rrtope@skbuf>
Organization: Collabora Ltd.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.53.2-1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

On Wed, 2024-09-04 at 01:44 +0300, Vladimir Oltean wrote:
> Hi Martyn,
>=20
> On Tue, Sep 03, 2024 at 03:04:18PM +0100, Martyn Welch wrote:
> > The enetc driver uses ifdefs when checking whether
> > CONFIG_FSL_ENETC_PTP_CLOCK is enabled in a number of places. This
> > works
> > if the driver is compiled in but fails if the driver is available
> > as a
> > kernel module. Replace the instances of ifdef with use of the
> > IS_ENABLED
> > macro, that will evaluate as true when this feature is built as a
> > kernel
> > module and follows the kernel's coding style.
> >=20
> > Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> > Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
> > ---
> >=20
> > Changes since v1:
> > =C2=A0 - Switched from preprocessor conditionals to normal C
> > conditionals.
>=20
> Thanks for the patch. Can you please send a v3 rebased on the latest
> net-next, which now contains commit 3dd261ca7f84 ("net: enetc: Remove
> setting of RX software timestamp")? The change needs rethinking a
> bit.
>=20

Sure no worries.

> Also, could you git format-patch --subject-prefix=3D"PATCH net-next v3"
> next time? The networking subsystem tends to require that from patch
> submitters, to indicate the tree that the patch should be applied to.
>=20
> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
> > b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
> > index 5e684b23c5f5..a9402c1907bf 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
> > @@ -853,24 +853,25 @@ static int enetc_get_ts_info(struct
> > net_device *ndev,
> > =C2=A0		info->phc_index =3D -1;
> > =C2=A0	}
> > =C2=A0
> > -#ifdef CONFIG_FSL_ENETC_PTP_CLOCK
> > -	info->so_timestamping =3D SOF_TIMESTAMPING_TX_HARDWARE |
> > -				SOF_TIMESTAMPING_RX_HARDWARE |
> > -				SOF_TIMESTAMPING_RAW_HARDWARE |
> > -				SOF_TIMESTAMPING_TX_SOFTWARE |
> > -				SOF_TIMESTAMPING_RX_SOFTWARE |
> > -				SOF_TIMESTAMPING_SOFTWARE;
> > -
> > -	info->tx_types =3D (1 << HWTSTAMP_TX_OFF) |
> > -			 (1 << HWTSTAMP_TX_ON) |
> > -			 (1 << HWTSTAMP_TX_ONESTEP_SYNC);
> > -	info->rx_filters =3D (1 << HWTSTAMP_FILTER_NONE) |
> > -			=C2=A0=C2=A0 (1 << HWTSTAMP_FILTER_ALL);
> > -#else
> > -	info->so_timestamping =3D SOF_TIMESTAMPING_RX_SOFTWARE |
> > -				SOF_TIMESTAMPING_TX_SOFTWARE |
> > -				SOF_TIMESTAMPING_SOFTWARE;
> > -#endif
> > +	if (IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK)) {
> > +		info->so_timestamping =3D
> > SOF_TIMESTAMPING_TX_HARDWARE |
> > +					SOF_TIMESTAMPING_RX_HARDWA
> > RE |
> > +					SOF_TIMESTAMPING_RAW_HARDW
> > ARE |
> > +					SOF_TIMESTAMPING_TX_SOFTWA
> > RE |
> > +					SOF_TIMESTAMPING_RX_SOFTWA
> > RE |
> > +					SOF_TIMESTAMPING_SOFTWARE;
> > +
> > +		info->tx_types =3D (1 << HWTSTAMP_TX_OFF) |
> > +				 (1 << HWTSTAMP_TX_ON) |
> > +				 (1 << HWTSTAMP_TX_ONESTEP_SYNC);
> > +		info->rx_filters =3D (1 << HWTSTAMP_FILTER_NONE) |
> > +				=C2=A0=C2=A0 (1 << HWTSTAMP_FILTER_ALL);
> > +	} else {
> > +		info->so_timestamping =3D
> > SOF_TIMESTAMPING_RX_SOFTWARE |
> > +					SOF_TIMESTAMPING_TX_SOFTWA
> > RE |
> > +					SOF_TIMESTAMPING_SOFTWARE;
> > +	}
> > +
>=20
> How about:
>=20
> 	if (!IS_ENABLED()) {
> 		info->so_timestamping =3D
> SOF_TIMESTAMPING_TX_SOFTWARE;
> 		return 0;
> 	}
>=20
> 	info->so_timestamping =3D SOF_TIMESTAMPING_TX_HARDWARE |
> 				SOF_TIMESTAMPING_RX_HARDWARE |
> 				SOF_TIMESTAMPING_RAW_HARDWARE |
> 				SOF_TIMESTAMPING_TX_SOFTWARE;
>=20
> 	info->tx_types =3D (1 << HWTSTAMP_TX_OFF) |
> 			 (1 << HWTSTAMP_TX_ON) |
> 			 (1 << HWTSTAMP_TX_ONESTEP_SYNC);
> 	info->rx_filters =3D (1 << HWTSTAMP_FILTER_NONE) |
> 			=C2=A0=C2=A0 (1 << HWTSTAMP_FILTER_ALL);
>=20
> 	return 0;
> ?
>=20
> I think I prefer the style with the early return.
>=20

Works for me. I'd actually considered that whilst reworking from v1,
but decided to keep the flow close to what it currently was.

Martyn

> > =C2=A0	return 0;
> > =C2=A0}
> > =C2=A0
> > --=20
> > 2.45.2


