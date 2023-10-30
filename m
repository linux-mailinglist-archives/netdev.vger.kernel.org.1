Return-Path: <netdev+bounces-45186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0B87DB4F6
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 09:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 156D9281081
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 08:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28948CA7E;
	Mon, 30 Oct 2023 08:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="flF6YDsm"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812DC7ED
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 08:16:24 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BE591
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 01:16:22 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-53f647c84d4so11668a12.0
        for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 01:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698653781; x=1699258581; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g89XSggoLUaEMPo+RRID+6tdEeDrel7KLo6Qj6UN4p0=;
        b=flF6YDsmduK+vpK/QFn2fm/1huYgaWSiO5ovHa+eRvhMPklkFHS5KUGCS+GTZ2kOK3
         MfZ37MHtjAD1+/9mIIiuimXGg1g3xmyktcjMHJBpl6Bxk3qDib86kfg5DVpCLYwRyVqK
         TxAU29B3eQYAvgP5uqFYs+WeOqeVsV8KbI+EKy+gKrtv0SFLibVASx7XyeIamOC+BIQl
         cS/43hoPsO1PsyMeW+1Rf0vh6HPpvurlukuIACqWncBtz47Lu/kTk/+C6oNk5dvKeamr
         qK01DjIR5OhebNW8xb1OaIJCQ28dHwuVCEvuklbHvEajSX9UHYVrdZLViwxedk+2lBoN
         ca3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698653781; x=1699258581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g89XSggoLUaEMPo+RRID+6tdEeDrel7KLo6Qj6UN4p0=;
        b=YzKO8NfhDUOfLtz0xHIa0iVSavp9+wzZjnj9pf7w9Bw59pL3emRxqEMkcsbtv+Q1Er
         /W9E/RVCAsMgFoe1B8Av0mcLxRO/9j7kz8fn7uw+cEHnKLd6N+TXJILWMxWlikBsJIWJ
         9In1EqFaeRatcMQ0Pvs48gMHxqmMvmQpTlmbrql+S9DqrRQKFM793HUtG0K6xTXwr+EM
         utJRt4n9SsauRFiDvD3Jr4KGw2YfAk1ZixEFrznkrqZohz+HKcBXpj9ygc2Sd9QhTFK2
         8c5QXpL+lvP48PGP7JDW9fYbpqEbYv5HNn+e8ZGLCOeQ5S3W4YUZuIJfAx6EjxiSYz6Z
         uxmA==
X-Gm-Message-State: AOJu0YzPxOg0U/eDH9v2Sd5vWwMiXtjVYDqRpuezz6GICUg2ZySTD27h
	HNV9pvw2gb8NsVvmDUQIbyaK0ZPBVual/AfqAZhQLQ==
X-Google-Smtp-Source: AGHT+IG4I7Rtp4zpBaUCuU660uqL5hMSv74JlubURsiyygvmUDA4z2m2beZ18vlmuO0Yv/s3YCT8ZDuLK12Wrfjhwqg=
X-Received: by 2002:a50:baee:0:b0:540:e63d:3cfb with SMTP id
 x101-20020a50baee000000b00540e63d3cfbmr93917ede.3.1698653780877; Mon, 30 Oct
 2023 01:16:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231023192217.426455-1-dima@arista.com> <20231023192217.426455-16-dima@arista.com>
In-Reply-To: <20231023192217.426455-16-dima@arista.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 30 Oct 2023 09:16:08 +0100
Message-ID: <CANn89iJQvO11pRqrsHpB5Y3NuurX1UcEFu_SYq7kxJsvW7y7BQ@mail.gmail.com>
Subject: Re: [PATCH v16 net-next 15/23] net/tcp: Add tcp_hash_fail()
 ratelimited logs
To: Dmitry Safonov <dima@arista.com>
Cc: David Ahern <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, 
	Andy Lutomirski <luto@amacapital.net>, Ard Biesheuvel <ardb@kernel.org>, 
	Bob Gilligan <gilligan@arista.com>, Dan Carpenter <error27@gmail.com>, 
	David Laight <David.Laight@aculab.com>, Dmitry Safonov <0x7f454c46@gmail.com>, 
	Donald Cassidy <dcassidy@redhat.com>, Eric Biggers <ebiggers@kernel.org>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, Francesco Ruggeri <fruggeri05@gmail.com>, 
	"Gaillardetz, Dominik" <dgaillar@ciena.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Ivan Delalande <colona@arista.com>, 
	Leonard Crestez <cdleonard@gmail.com>, "Nassiri, Mohammad" <mnassiri@ciena.com>, 
	Salam Noureddine <noureddine@arista.com>, Simon Horman <horms@kernel.org>, 
	"Tetreault, Francois" <ftetreau@ciena.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 9:22=E2=80=AFPM Dmitry Safonov <dima@arista.com> wr=
