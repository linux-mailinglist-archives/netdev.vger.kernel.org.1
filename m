Return-Path: <netdev+bounces-24640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06670770E95
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 09:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7477282263
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 07:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4107477;
	Sat,  5 Aug 2023 07:53:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195771FDD
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 07:53:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C14E3C433C8;
	Sat,  5 Aug 2023 07:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691222014;
	bh=PC4Ds+J+Yy1q1eDBiTjeR+7fVZu+dB4pJP5K8KhcD5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l3XT0SKMsPKL14Fz+XIRl9a7t3Iqnhp/UEgS79yXdF+v/b80tcgdOjuNPlX7yYGUA
	 t01YUkjylxIm2EHaEjLtT0SbVpknlEmgyGIfNKLHV4HPjC3eTCIdvvnbtisX2/Kxyc
	 S87yn/rAMBvjy17oG7jJy6UwZ4z0fyvcHGy0J7oaU1PD/Vp4jamVsI6KK7/FmLA1qb
	 PDcYYlJev86p+lOFqF/xHAi9SNO42aUcH9xQa+VCuf28C/Dkv8PoMPHDNWrHDmMkq3
	 Tey2R1Uum3GyG4CRWD5Wqpanq3c+UhGeohYHkZHfFt61q2ejVqln6qkVyMF0FT9G+S
	 Hx/sliQYgvJGQ==
Date: Sat, 5 Aug 2023 09:53:30 +0200
From: Simon Horman <horms@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: johannes@sipsolutions.net, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2] wifi: iw_handler.h: Remove unused declaration
 dev_get_wireless_info()
Message-ID: <ZM3/+pY9Fovc5AC9@vergenet.net>
References: <20230804133617.43564-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804133617.43564-1-yuehaibing@huawei.com>

On Fri, Aug 04, 2023 at 09:36:17PM +0800, Yue Haibing wrote:
> Commit 556829657397 ("[NL80211]: add netlink interface to cfg80211")
> declared but never implemented this, remove it.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
> v2: fix comment
> ---
>  include/net/iw_handler.h | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/include/net/iw_handler.h b/include/net/iw_handler.h
> index d2ea5863eedc..b2cf243ebe44 100644
> --- a/include/net/iw_handler.h
> +++ b/include/net/iw_handler.h
> @@ -426,17 +426,10 @@ struct iw_public_data {
>  
>  /**************************** PROTOTYPES ****************************/
>  /*
> - * Functions part of the Wireless Extensions (defined in net/core/wireless.c).
> - * Those may be called only within the kernel.
> + * Functions part of the Wireless Extensions (defined in net/wireless/wext-core.c).

Can I confirm that the wireless.c -> wext-core.c change is intentional?
It doesn't seem strictly related to the patch description.

> + * Those may be called by driver modules.
>   */
>  
> -/* First : function strictly used inside the kernel */
> -
> -/* Handle /proc/net/wireless, called in net/code/dev.c */
> -int dev_get_wireless_info(char *buffer, char **start, off_t offset, int length);
> -
> -/* Second : functions that may be called by driver modules */
> -
>  /* Send a single event to user space */
>  void wireless_send_event(struct net_device *dev, unsigned int cmd,
>  			 union iwreq_data *wrqu, const char *extra);
> -- 
> 2.34.1
> 

