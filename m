Return-Path: <netdev+bounces-24487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC73E77053F
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 17:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E58931C21910
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 15:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8ED18054;
	Fri,  4 Aug 2023 15:51:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20310BE7B
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 15:51:20 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8454170F
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 08:51:18 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fe2d620d17so104095e9.0
        for <netdev@vger.kernel.org>; Fri, 04 Aug 2023 08:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691164277; x=1691769077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WKI6r/logEv/dW6g10zi6Oac1f5KZSTaa9X0AtvaRYU=;
        b=2Yf9DOFb7PgaLFH78yiFUpMEAkQ6cULIE0l7NiBj4+zRARbcoPNU7AVf9CFqEgOsoL
         DWCy68BGKSMsq8cksWu8wcjT6sEp/mlO8wg1GvsECFbjXC05lPKQ1nmjL6YQGapg4xAI
         ezmIT/ZHUBVDM1G38eAlq5/8OzMRX5FTrVNxQjYQgASk579h6nrfHg7DTPVz7lQE63Ie
         8Y1GHstk6EPW4tRFZ3/0YBRoarOuNOa2zv842xbDQ9Xi/gpZZoPYMA2SbqLBVlDzfx9Y
         OrhtcDgCh8zPZOMsFEnVkWfpO3DfqzgVRL/7L8yCZatOfYB8ReQ0RrwmksQ9YamXV3sP
         VU/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691164277; x=1691769077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WKI6r/logEv/dW6g10zi6Oac1f5KZSTaa9X0AtvaRYU=;
        b=RyMaILTY2qjHAVjadGqfaH3CmuzARi/8tyeTSpn6En7c0yFwoBTBmvqayhnndeiKQe
         YyK1Q0fuwWvnMuq2oSTHKUpxIKbHLNB62zBOoqdz7nipbcbbeZtwhtxX+RQx6mAUz0Fp
         CRNXXO64Wcf1TffB1/NyPs2Og8AntiGNEtR3hSptaQm0S4YrwLhHs1ViCYo8gEJxWCN0
         O1v5FiAsRcbHTYezXqnl9xoGmI76Svg4TYPm3YBvuJ5bwK+xD88nuSuTpVl9oVHJYtp3
         PsMAfo0IaeVjUrMHIua0Xn+E8I4heHE/E6ol8feB5nG6xvem6UxM/XWOyBVoJRc7iGA/
         KNbg==
X-Gm-Message-State: AOJu0Yw4xFjmVxoAx58vl/LIEZV3no/b1VdQpbhUvjrH23r0MCB4Le5t
	nq/lrdya7fXB4fX0OeRRYXWgWTWRpUw8hgPqNuM0CA==
X-Google-Smtp-Source: AGHT+IEV6GH+fIcR7e8IVaM+CaAjVEyILzJJP/uxW02JJzqKlrXosN+HTZh5TA2ipsG5uKc0Kl+RjAUedzNr4r5EVsQ=
X-Received: by 2002:a05:600c:1d1d:b0:3f4:2736:b5eb with SMTP id
 l29-20020a05600c1d1d00b003f42736b5ebmr78938wms.1.1691164277312; Fri, 04 Aug
 2023 08:51:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230804144616.3938718-1-edumazet@google.com> <20230804144616.3938718-5-edumazet@google.com>
In-Reply-To: <20230804144616.3938718-5-edumazet@google.com>
From: Soheil Hassas Yeganeh <soheil@google.com>
Date: Fri, 4 Aug 2023 11:50:40 -0400
Message-ID: <CACSApvY-H8kMn3OXD-kbApGQ11H+pK7X7-gQH4ifGMU-g57rKQ@mail.gmail.com>
Subject: Re: [PATCH net-next 4/6] tcp: set TCP_KEEPCNT locklessly
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 4, 2023 at 10:46=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> tp->keepalive_probes can be set locklessly, readers
> are already taking care of this field being potentially
> set by other threads.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Acked-by: Soheil Hassas Yeganeh <soheil@google.com>

> ---
>  net/ipv4/tcp.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 75d6359ee5750d8a867fb36ec2de960869d8c76a..e74a9593283c91aa23fe23fdd=
125d4ba680a542c 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -3358,10 +3358,8 @@ int tcp_sock_set_keepcnt(struct sock *sk, int val)
>         if (val < 1 || val > MAX_TCP_KEEPCNT)
>                 return -EINVAL;
>
> -       lock_sock(sk);
>         /* Paired with READ_ONCE() in keepalive_probes() */
>         WRITE_ONCE(tcp_sk(sk)->keepalive_probes, val);
> -       release_sock(sk);
>         return 0;
>  }
>  EXPORT_SYMBOL(tcp_sock_set_keepcnt);
> @@ -3471,6 +3469,8 @@ int do_tcp_setsockopt(struct sock *sk, int level, i=
nt optname,
>                 return tcp_sock_set_user_timeout(sk, val);
>         case TCP_KEEPINTVL:
>                 return tcp_sock_set_keepintvl(sk, val);
> +       case TCP_KEEPCNT:
> +               return tcp_sock_set_keepcnt(sk, val);
>         }
>
>         sockopt_lock_sock(sk);
> @@ -3568,12 +3568,6 @@ int do_tcp_setsockopt(struct sock *sk, int level, =
int optname,
>         case TCP_KEEPIDLE:
>                 err =3D tcp_sock_set_keepidle_locked(sk, val);
>                 break;
> -       case TCP_KEEPCNT:
> -               if (val < 1 || val > MAX_TCP_KEEPCNT)
> -                       err =3D -EINVAL;
> -               else
> -                       WRITE_ONCE(tp->keepalive_probes, val);
> -               break;
>         case TCP_SAVE_SYN:
>                 /* 0: disable, 1: enable, 2: start from ether_header */
>                 if (val < 0 || val > 2)
> --
> 2.41.0.640.ga95def55d0-goog
>

