Return-Path: <netdev+bounces-229249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CB17CBD9CCB
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 15:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B4E304E9194
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 13:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E908320459A;
	Tue, 14 Oct 2025 13:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oTFS7isr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A6F199949;
	Tue, 14 Oct 2025 13:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760449574; cv=none; b=C02CtjfWQvPnnfIKhtr2ReCx3OcCZ3R7+hUM8qhweZd97lu+uFvwO1CvIO8ZD4wUHME7hNkgVIITd0eX5x8Gqm0ZqxIhk77Ujh9VuAEGQYnNfHhVuX8l4wrT4RtVtIgBE2jkxLpLzuMeNcpt4F+D1JzNJE9R/fk1sESlewE8vS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760449574; c=relaxed/simple;
	bh=1/iiJ1pUws2SIwvd6uEYF2UH4KkmPHjI8c7G8UkfUe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bbeHxk2h7YgGzplzIMMc3rMvdqhJaEtti74zZtTpxWGrHXoBdwcSAwsena2kQN3eXkSFiGZvKtzvK6jp6n4nk7Fp5/aUCqAbOXaG0ZXI3x63wpxApioDLSbACUnUvwDvxOTiU6S3T7q7F9hnRMDIlzm+/mgbbRAi4cQst3BsJgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTFS7isr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7FC0C4CEE7;
	Tue, 14 Oct 2025 13:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760449574;
	bh=1/iiJ1pUws2SIwvd6uEYF2UH4KkmPHjI8c7G8UkfUe8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oTFS7isr46L0jfmzYg7VUlWBAlOKhaLiSSALe74bUVABRnv9gFyGxG8xCLhW9DF/A
	 nqih8IM1uLh2DLkEzRJCtNeDUoj4/+tHic0ZOax6QsluF5inx8E8P4LEKpkifsAV3m
	 SKiZbwt1ZMTwnLeOYIVWxBmhhm5etmr00PXZQ95qEUuZ0S/tL5kNUCJI7wcQ24coBt
	 LENhOuwJR+PXn8qLhL7VueJ9IlK7eedtZAl5F4dRglKXGEDt4JFFCG6lYvL7EbTbWu
	 7Hirfu/PWYkb5sG2atULCHmKKjBrlNnr5d8oc3epLWcGvvy0dQlwRaC2HZIhjhnGHV
	 y1ODOEPSDyeEg==
Date: Tue, 14 Oct 2025 14:46:09 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
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
Message-ID: <20251014134609.GA3239414@horms.kernel.org>
References: <20251013-airoha-npu-7583-v3-0-00f748b5a0c7@kernel.org>
 <20251013-airoha-npu-7583-v3-2-00f748b5a0c7@kernel.org>
 <aO4LL8racazLjjzk@horms.kernel.org>
 <aO4WmeuoAcZLFSBo@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aO4WmeuoAcZLFSBo@lore-desk>

