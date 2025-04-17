Return-Path: <netdev+bounces-183676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD5EA91828
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 11:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1E6A443678
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 09:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0E7225A3D;
	Thu, 17 Apr 2025 09:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJRO9ygl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A460205E00
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 09:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744882828; cv=none; b=DMBXkYdBpuqKu99Lpf5KrKnCcLLjwmby8MxkUW6XxwOlAmbHD1C98g6oOgXxl119Zt+ihqou7zxBXDC4MAnBRycxVbRkRa/pGVcULtFjK4VdsBEckvkupUNCV45ktvkfi0gtULAv79ZInJGLJ0KPL4FpIcBfqswP8/O45Dc5WYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744882828; c=relaxed/simple;
	bh=oztNe+62TOePl7PmTJB2o1KTEoJOYLtNxh9fbyr6Y+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ky1wTFe0v8CCHnQYTsUgcLX5IULSrccLdNWKDUFVGqbEuuw5+kwjaNQWKkwTp23e1jkgqFvUVtTHtB2JpCtIXm+SP4NEsM20/sTP5cuM1NaqMpej32KoJx5YhVlp41i5/xfE4jgXb9mCP7nEV4ZvphKqFeVTVYHFaUWrV8SjswM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJRO9ygl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9105EC4CEEA;
	Thu, 17 Apr 2025 09:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744882828;
	bh=oztNe+62TOePl7PmTJB2o1KTEoJOYLtNxh9fbyr6Y+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OJRO9yglH0/zdjfhzDeZN8sEkS11lGoMRTT4JXFciq9R5kPYpEEEFiwJp+jpsBnlk
	 rbQ/onI1l1Kf08rTseJo6WS7E+0kqc8jdREOERth9Ho9aTWiOO7F3n9KBCUCXohuky
	 j1f1G+tExB8dTRz7LM/uxgWccBwXpe+2fJ2g4zVPDMCRpvybZv9ffFFCZoZIOhccAZ
	 BUpzGNMrPS64FVWqHgvumf+rx8IDpt9gjrD/nxMXqGMACxGEnWkUtSDRCoeMIEl+9c
	 auwqT96IckG9jDk5mG7MHDR63Vnzp35uNO2gLk8tGWbwj0gdaO8FwhJ/B1qDNDmvb+
	 PMKw1I+5s9A9w==
Date: Thu, 17 Apr 2025 11:40:25 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: airoha: Add missing filed to ppe_mbox_data
 struct
Message-ID: <aADMiRyhU_Qkc7qn@lore-desk>
References: <20250415-airoha-en7581-fix-ppe_mbox_data-v1-1-4408c60ba964@kernel.org>
 <20250416154144.GT395307@horms.kernel.org>
 <Z__S_m9fBEKmoos1@lore-desk>
 <ba5b4313-6e42-4340-8301-239dac046424@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="I/38EiJkfegtg/Bb"
Content-Disposition: inline
In-Reply-To: <ba5b4313-6e42-4340-8301-239dac046424@redhat.com>


--I/38EiJkfegtg/Bb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 4/16/25 5:55 PM, Lorenzo Bianconi wrote:
> >> On Tue, Apr 15, 2025 at 09:27:21AM +0200, Lorenzo Bianconi wrote:
> >>> The official Airoha EN7581 firmware requires adding max_packet filed =
in
> >>> ppe_mbox_data struct while the unofficial one used to develop the Air=
oha
> >>> EN7581 flowtable offload does not require this field. This patch fixes
> >>> just a theoretical bug since the Airoha EN7581 firmware is not posted=
 to
> >>> linux-firware or other repositories (e.g. OpenWrt) yet.
> >>>
> >>> Fixes: 23290c7bc190d ("net: airoha: Introduce Airoha NPU support")
> >>> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> >>> ---
> >>>  drivers/net/ethernet/airoha/airoha_npu.c | 1 +
> >>>  1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/e=
thernet/airoha/airoha_npu.c
> >>> index 7a5710f9ccf6a4a4f555ab63d67cb6b318de9b52..16201b5ce9f2786689622=
6c3611b4a154d19bc2c 100644
> >>> --- a/drivers/net/ethernet/airoha/airoha_npu.c
> >>> +++ b/drivers/net/ethernet/airoha/airoha_npu.c
> >>> @@ -104,6 +104,7 @@ struct ppe_mbox_data {
> >>>  			u8 xpon_hal_api;
> >>>  			u8 wan_xsi;
> >>>  			u8 ct_joyme4;
> >>> +			u8 max_packet;
> >>>  			int ppe_type;
> >>>  			int wan_mode;
> >>>  			int wan_sel;
> >>
> >> Hi Lorenzo,
> >>
> >> I'm a little confused by this.
> >>
> >> As I understand it ppe_mbox_data is sent as the data of a mailbox mess=
age
> >> send to the device.  But by adding the max_packet field the layout is
> >> changed. The size of the structure changes. And perhaps more important=
ly
> >> the offset of fields after max_packet, e.g.  wan_mode, change.
> >>
> >> Looking at how this is used, f.e. in the following code, I'm unclear on
> >> how this change is backwards compatible.
> >=20
> > you are right Simon, this change is not backwards compatible but the fw=
 is
> > not publicly available yet and the official fw version will use this ne=
w layout
> > (the previous one was just a private version I used to develop the driv=
er).
> > Can we use this simple approach or do you think we should differentiate=
 the two
> > firmware version in some way? (even if the previous one will never be u=
sed).
>=20
> I think it's better if you clarify the commit message. I read the above
> as the current (unpatched) code will not work with the official
> firmware, so bug addressed here does not look theoretical.

ack, I will fix it in v2.

Regards,
Lorenzo

>=20
> Thanks,
>=20
> Paolo
>=20

--I/38EiJkfegtg/Bb
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaADMiQAKCRA6cBh0uS2t
rJ67AP9cbyNfuXlCcIDCbznlmoFvGbjYrj48AEnIBLv7nvvs5wEAsKnFcqsQrIR+
qejGeo2uGi0ksWaTIT+CaDF6LBPaBQ8=
=GURb
-----END PGP SIGNATURE-----

--I/38EiJkfegtg/Bb--

