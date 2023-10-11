Return-Path: <netdev+bounces-40089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A676B7C5AF7
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 20:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 569F128236E
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 18:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A328F13FF9;
	Wed, 11 Oct 2023 18:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YkKwz31F"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1954C3994A
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 18:10:33 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F76A4
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 11:10:32 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4053f24c900so9025e9.1
        for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 11:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697047830; x=1697652630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ll2dO80dKdNtktHpD8Nup75jkjUJEZ6P5R1J+WyNECY=;
        b=YkKwz31F5HP8JUaJw1v+viSHW2+XXpHLRke3TRM/2azgDWa0OOAn6n/dtblz1eu+Be
         h/v6AfOD6VcpccnJJ4mH/XZWRN125507eLaCvYFVyGG6sIua7RU7eoVMcXjH1hBzI5jk
         Pq08rjSZYSYdsf3pFIy5iZuS5LZQ06DDzwPBQqR8cTG7XVoRDh2+LgR0buuihvVYx78s
         JQjW1iijNjw7qB3+DMQJvX7mBaSdEDzUDblB2iG4jdme28F94fUAJIC9a2lsoIXhMa+r
         U1ko1dQG8Wyx5/ePX4mMeoXq+7PH0n4q2kMEIzg5tMZeknSKOfzOpEUezB50HrK6rBm7
         UX9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697047830; x=1697652630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ll2dO80dKdNtktHpD8Nup75jkjUJEZ6P5R1J+WyNECY=;
        b=IcOBstuQn2MOQzIZXUXmZHoQmbv84KjCNuIZjnpsTIs9NFWeB0cRrPI/IWKheXLfPR
         sF3msvG8HLUCmZ1f+ZrHa24KtiGA6sY1t9hV3prJZeKP1/vhKGr0NyhWrnhU/Vz2NFDN
         WcV0+wfWRM0I3UZoqNsDPnPApYtLIXiYUOqGv4dRK1nb+5morZ5Bka1aYn8MqZgS5pFl
         R+NoY+CTV8DFZvHJBwr8HhVHKongJo/ufsmEiKGPhKh2ewL88g6e3CT7jpvTMnm3PoU5
         4JOFe/XiTIWEKpOnXu8QAQD6VMk3h8o6b0WgMEajpASeiH40lKsNsPfs26yqDzZC8sg8
         hBzQ==
X-Gm-Message-State: AOJu0YyHhChVk9d5vaZndnZL20+pKTlen1oIfb0gjQ+hPLpKT7egCCub
	6TmFplA9CA6lS3f1DPvhSikLMNKt6QacQveBIFSQLA==
X-Google-Smtp-Source: AGHT+IFNcNJNI8p4w8N17R8rGdiSVF/UkTipnQdlUZgaXk0kTR/bUKb2YXdrQKszl5vchkfRD8n+6CMPbZSnorHqKzM=
X-Received: by 2002:a05:600c:1ca6:b0:400:c6de:6a20 with SMTP id
 k38-20020a05600c1ca600b00400c6de6a20mr125146wms.3.1697047830169; Wed, 11 Oct
 2023 11:10:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231009230722.76268-1-dima@arista.com> <20231009230722.76268-10-dima@arista.com>
In-Reply-To: <20231009230722.76268-10-dima@arista.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 11 Oct 2023 20:10:19 +0200
Message-ID: <CANn89iLD=ySFfPYkrb+oN2fuMhimxXfHrhs4Pv9_60f912rzmQ@mail.gmail.com>
Subject: Re: [PATCH v14 net-next 09/23] net/tcp: Add TCP-AO sign to twsk
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
	Salam Noureddine <noureddine@arista.com>, Simon Horman <simon.horman@corigine.com>, 
	"Tetreault, Francois" <ftetreau@ciena.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 1:07=E2=80=AFAM Dmitry Safonov <dima@arista.com> wr=
ote:
>
> Add support for sockets in time-wait state.
> ao_info as well as all keys are inherited on transition to time-wait
> socket. The lifetime of ao_info is now protected by ref counter, so
> that tcp_ao_destroy_sock() will destruct it only when the last user is
> gone.
>
> Co-developed-by: Francesco Ruggeri <fruggeri@arista.com>
> Signed-off-by: Francesco Ruggeri <fruggeri@arista.com>
> Co-developed-by: Salam Noureddine <noureddine@arista.com>
> Signed-off-by: Salam Noureddine <noureddine@arista.com>
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> Acked-by: David Ahern <dsahern@kernel.org>
> ---
>  include/linux/tcp.h      |  3 ++
>  include/net/tcp_ao.h     | 11 ++++-
>  net/ipv4/tcp_ao.c        | 46 +++++++++++++++++---
>  net/ipv4/tcp_ipv4.c      | 92 +++++++++++++++++++++++++++++++---------
>  net/ipv4/tcp_minisocks.c |  4 +-
>  net/ipv4/tcp_output.c    |  2 +-
>  net/ipv6/tcp_ipv6.c      | 72 ++++++++++++++++++++++---------
>  7 files changed, 181 insertions(+), 49 deletions(-)
>
> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> index c38778b0baa0..51458219be4e 100644
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -512,6 +512,9 @@ struct tcp_timewait_sock {
>  #ifdef CONFIG_TCP_MD5SIG
>         struct tcp_md5sig_key     *tw_md5_key;
>  #endif
> +#ifdef CONFIG_TCP_AO
> +       struct tcp_ao_info      __rcu *ao_info;
> +#endif
>  };
>
>  static inline struct tcp_timewait_sock *tcp_twsk(const struct sock *sk)
> diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
> index 629ab0365b83..af2caf7e76fc 100644
> --- a/include/net/tcp_ao.h
> +++ b/include/net/tcp_ao.h
> @@ -85,6 +85,7 @@ struct tcp_ao_info {
>                                 __unused        :31;
>         __be32                  lisn;
>         __be32                  risn;
> +       atomic_t                refcnt;         /* Protects twsk destruct=
ion */

This needs to be a refcount_t

