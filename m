Return-Path: <netdev+bounces-37125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E837B3B3E
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 22:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 7B4AF281EC2
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 20:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3483C41E40;
	Fri, 29 Sep 2023 20:30:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9841566DFE
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 20:30:46 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59101AA
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 13:30:44 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5363227cc80so3471185a12.3
        for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 13:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696019443; x=1696624243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5p6ss+byANcIZ0xfw9ju2BJf5FjcNOKngvOcjk+MKk=;
        b=M/LK/qdAjwM1/OO7kzotAOyomcBuXGLmG5VCuhYwJtX3S5b+F6Wi1TKP8nBzAxFKbz
         pMVwM3de4cDF/ggU+xsi/CynRCzdmRCmTFfkeJ/Y/RTXNkyYvSwCsu1Gq06p06GWyJyc
         PR8+zuFbn6EZOWkq2GB0irrg+oEPRE/3Ydn4w/IF1vXDkWNaB2u7gfmPch+XRo9hO1r8
         hU2BWuMsBfe8gzQ4Ch2C+5Ai00vWpKN7knG0LZYKV5IvrRaScTP0xNS+JbMdZH9uAXSa
         v8HJN/wpijoMLDvg6WOq2zuoeR4JcyHDWNCEQsXUnC8F+1O27xmFboY5Us/Sl8tOQJ4a
         H68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696019443; x=1696624243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t5p6ss+byANcIZ0xfw9ju2BJf5FjcNOKngvOcjk+MKk=;
        b=m3FOyBgtmzcMWTVQfcxmxV1Bra2zFGG8ERIXN+5Uds3b+Wv8zjWOdA3b2N2QlLP86t
         cazPqWHX4o1gS6NqTZAuDhllKPUvpnm1THzYB/NIr70luEO1FeP/fCGxVnNjaXbLUwYJ
         nrqjThlGSX5zojgTpjQ9iRDgHMTHksYP1ww4BhviJFgfd1rP4Hzx0aE67R1FabkmDt3W
         4AycnE5xro30KUXnZk70ZW/BcCIrDo5UYmQ8Awdieu6nxQwC9uIy1XFvTyLYIflmj5yH
         Wz4wDBDpfAlLSz3dDAobtU356nintEpmx+teS8y88H3/wR8+Wsop1FokbnjTfKmwMxrK
         yKkA==
X-Gm-Message-State: AOJu0Yx5MeolPNAF+hCabaIszJijGt839gXs3rbzX46cYgdXYMzp/rRI
	3zsBSKH23Q60TjJDx/k107ZUy0310n6Z/J8bsek=
X-Google-Smtp-Source: AGHT+IEkd4hZEk7BCZ6qQ5+u9PclDsHqpPT5QZwNwHnjx6fj04T8PxtNUdGinwqUc1o72B7Sm3LPT+IotDMzMfldHhE=
X-Received: by 2002:aa7:d0d0:0:b0:530:c386:b277 with SMTP id
 u16-20020aa7d0d0000000b00530c386b277mr4935811edo.7.1696019442827; Fri, 29 Sep
 2023 13:30:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <74BF3CC8-2A3A-44FF-98C2-1E20F110A92E@gmail.com>
In-Reply-To: <74BF3CC8-2A3A-44FF-98C2-1E20F110A92E@gmail.com>
From: William Tu <u9012063@gmail.com>
Date: Fri, 29 Sep 2023 13:30:05 -0700
Message-ID: <CALDO+SZ_qmBv2AXD3xusEx1fb_PqSqTXVaBdhDTogpvDoKqRUw@mail.gmail.com>
Subject: Re: Vmxnet3 v22 - bug
To: Martin Zaharinov <micron10@gmail.com>
Cc: Alexander Duyck <alexanderduyck@fb.com>, alexandr.lobakin@intel.com, 
	netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 4, 2023 at 9:24=E2=80=AFAM Martin Zaharinov <micron10@gmail.com=
> wrote:
>
> Hi William Tu
>
>
> this is report of bug with latest version of vmxnet3 xdp support:
>
>
> [   92.417855] ------------[ cut here ]------------
> [   92.417855] XDP_WARN: xdp_update_frame_from_buff(line:278): Driver BUG=
: missing reserved tailroom
> [   92.417855] WARNING: CPU: 0 PID: 0 at net/core/xdp.c:586 xdp_warn+0xf/=
0x20
> [   92.417855] Modules linked in:  pppoe pppox ppp_generic slhc virtio_ne=
t net_failover failover virtio_pci virtio_pci_legacy_dev virtio_pci_modern_=
dev virtio virtio_ring vmxnet3
> [   92.417855] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W  O      =
 6.5.1 #1
