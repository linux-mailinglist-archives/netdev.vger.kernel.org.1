Return-Path: <netdev+bounces-41797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 429A27CBE93
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 11:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3490B20FBC
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 09:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2EC3E494;
	Tue, 17 Oct 2023 09:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="iGaFAIke"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25523D99D
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 09:08:57 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE6ED53
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 02:08:50 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40684f53ef3so57555295e9.3
        for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 02:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1697533729; x=1698138529; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=978qXrc9YEW7M0wZEw9ore1peLfv22bFLkhcrdH2ft8=;
        b=iGaFAIkepgLkbdrbc1UHBZ8t/YiDPbr1UoG6/j6nluOXZ3MiitZetIp+mG836A8EEN
         1/RW/FtpcPOFDhHNwModkSO5zfchk7PHyIisXHSGi+aDjvF0FJduVdu96fWNd/MhcbWB
         IMwIjPh7NoPJfqGWLgxY9DzwgJtqLpdD2jLttdb+vBbCysc0IzaVRhT4tFm6oClDDbSZ
         gPu+4em9TcJIT5c+LHngln1AglJ6O7/vJGPjK4i8jt8xBjrSAuCHf2UnbOVvB1SdAR0G
         RDpLDcynPhJJSv0YHGXV1FTGk8v+4VTvhqGtwJhXqYFJsyu2WeGI372D2OX/e5uW/9EH
         FG3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697533729; x=1698138529;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=978qXrc9YEW7M0wZEw9ore1peLfv22bFLkhcrdH2ft8=;
        b=fUm7JY0cmvW5U73/GiE03I82plW7mvCUhEFANILUJMt5jYSfpN3LD/jUuy4dbvnguG
         MBauCaIm+xYf27uFt1OOhcJno209oOzfZzGinCmXAjRjXY6bqe31l4VR8Z8y1fIWG5Mo
         4Zo21TDkQcW70vZD3/MsIMnHWQ0SQJBcCMtmDIIWYi/eS61h7NUTyWNj89w3J640xZF9
         LG0TLIEmlfWZ6NamhPrRO5KjD4u5ZqRAw6k/E5FZm1ZvYW8s0Sq7c0zw/d3Q63AhymEy
         h5SM9JGCSZhZpLtToK6kR7c6XUtgq/vb1/avs0WIfFn/K31PbLKeFw4AnBhTqXxAPvGA
         3+pw==
X-Gm-Message-State: AOJu0YweREYaTZcDa3GrsJbiDoAAqrIk4o9ageoTaGzzNBmoTEOdPuxf
	wxtRvEcx4WXeHp/9Yko/LkBhrg==
X-Google-Smtp-Source: AGHT+IFtmVgY2Etjqgkq/2FalSMZlzKy8YOSFyq+CGURWoaZHhN9z7rm9HMIdunpvXJJQZOdd6t1hg==
X-Received: by 2002:a05:600c:19c6:b0:407:8e85:899f with SMTP id u6-20020a05600c19c600b004078e85899fmr1206909wmq.16.1697533728868;
        Tue, 17 Oct 2023 02:08:48 -0700 (PDT)
Received: from [192.168.0.106] (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id t15-20020a05600c450f00b004064288597bsm1339463wmo.30.2023.10.17.02.08.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 02:08:48 -0700 (PDT)
Message-ID: <8558d00c-ae0c-54dc-8b41-4feeb991f8f8@blackwall.org>
Date: Tue, 17 Oct 2023 12:08:47 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH net-next 08/13] net: Add MDB get device operation
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 bridge@lists.linux-foundation.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, roopa@nvidia.com, mlxsw@nvidia.com
References: <20231016131259.3302298-1-idosch@nvidia.com>
 <20231016131259.3302298-9-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231016131259.3302298-9-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/16/23 16:12, Ido Schimmel wrote:
> Add MDB net device operation that will be invoked by rtnetlink code in
> response to received RTM_GETMDB messages. Subsequent patches will
> implement the operation in the bridge and VXLAN drivers.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   include/linux/netdevice.h | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 1c7681263d30..18376b65dc61 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -1586,6 +1586,10 @@ struct net_device_ops {
>   	int			(*ndo_mdb_dump)(struct net_device *dev,
>   						struct sk_buff *skb,
>   						struct netlink_callback *cb);
> +	int			(*ndo_mdb_get)(struct net_device *dev,
> +					       struct nlattr *tb[], u32 portid,
> +					       u32 seq,
> +					       struct netlink_ext_ack *extack);
>   	int			(*ndo_bridge_setlink)(struct net_device *dev,
>   						      struct nlmsghdr *nlh,
>   						      u16 flags,

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>



