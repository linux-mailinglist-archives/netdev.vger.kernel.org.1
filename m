Return-Path: <netdev+bounces-52271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB13E7FE19A
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 22:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4307FB20FFE
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 21:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FDB61670;
	Wed, 29 Nov 2023 21:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AdF/tHW/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D561D7F
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 13:13:02 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-54bfa9b4142so1600a12.0
        for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 13:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701292381; x=1701897181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+nIqgsvETnKoQSc8vKUyOXXBEEy3r6fseGYRERcez/M=;
        b=AdF/tHW/B6xwMlxi7O1S1lygKgrQyEMwFaN6Humi5Bz5jZcHQmQTIH2yyNHGefTX7V
         gZUibvLDrdAF1DGeGkhm+NzB4gLxscCJ7RGxAGVwdId1pTYhAcvyrNzgIBi6jJ7dnXHB
         VTfe+v4+vX243PP6eF+J+xbeB8S50pz8IOyurLyhFpUVY9AClecfhyfQXwOHrljTfjV8
         AnohtZBX5kx2zeluvQuDDtKh2ncJ5V6kNuI72sdgiEpayaH0r4NiJpVo078a6nhuaAkE
         NVAbdsPj98XhSWU7bfZLwiqZqU49wew9+AB35cBSPaQ8LaSM05wh7KPiC5dvZaRevI6d
         PLFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701292381; x=1701897181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+nIqgsvETnKoQSc8vKUyOXXBEEy3r6fseGYRERcez/M=;
        b=gZHkzk34xWZA0FnlVpM3nyaKSO8LaaJdPSb8hWgBc1fnr94a//xvEfoIMVOYGo/4DC
         bkDxyo2oaggkuX7HYhmmQ9f81etdUR+MJrZ+WvDv7xVsCP9XX83OiLGLiUJ7bVh1f7cd
         ep0Bhth66G5Pya95tliVaWVWiJo7Ckm1iE1IylfPQUoW2ue6wR8tOOIRJVwZ3LET+hi9
         Iw4NTqTl3Cbb/tezUFfnM+Q+NuqoHMRWlL8khJmpUaFiKoPWd9wmi8a04rtlTrJE5PgM
         uqroTIyd+p1nZxr1k7UMYDoOgdfBBMFioPISZcWVrk0IVEk4qrYK+cEXib9cPmgavyOf
         olcA==
X-Gm-Message-State: AOJu0YycNme3J3MN1u7DKQXvJQa/PLsRJ4+P95tJw4lsIIPO4YZIEqVP
	sjmAQUgeDm2ZZTXNNc2BjNQzBXjLA3PoI2QFBt/zjg==
X-Google-Smtp-Source: AGHT+IFpgCL7yuKSADyIP0M20BfHJTHbdls++a16Uqh+lofBwkckf6dyPza0dHtCjCP0Xk56ybiascCGtYi2humnqAc=
X-Received: by 2002:a50:ef07:0:b0:54a:ee8b:7a99 with SMTP id
 m7-20020a50ef07000000b0054aee8b7a99mr36568eds.0.1701292380872; Wed, 29 Nov
 2023 13:13:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231126230740.2148636-1-kuba@kernel.org> <170118422773.21698.10391322196700008288.git-patchwork-notify@kernel.org>
 <ZWeamcTq9kv0oGd4@makrotopia.org>
In-Reply-To: <ZWeamcTq9kv0oGd4@makrotopia.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 29 Nov 2023 22:12:49 +0100
Message-ID: <CANn89i+srqtEAqaKv=b9xrevL7xPk8MwoMwmudzOshjf0nDxfw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 00/13] net: page_pool: add netlink-based introspection
To: Daniel Golle <daniel@makrotopia.org>
Cc: patchwork-bot+netdevbpf@kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	hawk@kernel.org, ilias.apalodimas@linaro.org, dsahern@gmail.com, 
	dtatulea@nvidia.com, willemb@google.com, almasrymina@google.com, 
	shakeelb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 9:10=E2=80=AFPM Daniel Golle <daniel@makrotopia.org=
