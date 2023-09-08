Return-Path: <netdev+bounces-32679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F045D7991AE
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 23:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 352B71C20CBE
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 21:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85157B643;
	Fri,  8 Sep 2023 21:54:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E2F1C39
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 21:54:17 +0000 (UTC)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B688EE45
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 14:54:15 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-576bf2d50eeso314373a12.1
        for <netdev@vger.kernel.org>; Fri, 08 Sep 2023 14:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694210055; x=1694814855; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+nMK61Y2kvjey6f71VN74OFWl1qo5wICEG7/r110DX0=;
        b=RfRriABVVNW2Gn5Lk7XWsCbP+G/cTwsuv56C31LWcwmakxXWLnR5w1WB6vXvYqKi4p
         6GHvpQEJJ14jgnO9Ywc8vvxU4AtDH4PeRytcnl020Cu2iGFO97uzLJxf5SQHzIjHvSoo
         lsz4u2/NLCDg2kSfpMNjG1fCzCAWN/gWYG4RBQmniBZlL0uoIyGJ74NQwIsbaOYK3OgA
         syGQsdPhcf4FhHf/VDz7in+PnaEXu4lXyl9EbV/uhQYU2tjMNto6Qf21DS1Gtu83rLcX
         A0d4YaUuvsSJHs4+CVL6pDA6BX6qXEFlB8gybCQxABdaSKzt73PNUkfPnoPMToqkCD+j
         i6QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694210055; x=1694814855;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+nMK61Y2kvjey6f71VN74OFWl1qo5wICEG7/r110DX0=;
        b=g5R7xveQKYQCirPidQlUHNvBD1DAuvEdRfJKyx+jMfX5U2VV6f5m3CE7tYsFcQxihY
         yVBzFigdXsukewkw39bL9nahs9gXYnN5OfaKxuwWnURkb0HA7ASrWQwULzxSL1SYfvqf
         TpWxZ1CnyS3RdXv1Tb8WDS6Iu8Qa2R4hGipYYVfQmHQDpDdi6C0PBq1n0NjuLOZnGLPh
         nLiPLv7Fd6rORzQ3SLWzslH8J3vCLFqGqtielxo9yiWVd0m5k/lHWWEJBUOF7BI4C1aL
         S1K8ciK6mEHqpzRnHYhoN4pbJ2l5Wg/bf8vy8cUWJFxXaBc+4qLOwnCcAnugBgGLhJVJ
         zK3g==
X-Gm-Message-State: AOJu0YyeIVqmut0tMa7uVhCF5CQ8D0UVL42z41IbriNoQNRo3F20sqeP
	5Kl7WHGKXHrnxbjPdLeApPsPJ/WTtwyA/A==
X-Google-Smtp-Source: AGHT+IG4efniWE37orrpIJRz9H0X/nL3rlojctaWckfU1aIf834MgIzdiD8wF8g5aNfB/2Y6MV+0gQ==
X-Received: by 2002:a17:90b:1bc8:b0:263:161c:9e9c with SMTP id oa8-20020a17090b1bc800b00263161c9e9cmr8910796pjb.12.1694210055047;
        Fri, 08 Sep 2023 14:54:15 -0700 (PDT)
Received: from google.com ([2620:0:1008:10:c933:772e:ffc:beeb])
        by smtp.gmail.com with ESMTPSA id k4-20020a637b44000000b00563e1ef0491sm1577192pgn.8.2023.09.08.14.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 14:54:14 -0700 (PDT)
Date: Fri, 8 Sep 2023 14:54:12 -0700
From: Andrei Vagin <avagin@gmail.com>
To: Martin KaFai Lau <kafai@fb.com>
Cc: netdev@vger.kernel.org, David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, kernel-team@fb.com,
	Paolo Abeni <pabeni@redhat.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH net-next] net: Fix incorrect address comparison when
 searching for a bind2 bucket
Message-ID: <ZPuYBOFC8zsK6r9T@google.com>
References: <20220927002544.3381205-1-kafai@fb.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927002544.3381205-1-kafai@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 26, 2022 at 05:25:44PM -0700, Martin KaFai Lau wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
> 
> The v6_rcv_saddr and rcv_saddr are inside a union in the
> 'struct inet_bind2_bucket'.  When searching a bucket by following the
> bhash2 hashtable chain, eg. inet_bind2_bucket_match, it is only using
> the sk->sk_family and there is no way to check if the inet_bind2_bucket
> has a v6 or v4 address in the union.  This leads to an uninit-value
> KMSAN report in [0] and also potentially incorrect matches.
> 
> This patch fixes it by adding a family member to the inet_bind2_bucket
> and then tests 'sk->sk_family != tb->family' before matching
> the sk's address to the tb's address.

