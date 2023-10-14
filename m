Return-Path: <netdev+bounces-40996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E97077C94CE
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 15:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FE391C209B2
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 13:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F284312B75;
	Sat, 14 Oct 2023 13:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="muXq1+K6"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5699C12B60
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 13:54:41 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0FEB3
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 06:54:39 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-405361bb94eso35339835e9.0
        for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 06:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697291678; x=1697896478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1SuOOAxunTJUTPiukJW+9H8IuxRehPEqici0R4t6vQk=;
        b=muXq1+K63SPo6fDe+R/zCzE3NzSBY2+lbGXX4gED91cb9strDvqFRrZqxWVMEzNrl5
         OsGgCDJVMpTZqrnmPoG3qEn1WGvO2Jknnhlcr0vrE7BZLUBaDAR2g5XkK7c0fEyJvBsP
         C7WX3P9XMw5aKNvBdkr2B/sG/o0wm/DIiAYdJw/U7USsk5ML2Zn+f9CkIUzBpNfZA4py
         LC3i3TEmP+9q2e4sKdVr04MkwpVfFS5VvgpT8Al/2rXrWbJ5UL6tQlY618u3zI9hnV2n
         FNL4BCZOXOCrm6r9kQIzM9o/CCdUpDh0jAFaZFlKonBnP81fQbhRnOmLcrrsTRIoZ+P5
         lWnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697291678; x=1697896478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1SuOOAxunTJUTPiukJW+9H8IuxRehPEqici0R4t6vQk=;
        b=Y8fVQQ38YEdcuWEy0CKtgoKpQS6R2g6LjFMXWmKIgRRdWau0m29yhSoM9vLbrsNGCz
         GW8HcD+8uewd7FyeF2aSONjUbRwIS4lUZpAXPjUHjcg52Hwp4ZuF+g0Av4I52lEipId7
         bqHeQrF9ryLN5PprnuC51FbBfX6PcCKCyhomAXRsIfb5sY3eAFs8RFQZ/7k6K+B33Erk
         qa3A4tJ6XkNzrCY4eEEimdct1nD31XVPIPp7/ipvdidE/9/e2Up8oZQDFjfBvnDc1H44
         pBfXU1fQiAcMqknAqoqwLf48ISqgkOCyPxbiOmvWZYrUOK754u2bSh/SCbSKF9tpDGI7
         CYCg==
X-Gm-Message-State: AOJu0Yxwei2jQ0T9FNoCzb5fUt4+ts066V/+q9p5q1GfasH4Xc5Gz9WL
	Ce1+1Z4amcFg6UaVLBKImv+1Bc1StCy2HP3VUFuyFCtr
X-Google-Smtp-Source: AGHT+IFwcnUxk2BkCTm31AYxv/9Pb6CW8AKEfGMzKwmv2BL5IRjst2iRY2bfNrGsABq4PcMG/Iih7THwzsXhupzuI3w=
X-Received: by 2002:adf:f84e:0:b0:324:8353:6e51 with SMTP id
 d14-20020adff84e000000b0032483536e51mr27212687wrq.45.1697291677776; Sat, 14
 Oct 2023 06:54:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <74BF3CC8-2A3A-44FF-98C2-1E20F110A92E@gmail.com>
 <CALDO+SZ_qmBv2AXD3xusEx1fb_PqSqTXVaBdhDTogpvDoKqRUw@mail.gmail.com>
 <CALDO+SanaY3dO8-1sjgZBH0NdGNhsBErLOSYC8ZKT3kVPpkFBQ@mail.gmail.com> <42F24D1E-E60D-49C6-935D-BB5E1E7290CC@gmail.com>
In-Reply-To: <42F24D1E-E60D-49C6-935D-BB5E1E7290CC@gmail.com>
From: William Tu <u9012063@gmail.com>
Date: Sat, 14 Oct 2023 06:53:59 -0700
Message-ID: <CALDO+SZxsxGUWyD4QATT-cswRf_ztL_5+FOy3egDSNwwn4WC4A@mail.gmail.com>
Subject: Re: Vmxnet3 v22 - bug
To: Martin Zaharinov <micron10@gmail.com>
Cc: Alexander Duyck <alexanderduyck@fb.com>, alexandr.lobakin@intel.com, 
	netdev <netdev@vger.kernel.org>, Sankararaman Jayaraman <jsankararama@vmware.com>, doshir@vmware.com, 
	Boon Ang <bang@vmware.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Martin,
