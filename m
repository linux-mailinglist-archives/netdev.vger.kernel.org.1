Return-Path: <netdev+bounces-44395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A31267D7CD3
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 08:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C17D281E6D
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 06:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D291172F;
	Thu, 26 Oct 2023 06:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="v7M2YWKP"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A7EF9E5
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 06:23:21 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9420B189
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 23:23:19 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4084095722aso4276555e9.1
        for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 23:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1698301398; x=1698906198; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9KQrkDY9cLbzOIPZ1XItMMko64XHXu+1s55t9JoUn1k=;
        b=v7M2YWKPP7hqkgnltcDmPeAz6lyhUQdDJrJAqMPXtwhhzhkqd6DzxgiqtrR69h3Y8u
         Ae81ThYJgLHj2dMBN38ks0QBueMK+A3I0mHQDwVWQBVu45HetEtT7/7aRQ9wQrhTZqzH
         nf0Q1cCl/8+UJelWV9DONoYuFGT0fhaXmi3VGirgX1CfTcixwHdJ98E9KvVc6opX9MnD
         kO5zyyCtxDNJ0YQTyz0nCFcoZUjPmFvhoDk4z0/V6+0I5KvJvNaXdnuFuRlANNsMbs2f
         onoh7F/KWTpR4w4yEHzSggTFOj+snd9y68eI42VPoCKUNJl1RiNmeX5Yu3dOnNqiEElI
         ei4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698301398; x=1698906198;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9KQrkDY9cLbzOIPZ1XItMMko64XHXu+1s55t9JoUn1k=;
        b=cCeKo2pGghZcic0m7umTeqyFcGI1EveXw9KiPyTMUxvLfP48g747aFTAmy14KG//QR
         4lXywGQhqbB6qXBVziq1BO3PtykA0rZpQoKEoy+BXrJle9lzyp12qzAmb+FLzXnGo3aO
         o+atN92wtsYNOca4bVdvZP8q5Wkks9aM4d7+3AhZm7rpRju4RF5FGrBzz8jkjmaMWgiT
         l6Gf4gnKNiTbT994mGyhqdIZe5C4AQyuR9xkOLvLVWdNvp955mFfG+DBAmcyVZt2uqpE
         a8OZjfaJBlu9KRHM4SCcCRhlciVZfw2bH+8H0lkhPrS5btC1O9XVmUAdL7q+Ri7UCKUE
         WIgA==
X-Gm-Message-State: AOJu0YxQ0vSu1YYKGn45J4OCU/p1mFhcFBZgER9s0JqGA1eR5faRBukH
	PuA4+LL0Ap52yVCOqRaTkKUE+g==
X-Google-Smtp-Source: AGHT+IHdrHpWvVQCdxYemGSjNSjyWYmDsnI559K7jDJdX/aJNOGGpwulCQYSGADg4rJqcW4ZVX8i5A==
X-Received: by 2002:a5d:638d:0:b0:317:6513:da7e with SMTP id p13-20020a5d638d000000b003176513da7emr11165496wru.36.1698301397977;
        Wed, 25 Oct 2023 23:23:17 -0700 (PDT)
Received: from [192.168.0.106] (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id g3-20020a5d6983000000b00326b8a0e817sm13586805wru.84.2023.10.25.23.23.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 23:23:17 -0700 (PDT)
Message-ID: <dbd33fe5-7b27-5454-6808-c975638c8321@blackwall.org>
Date: Thu, 26 Oct 2023 09:23:16 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH net-next v2 09/13] bridge: mcast: Add MDB get support
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 bridge@lists.linux-foundation.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, roopa@nvidia.com, mlxsw@nvidia.com
References: <20231025123020.788710-1-idosch@nvidia.com>
 <20231025123020.788710-10-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231025123020.788710-10-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/25/23 15:30, Ido Schimmel wrote:
> Implement support for MDB get operation by looking up a matching MDB
> entry, allocating the skb according to the entry's size and then filling
> in the response. The operation is performed under the bridge multicast
> lock to ensure that the entry does not change between the time the reply
> size is determined and when the reply is filled in.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
> 
> Notes:
>      v2:
>      * Add a comment above spin_lock_bh().
> 
>   net/bridge/br_device.c  |   1 +
>   net/bridge/br_mdb.c     | 158 ++++++++++++++++++++++++++++++++++++++++
>   net/bridge/br_private.h |   9 +++
>   3 files changed, 168 insertions(+)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>



