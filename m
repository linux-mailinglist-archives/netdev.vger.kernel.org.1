Return-Path: <netdev+bounces-208786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC65B0D204
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 08:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7DC9541793
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 06:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE0C2868BF;
	Tue, 22 Jul 2025 06:45:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765891DC9BB
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 06:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753166751; cv=none; b=i1Z0Cs5JmXSRrB+NfRw8WbbgTFDGWLZx30w1bvb+k+WV5ZbMCB4M8cEAmJeTHpTD1DEXm+QS4YJn/DvNf/LfjyPpsi+VowpHfN3BgLAIuFq759o9T0GtuMEKV3sjFUjn//ftEpWDWwaOSF4ZUSAq3hExbcmXhKrZWTdgwYN5H2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753166751; c=relaxed/simple;
	bh=1yAfeUM+0aCbU2wqT1X4XnO0FHqgbZfZjdKiu6dmZqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lb1Ip80iCit9oF/kIZUP7GuxM+WSjUh0sgQs+tpg2+O3OyHX/juJiK6cIcC3cY9bzEsIzgjJ9MmDfjoqRmklSvqyjRZYVX9oQvlMqtB1NHV1qu/fN0cFo4T/BLJq9gm8w9pg7X76WS1UKrLjltQr5w4b9Kzpce7bUH7vE0xqo30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpgz4t1753166732tb2f2730f
X-QQ-Originating-IP: lc/T7L03GGO2+MGg/RYgyPv6CVL6lDGTXWv1SAH4VJ0=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 22 Jul 2025 14:45:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11965248678226407271
Date: Tue, 22 Jul 2025 14:45:30 +0800
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
Subject: Re: [PATCH v2 03/15] net: rnpgbe: Add basic mbx ops support
Message-ID: <D81C71402E58DF29+20250722064530.GC99399@nic-Precision-5820-Tower>
References: <20250721113238.18615-1-dong100@mucse.com>
 <20250721113238.18615-4-dong100@mucse.com>
 <e66591a1-0ffa-4135-9347-52dc7745728f@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e66591a1-0ffa-4135-9347-52dc7745728f@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MwqrwaLzgdebRnjDgaz7toidwNnwfo0Q2SEX4jbJQVGDaUyWj+KLBgdc
	zvYv2DGvWMeiaW2r6V/AgGDwWUuFVWLwXONZkga1bEEfA00rkmMnyykpZ+qm0L5RYXIu5RQ
	F3S651bcRPdGVroZ2lAUQMwVybUAY9Xw90UA1BtKKbpOS/xeThsvrxaZOHDflccDMkEdpVV
	6iPhZQbE799QLYyHUNeq5Ah5T70GWDYQ1/26n6UiEO9IL761tu/52l+74Do3pLF7pYIHXk6
	dIfnBMAIC3lbfivx7Xd/Ud2ClX7LdaMeyf5c51eRwcbhMsjvVreZBph/NwP7l6mdlA9f+pK
	mq5QRWtrApj11EGWmcGOVHW6vQfZKFtTlOypwDnmWFHWP7PSqzA35U6JPao1rOvOjqOAEAL
	AbbwfxskG/crP1tMrisTL5kahssVjnwjcdOfM1ud9KOINOqqlM8AnTLQX3lXS9xmhBy9U3G
	gJwUH2RE2owzMbgphmdMsu5l7x67CRiEPZZxYkVE8FhQAx4uDdNsja4DbMKVz0Q49bpSjLM
	idt9frNwOhw+JAN8bd+saTBfaj8VbUb9JqRzgwR7NqIukJBQklSqoPA6se4teOKQOowvI2q
	dxRSevJoDLGn5waboeXgHV63P+qTwurFBVQOyGNYcU+WFPO42Vh6D1P7CbWdqGznFSxqevH
	YfK2OXbr1/wVdicH2uqAzCg8PjjTmuBBMbCxK3NdM0RgqoSe4an35c7nr3urukUJOKbPxgd
	w/PoEwMwJSC75LWafZL4U83DPZNzSyTJwrk+du6M0JRrFqbVA7oWS7QJSb1uPXbAMQw83QY
	lvn83xLeY1mVgrcf4v5CoKdiRGwwJ/a+sf9ZCMDG4vMTh458gm1gB89uJb3JHNX4hnWgcBN
	fOZYzpu/V81S7aneSoJ2wz7LI8iRAebF42MD+5nsjMWBe2WXkmRjeKK9xg39gWk58clSDNV
	2iOdQkE8rC978ld71k2H8poI3mn5z4hspTGszM7gBtX3eXhlyd3E9WxGGPxLROOhpgdkWfD
	gaGVqL1f6ujA7uM4hZ
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