Does everything work ok, do you find more issue?
Otherwise I can send out patch to netdev, thanks!
William

On Wed, Oct 4, 2023 at 1:33=E2=80=AFAM Martin Zaharinov <micron10@gmail.com=
> wrote:
>
> Hi William,
>
> Yes this patch fix problem ,
>
> i will make little test if see any problem will update you.
>
> Thanks for your great work!
>
> Martin
>
> > On 30 Sep 2023, at 20:03, William Tu <u9012063@gmail.com> wrote:
> >
> > On Fri, Sep 29, 2023 at 1:30=E2=80=AFPM William Tu <u9012063@gmail.com>=
 wrote:
> >>
> >> On Mon, Sep 4, 2023 at 9:24=E2=80=AFAM Martin Zaharinov <micron10@gmai=
l.com> wrote:
> >>>
> >>> Hi William Tu
> >>>
> >>>
> >>> this is report of bug with latest version of vmxnet3 xdp support:
> >>>
> >>>
> >>> [   92.417855] ------------[ cut here ]------------
> >>> [   92.417855] XDP_WARN: xdp_update_frame_from_buff(line:278): Driver=
 BUG: missing reserved tailroom
> >>> [   92.417855] WARNING: CPU: 0 PID: 0 at net/core/xdp.c:586 xdp_warn+=
0xf/0x20
> >>> [   92.417855] Modules linked in:  pppoe pppox ppp_generic slhc virti=
o_net net_failover failover virtio_pci virtio_pci_legacy_dev virtio_pci_mod=
ern_dev virtio virtio_ring vmxnet3
> >>> [   92.417855] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W  O  =
     6.5.1 #1
