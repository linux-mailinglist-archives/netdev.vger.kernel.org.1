Return-Path: <netdev+bounces-229103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A284BD832C
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 10:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BE9A74FA4AF
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 08:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDD030F812;
	Tue, 14 Oct 2025 08:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tHIx0Sgo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D17B30DEAC;
	Tue, 14 Oct 2025 08:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760430900; cv=none; b=WSJL+A/RviWtHa+w3VPsBRV6JGuuWc6blu19YOaSXLAblr+tAHB14eM7DR4Thg728CDLzfAT2fOa5AzYYXBx82Gg2ceEr4ReRr5somhzaySzcj4tgRFcnafsqGSDBmOqqvwMDbenKp4UyYEfXTLq6Ef5bOt4L5HVUuuyk8/TzNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760430900; c=relaxed/simple;
	bh=gGnn14nn19buRMsFjRJqbyXn30qMIF3FN4EV6y6JEeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oUaVpwqfyhYN3/g9dTo/3nW/DdCKcowaL2Z5nfYHyzGnFbgbIwd33MnTMIvOHO5Jfa1YT2jwXVRvJkHmUaS/OmfIkqs2NUyDYntFkXxRgaLw2mWQVCgwuFwEg4r+6isci0eKi3r/MaMKJgTUe+UDcK+TGzIHG5avvj94lMOFNxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tHIx0Sgo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E38A8C4CEE7;
	Tue, 14 Oct 2025 08:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760430900;
	bh=gGnn14nn19buRMsFjRJqbyXn30qMIF3FN4EV6y6JEeU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tHIx0SgodJOeDzujA35S/7ES7yp8Uk7ESghpMUhqxByViRCSIo/KXvI42CANg9ojV
	 x5iuVbl3u8GQtJdgi6aO169pFVNI4XcitOjhjh0+fphsg5qYezqLGl5mNiA1IOWGlA
	 41yekkmBZA3g0d6LSK/wCe1sQwe8UHBn9THRA5oa3IG0b3t7XSs0at/YJgplO0hwlc
	 /74/GdNCXcKlwOmOLWqca9l4E5ZwMuCNZ1BMz9q5pJ5CSJYp3fs4nVbzqX+I6Coery
	 7WXQYedgVZGYfhgyL+B5MfjgGpLwvOL5tfiaDkLa4D4H8IxBK6/SAHOp1p6qHf2hjJ
	 uk6KpDJfrDgxw==
Date: Tue, 14 Oct 2025 09:34:55 +0100
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
Message-ID: <aO4LL8racazLjjzk@horms.kernel.org>
References: <20251013-airoha-npu-7583-v3-0-00f748b5a0c7@kernel.org>
 <20251013-airoha-npu-7583-v3-2-00f748b5a0c7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013-airoha-npu-7583-v3-2-00f748b5a0c7@kernel.org>

On Mon, Oct 13, 2025 at 03:58:50PM +0200, Lorenzo Bianconi wrote:

...

> @@ -182,49 +192,53 @@ static int airoha_npu_send_msg(struct airoha_npu *npu, int func_id,
>  	return ret;
>  }
>  
> -static int airoha_npu_run_firmware(struct device *dev, void __iomem *base,
> -				   struct resource *res)
> +static int airoha_npu_load_firmware(struct device *dev, void __iomem *addr,
> +				    const struct airoha_npu_fw *fw_info)
>  {
>  	const struct firmware *fw;
> -	void __iomem *addr;
>  	int ret;
>  
> -	ret = request_firmware(&fw, NPU_EN7581_FIRMWARE_RV32, dev);
> +	ret = request_firmware(&fw, fw_info->name, dev);
>  	if (ret)
>  		return ret == -ENOENT ? -EPROBE_DEFER : ret;
>  
> -	if (fw->size > NPU_EN7581_FIRMWARE_RV32_MAX_SIZE) {
> +	if (fw->size > fw_info->max_size) {
>  		dev_err(dev, "%s: fw size too overlimit (%zu)\n",
> -			NPU_EN7581_FIRMWARE_RV32, fw->size);
> +			fw_info->name, fw->size);
>  		ret = -E2BIG;
>  		goto out;
>  	}
>  
> -	addr = devm_ioremap_resource(dev, res);
> -	if (IS_ERR(addr)) {
> -		ret = PTR_ERR(addr);
> -		goto out;
> -	}
> -
>  	memcpy_toio(addr, fw->data, fw->size);
> +out:
>  	release_firmware(fw);
>  
> -	ret = request_firmware(&fw, NPU_EN7581_FIRMWARE_DATA, dev);
> -	if (ret)
> -		return ret == -ENOENT ? -EPROBE_DEFER : ret;
> +	return ret;
> +}
>  
> -	if (fw->size > NPU_EN7581_FIRMWARE_DATA_MAX_SIZE) {
> -		dev_err(dev, "%s: fw size too overlimit (%zu)\n",
> -			NPU_EN7581_FIRMWARE_DATA, fw->size);
> -		ret = -E2BIG;
> -		goto out;
> -	}
> +static int airoha_npu_run_firmware(struct device *dev, void __iomem *base,
> +				   struct resource *res)
> +{
> +	const struct airoha_npu_soc_data *soc;
> +	void __iomem *addr;
> +	int ret;
>  
> -	memcpy_toio(base + REG_NPU_LOCAL_SRAM, fw->data, fw->size);
> -out:
> -	release_firmware(fw);
> +	soc = of_device_get_match_data(dev);
> +	if (!soc)
> +		return -EINVAL;
>  
> -	return ret;
> +	addr = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(addr))
> +		return PTR_ERR(addr);
> +
> +	/* Load rv32 npu firmware */
> +	ret = airoha_npu_load_firmware(dev, addr, &soc->fw_rv32);
> +	if (ret)
> +		return ret;
> +
> +	/* Load data npu firmware */
> +	return airoha_npu_load_firmware(dev, base + REG_NPU_LOCAL_SRAM,
> +					&soc->fw_data);

Hi Lorenzo,

There are two calls to airoha_npu_load_firmware() above.
And, internally, airoha_npu_load_firmware() will call release_firmware()
if an error is encountered.

But should release_firmware() be called for the firmware requested
by the first call to airoha_npu_load_firmware() if the second call fails?
Such clean-up seems to have been the case prior to this patch.

Also, not strictly related. Should release_firmware() be called (twice)
when the driver is removed?

>  }
>  
>  static irqreturn_t airoha_npu_mbox_handler(int irq, void *npu_instance)

...

