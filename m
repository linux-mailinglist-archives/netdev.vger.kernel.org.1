Return-Path: <netdev+bounces-204850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 497E6AFC423
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 09:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0D7816B608
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 07:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EC729898B;
	Tue,  8 Jul 2025 07:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdUR9vjr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3A325A2C8;
	Tue,  8 Jul 2025 07:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751960026; cv=none; b=CIlv2wvXIUbWsLbZ1knFgb3yModFoF2qo95CofqC0bPFy0U34ALzVtpISk9Y74Ol8ywVkJRJ5jmW19U8l1yuYkVRI/kJd1so0YNcopjXLmTyU6kpQBskBQlvCIvmgBOoWLPRHxW2q3uVe2eDD0yejp5GCHrcdY/XUW/bZmfGx1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751960026; c=relaxed/simple;
	bh=PmHqTzW/ysKFVmsSvmen1NCnARGYFMnQHFeLSs8l8lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbYJ1y+7AyMELcP8bOJ1gIWeXPL1LqqrxQpdi1PZp1IQANeOuSNKUfQnJaKhKgrlStyMymewzj7ijvrr4wJVT8llq5jNfL0dnj31imc+pM47Lj9oCJAMvjV5LQjGZ5eUde9YAOd+mADAI8H7MkbblcsFQZMyKp9EZp5Vq8gsD/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdUR9vjr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4330C4CEED;
	Tue,  8 Jul 2025 07:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751960025;
	bh=PmHqTzW/ysKFVmsSvmen1NCnARGYFMnQHFeLSs8l8lc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fdUR9vjrMxIkwiqRNrJVADFdJeji6nypTKhcEihHDRTA2h/J22q1Tmmu8j+Ls0sYd
	 HR4Ru7IFSZYFCA7maYTFO82m5LfMQDGi/q39l1K1vHeOH/+JQ190f+BNZaiBR+Xafk
	 w1Q60OLnd0/3hosS5xzhRLKPaX5uXth4kwH+82PmxB6aWmjkc5cKIKEwTIRNiLh5Xg
	 Yb0TsGHvAqc1HtYeD/zxSctNQGIKtA/33lfA1indcxVVNPehiWnlcvhnhLXyLJvUxJ
	 3tw7xO+t3KUyuo+JyVPn0ZfRE/nZJ6ABBEJTDtBt/TtxHIMctzLA2gzGr2pUvk0JDK
	 /ZU72mRv0fUPQ==
Date: Tue, 8 Jul 2025 09:33:42 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH net-next v2 2/7] net: airoha: npu: Add NPU wlan memory
 initialization commands
Message-ID: <aGzJ1vFufzBts_yG@lore-desk>
References: <20250705-airoha-en7581-wlan-offlaod-v2-0-3cf32785e381@kernel.org>
 <20250705-airoha-en7581-wlan-offlaod-v2-2-3cf32785e381@kernel.org>
 <20250707-agile-aardwolf-of-politeness-29fead@krzk-bin>
 <aGt2L1e3xbWVoqOO@lore-desk>
 <679e6fd2-967f-4057-9ccd-92a37ecc4819@kernel.org>
 <aGvmoJ83EtYOIa0K@lore-desk>
 <904d1165-185e-43ac-9b52-a2f17f774e80@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1ik0M2Sq3xJXAfM5"
Content-Disposition: inline
In-Reply-To: <904d1165-185e-43ac-9b52-a2f17f774e80@kernel.org>


--1ik0M2Sq3xJXAfM5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 07/07/2025 17:24, Lorenzo Bianconi wrote:
> >> On 07/07/2025 09:24, Lorenzo Bianconi wrote:
> >>>> On Sat, Jul 05, 2025 at 11:09:46PM +0200, Lorenzo Bianconi wrote:
> >>>>> +
> >>>>>  struct airoha_npu *airoha_npu_get(struct device *dev, dma_addr_t *=
stats_addr)
> >>>>>  {
> >>>>>  	struct platform_device *pdev;
> >>>>> @@ -493,6 +573,7 @@ static int airoha_npu_probe(struct platform_dev=
ice *pdev)
> >>>>>  	npu->ops.ppe_deinit =3D airoha_npu_ppe_deinit;
> >>>>>  	npu->ops.ppe_flush_sram_entries =3D airoha_npu_ppe_flush_sram_ent=
ries;
> >>>>>  	npu->ops.ppe_foe_commit_entry =3D airoha_npu_foe_commit_entry;
> >>>>> +	npu->ops.wlan_init_reserved_memory =3D airoha_npu_wlan_init_memor=
y;
> >>>>
> >>>> I cannot find in your code single place calling this (later you add a
> >>>> wrapper... which is not called either).
> >>>>
> >>>> All this looks like dead code...
> >>>
> >>> As pointed out in the commit log, these callbacks will be used by MT7=
6 driver
> >>> to initialize the NPU reserved memory and registers during driver pro=
be in
> >>> order to initialize the WiFi offloading. Since MT76 patches are going=
 via
> >>> the wireless tree, I needed to add these callbacks first.
> >>
> >> Cover letter does not link to your NPU patchset. You cannot add dead
> >> code to the kernel and now it is pure dead code. Post your user - in
> >> this or separate patchset.
> >=20
> > I guess you mean the related MT76 patches are not linked in the cover-l=
etter,
> > right? I have not posted them yet.
> >=20
> >>
> >> Your explanation of dependency is also confusing. If these are added to
> >> wireless tree (considering last experience how they rebase and cannot
> >> easily handle cross tree merges), how does it solve your problem? You
> >> will have it in one tree but not in the other, so still nothing...
> >> That's anyway separate problem, because main issue is you add code whi=
ch
> >> we cannot even verify how it is being used.
> >=20
> > My main point here is wireless tree can't acutally merge the MT76 patch=
es
> > since, without the net-next ones (this series), it will not compile (so=
 I
>=20
> This does not explain hiding the other part. Again - there is nothing
> weird in patchset dependencies. Weird is saying there is dependency, so
> I will not post code.

I have a working patchset for MT76 support. I have not posted it yet just
because I need to clean it up.

>=20
> > posted net-next patches as preliminary ones for MT76 changes).
> > Moreover, this is the same approach we used when we added WED support to
> > mtk_eth_soc driver and the related MT76 support.
> > However, I am fine to post the MT76 changes as RFC and just refer to it=
 in
> > this series cover-letter. Agree?=20
> >=20
> >>
> >> So far I see ABI break, but without user cannot judge. And that's the
> >> hard reason this cannot be accepted.
> >=20
> > if you mean the dts changes, I will fix them in v3.
> >=20
> No, I mean driver.

Sorry, can you please explain what is the ABI break in the driver codebase?
airoha_npu_wlan_init_memory() is executed by MT76 driver and not during NPU
probe phase.

Regards,
Lorenzo

>=20
> Best regards,
> Krzysztof

--1ik0M2Sq3xJXAfM5
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaGzJ1gAKCRA6cBh0uS2t
rJ70AQDKW9DjcfHQlFHvXGhHzlDeXGR1AkdPDGOzsgKZe3hC4wD/QgxrN3+Nr8M7
U9rFLAgI8fC2gByAD0uk/fsm/2EGDgE=
=0IG7
-----END PGP SIGNATURE-----

--1ik0M2Sq3xJXAfM5--

