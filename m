Return-Path: <netdev+bounces-17505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0439751D37
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 11:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0ED11C21336
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 09:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A781100BB;
	Thu, 13 Jul 2023 09:30:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBB1100C0
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 09:30:16 +0000 (UTC)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89AD112E
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 02:30:11 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fbcbf4375dso603976e87.0
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 02:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20221208.gappssmtp.com; s=20221208; t=1689240610; x=1691832610;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bi1FlV5GLd9b5M5p2mDsMBKOhHCbBoFwfbfjXIV037U=;
        b=fo/F5nS1tzrOazQWrA2k5bOZneI6jl2csoF40VKZqI9mpoLUVMslv2zRzN8nXpp+OG
         9wjZ01YPQ1TvxaO2rr09Sp3Dp38/3ZjREQPDskpSdbISny68o8CZatSNOSjhHIxwkrMi
         KhfyiNQX+5s3DjsZauAK6n+EgTUq3P9eof/NcSvTHqKGGiqEiQBE+5kXE0gcQ23fUJTj
         +fLJ6543CrgO2xV3aVTyCkI9bbEm94htRqKy24ROYNF/qBVgsgcR39uCQT/zglRPHQcH
         UnIMALJ41yeQce8rJ35temr7dV4AaJLbtLPITqg7zY9XcXjiZOWLZVSSMMh47UgGQyDi
         5Rxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689240610; x=1691832610;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bi1FlV5GLd9b5M5p2mDsMBKOhHCbBoFwfbfjXIV037U=;
        b=TMmwst7/IitOTUUweQtEBHSR/mvICF+8N69PykKuX5mOHGWc7n8yqZ4WhQRpR+pLtU
         c8Ke5U6nnG5VB7o/V+lW2dwQT8slxaDthU1G4EonUIOBzI1uvYKo9b04rHr0/yTdiRYX
         +RtaTg2YbXDxbs36w2VygCVYDPdDA81YTrEsIrDIPSE3ydZctk6bIhHiVCgI4uyClhaa
         yFYal7qsILQa3nNDtJyGUOkUZFNQuPneauXrh0IBM0ICb1QBeKanQw7Q4P5n/CXgalWS
         Dsme8amKkZbtG31gmIftWF2//cpK6pSqjjxFQL6mGtTZTO8GMiyTw+AsDyvUbWfRUXrG
         4drw==
X-Gm-Message-State: ABy/qLZcluUEO9O+P/ZUXOPWzJXMJlOVzmfb7kXOqVXWbmS7MlaU2gM4
	6sBjwZJl9o1uGp4tmgPR6+QP3Q==
X-Google-Smtp-Source: APBJJlFR2XZ/G/iXZOxiDRpm0SXn+3u0Dcw26op0+Kd3dfBjGRYwGm5i7utYx9PqX/wDeW2GuOwyPw==
X-Received: by 2002:a05:6512:2315:b0:4f6:3ef3:13e8 with SMTP id o21-20020a056512231500b004f63ef313e8mr1653915lfu.0.1689240609563;
        Thu, 13 Jul 2023 02:30:09 -0700 (PDT)
Received: from [192.168.51.243] ([78.128.78.220])
        by smtp.gmail.com with ESMTPSA id h4-20020ac25d64000000b004fb6c61e79bsm1046916lft.117.2023.07.13.02.30.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 02:30:09 -0700 (PDT)
Message-ID: <1bd20ab6-4792-7689-932a-a7b9ccf72402@blackwall.org>
Date: Thu, 13 Jul 2023 12:30:07 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH net-next 2/4] vxlan: Add support for nexthop ID
 metadata
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 bridge@lists.linux-foundation.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, roopa@nvidia.com, dsahern@gmail.com, petrm@nvidia.com,
 taspelund@nvidia.com
References: <20230713070925.3955850-1-idosch@nvidia.com>
 <20230713070925.3955850-3-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230713070925.3955850-3-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 13/07/2023 10:09, Ido Schimmel wrote:
> VXLAN FDB entries can point to FDB nexthop objects. Each such object
> includes the IP address(es) of remote VTEP(s) via which the target host
> is accessible. Example:
> 
>   # ip nexthop add id 1 via 192.0.2.1 fdb
>   # ip nexthop add id 2 via 192.0.2.17 fdb
>   # ip nexthop add id 1000 group 1/2 fdb
>   # bridge fdb add 00:11:22:33:44:55 dev vx0 self static nhid 1000 src_vni 10020
> 
> This is useful for EVPN multihoming where a single host can be connected
> to multiple VTEPs. The source VTEP will calculate the flow hash of the
> skb and forward it towards the IP address of one of the VTEPs member in
> the nexthop group.
> 
> There are cases where an external entity (e.g., the bridge driver) can
> provide not only the tunnel ID (i.e., VNI) of the skb, but also the ID
> of the nexthop object via which the skb should be forwarded.
> 
> Therefore, in order to support such cases, when the VXLAN device is in
> external / collect metadata mode and the tunnel info attached to the skb
> is of bridge type, extract the nexthop ID from the tunnel info. If the
> ID is valid (i.e., non-zero), forward the skb via the nexthop object
> associated with the ID, as if the skb hit an FDB entry associated with
> this ID.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   drivers/net/vxlan/vxlan_core.c | 44 ++++++++++++++++++++++++++++++++++
>   1 file changed, 44 insertions(+)
> 

LGTM
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


