Return-Path: <netdev+bounces-18844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA92758CDB
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 07:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B3EE1C20CC2
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 05:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A8B566F;
	Wed, 19 Jul 2023 05:05:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBDD17D2
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 05:05:10 +0000 (UTC)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0911BFC
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 22:05:08 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-40371070eb7so493971cf.1
        for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 22:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689743108; x=1692335108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7PCWnotveVA/7iFt/FZ6cY9FtIJgmCHS8Q1l6pZTMlw=;
        b=xg58N9xeL1FKsCRyRkoWxJqJwEWppJ//Ba/BnHZGiYMzAxsyWAYbdmWHVVmAok2V8l
         wZHoyAogaPOsrkE6p9g5sMDFgdMkuTj6eLOqsZ2rW1+xBgKGOg3lC1ig9s0ut4auoGJC
         8qtdmVC4hPc76jRJe+xQ6hDfpaN+b5cTbTD2076BrpyydJkX4IkGhYLfrZoNtjNz92My
         3Jn5lbuFCY9egmGnb1BiJ66i+yI56Kf4UYJBKTO6F3h1wCbG3rFvQIWPXv1wNk1I3/GN
         28NvLJ3r9dmPkdiFvrgGnLUQVrbxW5d1aTY2F7O4m5qim11U2UuTTslozQh+03CGj7BJ
         /bng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689743108; x=1692335108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7PCWnotveVA/7iFt/FZ6cY9FtIJgmCHS8Q1l6pZTMlw=;
        b=eygFJKC0QS/3B7liBQLBvwkJZBCefp0jvlO4Qny6+nBabZntiZJ5Dgg4HljRUn6VHl
         adlLNrsBjEibduQhHeqeOqQoMDGrU5kcEaDKBB+lldqjaSXxlpOyzoKdghSbYjgPRLvs
         IUxJB7UAN9p9boJzbK8K8hpz+cpfkOFSY1eUNlDgxwqAB0qrPEa/TdeDA5wi1C08sae1
         EXk5GcAPOsuq5YyMLrRlIYfESlsgk4se8dR08xRPNHRwih+I3FVjxsgBTli5ZjiHyGFr
         3gBJOuG1X3MXeeMSgG5Q5C/vfCM2JYeUogSIJ9yh6ipF2Qspyg+SZM7CLUS9BWvwuEwq
         igOg==
X-Gm-Message-State: ABy/qLY0AZn4/2+naMoStcbA/07ivJTpyFZcKnLxzp+uP8LsYXt1iEYh
	RyiXQx3RTiDctAThGHd/hVteAVZtkJmWWgW9oI+d4csR4vCYVpJe8v4tWQ==
X-Google-Smtp-Source: APBJJlEsnVdvVhlqauvKLngQpQifQUoEWZR/Q1biTuLxF8okYuPXdwhHP8Md0JFs7gpHaHVtSYSQhirzsKwMVi0tjJs=
X-Received: by 2002:ac8:7e8d:0:b0:3f5:2006:50f1 with SMTP id
 w13-20020ac87e8d000000b003f5200650f1mr524107qtj.12.1689743107793; Tue, 18 Jul
 2023 22:05:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230711011737.1969582-1-william.xuanziyang@huawei.com>
 <20230717-clubhouse-swinger-8f0fa23b0628-mkl@pengutronix.de>
 <CANn89iJ47sVXAEEryvODoGv-iUpT-ACTCSWQTmdtJ9Fqs0s40Q@mail.gmail.com> <1e0e6539-412a-cc8d-b104-e2921a099e48@huawei.com>
