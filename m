Return-Path: <netdev+bounces-208703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D78B6B0CCC9
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 23:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8616B17059A
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 21:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7CA23E325;
	Mon, 21 Jul 2025 21:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikMcdFsO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9281117996;
	Mon, 21 Jul 2025 21:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753133873; cv=none; b=BPznwCULci3GW2um0GHbzZoTHkf7MSFTUiWiNpQWwlctrtze3hlAJnc1um5RF8JSismwa7E/upCe/tZeoDK5acDgu0ItQtfTSF1qo1nGDhf1OWM3DTSolUURAjsj1NggyWTFZll91ugrhC2asHCMclYm7ulYDworIUQngaLUfaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753133873; c=relaxed/simple;
	bh=vux3ljHQL8fINu3c42OPgphrlmfOj/Zy4tR5XX6EUKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dVn6tbg7MzdLaAdi8Ze+pMzgt6oSxRLc179pPfS0ZUd91g7kpuwTsbemzk1Vs7chVMeTgfmz5yhnyUuTLwxHvmhezpggwBMQKrqHgFs5rwwDyIxgWad6VchMOIclVma+7Ab1cuE0Rrop3o9FPRvweQQ1WKipQs6AmO0IxiJyLmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikMcdFsO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 845E0C4CEED;
	Mon, 21 Jul 2025 21:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753133873;
	bh=vux3ljHQL8fINu3c42OPgphrlmfOj/Zy4tR5XX6EUKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ikMcdFsOXsniDPlwnCm9s0WBgVm7AhZSiIVBtQ2F2Wq/5Wx9q66k6m5aFWIcCS5Or
	 aVPwKoEGEbw8Ti2J2QNRUVdyh98CUdrBp6U4eMkRA7daYn90+b0ceqNQnHPGYacTAu
	 PokDc6V6oTuz3DGNfh040y59WIoQR7o0nAOPBRcACuLDGkkTg1y7RzMrkoE0jrfapZ
	 6V3oCj/fLFprr6w+etUoIzWIe2GyXcjcClF4OJuCvDpkvugGeWtbSkDwdxQJEs0Mn8
	 qSWcLjzdverDlDPda5J5hXKhnoqUbtxEPhJJeJrZngkgGMZi/eOlR0GbrFu8EZaNFF
	 yw/pi3FG4Or9w==
Date: Mon, 21 Jul 2025 23:37:50 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH net-next v4 1/7] dt-bindings: net: airoha: npu: Add
 memory regions used for wlan offload
Message-ID: <aH6zLo17TOSZID37@lore-desk>
References: <20250717-airoha-en7581-wlan-offlaod-v4-0-6db178391ed2@kernel.org>
 <20250717-airoha-en7581-wlan-offlaod-v4-1-6db178391ed2@kernel.org>
 <20250718-sceptical-blue-bird-7e96e3@kuoka>
 <aHoWY6iGN-lJnu60@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hDFEHIRXI0z6CbSS"
Content-Disposition: inline
In-Reply-To: <aHoWY6iGN-lJnu60@lore-desk>


--hDFEHIRXI0z6CbSS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > On Thu, Jul 17, 2025 at 08:57:42AM +0200, Lorenzo Bianconi wrote:
> > > Document memory regions used by Airoha EN7581 NPU for wlan traffic
> > > offloading. The brand new added memory regions do not introduce any
> > > backward compatibility issues since they will be used just to offload
> > > traffic to/from the MT76 wireless NIC and the MT76 probing will not f=
ail
> > > if these memory regions are not provide, it will just disable offload=
ing
> > > via the NPU module.
> >=20
> > That's not what I see entirely. I see the same problem I told you alrea=
dy.
> > of_reserved_mem_region_to_resource_byname returns error ->
> > airoha_npu_wlan_init_memory returns error -> your other patchset prints
> > big fat warning in mt7996_pci_probe().
>=20
> Is it ok to use dev_info() instead dev_warn() or do you prefer to complet=
ely
> remove the log?
>=20
> >=20
> > So all correct DTS now gets a warning. Warning is a state of failure,
> > even if probe proceeds.
> >=20
> > I don't understand why you can't make it fully optional, so also fully
> > backwards compatible.
>=20
> I am completely fine to make it fully optional, but can you please explain
> what you mean here with 'optional'?
>=20
> At the moment in mt76_npu_init() we first look for the "airoha,npu" prope=
rty
> in mt76 node to load the NPU pointer running airoha_npu_get():
>=20
> wifi@0,0 {
> 	compatible =3D "mediatek,mt76";
> 	...
> 	airoha,npu =3D <&npu>;
> 	...
> };

According to my understanding it is enough to get rid of the dev_warn() in =
the
MT76 series in order to avoid any backward compatibility issues. Am I wrong?
Moreover, we have the NPU phandle in the MT76 DTS node in order to check if=
 the
reserved-memory properties are mandatory or not (if the MT76 node is config=
ured
with the NPU phandle it is expected to have the reserved-memory properties =
properly
configured).
If my understanding is correct the NPU series does not require any change (=
the
only required change is in MT76 series). Since the current series is marked=
 as
"Changes Requested' in patchwork, do I need to repost?

Regards,
Lorenzo

>=20
> If this property is defined in the wifi node I guess it is fine to assume
> even the NPU memory regions are properly defined int the DTS.
>=20
> Is it ok to use dev_info() instead of dev_warn() in mt7996_pci_probe() if
> the mt76_npu_init() returns an error (e.g. if the "airoha,npu" is not def=
ined)
> or do you prefer to do something else to make this process optional?
>=20
> Regards,
> Lorenzo
>=20
> >=20
> > Best regards,
> > Krzysztof
> >=20



--hDFEHIRXI0z6CbSS
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaH6zLgAKCRA6cBh0uS2t
rG2RAQCuL5YPTsDFkr426LnD5RkvUOkMsaYTElmnbIYT4uE1UAEA0n0KABJw+pOs
JmKHhsz291dIAM3tsXOOyatOEJIqFwc=
=83D7
-----END PGP SIGNATURE-----

--hDFEHIRXI0z6CbSS--

