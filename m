Return-Path: <netdev+bounces-204480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA348AFAC07
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 08:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E71117838A
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 06:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1F2279DD7;
	Mon,  7 Jul 2025 06:41:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5755D17A2F6;
	Mon,  7 Jul 2025 06:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751870480; cv=none; b=Lx4nfc1kmRRpaLek7zzmkijNAGuwBHBzagZBe/keQ7WHGYQU2DaFX1/C91/beZucBZSRVGWVC+nt3ohfCpcnedtPhMuXG4cVqdBF2BbB9+jI/au2gOkU3e2VOGUix6s1DAq7q25wiSAMVYMRRad13ImvIy5rBeEolgZK8osevzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751870480; c=relaxed/simple;
	bh=E4CpdpfvjbFb31eNpt1I5W5xMwZ2+JX1DELQsURXRzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KIrKwmHS1SdffzpSBPesyPXa9Uts7nuQgNoHpmdhC5vz6oc6ANcAZpuGuhllgd7pVxXcHCye9HdmSg92l7MESpCChn0jK9EpNu8LhbfIi99iHxrBN26V6KxuEn3Yk2WxqqQaNwr+O5mdmMxZd5Xzf/x4/GBnQ+LM6vIAvmNV25w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz11t1751870403t7b4d411c
X-QQ-Originating-IP: PVXPnXHUFKpnol3MyikDQMlsWMN3G4auBiHn1fypUpM=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 07 Jul 2025 14:40:01 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17395511315991072941
Date: Mon, 7 Jul 2025 14:39:55 +0800
From: Yibo Dong <dong100@mucse.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
	andrew+netdev@lunn.ch, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/15] net: rnpgbe: Add basic mbx ops support
Message-ID: <9C6FCA38E28D6768+20250707063955.GA162739@nic-Precision-5820-Tower>
References: <20250703014859.210110-1-dong100@mucse.com>
 <20250703014859.210110-4-dong100@mucse.com>
 <80644ec1-a313-403a-82dd-62eb551442d3@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80644ec1-a313-403a-82dd-62eb551442d3@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MAN6sKHDZ5xSaGWXfe+7Bn+vUKbGkUDEXayIP+S/njJsCtK4DB1iRPtn
	16vaqm0+0isEJiLqZb/XtfZMP8i9m3XLf1LsQ2+qa2KWnJp4Rl4mg1mA9PJGJmyUiForwHt
	Ir2vjToYE9/bdlC+pyihymFeooPyoR7fDsw0IPIgWEtLiBTroDKWuRzVwDLVMaXjngEw0Q9
	GoFNOFm7H8klMPcNlxw7Is4PNHhPqNy4v2Qp1nwHobVYJUcRr5l8K7ls3JShMKuPwaX5NfL
	PA3uoihlrDWs290klquNPPK3zBrobRJX+fq4GRf1bMkUl+8nl7csZvisFRdS+vMVOqS4gg1
	AHxGzGWWY5r8GouGynaPPgjRYjcJm6Gm/+/AVfX2ZzTIu5vp/S7lwyywD/GqUZWCWE4GWj5
	gWSThikHht7yxgU+DSHyaBxnFiW2qSFP4zo4kG0QZsDW7RNDeCMyDdYJnlGKz2V6J3ZM4ZT
	BnSrxXJAeeoXkyl1paYr9dVkE5Ewi8PFc8hMCEjQzwm34zJo+51uBfnhM7xNv6lL3bSr8DL
	Iyl6M6PfaTJPdEJ1Up20pS2EtpnRslxwime4HorBkuylvECMyxkcXpjxMZzCc3/6yJMcJQ7
	2MoxP9cSV7gNPnOVwuj80oCFSZ2uOOKhtVxJA6DqQM51rtTdJA0Lz+qyVehwgPTt1jFXQ/K
	taHog2ig4DfvSk3pqOwCaXvJmuMBr6MKGCs5aqoYB8sCa9DHqi84FtgHZVGNz485nk/6Q0e
	vpWKfpgC8vKWF3ZFQTKY9fypx1L3lm53klMxNnaZ0BgAIbz/145pbl80YL2bkBRn0XMIQF1
	XnGRPUMLj0kn5UVjdaAVUAj/K/P9okxB+OhsfmYE5xZwzd+nbBCLh5fWX2DO22acUX+2G6V
	YfD3jdwRxYx0Yi8/8sqAHS4rq9135aGJMr5gKQ4VFaQ21cdMj5Xja8ndMFXbWo6D0S8Easq
	/N7mnTBaUqWVzNB0unvfmIeGtq45//uORHhpXjQbfAsUoxg==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

