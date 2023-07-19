Return-Path: <netdev+bounces-18825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FED758C1F
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 05:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DB2928181B
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 03:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341DC1C06;
	Wed, 19 Jul 2023 03:31:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2361B1FB4
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 03:31:42 +0000 (UTC)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C76A119
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 20:31:40 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-40371070eb7so479831cf.1
        for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 20:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689737499; x=1692329499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3WGKKu7kZoCnbjCX34tBWkzIVGJY3tJhRvan09NcUvU=;
        b=bKkgMv4vS0BAs5XtiLOziKLdKe/OxNIBls/oFRr5wOZJzGiUI1c8RiI23pJWECj88b
         qmYDvp8gSD5hXd9VPfXkx1/Nd+1jvCt7BSo7R3dwZTsncfdN+FxQu1HkNtOzcTrAB0b5
         LJtF8MFq77vAcwk5seJBWELcNu9IlkTXenHGJF75Gir2gjIpY1ok0brn9bxVI5b2rGub
         /1pVP/1qsgAaYtZmvsCiksnYhgWxBxxpLddhFNLYF2E4ujDO/xlQx/99003ND7reIPbA
         TgV3bwj8WRKuVTvDG7TpMSxPnc93fDDfkI0Dat4qQHL5gFX4i+X4GQoVlMAlT/cohMfK
         Uwow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689737499; x=1692329499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3WGKKu7kZoCnbjCX34tBWkzIVGJY3tJhRvan09NcUvU=;
        b=bWDy7+yo/t5CCPlA+16JMe6Pj2rz1mic2VzSDoqe9wbUKIl9gIm7MSPlwbkRv3g4W1
         APOAgGGHz3fcxI9HK2t42KTR2dT8A4hjeFWOrjCZXWNA/KZIwpytZlI+++APxFH3vtqc
         LFqP8ebwcCDitN4GGGyqkh0+cRMEPv3dyBd3xjsql60F7fH9IIOugtzQ0ECJZKk++G8g
         eEV+18Mjf3A+r751Gw5OeDc/epV1fgreUxSzuAsFu3+BYDs9UiPOrqucI2n4F5BZS6iU
         ydx3zy8jZv9hQeLLvXSnL2AqZkIq8YRrZ8wGBrgi8/Di1KUixHwpautyH2+pMLEYqBqh
         xpZg==
X-Gm-Message-State: ABy/qLZkyTnNtQ1tT287Jj0pcoEEupKd2J1i3v+goIS6RYFly1JjZfsU
	ocOeliC8NVvSNNhjJzHcXwHhR4BRGMYXsSjz9ZbOiEem4uhvu+fIc7rfaQ==
X-Google-Smtp-Source: APBJJlG5qPMRFvaVadD1Xf8LaY9bLavGxePqz94LiSjYZEAOxx/qqckQ4ZhDvFo9boxqtLR2Tomw7AXDYwXCeH1XhSI=
X-Received: by 2002:a05:622a:312:b0:3fa:3c8f:3435 with SMTP id
 q18-20020a05622a031200b003fa3c8f3435mr377994qtw.27.1689737499247; Tue, 18 Jul
 2023 20:31:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230711011737.1969582-1-william.xuanziyang@huawei.com> <20230717-clubhouse-swinger-8f0fa23b0628-mkl@pengutronix.de>
In-Reply-To: <20230717-clubhouse-swinger-8f0fa23b0628-mkl@pengutronix.de>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 19 Jul 2023 05:31:28 +0200
Message-ID: <CANn89iJ47sVXAEEryvODoGv-iUpT-ACTCSWQTmdtJ9Fqs0s40Q@mail.gmail.com>
Subject: Re: [PATCH net v3] can: raw: fix receiver memory leak
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Ziyang Xuan <william.xuanziyang@huawei.com>, socketcan@hartkopp.net, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	penguin-kernel@i-love.sakura.ne.jp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 17, 2023 at 9:27=E2=80=AFAM Marc Kleine-Budde <mkl@pengutronix.=
de> wrote:
>
> On 11.07.2023 09:17:37, Ziyang Xuan wrote:
> > Got kmemleak errors with the following ltp can_filter testcase:
> >
> > for ((i=3D1; i<=3D100; i++))
> > do
> >         ./can_filter &
> >         sleep 0.1
> > done
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [<00000000db4a4943>] can_rx_register+0x147/0x360 [can]
> > [<00000000a289549d>] raw_setsockopt+0x5ef/0x853 [can_raw]
> > [<000000006d3d9ebd>] __sys_setsockopt+0x173/0x2c0
> > [<00000000407dbfec>] __x64_sys_setsockopt+0x61/0x70
> > [<00000000fd468496>] do_syscall_64+0x33/0x40
> > [<00000000b7e47d51>] entry_SYSCALL_64_after_hwframe+0x61/0xc6
> >
> > It's a bug in the concurrent scenario of unregister_netdevice_many()
> > and raw_release() as following:
> >
> >              cpu0                                        cpu1
> > unregister_netdevice_many(can_dev)
> >   unlist_netdevice(can_dev) // dev_get_by_index() return NULL after thi=
s
> >   net_set_todo(can_dev)
> >                                               raw_release(can_socket)
> >                                                 dev =3D dev_get_by_inde=
x(, ro->ifindex); // dev =3D=3D NULL
> >                                                 if (dev) { // receivers=
 in dev_rcv_lists not free because dev is NULL
> >                                                   raw_disable_allfilter=
s(, dev, );
> >                                                   dev_put(dev);
> >                                                 }
> >                                                 ...
> >                                                 ro->bound =3D 0;
> >                                                 ...
> >
> > call_netdevice_notifiers(NETDEV_UNREGISTER, )
> >   raw_notify(, NETDEV_UNREGISTER, )
> >     if (ro->bound) // invalid because ro->bound has been set 0
> >       raw_disable_allfilters(, dev, ); // receivers in dev_rcv_lists wi=
ll never be freed
> >
> > Add a net_device pointer member in struct raw_sock to record bound can_=
dev,
> > and use rtnl_lock to serialize raw_socket members between raw_bind(), r=
aw_release(),
> > raw_setsockopt() and raw_notify(). Use ro->dev to decide whether to fre=
e receivers in
> > dev_rcv_lists.
> >
> > Fixes: 8d0caedb7596 ("can: bcm/raw/isotp: use per module netdevice noti=
fier")
> > Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
> > Reviewed-by: Oliver Hartkopp <socketcan@hartkopp.net>
> > Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
>
> Added to linux-can/testing.
>

This patch causes three syzbot LOCKDEP reports so far.

I suspect we need something like the following patch.

If nobody objects, I will submit this formally soon.

diff --git a/net/can/raw.c b/net/can/raw.c
index 2302e48829677334f8b2d74a479e5a9cbb5ce03c..ba6b52b1d7767fdd7b57d1b8e55=
19495340c572c
100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -386,9 +386,9 @@ static int raw_release(struct socket *sock)
        list_del(&ro->notifier);
        spin_unlock(&raw_notifier_lock);

+       rtnl_lock();
        lock_sock(sk);

-       rtnl_lock();
        /* remove current filters & unregister */
        if (ro->bound) {
                if (ro->dev)
@@ -405,12 +405,13 @@ static int raw_release(struct socket *sock)
        ro->dev =3D NULL;
        ro->count =3D 0;
        free_percpu(ro->uniq);
-       rtnl_unlock();

        sock_orphan(sk);
        sock->sk =3D NULL;

        release_sock(sk);
+       rtnl_unlock();
+
        sock_put(sk);

        return 0;