In-Reply-To: <1e0e6539-412a-cc8d-b104-e2921a099e48@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 19 Jul 2023 07:04:56 +0200
Message-ID: <CANn89iKoTWHBGgMW-RyJHHeM0QuiN9De=eNWMM8VRom++n_o_g@mail.gmail.com>
Subject: Re: [PATCH net v3] can: raw: fix receiver memory leak
To: "Ziyang Xuan (William)" <william.xuanziyang@huawei.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, socketcan@hartkopp.net, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, penguin-kernel@i-love.sakura.ne.jp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 19, 2023 at 6:41=E2=80=AFAM Ziyang Xuan (William)
<william.xuanziyang@huawei.com> wrote:
>
> > On Mon, Jul 17, 2023 at 9:27=E2=80=AFAM Marc Kleine-Budde <mkl@pengutro=
nix.de> wrote:
> >>
> >> On 11.07.2023 09:17:37, Ziyang Xuan wrote:
> >>> Got kmemleak errors with the following ltp can_filter testcase:
> >>>
> >>> for ((i=3D1; i<=3D100; i++))
> >>> do
> >>>         ./can_filter &
> >>>         sleep 0.1
> >>> done
> >>>
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> [<00000000db4a4943>] can_rx_register+0x147/0x360 [can]
> >>> [<00000000a289549d>] raw_setsockopt+0x5ef/0x853 [can_raw]
> >>> [<000000006d3d9ebd>] __sys_setsockopt+0x173/0x2c0
> >>> [<00000000407dbfec>] __x64_sys_setsockopt+0x61/0x70
> >>> [<00000000fd468496>] do_syscall_64+0x33/0x40
> >>> [<00000000b7e47d51>] entry_SYSCALL_64_after_hwframe+0x61/0xc6
> >>>
> >>> It's a bug in the concurrent scenario of unregister_netdevice_many()
> >>> and raw_release() as following:
> >>>
> >>>              cpu0                                        cpu1
> >>> unregister_netdevice_many(can_dev)
> >>>   unlist_netdevice(can_dev) // dev_get_by_index() return NULL after t=
his
> >>>   net_set_todo(can_dev)
> >>>                                               raw_release(can_socket)
> >>>                                                 dev =3D dev_get_by_in=
dex(, ro->ifindex); // dev =3D=3D NULL
> >>>                                                 if (dev) { // receive=
rs in dev_rcv_lists not free because dev is NULL
> >>>                                                   raw_disable_allfilt=
ers(, dev, );
> >>>                                                   dev_put(dev);
> >>>                                                 }
> >>>                                                 ...
> >>>                                                 ro->bound =3D 0;
> >>>                                                 ...
> >>>
> >>> call_netdevice_notifiers(NETDEV_UNREGISTER, )
> >>>   raw_notify(, NETDEV_UNREGISTER, )
> >>>     if (ro->bound) // invalid because ro->bound has been set 0
> >>>       raw_disable_allfilters(, dev, ); // receivers in dev_rcv_lists =
will never be freed
> >>>
> >>> Add a net_device pointer member in struct raw_sock to record bound ca=
n_dev,
> >>> and use rtnl_lock to serialize raw_socket members between raw_bind(),=
 raw_release(),
> >>> raw_setsockopt() and raw_notify(). Use ro->dev to decide whether to f=
ree receivers in
> >>> dev_rcv_lists.
> >>>
> >>> Fixes: 8d0caedb7596 ("can: bcm/raw/isotp: use per module netdevice no=
tifier")
> >>> Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
> >>> Reviewed-by: Oliver Hartkopp <socketcan@hartkopp.net>
> >>> Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
> >>
> >> Added to linux-can/testing.
> >>
> >
> > This patch causes three syzbot LOCKDEP reports so far.
>
> Hello Eric,
>
> Is there reproducer? I want to understand the specific root cause.
>

No repro yet, but simply look at other functions in net/can/raw.c

You must always take locks in the same order.

raw_bind(), raw_setsockopt() use:

rtnl_lock();
lock_sock(sk);

Therefore, raw_release() must _also_ use the same order, or risk deadlock.

Please build a LOCKDEP enabled kernel, and run your tests ?