On Fri, Jul 04, 2025 at 08:13:19PM +0200, Andrew Lunn wrote:
> >  #define MBX_FEATURE_WRITE_DELAY BIT(1)
> >  	u32 mbx_feature;
> >  	/* cm3 <-> pf mbx */
> > -	u32 cpu_pf_shm_base;
> > -	u32 pf2cpu_mbox_ctrl;
> > -	u32 pf2cpu_mbox_mask;
> > -	u32 cpu_pf_mbox_mask;
> > -	u32 cpu2pf_mbox_vec;
> > +	u32 fw_pf_shm_base;
> > +	u32 pf2fw_mbox_ctrl;
> > +	u32 pf2fw_mbox_mask;
> > +	u32 fw_pf_mbox_mask;
> > +	u32 fw2pf_mbox_vec;
> 
> Why is a patch adding a new feature deleting code?
> 
Not delete code, 'cpu' here means controller in the chip, not host.
So, I just rename 'cpu' to 'fw' to avoid confusion.
> > +/**
> > + * mucse_read_mbx - Reads a message from the mailbox
> > + * @hw: Pointer to the HW structure
> > + * @msg: The message buffer
> > + * @size: Length of buffer
> > + * @mbx_id: Id of vf/fw to read
> > + *
> > + * returns 0 if it successfully read message or else
> > + * MUCSE_ERR_MBX.
> > + **/
> > +s32 mucse_read_mbx(struct mucse_hw *hw, u32 *msg, u16 size,
> 
> s32 is an unusual type for linux. Can the mbox actually return
> negative amounts of data?
> 
No, it cann't return negative amounts of data, but this function
returns negative when it failed. Maybe I should use 'int'?
> > +/**
> > + * mucse_write_mbx - Write a message to the mailbox
> > + * @hw: Pointer to the HW structure
> > + * @msg: The message buffer
> > + * @size: Length of buffer
> > + * @mbx_id: Id of vf/fw to write
> > + *
> > + * returns 0 if it successfully write message or else
> > + * MUCSE_ERR_MBX.
> 
> Don't invent new error codes. EINVAL would do.
> 
Got it, I will fix this.
> > + **/
> > +s32 mucse_write_mbx(struct mucse_hw *hw, u32 *msg, u16 size,
> > +		    enum MBX_ID mbx_id)
> > +{
> > +	struct mucse_mbx_info *mbx = &hw->mbx;
> > +	s32 ret_val = 0;
> > +
> > +	if (size > mbx->size)
> > +		ret_val = MUCSE_ERR_MBX;
> > +	else if (mbx->ops.write)
> > +		ret_val = mbx->ops.write(hw, msg, size, mbx_id);
> > +
> > +	return ret_val;
> > +}
> > +static inline void mucse_mbx_inc_pf_ack(struct mucse_hw *hw,
> > +					enum MBX_ID mbx_id)
> 
> No inline functions in C files. Let the compiler decide.
> 
Got it, I will move it to the h file.
> > +static s32 mucse_poll_for_msg(struct mucse_hw *hw, enum MBX_ID mbx_id)
> > +{
> > +	struct mucse_mbx_info *mbx = &hw->mbx;
> > +	int countdown = mbx->timeout;
> > +
> > +	if (!countdown || !mbx->ops.check_for_msg)
> > +		goto out;
> > +
> > +	while (countdown && mbx->ops.check_for_msg(hw, mbx_id)) {
> > +		countdown--;
> > +		if (!countdown)
> > +			break;
> > +		udelay(mbx->usec_delay);
> > +	}
> > +out:
> > +	return countdown ? 0 : -ETIME;
> 
> ETIMEDOUT, not ETIME. Please use iopoll.h, not roll your own.
> 
>     Andrew
> 
> ---
> pw-bot: cr
> 
Got it, I will fix it.
Thanks for your feedback.