> wrote:
>
> Hi Paolo,
>
> after the merge of this series to linux-next I'm seeing a new crash
> during boot.
> It can absolutely be that this is a bug in the Ethernet driver I'm
> working on though which only got exposed now. While I'm figuring it
> out I thought it'd still be good to let you know.
>
>
> [   15.626854] Unable to handle kernel access to user memory outside uacc=
ess routines at virtual address 0000000000000000
> [   15.637571] Mem abort info:
> [   15.640361]   ESR =3D 0x0000000096000045
> [   15.644115]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> [   15.649431]   SET =3D 0, FnV =3D 0
> [   15.652485]   EA =3D 0, S1PTW =3D 0
> [   15.655622]   FSC =3D 0x05: level 1 translation fault
> [   15.660494] Data abort info:
> [   15.663374]   ISV =3D 0, ISS =3D 0x00000045, ISS2 =3D 0x00000000
> [   15.668855]   CM =3D 0, WnR =3D 1, TnD =3D 0, TagAccess =3D 0
> [   15.673904]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
> [   15.679210] user pgtable: 4k pages, 39-bit VAs, pgdp=3D00000001055e600=
0
> [   15.685647] [0000000000000000] pgd=3D0800000105680003, p4d=3D080000010=
5680003, pud=3D0800000105680003, pmd=3D0000000000000000
> [   15.696265] Internal error: Oops: 0000000096000045 [#1] SMP
> [   15.701826] Modules linked in: option nft_fib_inet nf_flow_table_inet =
cdc_mbim wireguard usb_wwan qmi_wwan nft_reject_ipv6 nft_reject_ipv4 nft_re=
ject_inet nft_reject nft_redir nft_quota nft_numgen nft_nat nft_masq nft_lo=
g nft_limit nfs
> [   15.702009]  uas usb_storage leds_gpio xhci_plat_hcd xhci_pci xhci_mtk=
_hcd xhci_hcd usbcore usb_common mii
> [   15.801633] CPU: 0 PID: 3294 Comm: netifd Tainted: G           O      =
 6.7.0-rc3-next-20231129+ #0
> [   15.810579] Hardware name: Bananapi BPI-R4 (DT)
> [   15.815097] pstate: 00400005 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYP=
E=3D--)
> [   15.822047] pc : page_pool_unlist+0x40/0x74
> [   15.826227] lr : page_pool_unlist+0x38/0x74
> [   15.830400] sp : ffffffc0868639d0
> [   15.833703] x29: ffffffc0868639d0 x28: ffffff80c5e5c800 x27: 000000000=
0000000
> [   15.840829] x26: 0000000000000001 x25: ffffffc080bab958 x24: ffffffc08=
0a28f68
> [   15.847954] x23: ffffffc08071e61c x22: 0000000000000000 x21: 000000000=
0000000
> [   15.855078] x20: ffffffc080d48740 x19: ffffff80c199a800 x18: 000000000=
0000000
> [   15.862203] x17: ffffffc07eafc000 x16: ffffffc080000000 x15: 0000007fd=
42c1f68
> [   15.869328] x14: ffffff80c011c8c0 x13: 0123837901209924 x12: ffffff80c=
32e2cc0
> [   15.876453] x11: ffffff80c199d000 x10: 0000000000000002 x9 : 000000000=
0000001
> [   15.883577] x8 : 0000000000000238 x7 : 0000000000000000 x6 : 000000000=
0000000
> [   15.890702] x5 : 0000000000000000 x4 : ffffff80c06b86c8 x3 : 000000000=
0000000
> [   15.897826] x2 : 0000000000000000 x1 : ffffff80c199ae00 x0 : 000000000=
0000000
> [   15.904951] Call trace:
> [   15.907386]  page_pool_unlist+0x40/0x74
> [   15.911211]  page_pool_release+0x1f8/0x270
> [   15.915300]  page_pool_destroy+0xa4/0x160
> [   15.919300]  mtk_rx_clean+0x1a4/0x200
> [   15.922955]  mtk_dma_free+0x150/0x234
> [   15.926607]  mtk_stop+0x320/0x3b0
> [   15.929913]  __dev_close_many+0xb4/0x114
> [   15.933826]  __dev_change_flags+0x11c/0x18c
> [   15.938000]  dev_change_flags+0x20/0x64
> [   15.941827]  dev_ifsioc+0x204/0x4b8
> [   15.945307]  dev_ioctl+0x144/0x4b4
> [   15.948700]  sock_ioctl+0x1c8/0x44c
> [   15.952180]  __arm64_sys_ioctl+0x520/0xf78
> [   15.956268]  invoke_syscall.constprop.0+0x4c/0xdc
> [   15.960964]  do_el0_svc+0x3c/0xb8
> [   15.964269]  el0_svc+0x18/0x4c
> [   15.967315]  el0t_64_sync_handler+0xf8/0x124
> [   15.971575]  el0t_64_sync+0x150/0x154
> [   15.975229] Code: 9100e280 9409349f 91180261 a9430820 (f9000040)
> [   15.981310] ---[ end trace 0000000000000000 ]---
> [   15.987456] pstore: backend (ramoops) writing error (-28)
> [   15.992843] Kernel panic - not syncing: Oops: Fatal exception
> [   15.998576] SMP: stopping secondary CPUs
> [   16.002489] Kernel Offset: disabled
> [   16.005965] CPU features: 0x0,00000000,40000000,2100400b
> [   16.011264] Memory Limit: none
> [   16.015862] Rebooting in 3 seconds..
> PANIC at PC : 0x000000004300490c
>
>
> Cheers
>

