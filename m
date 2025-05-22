Return-Path: <netdev+bounces-192624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0749AAC08DD
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 11:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 321683A6D0B
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 09:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7972367D9;
	Thu, 22 May 2025 09:39:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43BC149C6F
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 09:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747906741; cv=none; b=oEWmzuW6BL0nyuneSfxDn4IO/Pf/D5ptfJyvkT9WBbkB+/Lp98XKZHhAVvPAX5SIewTUic1oZjQr2MASfN2L2Ky/WpRBT+kyWcVEGINarM57kIY/HeHcMPrfaFITAe7Jr6IaJLn8upjY0AVCXzk+Esgsgu3I1IUXRjRdZQhY4L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747906741; c=relaxed/simple;
	bh=xOpW+NNw6oXL2J9DS+ipOibt/IASPzCOPSO8SYRcZ3c=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=eNy4UUY3SE2mcXHzP7bnohGyTCXaOFjBtXYXXP9XtGjLVQaEfeKfyk426FT9uv7vaAV+RdbGM1wURrqXt6nuTt1btg40+PClzWimOLbK0fp1yEWZKLbIgo/R2GK+axW7r8cprOI776hKhOcHtIuVs1pLvSDUH2QnyMzYa6MAVrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas4t1747906675t201t23414
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [125.120.71.166])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 12888434157490660342
To: "'Simon Horman'" <horms@kernel.org>
Cc: <netdev@vger.kernel.org>,
	<pabeni@redhat.com>,
	<kuba@kernel.org>,
	<edumazet@google.com>,
	<davem@davemloft.net>,
	<andrew+netdev@lunn.ch>,
	<mengyuanlou@net-swift.com>
References: <20250520063900.37370-1-jiawenwu@trustnetic.com> <38C9EBBEE8FCE61E+20250520063900.37370-2-jiawenwu@trustnetic.com> <20250520165132.GD365796@horms.kernel.org>
In-Reply-To: <20250520165132.GD365796@horms.kernel.org>
Subject: RE: [PATCH net-next 2/2] net: txgbe: Support the FDIR rules assigned to VFs
Date: Thu, 22 May 2025 17:37:53 +0800
Message-ID: <014b01dbcafd$31197450$934c5cf0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQGg0O4KR7huWXJ8q/h3EDdDvvzoaQIcwO36AS5RtVK0OfyfAA==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Mutteg8H72qD3EOVEEnQXZNsWFZrXXiYC+cRCMeRKxDTteWody4v83gP
	vG4RLqvxRIAyzTZQzkr6nuk90kKoFhdXY6dshnF8PbBH16Y4WuZXf/9W8WL29w/JSPp68q0
	OOc8sag9YUyjo73W9A/5Z6I5IKULg7r5Fovi5DsZ6vQEb3MGBxLKsm6kUvjdOhhe9DJGCA4
	KWapHTNnlQ1mYLU4Ij577QGTMD3zMDWvMuNK6NKqTaiQJqC43IZ0KIQ/joaSWpNw87fVWV8
	RxAczHStqd7BtBtPxABuoUX8zTuouS/XEdrsPWssLCRw1P3aDOhOAWDkXQ+dZ6FPTBFM+/n
	5ekO3oHSDDDaTvALve1IdC9dcIVzavUj7rxeJS5V5EDQVdZ8G1yMjjKfMljTRYOovtri7o3
	hl548pTYKzLE/A/D0WyLtWgrTbhQZUYcUTHZkKScQRofZBotGuZOvK3ah1PzC3njJYmO4eD
	O4IHrLKLVgQEICPWvFxQGlD/hNm6L1r5/QNNZBIrX/3KDfXDSwNibNGgbRkQSu0I8yCXQyA
	D+TbdiUJWmDboB4hbDwyLWDk4HQ6g54owOdMDRHPALtVvBBCKgS6kp1XE/9jE7YwPM0aKoE
	plpTOOHPmgTOJFDeUXsaXIYfjFHtoD2NFi2CqRU0HiMSpk1a84I1pp+F9dE2xEfbZSLwlsm
	IHYG4OHQc7+/pcvYqIIafYsaX2XItK9MDhyJv9mf+OAuMvTEhszAffqQFkUw9Nxso52Bfmy
	8CE7xp8SatbnvNFsQ3pMr8kux0PI5AUWn4SYoytaFgvqYSZ8ETVpDb0O4M4TrsnzcAKjcjW
	BweAbLqP4A1QO3/ETpdoq0Oo+ytptbA64RVHw25Kq1RKlN/CfWR4g75AUNpDBfHJbyyQbyP
	BQOZFgB9MpjbzGPqYo5vdS3KF6t15pCR/N2dxZnqigFBCyDr9pFpw8KFSfkEeWhn1gPMXqb
	DKRtmYwgCXQlKGr34RsfLCAIzn4KBRIT1S+XeTP+0pFPMpJYvGp+Vi+6BPSdYmmAawSvwVW
	LUVF+7+PUKk0ar01HH7wC7/eqAnJ6+1WR5UeBpQA==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

> > diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.c
> > index ef50efbaec0f..d542c8a5a689 100644
> > --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.c
> > +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_fdir.c
> > @@ -307,6 +307,7 @@ void txgbe_atr(struct wx_ring *ring, struct wx_tx_buffer *first, u8 ptype)
> >  int txgbe_fdir_set_input_mask(struct wx *wx, union txgbe_atr_input *input_mask)
> >  {
> >  	u32 fdirm = 0, fdirtcpm = 0, flex = 0;
> > +	int i, j;
> 
> It would be nice to have more intuitive variable names than i and j,
> which seem more appropriate as names for iterators.

May not be a very intuitive variable name. It just defines the index and offset.
This code piece says, there are 16 registers to store flex information of 64 VMs.
And each register has 32 bits for 4 VMs. I can change to name it "index" and
"offset" if necessary. :)

> 
> >
> >  	/* Program the relevant mask registers. If src/dst_port or src/dst_addr
> >  	 * are zero, then assume a full mask for that field.  Also assume that
> > @@ -352,15 +353,17 @@ int txgbe_fdir_set_input_mask(struct wx *wx, union txgbe_atr_input *input_mask)
> >  	/* Now mask VM pool and destination IPv6 - bits 5 and 2 */
> >  	wr32(wx, TXGBE_RDB_FDIR_OTHER_MSK, fdirm);
> >
> > -	flex = rd32(wx, TXGBE_RDB_FDIR_FLEX_CFG(0));
> > -	flex &= ~TXGBE_RDB_FDIR_FLEX_CFG_FIELD0;
> > +	i = VMDQ_P(0) / 4;
> > +	j = VMDQ_P(0) % 4;
> > +	flex = rd32(wx, TXGBE_RDB_FDIR_FLEX_CFG(i));
> > +	flex &= ~(TXGBE_RDB_FDIR_FLEX_CFG_FIELD0 << (j * 8));
> >  	flex |= (TXGBE_RDB_FDIR_FLEX_CFG_BASE_MAC |
> > -		 TXGBE_RDB_FDIR_FLEX_CFG_OFST(0x6));
> > +		 TXGBE_RDB_FDIR_FLEX_CFG_OFST(0x6)) << (j * 8);
> >
> >  	switch ((__force u16)input_mask->formatted.flex_bytes & 0xFFFF) {
> >  	case 0x0000:
> >  		/* Mask Flex Bytes */
> > -		flex |= TXGBE_RDB_FDIR_FLEX_CFG_MSK;
> > +		flex |= TXGBE_RDB_FDIR_FLEX_CFG_MSK << (j * 8);
> >  		break;
> >  	case 0xFFFF:
> >  		break;
> > @@ -368,7 +371,7 @@ int txgbe_fdir_set_input_mask(struct wx *wx, union txgbe_atr_input *input_mask)
> >  		wx_err(wx, "Error on flexible byte mask\n");
> >  		return -EINVAL;
> >  	}
> > -	wr32(wx, TXGBE_RDB_FDIR_FLEX_CFG(0), flex);
> > +	wr32(wx, TXGBE_RDB_FDIR_FLEX_CFG(i), flex);
> >
> >  	/* store the TCP/UDP port masks, bit reversed from port layout */
> >  	fdirtcpm = ntohs(input_mask->formatted.dst_port);
> > @@ -516,14 +519,16 @@ static void txgbe_fdir_enable(struct wx *wx, u32 fdirctrl)
> >  static void txgbe_init_fdir_signature(struct wx *wx)
> >  {
> >  	u32 fdirctrl = TXGBE_FDIR_PBALLOC_64K;
> > +	int i = VMDQ_P(0) / 4;
> > +	int j = VMDQ_P(0) % 4;
> 
> Ditto.
> 
> >  	u32 flex = 0;
> >
> > -	flex = rd32(wx, TXGBE_RDB_FDIR_FLEX_CFG(0));
> > -	flex &= ~TXGBE_RDB_FDIR_FLEX_CFG_FIELD0;
> > +	flex = rd32(wx, TXGBE_RDB_FDIR_FLEX_CFG(i));
> > +	flex &= ~(TXGBE_RDB_FDIR_FLEX_CFG_FIELD0 << (j * 8));
> >
> >  	flex |= (TXGBE_RDB_FDIR_FLEX_CFG_BASE_MAC |
> > -		 TXGBE_RDB_FDIR_FLEX_CFG_OFST(0x6));
> > -	wr32(wx, TXGBE_RDB_FDIR_FLEX_CFG(0), flex);
> > +		 TXGBE_RDB_FDIR_FLEX_CFG_OFST(0x6)) << (j * 8);
> > +	wr32(wx, TXGBE_RDB_FDIR_FLEX_CFG(i), flex);
> >
> >  	/* Continue setup of fdirctrl register bits:
> >  	 *  Move the flexible bytes to use the ethertype - shift 6 words
> > diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
> > index 261a83308568..094d55cdb86c 100644
> > --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
> > +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_type.h
> > @@ -272,7 +272,7 @@ struct txgbe_fdir_filter {
> >  	struct hlist_node fdir_node;
> >  	union txgbe_atr_input filter;
> >  	u16 sw_idx;
> > -	u16 action;
> > +	u64 action;
> >  };
> >
> >  /* TX/RX descriptor defines */
> > --
> > 2.48.1
> >
> >
> 


