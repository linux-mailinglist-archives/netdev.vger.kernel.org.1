Return-Path: <netdev+bounces-27987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 243C177DD0E
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 11:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1CEE2816E6
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 09:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16701D53E;
	Wed, 16 Aug 2023 09:14:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0FAD539
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 09:14:46 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4FB1BF8
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 02:14:44 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fe5695b180so57229795e9.2
        for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 02:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1692177283; x=1692782083;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gVjWTBs70Hhob2JngnOgWWlZPi+W3BKkqOlo2nsVcvA=;
        b=NXwXxzJFs7UvjLDEj+9sYcQCf/k+Zhf9EMbSGSdgOiS2KRABgbgRlcsTrEvhWZMMrJ
         VZenX3vhPzGTCJkKdQ7uqDC83AJwsOk2+5jK8goITyDGJcO84tmJpLUy3i5Aily8ctvf
         KmYwLKGZTqG9gt/PRvpPNrrXZ8hM/j+dy+LCT3IvnNVLFIdUzeOy99D6k/Y8AlE2jsxd
         JnTkruv8jdcykrQ8TLXPS7oqFdxDLO+SYFbwDhQfhEaj90f83cXaLh7fyYCmzCaPF4x/
         RHs2dZJyN5sdMma3udTV52q1n916CwUImYJGP57f/9Ev+2nAO5tQh5qQ2r6NvDenrwNo
         FyGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692177283; x=1692782083;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gVjWTBs70Hhob2JngnOgWWlZPi+W3BKkqOlo2nsVcvA=;
        b=CBshgylQob+LBI5IhFUnh691klLM1UNWgqT6CrLgm9tUFawyd/1/rYiiIDKnj0rgTv
         Dck1zuyqhY/DdcHy2dciefm+x4p78lzTsimNsw7Ln+Nv5/x/+sWpyqdeFc69bZoDlKL3
         0mE9bJn3BT/muT64N4A0pwJn0CNlrWe12dM0D8QTCxdiffE5gL39zeQuhIRXz0RTBy2I
         K1OhcNmOfUNkgR1pZOHty/TaXr/j82VguSxJpRYoGJDZUATAh7bqj3VAX36zdkw3Hhrh
         1ftNzkUzKCfEqFO3FGyt6m6bwGTO0ZUzVIpe7yOCcDfl/4Qf6qXpL/ia5vfmFgzsFHwI
         S/Lg==
X-Gm-Message-State: AOJu0YxJyrNyAu5vE9y62hjguncEWCrrPUdqPoZXDh6Lh45Mc8GPyNn1
	QLLUHhK4QWRf4rlZibAtNSTqWbc08Vx8wboUALA=
X-Google-Smtp-Source: AGHT+IFm7ZZd+d+khKhc3L+1yJ0Sf6lv2AhGafE4UHL1w+aRKxbU78uBVlljnJrfS8F7sy4AigNjCQ==
X-Received: by 2002:a05:600c:214f:b0:3fe:266f:fe28 with SMTP id v15-20020a05600c214f00b003fe266ffe28mr889662wml.14.1692177282681;
        Wed, 16 Aug 2023 02:14:42 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:8c09:b284:9ea1:cfb8? ([2a02:578:8593:1200:8c09:b284:9ea1:cfb8])
        by smtp.gmail.com with ESMTPSA id y10-20020a1c4b0a000000b003fe2f3a89d4sm20563400wma.7.2023.08.16.02.14.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 02:14:42 -0700 (PDT)
Message-ID: <73bae72c-e706-4cb6-9836-64de560d4525@tessares.net>
Date: Wed, 16 Aug 2023 11:14:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 05/15] inet: move inet->freebind to
 inet->inet_flags
Content-Language: en-GB
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <simon.horman@corigine.com>,
 Soheil Hassas Yeganeh <soheil@google.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, Simon Horman <horms@kernel.org>,
 MPTCP Upstream <mptcp@lists.linux.dev>
References: <20230816081547.1272409-1-edumazet@google.com>
 <20230816081547.1272409-6-edumazet@google.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
In-Reply-To: <20230816081547.1272409-6-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Eric,

(+ Cc MPTCP ML)

On 16/08/2023 10:15, Eric Dumazet wrote:
> IP_FREEBIND socket option can now be set/read
> without locking the socket.

Good idea, thank you for these modifications!

> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
>  include/net/inet_sock.h  |  5 +++--
>  include/net/ipv6.h       |  3 ++-
>  net/ipv4/inet_diag.c     |  2 +-
>  net/ipv4/ip_sockglue.c   | 21 +++++++++------------
>  net/ipv6/ipv6_sockglue.c |  4 ++--

The modifications in MPTCP code...

>  net/mptcp/sockopt.c      |  7 ++++---
... looks good to me!

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

>  net/sctp/protocol.c      |  2 +-
>  7 files changed, 22 insertions(+), 22 deletions(-)

(...)

> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index 21bc46acbe38ee638a2111d717b158caa317d867..ffbe2f5f5b44c3aaf588eb4b8fb3e3594bf2f71c 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -419,7 +419,8 @@ static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
>  			inet_sk(sk)->transparent = inet_sk(ssk)->transparent;
>  			break;
>  		case IPV6_FREEBIND:
> -			inet_sk(sk)->freebind = inet_sk(ssk)->freebind;
> +			inet_assign_bit(FREEBIND, sk,
> +					inet_test_bit(FREEBIND, ssk));
>  			break;
>  		}
>  
> @@ -704,7 +705,7 @@ static int mptcp_setsockopt_sol_ip_set_transparent(struct mptcp_sock *msk, int o
>  
>  	switch (optname) {
>  	case IP_FREEBIND:
> -		issk->freebind = inet_sk(sk)->freebind;
> +		inet_assign_bit(FREEBIND, ssk, inet_test_bit(FREEBIND, sk));
>  		break;
>  	case IP_TRANSPARENT:
>  		issk->transparent = inet_sk(sk)->transparent;

FYI, we are looking at simplifying this not to modify these bits
directly but rather calling tcp_setsockopt() on the different subflows,
e.g.:

https://patchwork.kernel.org/project/mptcp/patch/20230707-mptcp-unify-sockopt-issue-353-v1-5-693e15c06646@tessares.net/

But the series this patch is from is not ready yet.

> @@ -1441,7 +1442,7 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
>  	__tcp_sock_set_nodelay(ssk, !!msk->nodelay);
>  
>  	inet_sk(ssk)->transparent = inet_sk(sk)->transparent;
> -	inet_sk(ssk)->freebind = inet_sk(sk)->freebind;
> +	inet_assign_bit(FREEBIND, ssk, inet_test_bit(FREEBIND, sk));
>  }
>  
>  static void __mptcp_sockopt_sync(struct mptcp_sock *msk, struct sock *ssk)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net

