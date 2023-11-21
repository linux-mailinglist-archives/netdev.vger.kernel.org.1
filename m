Return-Path: <netdev+bounces-49528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8857F246C
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 03:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0547A281283
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 02:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21498134A3;
	Tue, 21 Nov 2023 02:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Os5g50fJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC22CB
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 18:56:32 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1cf62a3b249so10395525ad.0
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 18:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700535392; x=1701140192; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7lVxM7IxfOKIhZGAnQjyX4jb5qqkmsYRP/Q35DcwOqM=;
        b=Os5g50fJ1MHgimzrlUvLTioQQ+av/qo1M1/SuBHmdZkUvsF5jk+tW7NbZA1ysCqjUX
         NcDzU7JZMxbY2+q3dfztI2XkT1uUkE2kGeLc76RAeZHY3gvo6FrfkhBsLGZeMdZVFOX4
         m3trGuRbwSfF8Zf0CM7VOeqnb6BaTN397Bah66SEQjGkzXHQ7KqbU5tl2T/LtTSxvLM+
         yzJ+esHWkrAGDpDKftnCZMGXOzy3gtPG62RcKqLjaz5PpnEU2DYyyiXaF7MfXheegWdp
         75NdQR+bycVKmD77nc00LGHfOqbWGry2ihZLLFqvL7PNAngHcRDawrzzTL73XYM1ICEj
         5nGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700535392; x=1701140192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7lVxM7IxfOKIhZGAnQjyX4jb5qqkmsYRP/Q35DcwOqM=;
        b=igg8GeogfXAk1VyS+iJQE8GVKwgM23dg6j6s1e3T4K7mJHoHmFWVQehfH1ICK6FbRr
         lbboXrjakEMKyh1FLRDzZiuWAifyRrkr1SzJXAOwFEdZyxrMlMj2N7V//KyAAFlDTOC5
         Xk7gZqBS2UFdh0Dxlsu1Mz8uE1Qvlo9jJ8CMtvswwUqWhx5Dg+E0kqq8hNcnj28GQ/dk
         O1T3qTbSlW92fPvch1blwLFcrTnYMK/xxLb3uT/Rpyv66fQyk853gnXA36mxh7Dc1+0C
         d9k87w6FKYgsEEvovyx7JXhU64hhQv/ieFynEgaSSC87oboZgvTHJR7ONzUSr2D8BPt+
         Zz2A==
X-Gm-Message-State: AOJu0YziGxiTI0PqqREX0rRvLsOskr1fyKAtj8Xh3VFTsVFrEp7rO5kY
	lq6zTWXAGFzCJi2lTTf5uGJz2d4+WTa/EG3b
X-Google-Smtp-Source: AGHT+IF0hxaMteeLjZHRbUyDRB+/5vIWsKwb5LDPj649PpHKYg7ywS92oXzriaZgVXMBcCP5jNqIbw==
X-Received: by 2002:a17:903:1252:b0:1cc:251c:c381 with SMTP id u18-20020a170903125200b001cc251cc381mr7956210plh.29.1700535391952;
        Mon, 20 Nov 2023 18:56:31 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id b5-20020a170903228500b001cc0f6028b8sm6748806plh.106.2023.11.20.18.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 18:56:31 -0800 (PST)
Date: Tue, 21 Nov 2023 10:56:26 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	weiyongjun1@huawei.com, yuehaibing@huawei.com
Subject: Re: [PATCH net] ipv4: igmp: fix refcnt uaf issue when receiving igmp
 query packet
Message-ID: <ZVwcWmg5NtuTSV7q@Laptop-X1>
References: <20231121020558.240321-1-shaozhengchao@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121020558.240321-1-shaozhengchao@huawei.com>

Hi Zhengchao,
On Tue, Nov 21, 2023 at 10:05:58AM +0800, Zhengchao Shao wrote:
> ---
>  net/ipv4/igmp.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
> index 76c3ea75b8dd..f217581904d6 100644
> --- a/net/ipv4/igmp.c
> +++ b/net/ipv4/igmp.c
> @@ -1044,6 +1044,8 @@ static bool igmp_heard_query(struct in_device *in_dev, struct sk_buff *skb,
>  	for_each_pmc_rcu(in_dev, im) {
>  		int changed;
>  
> +		if (!netif_running(im->interface->dev))
> +			continue;

I haven't checked this part for a long time. What's the difference of in_dev->dev
and im->interface->dev? I though they are the same, no?

If they are the same, should we stop processing the query earlier? e.g.

diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index 76c3ea75b8dd..f4e1d229c9aa 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -1082,6 +1082,9 @@ int igmp_rcv(struct sk_buff *skb)
                        goto drop;
        }

+       if (!netif_running(dev))
+               goto drop;
+
        in_dev = __in_dev_get_rcu(dev);
        if (!in_dev)
                goto drop;


BTW, does IPv6 MLD has this issue?

Thanks
Hangbin

