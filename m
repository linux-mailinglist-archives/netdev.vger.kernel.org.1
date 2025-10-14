Return-Path: <netdev+bounces-229133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EB6BD86BE
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 11:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E3B1C34EF26
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 09:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D66B2DCF7B;
	Tue, 14 Oct 2025 09:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OxijG8Ee"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C3A2080C1;
	Tue, 14 Oct 2025 09:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760433820; cv=none; b=i7GFO+8YncyvBJR3uSFs5oFpBR9IXZ4y0+jZqn01mbmVRZIbHO4MzgkYl28WNOUq+DTxncTSrmygTA0KhRv2obuqx+B/oKhDyFpFtFdNFzCzOYSJ5MTiuyD3SRIhynJtJ0BS6zjEcnyFcOnMIduHmMbcV5AM7Q/4cA8foR9kSe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760433820; c=relaxed/simple;
	bh=8UMDWUKXnpdCQC7p8eOw9etMN6k4kyh9pwqfBIRJJR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+/2PPU5IKa0qBPoYOX7y6j8jRDf+r07skhyDQIHtZBaas+m0ltctjcdz3mBAUilriQNRwfBD1Eo7b9M6+lSF/aHf0VujRecqcopPeUx37ZRXHubB5X/PJDXItz+TdSWDM+eaSS0iMwUZdjmF0jlR7u5/VRG8re5UOlqbvl6WK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OxijG8Ee; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AEAEC113D0;
	Tue, 14 Oct 2025 09:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760433820;
	bh=8UMDWUKXnpdCQC7p8eOw9etMN6k4kyh9pwqfBIRJJR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OxijG8Ee2g5+wVQnN1qVAuG8VcAY4HRVLn8vhSjOM7j7u/qSgp3Y1jBaIy50zEbUr
	 3UmR+WU+NNvFUBOoKX6jegmuW9xrZ8b3jTnCKA0LccwLcM2WJIhKjzkQzokmU4GCFT
	 p1C4gatH3OkYEwhVTUhG1+NaJsdWUZ6u4LIBleck60/q1eijpfs6FEBPl83NKAHsC+
	 hb+6Zyq4fTx4ghfJ8XGh0t4prBJwWp5HAK7oJ5X35ixzuIz3ouRm6F9xM23i35s67o
	 jW1aP4lFTsRyNPTSqQOGbBsTROYsZh7oszs1QwFMgghXEnRl9odRaf3Kl12TqZ48Z8
	 3NVfLEmJjjzkg==
Date: Tue, 14 Oct 2025 11:23:37 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v3 2/3] net: airoha: npu: Add
 airoha_npu_soc_data struct
Message-ID: <aO4WmeuoAcZLFSBo@lore-desk>
References: <20251013-airoha-npu-7583-v3-0-00f748b5a0c7@kernel.org>
 <20251013-airoha-npu-7583-v3-2-00f748b5a0c7@kernel.org>
 <aO4LL8racazLjjzk@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RC3OzpSHrP3UiKaL"
Content-Disposition: inline
In-Reply-To: <aO4LL8racazLjjzk@horms.kernel.org>


