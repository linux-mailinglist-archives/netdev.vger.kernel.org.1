Return-Path: <netdev+bounces-204230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E061AAF9A5C
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 20:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47D0B564F25
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 18:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81B820F076;
	Fri,  4 Jul 2025 18:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nb+16iYt"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDC71386B4;
	Fri,  4 Jul 2025 18:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751652832; cv=none; b=JsdWcR0H9j7+LK8ydYlSipxmoimYjTS7g2x2XVoSC0s3EyIdjx5pDop9OQ/HnLCjjDGfgd7tehV7ehoyU/Gu7t/JZevR7YwtsFoa5WW95e94jt4JUMinouj8AU7GxrJuaj9hoGlzBn2bZPkUrlcGpyPKFBRsVBb71m31rtHwGVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751652832; c=relaxed/simple;
	bh=o7Ztt88VULP2BvwY0jZdGOsO2+Hv20JRT5NbRvoQWW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RRsgJ38EUecYOAz13i0lKK+xwoOznEr9tv4lBKL+4TbrvxIOa9s5HGId5OO4mfeHPFGya0uOL5/6UoYCooIfwgxOzcLkKYdS04+dMZOGQERyJBivkeWfXUt4++M7s6cpaIZK+eJ7Nl84WUgRyUvEqj0DLywykrUIZblTi40qrSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nb+16iYt; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LQmG/00dUai8xgXuysJFRnSz/OOXAoKqduwrhGjZlk4=; b=nb+16iYt9PoADMr3zlGY2uR77T
	+c0GkSCyM0lMJRnc9hZ9ZG/KKluIRo573bl3YPxtQaJ2Obb/6KS1QNFXtK8IVZOV67HLGvZ1XnxIG
	638jBNdZWJvTpAd9blplVFpDeIeJCnoqD5z8mjskh9I6rrNLm7BQo+j044OaZWpQmryk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uXkuV-000HO3-4t; Fri, 04 Jul 2025 20:13:19 +0200
Date: Fri, 4 Jul 2025 20:13:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Dong Yibo <dong100@mucse.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
	andrew+netdev@lunn.ch, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/15] net: rnpgbe: Add basic mbx ops support
Message-ID: <80644ec1-a313-403a-82dd-62eb551442d3@lunn.ch>
References: <20250703014859.210110-1-dong100@mucse.com>
 <20250703014859.210110-4-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703014859.210110-4-dong100@mucse.com>

>  #define MBX_FEATURE_WRITE_DELAY BIT(1)
>  	u32 mbx_feature;
>  	/* cm3 <-> pf mbx */
> -	u32 cpu_pf_shm_base;
> -	u32 pf2cpu_mbox_ctrl;
> -	u32 pf2cpu_mbox_mask;
> -	u32 cpu_pf_mbox_mask;
> -	u32 cpu2pf_mbox_vec;
> +	u32 fw_pf_shm_base;
> +	u32 pf2fw_mbox_ctrl;
> +	u32 pf2fw_mbox_mask;
> +	u32 fw_pf_mbox_mask;
> +	u32 fw2pf_mbox_vec;

Why is a patch adding a new feature deleting code?

> +/**
> + * mucse_read_mbx - Reads a message from the mailbox
> + * @hw: Pointer to the HW structure
> + * @msg: The message buffer
> + * @size: Length of buffer
> + * @mbx_id: Id of vf/fw to read
> + *
> + * returns 0 if it successfully read message or else
> + * MUCSE_ERR_MBX.
> + **/
> +s32 mucse_read_mbx(struct mucse_hw *hw, u32 *msg, u16 size,

s32 is an unusual type for linux. Can the mbox actually return
negative amounts of data?

> +/**
> + * mucse_write_mbx - Write a message to the mailbox
> + * @hw: Pointer to the HW structure
> + * @msg: The message buffer
> + * @size: Length of buffer
> + * @mbx_id: Id of vf/fw to write
> + *
> + * returns 0 if it successfully write message or else
> + * MUCSE_ERR_MBX.

Don't invent new error codes. EINVAL would do.

> + **/
> +s32 mucse_write_mbx(struct mucse_hw *hw, u32 *msg, u16 size,
> +		    enum MBX_ID mbx_id)
> +{
> +	struct mucse_mbx_info *mbx = &hw->mbx;
> +	s32 ret_val = 0;
> +
> +	if (size > mbx->size)
> +		ret_val = MUCSE_ERR_MBX;
> +	else if (mbx->ops.write)
> +		ret_val = mbx->ops.write(hw, msg, size, mbx_id);
> +
> +	return ret_val;
> +}
> +static inline void mucse_mbx_inc_pf_ack(struct mucse_hw *hw,
> +					enum MBX_ID mbx_id)

No inline functions in C files. Let the compiler decide.

> +static s32 mucse_poll_for_msg(struct mucse_hw *hw, enum MBX_ID mbx_id)
> +{
> +	struct mucse_mbx_info *mbx = &hw->mbx;
> +	int countdown = mbx->timeout;
> +
> +	if (!countdown || !mbx->ops.check_for_msg)
> +		goto out;
> +
> +	while (countdown && mbx->ops.check_for_msg(hw, mbx_id)) {
> +		countdown--;
> +		if (!countdown)
> +			break;
> +		udelay(mbx->usec_delay);
> +	}
> +out:
> +	return countdown ? 0 : -ETIME;

ETIMEDOUT, not ETIME. Please use iopoll.h, not roll your own.

    Andrew

---
pw-bot: cr

