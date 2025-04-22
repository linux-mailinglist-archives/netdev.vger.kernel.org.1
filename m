Return-Path: <netdev+bounces-184689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 137FBA96DE8
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 16:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F257161C8E
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 14:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7286281345;
	Tue, 22 Apr 2025 14:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IIAfQZL9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827A6280A3A
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 14:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745330787; cv=none; b=PHmWXhMGny87yLI1xEZHp6C08wcBslFI4J5r2oNldoXDXYj77uVQQywitviTfRTkchxLteepFEEv2a7veoiAVjTdYK8pwE1pH5EFVGl2hEu/2HGclA/bReVsBKYrjOVyTyw/oI/G3urU6hZfIaOW0y9lANmlkTaJiqgiYhP8qpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745330787; c=relaxed/simple;
	bh=CtaCG5SyvKvnVAPK00rPM/KJJLyNDvl8auFq2J3k/uI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CW8mGZIuroAUbt0tQSNjRy3EnMEG6rO0bEtw/HjG6rIiayD2uV+erOxWj+roYtOwHnCd6yvm8hvfYP5WUULdioA92IaeDo8ESIKLS26e62Ci7uhi1rTHZEH2QdCVMnyJGRHvd5nwe6FAj3L6deXzlCSgFNkqQjVx+WfEq1vCtLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IIAfQZL9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B234C4CEEA;
	Tue, 22 Apr 2025 14:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745330786;
	bh=CtaCG5SyvKvnVAPK00rPM/KJJLyNDvl8auFq2J3k/uI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IIAfQZL9fQgIfVIGb0L9ht0MjiVsLAwWs9upaZ8fPknu9hkZ/Fpw39X1DIHFrns2N
	 ton2sut5F9fVzE0DRdGq7Ttg9SlsZvctgTjhkrYO0fYxa+16zux23IRSSWHahBRSTM
	 jS4jnzjWixltEPMyjFfl5KWaKEP8GCN5XK/8wDUsdsTlcI9kxwofJgkkvrGC0UXezq
	 ui2dUhoX4QuT9ZTKPb6N9p5vdOhIOaZ4/IHpLgDDuQewy6B8Lw+J90LvcAn7mFUjy7
	 CiG6ENvTtRZK2eto871T7K3Hq7i2qVJCspWKQPaS+0fpl0QOeykexE0Ff5ohp16a/9
	 dC0K1Kdh4ghhA==
Date: Tue, 22 Apr 2025 16:06:24 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v2] net: airoha: Add missing filed to
 ppe_mbox_data struct
Message-ID: <aAeiYFIIOyTVvMhw@lore-desk>
References: <20250417-airoha-en7581-fix-ppe_mbox_data-v2-1-43433cfbe874@kernel.org>
 <20250421183610.7bad877c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YKyKny5ZTTWVilj9"
Content-Disposition: inline
In-Reply-To: <20250421183610.7bad877c@kernel.org>


--YKyKny5ZTTWVilj9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, 17 Apr 2025 11:30:47 +0200 Lorenzo Bianconi wrote:
> > The official Airoha EN7581 firmware requires adding max_packet filed in
> > ppe_mbox_data struct while the unofficial one used to develop the Airoha
> > EN7581 flowtable support does not require this field.
> > This patch does not introduce any real backwards compatible issue since
> > EN7581 fw is not publicly available in linux-firmware or other
> > repositories (e.g. OpenWrt) yet and the official fw version will use th=
is
> > new layout. For this reason this change needs to be backported.
> >=20
> > Fixes: 23290c7bc190d ("net: airoha: Introduce Airoha NPU support")
>=20
> I'm not sure I agree with this fixes tag. The fixes tag should point=20
> to the earliest commit where any problem may be visible. IIUC you're
> targeting net-next because the structure is not used in net. So the
> Fixes tag should also point to some commit in net-next...
> If we leave it as is after the merge window stable bot will pull this
> commit into 6.15 for no good reason.

Hi Jakub,

actually the commit below is even present in the net tree. Since this is
required to work with the official airoha firmware, I guess I should repost
targeting net with the same Fixes tag. Agree?

Regards,
Lorenzo

commit 23290c7bc190def4e1ca61610992d9b7c32e33f3
Author: Lorenzo Bianconi <lorenzo@kernel.org>
Date:   Fri Feb 28 11:54:20 2025 +0100

    net: airoha: Introduce Airoha NPU support

    Packet Processor Engine (PPE) module available on EN7581 SoC populates
    the PPE table with 5-tuples flower rules learned from traffic forwarded
    between the GDM ports connected to the Packet Switch Engine (PSE) modul=
e.
    The airoha_eth driver can enable hw acceleration of learned 5-tuples
    rules if the user configure them in netfilter flowtable (netfilter
    flowtable support will be added with subsequent patches).
    airoha_eth driver configures and collects data from the PPE module via a
    Network Processor Unit (NPU) RISC-V module available on the EN7581 SoC.
    Introduce basic support for Airoha NPU module.
   =20
    Tested-by: Sayantan Nandy <sayantan.nandy@airoha.com>
    Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
    Signed-off-by: Paolo Abeni <pabeni@redhat.com>

> --=20
> pw-bot: cr

--YKyKny5ZTTWVilj9
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaAeiYAAKCRA6cBh0uS2t
rN+8AP9R7ZHRbO9irHC1fwakaSHs5lzuYIjCukAlC/qJVgOUjQD+KJmJnJP+PiRc
SoY+YA56aAOCed+gPMr7Tp3/vOmWlA4=
=wyH7
-----END PGP SIGNATURE-----

--YKyKny5ZTTWVilj9--

