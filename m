Return-Path: <netdev+bounces-37192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DB67B4276
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 19:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 575F9282E9D
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 17:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C7518035;
	Sat, 30 Sep 2023 17:04:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76993C2CA
	for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 17:04:07 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24C8E3
	for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 10:04:04 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-536b39daec1so3429892a12.2
        for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 10:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696093443; x=1696698243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q+gRvbY1PqyDzyt2gQdZPCNNC70X566NvyHMyduYC1w=;
        b=a9WzeY2CgnMX2MVHcv/O0Kevoi2NQHQEiojSe6yrS1fVKQc/b0T9rF27Lh5rREQgHp
         tPDUvoqG4tWDw59ge4MKje2UVzDORGpciSh0ijgZ0njXCVAyk7QTK0cauq+Rv1bQ2jgG
         Oon9QN9q0G503iihV3xGrxjGKEr6PA5PdS8QwLuOmCMhEYTNuC6bvezCr2CFmM+oxqgd
         ynqkT9nPL6mYSSr4pd9ViTl+dOsVURBdTYYNsz2XVEDGJRu7tzIjUyIetUOI9IJLlXz6
         pbavexCJmMrv1ZiX3txCtyieITHgbXq+WXXrC0Ih8p1QxFz+KCu+s7wBX3L/SvYIkgVD
         MC8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696093443; x=1696698243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q+gRvbY1PqyDzyt2gQdZPCNNC70X566NvyHMyduYC1w=;
        b=CACPbKAQzVTCNF7cYXnE8AKmpuseMM/QjpzRzJm22+1tQmkg+TKbxANEqohlmpEEle
         QJchZVpIt+9IU3oTBIMXe1GFMwVDbOxnXxp2wdsA4inWdRa8pcEOJvmpqJr+jZHpYQzL
         kNsCMybGF6bNMtEESL8GGW5E5+vxZDnpl6YqWHepQBsAosEv20x65THPNuYq5TxAnGB8
         7NMTP3KP3Fz2Zog49YXQjuoPP27bpQdN8MRWlf+av2X8uUXf+UBPSyD6wUxCWvO+bHXt
         Ca03pRhqDG+52uVlbabqoRs6ynOHHD+8VQQGn0Nx75CaRNmkBXOXqJ2Z5JMdYakM8U1b
         R2ow==
X-Gm-Message-State: AOJu0YwJlIou3IK/O2gBlxodoBI7XJoDNL7sopSoQb/DiRbaZ0H2v1/Q
	weVEWG6ZvTF596z58L4IjajKTK4dyUtdm62YKPk=
X-Google-Smtp-Source: AGHT+IEaFTekjOBYoex4cNOwMujiLdKOmqa9i8CabKoa99Ap8ue1i+jcJYnhG7Tc+j/mhS3Vb8Xgjq2zQDJhIbCaC7I=
X-Received: by 2002:a05:6402:1ac9:b0:525:469a:fc49 with SMTP id
 ba9-20020a0564021ac900b00525469afc49mr6000599edb.17.1696093442954; Sat, 30
 Sep 2023 10:04:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <74BF3CC8-2A3A-44FF-98C2-1E20F110A92E@gmail.com> <CALDO+SZ_qmBv2AXD3xusEx1fb_PqSqTXVaBdhDTogpvDoKqRUw@mail.gmail.com>
In-Reply-To: <CALDO+SZ_qmBv2AXD3xusEx1fb_PqSqTXVaBdhDTogpvDoKqRUw@mail.gmail.com>
From: William Tu <u9012063@gmail.com>
Date: Sat, 30 Sep 2023 10:03:25 -0700
Message-ID: <CALDO+SanaY3dO8-1sjgZBH0NdGNhsBErLOSYC8ZKT3kVPpkFBQ@mail.gmail.com>
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

On Fri, Sep 29, 2023 at 1:30=E2=80=AFPM William Tu <u9012063@gmail.com> wro=
te:
>
> On Mon, Sep 4, 2023 at 9:24=E2=80=AFAM Martin Zaharinov <micron10@gmail.c=
om> wrote:
> >
> > Hi William Tu
> >
> >
> > this is report of bug with latest version of vmxnet3 xdp support:
> >
> >
> > [   92.417855] ------------[ cut here ]------------
> > [   92.417855] XDP_WARN: xdp_update_frame_from_buff(line:278): Driver B=
UG: missing reserved tailroom
> > [   92.417855] WARNING: CPU: 0 PID: 0 at net/core/xdp.c:586 xdp_warn+0x=
f/0x20
> > [   92.417855] Modules linked in:  pppoe pppox ppp_generic slhc virtio_=
net net_failover failover virtio_pci virtio_pci_legacy_dev virtio_pci_moder=
n_dev virtio virtio_ring vmxnet3
> > [   92.417855] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W  O    =
   6.5.1 #1
> > [   92.417855] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS=
 rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
> > [   92.417855] RIP: 0010:xdp_warn+0xf/0x20
> > [   92.417855] Code: 00 00 c3 0f 1f 84 00 00 00 00 00 83 7f 0c 01 0f 94=
 c0 c3 0f 1f 84 00 00 00 00 00 48 89 f9 48 c7 c7 3d b2 e4 91 e8 d1 00 8e ff=
 <0f> 0b c3 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 53 48 89 fb 8b
