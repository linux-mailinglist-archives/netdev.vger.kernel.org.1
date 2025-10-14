Return-Path: <netdev+bounces-229250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AB38CBD9D10
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 15:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8CEE34E76C5
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 13:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AF526B2D5;
	Tue, 14 Oct 2025 13:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gyKslMt/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A7418A6B0;
	Tue, 14 Oct 2025 13:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760449964; cv=none; b=DmADw1jKJcw/r0z05XaEWbWfQDEC6m7xAKcnCR66W8e/KGDtcLZ1unf2pYhOKTAUKFZt5Ogsq2/XVF5jVXQCvRkFvogOeuHXESy6aRSI+0LG4Cbrqh5Diq0ICeAJ6poBJab8F6A6B4cH5DcvjMCG6g/yrOtPeeQJKguDagjeftU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760449964; c=relaxed/simple;
	bh=ssjsTqzEfEBT1gonGkyIguCeeCG6cNnHwZVkHgfQfPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hp9C98Q0wWV0aTKgTsOzCvVB3HYC4y2DRhiL9FvreUVZ9JRJVXPXlxHAAuiltaT74xeAbM7tuNNhxIZ0Lz+UNVusl9m4kNiyHHk5TYYqMmBD9G/M6rd3JFnWoj6QzJhDUjfgEevW3r8o5l9JClue4VyYbO2gud6EiI8sqLVd4uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gyKslMt/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2079DC113D0;
	Tue, 14 Oct 2025 13:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760449963;
	bh=ssjsTqzEfEBT1gonGkyIguCeeCG6cNnHwZVkHgfQfPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gyKslMt/Re73fKUgxWghdCYgF6656EvZDcTyasrTDRkn8ySxcPMqGtip7mgtwyOZ0
	 FBo4JuZ9fy5ala5yvrDcQuEkonoIDKOCSj8lE+Ag4AWeLpMAQpFalh0gKb8q7/a34C
	 vxiDUQ1U4Gre0vU3WwCZYwSLOxM2vA88recW2Bpuz7V3TqhG7mGf/rRtCAdNm4BulP
	 e88nzCKJhaQUBhAgvvYO9r6PGnWwacWNgraqXc3k6ZW1gJAQ1iYaNlZ/p1LNk7doo1
	 zZx9NatAG/BSJCKF8FktW7e9mWnbxyHFIuAKr3xFrh58dahsuoie4ygFDpZY/Iejop
	 AbnYJlcQZk04g==
Date: Tue, 14 Oct 2025 15:52:40 +0200
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
Message-ID: <aO5VqDegyOY9fVEK@lore-desk>
References: <20251013-airoha-npu-7583-v3-0-00f748b5a0c7@kernel.org>
 <20251013-airoha-npu-7583-v3-2-00f748b5a0c7@kernel.org>
 <aO4LL8racazLjjzk@horms.kernel.org>
 <aO4WmeuoAcZLFSBo@lore-desk>
 <20251014134609.GA3239414@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PckbZYlHLnwOdPvs"
Content-Disposition: inline
In-Reply-To: <20251014134609.GA3239414@horms.kernel.org>


