Return-Path: <netdev+bounces-221555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A32B3B50D92
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 07:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1B7E7B133A
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 05:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63A32BE65C;
	Wed, 10 Sep 2025 05:53:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159783C0C;
	Wed, 10 Sep 2025 05:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757483594; cv=none; b=V3QomW3aM+tB1cCPrUsVp1u1n4X5zHNQc2MltgGRxFwbTevfwYkWptJPWjV1O5XMeb7oI6uF/ImhrWadIuXA+NwvgtGSF/CMqRODnTSd7Ij38pgYQpJr/77ykcXQUC4bZfNxtC/FX4Kl3mhkuKcmOPpw/48QgWUsQJi2gpeDmGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757483594; c=relaxed/simple;
	bh=AQc+L8l+7wlaYn6ttGADb5Ntc3fJupIVV0u3j6Gx/m8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AKS1atZDXVa14xZ3F+ZrrehkFqc1UCjdItCcz48INkeaTUV6pFP56v/mR9ItdtdOzbNLlwE8DDzN9mp2+bznbv8p7CmXYAvS62ydc3bsebUGVcoNSMc7z7fnCnIWq3hcpb5UXiHEdlEOQf0wrTPNpq/vKT3it5jlgS5TCXN12XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz17t1757483564t6fda734d
X-QQ-Originating-IP: Rs0GtXYxOAIdy9c4A2MsB3LDWdjLIC6jPtmWwRXVcv0=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 10 Sep 2025 13:52:42 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16482408453919483906
Date: Wed, 10 Sep 2025 13:52:42 +0800
From: Yibo Dong <dong100@mucse.com>
To: "Anwar, Md Danish" <a0501179@ti.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com, kees@kernel.org,
	gustavoars@kernel.org, rdunlap@infradead.org,
	vadim.fedorenko@linux.dev, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v11 3/5] net: rnpgbe: Add basic mbx ops support
Message-ID: <D6388A3A145B9313+20250910055242.GA1832444@nic-Precision-5820-Tower>
References: <20250909120906.1781444-1-dong100@mucse.com>
 <20250909120906.1781444-4-dong100@mucse.com>
 <54602bba-3ec1-4cae-b068-e9c215b43773@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54602bba-3ec1-4cae-b068-e9c215b43773@ti.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OXhWvHhbOVwtis9ps2diS86/nY1LiT12WMbBnQi6rwFogzljHXkQqdUa
	jKVYTe3Eex7sA7pKeYeMnEfwjR4qRaAK0u/Bh4VKG/k39lklQ0ub1o2ihn9Xy3VHolmukUz
	MS4KO4YUajk7pfglY/bGNwoa4EKmsCzVYe7psKexmDqAvfSHchIyykFeorbbHu37sD/+B/h
	NQmkmczUJme7nTozeRzTn25bYamXbWTpQ451JxBjbvVgfgSX7QITd9INPaVtH46KwRCtU2t
	/jE1PilDGL7g9akZIztUN1WbY0/QTYzgRz7YaAfWag78tbUjsIZ1gc/2v7U5/0ld7rHbWuE
	ca/TZ4pVtqRLpcWk/2h/70Wg3tvp6jB5v6xdTCkOSGsG7n+ZaxqZlcpl574F//rqls4soh7
	o9ALrAD8itr+e51e6VB/pCv89YfPcLjJBWhYeAQlLlt0v23KKJVXQ++4QsI8G0A/3Btuv/c
	It1XE0SCgS1C3s8V3qqYoNuGQIFOhkES/wwXbb8S09MxDxqKM9TWrtSisUAHlzGilk3X1gP
	Mj3pkl8nffsPM0zQ6ildkea0kYH9kg5a+38ZMMwmkzM+KNSWWBLcbCG/JgKTZ77B6kguq0h
	zEJUmHfrXmKYPkhhvvmBx8uYsIsMOykmiRnWt3FTNFTJPG1BV0grR/3iNu6HviWkKymGmmo
	npMLooSCxiUfSM701i0U5Fy7PzdOc5YR3KBXwP6UON+DWQtjVdwuDrggPpg/b4jhwUZ8+hm
	mdcVIn1R++8f858i+qi9Lgx8/gWDOszONVXfK9j8NS+7DH0xFPbTzPdqsa8a2DTYZDxrh2F
	qvC5QKy8NksBHERsqF6Aq4HWzTUap0OXFH8iQ+ARBAODNkdXm9IFw/o72HDftvYyt8HSMzF
	DHgrJaMpnPlSBx/Nb7Mrn0dQB8yqgvId+mH/3pVAm3H2i4xvVgJeugnOcT7sEsPI35u7q0G
	2YKWiIcL/H2NcLTU+d4zpcIxr3ClnCLRGvnMCKPqa4qL/GZBIvgcQvtaS/Y62PFz5FuzF7j
	Ll38chRehQ7Be7Q1yh
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

