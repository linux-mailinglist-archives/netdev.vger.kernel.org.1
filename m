Return-Path: <netdev+bounces-49564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DE27F2707
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 09:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F79BB20FEF
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 08:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD7731A88;
	Tue, 21 Nov 2023 08:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XsiEoi7+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097C5C3
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 00:13:55 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-548c6efc020so10177a12.0
        for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 00:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700554433; x=1701159233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mf+BdlEkGDbGf7M1TsZM1PoygNkC+ixC14u9l75PZkw=;
        b=XsiEoi7+g05dayZN6xmalA1z6MxeyC2bjF6D7bzN8LEYkqtLJGTT0AY7aUiLWhFCju
         LpoGP5q0MVEv9X7melgOzatiTFoX94fkYIAUdb6HTPkfoN82kZJcVfLS+Tt7gbp/OJ1U
         eYmZiccnuVa99VdoAOCMNGvsLF5wDNPgxO0Ka+G8aNrkpBYt2Aovgwuuz6CMZT3WXSVd
         qzjGtxbpApQHWreoIbQjZwyYkclX5TUIzYilJ8fd0Kf39UqLc3pxr116tUKQo5DWR+1y
         8f5fDKsD5poiQBYt1fnWIds1WTpBOQ3nUTuEDNjoG6DiVTbhQeRDmBufSKSf5uOzfHLA
         i8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700554433; x=1701159233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mf+BdlEkGDbGf7M1TsZM1PoygNkC+ixC14u9l75PZkw=;
        b=wJaIyBnz5sNHFbLV5qsLgxUKmBAU20oUhWIa8KeEAOdS8wzPimS43w8AxzuhQQi+8w
         Ki/aRY776KM9ch2UGITInn0T0pLqQjh7Mp1W6L+KyZZN7+8NCnndovOqgboY0x0guEhw
         kRPh1pi1/e1Cun2K33NWXpBVYS3l29rrkrppeiX0wuyZA96+yaPffPMTcz85M+wBvs1Y
         9M6H7/tG9/F9ZbtN0wypw/xrJNDcn6QVYoRwPBi03FMNtn5+9Ad9+LUmATQoSduAQ7e4
         hwqXhRbLBLzMGkjn/hmeFER3iyZ9hby8or12FtWkAikf7RsRVKRXmHKVX2fgNAq5sHBW
         MAkg==
X-Gm-Message-State: AOJu0Yw7ROQsHjS+KWfDmg6zxdVHih+viq6TQ4ibgnJvMc9yFnqOAUzD
	C2ZVQbmU0X2myyHu/2oRdTE3D3dTF6Qdv8Ng3OByzQ==
X-Google-Smtp-Source: AGHT+IGFwYxSbTDYvmUGtIwukajn1P1YWpIV0tYvyPHz82Xr6UQWNYv5FGNk7ZL/FeBdbiKiC7fIf9xNc3PSUwRu3tU=
X-Received: by 2002:a05:6402:3886:b0:543:fb17:1a8 with SMTP id
 fd6-20020a056402388600b00543fb1701a8mr575639edb.3.1700554433190; Tue, 21 Nov
 2023 00:13:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121020111.1143180-1-dima@arista.com> <20231121020111.1143180-8-dima@arista.com>
In-Reply-To: <20231121020111.1143180-8-dima@arista.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 21 Nov 2023 09:13:42 +0100
Message-ID: <CANn89iK-=G7p5CMuJDjioa7+ynZRrOOpd7bK3kPzxCXzygfFCQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] net/tcp: Don't store TCP-AO maclen on reqsk
To: Dmitry Safonov <dima@arista.com>
Cc: David Ahern <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, 
	Dmitry Safonov <0x7f454c46@gmail.com>, Francesco Ruggeri <fruggeri05@gmail.com>, 
	Salam Noureddine <noureddine@arista.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 3:01=E2=80=AFAM Dmitry Safonov <dima@arista.com> wr=
ote:
>
> This extra check doesn't work for a handshake when SYN segment has
> (current_key.maclen !=3D rnext_key.maclen). It could be amended to
> preserve rnext_key.maclen instead of current_key.maclen, but that
> requires a lookup on listen socket.
>
> Originally, this extra maclen check was introduced just because it was
> cheap. Drop it and convert tcp_request_sock::maclen into boolean
> tcp_request_sock::used_tcp_ao.
>
> Fixes: 06b22ef29591 ("net/tcp: Wire TCP-AO to request sockets")
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>  include/linux/tcp.h   | 10 ++++------
>  net/ipv4/tcp_ao.c     |  4 ++--
>  net/ipv4/tcp_input.c  |  5 +++--
>  net/ipv4/tcp_output.c |  9 +++------
>  4 files changed, 12 insertions(+), 16 deletions(-)
>
> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> index 68f3d315d2e1..3af897b00920 100644
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -155,6 +155,9 @@ struct tcp_request_sock {
>         bool                            req_usec_ts;
>  #if IS_ENABLED(CONFIG_MPTCP)
>         bool                            drop_req;
> +#endif
> +#ifdef CONFIG_TCP_AO
> +       bool                            used_tcp_ao;

Why adding another 8bit field here and creating a hole ?

>  #endif
>         u32                             txhash;
>         u32                             rcv_isn;
> @@ -169,7 +172,6 @@ struct tcp_request_sock {
>  #ifdef CONFIG_TCP_AO
>         u8                              ao_keyid;
>         u8                              ao_rcv_next;
> -       u8                              maclen;

Just rename maclen here to  used_tcp_ao ?

>  #endif
>  };
>

