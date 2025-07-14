Return-Path: <netdev+bounces-206617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D49B03BA4
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 12:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A0F53BA7E0
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 10:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03114243369;
	Mon, 14 Jul 2025 10:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="faV4IGhr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA62218AA0;
	Mon, 14 Jul 2025 10:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752487768; cv=none; b=akA/4tMz5bf6KLJ0gt4Qe0ScENNAaRjrlmzpp7jJB6m5hBSWvIXjxnTgn0gDUQjaeZhjTnejfjQ91SaP/+Fs4f/92sNaKJaFuMeJFZgAwpTixUD4vV1gbw2pKeEkBDb+bW47BnHUbjW8t8wC9Uf8cLgxlw06qOPviIIK/dnFU7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752487768; c=relaxed/simple;
	bh=GkK3DkT/hUKSXHtNHhvB+gzC2lGV+LnAwQSWbGSKE6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gEBe0AwPeh0xNayU4jBkhPTrJJcYBWFL3Ak4Pz5DQ0jGMtXUN/CEkiDS/iPXM+LnUIe4EmPzLOORGdpI6F1gswR6MBUruUM+WLTm9I3lsIfO1Hqcn26SeJUZckIuJp+pXFb4fpJqO0Ciprnh1X3de5uCNhHtRlYCLqVk1E+ADt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=faV4IGhr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09072C4CEED;
	Mon, 14 Jul 2025 10:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752487768;
	bh=GkK3DkT/hUKSXHtNHhvB+gzC2lGV+LnAwQSWbGSKE6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=faV4IGhrwwPm7Xk3HAdpOK/5RPiCiaXiNxiuanEBjOZEaylhB1pK8uGlt+ACEdbJy
	 WStnLqumD05CeQsonqRO9aH+3G8tlby5aQJYsdw6IIrmsml8mH9dqlzjiJeQoIyuQZ
	 3iMeGUqixcmo6LlALxvp6uI6i4ErSip066C+9K7xXMpk+ZeuI5Gf3NvrjRLhscApq4
	 ONPUiNiFXooFhhDG4R9YsGQmwn06HCN+AKymqoxIiFt9Y/lUX2GF51BqCe2rbnUhY9
	 6k3z9F8CxNfgF/4PPzT0UHIKPUTNkwGr1Tk6EJTaxbh/XerCWxAYLTvJvi2dT7f8nq
	 RRc6R9x7VBbwg==
Date: Mon, 14 Jul 2025 12:09:25 +0200
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
Message-ID: <aHTXVQzo5pf9WvaF@lore-desk>
References: <20250705-airoha-en7581-wlan-offlaod-v2-0-3cf32785e381@kernel.org>
 <20250705-airoha-en7581-wlan-offlaod-v2-2-3cf32785e381@kernel.org>
 <20250707-agile-aardwolf-of-politeness-29fead@krzk-bin>
 <aGt2L1e3xbWVoqOO@lore-desk>
 <679e6fd2-967f-4057-9ccd-92a37ecc4819@kernel.org>
 <aGvmoJ83EtYOIa0K@lore-desk>
 <904d1165-185e-43ac-9b52-a2f17f774e80@kernel.org>
 <aGzJ1vFufzBts_yG@lore-desk>
 <623a647b-806a-4324-9c59-fcad3127f906@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="N4sH5cZnV86fq74t"
Content-Disposition: inline
In-Reply-To: <623a647b-806a-4324-9c59-fcad3127f906@kernel.org>


--N4sH5cZnV86fq74t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 08/07/2025 09:33, Lorenzo Bianconi wrote:
> >=20
> >>
> >>> posted net-next patches as preliminary ones for MT76 changes).
> >>> Moreover, this is the same approach we used when we added WED support=
 to
> >>> mtk_eth_soc driver and the related MT76 support.
> >>> However, I am fine to post the MT76 changes as RFC and just refer to =
it in
> >>> this series cover-letter. Agree?=20
> >>>
> >>>>
> >>>> So far I see ABI break, but without user cannot judge. And that's the
> >>>> hard reason this cannot be accepted.
> >>>
> >>> if you mean the dts changes, I will fix them in v3.
> >>>
> >> No, I mean driver.
> >=20
> > Sorry, can you please explain what is the ABI break in the driver codeb=
ase?
> > airoha_npu_wlan_init_memory() is executed by MT76 driver and not during=
 NPU
> > probe phase.
> >=20
>=20
> Read the first problem I pointed out - no user. Your new ABI returns
> error and you changed binding in incompatible way.
>=20
> Binding change is ABI break and its impact is impossible to judge due to
> missing code. I am speaking about this since beginning, but if you keep
> insisting that the driver does not matter then this is a NAK because you
> change ABI in the binding.

Please do not get me wrong, I was just trying to understand where the ABI
breakage is. I will post my MT76 changes as RFC and I will link that series
in the v3 cover letter so you can look at the new API user code.

Regards,
Lorenzo

>=20
>=20
> Best regards,
> Krzysztof

--N4sH5cZnV86fq74t
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaHTXVQAKCRA6cBh0uS2t
rACZAP9AyexJu6kQuZxCmXszphY7ttX/lmGO9BeyGtpAO+ZQXQD/ebhUOlm76q1y
hnCfV8C2VTjzBYpD1r7+JuQmdd0i0gc=
=9MXq
-----END PGP SIGNATURE-----

--N4sH5cZnV86fq74t--

