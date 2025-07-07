Return-Path: <netdev+bounces-204607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E246AFB734
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 17:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 518501AA1090
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 15:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3200A2E3360;
	Mon,  7 Jul 2025 15:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vCuz4onV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A39518D65C;
	Mon,  7 Jul 2025 15:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751901860; cv=none; b=AyTIzkDXLporLDvXtLi5NICSR1VsiYBze75CuSNYN5A77Iy8KVz2R1LQuG1N81QE6jYsFLpGCXjFtQjOX4w30wlX50H9tKHAl7CcBpCjTMLjrEvuCx1WSqA6HXL2gkqCPlsRXSu/nglk8MT4QCqd0BeDPpXsSdHWVbjMA+j8tSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751901860; c=relaxed/simple;
	bh=oes/+xn1RurzvrkWTc5SPMVdbj1/SKqgEqmxACEehrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qvsly0XiMl8kQytunHpBTyd1ljuDDSoCbCnU9NyunJX0FeItywFRB4E+hmcd51zBWcU754GnRgU9lS2JCrM+FCiw64SkBX2B/tnYHh+Uf0wWEMFQQ7aCY1ZRyQ1j5ILlWDQC3+0jeXxW9e/Vjn7L6QC4sQrdV8PKn2h3dBYrJIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vCuz4onV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16595C4CEE3;
	Mon,  7 Jul 2025 15:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751901859;
	bh=oes/+xn1RurzvrkWTc5SPMVdbj1/SKqgEqmxACEehrM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vCuz4onVvZwugFdTpv7P/0j4lrHYxUcEusn5UZ6Sc3j7ztX/K+Gpa453lYKJ13EmY
	 z73CmYgE5BggoGsBNG5/6zY9fi98PeDM+w1CSjMwqWyqgM7Ul78pQk0mEtzaY9GIGc
	 QJsjHURQIfWsqtV6KZwGq/Z0xRsrUpk9RdMopt9wi8VtTduJvP6Ss1E0ZQrqPfgoZ7
	 XJQHZMgFVGIS2XWGtbkQKAZK+NZntMD0y28Zwk1/CGDBtGBj5ZwM/muNm8GFJVRRTq
	 8qPt404gevgFXZzBS/3g6qkNxDEKs8rvNdwx/TRROq9pFCHoW8EDcbbV4pHIRSTUCO
	 UQO2KdE3eXKtg==
Date: Mon, 7 Jul 2025 17:24:16 +0200
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
Message-ID: <aGvmoJ83EtYOIa0K@lore-desk>
References: <20250705-airoha-en7581-wlan-offlaod-v2-0-3cf32785e381@kernel.org>
 <20250705-airoha-en7581-wlan-offlaod-v2-2-3cf32785e381@kernel.org>
 <20250707-agile-aardwolf-of-politeness-29fead@krzk-bin>
 <aGt2L1e3xbWVoqOO@lore-desk>
 <679e6fd2-967f-4057-9ccd-92a37ecc4819@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OT/S5wyakOFftJE4"
Content-Disposition: inline
In-Reply-To: <679e6fd2-967f-4057-9ccd-92a37ecc4819@kernel.org>


--OT/S5wyakOFftJE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 07/07/2025 09:24, Lorenzo Bianconi wrote:
> >> On Sat, Jul 05, 2025 at 11:09:46PM +0200, Lorenzo Bianconi wrote:
> >>> +
> >>>  struct airoha_npu *airoha_npu_get(struct device *dev, dma_addr_t *st=
ats_addr)
> >>>  {
> >>>  	struct platform_device *pdev;
> >>> @@ -493,6 +573,7 @@ static int airoha_npu_probe(struct platform_devic=
e *pdev)
> >>>  	npu->ops.ppe_deinit =3D airoha_npu_ppe_deinit;
> >>>  	npu->ops.ppe_flush_sram_entries =3D airoha_npu_ppe_flush_sram_entri=
es;
> >>>  	npu->ops.ppe_foe_commit_entry =3D airoha_npu_foe_commit_entry;
> >>> +	npu->ops.wlan_init_reserved_memory =3D airoha_npu_wlan_init_memory;
> >>
> >> I cannot find in your code single place calling this (later you add a
> >> wrapper... which is not called either).
> >>
> >> All this looks like dead code...
> >=20
> > As pointed out in the commit log, these callbacks will be used by MT76 =
driver
> > to initialize the NPU reserved memory and registers during driver probe=
 in
> > order to initialize the WiFi offloading. Since MT76 patches are going v=
ia
> > the wireless tree, I needed to add these callbacks first.
>=20
> Cover letter does not link to your NPU patchset. You cannot add dead
> code to the kernel and now it is pure dead code. Post your user - in
> this or separate patchset.

I guess you mean the related MT76 patches are not linked in the cover-lette=
r,
right? I have not posted them yet.

>=20
> Your explanation of dependency is also confusing. If these are added to
> wireless tree (considering last experience how they rebase and cannot
> easily handle cross tree merges), how does it solve your problem? You
> will have it in one tree but not in the other, so still nothing...
> That's anyway separate problem, because main issue is you add code which
> we cannot even verify how it is being used.

My main point here is wireless tree can't acutally merge the MT76 patches
since, without the net-next ones (this series), it will not compile (so I
posted net-next patches as preliminary ones for MT76 changes).
Moreover, this is the same approach we used when we added WED support to
mtk_eth_soc driver and the related MT76 support.
However, I am fine to post the MT76 changes as RFC and just refer to it in
this series cover-letter. Agree?=20

>=20
> So far I see ABI break, but without user cannot judge. And that's the
> hard reason this cannot be accepted.

if you mean the dts changes, I will fix them in v3.

Regards,
Lorenzo

>=20
> Best regards,
> Krzysztof

--OT/S5wyakOFftJE4
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaGvmoAAKCRA6cBh0uS2t
rDczAPsFgaNtjWprKaC6Z+VfmUNzguMJ9HSaKYKBDoZw5TyM1gD8CclHT+w5VNy/
s041k48snp6/uVkoTA4CjRMJt0+DKQM=
=aXb3
-----END PGP SIGNATURE-----

--OT/S5wyakOFftJE4--