It seems this patch doesn't handle v4mapped addresses properly. One of
gVisor test started failing with this change:

socket(AF_INET6, SOCK_STREAM, IPPROTO_IP) = 3
bind(3, {sa_family=AF_INET6, sin6_port=htons(0), sin6_flowinfo=htonl(0), inet_pton(AF_INET6, "::ffff:0.0.0.0", &sin6_addr), sin6_scope_id=0}, 28) = 0
getsockname(3, {sa_family=AF_INET6, sin6_port=htons(33789), sin6_flowinfo=htonl(0), inet_pton(AF_INET6, "::ffff:0.0.0.0", &sin6_addr), sin6_scope_id=0}, [28]) = 0
socket(AF_INET6, SOCK_STREAM, IPPROTO_IP) = 4
bind(4, {sa_family=AF_INET6, sin6_port=htons(33789), sin6_flowinfo=htonl(0), inet_pton(AF_INET6, "::1", &sin6_addr), sin6_scope_id=0}, 28) = 0
socket(AF_INET, SOCK_STREAM, IPPROTO_IP) = 5
bind(5, {sa_family=AF_INET, sin_port=htons(33789), sin_addr=inet_addr("127.0.0.1")}, 16) = 0

The test expects that the second bind returns EADDRINUSE.

Thanks,
Andrei

> 
> Cc: Joanne Koong <joannelkoong@gmail.com>
> Cc: Alexander Potapenko <glider@google.com>
> Fixes: 28044fc1d495 ("net: Add a bhash2 table hashed by port and address")
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> ---
>  include/net/inet_hashtables.h |  3 +++
>  net/ipv4/inet_hashtables.c    | 10 ++++++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
> index 9121ccab1fa1..3af1e927247d 100644
> --- a/include/net/inet_hashtables.h
> +++ b/include/net/inet_hashtables.h
> @@ -95,6 +95,9 @@ struct inet_bind2_bucket {
>  	possible_net_t		ib_net;
>  	int			l3mdev;
>  	unsigned short		port;
> +#if IS_ENABLED(CONFIG_IPV6)
> +	unsigned short		family;
> +#endif
>  	union {
>  #if IS_ENABLED(CONFIG_IPV6)
>  		struct in6_addr		v6_rcv_saddr;
> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> index 74e64aad5114..49db8c597eea 100644
> --- a/net/ipv4/inet_hashtables.c
> +++ b/net/ipv4/inet_hashtables.c
> @@ -109,6 +109,7 @@ static void inet_bind2_bucket_init(struct inet_bind2_bucket *tb,
>  	tb->l3mdev    = l3mdev;
>  	tb->port      = port;
>  #if IS_ENABLED(CONFIG_IPV6)
> +	tb->family    = sk->sk_family;
>  	if (sk->sk_family == AF_INET6)
>  		tb->v6_rcv_saddr = sk->sk_v6_rcv_saddr;
>  	else
> @@ -146,6 +147,9 @@ static bool inet_bind2_bucket_addr_match(const struct inet_bind2_bucket *tb2,
>  					 const struct sock *sk)
>  {
>  #if IS_ENABLED(CONFIG_IPV6)
> +	if (sk->sk_family != tb2->family)
> +		return false;
> +
>  	if (sk->sk_family == AF_INET6)
>  		return ipv6_addr_equal(&tb2->v6_rcv_saddr,
>  				       &sk->sk_v6_rcv_saddr);
> @@ -791,6 +795,9 @@ static bool inet_bind2_bucket_match(const struct inet_bind2_bucket *tb,
>  				    int l3mdev, const struct sock *sk)
>  {
>  #if IS_ENABLED(CONFIG_IPV6)
> +	if (sk->sk_family != tb->family)
> +		return false;
> +
>  	if (sk->sk_family == AF_INET6)
>  		return net_eq(ib2_net(tb), net) && tb->port == port &&
>  			tb->l3mdev == l3mdev &&
> @@ -807,6 +814,9 @@ bool inet_bind2_bucket_match_addr_any(const struct inet_bind2_bucket *tb, const
>  #if IS_ENABLED(CONFIG_IPV6)
>  	struct in6_addr addr_any = {};
>  
> +	if (sk->sk_family != tb->family)
> +		return false;
> +
>  	if (sk->sk_family == AF_INET6)
>  		return net_eq(ib2_net(tb), net) && tb->port == port &&
>  			tb->l3mdev == l3mdev &&
> -- 
> 2.30.2
> 

