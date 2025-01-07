Return-Path: <netdev+bounces-155661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3231A034D0
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 03:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62AC4188580B
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 02:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A69412D758;
	Tue,  7 Jan 2025 02:01:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F3F2594A5
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 02:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736215282; cv=none; b=UdtUj7e+u5vB5SHdFuUrngvSp5rXDjKfFxBGyVIu/lEBIS7Tyd2tzs3l1kcAZOplgIkwlMuYiVeYfude1D6OxFvvpBzxso+kJpIrFqzIjVuBflvOicUMhDF7XdAp2WDsbFgN+xpkK1AhoY+oxAx5e9lPp3ToLDpxloyedpSsZ+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736215282; c=relaxed/simple;
	bh=pPM2FoDLEQuGBges2PPBszAa4+87VcpZVYMQDvGKuJA=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qg3fB1bkfM7YNkJoPT4YEOboIfIZWwZGXML3YpYoUCr4G+uXuJSvlDRrnhpbDwEs/2v+d6PrQopAZBvEMFmw2LHPErJ7J3rQo9Kv6XH2croMDpYafkyI9QJuHPRC+e92h/RX9SXeDYkVpWmcDOudYU3Sat3shd2oKp2cm52j9x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas5t1736215264t856t49011
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [125.118.30.165])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 1265989437814988002
To: "'Vadim Fedorenko'" <vadim.fedorenko@linux.dev>,
	<andrew+netdev@lunn.ch>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<richardcochran@gmail.com>,
	<linux@armlinux.org.uk>,
	<horms@kernel.org>,
	<jacob.e.keller@intel.com>,
	<netdev@vger.kernel.org>
Cc: <mengyuanlou@net-swift.com>
References: <20250106084506.2042912-1-jiawenwu@trustnetic.com> <20250106084506.2042912-2-jiawenwu@trustnetic.com> <836cb511-2fef-479e-8743-662cb3884b2c@linux.dev>
In-Reply-To: <836cb511-2fef-479e-8743-662cb3884b2c@linux.dev>
Subject: RE: [PATCH net-next v2 1/4] net: wangxun: Add support for PTP clock
Date: Tue, 7 Jan 2025 10:01:03 +0800
Message-ID: <034f01db60a8$01da7d70$058f7850$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQFgxPKZN8TRQHApGKDHehP8aTZMFAK5VMI2AdXv1HWz20mXAA==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MPAlP4yRn0xg2oubrlz1GiqdS1EgCTg8sxW2HWYj1tWQ2iJWe/Ghp2E4
	DXS1C2YN8/wae9TbftE8pzXCsNAnG3GM4AmjRUg+hjdOyRCroopmvpXQzIBIiYJoOGj9RcG
	+I2OOq3fIxRESyS4ssTOLsD1yH+7b5X7gZ4D0+ngn+to6f7CD2MOvoN138FDAtyLqZwjAd1
	fPyNX0xEJy1UCJ7mc9nmarOmv9YFqZXCaPdDZz+7FQp9hh5XLCPoxpqqwQvROPfSYvot4xF
	kFYBMAdxjyv1xCbjbWKyXCRyPFUx+dGfqULBlmbWpiRo9K/BpUnu/zXQ6Z0NA91wyA/RZop
	DeQhehkxwbRHz57Swtqhe6Ta95Ejx+MxRz0LGEUYQuLy68u6sK9Dqb1jnJrbUNMsTgt052a
	+VSkD9bpuGr+nqRxlhTOfreRiCY8uAHAe/S77GYvoQ5YO2aPu6mXV0Y191nfyOlc95hCEkb
	219iz8d8kJhQAhrahuL2Rpr67eVnthkoQUpUMV1GLjEIei8KUx5zK8iWZxA6DtnYBcpoxNa
	M2xAt+qsZYiRFtCcMXe14zfDDah+T9tQn+dh8zr0cYUx0y3f2R+C0LmeGwt/xuBItpTV8aM
	fBGKJCe+UJox6nQpZ7QfHao+9LZaUB7RLxlS7PH1/h3ENChXgE6TNHmV8rt/H8gzO5lNRnS
	r7I+uq0kCDTXalhKV0AEZONjTjYvqLT0OpDCaWedEKx9Z6bBkHc4ppN/t+DFyNxnMYWQ2Ny
	5UflfUX5xZvQ6lxvP1qSJL2CU+p2Ppl9rPCLXXm6ePokWM/4Xu9LU59AzMy15V+1DNm9s0U
	wy0MSB3L06l/WKstgF1FMt9z60QBywMD5KLMEcFOEj8BAWB5GTlfQK9MAQ29veDKgkpmaQi
	UxXCk5/5mrXH+ZhqXoNL1McraO4jtX+dB4Us4r25DBwM/6VC3dDQ1ecli4I3rrWm+MO+2k0
	zRC7WNqCMoLnffqb1GhpUGQGD224sVtgkUR3fnoqy36bf8m2lFcOIOSlbtHo8lEVHo6exlf
	gLl5HlxQ==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

> > +/**
> > + * wx_ptp_create_clock
> > + * @wx: the private board structure
> > + *
> > + * Returns 0 on success, negative value on failure
> > + *
> > + * This function performs setup of the user entry point function table and
> > + * initalizes the PTP clock device used by userspace to access the clock-like
> > + * features of the PTP core. It will be called by wx_ptp_init, and may
> > + * re-use a previously initialized clock (such as during a suspend/resume
> > + * cycle).
> > + */
> > +static long wx_ptp_create_clock(struct wx *wx)
> > +{
> > +	struct net_device *netdev = wx->netdev;
> > +	long err;
> > +
> > +	/* do nothing if we already have a clock device */
> > +	if (!IS_ERR_OR_NULL(wx->ptp_clock))
> > +		return 0;
> > +
> > +	snprintf(wx->ptp_caps.name, sizeof(wx->ptp_caps.name),
> > +		 "%s", netdev->name);
> > +	wx->ptp_caps.owner = THIS_MODULE;
> > +	wx->ptp_caps.n_alarm = 0;
> > +	wx->ptp_caps.n_ext_ts = 0;
> > +	wx->ptp_caps.n_per_out = 0;
> > +	wx->ptp_caps.pps = 0;
> > +	wx->ptp_caps.adjfine = wx_ptp_adjfine;
> > +	wx->ptp_caps.adjtime = wx_ptp_adjtime;
> > +	wx->ptp_caps.gettimex64 = wx_ptp_gettimex64;
> > +	wx->ptp_caps.settime64 = wx_ptp_settime64;
> > +	wx->ptp_caps.do_aux_work = wx_ptp_do_aux_work;
> 
> wx_ptp_do_aux_work is not defined in this patch, it appears in patch 3
> only. did you compile test your code patch by patch?

I think I may have created some confusion between the coding and testing
machines...
Thanks for your careful review.

 


