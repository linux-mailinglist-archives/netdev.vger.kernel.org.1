Return-Path: <netdev+bounces-17162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AED750A37
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 15:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04A0F1C20EF6
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 13:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FAB34CC2;
	Wed, 12 Jul 2023 13:59:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920A82AB42
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 13:59:00 +0000 (UTC)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D3E10C7
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 06:58:57 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-40371070eb7so246831cf.1
        for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 06:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689170336; x=1691762336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8JcShd0oM4kEUl2tD0jn7iZHCqnw5eZrM1LQxOVRDnU=;
        b=ByOzibciFt113ndRVv0hVC4AozWU7nNNDWlfxkfF0hko6ZgksB9NNf3IcQ40hg+/tH
         LKDWJNfopwBs7UqpwA07ad8+h7edlEAOmMOW/k+msdG4ESFyJbPfcx4lMOqQuZ8AfKZX
         98KoQalW8mupOqx6fhWpy42XYZX1Smzsh7KL0+H2e4QDYqJ/EqeYwcxTvQ51VKNe9wDE
         C/14hYGp5WK5lrr7/ESoqr1YHjsePOoXyDtyzO/zeJ7/5PcCjZ6BnV9Gi0fIDL8w+9WX
         EiIXQOMk/yCR7sE5aPlW4SjSuJr3AMaH4E1lkzUYqKwbMr0O8tg3Ls8UQM8gesuVcR6f
         KGZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689170336; x=1691762336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8JcShd0oM4kEUl2tD0jn7iZHCqnw5eZrM1LQxOVRDnU=;
        b=ZxGoT78TBW5pSR7GeEpQQP5f6+70LvMPhODxphijOtAib7vPy4Zie6V1OulkKADvRA
         c/8Ynkuz0NQRNd1OjfLWC00z2ZMjMx17NaPSU2TUjWJDyLJNIJKRuXExWAwA+WV67vzk
         BYauOFKWJ+JDsfGFzCSxN52EEDv5OVTlbcabbIZs23d558cCsuiSHK+MOqif35aP8rA/
         hx59a6ZfQ+pU1dpyWZtkcEwKlko3UytQwwmHmwfKtKlqhlGfcveR2t8ClegqJ6GRNFDG
         CrHVe0GaJG6TfUG4zAAc0bGx2nNVN//BWTbCE8ddRpapj2SfgrASjGxzIRad2LjEK5km
         IFiA==
X-Gm-Message-State: ABy/qLZ9WbWhhMJTq5cMbS8YXpNS/tE2//VIicH5g0BbyR5hzVDRJgHk
	RUFtZ94bNdk/sZGjlV+MRwCQA7lG2va4E/sQw+syAg==
X-Google-Smtp-Source: APBJJlG4nUjR0Wc5ZZ6du+fYfj4v/rZ8BQPRF3hOTcWRiRdTjkEZwuXg91kB06/7O1tUmuH18eNccnLRgPudp7uV/U4=
X-Received: by 2002:a05:622a:c:b0:3f0:af20:1a37 with SMTP id
 x12-20020a05622a000c00b003f0af201a37mr152152qtw.15.1689170336160; Wed, 12 Jul
 2023 06:58:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230712135520.743211-1-maze@google.com>
In-Reply-To: <20230712135520.743211-1-maze@google.com>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Date: Wed, 12 Jul 2023 15:58:43 +0200
Message-ID: <CANP3RGeckq1hiiFvXZ1m7hozSUc5S=qLmsL7xnk1Bts_vbGNWg@mail.gmail.com>
Subject: Re: [PATCH net] ipv6 addrconf: fix bug where deleting a mngtmpaddr
 can create a new temporary address
