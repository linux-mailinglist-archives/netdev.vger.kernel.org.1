Return-Path: <netdev+bounces-219789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98405B42FD8
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 04:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53A511BC67BF
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 02:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288701F7098;
	Thu,  4 Sep 2025 02:39:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4BD2628D;
	Thu,  4 Sep 2025 02:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756953565; cv=none; b=Xzf2jqDsJNyzCSaGIQlZT8vjsOoKd/La489Wp2W6bRokeIEO2LrvMSb8v0F/ForxOq0w4Az8B5O7ixTyDvWvx0tGOWNA1oLV95qwAbEmK5MECmpoISlsW8gE+19YxqcoaeXbNuOSK0g6S4MLMFAlQaGXBENUqdLnEnhMBETt1og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756953565; c=relaxed/simple;
	bh=Un2jBL3+CE2kkbBmaX1i7puEYmvyswZnW6zA6/jHXvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uux3IhSgg9G2mEH8MapPKpMb6BAt0DP5fpYB9p5VDj2IRUmawu4IcoWo4t61Dv87C1S4j69Ezz9YYaIek0LLjYSObZ91fbqtk2i6Pfg6trmMaLvsL/hRbIufpSpp06c6P+yQgyNA7TJfTOrVW2SrdqD2d56lpk4efjkWlwNfk+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpgz7t1756953533tab631f24
X-QQ-Originating-IP: ZiD4DA2t9IebggFi5to5NbV3JdPD9/SXq88z6qRXx1U=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 04 Sep 2025 10:38:51 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9849765292979018679
Date: Thu, 4 Sep 2025 10:38:51 +0800
From: Yibo Dong <dong100@mucse.com>
To: Simon Horman <horms@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
	gur.stavi@huawei.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
	danishanwar@ti.com, lee@trager.us, gongfan1@huawei.com,
	lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com, kees@kernel.org,
	gustavoars@kernel.org, rdunlap@infradead.org,
	vadim.fedorenko@linux.dev, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v10 3/5] net: rnpgbe: Add basic mbx ops support
Message-ID: <C3FF2A9FD848166E+20250904023851.GB1015062@nic-Precision-5820-Tower>
References: <20250903025430.864836-1-dong100@mucse.com>
 <20250903025430.864836-4-dong100@mucse.com>
 <20250903164431.GD361157@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903164431.GD361157@horms.kernel.org>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NQ1SesBsQjVtGOsZlTHftgyo/547i5B3HWDBaMU63cWmf0NXzMl0+SCS
	U0KekzMS4iu/YDKQ0aCEHPiYlKy1ZJdLrbsnhVA/qRHoKvhjQcffHWq6EbR/e0e0OCFfEv5
	ldRwGpUpv2ybtPrCl+T+Idc0eDBmP9hCLaD/74XErLCUMp9z/EVn89vxhceg286c+gSOEMc
	k/zrEY07S+9r4++aRZUq7AsuOEKPUNy6iGw15BFYlurywZFvzedcHb3lqoPxmukCD77qmbD
	5KYsCNFcI4XpIVQUj7QQIXwKUq1J3bg/dsqKxco9kYChjJTv6FTDiTin8NhRNGFIw+8r2vf
	iwooIDhh+U1AnlhnHUWLI4kW4dR/qxy1Bb6+O52gFPp3rj2G8fw1pgXsXWQER7A+l121mOe
	+QrBM34fYByNuDX9ezFo76WVi+qOwks1aBjZmPiv5EPL0Kx5Z9C9qKQjwuY3nca1q4lxIIf
	zDwsC9b+yp56n1nsZbbVPncscNCqutVQXuhjXRHxOLLpUkNRSFoxgkniiGCDM0gpIvclKwi
	d9LPNPMpLebpbsHkoRA5utA6UJCFODr39bYKx46/chLZ/hAc4cV3LjSzyFOSh5Jtf+F8n9N
	TZc5Q3Ul7CTYuPw9DnskV3cnpLjTVdvZkx8HTBrXkEfNqtxPaB8AC3xgpQpYad9m+6/BIlB
	roo5flNe1WQJWfffDR1Ya8bVqp/7MWVczTA5pS25tgKN4FIDx1tWas/w9I60efkEc4JPpoJ
	R8zu6LA0ngmD+s7nWhVA7mPxLFKlQpPz2gQ1htaGPI6gl2Kaza+EJtPG6dAUF33PLBzRxVN
	pRBrVDhlDu3aggXfYk/DI5mV/eBr+7s2kv7Bwbb7gW0KM48KoIGPei09OEjbnZc1CjyfTL0
	T0hvR1gMwpUswwMl93SLm238PLYGnKbRzN7L+e0gW5e4E+ZjRpQgnBqgh/wj2NFgyVVIRtz
	ZJKETEA/2u7o6iTioazJqGIE5rCAgH9qDL7/PmqIpiQugU5NYN0zpFapHdvwTokjMfo5ftE
	QoYYkllT9nYcBYVl49
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

