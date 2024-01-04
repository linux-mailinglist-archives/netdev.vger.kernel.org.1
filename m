Return-Path: <netdev+bounces-61424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A69823A4E
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 02:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24084B2106A
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 01:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3C11849;
	Thu,  4 Jan 2024 01:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Watoy6Ry"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1359B184F
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 01:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5edf3780534so553477b3.0
        for <netdev@vger.kernel.org>; Wed, 03 Jan 2024 17:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704332516; x=1704937316; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RMqwb/eYpUYP2hNT+3w24QlDGdNR7GrUdVOxzz/rlLc=;
        b=Watoy6Ry0FePoheMfqWUHCVPlMg1lk4/9R1bL+mT+J8xfWxXUrH4Hwpre4waNG7VnF
         Pd4WdR8f+B06Q7tHrJHeYYbnMcm2ZfR8XwWjLRalnI/JxRsc+3bGjbqdlZ7k95yr1JF+
         W1TtULwJbghMDeC65rIdSBKrNRM3nsE6pKnpd4ADICEDzkTu8lU+9T6zt6KrMnf923br
         dv1waw1pG3Wqt/9QAQ4nrLv5quVr7Pqv28jeA9p3IBejwbtWC2ooGA3LJFpHNBPwK65y
         9BIZbMMssWQV8+RqAPTBbXpoXvnvgXAJ/TaN2WG3r+9tQLqmwhqCw9ajocl1cBZ8oVZ2
         C7gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704332516; x=1704937316;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RMqwb/eYpUYP2hNT+3w24QlDGdNR7GrUdVOxzz/rlLc=;
        b=HlHoBJPErf4zDoBo7uYRS6o6useD9n//PExYLWHclHZFFG6K2GFa4QSVLJBEnJHjUj
         2HkYNx9n7ie4mJKL+InlwLIQf45n/FTBdrMSr5JlDaVwyEl1CWNavcGGhg9pKcoYs1aC
         p4g3oGIzi/IDsT0e0bxOTtl+sAjoLBuHzJoqSGVGqZzU3Qk2b3ppv444uRqNp9EXwU/O
         mnbc5z/tQ74i/RoYJmpVPpzl2dKUSG2lZzmzWyKCfFRvW2UyXaDntrpWWOUP5C9m47w5
         2vmWLZGnKFEctPtWfbmX2oWg4IJlGO0Nj0243rgcdqudkNKgUhXOtrmF3Z65ZqPC0zO7
         305w==
X-Gm-Message-State: AOJu0YzU3Cf7PI/FNqB0bCeC8VZQUK2wJ7Frn8eAaITC1CaijO5z31/+
	iXvg5BFjBWSby+VbqRnFVmls8/aWIgQ=
X-Google-Smtp-Source: AGHT+IFHW2f2ZinkR/W9Qinh3dZwtBv0hVwnAaRm4h28AGHcacEWqZrwwegP6UcNt5A2eYVYYzmZiA==
X-Received: by 2002:a0d:f4c5:0:b0:5e7:a150:627e with SMTP id d188-20020a0df4c5000000b005e7a150627emr12853693ywf.99.1704332516070;
        Wed, 03 Jan 2024 17:41:56 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:1e6:8848:d591:6950? ([2600:1700:6cf8:1240:1e6:8848:d591:6950])
        by smtp.gmail.com with ESMTPSA id u18-20020a81a512000000b00597e912e67esm13217792ywg.131.2024.01.03.17.41.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 17:41:55 -0800 (PST)
Message-ID: <ce8d3e55-b8bc-409c-ace9-5cf1c4f7c88e@gmail.com>
Date: Wed, 3 Jan 2024 17:41:54 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: netdev@vger.kernel.org, victor@mojatatu.com
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 pctammela@mojatatu.com, "David S. Miller" <davem@davemloft.net>,
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@meta.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
Subject: net/sched - kernel crashes when replacing a qdisc node.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

The kernel crashes when running selftests/bpf/prog_tests/lwt_reroute.c. 
We got the error message at end of this post.

It happens when lwt_reroute.c running the shell command

   tc qdisc replace dev tun0 root fq limit 5 flow_limit 5

The kernel crashes at the line

   block = cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NULL);

in the function qdisc_block_add_dev(), which is added by
913b47d3424e7 ("net/sched: Introduce tc block netdev tracking infra")
recently. According to what I saw, cl_ops (sch->ops->cl_ops) is null,
and it causes cl_ops->tcf_block an invalid memory access. The id of
qdisc here is "fq", and it has no Qdisc_class_ops.

IMHO, qdisc_block_add_dev() wrongly believes that every qdisc received
by it is classful. This issue causes BPF CI fails, and we have to
disable some test cases for now.

Error message:

