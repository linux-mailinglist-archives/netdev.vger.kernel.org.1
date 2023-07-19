Return-Path: <netdev+bounces-19258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE74575A09F
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 23:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 213562819B7
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 21:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F0B22F0D;
	Wed, 19 Jul 2023 21:34:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8601BB23
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 21:34:16 +0000 (UTC)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063C91FCD
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 14:34:15 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-7654e1d83e8so13977285a.1
        for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 14:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689802454; x=1690407254;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UhjZnja+3pEm/KPmfQYh13vk1P0h050QhwiajcOhgHY=;
        b=G7YiA8V0ZyH0L64cCODJduJ7zkCzwUdPi9DoaE1IjZFEnC+hGYU4PmxeOgn2YdevL2
         Z4RvmX2snyR8xo5Wt2M73uolWXnAzUWXwdI5VCiOACWLElrb3QNN6ZkypdIrFW42lnma
         DcEq6XWrGiiCOno3W9ry32kkYE06e+I55cBPFzWefuKCRMfTClUQ9TIiS8CQxEHcBsPk
         8AmCXS62MHgKp3O5Bqt2DcL2as2+46Zx/Qp8ebFN27BifU0nSuxHbwRh8kIrFJ//6wB1
         dkuy6ivxDn1aTq6Wv8gUTmcMWMZxyetKXr3UTFgl0W1sB4+05OCjeF6gut+MvqVXWpAx
         BZcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689802454; x=1690407254;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UhjZnja+3pEm/KPmfQYh13vk1P0h050QhwiajcOhgHY=;
        b=Ukx4Wf74oyZ/pJoM3BN+mEGrcKkkocnXayQRidYnkWEpx3KuOyUdTu8D5Mx4jl5KWd
         YWSlFN3vwX9stv476IngBUQvw9YWeXzlgusCqbagHVkxvWmwrQXZ0tUjdzBfz3FytxUI
         nQDfclfNSq8YH9/eGvYs4osCSXjVQty1Pl2ChAg99KTZQz2TMO2vAwnE4TCzUGDsJyS1
         PD9tLXOwT++By1rp3S4hZBdsZ4OE9gk4+kC398Q2FnvvLjATwcoQceXHEgqPo2zRoWoa
         HexPWurbNEbomEtE45RTg29Fs0A9XJJwojjEj7f6KKzInivsNdDbJYyod2Y3/TN21c7C
         yWrg==
X-Gm-Message-State: ABy/qLYAcl3Ih3G1SNUCNrNQ+QZdXQDIvMeL9mBw11Tjppxqgvmx1hPB
	K61GltFkCncxyh8CBGKRYUg=
X-Google-Smtp-Source: APBJJlFG0/vpxUv/LvNSTk+ocOPsL+of59D8WPzSLJJAp52m2sdikuHfDRygL22Viu99guNwGL5yZw==
X-Received: by 2002:a05:620a:450c:b0:767:f1de:293c with SMTP id t12-20020a05620a450c00b00767f1de293cmr934682qkp.59.1689802454083;
        Wed, 19 Jul 2023 14:34:14 -0700 (PDT)
Received: from localhost (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id pa39-20020a05620a832700b007675c4b530fsm553017qkn.28.2023.07.19.14.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 14:34:13 -0700 (PDT)
Date: Wed, 19 Jul 2023 17:34:13 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, 
 willemdebruijn.kernel@gmail.com
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 gustavoars@kernel.org, 
 keescook@chromium.org, 
 kuba@kernel.org, 
 kuni1840@gmail.com, 
 kuniyu@amazon.com, 
 leitao@debian.org, 
 netdev@vger.kernel.org, 
 pabeni@redhat.com, 
 syzkaller@googlegroups.com
Message-ID: <64b856d553b5b_2842f2294f0@willemb.c.googlers.com.notmuch>
In-Reply-To: <20230719212709.63492-1-kuniyu@amazon.com>
References: <64b8525db522_2831cb294d@willemb.c.googlers.com.notmuch>
 <20230719212709.63492-1-kuniyu@amazon.com>
Subject: RE: [PATCH v1 net 2/2] af_packet: Fix warning of fortified memcpy()
 in packet_getname().
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> >  
> > > The write seems to overflow, but actually not since we use struct
> > > sockaddr_storage defined in __sys_getsockname().
> > 
> > Which gives _K_SS_MAXSIZE == 128, minus offsetof(struct sockaddr_ll, sll_addr).
> > 
> > For fun, there is another caller. getsockopt SO_PEERNAME also calls
> > sock->ops->getname, with a buffer hardcoded to 128. Should probably
> > use sizeof(sockaddr_storage) for documentation, at least.
> > 
> > .. and I just noticed that that was attempted, but not completed
> > https://lore.kernel.org/lkml/20140928135545.GA23220@type.youpi.perso.aquilenet.fr/
> 
> Yes, acutally my first draft had the diff below, but I dropped it
> because packet_getname() does not call memcpy() for SO_PEERNAME at
> least, and same for getpeername().
> 
> And interestingly there was a revival thread.
> https://lore.kernel.org/netdev/20230719084415.1378696-1-leitao@debian.org/

Ah interesting :) Topical.

> I can include this in v2 if needed.
> What do you think ?
> 
> ---8<---
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 9370fd50aa2c..f1e887c3115f 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -1815,14 +1815,14 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
>  
>  	case SO_PEERNAME:
>  	{
> -		char address[128];
> +		struct sockaddr_storage address;
>  
> -		lv = sock->ops->getname(sock, (struct sockaddr *)address, 2);
> +		lv = sock->ops->getname(sock, (struct sockaddr *)&address, 2);
>  		if (lv < 0)
>  			return -ENOTCONN;
>  		if (lv < len)
>  			return -EINVAL;
> -		if (copy_to_sockptr(optval, address, len))
> +		if (copy_to_sockptr(optval, &address, len))
>  			return -EFAULT;
>  		goto lenout;
>  	}
> ---8<---

I agree that it's a worthwhile change. I think it should be an
independent commit. And since it does not fix a bug, target net-next.