To: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jiri Pirko <jiri@resnulli.us>, Xiao Ma <xiaom@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_SPF_WL autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 12, 2023 at 3:55=E2=80=AFPM Maciej =C5=BBenczykowski <maze@goog=
le.com> wrote:
> currently on 6.4 net/main:
>
>   # ip link add dummy1 type dummy
>   # echo 1 > /proc/sys/net/ipv6/conf/dummy1/use_tempaddr
>   # ip link set dummy1 up
>   # ip -6 addr add 2000::1/64 mngtmpaddr dev dummy1
>   # ip -6 addr show dev dummy1
>
>   11: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state =
UNKNOWN group default qlen 1000
>       inet6 2000::44f3:581c:8ca:3983/64 scope global temporary dynamic
>          valid_lft 604800sec preferred_lft 86172sec
>       inet6 2000::1/64 scope global mngtmpaddr
>          valid_lft forever preferred_lft forever
>       inet6 fe80::e8a8:a6ff:fed5:56d4/64 scope link
>          valid_lft forever preferred_lft forever
>
>   # ip -6 addr del 2000::44f3:581c:8ca:3983/64 dev dummy1
>
>   (can wait a few seconds if you want to, the above delete isn't [directl=
y] the problem)
>
>   # ip -6 addr show dev dummy1
>
>   11: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state =
UNKNOWN group default qlen 1000
>       inet6 2000::1/64 scope global mngtmpaddr
>          valid_lft forever preferred_lft forever
>       inet6 fe80::e8a8:a6ff:fed5:56d4/64 scope link
>          valid_lft forever preferred_lft forever
>
>   # ip -6 addr del 2000::1/64 mngtmpaddr dev dummy1
>   # ip -6 addr show dev dummy1
>
>   11: dummy1: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state =
UNKNOWN group default qlen 1000
>       inet6 2000::81c9:56b7:f51a:b98f/64 scope global temporary dynamic
>          valid_lft 604797sec preferred_lft 86169sec
>       inet6 fe80::e8a8:a6ff:fed5:56d4/64 scope link
>          valid_lft forever preferred_lft forever
>
> This patch prevents this new 'global temporary dynamic' address from bein=
g
> created by the deletion of the related (same subnet prefix) 'mngtmpaddr'
> (which is triggered by there already being no temporary addresses).
>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: David Ahern <dsahern@kernel.org>
> Cc: Jiri Pirko <jiri@resnulli.us>
> Fixes: 53bd67491537 ("ipv6 addrconf: introduce IFA_F_MANAGETEMPADDR to te=
ll kernel to manage temporary addresses")
> Signed-off-by: Maciej =C5=BBenczykowski <maze@google.com>
> ---
>  net/ipv6/addrconf.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index e5213e598a04..94cec2075eee 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -2561,12 +2561,18 @@ static void manage_tempaddrs(struct inet6_dev *id=
ev,
>                         ipv6_ifa_notify(0, ift);
>         }
>
> -       if ((create || list_empty(&idev->tempaddr_list)) &&
> -           idev->cnf.use_tempaddr > 0) {
> +       /* Also create a temporary address if it's enabled but no tempora=
ry
> +        * address currently exists.
> +        * However, we get called with valid_lft =3D=3D 0, prefered_lft =
=3D=3D 0, create =3D=3D false
> +        * as part of cleanup (ie. deleting the mngtmpaddr).
> +        * We don't want that to result in creating a new temporary ip ad=
dress.
> +        */
> +       if (list_empty(&idev->tempaddr_list) && (valid_lft || prefered_lf=
t))
> +               create =3D true;
> +
> +       if (create && idev->cnf.use_tempaddr > 0) {
>                 /* When a new public address is created as described
>                  * in [ADDRCONF], also create a new temporary address.
> -                * Also create a temporary address if it's enabled but
> -                * no temporary address currently exists.
>                  */
>                 read_unlock_bh(&idev->lock);
>                 ipv6_create_tempaddr(ifp, false);
> --
> 2.41.0.255.g8b1d071c50-goog
>

eh, should have included:

Reported-by: Xiao Ma <xiaom@google.com>

