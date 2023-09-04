Return-Path: <netdev+bounces-31962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD2B791B69
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 18:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA4AA1C20853
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 16:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D978C2F2;
	Mon,  4 Sep 2023 16:24:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E395C2DF
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 16:24:36 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78EA09D
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 09:24:34 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-52bca2e8563so2197071a12.2
        for <netdev@vger.kernel.org>; Mon, 04 Sep 2023 09:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693844673; x=1694449473; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G+T6Rx9YsgeIvknysvDIrCrsaJwMh6gU78QhgJK7DhE=;
        b=r03gj6ltuChM0LfXcquVB2KqQR9LiVN+FO8EW+E2hzk4n/oLne1QI8m1WDyahq0fNI
         YcP9iyzfXUIlDmF0y2UuDMU9nKZ12YfYigGGdrobAqr1idyqZnBP0FDajENj8Gk/NS4B
         DZPYGySNvlf7dNCvjDyHT5zby+OP7uqNJuwFaO/DtiO5Ux0EQWDhwsobdijX5lklBUem
         eRZI1A272GJZcI2bC9jXEp7l2tiprjfK5Y6uf472/7vtISOAPw4Krni/YahLPn5Do5IV
         nrOmu35zBgIb47i6bXy6RILPiVGJnKZn8LZwf4VmV44lhTWzC3R1O+N34RqL7yAJFXdI
         xiHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693844673; x=1694449473;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G+T6Rx9YsgeIvknysvDIrCrsaJwMh6gU78QhgJK7DhE=;
        b=V8h6PiVSXkW9f9RRXyOloulNeEjWngegnS7I3Apb0DcqSCT5H0tZNUO92SLt0YLO6p
         pm/+Uvbs3yosHQpzJ7DeQqIRJA+HC8l9FQGxL6KYNyUn/0bg/jRUhlAB2BVrT5Zeo1Hs
         o2SDEHB3uOhfRxzVQDu3ACTIqIU8/2Zl+mArR1JYrKA1coK4pWenxg/+gScVUnyNmaD5
         ghRpo5faWUklZV41p84SD3MJaxFsTWiJJBJ+LMqWtWMrzJvJREI+RCXXsWmbFTOYhRhB
         ziryMC3Xej1Ate06u96OGI0cBxluO5hXnekWapXzLfLXNq3eIIivOdAcjDj849BveX0y
         yUyQ==
X-Gm-Message-State: AOJu0YxgZ76EbLezfePLRszZxYqNOyn5mT3YFI1kDYcjCJDC/XTHidl9
	hIUzkqgRgdsch8Vm/gGcM9M=
X-Google-Smtp-Source: AGHT+IGCaFLRSI9YHBZlWXpvKo39pZmQ+1VcXKzPOzZINmIpHGOlNKPfmQofZUOUvB217UnWRZk20g==
X-Received: by 2002:a05:6402:3811:b0:52e:31be:e4c2 with SMTP id es17-20020a056402381100b0052e31bee4c2mr2116372edb.41.1693844672680;
        Mon, 04 Sep 2023 09:24:32 -0700 (PDT)
Received: from smtpclient.apple ([178.254.237.20])
        by smtp.gmail.com with ESMTPSA id m7-20020aa7c2c7000000b00523a43f9b1dsm6016393edp.22.2023.09.04.09.24.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Sep 2023 09:24:31 -0700 (PDT)
From: Martin Zaharinov <micron10@gmail.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Vmxnet3 v22 - bug
Message-Id: <74BF3CC8-2A3A-44FF-98C2-1E20F110A92E@gmail.com>
Date: Mon, 4 Sep 2023 19:24:20 +0300
Cc: Alexander Duyck <alexanderduyck@fb.com>,
 alexandr.lobakin@intel.com,
 netdev <netdev@vger.kernel.org>
To: u9012063@gmail.com
X-Mailer: Apple Mail (2.3731.700.6)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi William Tu


this is report of bug with latest version of vmxnet3 xdp support:


[   92.417855] ------------[ cut here ]------------
[   92.417855] XDP_WARN: xdp_update_frame_from_buff(line:278): Driver =
BUG: missing reserved tailroom
[   92.417855] WARNING: CPU: 0 PID: 0 at net/core/xdp.c:586 =
xdp_warn+0xf/0x20
[   92.417855] Modules linked in:  pppoe pppox ppp_generic slhc =
virtio_net net_failover failover virtio_pci virtio_pci_legacy_dev =
virtio_pci_modern_dev virtio virtio_ring vmxnet3=20
[   92.417855] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W  O      =
 6.5.1 #1
