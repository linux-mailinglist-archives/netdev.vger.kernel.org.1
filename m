Return-Path: <netdev+bounces-58500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F41816A8D
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 11:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2315E1C22619
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 10:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAEC12B89;
	Mon, 18 Dec 2023 10:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="lf/cbz4E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801E3134A9
	for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 10:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40c29f7b068so31017135e9.0
        for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 02:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1702894132; x=1703498932; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cgeuubteA4g8KPHC7Y210Emoi+OTT8dlwnrip9u/P0g=;
        b=lf/cbz4EP2z8igYUymgd5CfAOaUwkHuQdPGUQL76iB7QRd1nsNF+O6FBjyQrn4oPCp
         A3JVRVIo1jY6Iy73hYvnSuINhXEIMvP1jwPbSxrWy9bWmBfgIKBFBaIBfpBo81W+MaUG
         AkozxrZuEldF82KH+nBnGdR0LSMiVHySePcvi+70xc7xm5F7A7BK2MDzYtEcXDU6YdQJ
         2TGaquPpVs2QyxQHaWWeBAr8C5+sj5gqF71RjjDzefmuq1T7xslpczESQ6bsPZ2TX0XJ
         /urjaKhE54dNOEgXot/ph0QLcbwgZI3ngSwPLbWiQ7QqQGPv6lZ/VtJKZSiu9YtbqJ6n
         sCpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702894132; x=1703498932;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cgeuubteA4g8KPHC7Y210Emoi+OTT8dlwnrip9u/P0g=;
        b=wsOGH2aOm8R447jecVNqV43Va2semxzg9BJUM8R6iUqCrishNtmbP/wFFqpyAC5asX
         o+bR+L1d4ALDqCdnzP4Y21n512v9xpzfIQBdpYHqTkNCwHoMQngYIssjZIu49IFqqgb1
         qFlmrPKkMmicejsbFDAxMf7aZMA9zEisnZ6RTHuvnZhE43oOzv+Py6np6nNrOH4lgd8k
         trYuiIgqFXR+udAvDXM8ka0BaD/Fy+UOq4Dv44aMlexeHEJmbuRlhDfCYghskCEC/ze+
         j8ZuPneWmeo8G5/6LmLy0uK2HV1RacTTGVYYfQ6EWCZKNxvjUeDqKhdhKSYAZjehrtvT
         pWgA==
X-Gm-Message-State: AOJu0Yzg5RTaqgtf6Mc2BnqQ0Us6FcBO+egDFIg4ipk27iW50ciC5bT2
	Yoed3NipdpAy0cZlhG7m/lImUQ==
X-Google-Smtp-Source: AGHT+IGuhVTWohofK+CQ4e7TdTNrFjg8p1GSsokc4DG26V0bC28w4wxOKdctA19fa0FYVu0tIGeTtw==
X-Received: by 2002:a05:600c:1c01:b0:40b:380e:2c9e with SMTP id j1-20020a05600c1c0100b0040b380e2c9emr6890650wms.34.1702894131549;
        Mon, 18 Dec 2023 02:08:51 -0800 (PST)
Received: from [192.168.51.243] ([78.128.78.220])
        by smtp.gmail.com with ESMTPSA id bi8-20020a05600c3d8800b0040c43be2e52sm33818365wmb.40.2023.12.18.02.08.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 02:08:51 -0800 (PST)
Message-ID: <bf187ae3-5e5c-4259-87df-62a011e426f8@blackwall.org>
Date: Mon, 18 Dec 2023 12:08:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/9] net: Add MDB bulk deletion device operation
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 bridge@lists.linux-foundation.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, roopa@nvidia.com, petrm@nvidia.com
References: <20231217083244.4076193-1-idosch@nvidia.com>
 <20231217083244.4076193-4-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231217083244.4076193-4-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/12/2023 10:32, Ido Schimmel wrote:
> Add MDB net device operation that will be invoked by rtnetlink code in
> response to received 'RTM_DELMDB' messages with the 'NLM_F_BULK' flag
> set. Subsequent patches will implement the operation in the bridge and
> VXLAN drivers.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> ---
>   include/linux/netdevice.h | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 1b935ee341b4..75c7725e5e4f 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -1329,6 +1329,9 @@ struct netdev_net_notifier {
>    * int (*ndo_mdb_del)(struct net_device *dev, struct nlattr *tb[],
>    *		      struct netlink_ext_ack *extack);
>    *	Deletes the MDB entry from dev.
> + * int (*ndo_mdb_del_bulk)(struct net_device *dev, struct nlattr *tb[],
> + *			   struct netlink_ext_ack *extack);
> + *	Bulk deletes MDB entries from dev.
>    * int (*ndo_mdb_dump)(struct net_device *dev, struct sk_buff *skb,
>    *		       struct netlink_callback *cb);
>    *	Dumps MDB entries from dev. The first argument (marker) in the netlink
> @@ -1611,6 +1614,9 @@ struct net_device_ops {
>   	int			(*ndo_mdb_del)(struct net_device *dev,
>   					       struct nlattr *tb[],
>   					       struct netlink_ext_ack *extack);
> +	int			(*ndo_mdb_del_bulk)(struct net_device *dev,
> +						    struct nlattr *tb[],
> +						    struct netlink_ext_ack *extack);
>   	int			(*ndo_mdb_dump)(struct net_device *dev,
>   						struct sk_buff *skb,
>   						struct netlink_callback *cb);

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