> [   92.417855] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS r=
el-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
> [   92.417855] RIP: 0010:xdp_warn+0xf/0x20
> [   92.417855] Code: 00 00 c3 0f 1f 84 00 00 00 00 00 83 7f 0c 01 0f 94 c=
0 c3 0f 1f 84 00 00 00 00 00 48 89 f9 48 c7 c7 3d b2 e4 91 e8 d1 00 8e ff <=
0f> 0b c3 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 53 48 89 fb 8b
> [   92.417855] RSP: 0018:ffffb30180003d40 EFLAGS: 00010286
> [   92.417855] RAX: 0000000000000055 RBX: ffff99bcf7c22ee0 RCX: 00000000f=
ffdffff
> [   92.417855] RDX: 00000000fffdffff RSI: 0000000000000001 RDI: 00000000f=
fffffea
> [   92.417855] RBP: ffff99bb849c2000 R08: 0000000000000000 R09: 00000000f=
ffdffff
> [   92.417855] R10: ffff99bcf6a00000 R11: 0000000000000003 R12: ffff99bb8=
3840000
> [   92.417855] R13: ffff99bb83842780 R14: ffffb3018081d000 R15: ffff99bb8=
49c2000
> [   92.417855] FS:  0000000000000000(0000) GS:ffff99bcf7c00000(0000) knlG=
S:0000000000000000
> [   92.417855] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   92.417855] CR2: 00007f9bf822df88 CR3: 00000001a74de000 CR4: 000000000=
03506f0
> [   92.417855] Call Trace:
> [   92.417855]  <IRQ>
> [   92.417855]  ? __warn+0x6c/0x130
> [   92.417855]  ? report_bug+0x1e4/0x260
> [   92.417855]  ? handle_bug+0x36/0x70
> [   92.417855]  ? exc_invalid_op+0x17/0x1a0
> [   92.417855]  ? asm_exc_invalid_op+0x16/0x20
> [   92.417855]  ? xdp_warn+0xf/0x20
> [   92.417855]  xdp_do_redirect+0x15f/0x1c0
> [   92.417855]  vmxnet3_run_xdp+0x17a/0x400 [vmxnet3]
> [   92.417855]  vmxnet3_process_xdp+0xe4/0x760 [vmxnet3]
> [   92.417855]  ? vmxnet3_tq_tx_complete.isra.0+0x21e/0x2c0 [vmxnet3]
> [   92.417855]  vmxnet3_rq_rx_complete+0x7ad/0x1120 [vmxnet3]
> [   92.417855]  vmxnet3_poll_rx_only+0x2d/0xa0 [vmxnet3]
> [   92.417855]  __napi_poll+0x20/0x180
> [   92.417855]  net_rx_action+0x177/0x390
> [   92.417855]  __do_softirq+0xd0/0x202
> [   92.417855]  irq_exit_rcu+0x82/0xa0
> [   92.417855]  common_interrupt+0x7a/0xa0
> [   92.417855]  </IRQ>
> [   92.417855]  <TASK>
> [   92.417855]  asm_common_interrupt+0x22/0x40
> [   92.417855] RIP: 0010:default_idle+0xb/0x10
> [   92.417855] Code: 07 76 e7 48 89 07 49 c7 c0 08 00 00 00 4d 29 c8 4c 0=
1 c7 4c 29 c2 e9 72 ff ff ff cc cc cc cc eb 07 0f 00 2d 47 72 29 00 fb f4 <=
fa> c3 0f 1f 00 65 48 8b 04 25 00 33 02 00 f0 80 48 02 20 48 8b 10
> [   92.417855] RSP: 0018:ffffffff92003e88 EFLAGS: 00000206
> [   92.417855] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000000000=
0000001
> [   92.417855] RDX: 4000000000000000 RSI: 0000000000000083 RDI: 000000000=
00bfc34
> [   92.417855] RBP: ffffffff92009dc0 R08: ffff99bcf7c1f160 R09: ffff99bcf=
7c1f100
> [   92.417855] R10: ffff99bcf7c1f100 R11: 0000000000000000 R12: 000000000=
0000000
> [   92.417855] R13: 0000000000000000 R14: ffffffff92009dc0 R15: 000000000=
0000000
> [   92.417855]  default_idle_call+0x1f/0x30
> [   92.417855]  do_idle+0x1df/0x210
> [   92.417855]  cpu_startup_entry+0x14/0x20
> [   92.417855]  rest_init+0xc7/0xd0
> [   92.417855]  arch_call_rest_init+0x5/0x20
> [   92.417855]  start_kernel+0x3e9/0x5b0
> [   92.417855]  x86_64_start_reservations+0x14/0x30
> [   92.417855]  x86_64_start_kernel+0x71/0x80
> [   92.417855]  secondary_startup_64_no_verify+0x167/0x16b
> [   92.417855]  </TASK>
> [   92.417855] ---[ end trace 0000000000000000 ]=E2=80=94
>
>
Hi Martin,

Thanks, I'll take a look.
William