On Wed, Sep 03, 2025 at 05:44:31PM +0100, Simon Horman wrote:
> On Wed, Sep 03, 2025 at 10:54:28AM +0800, Dong Yibo wrote:
> > Initialize basic mbx function.
> > 
> > Signed-off-by: Dong Yibo <dong100@mucse.com>
> 
> ...
> 
> > +/**
> > + * mucse_mbx_inc_pf_req - Increase req
> > + * @hw: pointer to the HW structure
> > + *
> > + * mucse_mbx_inc_pf_req read pf_req from hw, then write
> > + * new value back after increase
> > + **/
> > +static void mucse_mbx_inc_pf_req(struct mucse_hw *hw)
> > +{
> > +	struct mucse_mbx_info *mbx = &hw->mbx;
> > +	u16 req;
> > +	u32 v;
> > +
> > +	v = mbx_data_rd32(mbx, MBX_PF2FW_COUNTER);
> > +	req = (v & GENMASK_U32(15, 0));
> 
> nit1: Unnecessary parentheses
> nit2: I would have used FIELD_GET here in conjunction with something like.
> 
>       #define MBX_PF2FW_COUNTER_MASK GENMASK_U32(15, 0)
> 

Got it, maybe update it like this?

req = FIELD_GET(GENMASK_U32(15, 0), v);

> > +	req++;
> > +	v &= GENMASK_U32(31, 16);
> > +	v |= req;
> 
>       And using FIELD_PREP is probably more succinct here.
> 
>       Likewise in the following function
> 

Got it, maybe update it like this?

req++;
v = (v & ~GENMASK_U32(15, 0)) | FIELD_PREP(GENMASK_U32(15, 0), req);

> > +	mbx_data_wr32(mbx, MBX_PF2FW_COUNTER, v);
> > +	hw->mbx.stats.msgs_tx++;
> > +}
> > +
> > +/**
> > + * mucse_mbx_inc_pf_ack - Increase ack
> > + * @hw: pointer to the HW structure
> > + *
> > + * mucse_mbx_inc_pf_ack read pf_ack from hw, then write
> > + * new value back after increase
> > + **/
> > +static void mucse_mbx_inc_pf_ack(struct mucse_hw *hw)
> > +{
> > +	struct mucse_mbx_info *mbx = &hw->mbx;
> > +	u16 ack;
> > +	u32 v;
> > +
> > +	v = mbx_data_rd32(mbx, MBX_PF2FW_COUNTER);
> > +	ack = (v >> 16) & GENMASK_U32(15, 0);
> > +	ack++;
> > +	v &= GENMASK_U32(15, 0);
> > +	v |= (ack << 16);
> > +	mbx_data_wr32(mbx, MBX_PF2FW_COUNTER, v);
> > +	hw->mbx.stats.msgs_rx++;
> > +}
> 
> ...
> 

Maybe like this ?
...
v = mbx_data_rd32(mbx, MBX_PF2FW_COUNTER);
ack = FIELD_GET(GENMASK_U32(31, 16), v);
ack++;
v = (v & GENMASK_U32(15, 0)) | FIELD_PREP(GENMASK_U32(31, 16), ack);
mbx_data_wr32(mbx, MBX_PF2FW_COUNTER, v);
...

> > +/**
> > + * mucse_mbx_reset - Reset mbx info, sync info from regs
> > + * @hw: pointer to the HW structure
> > + *
> > + * This function reset all mbx variables to default.
> > + **/
> > +static void mucse_mbx_reset(struct mucse_hw *hw)
> > +{
> > +	struct mucse_mbx_info *mbx = &hw->mbx;
> > +	u32 v;
> > +
> > +	v = mbx_data_rd32(mbx, MBX_FW2PF_COUNTER);
> > +	hw->mbx.fw_req = v & GENMASK_U32(15, 0);
> > +	hw->mbx.fw_ack = (v >> 16) & GENMASK_U32(15, 0);
> 
> I'd use FIELD_GET here too.
> 

Maybe like this?
hw->mbx.fw_req = FIELD_GET(GENMASK_U32(15, 0), v);
hw->mbx.fw_ack = FIELD_GET(GENMASK_U32(31, 16), v);

> > +	mbx_ctrl_wr32(mbx, PF2FW_MBOX_CTRL(mbx), 0);
> > +	mbx_ctrl_wr32(mbx, FW_PF_MBOX_MASK(mbx), GENMASK_U32(31, 16));
> > +}
> 
> ...
> 

Thanks for your feedback.


