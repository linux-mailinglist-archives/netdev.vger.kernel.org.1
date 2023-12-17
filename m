Return-Path: <netdev+bounces-58368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A72815F9F
	for <lists+netdev@lfdr.de>; Sun, 17 Dec 2023 15:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 997891F21DE9
	for <lists+netdev@lfdr.de>; Sun, 17 Dec 2023 14:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8439E4439A;
	Sun, 17 Dec 2023 14:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="TXRaIoZN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E3E44C65
	for <netdev@vger.kernel.org>; Sun, 17 Dec 2023 14:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a1e35c2807fso242001066b.3
        for <netdev@vger.kernel.org>; Sun, 17 Dec 2023 06:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1702822783; x=1703427583; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=46s4XR8p2ZqIXEzN3Qc7mK75wNdchG/YnXJTX3J45Fc=;
        b=TXRaIoZNSKnJbyxGi6Mrjy28AJ1Lyf+ir9Na8NGAdUHQBYy9MC3Wy31vUSz2VHsNar
         9rfnSMsmB01FEtdb/E2QDs0bTafInV2yW8U0DAxAMI/QnRxtW48oRCYq95I2klGX4p6A
         8/jenvTmQxmQkFjtjoiHbUmGt/FLxF2WS3I6TsmYSxNVKN/wj7dwvy5QuaznOAPVuGN9
         ubkdCUrsKQoVW55s6ztBlap1m8MYzRJ93Zsensi0D3rPKoyWafjvM4LVMUSI3av6KpoR
         8Mcr7IwVBiNCBYey15IaZ88ZeN3DSnJ2ElQIOnaSlslhuJBc1ERLoAjlvS6TUTTIPj1r
         lmSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702822783; x=1703427583;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=46s4XR8p2ZqIXEzN3Qc7mK75wNdchG/YnXJTX3J45Fc=;
        b=owLirkuc3dnU5742YPrN7aaTQHGUODX9Ien8ji88LOnlNKLxyvNFh2JiPnpAUghBTl
         8gbQ5Yq0wpLuS/vAaKiXcEXDVC/BaDWmxIOZGwIqVBPTE7qAaIQrv932w6c6HLCQh3DX
         dYbarJyYtT5rPgXSQCBnSLZDXQjuZ/hkueaJTXJ38M3k9VkldLRRvPfQqvk9kXO57tYU
         CEaT7VntlwRSZ7puW89B4JhAisCDTZibidtWeXY6WgzQpfgoa7pGmWxnzAqRnNcr5War
         GB/1f3M9VsTe26qqqI5DkkC0jAIq3nhasFum2j4DmAw74DCPRq7IERiuOndMtF0Gi6ym
         KqBQ==
X-Gm-Message-State: AOJu0YzHZTuCyd8eOQC1mR0vVqFD1FcBWIXDUE7eTvIPfVB/Qd8+kyR8
	vu/pqatZKy5k3yQS4a0QX2cPrA==
X-Google-Smtp-Source: AGHT+IHy7RWEEWDa0UpGrCYAt4bCTO1zFZ/U/S595rqDa+/oHui+ADssOTK47t9+CD2FIv5XDC2P2w==
X-Received: by 2002:a17:906:234c:b0:a23:513f:a83b with SMTP id m12-20020a170906234c00b00a23513fa83bmr305769eja.57.1702822783280;
        Sun, 17 Dec 2023 06:19:43 -0800 (PST)
Received: from [192.168.0.161] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id cx12-20020a170907168c00b00a1caa9dd507sm13068110ejd.52.2023.12.17.06.19.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Dec 2023 06:19:42 -0800 (PST)
Message-ID: <acc5f924-514d-40f3-a14f-7e569b56451b@blackwall.org>
Date: Sun, 17 Dec 2023 16:19:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: rtnl: use rcu_replace_pointer_rtnl in
 rtnl_unregister_*
Content-Language: en-US
To: Pedro Tammela <pctammela@mojatatu.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us, jhs@mojatatu.com,
 victor@mojatatu.com, martin@strongswan.org, idosch@nvidia.com,
 lucien.xin@gmail.com, edwin.peer@broadcom.com, amcohen@nvidia.com
References: <20231215175711.323784-1-pctammela@mojatatu.com>
 <20231215175711.323784-3-pctammela@mojatatu.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231215175711.323784-3-pctammela@mojatatu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/12/2023 19:57, Pedro Tammela wrote:
> With the introduction of the rcu_replace_pointer_rtnl helper,
> cleanup the rtnl_unregister_* functions to use the helper instead
> of open coding it.
> 
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> ---
>  net/core/rtnetlink.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index 5e0ab4c08f72..94c4572512b8 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -342,8 +342,7 @@ int rtnl_unregister(int protocol, int msgtype)
>  		return -ENOENT;
>  	}
>  
> -	link = rtnl_dereference(tab[msgindex]);
> -	RCU_INIT_POINTER(tab[msgindex], NULL);
> +	link = rcu_replace_pointer_rtnl(tab[msgindex], NULL);
>  	rtnl_unlock();
>  
>  	kfree_rcu(link, rcu);
> @@ -368,18 +367,13 @@ void rtnl_unregister_all(int protocol)
>  	BUG_ON(protocol < 0 || protocol > RTNL_FAMILY_MAX);
>  
>  	rtnl_lock();
> -	tab = rtnl_dereference(rtnl_msg_handlers[protocol]);
> +	tab = rcu_replace_pointer_rtnl(rtnl_msg_handlers[protocol], NULL);
>  	if (!tab) {
>  		rtnl_unlock();
>  		return;
>  	}
> -	RCU_INIT_POINTER(rtnl_msg_handlers[protocol], NULL);
>  	for (msgindex = 0; msgindex < RTM_NR_MSGTYPES; msgindex++) {
> -		link = rtnl_dereference(tab[msgindex]);
> -		if (!link)
> -			continue;
> -
> -		RCU_INIT_POINTER(tab[msgindex], NULL);
> +		link = rcu_replace_pointer_rtnl(tab[msgindex], NULL);
>  		kfree_rcu(link, rcu);
>  	}
>  	rtnl_unlock();

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

