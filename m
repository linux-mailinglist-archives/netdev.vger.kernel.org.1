Return-Path: <netdev+bounces-24168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7122876F13F
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 20:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 153AC2822E5
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 18:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBBD25175;
	Thu,  3 Aug 2023 18:03:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B711F16D
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 18:03:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A72CC433C7;
	Thu,  3 Aug 2023 18:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691085790;
	bh=VrjKRx+oWp5ae5K/8G0kK9vqZU2UuHSN2r5BpFukw+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CRdu56irx6tj4e1Mt6Yl3O+Efl7BEJqpB7L+M4U/gXlJxGkCS18Y7jIV+cL57E4we
	 SujUzYcOtZsYUL051sAyHV5s9dTn6t/wjfHaQ9YfoXrZvfabmyR0Bfe7gCNyCQC/Rx
	 InzhpZrGGLa6tiX3A6SSzeNwhmi4IKRRUFGBqslG87I43WDJebBPPSPZTHj0wZlxi8
	 IwC9MwsyhBtUn1FTgPmFLJ3U7vJPoNwwCQ2TkUH41yennKINTm3ty1sgnqFTlUigPt
	 xt46UwxRtxAe0KkE/VZjdcEZkglwscJ62qNyw1ZAsLJltAVOTOyPB1j6RFx4kQvnuC
	 ZZkoDrWKZYu2w==
Date: Thu, 3 Aug 2023 20:03:06 +0200
From: Simon Horman <horms@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: johannes@sipsolutions.net, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] wifi: iw_handler.h: Remove unused declaration
 dev_get_wireless_info()
Message-ID: <ZMvr2lNVTPLqs8Nq@kernel.org>
References: <20230803134248.42652-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803134248.42652-1-yuehaibing@huawei.com>

On Thu, Aug 03, 2023 at 09:42:48PM +0800, Yue Haibing wrote:
> Commit 556829657397 ("[NL80211]: add netlink interface to cfg80211")
> declared but never implemented this, remove it.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  include/net/iw_handler.h | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/include/net/iw_handler.h b/include/net/iw_handler.h
> index d2ea5863eedc..99f46f521aa7 100644
> --- a/include/net/iw_handler.h
> +++ b/include/net/iw_handler.h
> @@ -432,9 +432,6 @@ struct iw_public_data {
>  
>  /* First : function strictly used inside the kernel */
>  

Hi Yue Haibing,

I think you can remove the comment above and blank line below it too.

> -/* Handle /proc/net/wireless, called in net/code/dev.c */
> -int dev_get_wireless_info(char *buffer, char **start, off_t offset, int length);
> -
>  /* Second : functions that may be called by driver modules */

And work this into the comment above the to be deleted 'First :' comment.
Something like this:

/*
 * Functions part of the Wireless Extensions (defined in net/core/wireless.c).
 * These may be called by driver modules.
 */ 

>  
>  /* Send a single event to user space */
> -- 
> 2.34.1
> 
> 

