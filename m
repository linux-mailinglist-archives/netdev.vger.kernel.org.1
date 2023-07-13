Return-Path: <netdev+bounces-17503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7439F751D2A
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 11:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26373281BB8
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 09:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D47100AF;
	Thu, 13 Jul 2023 09:29:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059DF645
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 09:29:27 +0000 (UTC)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7867A1BF8
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 02:29:26 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b6a084a34cso6484481fa.1
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 02:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20221208.gappssmtp.com; s=20221208; t=1689240564; x=1691832564;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bsVmfGKx3JXZYIZAj2sAzKGn4PToD7TqBYHKEzg5nto=;
        b=OAnxR7sZlPRNrMXt4kWEK+yNxP/NCURgWaHEGLa2wYbRRl6ISG0A/U/BpdXylMgYtU
         d6kfogGXYRopfW1VioEhTOe9hoEqBH623r6SNcgEqw4i0iCGwJEiavi/qSTZnT9U5GIV
         fR+ncQJZe9mLIPbxyX3UTyzLC4lypIuklt92LUcr90im6PC5YueMAL+t74ZGstz1cNBb
         sTI0UBtD1C/ykVd6y7ONayIVDRuVCyh3zJI7IZEYP0LKiLlzQkqb/Lc4k/DdB9nFgbZH
         LX6I27edSUZxdIw+k3UFVUl9tuHjJrMJhtMotlE66iZosG4hZbgkZxwnQL7HrnQmfbVr
         Vxrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689240565; x=1691832565;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bsVmfGKx3JXZYIZAj2sAzKGn4PToD7TqBYHKEzg5nto=;
        b=V736gS5+UEQ2OTZSD03ZO84cyxLeWkWiSUcf3J3ermeeKVXT9cbWE0ah9h09t25oya
         mXMO9XHPHMfrj5UhRg/qYbQXF7aE/134cYfVi+lO/tSwSrIZWP7KA/1tbRiW8xRsOT0a
         mVRA12sBl+KBS+qcxE5OAtdAUpuMWozXx2A9pAu+xrv2yijtxKR4SaojBXM869tYAfka
         4+xgPR6t4gQQ7kbefRpJGBGzm2l1/V8TaK7m3Qh82jVEWxW/486Lyh2MVAE86/dS+ThS
         /AgzrR4b2RzHZKW/clsOE7gZQIPdfJghtgkMVGSbpIzkAtdhCSSa2i/O6SbCcFBSlLSt
         LCPg==
X-Gm-Message-State: ABy/qLaMZTGdGdr/ZlVxc9l0vq+TrgOM/Oi23QFY3yDgl7bFMD8s7j0C
	AS9RbbxECszx1Sz73L16dVPVqA==
X-Google-Smtp-Source: APBJJlEbccQh+Fe73AZgnIslTq9Iowmz40ZtXehUemrv0jO+EbBGRc3c4ISaVg7GhBgi9oPnMAIbGA==
X-Received: by 2002:a05:651c:10d:b0:2b6:d44c:c25b with SMTP id a13-20020a05651c010d00b002b6d44cc25bmr828911ljb.45.1689240564574;
        Thu, 13 Jul 2023 02:29:24 -0700 (PDT)
Received: from [192.168.51.243] ([78.128.78.220])
        by smtp.gmail.com with ESMTPSA id y1-20020a05651c020100b002b6cc613c23sm1404073ljn.80.2023.07.13.02.29.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 02:29:24 -0700 (PDT)
Message-ID: <d003b6e7-6db1-f5e3-d356-237e4bf3a34c@blackwall.org>
Date: Thu, 13 Jul 2023 12:29:22 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH net-next 1/4] ip_tunnels: Add nexthop ID field to
 ip_tunnel_key
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 bridge@lists.linux-foundation.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, roopa@nvidia.com, dsahern@gmail.com, petrm@nvidia.com,
 taspelund@nvidia.com
References: <20230713070925.3955850-1-idosch@nvidia.com>
 <20230713070925.3955850-2-idosch@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230713070925.3955850-2-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 13/07/2023 10:09, Ido Schimmel wrote:
> Extend the ip_tunnel_key structure with a field indicating the ID of the
> nexthop object via which the skb should be routed.
> 
> The field is going to be populated in subsequent patches by the bridge
> driver in order to indicate to the VXLAN driver which FDB nexthop object
> to use in order to reach the target host.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   include/net/ip_tunnels.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
> index ed4b6ad3fcac..e8750b4ef7e1 100644
> --- a/include/net/ip_tunnels.h
> +++ b/include/net/ip_tunnels.h
> @@ -52,6 +52,7 @@ struct ip_tunnel_key {
>   	u8			tos;		/* TOS for IPv4, TC for IPv6 */
>   	u8			ttl;		/* TTL for IPv4, HL for IPv6 */
>   	__be32			label;		/* Flow Label for IPv6 */
> +	u32			nhid;
>   	__be16			tp_src;
>   	__be16			tp_dst;
>   	__u8			flow_flags;

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


