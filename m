Return-Path: <netdev+bounces-226732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C187BA4896
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 18:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 126CE7B3B10
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 16:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC3123B628;
	Fri, 26 Sep 2025 16:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPjBmudZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3467D233149;
	Fri, 26 Sep 2025 16:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758902510; cv=none; b=MJGLYIw6K6/s5SyyDc4r7PjnMLhyuTDwlPT1weY+cmiWA0mp3El9UM0i6pu7mjZZODGrUDAQyR/CX6Wr8Ef4J3JMdhNaSVGklSAj1gESQO8BUWgEtGlkJYdWJTExW0jrQI1/fMc1ejBKh1s5qMY85OhwURXVd7gO392vh/U8ZRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758902510; c=relaxed/simple;
	bh=YM8IV0+v374wnHxVVm/Vnnd8QnjR389XXK1l3TAj00o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E143tnOsc/OQCSfyvyuDWAvyl7tajolhD7OToHbHzWfxMiJfNacCVkv0KkVXmDGa5PzrEORwV7HIi+yB8QeriragdWZ1LhhzQZsqbqkFc7S8g/kXE52YkFNzRfzsnxsrX8pV2m0yyNb1/vqUJVm2K8d5SUtDdzZwF7lTJIAOJhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QPjBmudZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 718ACC4CEF7;
	Fri, 26 Sep 2025 16:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758902509;
	bh=YM8IV0+v374wnHxVVm/Vnnd8QnjR389XXK1l3TAj00o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QPjBmudZnf09hWZOTPBa90uUNc78OHxilarHsju0QpVLdXDTZf5eMwPs+QusAhLFa
	 ZH7B9f4yMUW9krRsFQ0nxlxRbBsRghqnvFXL3RYoSvlnPLwAR4TrFUTRli3MrPiCAW
	 KUDMgFp4AIs6K6V85SmYlShCmOajgcwWEQF/5z0DjBQ4M52DPlKNwJZS5gTi5J1CFV
	 +8RGq3rsSNFROXlne4G2uxcWwdQ4AgrrD5T+77XaENVQ7LCJ5nCu3B48CNX/+NhX68
	 BBLcMdcMtCTo1hyITS9Ahzlk1pUefKnb8VGOcLzvJtDkTFBTD5kOKG+rt4ZKUipMNN
	 O6BqmVtYm1puQ==
Date: Fri, 26 Sep 2025 18:01:47 +0200
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
Subject: Re: [PATCH net-next 2/2] net: airoha: npu: Add 7583 SoC support
Message-ID: <aNa464zcFCvNhL33@lore-desk>
References: <20250926-airoha-npu-7583-v1-0-447e5e2df08d@kernel.org>
 <20250926-airoha-npu-7583-v1-2-447e5e2df08d@kernel.org>
 <82a08bb5-cbc3-4bba-abad-393092d66557@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hB/pAcwWM8gt6iYi"
Content-Disposition: inline
In-Reply-To: <82a08bb5-cbc3-4bba-abad-393092d66557@lunn.ch>


--hB/pAcwWM8gt6iYi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > -	ret =3D request_firmware(&fw, NPU_EN7581_FIRMWARE_DATA, dev);
> > +	if (of_device_is_compatible(dev->of_node, "airoha,an7583-npu"))
> > +		fw_name =3D NPU_AN7583_FIRMWARE_DATA;
> > +	else
> > +		fw_name =3D NPU_EN7581_FIRMWARE_DATA;
> > +	ret =3D request_firmware(&fw, fw_name, dev);
> >  	if (ret)
> >  		return ret =3D=3D -ENOENT ? -EPROBE_DEFER : ret;
> > =20
> > @@ -612,6 +623,7 @@ EXPORT_SYMBOL_GPL(airoha_npu_put);
> > =20
> >  static const struct of_device_id of_airoha_npu_match[] =3D {
> >  	{ .compatible =3D "airoha,en7581-npu" },
> > +	{ .compatible =3D "airoha,an7583-npu" },
>=20
> It would be more normal to make use of the void * in of_device_id to
> have per compatible data, such are firmware name.
>=20
> 	Andrew

ack, I implemted this way since we have 2 fw names but we can have a struct
pointed by of_device_id driver_data pointer to contains both of them.
What do you think?

Regards,
Lorenzo

--hB/pAcwWM8gt6iYi
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaNa46wAKCRA6cBh0uS2t
rPX0AP4jYjmSFYol3JmGbMp9YCs2mGaQp8A9OZ1MuJvwphnyXgEAyEhcgj/ytZnA
tBXvUeNCKzmn5hurXo642VMuHkx7dAg=
=aHsk
-----END PGP SIGNATURE-----

--hB/pAcwWM8gt6iYi--

