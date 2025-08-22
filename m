Return-Path: <netdev+bounces-215917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2141AB30DF4
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 07:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7759B7BB307
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 05:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FDB2C325C;
	Fri, 22 Aug 2025 05:25:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0457A2C1596;
	Fri, 22 Aug 2025 05:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755840325; cv=none; b=tLJEgLvffJta30QN3AbiM5AeA2HAUnHr8da2zLhCDzC3swSzQohJIWzTos+bZTVIG4h4Y9GjbsK0ERhEDOjeXWetzS2w41C11D9uDAIq9Y6jhvwtbYJnfgLF7CSQZzNsyjPDXpyA3ZrXmozRoGQXypM4vTTKF5ToWVCby8x3Upc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755840325; c=relaxed/simple;
	bh=EwC/a0KV2I8YGxKhs/nPZvHT6OBRurivwO19o5f5pV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mF0+s0F/ZIWVN01Ki+zXiLZ1sYV4Xm9g1vKS2HTrImJNo1JIkFbDkb8lMf8FsH3iw/bb6qw71iyzZYQVOroLAyFURsDMdS6NY+3bF627H678RRy8rN3XH6Iumo68OwZypnXk8XT3dfej71efkViPkjAsotDKAyryKaM6l52tVmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz11t1755840313t1968e2c3
X-QQ-Originating-IP: ay1n1e7+jnTaE0tAKeASRzidqi+sbKOyFZfmoekBSgE=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 22 Aug 2025 13:25:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6492650603905792360
Date: Fri, 22 Aug 2025 13:25:11 +0800
From: Yibo Dong <dong100@mucse.com>
To: Parthiban.Veerasooran@microchip.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	lukas.bulwahn@redhat.com, alexanderduyck@fb.com,
	richardcochran@gmail.com, kees@kernel.org, gustavoars@kernel.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v7 3/5] net: rnpgbe: Add basic mbx ops support
Message-ID: <91803970CBBEA502+20250822052511.GB1931582@nic-Precision-5820-Tower>
References: <20250822023453.1910972-1-dong100@mucse.com>
 <20250822023453.1910972-4-dong100@mucse.com>
 <b5f36260-8615-4b81-9905-a44d05e919a3@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5f36260-8615-4b81-9905-a44d05e919a3@microchip.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MKBlamCdrQXMuxOy2TBbCjGL1rywvtGWch9rT/M2Wy1ZuBwQjbbQPZXx
	9Q32Qe/aZ+tzUuLs2sv8a7L7g1DBcue53u/5x6NjVWWZAWLRbYvn6Xf5chhxIr5n8FbA3Fa
	4BGbxLNDCo+i4Dm6P5KO9dAONXypLQSvJkvTee7QIp14ZUsFnJXtdthf6M4ju64JKJYofDr
	2//OhgtaueVYxibQjggYdrxEn/jWZE76snbX/zGdHiWe5ZGTjlfrC5KGtGcM80m5r1kZyP8
	aSohZ7K7QUvoruG901Mdf6CK3VEkzegZ8dDfHWNnvyVJUp+vdstSv0sPXOWV41Mn+hk2mlR
	ti1EX9ODLWuYpG6prHqKsxTT2CfKXfFeBwVJQmVDybaz5NVdIiyT1GKYitD3a6JDOq+I1o0
	BP9ObMKX2ekkJaYlV6w0crf/B9GoxiHVaAMJsrlVOqUBig4bam5CGbeqvsBYdlRg+RDWDQx
	xEHVQoK+yAAXu54RYZl5R8FxYe2d0OPGDvvO6n4os7NgyME1CCbkrQhLK0TugakKnmrzECm
	zmGSKw924Z7UGfwLTm/eGNNPolrgmADBoVFly+jz1bModzI7fyErptfO1ilCh7K5PvBP9qp
	YD3/5KezVOe16b+3rqW9hICFviu+uF7HUSzXirAhOX5mYfusUyQsVNlWGgt4N2ddpRnzR3q
	AOK8HcCKsk5v0dMAiPz4Ex/nygmd2RYnzi7Ztk2JCSSyjCK7SwAnhcTl2yDb+Meb6hXHKBs
	lsBsdag/VeGooJWH7R/SuOWZ8j5aSUV7w6cm2GC9fPeRrYHj7wvw5UavUA+xjcvzvAacFaH
	uND/SMYMyJAoh9bNcRTec2T3mmR0cEqwnNtfv7YWx42x9QQcwAlFCil+IJG02tBLftD1TUx
	wQTom3orwPVi6YuoycU/IsWp4Fp4fU4ZqpLuzQl2yat7ahDTYzezDJ09b3NxfqKKMEw43Ze
	+URUojBl+bAaeY9y76Z2JAbqHMjCQOMDKWs6P3PwnwX9/7ZubwI4uTiLV5GNEeTBmL2bCfn
	UV8qVpAtzFiYzV0NhdokGeTI5+QJx9gKge7Pc6Vg==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

On Fri, Aug 22, 2025 at 04:41:48AM +0000, Parthiban.Veerasooran@microchip.com wrote:
> > +
> > +/**
> > + * mucse_check_for_msg_pf - Check to see if the fw has sent mail
> > + * @hw: pointer to the HW structure
> > + *
> > + * @return: 0 if the fw has set the Status bit or else
> > + * -EIO
> > + **/
> > +static int mucse_check_for_msg_pf(struct mucse_hw *hw)
> > +{
> > +       struct mucse_mbx_info *mbx = &hw->mbx;
> > +       u16 hw_req_count = 0;
> I don't think you need to assign 0 here as this variable is updated in 
> the next line.
> 
> Best regards,
> Parthiban V

Got it, I will update this.

> > +
> > +       hw_req_count = mucse_mbx_get_fwreq(mbx);
> > +       /* chip's register is reset to 0 when rc send reset
> > +        * mbx command. This causes 'hw_req_count != hw->mbx.fw_req'
> > +        * be TRUE before fw really reply. Driver must wait fw reset
> > +        * done reply before using chip, we must check no-zero.
> > +        **/
> > +       if (hw_req_count != 0 && hw_req_count != hw->mbx.fw_req) {
> > +               hw->mbx.stats.reqs++;
> > +               return 0;
> > +       }
> > +
> > +       return -EIO;
> > +}
> > +

Thanks for your feedback.


