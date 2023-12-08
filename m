Return-Path: <netdev+bounces-55299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F4D80A2CD
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 13:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B29701F211A7
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 12:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63AA1BDE0;
	Fri,  8 Dec 2023 12:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kNpdEyU3"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B671987
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 04:06:43 -0800 (PST)
Message-ID: <49d5c768-2a05-4f20-99cf-a92aa378ebdd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702037202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PFe7ctH+VkTXULxm2XkM90RYmTcv2+gpmy8zsa6VSog=;
	b=kNpdEyU31c2/m35Gjr3mJ0VCNwuEVuxffvAzwFCW0pAH/NMp4XMppi9Jf+LmNAOXKp59qr
	GzacUU4WpcNmIS1wv4LKv8nMrAC7zJsfAhvIK2WdDWeXswjD6RRgqxNpW4Hn4Hlm3gA+Bm
	eVhLkkALbjGHG72f8zJDcqhDZYM2niY=
Date: Fri, 8 Dec 2023 12:06:34 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [patch net-next] dpll: remove leftover mode_supported() op and
 use mode_get() instead
Content-Language: en-US
To: Jiri Pirko <jiri@resnulli.us>,
 "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
Cc: kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
 saeedm@nvidia.com, leon@kernel.org, richardcochran@gmail.com,
 jonathan.lemon@gmail.com, netdev@vger.kernel.org
References: <20231207151204.1007797-1-jiri@resnulli.us>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20231207151204.1007797-1-jiri@resnulli.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 07/12/2023 15:12, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Mode supported is currently reported to the user exactly the same, as
> the current mode. That's because mode changing is not implemented.
> Remove the leftover mode_supported() op and use mode_get() to fill up
> the supported mode exposed to user.
> 
> One, if even, mode changing is going to be introduced, this could be
> very easily taken back. In the meantime, prevent drivers form
> implementing this in wrong way (as for example recent netdevsim
> implementation attempt intended to do).
> 

I'm OK to remove from ptp_ocp part because it's really only one mode
supported. But I would like to hear something from Arkadiusz about the
plans to maybe implement mode change in ice?

> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---
>   drivers/dpll/dpll_netlink.c                   | 16 +++++++-----
>   drivers/net/ethernet/intel/ice/ice_dpll.c     | 26 -------------------
>   .../net/ethernet/mellanox/mlx5/core/dpll.c    |  9 -------
>   drivers/ptp/ptp_ocp.c                         |  8 ------
>   include/linux/dpll.h                          |  3 ---
>   5 files changed, 10 insertions(+), 52 deletions(-)
> 


