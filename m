Return-Path: <netdev+bounces-202252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90675AECE6A
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 17:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F9FF1895F8D
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 15:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39741233D85;
	Sun, 29 Jun 2025 15:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="H81BHnh4"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BC72309B0
	for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 15:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751212665; cv=none; b=UTA3EklruyadhhpIMmjBKl515JGPi4ZIu7zB0Fe/VB+YoC7jpOu19uI4owY17U9V98aamBSmOuI83/DRMPmOw+emLyYYmIwWryoWeYqjfTwFnkR/4xKAA7aeP4eIQkL1RpcP/Ffy/sfUeH6fMeJlPukV9wJ8RjtArpnZP0xtKnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751212665; c=relaxed/simple;
	bh=oXWTCCX2xoYpHj5cJlHDVuUps+Oef7Z++7fLmHOGZEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X+HWGfqjkyoJTDW4xiAHGQC0hp4L/kEke8CgIJcqGT1FDDVIyz2qe4VIsVIBhLfe74kOQa53MSMu3ULK65YKSRconWf8qzkjRY1qgvTR57Qtn6q2iddhHN8u35vDRxfVax3wOSZ/i4VLV/C0SiSEscNoy5Tt9zHMFGQ4pXn/YNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=H81BHnh4; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7b9e4743-bea3-497c-8972-4198d96284fa@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751212660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SXGXG9jcUm1RkDFMCjRgOKff8nwHBp7Uh00l+YD/zgM=;
	b=H81BHnh4nxcyftqTUQ7XBoGLxrWRXUWpIZuyvNQO0wsT8P7sI6NDM+uhkDAZfICPeEKE70
	c2dte1ZPeAM+bezlHZeD77GAbJQ1DC13wzQ0CWGeMgIbkYLpYPRsCq9xDXxv/wp5sQKhX1
	+Y5Zm5fWsHhBYpnFvgABCdaTZ+BL6Tc=
Date: Sun, 29 Jun 2025 16:57:37 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [patch 3/3] ptp: Enable auxiliary clocks for
 PTP_SYS_OFFSET_EXTENDED
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>,
 Christopher Hall <christopher.s.hall@intel.com>,
 John Stultz <jstultz@google.com>, Frederic Weisbecker <frederic@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Miroslav Lichvar <mlichvar@redhat.com>,
 Werner Abt <werner.abt@meinberg-usa.com>,
 David Woodhouse <dwmw2@infradead.org>, Stephen Boyd <sboyd@kernel.org>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Kurt Kanzenbach <kurt@linutronix.de>, Nam Cao <namcao@linutronix.de>,
 Antoine Tenart <atenart@kernel.org>
References: <20250626124327.667087805@linutronix.de>
 <20250626131708.544227586@linutronix.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250626131708.544227586@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 26/06/2025 14:27, Thomas Gleixner wrote:
> Allow ioctl(PTP_SYS_OFFSET_EXTENDED*) to select CLOCK_AUX clock ids for
> generating the pre and post hardware readout timestamps.
> 
> Aside of adding these clocks to the clock ID validation, this also requires
> to check the timestamp to be valid, i.e. the seconds value being greater
> than or equal zero. This is necessary because AUX clocks can be
> asynchronously enabled or disabled, so there is no way to validate the
> availability upfront.
> 
> The same could have been achieved by handing the return value of
> ktime_get_aux_ts64() all the way down to the IOCTL call site, but that'd
> require to modify all existing ptp::gettimex64() callbacks and their inner
> call chains. The timestamp check achieves the same with less churn and less
> complicated code all over the place.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   drivers/ptp/ptp_chardev.c |   21 ++++++++++++++++-----
>   1 file changed, 16 insertions(+), 5 deletions(-)
> 
> --- a/drivers/ptp/ptp_chardev.c
> +++ b/drivers/ptp/ptp_chardev.c
> @@ -325,13 +325,19 @@ static long ptp_sys_offset_extended(stru
>   	if (IS_ERR(extoff))
>   		return PTR_ERR(extoff);
>   
> -	if (extoff->n_samples > PTP_MAX_SAMPLES ||
> -	    extoff->rsv[0] || extoff->rsv[1] ||
> -	    (extoff->clockid != CLOCK_REALTIME &&
> -	     extoff->clockid != CLOCK_MONOTONIC &&
> -	     extoff->clockid != CLOCK_MONOTONIC_RAW))
> +	if (extoff->n_samples > PTP_MAX_SAMPLES || extoff->rsv[0] || extoff->rsv[1])
>   		return -EINVAL;
>   
> +	switch (extoff->clockid) {
> +	case CLOCK_REALTIME:
> +	case CLOCK_MONOTONIC:
> +	case CLOCK_MONOTONIC_RAW:
> +	case CLOCK_AUX ... CLOCK_AUX_LAST:
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
>   	sts.clockid = extoff->clockid;
>   	for (unsigned int i = 0; i < extoff->n_samples; i++) {
>   		struct timespec64 ts;
> @@ -340,6 +346,11 @@ static long ptp_sys_offset_extended(stru
>   		err = ptp->info->gettimex64(ptp->info, &ts, &sts);
>   		if (err)
>   			return err;
> +
> +		/* Filter out disabled or unavailable clocks */
> +		if (sts.pre_ts.tv_sec < 0 || sts.post_ts.tv_sec < 0)
> +			return -EINVAL;
> +
>   		extoff->ts[i][0].sec = sts.pre_ts.tv_sec;
>   		extoff->ts[i][0].nsec = sts.pre_ts.tv_nsec;
>   		extoff->ts[i][1].sec = ts.tv_sec;
> 
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

