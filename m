Return-Path: <netdev+bounces-27887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B95877D851
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 04:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3516F1C20EC0
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 02:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C0D1C04;
	Wed, 16 Aug 2023 02:17:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF99E17E8
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 02:17:58 +0000 (UTC)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CAD2683;
	Tue, 15 Aug 2023 19:17:39 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4ff72830927so4526451e87.3;
        Tue, 15 Aug 2023 19:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692152257; x=1692757057;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YGLsrMXOYTzbZg9A5ewvotRbsvslBbVECaYUAZxQick=;
        b=EA/Xrp4XGLTNQqWXp1nBGasIY1AxOlDN5GLKxZabiP3D/w9ILkYvSs6CnLOSL1GhcI
         4MXQmlVdpYW6NfhaAKIMb+9uIYeC9052bwYkiHFsbw+Z1qoftDMmWokl+f4Xcu07ZdjW
         H/wksgAKfbJyh9LmeV0zQHbrRdzOMMv6cVhk2HT2nUFj90JxfqsiwztOoMd13jcZmd+q
         i28qNDYmMkgjBtGHeaKq7tO3d45LzJUx6NU51PV1bRqJfaS+Q2+t+tUUrgUl8MDM7DDa
         Bonpr59p5LHDJZ/QrFSZ6CvkvKsMYEWeazFXSUvnmipSksm42WeM1iCAlYaRgxsZGvQN
         i1Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692152257; x=1692757057;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YGLsrMXOYTzbZg9A5ewvotRbsvslBbVECaYUAZxQick=;
        b=LxdKq4YA5EFJ06ojsnSFu0GhQbCKeyThZWZumyUso2k3Qir+gqzoI4e2vBToaHNM+z
         /tCCa9UFFeK6kYFlxFpfj58AmOtxjZh1gVX4LhyEc9Co2ZSglJRnwjr8FbnViLwVyxxo
         tcHq7LpERmuyr5cVZtwNzkIMbKB3lyGT6tRlpoC0XqErpM2AlWqkJpMaKsk01rUEgtYZ
         DIfbKGIKO/dJQBc8hvNyAOIT7sTOIyXEPvWhjnbYsGdwKy6MqNcVm4/YEBnAlnBnng9o
         yrJ/qyLWEkE8QJxu1HTY/J0LAHhp1HvE5VtK41LJkNXFpROb854N8vSEIAYsHeETOZM2
         hU6A==
X-Gm-Message-State: AOJu0Yz8on/GXZEjw9Crq/YD2T7S7o9O01KLiKVmjkZxG9i4kWZetXVZ
	2dpYL/5V8c2QZrDqJyBLllhOnsDTKNTS0nSiCic=
X-Google-Smtp-Source: AGHT+IHq2QDPYB2sI8SQ7vTRmjdxx79ojX9Y1jqjjP8gwhSnIqx4+sCXT+r2+88L8+k3C1rKGk1kTLK1ON+jMWwQ0XA=
X-Received: by 2002:a19:655d:0:b0:4fa:6d62:9219 with SMTP id
 c29-20020a19655d000000b004fa6d629219mr425868lfj.62.1692152256814; Tue, 15 Aug
 2023 19:17:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yikebaer Aizezi <yikebaer61@gmail.com>
Date: Wed, 16 Aug 2023 10:17:20 +0800
Message-ID: <CALcu4rY66VMDQ3ODR25Xu9AD3ef353=gVvPHSpMVz-1jLWDqQg@mail.gmail.com>
Subject: kernel BUG in unregister_vlan_dev
To: davem@davemloft.net, edumazet@google.com, Paolo Abeni <pabeni@redhat.com>, 
	kuba@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

When using Healer to fuzz the Latest Linux-6.5-rc6,  the following crash
was triggered.

