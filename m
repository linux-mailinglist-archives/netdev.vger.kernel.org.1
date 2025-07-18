Return-Path: <netdev+bounces-208120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E89E1B09FF4
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 11:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3A26A44E41
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 09:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5F42989BA;
	Fri, 18 Jul 2025 09:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRFPe2zz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EBE1E98E3;
	Fri, 18 Jul 2025 09:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752831590; cv=none; b=SnTOB23amJAivvuPnGxdok38tEKclL6S76qxcfi8Y7lcELw9/D4x/q7wwC1o69Y39HKAFVJYYsXcFyQs6ii/iMZw7tqna3NlXuIGv1gq6Wpzj84g0nk12zEcvsA5ViJ7wM1tvDx/QJeHx8vOOVXVJ6EairAePKfKJN1Xki7Nbrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752831590; c=relaxed/simple;
	bh=ATisPNWNr/NpB62B2F5Uq+5svo7dwS+kjzLt4tvM/K8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NOepXJfa81jL0Yl86ZQgMxmlEmUp59yiGE53dxIwnlG/zV6NJt0TUqwszZVWykL6bQkzdjpXFTEGIB68vStIrLuD7wurcOcepdfa+S3wMgxSRGR1BeU0mlIB2cJ7Xu0IAvtw9CzR2mMxmTW2VZwNb8z5XxoswPu+MkBAjhDAB0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRFPe2zz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EB72C4CEEB;
	Fri, 18 Jul 2025 09:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752831590;
	bh=ATisPNWNr/NpB62B2F5Uq+5svo7dwS+kjzLt4tvM/K8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WRFPe2zzvXaR+wqRNqtPQ0xneaYD4yub6M6czL2yeoub91++wGWiWDAFotvunoArf
	 ytw7tz8snJE802azQGmTAU3UPgOJ7Vg1gsmoB+xnrvHTPUH3LeV/rzUsgZTkFHpl5e
	 BfcRST/FFoiyCpkeDlHD2QL5XKC7Ug0U1Sf+byuvZgXA+1JFdZ97Cilv3vNBvQVEMq
	 36DxwgcbDmr8beQG76QpT7U1grOV8jGxfwhYWsB2zlP1f0zNL5FHUTMGJ4IJqQDzMR
	 g11qaPv6rNFYD2Vy+tgqUA56d4EoMAloVrjVW8V/74KBIjXCjwlJYtXPQCQvKqFIVF
	 fAuM7vp+MMz8Q==
Date: Fri, 18 Jul 2025 11:39:47 +0200
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
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/7] dt-bindings: net: airoha: npu: Add
 memory regions used for wlan offload
Message-ID: <aHoWY6iGN-lJnu60@lore-desk>
References: <20250717-airoha-en7581-wlan-offlaod-v4-0-6db178391ed2@kernel.org>
 <20250717-airoha-en7581-wlan-offlaod-v4-1-6db178391ed2@kernel.org>
 <20250718-sceptical-blue-bird-7e96e3@kuoka>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3JqbMrQnCkpywZ9L"
Content-Disposition: inline
In-Reply-To: <20250718-sceptical-blue-bird-7e96e3@kuoka>


--3JqbMrQnCkpywZ9L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, Jul 17, 2025 at 08:57:42AM +0200, Lorenzo Bianconi wrote:
> > Document memory regions used by Airoha EN7581 NPU for wlan traffic
> > offloading. The brand new added memory regions do not introduce any
> > backward compatibility issues since they will be used just to offload
> > traffic to/from the MT76 wireless NIC and the MT76 probing will not fail
> > if these memory regions are not provide, it will just disable offloading
> > via the NPU module.
>=20
> That's not what I see entirely. I see the same problem I told you already.
> of_reserved_mem_region_to_resource_byname returns error ->
> airoha_npu_wlan_init_memory returns error -> your other patchset prints
> big fat warning in mt7996_pci_probe().

Is it ok to use dev_info() instead dev_warn() or do you prefer to completely
remove the log?

>=20
> So all correct DTS now gets a warning. Warning is a state of failure,
> even if probe proceeds.
>=20
> I don't understand why you can't make it fully optional, so also fully
> backwards compatible.

I am completely fine to make it fully optional, but can you please explain
what you mean here with 'optional'?

At the moment in mt76_npu_init() we first look for the "airoha,npu" property
in mt76 node to load the NPU pointer running airoha_npu_get():

wifi@0,0 {
	compatible =3D "mediatek,mt76";
	...
	airoha,npu =3D <&npu>;
	...
};

If this property is defined in the wifi node I guess it is fine to assume
even the NPU memory regions are properly defined int the DTS.

Is it ok to use dev_info() instead of dev_warn() in mt7996_pci_probe() if
the mt76_npu_init() returns an error (e.g. if the "airoha,npu" is not defin=
ed)
or do you prefer to do something else to make this process optional?

Regards,
Lorenzo

>=20
> Best regards,
> Krzysztof
>=20

--3JqbMrQnCkpywZ9L
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaHoWYwAKCRA6cBh0uS2t
rMH+AP9mKzNrRKajI0dIizZfVTYflu21cQpHgECLJi/0fBDXygEA5dRSNsUQcyo4
ll6BHt9geLz7bnYYSRTsginFvI+8iA4=
=QkuP
-----END PGP SIGNATURE-----

--3JqbMrQnCkpywZ9L--

