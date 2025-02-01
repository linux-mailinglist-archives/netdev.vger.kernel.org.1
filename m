Return-Path: <netdev+bounces-161920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FB0A24A19
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 17:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2F427A1D63
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 16:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6BF374EA;
	Sat,  1 Feb 2025 16:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvAVsmys"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AA22F56
	for <netdev@vger.kernel.org>; Sat,  1 Feb 2025 16:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738425761; cv=none; b=kmh33vzvLmaVPM4mlW/wkbIoCKZIuOQnWjD3maDXg7GaliutN4vir2O+IlH14RyAhZuUF5tUqkjqTXmNJbltLQFr+paQKVC897nMEufYtr5SM5OWUWQAj5xTLBMzdKSXAxehaRHn9URhkUqOuPeKf2fY9dtFCR/msxwFmojYSbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738425761; c=relaxed/simple;
	bh=V6xwWefxYKrAr3urRl591ej3lm08zf4FcfQltiimysk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DgpquUjj7d76y/1iARe7TaNxtGeL9BUdivEY0Cri2J+oNqOIWs1QUsZwJxT5U14a+qHY8tm2LexnZ8inMpRATosEMFpbdmNKKQidU4IWcLSslnOiiWfnOkjiYo4jAzUyiTtPIzvbkZDHJSXfJNKIoF+EMZyANEcrbT/OfWsnb6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvAVsmys; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F87C4CED3;
	Sat,  1 Feb 2025 16:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738425760;
	bh=V6xwWefxYKrAr3urRl591ej3lm08zf4FcfQltiimysk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mvAVsmysg8RFDj8JDRSkgCpMf5B2Cda66pCDcyPaJ8OCF1I5TD05SyMbE7CEHyLS1
	 cyxUaKTXFxxe+ez9ip96QeXOxDG/aJ0i1+iNVss4NQSH9i0DiEvRHG9opGegTtsJKa
	 sAzVsCi4ysCjXXfI7Lo5D1BBOO0ghsh4wYpE2902nqNky375HVsE0UDww/AvuMddOy
	 ziqDHTcjomVoFIniXIv6/+OwZoaknHk3URJ3riKvDBsVJp+Pe6tUAF60Cs47vjmR4H
	 OmvAM6DvcmFaHJS/OYngc1brHhG5q9oesWEDmpm1lZY/Nny3XlxnM/1FfCINDpeVXG
	 2AnqOjrgzW3Wg==
Date: Sat, 1 Feb 2025 16:02:37 +0000
From: Simon Horman <horms@kernel.org>
To: Wojtek Wasko <wwasko@nvidia.com>
Cc: netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH RFC net-next] ptp: Add file permission checks on PHC
 chardevs
Message-ID: <20250201160237.GB211663@kernel.org>
References: <DM4PR12MB8558AB3C0DEA666EE334D8BCBEE82@DM4PR12MB8558.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR12MB8558AB3C0DEA666EE334D8BCBEE82@DM4PR12MB8558.namprd12.prod.outlook.com>

On Fri, Jan 31, 2025 at 06:29:23PM +0000, Wojtek Wasko wrote:
> Udev sets strict 600 permissions on /dev/ptp* devices, preventing
> unprivileged users from accessing the time [1]. This patch enables
> more granular permissions and allows readonly access to the PTP clocks.
> 
> Add permission checking for ioctls which modify the state of device.
> Notably, require WRITE for polling as it is only used for later reading
> timestamps from the queue (there is no peek support). POSIX clock
> operations (settime, adjtime) are checked in the POSIX layer.
> 
> [1] https://lists.nwtime.org/sympa/arc/linuxptp-users/2024-01/msg00036.html
> 
> Signed-off-by: Wojtek Wasko <wwasko@nvidia.com>

...

> @@ -516,9 +554,15 @@ __poll_t ptp_poll(struct posix_clock_context *pccontext, struct file *fp,
>  {
>  	struct ptp_clock *ptp =
>  		container_of(pccontext->clk, struct ptp_clock, clock);
> +	struct ptp_private_ctxdata *ctxdata;
>  	struct timestamp_event_queue *queue;
>  
> -	queue = pccontext->private_clkdata;
> +	ctxdata = pccontext->private_clkdata;
> +	if (!ctxdata)
> +		return EPOLLERR;
> +	if ((ctxdata->fmode & FMODE_WRITE) == 0)
> +		return EACCES;

Hi Wojtek,

This is not a full review, but rather, something to take into account
if this idea goes forwards:

The return type of this function is __poll_t, not int.
So I think this should be EPOLLERR rather than EACCESS.

> +	queue = ctxdata->queue;
>  	if (!queue)
>  		return EPOLLERR;
>  

...

