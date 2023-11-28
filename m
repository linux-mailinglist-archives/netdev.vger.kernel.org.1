Return-Path: <netdev+bounces-51724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8107FBDD5
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 16:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 348F6B20B05
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 15:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A925CD24;
	Tue, 28 Nov 2023 15:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C5pNGv4I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FCFD49
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 07:12:24 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-54b0c368d98so9848a12.1
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 07:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701184343; x=1701789143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xkBw/es1LgyI4zK7NU74/SX9pAO59ac919np3TEdJiA=;
        b=C5pNGv4I9kKKLvKd+hbcMsAZlncO1tt0dxHRY4w5/IGH7jwHnFxwjo1VeIECUVmLN0
         +z8i8yeJ8lu8x+lLqShb2eL+VejUYLEPN81dWIWPEbzNI3yIHzk58KJnUbPjrDYgpNKX
         wobZTX84A7stMQIlVusirlJwO30E2LXoVAjxtbfdAzgPqLSOQAKY+xzb1kaBQ+gu+VlJ
         HrnBt85tc7EBn+QYrZvjlsYhpX5IuItD18HMROYMFZLawTSSHJWpT0awIOG3e+/CrzWu
         oeXxf8RPwd5ft1aUeylkGiUtEzhif0RpbvYtRUeoexmosNai/pZAKKPTy1i1qXCuZ2Vm
         bFQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701184343; x=1701789143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xkBw/es1LgyI4zK7NU74/SX9pAO59ac919np3TEdJiA=;
        b=id57RRWiBHxd+tDMLwMPiz/cKhwJo6Xsw7qk81M1jHhm1YWaDhLgaK/cu7TSYwPdAU
         HLIrfEym2/51EvdF+arxsnUHGSRUgiAWGzrYp440y3wtIp3pksK/E/C8ZYNL4HJR7lfh
         uLbeMq6x+Ce6y40ew598EuyT8wziERLskxK94/ypRiRj02ujT2ih5DtB53D9bxXq4w4Y
         YtI7mzIIWlVc49xRdXdMyn7ZHjyk/6E+OilWNldMRD5nU4cPYEVOp54LcIgmZ8472PpJ
         ZChHl86IqPNvoeoYH+hwUdUNRlNnCoy34xGKW8HPDMXQwqwm1i4xQiInp0hB79ayfDRY
         wvtw==
X-Gm-Message-State: AOJu0Yy+G1z+dTgvHbf/ZsHGvchF6bxnvZu9HZdJcxvGN+lujc+KUy8u
	xvh9MiMLq0jP1WKh1iZyxn8wvvvUZQx9CRzy1Bmm/A==
X-Google-Smtp-Source: AGHT+IHaX7scUm9uTntceKE6T+LBWo3v8l3hgAGRyspBUGUv/oxgcBvgHwLUFiQKZeG32RzY7wqrwNmqPnAAaYDN9Kw=
X-Received: by 2002:aa7:dccb:0:b0:54b:321:ef1a with SMTP id
 w11-20020aa7dccb000000b0054b0321ef1amr419622edu.6.1701184342496; Tue, 28 Nov
 2023 07:12:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231125011638.72056-1-kuniyu@amazon.com> <20231125011638.72056-5-kuniyu@amazon.com>
In-Reply-To: <20231125011638.72056-5-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 28 Nov 2023 16:12:08 +0100
Message-ID: <CANn89iKaOrkdaKYnjFx2B08Cw5idMW0+-181_WK6Go3J8DXNXQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 4/8] tcp: Don't pass cookie to __cookie_v[46]_check().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 25, 2023 at 2:18=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> tcp_hdr(skb) and SYN Cookie are passed to __cookie_v[46]_check(), but
> none of the callers passes cookie other than ntohl(th->ack_seq) - 1.
>
> Let's fetch it in __cookie_v[46]_check() instead of passing the cookie
> over and over.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
>  include/linux/netfilter_ipv6.h   |  8 ++++----
>  include/net/tcp.h                |  6 ++----
>  net/core/filter.c                | 15 ++++-----------
>  net/ipv4/syncookies.c            | 15 ++++++++-------
>  net/ipv6/syncookies.c            | 15 ++++++++-------
>  net/netfilter/nf_synproxy_core.c |  4 ++--
>  6 files changed, 28 insertions(+), 35 deletions(-)

Reviewed-by: Eric Dumazet <edumazet@google.com>

