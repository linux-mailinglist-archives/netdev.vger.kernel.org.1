Return-Path: <netdev+bounces-34662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D93657A522F
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 20:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 923F9281771
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 18:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC10B1F947;
	Mon, 18 Sep 2023 18:40:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D591F5E8
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 18:40:36 +0000 (UTC)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2840D115
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 11:40:34 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-502fdfeb1d9so4018118e87.2
        for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 11:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1695062432; x=1695667232; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2WdsSfofUGele0mRKN0b7stC04NtZCFmAAWd2U17AD0=;
        b=x7GPbHCH2cQZRsl8f1oC+pTnRGOBNwvvJPRVFU2ZSo7FZlV4BGtK/VCVBHhPgXHdjn
         c5CCWW6Vz4iAZuSr+H8a65L9M2L6AyWvGvuSLML5/h/DJrHTOVQHggy0djF/2P9UqsgX
         vVTSUDKocohIbAFjMAYxb1p1+E0SZzg6YZSj1cQJ/UoBBvhiDITkaaWOKu8BiQOByOKC
         HVJJNz46cNKSPbKB/kfUuvd1APkIk7dkssAbcD3IBzCggeITj1OzldjEi+sAkrNWESfA
         NK/LvAJS1J1BnrVoqpXnflVRkBbRSdqVhBZIBFdKAbcG50It26q6fFhSuyOD/kte15Y7
         niJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695062432; x=1695667232;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2WdsSfofUGele0mRKN0b7stC04NtZCFmAAWd2U17AD0=;
        b=PcKvPfnsWAni1UwtodpNx1hURJXYceCMfO8RM0ilrXJ4V695lJ+XHxW31Sa4FYNVq8
         ulP1maXUdE0i8gEdIa8rca9WxPVJAjn2Mfe4yHdGNWmETz3aHtLCogG5u/k2XFjNPD8E
         TDsfuwZSvwOz53mqnHQaPzfCbRJIi0bZ/ardVUKp8RiEzfpc0ENAdkKjWe9dekwEwskY
         aoTy/ZRn4IoUNMjNORCk2SioFBMuf8BW30mQo5bwiG98Ri77ugsenu9NK17gouWIqpTm
         WKSfoRN1PJzJ+lMn9U1En4FXhs5wLyiYxrZOHmEjY5hSygMx/lJcSvfydLVjG6jHJdMP
         cmRw==
X-Gm-Message-State: AOJu0YyuCz7Hr58LO/pFzeYHThHenJOT2vE4KIR+JkEQV0HRyuh0lsuD
	Mvn6AN33UVJpJdj+BB3hINZH+w==
X-Google-Smtp-Source: AGHT+IEG5a0g3TQxjA6y+VsgWpRutdjILd2hXXFuYE6O9EeZg+pUHc+g67XKe9NEynTqdCUmxUpIZQ==
X-Received: by 2002:ac2:5bc2:0:b0:500:ba5d:e750 with SMTP id u2-20020ac25bc2000000b00500ba5de750mr7419176lfn.52.1695062432136;
        Mon, 18 Sep 2023 11:40:32 -0700 (PDT)
Received: from [192.168.0.105] (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id e9-20020aa7d7c9000000b0050488d1d376sm6440576eds.0.2023.09.18.11.40.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 11:40:31 -0700 (PDT)
Message-ID: <e3405821-a614-2e04-c319-b54b9a1a0901@blackwall.org>
Date: Mon, 18 Sep 2023 21:40:29 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH net] vxlan: Add missing entries to vxlan_get_size()
Content-Language: en-US
To: Benjamin Poirier <bpoirier@nvidia.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>,
 Simon Horman <horms@kernel.org>, Jiri Benc <jbenc@redhat.com>,
 Gavin Li <gavinl@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>,
 Vladimir Nikishkin <vladimir@nikishkin.pw>, Li Zetao <lizetao1@huawei.com>,
 Thomas Graf <tgraf@suug.ch>, Tom Herbert <therbert@google.com>,
 Roopa Prabhu <roopa@nvidia.com>
References: <20230918154015.80722-1-bpoirier@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230918154015.80722-1-bpoirier@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/18/23 18:40, Benjamin Poirier wrote:
> There are some attributes added by vxlan_fill_info() which are not
> accounted for in vxlan_get_size(). Add them.
> 
> I didn't find a way to trigger an actual problem from this miscalculation
> since there is usually extra space in netlink size calculations like
> if_nlmsg_size(); but maybe I just didn't search long enough.
> 
> Fixes: 3511494ce2f3 ("vxlan: Group Policy extension")
> Fixes: e1e5314de08b ("vxlan: implement GPE")
> Fixes: 0ace2ca89cbd ("vxlan: Use checksum partial with remote checksum offload")
> Fixes: f9c4bb0b245c ("vxlan: vni filtering support on collect metadata device")
> Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
> ---
>   drivers/net/vxlan/vxlan_core.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index e463f59e95c2..5b5597073b00 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c
> @@ -4331,6 +4331,10 @@ static size_t vxlan_get_size(const struct net_device *dev)
>   		nla_total_size(sizeof(__u8)) + /* IFLA_VXLAN_REMCSUM_TX */
>   		nla_total_size(sizeof(__u8)) + /* IFLA_VXLAN_REMCSUM_RX */
>   		nla_total_size(sizeof(__u8)) + /* IFLA_VXLAN_LOCALBYPASS */
> +		nla_total_size(0) + /* IFLA_VXLAN_GBP */
> +		nla_total_size(0) + /* IFLA_VXLAN_GPE */
> +		nla_total_size(0) + /* IFLA_VXLAN_REMCSUM_NOPARTIAL */
> +		nla_total_size(sizeof(__u8)) + /* IFLA_VXLAN_VNIFILTER */
>   		0;
>   }
>   

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