> >>> [   92.417855] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BI=
OS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
> >>> [   92.417855] RIP: 0010:xdp_warn+0xf/0x20
> >>> [   92.417855] Code: 00 00 c3 0f 1f 84 00 00 00 00 00 83 7f 0c 01 0f =
94 c0 c3 0f 1f 84 00 00 00 00 00 48 89 f9 48 c7 c7 3d b2 e4 91 e8 d1 00 8e =
ff <0f> 0b c3 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 53 48 89 fb 8b
> >>> [   92.417855] RSP: 0018:ffffb30180003d40 EFLAGS: 00010286
> >>> [   92.417855] RAX: 0000000000000055 RBX: ffff99bcf7c22ee0 RCX: 00000=
000fffdffff
> >>> [   92.417855] RDX: 00000000fffdffff RSI: 0000000000000001 RDI: 00000=
000ffffffea
> >>> [   92.417855] RBP: ffff99bb849c2000 R08: 0000000000000000 R09: 00000=
000fffdffff
> >>> [   92.417855] R10: ffff99bcf6a00000 R11: 0000000000000003 R12: ffff9=
9bb83840000
> >>> [   92.417855] R13: ffff99bb83842780 R14: ffffb3018081d000 R15: ffff9=
9bb849c2000
> >>> [   92.417855] FS:  0000000000000000(0000) GS:ffff99bcf7c00000(0000) =
knlGS:0000000000000000
> >>> [   92.417855] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>> [   92.417855] CR2: 00007f9bf822df88 CR3: 00000001a74de000 CR4: 00000=
000003506f0
> >>> [   92.417855] Call Trace:
> >>> [   92.417855]  <IRQ>
> >>> [   92.417855]  ? __warn+0x6c/0x130
> >>> [   92.417855]  ? report_bug+0x1e4/0x260
> >>> [   92.417855]  ? handle_bug+0x36/0x70
> >>> [   92.417855]  ? exc_invalid_op+0x17/0x1a0
> >>> [   92.417855]  ? asm_exc_invalid_op+0x16/0x20
> >>> [   92.417855]  ? xdp_warn+0xf/0x20
> >>> [   92.417855]  xdp_do_redirect+0x15f/0x1c0
> >>> [   92.417855]  vmxnet3_run_xdp+0x17a/0x400 [vmxnet3]
> >>> [   92.417855]  vmxnet3_process_xdp+0xe4/0x760 [vmxnet3]
> >>> [   92.417855]  ? vmxnet3_tq_tx_complete.isra.0+0x21e/0x2c0 [vmxnet3]
> >>> [   92.417855]  vmxnet3_rq_rx_complete+0x7ad/0x1120 [vmxnet3]
> >>> [   92.417855]  vmxnet3_poll_rx_only+0x2d/0xa0 [vmxnet3]
> >>> [   92.417855]  __napi_poll+0x20/0x180
> >>> [   92.417855]  net_rx_action+0x177/0x390
> >>> [   92.417855]  __do_softirq+0xd0/0x202
> >>> [   92.417855]  irq_exit_rcu+0x82/0xa0
> >>> [   92.417855]  common_interrupt+0x7a/0xa0
> >>> [   92.417855]  </IRQ>
> >>> [   92.417855]  <TASK>
> >>> [   92.417855]  asm_common_interrupt+0x22/0x40
> >>> [   92.417855] RIP: 0010:default_idle+0xb/0x10
> >>> [   92.417855] Code: 07 76 e7 48 89 07 49 c7 c0 08 00 00 00 4d 29 c8 =
4c 01 c7 4c 29 c2 e9 72 ff ff ff cc cc cc cc eb 07 0f 00 2d 47 72 29 00 fb =
f4 <fa> c3 0f 1f 00 65 48 8b 04 25 00 33 02 00 f0 80 48 02 20 48 8b 10
> >>> [   92.417855] RSP: 0018:ffffffff92003e88 EFLAGS: 00000206
> >>> [   92.417855] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000=
00000000001
> >>> [   92.417855] RDX: 4000000000000000 RSI: 0000000000000083 RDI: 00000=
000000bfc34
> >>> [   92.417855] RBP: ffffffff92009dc0 R08: ffff99bcf7c1f160 R09: ffff9=
9bcf7c1f100
> >>> [   92.417855] R10: ffff99bcf7c1f100 R11: 0000000000000000 R12: 00000=
00000000000
> >>> [   92.417855] R13: 0000000000000000 R14: ffffffff92009dc0 R15: 00000=
00000000000
> >>> [   92.417855]  default_idle_call+0x1f/0x30
> >>> [   92.417855]  do_idle+0x1df/0x210
> >>> [   92.417855]  cpu_startup_entry+0x14/0x20
> >>> [   92.417855]  rest_init+0xc7/0xd0
> >>> [   92.417855]  arch_call_rest_init+0x5/0x20
> >>> [   92.417855]  start_kernel+0x3e9/0x5b0
> >>> [   92.417855]  x86_64_start_reservations+0x14/0x30
> >>> [   92.417855]  x86_64_start_kernel+0x71/0x80
> >>> [   92.417855]  secondary_startup_64_no_verify+0x167/0x16b
> >>> [   92.417855]  </TASK>
> >>> [   92.417855] ---[ end trace 0000000000000000 ]=E2=80=94
> >>>
> >>>
> >> Hi Martin,
> >>
> >> Thanks, I'll take a look.
> >> William
> >
> > Hi Martin,
> > For non-dataring packet, I should use rbi->len instead of rcd->len.
> > Are you able to see if this fixes the bug?
> > thanks!
> >
> > diff --git a/drivers/net/vmxnet3/vmxnet3_xdp.c
> > b/drivers/net/vmxnet3/vmxnet3_xdp.c
> > index 80ddaff759d4..a6c787454a1a 100644
> > --- a/drivers/net/vmxnet3/vmxnet3_xdp.c
> > +++ b/drivers/net/vmxnet3/vmxnet3_xdp.c
> > @@ -382,12 +382,12 @@ vmxnet3_process_xdp(struct vmxnet3_adapter *adapt=
er,
> >        page =3D rbi->page;
> >        dma_sync_single_for_cpu(&adapter->pdev->dev,
> >                                page_pool_get_dma_addr(page) +
> > -                               rq->page_pool->p.offset, rcd->len,
> > +                               rq->page_pool->p.offset, rbi->len,
> >                                page_pool_get_dma_dir(rq->page_pool));
> >
> > -       xdp_init_buff(&xdp, rbi->len, &rq->xdp_rxq);
> > +       xdp_init_buff(&xdp, PAGE_SIZE, &rq->xdp_rxq);
> >        xdp_prepare_buff(&xdp, page_address(page), rq->page_pool->p.offs=
et,
> > -                        rcd->len, false);
> > +                        rbi->len, false);
> >        xdp_buff_clear_frags_flag(&xdp);
> >
> >        xdp_prog =3D rcu_dereference(rq->adapter->xdp_bpf_prog);
>