[    5.230927] BUG: kernel NULL pointer dereference, address: 
0000000000000048
[    5.231767] #PF: supervisor read access in kernel mode
[    5.231872] #PF: error_code(0x0000) - not-present page
[    5.231872] PGD 0 P4D 0
[    5.233365] Oops: 0000 [#1] PREEMPT SMP NOPTI
[    5.233365] CPU: 2 PID: 2179 Comm: tc Tainted: G           OE 
6.7.0-rc6-01883-gb4560055c8f1-dirty #1582
[    5.233944] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS 1.15.0-1 04/01/2014
[    5.233944] RIP: 0010:qdisc_create+0x2d0/0x800
[    5.236068] Code: 00 48 c7 c7 31 af 83 82 e8 3d 60 60 ff 49 8b 44 24 
18 be a6 04 00 00 48 c7 c7 b8 ad 83 82 4c 8b 78 08 4c 89 fa e8 20 60 60 
ff <49> 8b 57 481
[    5.236068] RSP: 0018:ffffc900003e3998 EFLAGS: 00010282
[    5.239068] RAX: 0000000000000032 RBX: ffff88810a9cc000 RCX: 
0000000000000000
[    5.239068] RDX: 0000000000000001 RSI: ffffffff82762bcb RDI: 
00000000ffffffff
[    5.240161] RBP: ffffffff83915340 R08: ffffffff83765168 R09: 
0000000000000003
[    5.240161] R10: ffffffff83065180 R11: ffffffff835e5180 R12: 
ffff888106ef8000
[    5.240161] R13: 0000000000000000 R14: 0000000080010000 R15: 
0000000000000000
[    5.243192] FS:  00007f16eed0c740(0000) GS:ffff888237d00000(0000) 
knlGS:0000000000000000
[    5.243192] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    5.243192] CR2: 0000000000000048 CR3: 000000010a92c000 CR4: 
00000000000006f0
[    5.243192] Call Trace:
[    5.245838]  <TASK>
[    5.245838]  ? __die+0x20/0x60
[    5.245838]  ? page_fault_oops+0x14b/0x420
[    5.246765]  ? fixup_exception+0x22/0x280
[    5.246765]  ? exc_page_fault+0x60/0x120
[    5.246765]  ? asm_exc_page_fault+0x22/0x30
[    5.246765]  ? qdisc_create+0x2d0/0x800
[    5.246765]  ? qdisc_create+0x2d0/0x800
[    5.246765]  tc_modify_qdisc+0x224/0x890
[    5.246765]  rtnetlink_rcv_msg+0x146/0x3c0
[    5.246765]  ? rtnl_calcit.isra.0+0x110/0x110
[    5.246765]  netlink_rcv_skb+0x41/0xd0
[    5.251263]  netlink_unicast+0x213/0x340
[    5.251389]  netlink_sendmsg+0x1e4/0x400
[    5.251389]  __sock_sendmsg+0x38/0x70
[    5.251389]  ____sys_sendmsg+0x1e4/0x220
[    5.251389]  ? copy_msghdr_from_user+0x5d/0x80
[    5.251389]  ___sys_sendmsg+0x6f/0xa0
[    5.251389]  ? copy_msghdr_from_user+0x5d/0x80
[    5.251389]  ? ___sys_recvmsg+0x75/0xa0
[    5.251389]  __sys_sendmsg+0x49/0x80
[    5.255231]  do_syscall_64+0x3b/0xe0
[    5.255231]  entry_SYSCALL_64_after_hwframe+0x63/0x6b
[    5.255231] RIP: 0033:0x7f16eeb27b17
[    5.255231] Code: 0f 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b9 0f 
1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 2e 00 00 00 0f 
05 <48> 3d 00 f00
[    5.255231] RSP: 002b:00007ffdddd33af8 EFLAGS: 00000246 ORIG_RAX: 
000000000000002e
[    5.259735] RAX: ffffffffffffffda RBX: 0000000065960730 RCX: 
00007f16eeb27b17
[    5.259966] RDX: 0000000000000000 RSI: 00007ffdddd33b60 RDI: 
0000000000000007
[    5.259966] RBP: 0000000000000000 R08: 0000000000000001 R09: 
0000560365ad78f0
[    5.259966] R10: 0000560365adf8f0 R11: 0000000000000246 R12: 
0000000000000001
[    5.259966] R13: 0000560365aa7236 R14: 0000560365aa70c8 R15: 
0000560365acdf40
[    5.259966]  </TASK>
[    5.264057] Modules linked in: bpf_testmod(OE)
[    5.264057] CR2: 0000000000000048
[    5.265368] ---[ end trace 0000000000000000 ]---
[    5.265980] RIP: 0010:qdisc_create+0x2d0/0x800
[    5.266576] Code: 00 48 c7 c7 31 af 83 82 e8 3d 60 60 ff 49 8b 44 24 
18 be a6 04 00 00 48 c7 c7 b8 ad 83 82 4c 8b 78 08 4c 89 fa e8 20 60 60 
ff <49> 8b 57 481
[    5.268924] RSP: 0018:ffffc900003e3998 EFLAGS: 00010282
[    5.269594] RAX: 0000000000000032 RBX: ffff88810a9cc000 RCX: 
0000000000000000
[    5.270522] RDX: 0000000000000001 RSI: ffffffff82762bcb RDI: 
00000000ffffffff
[    5.271363] RBP: ffffffff83915340 R08: ffffffff83765168 R09: 
0000000000000003
[    5.272261] R10: ffffffff83065180 R11: ffffffff835e5180 R12: 
ffff888106ef8000
[    5.273140] R13: 0000000000000000 R14: 0000000080010000 R15: 
0000000000000000
[    5.274030] FS:  00007f16eed0c740(0000) GS:ffff888237d80000(0000) 
knlGS:0000000000000000
[    5.275042] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    5.275816] CR2: 00007ff5f9430088 CR3: 000000010a92c000 CR4: 
00000000000006f0
[    5.276728] Kernel panic - not syncing: Fatal exception
[    5.277552] Kernel Offset: disabled
[    5.277718] ---[ end Kernel panic - not syncing: Fatal exception ]---


