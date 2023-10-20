Return-Path: <netdev+bounces-43106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCC27D16D1
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 22:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E18BB2825F4
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 20:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2F1249E3;
	Fri, 20 Oct 2023 20:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCBgJw4S"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9C41E530
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 20:14:10 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04D5D63
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 13:14:08 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so4859789a12.1
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 13:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697832847; x=1698437647; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZrD7dNsNZ9jme2mIBsxoCQsCyn+0WyOyjNgBFgT33Yg=;
        b=WCBgJw4SwfdMuAhJCXH4wnJMM6pzu7IBvZKGRoQVWZPYdFxQ5+K39dRJNWYRj2eS8e
         YDrtmdOo7W/8//yXvfRAcjkuWzI0o0ZQr3Nt/K8aUI4m0qs3zQ9IH8dHIhNcbzLA5xAo
         ncO6Jb9m5XvYkB6HaAuKWVULt7VoWHyR5ylCGng0ZuSa0hc1WiIbDZyd83VE6Nuae2T8
         cSwk8bEKxWEDT2AS9o21vYOjYeReJyPWgY30yzpVgKxzX2+u5xXgVpjHdzFbUkSsSNLk
         M4wxmZMIiUsRgETHr0O+itqThUzVNqsy1OQOz0ZVD5Eyd7KUeB0zCeZN92vD2ye8oal4
         sHMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697832847; x=1698437647;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZrD7dNsNZ9jme2mIBsxoCQsCyn+0WyOyjNgBFgT33Yg=;
        b=VdbobVvlICrWWPHLaN+vSQdP+J9T+hAooM3brXCEJm/rX3tfpZ2kPkCGLng7qtdHWj
         9/jCh9yveyIwTYeTEEARCtp+2D9TWIt7hHfYivKyD5cU1OxC6jjo0nDLxInGHGnue//+
         bj3/V3nKQd/J//20FtrKKK8eDXiRhmfQsR2wPggB5mRcCMoo0G/lafU9mb4kJOGaq53P
         hdaulVSOjHS9XoT5MBRcz7xav+Xcd/Lzl4/lT4KlEmzgexWVADrQK6oorNvuv0riwuin
         pLnPq2h29Wea3cfq0pl2UAw8m4qf+Wa4JDGI9i2PC2XJZQq3Hxhz7Vj6jEUTWhCjrSE+
         MRjg==
X-Gm-Message-State: AOJu0Ywc4J4IiCZdArp1c3A0Li4KHmEsSSrPKuIaynnD4fMngzTm5aVG
	H2dQ4lAaXruOkE0LMQ6OBx4=
X-Google-Smtp-Source: AGHT+IGei8MukdHbRNr9dgS9RyVuZmzQEC+zZpL6CQZGYpAIzxDKdH9STYtyFXZwMU0cMn54WjsTIQ==
X-Received: by 2002:a50:9fae:0:b0:53e:2aab:14f3 with SMTP id c43-20020a509fae000000b0053e2aab14f3mr2288880edf.17.1697832847111;
        Fri, 20 Oct 2023 13:14:07 -0700 (PDT)
Received: from smtpclient.apple ([178.254.237.20])
        by smtp.gmail.com with ESMTPSA id y90-20020a50bb63000000b0053e8bb112adsm2084524ede.53.2023.10.20.13.14.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Oct 2023 13:14:06 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.100.2.1.4\))
Subject: Re: Vmxnet3 v22 - bug
From: Martin Zaharinov <micron10@gmail.com>
In-Reply-To: <CALDO+SZxsxGUWyD4QATT-cswRf_ztL_5+FOy3egDSNwwn4WC4A@mail.gmail.com>
Date: Fri, 20 Oct 2023 23:13:55 +0300
Cc: Alexander Duyck <alexanderduyck@fb.com>,
 alexandr.lobakin@intel.com,
 netdev <netdev@vger.kernel.org>,
 Sankararaman Jayaraman <jsankararama@vmware.com>,
 doshir@vmware.com,
 Boon Ang <bang@vmware.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <ED28CCE4-EFBA-4EBB-8278-1032588C8B57@gmail.com>
References: <74BF3CC8-2A3A-44FF-98C2-1E20F110A92E@gmail.com>
 <CALDO+SZ_qmBv2AXD3xusEx1fb_PqSqTXVaBdhDTogpvDoKqRUw@mail.gmail.com>
 <CALDO+SanaY3dO8-1sjgZBH0NdGNhsBErLOSYC8ZKT3kVPpkFBQ@mail.gmail.com>
 <42F24D1E-E60D-49C6-935D-BB5E1E7290CC@gmail.com>
 <CALDO+SZxsxGUWyD4QATT-cswRf_ztL_5+FOy3egDSNwwn4WC4A@mail.gmail.com>
