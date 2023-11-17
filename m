Return-Path: <netdev+bounces-48763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8412D7EF6F6
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 18:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA548B20AE2
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 17:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0291374D4;
	Fri, 17 Nov 2023 17:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KBqn4DQs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2B2E5
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 09:29:23 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so0a12.0
        for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 09:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700242161; x=1700846961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zNX5vSn4trFssKgOhtnpJClEAgcyxOvOwHdl3OyYifg=;
        b=KBqn4DQsWEAbn271fd2Xx0QfbuuF6nlpMdCjEHyP8CKuga5GQhnzq2kRgVdYBGDSVG
         OVO/Waqp6LGymP6q2qrQnOyeq8MQR2LReI3NxYueBQFY991U0eJnzOr/wBeDvJPKLtaE
         kheSEzsaG8CxZNECYtI4+8ZH5pCDvnuAKQTsaJv/C9p5sKAXH0UrwVlVXjV54NugzxAL
         7c4KCZ/1DWItqFWSwunBbkP+6L5RIF2aa1GsS8lrjlypeIVpILNLki47C8x+bxHbzOu1
         OLKqR4SMqnXOdmxOHVXp+EsuRds+H+nwjL+uqyY1IL3YHB0vsrDRJ6ARE8jOsr20sAxp
         LqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700242161; x=1700846961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zNX5vSn4trFssKgOhtnpJClEAgcyxOvOwHdl3OyYifg=;
        b=gEV6sCggT9ifF+1UCpWL0/MpbDBGbtKyi8iWkvgDyTYVOuP/tP3Pc+C6VNn/pb+j7O
         hyFnzeG/aVGPLbEnJJ3WLoYoYXvCE/z4DxPJ2sfBpEbFE2dTfwFuRdpqGvm8h441ZArb
         JyTzZ793Koy5Y2ukWaxf5ca+p1ZI529qTaTIGbvy+ST6R1+/Ylc9yenb5iokUdWVYjhs
         IVzEZticCcXJ34beuVFJlhOtNpzL9IhiC9nUQvltj2uPO4MSHJqjjtcKDFB4na1B6cHI
         Q8WqrRCz0HUrKghd7DW2nAQUHp6QFj5P3TAkGLLFjkPJdYYkwnaiwA2qAiV+3uSuTg4Y
         3QtA==
X-Gm-Message-State: AOJu0YzHi51McFBxly+oMSe9It8ELKRjkWu/alLZ7uMzxAX6+LUw7DDn
	PnD71bymHiznJv8q1qHn9kYRrVEzEPAP70gez3aTdQ==
X-Google-Smtp-Source: AGHT+IHZqKyWH2HNr9y7AtGf0eJxIce50Dug2CDO7QDkXuoh+B16qm3v+4PTfiSFawj5mE80S2Hn3+GdWACHh3DVNfs=
X-Received: by 2002:a05:6402:c41:b0:544:e249:be8f with SMTP id
 cs1-20020a0564020c4100b00544e249be8fmr14129edb.1.1700242161208; Fri, 17 Nov
 2023 09:29:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231117154831.2518110-1-chentao@kylinos.cn>
In-Reply-To: <20231117154831.2518110-1-chentao@kylinos.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 17 Nov 2023 18:29:10 +0100
Message-ID: <CANn89iKJ=Na2hWGv9Dau36Ojivt-icnd1BRgke033Z=a+E9Wcw@mail.gmail.com>
Subject: Re: [PATCH] ipv6: Correct/silence an endian warning in ip6_multipath_l3_keys
To: Kunwu Chan <chentao@kylinos.cn>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, kunwu.chan@hotmail.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2023 at 6:06=E2=80=AFPM Kunwu Chan <chentao@kylinos.cn> wro=
te:
>
> net/ipv6/route.c:2332:39: warning: incorrect type in assignment (differen=
t base types)
> net/ipv6/route.c:2332:39:    expected unsigned int [usertype] flow_label
> net/ipv6/route.c:2332:39:    got restricted __be32
>
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>

Same remark, we need a Fixes: tag

> ---
>  net/ipv6/route.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index b132feae3393..692c811eb786 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -2329,7 +2329,7 @@ static void ip6_multipath_l3_keys(const struct sk_b=
uff *skb,
>         } else {
>                 keys->addrs.v6addrs.src =3D key_iph->saddr;
>                 keys->addrs.v6addrs.dst =3D key_iph->daddr;
> -               keys->tags.flow_label =3D ip6_flowlabel(key_iph);
> +               keys->tags.flow_label =3D be32_to_cpu(ip6_flowlabel(key_i=
ph));
>                 keys->basic.ip_proto =3D key_iph->nexthdr;
>         }

This is not consistent with line 2541 doing:

hash_keys.tags.flow_label =3D (__force u32)flowi6_get_flowlabel(fl6);