On Tue, Sep 09, 2025 at 07:52:21PM +0530, Anwar, Md Danish wrote:
> On 9/9/2025 5:39 PM, Dong Yibo wrote:
> > Add fundamental mailbox (MBX) communication operations between PF (Physical
> > Function) and firmware for n500/n210 chips
> > 
> > Signed-off-by: Dong Yibo <dong100@mucse.com>
> > ---
> >  drivers/net/ethernet/mucse/rnpgbe/Makefile    |   4 +-
> >  drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  25 ++
> >  .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |  70 +++
> >  drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |   7 +
> >  .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |   5 +
> >  .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    | 425 ++++++++++++++++++
> >  .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |  20 +
> >  7 files changed, 555 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
> >  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
> >  create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
> > 
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/Makefile b/drivers/net/ethernet/mucse/rnpgbe/Makefile
> > index 9df536f0d04c..5fc878ada4b1 100644
> > --- a/drivers/net/ethernet/mucse/rnpgbe/Makefile
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/Makefile
> > @@ -5,4 +5,6 @@
> >  #
> 
> [ ... ]
> 
> > +
> > +/**
> > + * rnpgbe_init_hw - Setup hw info according to board_type
> > + * @hw: hw information structure
> > + * @board_type: board type
> > + *
> > + * rnpgbe_init_hw initializes all hw data
> > + *
> > + * Return: 0 on success, negative errno on failure
> > + **/
> > +int rnpgbe_init_hw(struct mucse_hw *hw, int board_type)
> > +{
> > +	struct mucse_mbx_info *mbx = &hw->mbx;
> > +
> > +	mbx->pf2fw_mbx_ctrl = MUCSE_GBE_PFFW_MBX_CTRL_OFFSET;
> > +	mbx->fwpf_mbx_mask = MUCSE_GBE_FWPF_MBX_MASK_OFFSET;
> > +
> > +	switch (board_type) {
> > +	case board_n500:
> > +		rnpgbe_init_n500(hw);
> > +	break;
> > +	case board_n210:
> > +		rnpgbe_init_n210(hw);
> > +	break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> 
> The indentation of this switch block seems off to me.
> 
> As per the coding guidlines
> https://www.kernel.org/doc/html/v4.14/process/coding-style.html#indentation
> 
> Break statements should be at the same indentation level as the case
> code. The current indentation has the "break" statements at the same
> level as the case labels, which is inconsistent.
> 
> This should be like,
> 
> 	switch (board_type) {
> 	case board_n500:
> 		rnpgbe_init_n500(hw);
> 		break;
> 	case board_n210:
> 		rnpgbe_init_n210(hw);
> 		break;
> 	default:
> 		return -EINVAL;
> 	}
> 

Sorry for the bad code style. I will fix this in next version.

> > +	/* init_params with mbx base */
> > +	mucse_init_mbx_params_pf(hw);
> > +
> > +	return 0;
> > +}
> 
[ ... ]
> 
> 
> 
> -- 
> Thanks and Regards,
> Md Danish Anwar
> 
> 

Thanks for your feedback.