Please look at the syzbot report

Proposed patch was :

diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
index 1426434a7e1587797da92f3199c0012559b51271..07becd4eceddcd4be9e5bea6479=
f8ffd16dac851
100644
--- a/net/core/page_pool_user.c
+++ b/net/core/page_pool_user.c
@@ -339,7 +339,8 @@ void page_pool_unlist(struct page_pool *pool)
        mutex_lock(&page_pools_lock);
        netdev_nl_page_pool_event(pool, NETDEV_CMD_PAGE_POOL_DEL_NTF);
        xa_erase(&page_pools, pool->user.id);
-       hlist_del(&pool->user.list);
+       if (!hlist_unhashed(&pool->user.list))
+               hlist_del(&pool->user.list);
        mutex_unlock(&page_pools_lock);
 }




>
> Daniel
>
>
>
> On Tue, Nov 28, 2023 at 03:10:27PM +0000, patchwork-bot+netdevbpf@kernel.=
org wrote:
> > Hello:
> >
> > This series was applied to netdev/net-next.git (main)
> > by Paolo Abeni <pabeni@redhat.com>:
> >
> > On Sun, 26 Nov 2023 15:07:27 -0800 you wrote:
> > > We recently started to deploy newer kernels / drivers at Meta,
> > > making significant use of page pools for the first time.
> > > We immediately run into page pool leaks both real and false positive
> > > warnings. As Eric pointed out/predicted there's no guarantee that
> > > applications will read / close their sockets so a page pool page
> > > may be stuck in a socket (but not leaked) forever. This happens
> > > a lot in our fleet. Most of these are obviously due to application
> > > bugs but we should not be printing kernel warnings due to minor
> > > application resource leaks.
> > >
> > > [...]
> >
> > Here is the summary with links:
> >   - [net-next,v4,01/13] net: page_pool: factor out uninit
> >     https://git.kernel.org/netdev/net-next/c/23cfaf67ba5d
> >   - [net-next,v4,02/13] net: page_pool: id the page pools
> >     https://git.kernel.org/netdev/net-next/c/f17c69649c69
> >   - [net-next,v4,03/13] net: page_pool: record pools per netdev
> >     https://git.kernel.org/netdev/net-next/c/083772c9f972
> >   - [net-next,v4,04/13] net: page_pool: stash the NAPI ID for easier ac=
cess
> >     https://git.kernel.org/netdev/net-next/c/02b3de80c5f8
> >   - [net-next,v4,05/13] eth: link netdev to page_pools in drivers
> >     https://git.kernel.org/netdev/net-next/c/7cc9e6d77f85
> >   - [net-next,v4,06/13] net: page_pool: add nlspec for basic access to =
page pools
> >     https://git.kernel.org/netdev/net-next/c/839ff60df3ab
> >   - [net-next,v4,07/13] net: page_pool: implement GET in the netlink AP=
I
> >     https://git.kernel.org/netdev/net-next/c/950ab53b77ab
> >   - [net-next,v4,08/13] net: page_pool: add netlink notifications for s=
tate changes
> >     https://git.kernel.org/netdev/net-next/c/d2ef6aa077bd
> >   - [net-next,v4,09/13] net: page_pool: report amount of memory held by=
 page pools
> >     https://git.kernel.org/netdev/net-next/c/7aee8429eedd
> >   - [net-next,v4,10/13] net: page_pool: report when page pool was destr=
oyed
> >     https://git.kernel.org/netdev/net-next/c/69cb4952b6f6
> >   - [net-next,v4,11/13] net: page_pool: expose page pool stats via netl=
ink
> >     https://git.kernel.org/netdev/net-next/c/d49010adae73
> >   - [net-next,v4,12/13] net: page_pool: mute the periodic warning for v=
isible page pools
> >     https://git.kernel.org/netdev/net-next/c/be0096676e23
> >   - [net-next,v4,13/13] tools: ynl: add sample for getting page-pool in=
formation
> >     https://git.kernel.org/netdev/net-next/c/637567e4a3ef
> >
> > You are awesome, thank you!
> > --
> > Deet-doot-dot, I am a bot.
> > https://korg.docs.kernel.org/patchwork/pwbot.html
> >
> >
> >

