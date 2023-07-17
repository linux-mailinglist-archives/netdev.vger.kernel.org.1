Return-Path: <netdev+bounces-18297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3A8756555
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 15:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6083C2812C3
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 13:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41882BA34;
	Mon, 17 Jul 2023 13:44:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366048F7D
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 13:44:36 +0000 (UTC)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C723B8F
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 06:44:34 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-40353537485so27919281cf.1
        for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 06:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689601474; x=1692193474;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=noR/YaeMVHa+Icn0/Rrg6+OuamiEIxVCyoNZ2OUKEBQ=;
        b=f+3CFTzfXgbkVLnmaSSGbuk8yPRmqjc71Itx/UmfO2o2ah2TO5jNODxLgVFfBGGQe7
         LXZ7KPpQqEEyV1Y/8r8kiEGj1Bf9GeZ0hyL82V9k20GtpIp6x6soEsfxwE7Pg0gbuNVX
         IsjzLe7Kv3qH0akHIUGUFltWKAwjyeWBrNM4pE2gZsTnkYvYV/Uk6oAWzmMv8iNHPX6M
         n1KacbZQbmN7TDEC+Xc0ia+1D2adMkzp8E8qTtndXbcoqeTyzMvVB6zaZOakEAguVIsu
         Sjt5Gi4C2MrzD+B0lU+jfOw7R2SWpfpY3LC0mponDGwhfY3mjgv0GkUL6kQa3o0EDxDK
         Y9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689601474; x=1692193474;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=noR/YaeMVHa+Icn0/Rrg6+OuamiEIxVCyoNZ2OUKEBQ=;
        b=aqoJ4JLJS7JCPSL0gIhn+0mEYYCq1HHJRxCpMOitH72Pjg/uFljs5NPSFEylTpRysK
         OLw5S44eU0TbFsZjA5RSTR2b4c3C56Pz7EpihDI0PgSbnoqGnxuXMMQzLhPRBjNg1wMC
         8wRPhfS0VZ9loOioGup7SaQk6WHG9selhX1WWMrMqkMmi9ywWAD+EAxh7MHWeMqoz3yr
         zOXWIUjllU2+bI8cMV/00Rhv00YjoTzRjmdhpTwEKkEEtJ42A0K5hb2X0oUKDb54ZYR3
         cSkcyVJk+4/Os0BwTu+lxbPgLILrUqFyJI6CkB1MWYOxy9GyLX9ETOetY5iAlHesRTts
         6A7w==
X-Gm-Message-State: ABy/qLZKEV/HmM/zBJUp5YFsrGe9zme6ter4uk928QwI8L2Xdey4UV3s
	H09p2BLttvpHtfmi9iFfZBo=
X-Google-Smtp-Source: APBJJlHn1lBeScSI+fDnuaGF+EjUqaVV59RkjhHQGv6tYQ9WfUIKTXdmjG5HU4sHsiJylDPC8Rl3ig==
X-Received: by 2002:ac8:4e8e:0:b0:400:915d:a17e with SMTP id 14-20020ac84e8e000000b00400915da17emr14856356qtp.65.1689601473851;
        Mon, 17 Jul 2023 06:44:33 -0700 (PDT)
Received: from localhost (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id w16-20020a05622a135000b00403a06202c2sm2852971qtk.49.2023.07.17.06.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 06:44:33 -0700 (PDT)
Date: Mon, 17 Jul 2023 09:44:33 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 David Ahern <dsahern@kernel.org>
Message-ID: <64b545c1316d2_1e11c1294e3@willemb.c.googlers.com.notmuch>
In-Reply-To: <8834aadd89c1ebcbad32f591ea4d29c9f2684497.1689587539.git.pabeni@redhat.com>
References: <8834aadd89c1ebcbad32f591ea4d29c9f2684497.1689587539.git.pabeni@redhat.com>
Subject: RE: [PATCH net-next] udp: introduce and use indirect call wrapper for
 data ready()
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

Paolo Abeni wrote:
> In most cases UDP sockets use the default data ready callback.
> This patch Introduces and uses a specific indirect call wrapper for
> such callback to avoid an indirect call in fastpath.
> 
> The above gives small but measurable performance gain under UDP flood.

Interesting. I recently wrote a patch to add indirect call wrappers
around getfrag (ip_generic_getfrag), expecting that to improve  UDP
senders. Since it's an indirect call on each send call. Not sent,
because I did not see measurable gains, at least with a udp_rr bench.

> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> Note that this helper could be used for TCP, too. I did not send such
> patch right away because in my tests the perf delta there is below the
> noise level even in RR scenarios and the patch would be a little more
> invasive - there are more sk_data_ready() invocation places.
> ---
>  include/net/sock.h | 4 ++++
>  net/ipv4/udp.c     | 2 +-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 2eb916d1ff64..1b26dbecdcca 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -2947,6 +2947,10 @@ static inline bool sk_dev_equal_l3scope(struct sock *sk, int dif)
>  }
>  
>  void sock_def_readable(struct sock *sk);
> +static inline void sk_data_ready(struct sock *sk)
> +{
> +	INDIRECT_CALL_1(sk->sk_data_ready, sock_def_readable, sk);
> +}
>

Why introduce a static inline in the header for this?

To reuse it in other protocols later?

>  int sock_bindtoindex(struct sock *sk, int ifindex, bool lock_sk);
>  void sock_set_timestamp(struct sock *sk, int optname, bool valbool);
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 42a96b3547c9..5aec1854b711 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -1553,7 +1553,7 @@ int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
>  	spin_unlock(&list->lock);
>  
>  	if (!sock_flag(sk, SOCK_DEAD))
> -		sk->sk_data_ready(sk);
> +		sk_data_ready(sk);
>  
>  	busylock_release(busy);
>  	return 0;
> -- 
> 2.41.0
> 



