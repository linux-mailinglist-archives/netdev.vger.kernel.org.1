Return-Path: <netdev+bounces-133613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB15996799
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 12:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E262B24C4F
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 10:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D464C18F2C1;
	Wed,  9 Oct 2024 10:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="M9Q71tuw"
X-Original-To: netdev@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F5A18E046;
	Wed,  9 Oct 2024 10:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728470862; cv=none; b=jcMZHSzVBTzdWyBNZSiyEc/zoGsjnf0pSJdZsBUgqQEuy+Ql2fpv1V/Bm1PBMH0FTTwIx3uM4LOkBytusAx90qSzyY72KavsFIJT6heL1fvVLLDZjU4OYoEhYIg7Cbzu32BtqXQP7mhogSW3onoF3a5OgGOdkqMy7GXuneT/klM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728470862; c=relaxed/simple;
	bh=DeGGr8eRNM1sOG5ooc1oEBYLMlvCiRdc/MY/Z+V1QGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hKsBY7zK2H8ePsCBhoR0eRwA+j6WdtNw6UlJpFSe4JZ/qSvMmfMoraOZpfTCxYN2QpVoKhkEVn6NY/G3tVRVDz/Pdo7ycfW6guiEOmoJwReM8tOhdvJ8kdZ/FYWk+6YEtP2SpASZapXdxm2j2KDemw+ufjnkbhY/rQ4OBPK6ykM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=M9Q71tuw; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728470851; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=cU67mvjUuCR3ylemxoenE5dWbfUp5sHbHLvCaaUCjVQ=;
	b=M9Q71tuwmA3nmRPNFiUJAHFXQdWGhM8c8rDGf39K1vJkf1fBIBD3gC76hiUar2pWJHi5kbiCe02/gx6NX6WbUr68bWcwR28nPtBVPS1949DHsa1HSt/bSBOZT6myHluTSM+WMFsgnLpvHwtZMTPDnfz4b0UJJe3DDjxvks6Zwz8=
Received: from 30.221.113.24(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WGidf1L_1728470849)
          by smtp.aliyun-inc.com;
          Wed, 09 Oct 2024 18:47:30 +0800
Message-ID: <0d21c4e5-f014-44b0-b7bd-82e4608e6228@linux.alibaba.com>
Date: Wed, 9 Oct 2024 18:47:29 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/smc: Address spelling errors
To: Simon Horman <horms@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Wenjia Zhang <wenjia@linux.ibm.com>,
 Jan Karcher <jaka@linux.ibm.com>, Tony Lu <tonylu@linux.alibaba.com>,
 Wen Gu <guwen@linux.alibaba.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org
References: <20241009-smc-starspell-v1-1-b8b395bbaf82@kernel.org>
Content-Language: en-US
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <20241009-smc-starspell-v1-1-b8b395bbaf82@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/9/24 6:05 PM, Simon Horman wrote:
> Address spelling errors flagged by codespell.
> 
> This patch is intended to cover all files under drivers/smc
> 
> Signed-off-by: Simon Horman <horms@kernel.org>
> ---
>   net/smc/smc.h      | 2 +-
>   net/smc/smc_clc.h  | 2 +-
>   net/smc/smc_core.c | 2 +-
>   net/smc/smc_core.h | 4 ++--
>   4 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/net/smc/smc.h b/net/smc/smc.h
> index ad77d6b6b8d3..78ae10d06ed2 100644
> --- a/net/smc/smc.h
> +++ b/net/smc/smc.h
> @@ -278,7 +278,7 @@ struct smc_connection {
>   						 */
>   	u64			peer_token;	/* SMC-D token of peer */
>   	u8			killed : 1;	/* abnormal termination */
> -	u8			freed : 1;	/* normal termiation */
> +	u8			freed : 1;	/* normal termination */
>   	u8			out_of_sync : 1; /* out of sync with peer */
>   };
>   
> diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
> index 5625fda2960b..5fd6f5b8ef03 100644
> --- a/net/smc/smc_clc.h
> +++ b/net/smc/smc_clc.h
> @@ -156,7 +156,7 @@ struct smc_clc_msg_proposal_prefix {	/* prefix part of clc proposal message*/
>   } __aligned(4);
>   
>   struct smc_clc_msg_smcd {	/* SMC-D GID information */
> -	struct smc_clc_smcd_gid_chid ism; /* ISM native GID+CHID of requestor */
> +	struct smc_clc_smcd_gid_chid ism; /* ISM native GID+CHID of requester */
>   	__be16 v2_ext_offset;	/* SMC Version 2 Extension Offset */
>   	u8 vendor_oui[3];	/* vendor organizationally unique identifier */
>   	u8 vendor_exp_options[5];
> diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
> index 4e694860ece4..500952c2e67b 100644
> --- a/net/smc/smc_core.c
> +++ b/net/smc/smc_core.c
> @@ -2321,7 +2321,7 @@ static struct smc_buf_desc *smcr_new_buf_create(struct smc_link_group *lgr,
>   		}
>   		if (lgr->buf_type == SMCR_PHYS_CONT_BUFS)
>   			goto out;
> -		fallthrough;	// try virtually continguous buf
> +		fallthrough;	// try virtually contiguous buf
>   	case SMCR_VIRT_CONT_BUFS:
>   		buf_desc->order = get_order(bufsize);
>   		buf_desc->cpu_addr = vzalloc(PAGE_SIZE << buf_desc->order);
> diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
> index 0db4e5f79ac4..69b54ecd6503 100644
> --- a/net/smc/smc_core.h
> +++ b/net/smc/smc_core.h
> @@ -30,7 +30,7 @@
>   					 */
>   #define SMC_CONN_PER_LGR_PREFER	255	/* Preferred connections per link group used for
>   					 * SMC-R v2.1 and later negotiation, vendors or
> -					 * distrubutions may modify it to a value between
> +					 * distributions may modify it to a value between
>   					 * 16-255 as needed.
>   					 */
>   
> @@ -181,7 +181,7 @@ struct smc_link {
>   					 */
>   #define SMC_LINKS_PER_LGR_MAX_PREFER	2	/* Preferred max links per link group used for
>   						 * SMC-R v2.1 and later negotiation, vendors or
> -						 * distrubutions may modify it to a value between
> +						 * distributions may modify it to a value between
>   						 * 1-2 as needed.
>   						 */
>   
> 

LGTM.

Reviewed-by: D. Wythe <alibuda@linux.alibaba.com>

D. Wythe


