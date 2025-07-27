Return-Path: <netdev+bounces-210353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24090B12EBB
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 10:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FE491899805
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 08:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8021F03C7;
	Sun, 27 Jul 2025 08:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DkGPnJij"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B4C645;
	Sun, 27 Jul 2025 08:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753605749; cv=none; b=WCHUlkJSoJoJOeyvy8fwYqZSjvN4HsCOFWAF0HQ2vV9pqmCgNfk0oWrpPFWKJrynsWyb8zjcRSV/Cepme4aOrWZQN1SzA5gXi5n48nnEqY2RTzL9yzJ2sBYW/+c0RxSL7fpdj2Sxybzu9rSp1mv3/V4reB1RG1oSj0vSwuAR+es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753605749; c=relaxed/simple;
	bh=1FBsq3RJo4viUjTTcy8YHS5y2gw/+JTmgv3W+/1sNcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3cI0TZTF8HZYAKqyuT5JaQu1SPBAmtRu2tI0bF/xgAuxfDOaZL9kpecfY3orFWUaTyuiEzVnEAoZBKjsb+9JrDN5qMkMEVx3g7q1kLeIzaEI/n7IquTEmC4Bs0W2iSg83yXis+n6W/nsC3mgW5sAUPibUFgUCX/soYYuIAQjfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DkGPnJij; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8BB3C4CEEB;
	Sun, 27 Jul 2025 08:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753605749;
	bh=1FBsq3RJo4viUjTTcy8YHS5y2gw/+JTmgv3W+/1sNcc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DkGPnJijKVgVkPNWynxQoXYQPWllTcSUGGm1qWoE2LkOL7WW0DJemmcv9Sj6aSeQl
	 2ytVgW4bGL8CsGWfW+FIx/I8QYszufxSMK8hh0Ah0BnOMX+sHtXUwXDxRHTen1yKgk
	 Py/RDpfVRcdEaWqIq4GLu2tahKmAaJ8FwgqL2ewnWQp2gdFG+HzdcUZ+XAedM0xRYG
	 mXiiB0FSelfP5TrkzMo0oHwChQ/NCqmBmmq3Oqx94WNz042sqzXVttjVubxMfEq2/n
	 3hgDKXKo1WrAMyBMu5RDFezLkTt1rf6WPI8Qhm1J2sDUnUHZRW2DIkEW9eLEmiemqT
	 PDPtR5mqBBWZA==
Date: Sun, 27 Jul 2025 10:42:25 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Felix Fietkau <nbd@nbd.name>, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v5 3/7] net: airoha: npu: Add
 wlan_{send,get}_msg NPU callbacks
Message-ID: <aIXmcUCQe7-gm9--@lore-desk>
References: <20250723-airoha-en7581-wlan-offlaod-v5-0-da92e0f8c497@kernel.org>
 <20250723-airoha-en7581-wlan-offlaod-v5-3-da92e0f8c497@kernel.org>
 <ff106cec-7e63-4475-a0e6-452bfcb823b3@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KcwatzaRMwMSfQy/"
Content-Disposition: inline
In-Reply-To: <ff106cec-7e63-4475-a0e6-452bfcb823b3@linux.dev>


--KcwatzaRMwMSfQy/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 23/07/2025 18:19, Lorenzo Bianconi wrote:
> > Introduce wlan_send_msg() and wlan_get_msg() NPU wlan callbacks used
> > by the wlan driver (MT76) to initialize NPU module registers in order to
> > offload wireless-wired traffic.
> > This is a preliminary patch to enable wlan flowtable offload for EN7581
> > SoC with MT76 driver.
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >   drivers/net/ethernet/airoha/airoha_npu.c | 58 +++++++++++++++++++++++=
+++++++++
> >   drivers/net/ethernet/airoha/airoha_npu.h | 21 ++++++++++++
> >   2 files changed, 79 insertions(+)
> >=20
>=20
> [...]
>=20
> > @@ -131,6 +147,12 @@ struct wlan_mbox_data {
> >   	u32 func_id;
> >   	union {
> >   		u32 data;
> > +		struct {
> > +			u32 dir;
> > +			u32 in_counter_addr;
> > +			u32 out_status_addr;
> > +			u32 out_counter_addr;
> > +		} txrx_addr;
> >   		u8 stats[WLAN_MAX_STATS_SIZE];
> >   	};
> >   };
> > @@ -424,6 +446,30 @@ static int airoha_npu_wlan_msg_send(struct airoha_=
npu *npu, int ifindex,
> >   	return err;
> >   }
> > +static int airoha_npu_wlan_msg_get(struct airoha_npu *npu, int ifindex,
> > +				   enum airoha_npu_wlan_get_cmd func_id,
> > +				   u32 *data, gfp_t gfp)
> > +{
> > +	struct wlan_mbox_data *wlan_data;
> > +	int err;
> > +
> > +	wlan_data =3D kzalloc(sizeof(*wlan_data), gfp);
> > +	if (!wlan_data)
> > +		return -ENOMEM;
> > +
> > +	wlan_data->ifindex =3D ifindex;
> > +	wlan_data->func_type =3D NPU_OP_GET;
> > +	wlan_data->func_id =3D func_id;
> > +
> > +	err =3D airoha_npu_send_msg(npu, NPU_FUNC_WIFI, wlan_data,
> > +				  sizeof(*wlan_data));
> > +	if (!err)
> > +		*data =3D wlan_data->data;
> > +	kfree(wlan_data);
> > +
> > +	return err;
> > +}
>=20
> Am I reading it correct, that on message_get you allocate 4408 + 8 byte,
> setting it 0, then reallocate the same size in airoha_npu_send_msg() and
> copy the data, and then free both buffers, and this is all done just to
> get u32 value back?

ack, right. This is was the original approach in the vendor sdk.
I will fix in v6.

Regards,
Lorenzo


--KcwatzaRMwMSfQy/
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaIXmcQAKCRA6cBh0uS2t
rFrAAP4yzHsHYDp6pps4peenrqug/hiwFirsQerZGdFYZscxxgD/ZPuKL0EPUbb9
du8EkSKxgOkHAkO0SUXlzjl0Dc4R+Q8=
=TBNx
-----END PGP SIGNATURE-----

--KcwatzaRMwMSfQy/--

