Return-Path: <netdev+bounces-155318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C855A01DB7
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 03:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 845183A48D6
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 02:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10868FC0A;
	Mon,  6 Jan 2025 02:35:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA66341760
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 02:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736130938; cv=none; b=lE6npIFxKcn4gBXJ30AdWQUYfDcjZo2Tg2m18mL3VYsJ0WAtT+okX6D7E1DMisLVTMiL51S6EI4dpD+ndojwql+qm0DBGkrGm1oXBYZtvSjAsrn6F++2M5hTRd21nUfKguVqCG7noZgiApdX+5iDDvbYT3qas4m7GXUDzALBYeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736130938; c=relaxed/simple;
	bh=3MA7M54czBHWZtvLdpXquf6ZFDxHtP85XS/7bd1seO4=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=lFfcqdPgwFJLExG4mxDSi+6seJyUbFJCnTLZzOeY4ftzipZjBEC6Rdkc8mgbI6/flP8BAvD7jv5XF4bexNcv6JAWsoYU9ukREOFLpG/qUoAvbcvT7xvHVqvoZ/E3sWbpGOdyAEJRxaTn5miIrzUr+iNAtJt6KM8CDhyFwXeVmls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas7t1736130912t021t17706
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [125.118.30.165])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 4945668412689827072
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
References: <20250102103026.1982137-1-jiawenwu@trustnetic.com> <20250102103026.1982137-3-jiawenwu@trustnetic.com> <00a642f0-5e80-4aa7-b1e5-219fa0fcb973@linux.dev>
In-Reply-To: <00a642f0-5e80-4aa7-b1e5-219fa0fcb973@linux.dev>
Subject: RE: [PATCH net-next 2/4] net: wangxun: Implement get_ts_info
Date: Mon, 6 Jan 2025 10:35:10 +0800
Message-ID: <032601db5fe3$9b96d550$d2c47ff0$@trustnetic.com>
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
Thread-Index: AQEgJ35Ybs4gTOBDiJnQm6cX+eEXEQNNrCJ6AVZ4E0q0WlbVEA==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: M5wsar+mICWwPeH21VBg4wv7RCCyFWd1oWx/EPqbSfq0qPlNJxWTT6r9
	RG9cxliomCvIrxZewPZxI0VRwVx94KyVx+ix70UJ0EL6yE/5C5NRnjvI6PDxhqQUgTFfc7A
	ZkHtVmWbx9ZeQMvWaGZ1Al+7roFZ1z9IUEQb9lAItNl7UxeER9ABVLwVzwMJszLjPVkl/X6
	+BTQMtX5jPBesrQyehDb1F0PHKejht6WyqCUyLNLLqfmsuRFCEjEc0ml227vedriLm80kDD
	Ejhb3GaXPmIE/GZxKq3IIdKht7MGIIfb62ISoOmpAhb9khPsKFDwDsoecgv2NONGQNOYOeg
	3yx4L+qE+5YnLTzNA78SxLFagIgojmwi1WLLijX+FlK4+hMZZV2dLTpPJR+Gh/0z0R2Xeb2
	iluWXpYUGiQGkYWoSXo7Y2t5D5H2353aUBU3Y1drb+t5gvzc1GlRkSGeATiiQHccXrlkPw5
	DUNRc3DdIAq3ukHv1YohyAGhV0zoumrUvHcyDcjkLsIXs6mJyeoeR2FRjbc4wgNjog6Y6xy
	9N1B2xW+c1q2t33dul0FevejOyoIOJgMucLPebQPEaALspKobI86lDgCD5e4Z9QrLTiRdwe
	WqMYevq+SuWhTSnbwyJkAV+y4Wnw1uzxldYujxzIv95CnfPnF4N8bZFWYnltL2vk82jA3e+
	18IRmsxXJDFdInOXFQSPQ4MCruey0EFB10OEMMZhFgHhsJQ23jXr6FpBxWEgwBw/LZy9/t0
	r0ODg77xo3wvpSyKlJH2hVTGJNhrpEMPFb7av5yTwz7B5xGhqS/JM9Bkkj74VeM6PKANTDz
	VFdGc+qD+mJqJdX3gDGBCGFUoplKAvx8FyQOsuEy8U1Ga8eJSpg17wcQYHcpS11B5j6c5b7
	5ix0Qhzwe/yB/gEJnggueNR5ukV7g9+ftsU2tfF+siMVgiylbvEjmGkv2uOXzq/3KMFWhPM
	sBF6cRzwfu2bZdvGl2NwjJPEzndOF/Mef3CVo9Ha/RO7yTg==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

> > +int wx_get_ts_info(struct net_device *dev,
> > +		   struct kernel_ethtool_ts_info *info)
> > +{
> > +	struct wx *wx = netdev_priv(dev);
> > +
> > +	info->rx_filters = BIT(HWTSTAMP_FILTER_NONE) |
> > +			   BIT(HWTSTAMP_FILTER_PTP_V1_L4_SYNC) |
> > +			   BIT(HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ) |
> > +			   BIT(HWTSTAMP_FILTER_PTP_V2_L2_EVENT) |
> > +			   BIT(HWTSTAMP_FILTER_PTP_V2_L4_EVENT) |
> > +			   BIT(HWTSTAMP_FILTER_PTP_V2_SYNC) |
> > +			   BIT(HWTSTAMP_FILTER_PTP_V2_L2_SYNC) |
> > +			   BIT(HWTSTAMP_FILTER_PTP_V2_L4_SYNC) |
> > +			   BIT(HWTSTAMP_FILTER_PTP_V2_DELAY_REQ) |
> > +			   BIT(HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ) |
> > +			   BIT(HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ) |
> > +			   BIT(HWTSTAMP_FILTER_PTP_V2_EVENT);
> > +
> > +	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
> > +				SOF_TIMESTAMPING_RX_SOFTWARE |
> 
> SOF_TIMESTAMPING_RX_SOFTWARE is now moved to core networking and there
> is no need to report it from driver
> 
> > +				SOF_TIMESTAMPING_SOFTWARE |
> 
> SOF_TIMESTAMPING_SOFTWARE means "software-system-clock". What kind of
> software clock is provided by the driver?

I think I should remove it.


