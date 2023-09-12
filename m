Return-Path: <netdev+bounces-33043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CF579C823
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 09:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 509312818F2
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 07:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D12417723;
	Tue, 12 Sep 2023 07:26:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23204171DA
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 07:26:01 +0000 (UTC)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BCEAA
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 00:26:01 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c39bc0439bso17953955ad.0
        for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 00:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694503561; x=1695108361; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XllLpl9l0EXssd5MPJ9auelWEtc2VmBGvbTeEvViLpE=;
        b=eA0gexSkcQ9DTcJCOoeEb6Tydifn30wnludRWWditec56IeYdv1HygY41vuwTPOfkQ
         /wkmDPL7yy863B4zrocjjpnntikIWdLpSRWwpdqhUVLsGokghHMZmXlDebhE4sTUjX5H
         gpqV3Gz7Gpm6h5KP1xNZG5Lx2MwvEN1m2um2K0vrmG9nHGOGM+8TSZDAGYpZz/AfvWs3
         buM0kzPjLCxv4IM5Q2gOLpi2NOuCNmTyZv+M3KLn96OAXRSKDEVbgdUFxT3ku1C2+/Ha
         Zxxj7pJAbVwCTeeHHz9RFDKQ79TzCcP2sFiwtSsTBa6eTbk+AXSl5K7TaxCz9JIjALy7
         BBmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694503561; x=1695108361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XllLpl9l0EXssd5MPJ9auelWEtc2VmBGvbTeEvViLpE=;
        b=si8etmpdDeQN9KHPmrWbMg2fNYkEzfZQEDjc1y7f3nI0Y0NetJaX8W5woZQD8nzZcr
         7M+MoadJ+fGy3Og9UM+wWMsvTNiaVXZYb5nUSwtkadU3C0BSFQIKnInTZuH7zUehGhAd
         KlEewcblf+waIqZvv3hkLPIdgaWAis0RhsKWmZFCIM/ZZFWkENG15f4ZbbxXalKEb18v
         NhVtwLgLwxr83CF54BvRrx6PsDRTcb56oEUrd9/+YxUbmA4utcxh1P90rZNijUelH0fc
         nNo/lBDjSKDmtFQqcFLmpDggNHashroOsv1uf6suctuJKb+WGgjK5xUGyuTB+wd/Ppci
         QX4A==
X-Gm-Message-State: AOJu0Yz//biq6Mp6/ltxJIFzCE7TLPIlNHHWEzDykjLqmUojCzLW5Pdr
	uP0Bm+suEnSckU74qVrick4=
X-Google-Smtp-Source: AGHT+IEi1x5PHrv6acRFXLTh6ucuXZpLb3YkheLWXMetd0XiWSnJXmFQ6hEsHHb+UdOuML3HisOcsA==
X-Received: by 2002:a17:902:f691:b0:1c1:fc5c:b31b with SMTP id l17-20020a170902f69100b001c1fc5cb31bmr2095164plg.9.1694503560679;
        Tue, 12 Sep 2023 00:26:00 -0700 (PDT)
Received: from google.com ([2620:0:1008:10:5b6e:44b:2440:c142])
        by smtp.gmail.com with ESMTPSA id ay6-20020a1709028b8600b001b896d0eb3dsm7679708plb.8.2023.09.12.00.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 00:26:00 -0700 (PDT)
Date: Tue, 12 Sep 2023 00:25:58 -0700
From: Andrei Vagin <avagin@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net 3/6] tcp: Fix bind() regression for v4-mapped-v6
 non-wildcard address.
Message-ID: <ZQAShrVUokZR/WGs@google.com>
References: <20230911183700.60878-1-kuniyu@amazon.com>
 <20230911183700.60878-4-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911183700.60878-4-kuniyu@amazon.com>

On Mon, Sep 11, 2023 at 11:36:57AM -0700, Kuniyuki Iwashima wrote:
> Since bhash2 was introduced, the example below does not work as expected.
> These two bind() should conflict, but the 2nd bind() now succeeds.
> 
>   from socket import *
> 
>   s1 = socket(AF_INET6, SOCK_STREAM)
>   s1.bind(('::ffff:127.0.0.1', 0))
> 
>   s2 = socket(AF_INET, SOCK_STREAM)
>   s2.bind(('127.0.0.1', s1.getsockname()[1]))
> 
> During the 2nd bind() in inet_csk_get_port(), inet_bind2_bucket_find()
> fails to find the 1st socket's tb2, so inet_bind2_bucket_create() allocates
> a new tb2 for the 2nd socket.  Then, we call inet_csk_bind_conflict() that
> checks conflicts in the new tb2 by inet_bhash2_conflict().  However, the
> new tb2 does not include the 1st socket, thus the bind() finally succeeds.
> 
> In this case, inet_bind2_bucket_match() must check if AF_INET6 tb2 has
> the conflicting v4-mapped-v6 address so that inet_bind2_bucket_find()
> returns the 1st socket's tb2.
> 
> Note that if we bind two sockets to 127.0.0.1 and then ::FFFF:127.0.0.1,
> the 2nd bind() fails properly for the same reason mentinoed in the previous
> commit.
> 
> Fixes: 28044fc1d495 ("net: Add a bhash2 table hashed by port and address")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  net/ipv4/inet_hashtables.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> index a58b04052ca6..c32f5e28758b 100644
> --- a/net/ipv4/inet_hashtables.c
> +++ b/net/ipv4/inet_hashtables.c
> @@ -820,8 +820,13 @@ static bool inet_bind2_bucket_match(const struct inet_bind2_bucket *tb,

Should we fix inet_bind2_bucket_addr_match too?

>  		return false;
>  
>  #if IS_ENABLED(CONFIG_IPV6)
> -	if (sk->sk_family != tb->family)
> +	if (sk->sk_family != tb->family) {
> +		if (sk->sk_family == AF_INET)
> +			return ipv6_addr_v4mapped(&tb->v6_rcv_saddr) &&
> +				tb->v6_rcv_saddr.s6_addr32[3] == sk->sk_rcv_saddr;

I was wondering why we don't check a case when sk is AF_INET6 and tb is
AF_INET. I tried to run the next test:

import socket
sk4 = socket.socket(socket.AF_INET, socket.SOCK_STREAM, 0)
sk6 = socket.socket(socket.AF_INET6, socket.SOCK_STREAM, 0)
sk4.bind(("127.0.0.1", 32773))
sk6.bind(("::ffff:127.0.0.1", 32773))

The second bind returned EADDRINUSE. It works as expected only because
inet_use_bhash2_on_bind returns false for all v4mapped addresses. This
doesn't look right, and I am not sure it was intentional. I think it can
to be changed this way:

@@ -158,7 +158,7 @@ static bool inet_use_bhash2_on_bind(const struct sock *sk)
                int addr_type = ipv6_addr_type(&sk->sk_v6_rcv_saddr);

                return addr_type != IPV6_ADDR_ANY &&
-                       addr_type != IPV6_ADDR_MAPPED;
+                       !ipv6_addr_v4mapped_any(&sk->sk_v6_rcv_saddr);
        }
 #endif
        return sk->sk_rcv_saddr != htonl(INADDR_ANY);

As for this patch, I think it may be a good idea if bind2 buckets for
v4-mapped addresses are created with the AF_INET family and matching
ipv4 addresses.

> +
>  		return false;
> +	}
>  
>  	if (sk->sk_family == AF_INET6)
>  		return ipv6_addr_equal(&tb->v6_rcv_saddr, &sk->sk_v6_rcv_saddr);

