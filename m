Return-Path: <netdev+bounces-24486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 528AF77053E
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 17:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C2CC28276C
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 15:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E62318053;
	Fri,  4 Aug 2023 15:51:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3888C14A
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 15:51:01 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EC549D6
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 08:51:00 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so13963a12.0
        for <netdev@vger.kernel.org>; Fri, 04 Aug 2023 08:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691164259; x=1691769059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8KmqRM2LFxv0G8/Jyu+UzaXBM9Ly10dAMezjkMZvY3g=;
        b=OnE6yIxb07Fjv7YMvNk7W0w8y/5629ckztf7bkk9BO/DhEUDBPEihtfK2WiwWiPSAY
         QytkaTHbG0eG/YehqwhuydIsBc5sApNB7+F9rQwVilwV4Tr5AYxmkV6zxhy33xRa1o6Y
         IEshKPl81fIla2x7DI4PE8Nk88LS7af9FeiAtewNX0YpiOrWtD9QYodlX81cEw7rupDh
         WyAls17QrMylNK6VcbErpHGcLET+RR0yUWu4JO9+gxjG2kN5HA8B/YzNhtzGJALL9luB
         4WAJX68QJauWQVxzULjkWdh9hliZeD57MC2sZlj1oDy7wC6WJCXeLVqHdgXopQseElZF
         unoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691164259; x=1691769059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8KmqRM2LFxv0G8/Jyu+UzaXBM9Ly10dAMezjkMZvY3g=;
        b=jUrFVsnyL2IKq4lAYjsDSYx/LglPW0zBACL6rIIatfFRQYmzf9b8MXwpfyTSe8Wm+i
         vLXhHSIZ4Blq3yF9SDl3IhuBzowt8VUH6X+Xs31mBjwgFzptonRgBbWUahXgQrLsk2M2
         aYQcH6ujAk3P1rGKuc/ycu/NLKoh2IfZC4liFRMIOUdrzbDWFvBezGNz10C3VFAVGOqR
         9PgL4bIpGxMS7XqDBpJ0WIDSPpr4zdsjpOCFxlxkat3R0SY5vzI2KUelGrP8eiOaPMu4
         jgKUkttAFlmsvzLUUonACIxS/plIm1ZNa5j68OTZXW9u9n/6z4Q4JNW8RSnUfrCUzG4v
         QQRQ==
X-Gm-Message-State: AOJu0YxFVDvpJ8ICFf52kJs6T6Fh1RVyJyyqW8r50SuWMIHH0Y95aVzK
	fa/D7x2Bk671+LDb/08qPenDwsAUlySajZJGAmUV8g==
X-Google-Smtp-Source: AGHT+IGLSZXAehNzRf+531sV2fiqCS2/ML1XKb67FToPHVe4owQoxoCtOwkKRx5PC7ylYdEKiVF38wyxc08W95jW80c=
X-Received: by 2002:a50:d4cc:0:b0:51a:1ffd:10e with SMTP id
 e12-20020a50d4cc000000b0051a1ffd010emr85258edj.3.1691164258862; Fri, 04 Aug
 2023 08:50:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230804144616.3938718-1-edumazet@google.com> <20230804144616.3938718-4-edumazet@google.com>
In-Reply-To: <20230804144616.3938718-4-edumazet@google.com>
From: Soheil Hassas Yeganeh <soheil@google.com>
Date: Fri, 4 Aug 2023 11:50:22 -0400
Message-ID: <CACSApvaXx+aogteaxFr+D-1zhZ6nrF+DNmuA=hicpaUf-2w45A@mail.gmail.com>
Subject: Re: [PATCH net-next 3/6] tcp: set TCP_KEEPINTVL locklessly
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
> tp->keepalive_intvl can be set locklessly, readers
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
> index 34c2a40b024779866216402e1d1de1802f8dfde4..75d6359ee5750d8a867fb36ec=
2de960869d8c76a 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -3348,9 +3348,7 @@ int tcp_sock_set_keepintvl(struct sock *sk, int val=
)
>         if (val < 1 || val > MAX_TCP_KEEPINTVL)
>                 return -EINVAL;
>
> -       lock_sock(sk);
>         WRITE_ONCE(tcp_sk(sk)->keepalive_intvl, val * HZ);
> -       release_sock(sk);
>         return 0;
>  }
>  EXPORT_SYMBOL(tcp_sock_set_keepintvl);
> @@ -3471,6 +3469,8 @@ int do_tcp_setsockopt(struct sock *sk, int level, i=
nt optname,
>                 return tcp_sock_set_syncnt(sk, val);
>         case TCP_USER_TIMEOUT:
>                 return tcp_sock_set_user_timeout(sk, val);
> +       case TCP_KEEPINTVL:
> +               return tcp_sock_set_keepintvl(sk, val);
>         }
>
>         sockopt_lock_sock(sk);
> @@ -3568,12 +3568,6 @@ int do_tcp_setsockopt(struct sock *sk, int level, =
int optname,
>         case TCP_KEEPIDLE:
>                 err =3D tcp_sock_set_keepidle_locked(sk, val);
>                 break;
> -       case TCP_KEEPINTVL:
> -               if (val < 1 || val > MAX_TCP_KEEPINTVL)
> -                       err =3D -EINVAL;
> -               else
> -                       WRITE_ONCE(tp->keepalive_intvl, val * HZ);
> -               break;
>         case TCP_KEEPCNT:
>                 if (val < 1 || val > MAX_TCP_KEEPCNT)
>                         err =3D -EINVAL;
> --
> 2.41.0.640.ga95def55d0-goog
>