> > [   92.417855] RSP: 0018:ffffb30180003d40 EFLAGS: 00010286
> > [   92.417855] RAX: 0000000000000055 RBX: ffff99bcf7c22ee0 RCX: 0000000=
0fffdffff
> > [   92.417855] RDX: 00000000fffdffff RSI: 0000000000000001 RDI: 0000000=
0ffffffea
> > [   92.417855] RBP: ffff99bb849c2000 R08: 0000000000000000 R09: 0000000=
0fffdffff
> > [   92.417855] R10: ffff99bcf6a00000 R11: 0000000000000003 R12: ffff99b=
b83840000
> > [   92.417855] R13: ffff99bb83842780 R14: ffffb3018081d000 R15: ffff99b=
b849c2000
> > [   92.417855] FS:  0000000000000000(0000) GS:ffff99bcf7c00000(0000) kn=
lGS:0000000000000000
> > [   92.417855] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   92.417855] CR2: 00007f9bf822df88 CR3: 00000001a74de000 CR4: 0000000=
0003506f0
> > [   92.417855] Call Trace:
> > [   92.417855]  <IRQ>
> > [   92.417855]  ? __warn+0x6c/0x130
> > [   92.417855]  ? report_bug+0x1e4/0x260
> > [   92.417855]  ? handle_bug+0x36/0x70
> > [   92.417855]  ? exc_invalid_op+0x17/0x1a0
> > [   92.417855]  ? asm_exc_invalid_op+0x16/0x20
> > [   92.417855]  ? xdp_warn+0xf/0x20
> > [   92.417855]  xdp_do_redirect+0x15f/0x1c0
> > [   92.417855]  vmxnet3_run_xdp+0x17a/0x400 [vmxnet3]
> > [   92.417855]  vmxnet3_process_xdp+0xe4/0x760 [vmxnet3]
> > [   92.417855]  ? vmxnet3_tq_tx_complete.isra.0+0x21e/0x2c0 [vmxnet3]
> > [   92.417855]  vmxnet3_rq_rx_complete+0x7ad/0x1120 [vmxnet3]
> > [   92.417855]  vmxnet3_poll_rx_only+0x2d/0xa0 [vmxnet3]
> > [   92.417855]  __napi_poll+0x20/0x180
> > [   92.417855]  net_rx_action+0x177/0x390
> > [   92.417855]  __do_softirq+0xd0/0x202
> > [   92.417855]  irq_exit_rcu+0x82/0xa0
> > [   92.417855]  common_interrupt+0x7a/0xa0
> > [   92.417855]  </IRQ>
> > [   92.417855]  <TASK>
> > [   92.417855]  asm_common_interrupt+0x22/0x40
> > [   92.417855] RIP: 0010:default_idle+0xb/0x10
> > [   92.417855] Code: 07 76 e7 48 89 07 49 c7 c0 08 00 00 00 4d 29 c8 4c=
 01 c7 4c 29 c2 e9 72 ff ff ff cc cc cc cc eb 07 0f 00 2d 47 72 29 00 fb f4=
 <fa> c3 0f 1f 00 65 48 8b 04 25 00 33 02 00 f0 80 48 02 20 48 8b 10
> > [   92.417855] RSP: 0018:ffffffff92003e88 EFLAGS: 00000206
> > [   92.417855] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000=
000000001
> > [   92.417855] RDX: 4000000000000000 RSI: 0000000000000083 RDI: 0000000=
0000bfc34
> > [   92.417855] RBP: ffffffff92009dc0 R08: ffff99bcf7c1f160 R09: ffff99b=
cf7c1f100
> > [   92.417855] R10: ffff99bcf7c1f100 R11: 0000000000000000 R12: 0000000=
000000000
> > [   92.417855] R13: 0000000000000000 R14: ffffffff92009dc0 R15: 0000000=
000000000
> > [   92.417855]  default_idle_call+0x1f/0x30
> > [   92.417855]  do_idle+0x1df/0x210
> > [   92.417855]  cpu_startup_entry+0x14/0x20
> > [   92.417855]  rest_init+0xc7/0xd0
> > [   92.417855]  arch_call_rest_init+0x5/0x20
> > [   92.417855]  start_kernel+0x3e9/0x5b0
> > [   92.417855]  x86_64_start_reservations+0x14/0x30
> > [   92.417855]  x86_64_start_kernel+0x71/0x80
> > [   92.417855]  secondary_startup_64_no_verify+0x167/0x16b
> > [   92.417855]  </TASK>
> > [   92.417855] ---[ end trace 0000000000000000 ]=E2=80=94
> >
> >
> Hi Martin,
>
> Thanks, I'll take a look.
> William

Hi Martin,
For non-dataring packet, I should use rbi->len instead of rcd->len.
Are you able to see if this fixes the bug?
thanks!

diff --git a/drivers/net/vmxnet3/vmxnet3_xdp.c
b/drivers/net/vmxnet3/vmxnet3_xdp.c
index 80ddaff759d4..a6c787454a1a 100644
--- a/drivers/net/vmxnet3/vmxnet3_xdp.c
+++ b/drivers/net/vmxnet3/vmxnet3_xdp.c
@@ -382,12 +382,12 @@ vmxnet3_process_xdp(struct vmxnet3_adapter *adapter,
        page =3D rbi->page;
        dma_sync_single_for_cpu(&adapter->pdev->dev,
                                page_pool_get_dma_addr(page) +
-                               rq->page_pool->p.offset, rcd->len,
+                               rq->page_pool->p.offset, rbi->len,
                                page_pool_get_dma_dir(rq->page_pool));

-       xdp_init_buff(&xdp, rbi->len, &rq->xdp_rxq);
+       xdp_init_buff(&xdp, PAGE_SIZE, &rq->xdp_rxq);
        xdp_prepare_buff(&xdp, page_address(page), rq->page_pool->p.offset,
-                        rcd->len, false);
+                        rbi->len, false);
        xdp_buff_clear_frags_flag(&xdp);

        xdp_prog =3D rcu_dereference(rq->adapter->xdp_bpf_prog);

