Return-Path: <netdev+bounces-159315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7211AA15162
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 15:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A06E41693D2
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 14:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45C3200BB2;
	Fri, 17 Jan 2025 14:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Bgvc6Qd0"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F5C1FFC42
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 14:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737123311; cv=none; b=n/1ScJp+01okYEnDYT4s/aCTN+ke4gB9RI4ArP6BT4330vvpEcpzOGobeEQIzERWpwvi+5n8srP1QLH0VjX07nL7S8pNOgwxXs9/03yp7IpdxI2O6dYcNEA5XnY18mRsONGQEO7G4fWTaE5/ObKcRLnva4SOcnRsoHVSzccap0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737123311; c=relaxed/simple;
	bh=qFtytAXvN2k/5V0e66PWFL+SBYSQX6RSD2OVNqwND/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IXU3sSedL1ipJ9njFQr3uMEUJdEB15e12BwfALMrSQ+4H2azf/8gfWLYxZ2dnzQk90VnvTVkXKITjnZqcBBOT8YCTOjIZG8CDshG9LOyqLjVGkSbxtoSAAh+KWdW66JPMKszsMBiAyabXOPlrRstMVe7BB5T7OsXT9i6nvgD2ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Bgvc6Qd0; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9390f920-a89f-43d3-a75f-664fd05df655@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737123305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VSP7SrlX7wP5UxI9W8Ui4tDLgLEOzlpbYDI2HOQSZIk=;
	b=Bgvc6Qd0DxyklbbG2F7Ohggu12Q7gBHBez7y/yDtvmexQAlOS9HOLnvnoa6cKHu6B25C44
	v+2PBwcTFCf4N7jf9gHF2EKJD6M7/3viLJJA8RORQ9G9S96I8eIQ1+izNX/wXoUvQpCcRQ
	xfBDyVng16HBEcSR8SjBFFe11/infYA=
Date: Fri, 17 Jan 2025 14:15:01 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v5 1/4] net: wangxun: Add support for PTP clock
To: Jiawen Wu <jiawenwu@trustnetic.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com, linux@armlinux.org.uk,
 horms@kernel.org, jacob.e.keller@intel.com, netdev@vger.kernel.org
Cc: mengyuanlou@net-swift.com
References: <20250117062051.2257073-1-jiawenwu@trustnetic.com>
 <20250117062051.2257073-2-jiawenwu@trustnetic.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250117062051.2257073-2-jiawenwu@trustnetic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 17/01/2025 06:20, Jiawen Wu wrote:
> Implement support for PTP clock on Wangxun NICs.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

[...]

> +/**
> + * wx_ptp_create_clock
> + * @wx: the private board structure
> + *
> + * Returns 0 on success, negative value on failure
> + *
> + * This function performs setup of the user entry point function table and
> + * initalizes the PTP clock device used by userspace to access the clock-like
> + * features of the PTP core. It will be called by wx_ptp_init, and may
> + * re-use a previously initialized clock (such as during a suspend/resume
> + * cycle).
> + */
> +static long wx_ptp_create_clock(struct wx *wx)
> +{
> +	struct net_device *netdev = wx->netdev;
> +	long err;
> +
> +	/* do nothing if we already have a clock device */
> +	if (!IS_ERR_OR_NULL(wx->ptp_clock))
> +		return 0;
> +
> +	snprintf(wx->ptp_caps.name, sizeof(wx->ptp_caps.name),
> +		 "%s", netdev->name);
> +	wx->ptp_caps.owner = THIS_MODULE;
> +	wx->ptp_caps.n_alarm = 0;
> +	wx->ptp_caps.n_ext_ts = 0;
> +	wx->ptp_caps.n_per_out = 0;
> +	wx->ptp_caps.pps = 0;
> +	wx->ptp_caps.adjfine = wx_ptp_adjfine;
> +	wx->ptp_caps.adjtime = wx_ptp_adjtime;
> +	wx->ptp_caps.gettimex64 = wx_ptp_gettimex64;
> +	wx->ptp_caps.settime64 = wx_ptp_settime64;
> +	if (wx->mac.type == wx_mac_em)
> +		wx->ptp_caps.max_adj = 500000000;
> +	else
> +		wx->ptp_caps.max_adj = 250000000;
> +
> +	wx->ptp_clock = ptp_clock_register(&wx->ptp_caps, &wx->pdev->dev);
> +	if (IS_ERR(wx->ptp_clock)) {
> +		err = PTR_ERR(wx->ptp_clock);
> +		wx->ptp_clock = NULL;
> +		wx_err(wx, "ptp clock register failed\n");
> +		return err;
> +	} else if (wx->ptp_clock) {

there is no way ptp_clock_register() will return NULL, that means
this `else if` construction is always true, so it's meaning less.
Please remove it if there will be need for another version.

Otherwise LGTM,

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>


> +		dev_info(&wx->pdev->dev, "registered PHC device on %s\n",
> +			 netdev->name);
> +	}



[...]