HEAD commit: 2ccdd1b13c591d306f0401d98dedc4bdcd02b421 (tag: v6.5-rc6=EF=BC=
=89
git tree: upstream

console output:
https://drive.google.com/file/d/1Ff3neTmiyj4PdLk5JGTnEe-PbV47cZhL/view?usp=
=3Ddrive_link
kernel config:https://drive.google.com/file/d/1GMWQQWjECxVnH4Bfd6NpwWJ8t9jx=
yYVD/view?usp=3Ddrive_link
C reproducer:https://drive.google.com/file/d/1d5Bj0ampj1Gd6KaLI3nFfHEjP8hor=
IXx/view?usp=3Ddrive_link
Syzlang reproducer:
https://drive.google.com/file/d/1p-CbhgHnkaQlHHlze3G8VzqV3B9iyuUx/view?usp=
=3Ddrive_link

If you fix this issue, please add the following tag to the commit:
Reported-by: Yikebaer Aizezi <yikebaer61@gmail.com>

------------[ cut here ]------------
kernel BUG at net/8021q/vlan.c:100!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 13 Comm: kworker/u4:1 Not tainted 6.5.0-rc6 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Workqueue: netns cleanup_net
RIP: 0010:unregister_vlan_dev+0x4a5/0x580
home/smyl/workspace/linux-6.5-rc6/net/8021q/vlan.c:100
Code: 61 00 00 00 48 c7 c6 40 6a 15 8b 48 c7 c7 80 6a 15 8b c6 05 bb
6f 18 05 01 e8 57 db 60 f8 0f 0b e9 f4 fb ff ff e8 3b d7 98 f8 <0f> 0b
e8 74 a3 e8 f8 e9 c3 fb ff ff 4c 89 f7 e8 77 a3 e8 f8 e9 56
RSP: 0018:ffffc900000ffae8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff8881117ae000 RCX: 0000000000000000
RDX: ffff888013e50000 RSI: ffffffff88e793b5 RDI: ffff888029992350
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 000000000008e001 R12: ffff888029992000
R13: 0000000000000000 R14: ffffffff88e78f10 R15: ffffc900000ffbd8
FS:  0000000000000000(0000) GS:ffff888135c00000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000557f357e3680 CR3: 0000000029cce000 CR4: 0000000000750ee0
PKRU: 55555554
Call Trace:
 <TASK>
 default_device_exit_batch+0x377/0x5b0
home/smyl/workspace/linux-6.5-rc6/net/core/dev.c:11354
 ops_exit_list+0x125/0x170
home/smyl/workspace/linux-6.5-rc6/net/core/net_namespace.c:175
 cleanup_net+0x4ea/0xb10
home/smyl/workspace/linux-6.5-rc6/net/core/net_namespace.c:614
 process_one_work+0xa22/0x16e0
home/smyl/workspace/linux-6.5-rc6/kernel/workqueue.c:2600
 worker_thread+0x679/0x10c0
home/smyl/workspace/linux-6.5-rc6/kernel/workqueue.c:2751
 kthread+0x33a/0x430 home/smyl/workspace/linux-6.5-rc6/kernel/kthread.c:389
 ret_from_fork+0x28/0x60
home/smyl/workspace/linux-6.5-rc6/arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20
home/smyl/workspace/linux-6.5-rc6/arch/x86/entry/entry_64.S:304
 </TASK>
Modules linked in:
Dumping ftrace buffer:
   (ftrace buffer empty)
---[ end trace 0000000000000000 ]---
RIP: 0010:unregister_vlan_dev+0x4a5/0x580
home/smyl/workspace/linux-6.5-rc6/net/8021q/vlan.c:100
Code: 61 00 00 00 48 c7 c6 40 6a 15 8b 48 c7 c7 80 6a 15 8b c6 05 bb
6f 18 05 01 e8 57 db 60 f8 0f 0b e9 f4 fb ff ff e8 3b d7 98 f8 <0f> 0b
e8 74 a3 e8 f8 e9 c3 fb ff ff 4c 89 f7 e8 77 a3 e8 f8 e9 56
RSP: 0018:ffffc900000ffae8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff8881117ae000 RCX: 0000000000000000
RDX: ffff888013e50000 RSI: ffffffff88e793b5 RDI: ffff888029992350
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 000000000008e001 R12: ffff888029992000
R13: 0000000000000000 R14: ffffffff88e78f10 R15: ffffc900000ffbd8
FS:  0000000000000000(0000) GS:ffff888063c00000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555fce4b01a8 CR3: 000000010f878000 CR4: 0000000000750ef0
PKRU: 55555554