On Mon, Jul 21, 2025 at 05:43:41PM +0200, Andrew Lunn wrote:
> >  #define MAX_VF_NUM (8)
> 
> > +	hw->max_vfs = 7;
> 
> ???

This is mistake, max vfs is 7. 8 is '7 vfs + 1 pf'.

> 
> 
> >  }
> >  
> >  /**
> > @@ -117,6 +119,7 @@ static void rnpgbe_get_invariants_n210(struct mucse_hw *hw)
> >  	/* update hw feature */
> >  	hw->feature_flags |= M_HW_FEATURE_EEE;
> >  	hw->usecstocount = 62;
> > +	hw->max_vfs_noari = 7;
> 
> ???

Bridge with no ari(Alternative Routing - ID Interpretation) function limits
8 function for one ep. This variable is used to limit vf numbers in no-ari
condition.
Of course, those not really used code should be removed in this patch.

> 
> > +int mucse_read_mbx(struct mucse_hw *hw, u32 *msg, u16 size,
> > +		   enum MBX_ID mbx_id)
> > +{
> > +	struct mucse_mbx_info *mbx = &hw->mbx;
> > +
> > +	/* limit read to size of mailbox */
> > +	if (size > mbx->size)
> > +		size = mbx->size;
> > +
> > +	if (!mbx->ops.read)
> > +		return -EIO;
> 
> How would that happen?
> 
> > +
> > +	return mbx->ops.read(hw, msg, size, mbx_id);
> 
> > +int mucse_write_mbx(struct mucse_hw *hw, u32 *msg, u16 size,
> > +		    enum MBX_ID mbx_id)
> > +{
> > +	struct mucse_mbx_info *mbx = &hw->mbx;
> > +
> > +	if (size > mbx->size)
> > +		return -EINVAL;
> > +
> > +	if (!mbx->ops.write)
> > +		return -EIO;
> 
> How would either of these two conditions happen.
> 

Those are 'defensive code' which you point before. I should
remove those.

> > +static u16 mucse_mbx_get_req(struct mucse_hw *hw, int reg)
> > +{
> > +	/* force memory barrier */
> > +	mb();
> > +	return ioread32(hw->hw_addr + reg) & GENMASK(15, 0);
> 
> I'm no expert on memory barriers, but what are you trying to achieve
> here? Probably the most used pattern of an mb() is to flush out writes
> to hardware before doing a special write which triggers the hardware
> to do something. That is not what is happening here.
> 

Got it, I will check and fix it.

> > +static void mucse_mbx_inc_pf_req(struct mucse_hw *hw,
> > +				 enum MBX_ID mbx_id)
> > +{
> > +	struct mucse_mbx_info *mbx = &hw->mbx;
> > +	u32 reg, v;
> > +	u16 req;
> > +
> > +	reg = (mbx_id == MBX_FW) ? PF2FW_COUNTER(mbx) :
> > +				   PF2VF_COUNTER(mbx, mbx_id);
> > +	v = mbx_rd32(hw, reg);
> > +	req = (v & GENMASK(15, 0));
> > +	req++;
> > +	v &= GENMASK(31, 16);
> > +	v |= req;
> > +	/* force before write to hw */
> > +	mb();
> > +	mbx_wr32(hw, reg, v);
> > +	/* update stats */
> > +	hw->mbx.stats.msgs_tx++;
> 
> What are you forcing? As i said, i'm no expert on memory barriers, but
> to me, it looks like whoever wrote this code also does not understand
> memory barriers.
> 

Got it, I will check and fix it.

> > +static int mucse_obtain_mbx_lock_pf(struct mucse_hw *hw, enum MBX_ID mbx_id)
> > +{
> > +	struct mucse_mbx_info *mbx = &hw->mbx;
> > +	int try_cnt = 5000, ret;
> > +	u32 reg;
> > +
> > +	reg = (mbx_id == MBX_FW) ? PF2FW_MBOX_CTRL(mbx) :
> > +				   PF2VF_MBOX_CTRL(mbx, mbx_id);
> > +	while (try_cnt-- > 0) {
> > +		/* Take ownership of the buffer */
> > +		mbx_wr32(hw, reg, MBOX_PF_HOLD);
> > +		/* force write back before check */
> > +		wmb();
> > +		if (mbx_rd32(hw, reg) & MBOX_PF_HOLD)
> > +			return 0;
> > +		udelay(100);
> > +	}
> > +	return ret;
> 
> I've not compiled this, but isn't ret uninitialized here? I would also
> expect it to return -ETIMEDOUT?
> 
> 	Andrew
> 

Yes, ret is uninitialized. I will fix this.
Thanks for your feedback.