--RC3OzpSHrP3UiKaL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, Oct 13, 2025 at 03:58:50PM +0200, Lorenzo Bianconi wrote:
>=20
> ...
>=20
> > @@ -182,49 +192,53 @@ static int airoha_npu_send_msg(struct airoha_npu =
*npu, int func_id,
> >  	return ret;
> >  }
> > =20
> > -static int airoha_npu_run_firmware(struct device *dev, void __iomem *b=
ase,
> > -				   struct resource *res)
> > +static int airoha_npu_load_firmware(struct device *dev, void __iomem *=
addr,
> > +				    const struct airoha_npu_fw *fw_info)
> >  {
> >  	const struct firmware *fw;
> > -	void __iomem *addr;
> >  	int ret;
> > =20
> > -	ret =3D request_firmware(&fw, NPU_EN7581_FIRMWARE_RV32, dev);
> > +	ret =3D request_firmware(&fw, fw_info->name, dev);
> >  	if (ret)
> >  		return ret =3D=3D -ENOENT ? -EPROBE_DEFER : ret;
> > =20
> > -	if (fw->size > NPU_EN7581_FIRMWARE_RV32_MAX_SIZE) {
> > +	if (fw->size > fw_info->max_size) {
> >  		dev_err(dev, "%s: fw size too overlimit (%zu)\n",
> > -			NPU_EN7581_FIRMWARE_RV32, fw->size);
> > +			fw_info->name, fw->size);
> >  		ret =3D -E2BIG;
> >  		goto out;
> >  	}
> > =20
> > -	addr =3D devm_ioremap_resource(dev, res);
> > -	if (IS_ERR(addr)) {
> > -		ret =3D PTR_ERR(addr);
> > -		goto out;
> > -	}
> > -
> >  	memcpy_toio(addr, fw->data, fw->size);
> > +out:
> >  	release_firmware(fw);
> > =20
> > -	ret =3D request_firmware(&fw, NPU_EN7581_FIRMWARE_DATA, dev);
> > -	if (ret)
> > -		return ret =3D=3D -ENOENT ? -EPROBE_DEFER : ret;
> > +	return ret;
> > +}
> > =20
> > -	if (fw->size > NPU_EN7581_FIRMWARE_DATA_MAX_SIZE) {
> > -		dev_err(dev, "%s: fw size too overlimit (%zu)\n",
> > -			NPU_EN7581_FIRMWARE_DATA, fw->size);
> > -		ret =3D -E2BIG;
> > -		goto out;
> > -	}
> > +static int airoha_npu_run_firmware(struct device *dev, void __iomem *b=
ase,
> > +				   struct resource *res)
> > +{
> > +	const struct airoha_npu_soc_data *soc;
> > +	void __iomem *addr;
> > +	int ret;
> > =20
> > -	memcpy_toio(base + REG_NPU_LOCAL_SRAM, fw->data, fw->size);
> > -out:
> > -	release_firmware(fw);
> > +	soc =3D of_device_get_match_data(dev);
> > +	if (!soc)
> > +		return -EINVAL;
> > =20
> > -	return ret;
> > +	addr =3D devm_ioremap_resource(dev, res);
> > +	if (IS_ERR(addr))
> > +		return PTR_ERR(addr);
> > +
> > +	/* Load rv32 npu firmware */
> > +	ret =3D airoha_npu_load_firmware(dev, addr, &soc->fw_rv32);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Load data npu firmware */
> > +	return airoha_npu_load_firmware(dev, base + REG_NPU_LOCAL_SRAM,
> > +					&soc->fw_data);
>=20
> Hi Lorenzo,

Hi Simon,

>=20
> There are two calls to airoha_npu_load_firmware() above.
> And, internally, airoha_npu_load_firmware() will call release_firmware()
> if an error is encountered.
>=20
> But should release_firmware() be called for the firmware requested
> by the first call to airoha_npu_load_firmware() if the second call fails?
> Such clean-up seems to have been the case prior to this patch.

release_firmware() is intended to release the resources allocated by the
corresponding call to request_firmware() in airoha_npu_load_firmware().
According to my understanding we always run release_firmware() in
airoha_npu_load_firmware() before returning to the caller. Even before this
patch we run release_firmware() on the 'first' firmware image before reques=
ting
the second one. Am I missing something?

>=20
> Also, not strictly related. Should release_firmware() be called (twice)
> when the driver is removed?

For the above reasons, it is not important to call release_firmware() remov=
ing
the module. Agree?

Regards,
Lorenzo

>=20
> >  }
> > =20
> >  static irqreturn_t airoha_npu_mbox_handler(int irq, void *npu_instance)
>=20
> ...

--RC3OzpSHrP3UiKaL
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaO4WmQAKCRA6cBh0uS2t
rMoTAP9HdqSplLptTvESowj2txGAcrb/gc17fXY3RbXV9I2MoQEAokKGOUSeg9My
inH68eZk4H3dQS+CcqdVfpLwtEramQU=
=2u0A
-----END PGP SIGNATURE-----

--RC3OzpSHrP3UiKaL--