To: William Tu <u9012063@gmail.com>
X-Mailer: Apple Mail (2.3774.100.2.1.4)

Hi William,

Big sorry for delay,
all work for now and don=E2=80=99t see any error.
its ok to commit.


If i see any other error i will update you .

Thanks for you great work.

Best regrads,
Martin

> On 14 Oct 2023, at 16:53, William Tu <u9012063@gmail.com> wrote:
>=20
> Hi Martin,
> Does everything work ok, do you find more issue?
> Otherwise I can send out patch to netdev, thanks!
> William
>=20
> On Wed, Oct 4, 2023 at 1:33=E2=80=AFAM Martin Zaharinov =
<micron10@gmail.com> wrote:
>>=20
>> Hi William,
>>=20
>> Yes this patch fix problem ,
>>=20
>> i will make little test if see any problem will update you.
>>=20
>> Thanks for your great work!
>>=20
>> Martin
>>=20
>>> On 30 Sep 2023, at 20:03, William Tu <u9012063@gmail.com> wrote:
>>>=20
>>> On Fri, Sep 29, 2023 at 1:30=E2=80=AFPM William Tu =
<u9012063@gmail.com> wrote:
>>>>=20
>>>> On Mon, Sep 4, 2023 at 9:24=E2=80=AFAM Martin Zaharinov =
<micron10@gmail.com> wrote:
>>>>>=20
>>>>> Hi William Tu
>>>>>=20
>>>>>=20
>>>>> this is report of bug with latest version of vmxnet3 xdp support:
>>>>>=20
>>>>>=20
>>>>> [   92.417855] ------------[ cut here ]------------
>>>>> [   92.417855] XDP_WARN: xdp_update_frame_from_buff(line:278): =
Driver BUG: missing reserved tailroom
>>>>> [   92.417855] WARNING: CPU: 0 PID: 0 at net/core/xdp.c:586 =
xdp_warn+0xf/0x20
>>>>> [   92.417855] Modules linked in:  pppoe pppox ppp_generic slhc =
virtio_net net_failover failover virtio_pci virtio_pci_legacy_dev =
virtio_pci_modern_dev virtio virtio_ring vmxnet3
>>>>> [   92.417855] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W  =
O       6.5.1 #1
>>>>> [   92.417855] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), =
BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
>>>>> [   92.417855] RIP: 0010:xdp_warn+0xf/0x20
>>>>> [   92.417855] Code: 00 00 c3 0f 1f 84 00 00 00 00 00 83 7f 0c 01 =
0f 94 c0 c3 0f 1f 84 00 00 00 00 00 48 89 f9 48 c7 c7 3d b2 e4 91 e8 d1 =
00 8e ff <0f> 0b c3 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 53 48 89 =
fb 8b
>>>>> [   92.417855] RSP: 0018:ffffb30180003d40 EFLAGS: 00010286
>>>>> [   92.417855] RAX: 0000000000000055 RBX: ffff99bcf7c22ee0 RCX: =
00000000fffdffff
>>>>> [   92.417855] RDX: 00000000fffdffff RSI: 0000000000000001 RDI: =
00000000ffffffea
>>>>> [   92.417855] RBP: ffff99bb849c2000 R08: 0000000000000000 R09: =
00000000fffdffff
>>>>> [   92.417855] R10: ffff99bcf6a00000 R11: 0000000000000003 R12: =
ffff99bb83840000
>>>>> [   92.417855] R13: ffff99bb83842780 R14: ffffb3018081d000 R15: =
ffff99bb849c2000
>>>>> [   92.417855] FS:  0000000000000000(0000) =
GS:ffff99bcf7c00000(0000) knlGS:0000000000000000
>>>>> [   92.417855] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>> [   92.417855] CR2: 00007f9bf822df88 CR3: 00000001a74de000 CR4: =
00000000003506f0
>>>>> [   92.417855] Call Trace:
>>>>> [   92.417855]  <IRQ>
>>>>> [   92.417855]  ? __warn+0x6c/0x130
>>>>> [   92.417855]  ? report_bug+0x1e4/0x260
>>>>> [   92.417855]  ? handle_bug+0x36/0x70
>>>>> [   92.417855]  ? exc_invalid_op+0x17/0x1a0
>>>>> [   92.417855]  ? asm_exc_invalid_op+0x16/0x20
>>>>> [   92.417855]  ? xdp_warn+0xf/0x20
>>>>> [   92.417855]  xdp_do_redirect+0x15f/0x1c0
>>>>> [   92.417855]  vmxnet3_run_xdp+0x17a/0x400 [vmxnet3]
>>>>> [   92.417855]  vmxnet3_process_xdp+0xe4/0x760 [vmxnet3]
>>>>> [   92.417855]  ? vmxnet3_tq_tx_complete.isra.0+0x21e/0x2c0 =
[vmxnet3]
>>>>> [   92.417855]  vmxnet3_rq_rx_complete+0x7ad/0x1120 [vmxnet3]
>>>>> [   92.417855]  vmxnet3_poll_rx_only+0x2d/0xa0 [vmxnet3]
>>>>> [   92.417855]  __napi_poll+0x20/0x180
>>>>> [   92.417855]  net_rx_action+0x177/0x390
>>>>> [   92.417855]  __do_softirq+0xd0/0x202
>>>>> [   92.417855]  irq_exit_rcu+0x82/0xa0
>>>>> [   92.417855]  common_interrupt+0x7a/0xa0
>>>>> [   92.417855]  </IRQ>
>>>>> [   92.417855]  <TASK>
>>>>> [   92.417855]  asm_common_interrupt+0x22/0x40
>>>>> [   92.417855] RIP: 0010:default_idle+0xb/0x10
>>>>> [   92.417855] Code: 07 76 e7 48 89 07 49 c7 c0 08 00 00 00 4d 29 =
c8 4c 01 c7 4c 29 c2 e9 72 ff ff ff cc cc cc cc eb 07 0f 00 2d 47 72 29 =
00 fb f4 <fa> c3 0f 1f 00 65 48 8b 04 25 00 33 02 00 f0 80 48 02 20 48 =
8b 10
>>>>> [   92.417855] RSP: 0018:ffffffff92003e88 EFLAGS: 00000206
>>>>> [   92.417855] RAX: 0000000000000000 RBX: 0000000000000000 RCX: =
0000000000000001
>>>>> [   92.417855] RDX: 4000000000000000 RSI: 0000000000000083 RDI: =
00000000000bfc34
>>>>> [   92.417855] RBP: ffffffff92009dc0 R08: ffff99bcf7c1f160 R09: =
ffff99bcf7c1f100
>>>>> [   92.417855] R10: ffff99bcf7c1f100 R11: 0000000000000000 R12: =
0000000000000000
>>>>> [   92.417855] R13: 0000000000000000 R14: ffffffff92009dc0 R15: =
0000000000000000
>>>>> [   92.417855]  default_idle_call+0x1f/0x30
>>>>> [   92.417855]  do_idle+0x1df/0x210
>>>>> [   92.417855]  cpu_startup_entry+0x14/0x20
>>>>> [   92.417855]  rest_init+0xc7/0xd0
>>>>> [   92.417855]  arch_call_rest_init+0x5/0x20
>>>>> [   92.417855]  start_kernel+0x3e9/0x5b0
>>>>> [   92.417855]  x86_64_start_reservations+0x14/0x30
>>>>> [   92.417855]  x86_64_start_kernel+0x71/0x80
>>>>> [   92.417855]  secondary_startup_64_no_verify+0x167/0x16b
>>>>> [   92.417855]  </TASK>
>>>>> [   92.417855] ---[ end trace 0000000000000000 ]=E2=80=94
>>>>>=20
>>>>>=20
>>>> Hi Martin,
>>>>=20
>>>> Thanks, I'll take a look.
>>>> William
>>>=20
>>> Hi Martin,
>>> For non-dataring packet, I should use rbi->len instead of rcd->len.
>>> Are you able to see if this fixes the bug?
>>> thanks!
>>>=20
>>> diff --git a/drivers/net/vmxnet3/vmxnet3_xdp.c
>>> b/drivers/net/vmxnet3/vmxnet3_xdp.c
>>> index 80ddaff759d4..a6c787454a1a 100644
>>> --- a/drivers/net/vmxnet3/vmxnet3_xdp.c
>>> +++ b/drivers/net/vmxnet3/vmxnet3_xdp.c
>>> @@ -382,12 +382,12 @@ vmxnet3_process_xdp(struct vmxnet3_adapter =
*adapter,
>>>       page =3D rbi->page;
>>>       dma_sync_single_for_cpu(&adapter->pdev->dev,
>>>                               page_pool_get_dma_addr(page) +
>>> -                               rq->page_pool->p.offset, rcd->len,
>>> +                               rq->page_pool->p.offset, rbi->len,
>>>                               page_pool_get_dma_dir(rq->page_pool));
>>>=20
>>> -       xdp_init_buff(&xdp, rbi->len, &rq->xdp_rxq);
>>> +       xdp_init_buff(&xdp, PAGE_SIZE, &rq->xdp_rxq);
>>>       xdp_prepare_buff(&xdp, page_address(page), =
rq->page_pool->p.offset,
>>> -                        rcd->len, false);
>>> +                        rbi->len, false);
>>>       xdp_buff_clear_frags_flag(&xdp);
>>>=20
>>>       xdp_prog =3D rcu_dereference(rq->adapter->xdp_bpf_prog);
>>=20


