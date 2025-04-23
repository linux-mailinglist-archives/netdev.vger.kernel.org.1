Return-Path: <netdev+bounces-185102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6887A9885C
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 13:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94F23188529D
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 11:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A2626FA41;
	Wed, 23 Apr 2025 11:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="opRbMOSh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349B11F3B83
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 11:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745407246; cv=none; b=a8FdPQkUHjZGVj4wXaedfwMI34Qgk5oEk/mqzkzFO6UO+6AFUdQKLJXrCwRlIkgsmnnrTdCNI0bK0/Je/cxVL9ZFhkpyXfqAa7hTdi36ZR72/QYor2JOXgdqF3Kd9Ab3R5DvegHnoMwwkhGRxCMd9aT9VCwCHyjhOALn5Gs76XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745407246; c=relaxed/simple;
	bh=65P2yTpP9ikdQkaNusQHi/VQHjNJozPS2sRudLvmzb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=utDfXRPKeqdYxUQSPHQnRp+YcGxLzZd2g7xlDmnjZAPIFnZvexe28ugxrs59RN6mDyML33pMArc3ZLDjs9hA6958KFatHv+jY0XMbOmhus12w/Uwuc2hIOFm/xI7ReneyPWbYzZYtmRpyfIinz6LdVmVCsO23U63CFSC4dXnMu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=opRbMOSh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CE80C4CEEF;
	Wed, 23 Apr 2025 11:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745407245;
	bh=65P2yTpP9ikdQkaNusQHi/VQHjNJozPS2sRudLvmzb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=opRbMOShB0/OUYO0pvUAhd7824ICrNR9B2Y4lsnbFb1F1y64mTQifjGSDwfQ+KCpJ
	 heovBjRnk6jFOXaMwAh67fBadX3dTv8p+wCSzRNwypkKyzqelaBy/jSbVwjOTLIFFJ
	 XRov3yvdHJSB1EE+s9uLVi7exNAdSy1oDsyvYVoMmMtQUGjHK5A5lQqdjw7qRLFDCt
	 9q9eqAugc3+SIjt9kJYYPxsyh+uFJvMQNW3Y6Qql5UBtLnf/p+6WaKfNoppOCABkwu
	 M6kPVrol6u/97p1avxJU1EPvbtAgmf2z3/YkZ/JzA73rbbchI+iNm/6Yq0rnpsr4dB
	 6MUBh7ydzGAXw==
Date: Wed, 23 Apr 2025 13:20:43 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net v3] net: airoha: Add missing filed to ppe_mbox_data
 struct
Message-ID: <aAjNC7zUrhc2Ma0z@lore-desk>
References: <20250422-airoha-en7581-fix-ppe_mbox_data-v3-1-87dd50d2956e@kernel.org>
 <c34ef8a0-20fd-4d0b-84cc-8f829f4be675@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8KAiwfBxBw0HvHWB"
Content-Disposition: inline
In-Reply-To: <c34ef8a0-20fd-4d0b-84cc-8f829f4be675@intel.com>


--8KAiwfBxBw0HvHWB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>=20
>=20
> On 4/22/2025 8:59 AM, Lorenzo Bianconi wrote:
> > The official Airoha EN7581 firmware requires adding max_packet filed in
> > ppe_mbox_data struct while the unofficial one used to develop the Airoha
> > EN7581 flowtable support does not require this field.
> > This patch does not introduce any real backwards compatible issue since
> > EN7581 fw is not publicly available in linux-firmware or other
> > repositories (e.g. OpenWrt) yet and the official fw version will use th=
is
> > new layout. For this reason this change needs to be backported.
> >=20
>=20
> To clarify if I understand correctly:
>=20
> The original data structure without max_packet is for an unreleased
> version of firmware which is unofficial and which is not released publicl=
y.

correct

>=20
> Then, the official public release will include this additional field,
> and thus won't work with the current kernel code.

correct

>=20
> Of course anyone who happens to have the unofficial firmware will need
> to work around this, but that should only include a small handful of
> folks with development images?

yes, right

>=20
> > Fixes: 23290c7bc190d ("net: airoha: Introduce Airoha NPU support")
> > Reviewed-by: Simon Horman <horms@kernel.org>
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> > Changes in v3:
> > - resend targeting net tree
> > - Link to v2: https://lore.kernel.org/r/20250417-airoha-en7581-fix-ppe_=
mbox_data-v2-1-43433cfbe874@kernel.org
> >=20
> > Changes in v2:
> > - Add more details to commit log
> > - Link to v1: https://lore.kernel.org/r/20250415-airoha-en7581-fix-ppe_=
mbox_data-v1-1-4408c60ba964@kernel.org
> > ---
> >  drivers/net/ethernet/airoha/airoha_npu.c | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/eth=
ernet/airoha/airoha_npu.c
> > index 7a5710f9ccf6a4a4f555ab63d67cb6b318de9b52..16201b5ce9f27866896226c=
3611b4a154d19bc2c 100644
> > --- a/drivers/net/ethernet/airoha/airoha_npu.c
> > +++ b/drivers/net/ethernet/airoha/airoha_npu.c
> > @@ -104,6 +104,7 @@ struct ppe_mbox_data {
> >  			u8 xpon_hal_api;
> >  			u8 wan_xsi;
> >  			u8 ct_joyme4;
> > +			u8 max_packet;
> >  			int ppe_type;
> >  			int wan_mode;
> >  			int wan_sel;
> >=20
>=20
> One oddity here is that the structure is not marked __packed. This
> addition of a u8 means there will be a 3-byte gap on platforms which
> have a 4-byte integer... It feels very weird these are ints and not s32
> or something to fully clarify the sizes.

yes, you are right. Let's hold on for a while with this patch and let me ask
Airoha folks if we can "pack" the struct in the NPU firmware binary so we c=
an use
__packed attribute here. In any case I will use "u32" instead of "int" in t=
he next
version.

Regards,
Lorenzo

>=20
> Regardless, assuming the correctness that the unofficial firmware is
> only available to developers and isn't widely available:
>=20
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
>=20
> > ---
> > base-commit: c03a49f3093a4903c8a93c8b5c9a297b5343b169
> > change-id: 20250422-airoha-en7581-fix-ppe_mbox_data-56df12d4df72
> >=20
> > Best regards,
>=20

--8KAiwfBxBw0HvHWB
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaAjNCwAKCRA6cBh0uS2t
rPiDAQDU27iVGbvQTRUgJz0etHDsJYWRsxVCk2Tpnk7nMfcGxAD+PGrxpM04Unxu
AM7bzNBJaFr0+ApT2IbNYFPvCJfa1wA=
=w26b
-----END PGP SIGNATURE-----

--8KAiwfBxBw0HvHWB--

