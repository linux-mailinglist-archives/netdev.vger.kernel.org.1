Return-Path: <netdev+bounces-21420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 902BC763901
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 16:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C19FB1C21214
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 14:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4E8253AF;
	Wed, 26 Jul 2023 14:25:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F00DCA51
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 14:25:48 +0000 (UTC)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE4E196
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 07:25:47 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-40631c5b9e9so298441cf.1
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 07:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690381546; x=1690986346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Js5vSAWaFZ4VidzN0BY/hvjERu9+lVPgqYjIT57+gZ0=;
        b=TLQ43fRW9WLhXdLiCoIYtwVp54lOb+4b7qPtfABK6e6g+GoddpVgz1RwtFZL3+G/K6
         q9n1UxelFBPzVC80L/Y5aKNSli59euzei+hSUseguK2sxs6Ms0n09+KB6ybob78mfF3f
         7vTRHz0wOGq1zkNTsYpDwAvIgBQBm3ZXcNAYJFhRT0xnslX62gebDlqJ+4aVrcigLojp
         6UL+OtGPEuSmytj/UO9muN2SVyRHrKU9a6vpBOPVw4SlbnMRsG9Z9LDzPgNjxGFkzfK+
         47plBrI2mfkpBTNphFH3eR43gd3HGR/kgqXQNGZ8iSyttLGwZI3sfnTpYoRZSkZrmT2N
         Xkeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690381546; x=1690986346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Js5vSAWaFZ4VidzN0BY/hvjERu9+lVPgqYjIT57+gZ0=;
        b=XKKWnrstocYpfe0ekn1KERYS2dEf7GzQPi4AjUlAsUH9Y5+s8eJO2sbz2VXRNxmUHc
         hh9nmOazmzUsMyAQGd4U/Y+6v+ebh6lVKhm6DIetyv/9T+VoK+CNwRq02JU0f2f8vqE8
         xGrHg9xVFkzLBnHjEBt4HjBvFBC8FClCNKYmukmgLZpChRTRY6rxZxdZt5RxVzrkSDLc
         s5d0NEKzU7HN0hzmLzdkpMEcIQmyegALRjxeFDiT17F/Pcs51xb9M6yifd4RSqOypDL0
         z8rzmHtrMWEhTmxw43G5SXp6rkpp2iY4r2/bDY51/dB4wFyLQEKrMszhLCOa0gUIJgBo
         DYmw==
X-Gm-Message-State: ABy/qLYFuAN5475NzyOWTozWyegGwEPB5dKEro2StjyLwYja/aATfl83
	U/bZGuqgCyiXrVGrShi3IMzDjLrWUOVELgfFJALdkg==
X-Google-Smtp-Source: APBJJlEDQ/+u7UDGiiJ2B4FzwviPxrtW7qeOOAOcwGlijvwfDiSir62tMQrMC+sDr90j/5YHDH32t3M77dRi4zC2dnE=
X-Received: by 2002:ac8:7d90:0:b0:403:ac9c:ac2f with SMTP id
 c16-20020ac87d90000000b00403ac9cac2fmr437111qtd.17.1690381546062; Wed, 26 Jul
 2023 07:25:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230726142029.2867663-1-liujian56@huawei.com> <20230726142029.2867663-2-liujian56@huawei.com>
In-Reply-To: <20230726142029.2867663-2-liujian56@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 26 Jul 2023 16:25:34 +0200
Message-ID: <CANn89i+DuhGRXj9U-iXcEA__j6jvV5FC+tLNkGBCSqMCPpuFaA@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] net: introduce __sk_rmem_schedule() helper
To: Liu Jian <liujian56@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	john.fastabend@gmail.com, jakub@cloudflare.com, dsahern@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 26, 2023 at 4:15=E2=80=AFPM Liu Jian <liujian56@huawei.com> wro=
te:
>
> Compared with sk_wmem_schedule(), sk_rmem_schedule() not only performs
> rmem accounting, but also checks skb_pfmemalloc. The __sk_rmem_schedule()
> helper function is introduced here to perform only rmem accounting relate=
d
> activities.
>

Why not care about pfmemalloc ? Why is it safe ?

You need to give more details, or simply reuse the existing helper.

> Signed-off-by: Liu Jian <liujian56@huawei.com>
> ---
>  include/net/sock.h | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 2eb916d1ff64..58bf26c5c041 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -1617,16 +1617,20 @@ static inline bool sk_wmem_schedule(struct sock *=
sk, int size)
>         return delta <=3D 0 || __sk_mem_schedule(sk, delta, SK_MEM_SEND);
>  }
>
> -static inline bool
> -sk_rmem_schedule(struct sock *sk, struct sk_buff *skb, int size)
> +static inline bool __sk_rmem_schedule(struct sock *sk, int size)
>  {
>         int delta;
>
>         if (!sk_has_account(sk))
>                 return true;
>         delta =3D size - sk->sk_forward_alloc;
> -       return delta <=3D 0 || __sk_mem_schedule(sk, delta, SK_MEM_RECV) =
||
> -               skb_pfmemalloc(skb);
> +       return delta <=3D 0 || __sk_mem_schedule(sk, delta, SK_MEM_RECV);
> +}
> +
> +static inline bool
> +sk_rmem_schedule(struct sock *sk, struct sk_buff *skb, int size)
> +{
> +       return __sk_rmem_schedule(sk, size) || skb_pfmemalloc(skb);
>  }
>
>  static inline int sk_unused_reserved_mem(const struct sock *sk)
> --
> 2.34.1
>