--PckbZYlHLnwOdPvs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 14, Simon Horman wrote:
> On Tue, Oct 14, 2025 at 11:23:37AM +0200, Lorenzo Bianconi wrote:
> > > On Mon, Oct 13, 2025 at 03:58:50PM +0200, Lorenzo Bianconi wrote:
> > >=20
> > > ...
> > >=20
> > > > @@ -182,49 +192,53 @@ static int airoha_npu_send_msg(struct airoha_=
npu *npu, int func_id,
> > > >  	return ret;
> > > >  }
> > > > =20
> > > > -static int airoha_npu_run_firmware(struct device *dev, void __iome=
m *base,
> > > > -				   struct resource *res)
> > > > +static int airoha_npu_load_firmware(struct device *dev, void __iom=
em *addr,
> > > > +				    const struct airoha_npu_fw *fw_info)
> > > >  {
> > > >  	const struct firmware *fw;
> > > > -	void __iomem *addr;
> > > >  	int ret;
> > > > =20
> > > > -	ret =3D request_firmware(&fw, NPU_EN7581_FIRMWARE_RV32, dev);
> > > > +	ret =3D request_firmware(&fw, fw_info->name, dev);
> > > >  	if (ret)
> > > >  		return ret =3D=3D -ENOENT ? -EPROBE_DEFER : ret;
> > > > =20
> > > > -	if (fw->size > NPU_EN7581_FIRMWARE_RV32_MAX_SIZE) {
> > > > +	if (fw->size > fw_info->max_size) {
> > > >  		dev_err(dev, "%s: fw size too overlimit (%zu)\n",
> > > > -			NPU_EN7581_FIRMWARE_RV32, fw->size);
> > > > +			fw_info->name, fw->size);
> > > >  		ret =3D -E2BIG;
> > > >  		goto out;
> > > >  	}
> > > > =20
> > > > -	addr =3D devm_ioremap_resource(dev, res);
> > > > -	if (IS_ERR(addr)) {
> > > > -		ret =3D PTR_ERR(addr);
> > > > -		goto out;
> > > > -	}
> > > > -
> > > >  	memcpy_toio(addr, fw->data, fw->size);
> > > > +out:
> > > >  	release_firmware(fw);
> > > > =20
> > > > -	ret =3D request_firmware(&fw, NPU_EN7581_FIRMWARE_DATA, dev);
> > > > -	if (ret)
> > > > -		return ret =3D=3D -ENOENT ? -EPROBE_DEFER : ret;
> > > > +	return ret;
> > > > +}
> > > > =20
> > > > -	if (fw->size > NPU_EN7581_FIRMWARE_DATA_MAX_SIZE) {
> > > > -		dev_err(dev, "%s: fw size too overlimit (%zu)\n",
> > > > -			NPU_EN7581_FIRMWARE_DATA, fw->size);
> > > > -		ret =3D -E2BIG;
> > > > -		goto out;
> > > > -	}
> > > > +static int airoha_npu_run_firmware(struct device *dev, void __iome=
m *base,
> > > > +				   struct resource *res)
> > > > +{
> > > > +	const struct airoha_npu_soc_data *soc;
> > > > +	void __iomem *addr;
> > > > +	int ret;
> > > > =20
> > > > -	memcpy_toio(base + REG_NPU_LOCAL_SRAM, fw->data, fw->size);
> > > > -out:
> > > > -	release_firmware(fw);
> > > > +	soc =3D of_device_get_match_data(dev);
> > > > +	if (!soc)
> > > > +		return -EINVAL;
> > > > =20
> > > > -	return ret;
> > > > +	addr =3D devm_ioremap_resource(dev, res);
> > > > +	if (IS_ERR(addr))
> > > > +		return PTR_ERR(addr);
> > > > +
> > > > +	/* Load rv32 npu firmware */
> > > > +	ret =3D airoha_npu_load_firmware(dev, addr, &soc->fw_rv32);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	/* Load data npu firmware */
> > > > +	return airoha_npu_load_firmware(dev, base + REG_NPU_LOCAL_SRAM,
> > > > +					&soc->fw_data);
> > >=20
> > > Hi Lorenzo,
> >=20
> > Hi Simon,
> >=20
> > >=20
> > > There are two calls to airoha_npu_load_firmware() above.
> > > And, internally, airoha_npu_load_firmware() will call release_firmwar=
e()
> > > if an error is encountered.
> > >=20
> > > But should release_firmware() be called for the firmware requested
> > > by the first call to airoha_npu_load_firmware() if the second call fa=
ils?
> > > Such clean-up seems to have been the case prior to this patch.
> >=20
> > release_firmware() is intended to release the resources allocated by the
> > corresponding call to request_firmware() in airoha_npu_load_firmware().
> > According to my understanding we always run release_firmware() in
> > airoha_npu_load_firmware() before returning to the caller. Even before =
this
> > patch we run release_firmware() on the 'first' firmware image before re=
questing
> > the second one. Am I missing something?
> >=20
> > >=20
> > > Also, not strictly related. Should release_firmware() be called (twic=
e)
> > > when the driver is removed?
> >=20
> > For the above reasons, it is not important to call release_firmware() r=
emoving
> > the module. Agree?
>=20
> Thanks, agreed.
>=20
> For some reason I missed that release_firmware() is called in
> airoha_npu_load_firmware() regardless of error - I thought it was only
> in error paths for some reason.
>=20
> So I agree that the firmware is always released by the time
> airoha_npu_load_firmware() is returned. As thus there is never
> a need to release it afterwards.
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>
>=20
>=20

ack, thx for the review.

Regards,
Lorenzo

--PckbZYlHLnwOdPvs
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHQEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaO5VqAAKCRA6cBh0uS2t
rKOOAQDpkKyXdtPwflpBidM62ACL3W06z3Xjas/GK4+Y4rraYgD4+VvRgWRlYY8L
iT7Okq7FVtyyot/ZH4Lpb3VEMvSlCg==
=CTji
-----END PGP SIGNATURE-----

--PckbZYlHLnwOdPvs--