On Tue, Oct 14, 2025 at 11:23:37AM +0200, Lorenzo Bianconi wrote:
> > On Mon, Oct 13, 2025 at 03:58:50PM +0200, Lorenzo Bianconi wrote:
> > 
> > ...
> > 
> > > @@ -182,49 +192,53 @@ static int airoha_npu_send_msg(struct airoha_npu *npu, int func_id,
> > >  	return ret;
> > >  }
> > >  
> > > -static int airoha_npu_run_firmware(struct device *dev, void __iomem *base,
> > > -				   struct resource *res)
> > > +static int airoha_npu_load_firmware(struct device *dev, void __iomem *addr,
> > > +				    const struct airoha_npu_fw *fw_info)
> > >  {
> > >  	const struct firmware *fw;
> > > -	void __iomem *addr;
> > >  	int ret;
> > >  
> > > -	ret = request_firmware(&fw, NPU_EN7581_FIRMWARE_RV32, dev);
> > > +	ret = request_firmware(&fw, fw_info->name, dev);
> > >  	if (ret)
> > >  		return ret == -ENOENT ? -EPROBE_DEFER : ret;
> > >  
> > > -	if (fw->size > NPU_EN7581_FIRMWARE_RV32_MAX_SIZE) {
> > > +	if (fw->size > fw_info->max_size) {
> > >  		dev_err(dev, "%s: fw size too overlimit (%zu)\n",
> > > -			NPU_EN7581_FIRMWARE_RV32, fw->size);
> > > +			fw_info->name, fw->size);
> > >  		ret = -E2BIG;
> > >  		goto out;
> > >  	}
> > >  
> > > -	addr = devm_ioremap_resource(dev, res);
> > > -	if (IS_ERR(addr)) {
> > > -		ret = PTR_ERR(addr);
> > > -		goto out;
> > > -	}
> > > -
> > >  	memcpy_toio(addr, fw->data, fw->size);
> > > +out:
> > >  	release_firmware(fw);
> > >  
> > > -	ret = request_firmware(&fw, NPU_EN7581_FIRMWARE_DATA, dev);
> > > -	if (ret)
> > > -		return ret == -ENOENT ? -EPROBE_DEFER : ret;
> > > +	return ret;
> > > +}
> > >  
> > > -	if (fw->size > NPU_EN7581_FIRMWARE_DATA_MAX_SIZE) {
> > > -		dev_err(dev, "%s: fw size too overlimit (%zu)\n",
> > > -			NPU_EN7581_FIRMWARE_DATA, fw->size);
> > > -		ret = -E2BIG;
> > > -		goto out;
> > > -	}
> > > +static int airoha_npu_run_firmware(struct device *dev, void __iomem *base,
> > > +				   struct resource *res)
> > > +{
> > > +	const struct airoha_npu_soc_data *soc;
> > > +	void __iomem *addr;
> > > +	int ret;
> > >  
> > > -	memcpy_toio(base + REG_NPU_LOCAL_SRAM, fw->data, fw->size);
> > > -out:
> > > -	release_firmware(fw);
> > > +	soc = of_device_get_match_data(dev);
> > > +	if (!soc)
> > > +		return -EINVAL;
> > >  
> > > -	return ret;
> > > +	addr = devm_ioremap_resource(dev, res);
> > > +	if (IS_ERR(addr))
> > > +		return PTR_ERR(addr);
> > > +
> > > +	/* Load rv32 npu firmware */
> > > +	ret = airoha_npu_load_firmware(dev, addr, &soc->fw_rv32);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	/* Load data npu firmware */
> > > +	return airoha_npu_load_firmware(dev, base + REG_NPU_LOCAL_SRAM,
> > > +					&soc->fw_data);
> > 
> > Hi Lorenzo,
> 
> Hi Simon,
> 
> > 
> > There are two calls to airoha_npu_load_firmware() above.
> > And, internally, airoha_npu_load_firmware() will call release_firmware()
> > if an error is encountered.
> > 
> > But should release_firmware() be called for the firmware requested
> > by the first call to airoha_npu_load_firmware() if the second call fails?
> > Such clean-up seems to have been the case prior to this patch.
> 
> release_firmware() is intended to release the resources allocated by the
> corresponding call to request_firmware() in airoha_npu_load_firmware().
> According to my understanding we always run release_firmware() in
> airoha_npu_load_firmware() before returning to the caller. Even before this
> patch we run release_firmware() on the 'first' firmware image before requesting
> the second one. Am I missing something?
> 
> > 
> > Also, not strictly related. Should release_firmware() be called (twice)
> > when the driver is removed?
> 
> For the above reasons, it is not important to call release_firmware() removing
> the module. Agree?

Thanks, agreed.

For some reason I missed that release_firmware() is called in
airoha_npu_load_firmware() regardless of error - I thought it was only
in error paths for some reason.

So I agree that the firmware is always released by the time
airoha_npu_load_firmware() is returned. As thus there is never
a need to release it afterwards.

Reviewed-by: Simon Horman <horms@kernel.org>



