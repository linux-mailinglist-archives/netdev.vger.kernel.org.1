Return-Path: <netdev+bounces-18403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D66E6756C6D
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 20:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3EBC1C208EA
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 18:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A856BA50;
	Mon, 17 Jul 2023 18:48:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D19B253B8
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 18:48:16 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A679D
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 11:48:15 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-98df3dea907so634942066b.3
        for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 11:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689619693; x=1692211693;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ii06RB0ES+DRMclud4V3+/xZnaxwoU1WbsDW6EiAY7U=;
        b=XlmbEUfVE963tAZD7uX3suEA9JH2LmAscz3ppOt2Mn1M1M7Mx113Wl/ll7SBcOkv4o
         r0R8bMlYmPe7XTA1iDODJ1nx5xhzS8f0lpZ5J4CWxy2zenK+PJRgRBIUe1YibSFzmJxM
         HiaiWPRB2XmHJAwJ8G3ylGkyP2JP7bHIFo/s7dJF/21dKzBcv4pGX7r2PJQ8EPz6nZmT
         p+1WQpiDIfZCKVFzQSO1oDyTgS0n6jeSqQSRd0LV2svRr6NYN6GyMzlPzWTT3tMYtHyn
         fZbPphpLET56rrtlHVh/tD4VD1S3/NT/IUZt+6W/n8fOq8JWt9heGjKeaBObQAkVb3ki
         WxrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689619693; x=1692211693;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ii06RB0ES+DRMclud4V3+/xZnaxwoU1WbsDW6EiAY7U=;
        b=iCO6ZS6KZrL+WxSzjvu6CGKfU/uwOHhdFJ5y4DKdt5diCitHEjQxloD2MFp/Kln0bC
         QjPd7xJMRJjxzMP7fPPxe4/5D/nMZi4NYx1bfT58PLqMZRL5HFABDDofkdbDTTrE2Rig
         P+eFdhBwlBJWurh2krRyEZU6IKhpDtpODfO7rxSvQc+lUJVQFpIBKPoAc+DdUkTa4jsI
         eu3jT7kHSBXxTnPE1iDDow24Jd0cQr7DPAXsqesP0HxZKST9TObvL5DPsjlo9W7i/Xx4
         Uo0wg1hyj5m9tX+kLSOe0KInK95+52LuRNr26OYcCaiAKqBCTcG62Ve6Lflrzhj/JRVx
         S0Ew==
X-Gm-Message-State: ABy/qLbOjdp7CiBv5xzY5bU7VRgm3MXvWz8R8NuLud5QVWWkJcD72jmw
	epO7XsVSM8EG/6CkRPeHYhA=
X-Google-Smtp-Source: APBJJlHtvOC0TqDZxgal8B4dR3k8FBldDQBjIkZm5Uul9QRKpJkEQpxb3TOOL1L3u2CvXZSr2rf2SA==
X-Received: by 2002:a17:907:58d:b0:992:ab3a:f0d4 with SMTP id vw13-20020a170907058d00b00992ab3af0d4mr8458606ejb.17.1689619693292;
        Mon, 17 Jul 2023 11:48:13 -0700 (PDT)
Received: from [192.168.0.110] ([77.124.20.250])
        by smtp.gmail.com with ESMTPSA id gh5-20020a170906e08500b00992bea2e9d2sm39549ejb.62.2023.07.17.11.48.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 11:48:12 -0700 (PDT)
Message-ID: <bcf79bb0-00e2-5e4b-807f-ba43d4c122a9@gmail.com>
Date: Mon, 17 Jul 2023 21:48:10 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/1] drivers:net: fix return value check in
 mlx5e_ipsec_remove_trailer
Content-Language: en-US
To: Yuanjun Gong <ruc_gongyuanjun@163.com>, Saeed Mahameed
 <saeedm@nvidia.com>, Boris Pismenny <borisp@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
 Tariq Toukan <tariqt@nvidia.com>
References: <20230717144640.23166-1-ruc_gongyuanjun@163.com>
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20230717144640.23166-1-ruc_gongyuanjun@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 17/07/2023 17:46, Yuanjun Gong wrote:
> mlx5e_ipsec_remove_trailer should return an error code if function
> pskb_trim returns an unexpected value.
> 

It's a fix, please add a Fixes tag.

> Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c
> index eab5bc718771..8d995e304869 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c
> @@ -58,7 +58,9 @@ static int mlx5e_ipsec_remove_trailer(struct sk_buff *skb, struct xfrm_state *x)
>   
>   	trailer_len = alen + plen + 2;
>   
> -	pskb_trim(skb, skb->len - trailer_len);
> +	ret = pskb_trim(skb, skb->len - trailer_len);
> +	if (unlikely(ret))
> +		return ret;
>   	if (skb->protocol == htons(ETH_P_IP)) {
>   		ipv4hdr->tot_len = htons(ntohs(ipv4hdr->tot_len) - trailer_len);
>   		ip_send_check(ipv4hdr);

Other than that:
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

