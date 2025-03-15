Return-Path: <netdev+bounces-175056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91259A62ECF
	for <lists+netdev@lfdr.de>; Sat, 15 Mar 2025 16:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E66DB189B416
	for <lists+netdev@lfdr.de>; Sat, 15 Mar 2025 15:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFC5202F96;
	Sat, 15 Mar 2025 14:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0QKS65a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE35202963
	for <netdev@vger.kernel.org>; Sat, 15 Mar 2025 14:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742050790; cv=none; b=SpAGGfAXlka7cj7tUmEuZkFXNgZcc7K5gi6QsU/W8/EIJY2eYjpFPfOjknhTpafsOPcDymbQQtjBxa9Ic5bRcGBMYnVGsbf0wRGTmvlABCOxSrfcTUs8eSFXKSWMSit3zk4PqZbzMUPqRUgUHHw3x3e/AjJjIo24fo6kRge4Fg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742050790; c=relaxed/simple;
	bh=nbH36w1dL+pRRLGP3n0xnr2K2/yhzh6Zxphogml5rEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMIIrNAfXAxJvB0yDMv8qHNnOMtNm9F8cTunSS/Pvc0unjV+eWCzujbxGFcIL7SvnP8p4/XBfGJobFOfrht1kNAMlQveDYZVOvq+KGAuuFrzupDo+aaMqpn1LETNEvLWzNLprLcxlDIiZxN7hByFUod52H9l1P4qnI9qm9fgcgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M0QKS65a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE96C4CEE5;
	Sat, 15 Mar 2025 14:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742050789;
	bh=nbH36w1dL+pRRLGP3n0xnr2K2/yhzh6Zxphogml5rEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M0QKS65a7KfZjQU861W52Aibfx/85WGuyFdmAbFJD8Faw3UXl9rlDwwANcvDpozNo
	 JY2yA2JpsppGFoq46iKbGHKw2+mYXsxoaPZba7Aa55oAS8vZt/de2susUwsmDUiN+b
	 2xYTyrDKyRPgJxaNEO2fiJumHmBzinGW/SeoPgA/WDvu7GpRQEzHtVzq7tM+fOKjIt
	 CTdTDfEjSGsuHVjoF6gTr5/WBgkDzQShecYdKLdDSPDvhdAlSadj4Gpm8SkQAGoMnj
	 6SnWUN9GpxkEBZbYDvWmtxl9UKaubRs4yGG9/i1VeMfLM7ph1aR6UPzjwXc9vniNva
	 G6hEUIgdd6hAg==
Date: Sat, 15 Mar 2025 15:59:46 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: airoha: Validate egress gdm port in
 airoha_ppe_foe_entry_prepare()
Message-ID: <Z9WV4mNwG04JRbZg@lore-desk>
References: <20250315-airoha-flowtable-null-ptr-fix-v2-1-94b923d30234@kernel.org>
 <b647d3c2-171e-43ea-9329-ea37093f5dec@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0gwZGiIvCsP+axxS"
Content-Disposition: inline
In-Reply-To: <b647d3c2-171e-43ea-9329-ea37093f5dec@lunn.ch>


--0gwZGiIvCsP+axxS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > Fix the issue validating egress gdm port in airoha_ppe_foe_entry_prepare
> > routine.
>=20
> A more interesting question is, why do you see an invalid port? Is the
> hardware broken? Something not correctly configured? Are you just
> papering over the crack?
>=20
> > -static int airoha_ppe_foe_entry_prepare(struct airoha_foe_entry *hwe,
> > +static int airoha_ppe_foe_entry_prepare(struct airoha_eth *eth,
> > +					struct airoha_foe_entry *hwe,
> >  					struct net_device *dev, int type,
> >  					struct airoha_flow_data *data,
> >  					int l4proto)
> > @@ -224,6 +225,11 @@ static int airoha_ppe_foe_entry_prepare(struct air=
oha_foe_entry *hwe,
> >  	if (dev) {
> >  		struct airoha_gdm_port *port =3D netdev_priv(dev);
>=20
> If port is invalid, is dev also invalid? And if dev is invalid, could
> dereferencing it to get priv cause an opps?

I do not think this is a hw problem. Running bidirectional high load traffi=
c,
I got the sporadic crash reported above. In particular, netfilter runs
airoha_ppe_flow_offload_replace() providing the egress net_device pointer u=
sed
in airoha_ppe_foe_entry_prepare(). Debugging with gdb, I discovered the sys=
tem
crashes dereferencing port pointer in airoha_ppe_foe_entry_prepare() (even =
if
dev pointer is not NULL). Adding this sanity check makes the system stable.
Please note a similar check is available even in mtk driver [0].

Regards,
Lorenzo

[0] https://github.com/torvalds/linux/blob/master/drivers/net/ethernet/medi=
atek/mtk_ppe_offload.c#L220

>=20
> 	Andrew

--0gwZGiIvCsP+axxS
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZ9WV4gAKCRA6cBh0uS2t
rG88AQC/jFkglYKzs7gKjBMXlbb4qZXUvmG4BooRm1FBX3ufNAD8C4Kkjhzs5jAE
MFryAvFRHcSIrWLNX8IUoQyL/VhhfQA=
=91tS
-----END PGP SIGNATURE-----

--0gwZGiIvCsP+axxS--

