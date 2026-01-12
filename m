Return-Path: <netdev+bounces-249025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAF9D12D89
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 14:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F28523015AAC
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 13:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA3A358D07;
	Mon, 12 Jan 2026 13:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tk5eb7kb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D44F3587A1;
	Mon, 12 Jan 2026 13:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768224960; cv=none; b=qIioVX1Pp29xrZaauG+OaJT5KLdGL84dp+EfrqoNDEcgzhLEzJzEwxYX89JACwu2QPWV2lygUD5S14O3M+QJ/v4FRVm4k6EzUk/m5Lz8EYMYUAVXvd+ZgJMWw5SxX/2UbP7EgHe9HqNgzYYSALWP3zMpjPyJ/kcGrH80SlmuSPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768224960; c=relaxed/simple;
	bh=wx3vwavyvgTGfzp6h8X47zsgs32m0wRi01cnEWDyyOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hku3qUsJFbcbd8nEfEYUkDRWI7TpXovVzSu3F3cWNKnWFDduyUKJgtYe+3pV2SLmVXyMjJnVRVkPagmRMH3xNsFA5JvBsrroA8TNyf9klsksMwRpKk9b1iK1zDLTgcA2SqG+QyVVQ8Rz9zlQNR7EhtxgYYuwSC5HM3qC3FB0nUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tk5eb7kb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69A42C16AAE;
	Mon, 12 Jan 2026 13:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768224959;
	bh=wx3vwavyvgTGfzp6h8X47zsgs32m0wRi01cnEWDyyOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tk5eb7kbHiRVP3gn5HFlTgUmg4oXCcb/K5L3CwpyJHARmM3ebvLZPjhqc6PkGIwvx
	 og85amj9ERx0QUp3k/HAwRrxRMT5gUjjFGvjhRcUp/LwU4JqPudjQjOku4AsbGtCrO
	 4fyRBfh2HdlmGkf+v0MbWRUs5RMn+5EQkxqwk1C6d0xLsCWqB5NAHLDNovLU+XH1C3
	 40gPyOcmD9rk1assyM5T7Pn/+jin9a1xpdHANmbtp5+kiQQcQOTrvV0YtFlEHIJLxa
	 wZiX9b78BDhj5FRXo5fmtct5rVnnn++TGTFOyYbvY9VQ0NVt5BD3lq+5XJ7Dujw3q5
	 dY4jzerfhOhOA==
Date: Mon, 12 Jan 2026 14:35:57 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next 2/2] net: airoha: npu: Add the capability to
 read firmware names from dts
Message-ID: <aWT4vcBzG6UnaqOF@lore-desk>
References: <20260112-airoha-npu-firmware-name-v1-0-d0b148b6710f@kernel.org>
 <20260112-airoha-npu-firmware-name-v1-2-d0b148b6710f@kernel.org>
 <f57867a0-a57d-4572-b0ed-b2adb41d9689@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ACHKGX5J56MzbVwz"
Content-Disposition: inline
In-Reply-To: <f57867a0-a57d-4572-b0ed-b2adb41d9689@lunn.ch>


--ACHKGX5J56MzbVwz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, Jan 12, 2026 at 11:00:08AM +0100, Lorenzo Bianconi wrote:
> > Introduce the capability to read the firmware binary names from device-=
tree
> > using the firmware-name property if available.
> > This is a preliminary patch to enable NPU offloading for MT7996 (Eagle)
> > chipset since it requires a different binary with respect to the one
> > used for MT7992 on the EN7581 SoC.
>=20
> When i look at
>=20
> airoha_npu.c
>=20
> i see:
>=20
> #define NPU_EN7581_FIRMWARE_DATA                "airoha/en7581_npu_data.b=
in"
> #define NPU_EN7581_FIRMWARE_RV32                "airoha/en7581_npu_rv32.b=
in"
> #define NPU_AN7583_FIRMWARE_DATA                "airoha/an7583_npu_data.b=
in"
> #define NPU_AN7583_FIRMWARE_RV32                "airoha/an7583_npu_rv32.b=
in"
>=20
> static const struct airoha_npu_soc_data en7581_npu_soc_data =3D {
>         .fw_rv32 =3D {
>                 .name =3D NPU_EN7581_FIRMWARE_RV32,
>                 .max_size =3D NPU_EN7581_FIRMWARE_RV32_MAX_SIZE,
>         },
>         .fw_data =3D {
>                 .name =3D NPU_EN7581_FIRMWARE_DATA,
>                 .max_size =3D NPU_EN7581_FIRMWARE_DATA_MAX_SIZE,
>         },
> };
>=20
> static const struct airoha_npu_soc_data an7583_npu_soc_data =3D {
>         .fw_rv32 =3D {
>                 .name =3D NPU_AN7583_FIRMWARE_RV32,
>                 .max_size =3D NPU_EN7581_FIRMWARE_RV32_MAX_SIZE,
>         },
>         .fw_data =3D {
>                 .name =3D NPU_AN7583_FIRMWARE_DATA,
>                 .max_size =3D NPU_EN7581_FIRMWARE_DATA_MAX_SIZE,
>         },
> };
>=20
> static const struct of_device_id of_airoha_npu_match[] =3D {
>         { .compatible =3D "airoha,en7581-npu", .data =3D &en7581_npu_soc_=
data },
>         { .compatible =3D "airoha,an7583-npu", .data =3D &an7583_npu_soc_=
data },
>         { /* sentinel */ }
> };
>=20
> Why cannot this scheme be extended with another compatible?

yes, that is another possibility I was thinking of but then I found
"firwmare-name" property was quite a common approach.
Something like:

static const struct of_device_id of_airoha_npu_match[] =3D {
	...
	{ .compatible =3D "airoha,en7581-npu-7996", .data =3D &en7581_7996_npu_soc=
_data },
	...
};

What do you think?

Regards,
Lorenzo

>=20
>     Andrew

--ACHKGX5J56MzbVwz
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaWT4vQAKCRA6cBh0uS2t
rHYNAQDGH3oT5hXKQNMrulNWdI8aXsyBx9SNvaFF4mgjMtA1iAD+KAgmsi6pfWp5
lz+BZ302fPMsRSq5ALTDn3pqwONpUw4=
=Ka0P
-----END PGP SIGNATURE-----

--ACHKGX5J56MzbVwz--

