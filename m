Return-Path: <netdev+bounces-208431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7BBB0B65D
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 16:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 991EE18855E0
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 14:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2A4217736;
	Sun, 20 Jul 2025 14:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAqQ8dQi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B51E21578D
	for <netdev@vger.kernel.org>; Sun, 20 Jul 2025 14:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753020906; cv=none; b=sY2te3vJyhKC1yZaraV552bBYFagAu5p+qSFR5KYBgHf5hHe6ubgniNK2/eqUjHV3eo8ySUAnd/N86xdsjVIUNv3sitzH7CU5Qs4uPow5pdL+HzvBEJ/jf0/7YAgy9MCbBn4G9tLtDQoTeHfL4SgXUW9xtXYv6A9H2Lne+jwX/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753020906; c=relaxed/simple;
	bh=T9jP8YMHoEvDyh3Lpsztn+qHedFD+KxlILfYJHbS11g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TcMpHd9lvMqRS4lr4psLylC+TV/94cBDdES3dP4TcD75CqRaLKkLqxUb13R/qDSeoXZLvF5yiJmJ2ma7Oj/F0Ccs1Lluxpol+GJBTrMShXWy9tugTAYHzvseU36VAsb52oOrVa7R83r+vd2pxtZ/B0kxva9bMAcuzUw/cFisrE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAqQ8dQi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2CBDC4CEE7;
	Sun, 20 Jul 2025 14:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753020906;
	bh=T9jP8YMHoEvDyh3Lpsztn+qHedFD+KxlILfYJHbS11g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NAqQ8dQiMs5TA9qPEVdGq8YJu9R/CbHBsNJTrETN14UoQp8saWLCRwV0V+cc9FQsu
	 9TlfylyxzAK5zjg1Dw6hgBQGwsJ/dCM28EZufjsWSEgN2z3yvtDHbcs3s8tDwfqXri
	 wPGhVq9s/ZmkHzLdDXnprSpjcAOWH9pDRcjXwQnU0iUjE0xWPhzgeIuGNV4xQG3fBd
	 CTidh4vnnolTwchJsEyOypUywrSr2LdxAaTx0l4EddMnMVQ6oiQVAzzX2I0iNPLrDi
	 lnyvinMbbOLVntEWLmSCy+2/cA+U0GPWJJPh/GmZp9Oa4xQDdIb5jaD1rW4ECHagQ5
	 dQwgGQaXe4iGg==
Date: Sun, 20 Jul 2025 15:15:02 +0100
From: Simon Horman <horms@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch
Subject: Re: [PATCH net-next] netdevsim: add couple of fw_update_flash_*
 debugfs knobs
Message-ID: <20250720141502.GV2459@horms.kernel.org>
References: <20250719131315.353975-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250719131315.353975-1-jiri@resnulli.us>

On Sat, Jul 19, 2025 at 03:13:15PM +0200, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Netdevsim emulates firmware update and it takes 5 seconds to complete.
> For some usecases, this is too long and unnecessary. Allow user to
> configure the time by exposing debugfs knobs to set flash size, chunk
> size and chunk time.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>

...

> @@ -1035,20 +1040,20 @@ static int nsim_dev_flash_update(struct devlink *devlink,
>  						   params->component, 0, 0);
>  	}
>  
> -	for (i = 0; i < NSIM_DEV_FLASH_SIZE / NSIM_DEV_FLASH_CHUNK_SIZE; i++) {
> +	for (i = 0; i < flash_size / flash_chunk_size; i++) {
>  		if (nsim_dev->fw_update_status)
>  			devlink_flash_update_status_notify(devlink, "Flashing",
>  							   params->component,
> -							   i * NSIM_DEV_FLASH_CHUNK_SIZE,
> -							   NSIM_DEV_FLASH_SIZE);
> -		msleep(NSIM_DEV_FLASH_CHUNK_TIME_MS);
> +							   i * flash_chunk_size,
> +							   flash_size);
> +		msleep(flash_chunk_time_ms);
>  	}

Hi Jiri,

This loop seems to assume that flash_size is an integer number multiple
of flash_chunk_size. But with this change that may not be the case,
leading to less than flash_size bytes being written.

Perhaps the code should to guard against that, or handle it somehow.

>  
>  	if (nsim_dev->fw_update_status) {
>  		devlink_flash_update_status_notify(devlink, "Flashing",
>  						   params->component,
> -						   NSIM_DEV_FLASH_SIZE,
> -						   NSIM_DEV_FLASH_SIZE);
> +						   flash_size,
> +						   flash_size);
>  		devlink_flash_update_timeout_notify(devlink, "Flash select",
>  						    params->component, 81);
>  		devlink_flash_update_status_notify(devlink, "Flashing done",

...