ote:
>
> Add a helper for logging connection-detailed messages for failed TCP
> hash verification (both MD5 and AO).
>
> Co-developed-by: Francesco Ruggeri <fruggeri@arista.com>
> Signed-off-by: Francesco Ruggeri <fruggeri@arista.com>
> Co-developed-by: Salam Noureddine <noureddine@arista.com>
> Signed-off-by: Salam Noureddine <noureddine@arista.com>
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> Acked-by: David Ahern <dsahern@kernel.org>
> ---
>  include/net/tcp.h    | 14 ++++++++++++--
>  include/net/tcp_ao.h | 29 +++++++++++++++++++++++++++++
>  net/ipv4/tcp.c       | 23 +++++++++++++----------
>  net/ipv4/tcp_ao.c    |  7 +++++++
>  4 files changed, 61 insertions(+), 12 deletions(-)
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index d29c8a867f0e..c93ac6cc12c4 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -2746,12 +2746,18 @@ tcp_inbound_hash(struct sock *sk, const struct re=
quest_sock *req,
>         int l3index;
>
>         /* Invalid option or two times meet any of auth options */
> -       if (tcp_parse_auth_options(th, &md5_location, &aoh))
> +       if (tcp_parse_auth_options(th, &md5_location, &aoh)) {
> +               tcp_hash_fail("TCP segment has incorrect auth options set=
",
> +                             family, skb, "");
>                 return SKB_DROP_REASON_TCP_AUTH_HDR;
> +       }
>
>         if (req) {
>                 if (tcp_rsk_used_ao(req) !=3D !!aoh) {
>                         NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPAOBAD);
> +                       tcp_hash_fail("TCP connection can't start/end usi=
ng TCP-AO",
> +                                     family, skb, "%s",
> +                                     !aoh ? "missing AO" : "AO signed");
>                         return SKB_DROP_REASON_TCP_AOFAILURE;
>                 }
>         }
> @@ -2768,10 +2774,14 @@ tcp_inbound_hash(struct sock *sk, const struct re=
quest_sock *req,
>                  * the last key is impossible to remove, so there's
>                  * always at least one current_key.
>                  */
> -               if (tcp_ao_required(sk, saddr, family, true))
> +               if (tcp_ao_required(sk, saddr, family, true)) {
> +                       tcp_hash_fail("AO hash is required, but not found=
",
> +                                       family, skb, "L3 index %d", l3ind=
ex);
>                         return SKB_DROP_REASON_TCP_AONOTFOUND;
> +               }
>                 if (unlikely(tcp_md5_do_lookup(sk, l3index, saddr, family=
))) {
>                         NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5NOTFO=
UND);
> +                       tcp_hash_fail("MD5 Hash not found", family, skb, =
"");
>                         return SKB_DROP_REASON_TCP_MD5NOTFOUND;
>                 }
>                 return SKB_NOT_DROPPED_YET;
> diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
> index 0c3516d1b968..4da6e3657913 100644
> --- a/include/net/tcp_ao.h
> +++ b/include/net/tcp_ao.h
> @@ -118,6 +118,35 @@ struct tcp_ao_info {
>         struct rcu_head         rcu;
>  };
>
> +#define tcp_hash_fail(msg, family, skb, fmt, ...)                      \
> +do {                                                                   \
> +       const struct tcphdr *th =3D tcp_hdr(skb);                        =
 \
> +       char hdr_flags[5] =3D {};                                        =
 \
> +       char *f =3D hdr_flags;                                           =
 \
> +                                                                       \
> +       if (th->fin)                                                    \
> +               *f++ =3D 'F';                                            =
 \
> +       if (th->syn)                                                    \
> +               *f++ =3D 'S';                                            =
 \
> +       if (th->rst)                                                    \
> +               *f++ =3D 'R';                                            =
 \
> +       if (th->ack)                                                    \
> +               *f++ =3D 'A';                                            =
 \
> +       if (f !=3D hdr_flags)                                            =
 \
> +               *f =3D ' ';                                              =
 \

I see no null termination of  hdr_flags[] if FIN+SYN+ACK+RST are all set.

I will send something like:

diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
index a375a171ef3cb37ab1d8246c72c6a3e83f5c9184..5daf96a3dbee14bd3786e19ea49=
72e351058e6e7
100644
--- a/include/net/tcp_ao.h
+++ b/include/net/tcp_ao.h
@@ -124,7 +124,7 @@ struct tcp_ao_info {
 #define tcp_hash_fail(msg, family, skb, fmt, ...)                      \
 do {                                                                   \
        const struct tcphdr *th =3D tcp_hdr(skb);                         \
-       char hdr_flags[5] =3D {};                                         \
+       char hdr_flags[5];                                              \
        char *f =3D hdr_flags;                                            \
                                                                        \
        if (th->fin)                                                    \
@@ -135,8 +135,7 @@ do {
                         \
                *f++ =3D 'R';                                             \
        if (th->ack)                                                    \
                *f++ =3D 'A';                                             \
-       if (f !=3D hdr_flags)                                             \
-               *f =3D ' ';                                               \
+       *f =3D 0;                                                         \
        if ((family) =3D=3D AF_INET) {                                     =
 \
                net_info_ratelimited("%s for (%pI4, %d)->(%pI4, %d)
%s" fmt "\n", \
                                msg, &ip_hdr(skb)->saddr, ntohs(th->source)=
, \

