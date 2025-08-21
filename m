Return-Path: <netdev+bounces-215439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2F9B2EAEF
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 03:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 308C25E494F
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 01:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B940324BCF5;
	Thu, 21 Aug 2025 01:44:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6891E1D54FE
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 01:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755740668; cv=none; b=j0o8tj1CYD0A5cCvjc3BAK+tj0kGkpkk4DhShMXaXSjZ4KUySdWg4kEZ0rMm+AvLX+2S3+ZFNrS9MjdihZvm2SV74ZNCim3xnXR6gSqL6opqvh2CHbhK9eM5h7/EPCRLi9M72zrKz4QVKrKYFFppJIB7HHjNclc4r1/IvkscDRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755740668; c=relaxed/simple;
	bh=/spv7jWo69UbbuIZnbqkbS+7Kk/f7i+A+U1mM8kITus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFp1dZIGyS2c4qLW3FD+RZIFfAv+R+ICKf3TSg0OS5b33trKGrMqym77enH4khKlKNzuQsVfjTUVBgnoVxCopjq8/nuLUth4pXDRIuQLAtq3urZ2H6H4Q/wR4jR1/FqyGfi1dTWaRNDvNBT8a5xsRYVU36V0xrYN6pmLwhQpuO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpgz16t1755740653t744f92ac
X-QQ-Originating-IP: sSkp9uld1sPBcAjgjwrJDFdHIEDs46stzol3q4J49GU=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 21 Aug 2025 09:44:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11662485468357027338
Date: Thu, 21 Aug 2025 09:44:11 +0800
From: Yibo Dong <dong100@mucse.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/5] net: rnpgbe: Add basic mbx ops support
Message-ID: <6981CF6C1312658E+20250821014411.GB1742451@nic-Precision-5820-Tower>
References: <20250818112856.1446278-1-dong100@mucse.com>
 <20250818112856.1446278-4-dong100@mucse.com>
 <5cced097-52db-41c9-93e4-927aab5ffb2e@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cced097-52db-41c9-93e4-927aab5ffb2e@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: M75I2DDAzREFMtYwJAvfGXNR2mhOFgUILJCSe2syUJRDSAIUP8hCWTjf
	fpxrGmLZkZ+CvANSbvspFTUJLVdEHAJsC1TUrlag4oRYllFIX4z9/1KMo2gYFHXcXSsBIVA
	2r7CtvYI63BouGYZUWfjRoZS86vNuj/HikXBx++bKFOcsnUAZC2Bxk61gZ2n4UKRRsz1QYo
	ddQblflY3UMsxjgaiDrsEBe3bTJry+rbz4IdgJaHjrXY8R2vTFJojcd7vU9XBFPDZYjc7G2
	TmH0LM3bPpqUgdbt16HBzccOhg4R6j9n4NNGngb7JJ+r4XpP8iAh6D+BrhcHEzuv2bq8q7q
	EFxMH5JiDkAU72ArpFoj66IQWx/swhwUC5V0wnDGqd4cQXwRBPIMthUvKrItzhGmQDz7vzj
	1yRsF0eG+JMpKSx/ZEZuPaz9CKsDQQrU4GtCSnSNNfefFgAW4ZMaPgXSOaWyVDPZGMSZZjF
	nN4HXUIQcyNzx9UJHZuKLDyGDX7AC7Q5PJUgn1gwh/2kOJGHJQHB+2aOFucg8z5jpmWeg1c
	txxti822MTkKfpX24aTfhFAm4UDIc9M5KWOsHvUosBHKGewReDYeX/aRmyd1Zmj7gbCATn2
	vsGXoV87SsiDHRU1ozQWidAP63wq60kJbjw+ZB0eZTighm9xmMkJ2RZBn2ojjV7WnRIYZwi
	AZaXBuSOhXPNKWn2LKbZraoVc8gxIPn0SJ/LsoC8Yaf3DK1PMz9DXccvbp1+qaWMjI7JPas
	QPrRFWpo77x2m6g8+23Jx19YfO+xAhhGWhzJQVEK8MvDaMJMDKnHSg0dprvNcpfZ/i5fLdS
	Mp1LU1FN+q7cxQ3/Vw5wOt4DipOe3nfQow5aj8bKCml9AEImQyaCPvc65vI2bn/CufJSM+T
	ZY4i9wqBtapwUX6ke9xahTdN8NgdY+dMd1dy02FGlpYauXLoKzgF27KB5Hc3Bsxr3egjKwl
	zf9n5k64MEptq52AJV63nnZjsatQJy+asCGU/dobqxTelFKSQDsSjG3bBC0PHJxgCVXUrIe
	q1N7yWuwiaEnD1bVoxnKU6dwr4vp0=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