[   92.417855] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS =
rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
[   92.417855] RIP: 0010:xdp_warn+0xf/0x20
[   92.417855] Code: 00 00 c3 0f 1f 84 00 00 00 00 00 83 7f 0c 01 0f 94 =
c0 c3 0f 1f 84 00 00 00 00 00 48 89 f9 48 c7 c7 3d b2 e4 91 e8 d1 00 8e =
ff <0f> 0b c3 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 53 48 89 fb 8b
[   92.417855] RSP: 0018:ffffb30180003d40 EFLAGS: 00010286
[   92.417855] RAX: 0000000000000055 RBX: ffff99bcf7c22ee0 RCX: =
00000000fffdffff
[   92.417855] RDX: 00000000fffdffff RSI: 0000000000000001 RDI: =
00000000ffffffea
[   92.417855] RBP: ffff99bb849c2000 R08: 0000000000000000 R09: =
00000000fffdffff
[   92.417855] R10: ffff99bcf6a00000 R11: 0000000000000003 R12: =
ffff99bb83840000
[   92.417855] R13: ffff99bb83842780 R14: ffffb3018081d000 R15: =
ffff99bb849c2000
[   92.417855] FS:  0000000000000000(0000) GS:ffff99bcf7c00000(0000) =
knlGS:0000000000000000
[   92.417855] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   92.417855] CR2: 00007f9bf822df88 CR3: 00000001a74de000 CR4: =
00000000003506f0
[   92.417855] Call Trace:
[   92.417855]  <IRQ>
[   92.417855]  ? __warn+0x6c/0x130
[   92.417855]  ? report_bug+0x1e4/0x260
[   92.417855]  ? handle_bug+0x36/0x70
[   92.417855]  ? exc_invalid_op+0x17/0x1a0
[   92.417855]  ? asm_exc_invalid_op+0x16/0x20
[   92.417855]  ? xdp_warn+0xf/0x20
[   92.417855]  xdp_do_redirect+0x15f/0x1c0
[   92.417855]  vmxnet3_run_xdp+0x17a/0x400 [vmxnet3]
[   92.417855]  vmxnet3_process_xdp+0xe4/0x760 [vmxnet3]
[   92.417855]  ? vmxnet3_tq_tx_complete.isra.0+0x21e/0x2c0 [vmxnet3]
[   92.417855]  vmxnet3_rq_rx_complete+0x7ad/0x1120 [vmxnet3]
[   92.417855]  vmxnet3_poll_rx_only+0x2d/0xa0 [vmxnet3]
[   92.417855]  __napi_poll+0x20/0x180
[   92.417855]  net_rx_action+0x177/0x390
[   92.417855]  __do_softirq+0xd0/0x202
[   92.417855]  irq_exit_rcu+0x82/0xa0
[   92.417855]  common_interrupt+0x7a/0xa0
[   92.417855]  </IRQ>
[   92.417855]  <TASK>
[   92.417855]  asm_common_interrupt+0x22/0x40
[   92.417855] RIP: 0010:default_idle+0xb/0x10
[   92.417855] Code: 07 76 e7 48 89 07 49 c7 c0 08 00 00 00 4d 29 c8 4c =
01 c7 4c 29 c2 e9 72 ff ff ff cc cc cc cc eb 07 0f 00 2d 47 72 29 00 fb =
f4 <fa> c3 0f 1f 00 65 48 8b 04 25 00 33 02 00 f0 80 48 02 20 48 8b 10
[   92.417855] RSP: 0018:ffffffff92003e88 EFLAGS: 00000206
[   92.417855] RAX: 0000000000000000 RBX: 0000000000000000 RCX: =
0000000000000001
[   92.417855] RDX: 4000000000000000 RSI: 0000000000000083 RDI: =
00000000000bfc34
[   92.417855] RBP: ffffffff92009dc0 R08: ffff99bcf7c1f160 R09: =
ffff99bcf7c1f100
[   92.417855] R10: ffff99bcf7c1f100 R11: 0000000000000000 R12: =
0000000000000000
[   92.417855] R13: 0000000000000000 R14: ffffffff92009dc0 R15: =
0000000000000000
[   92.417855]  default_idle_call+0x1f/0x30
[   92.417855]  do_idle+0x1df/0x210
[   92.417855]  cpu_startup_entry+0x14/0x20
[   92.417855]  rest_init+0xc7/0xd0
[   92.417855]  arch_call_rest_init+0x5/0x20
[   92.417855]  start_kernel+0x3e9/0x5b0
[   92.417855]  x86_64_start_reservations+0x14/0x30
[   92.417855]  x86_64_start_kernel+0x71/0x80
[   92.417855]  secondary_startup_64_no_verify+0x167/0x16b
[   92.417855]  </TASK>
[   92.417855] ---[ end trace 0000000000000000 ]=E2=80=94


Please update if you find a problem.


Best regards,
Martin=