On Wed, Aug 20, 2025 at 10:23:44PM +0200, Andrew Lunn wrote:
> > +/**
> > + * mucse_mbx_get_ack - Read ack from reg
> > + * @mbx: pointer to the MBX structure
> > + * @reg: register to read
> > + *
> > + * @return: the ack value
> > + **/
> > +static u16 mucse_mbx_get_ack(struct mucse_mbx_info *mbx, int reg)
> > +{
> > +	return (mbx_data_rd32(mbx, reg) >> 16);
> > +}
> 
> > +static int mucse_check_for_ack_pf(struct mucse_hw *hw)
> > +{
> > +	struct mucse_mbx_info *mbx = &hw->mbx;
> > +	u16 hw_fw_ack;
> > +
> > +	hw_fw_ack = mucse_mbx_get_ack(mbx, MBX_FW2PF_COUNTER);
> 
> > +int mucse_write_mbx_pf(struct mucse_hw *hw, u32 *msg, u16 size)
> > +{
> > +	struct mucse_mbx_info *mbx = &hw->mbx;
> > +	int size_inwords = size / 4;
> > +	u32 ctrl_reg;
> > +	int ret;
> > +	int i;
> > +
> > +	ctrl_reg = PF2FW_MBOX_CTRL(mbx);
> > +	ret = mucse_obtain_mbx_lock_pf(hw);
> > +	if (ret)
> > +		return ret;
> > +
> > +	for (i = 0; i < size_inwords; i++)
> > +		mbx_data_wr32(mbx, MBX_FW_PF_SHM_DATA + i * 4, msg[i]);
> > +
> > +	/* flush msg and acks as we are overwriting the message buffer */
> > +	hw->mbx.fw_ack = mucse_mbx_get_ack(mbx, MBX_FW2PF_COUNTER);
> 
> It seems like the ACK is always at MBX_FW2PF_COUNTER. So why pass it
> to mucse_mbx_get_ack()? Please look at your other getters and setters.
> 

'mucse_mbx_get_ack' is always at MBX_FW2PF_COUNTER now, just for pf-fw mbx. 
But, in the future, there will be pf-vf mbx with different input.
Should I move 'MBX_FW2PF_COUNTER' to function 'mucse_mbx_get_ack', and
update the function when I add vf relative code in the future?

> > +/**
> > + * mucse_write_mbx - Write a message to the mailbox
> > + * @hw: pointer to the HW structure
> > + * @msg: the message buffer
> > + * @size: length of buffer
> > + *
> > + * @return: 0 on success, negative on failure
> > + **/
> > +int mucse_write_mbx(struct mucse_hw *hw, u32 *msg, u16 size)
> > +{
> > +	return mucse_write_mbx_pf(hw, msg, size);
> > +}
> 
> This function does not do anything useful. Why not call
> mucse_write_mbx_pf() directly?
> 

Yes, I should call it directly. 

> > +/**
> > + * mucse_check_for_msg - Check to see if fw sent us mail
> > + * @hw: pointer to the HW structure
> > + *
> > + * @return: 0 on success, negative on failure
> > + **/
> > +int mucse_check_for_msg(struct mucse_hw *hw)
> > +{
> > +	return mucse_check_for_msg_pf(hw);
> > +}
> > +
> > +/**
> > + * mucse_check_for_ack - Check to see if fw sent us ACK
> > + * @hw: pointer to the HW structure
> > + *
> > + * @return: 0 on success, negative on failure
> > + **/
> > +int mucse_check_for_ack(struct mucse_hw *hw)
> > +{
> > +	return mucse_check_for_ack_pf(hw);
> > +}
> 
> These as well.

Got it, I will update it.

> 
> 	Andrew
> 

Thanks for your feedback.


