Return-Path: <netdev+bounces-286570-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPSeMp+nAWrlhQEAu9opvQ
	(envelope-from <netdev+bounces-286570-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 11:55:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4958E50B680
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 11:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2BC530861E9
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647C23BE163;
	Mon, 11 May 2026 09:32:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E763BB9F8
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 09:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778491948; cv=none; b=EaMf3rIYYjUQBGUIV+0FBG2l7UEOhAy+jmWXxmQHam5mshPoD/HrdP/GYo5hh2R1tAPZocxJ9f0nXMgUXv1gE5MHCAwNjV76vNLPS+syu0shw2dbhZmdL4WI0btvXdisrcLzythzOFrl+h6qdaE1zAVdnV8hNshcnbtpjdeOkMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778491948; c=relaxed/simple;
	bh=d9PSxFFxGUfO9bcu4GbUqyZO6ELfnJGEDw8k62X8+NQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=t6LElYX8rubOAB/WfGJHhvwC24x4sEHMZ6cEjPfZwvd0DwJvVTGZQ7AEDXOm/rxfBlb13W7Q51zucXUSvYozuWOCQM3duzv6Wf3ojAPtfWZ929z6D8qcelN0VXVOyoZ6XSmhKwSIwdK25KKX6eSFZhUmXCHATkWjDjvFP4xmv4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-63130466364so1076109137.2
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 02:32:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778491946; x=1779096746;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Nrzls/aY5F/88Jsnwy7xDyfA7Q7OHE0DPx4RzZ5fDw=;
        b=gjYhTow4UL6S2+ixb9mPOFMOaxzoGit9pPz9E9XEyTqI8HpOZZ3pNwMAxbTygYCQ9u
         cvcsM1J5APB1qG5hEku8dcsPusS8I8vcm78MvHQdWriMxa8nlwJfcUGoJpv93a4ZV5P+
         d5bB+4kbKa5X6Z+rTb8c8Z3gpS7F2R5SEP1MaCADweGy4oS9AYNtmqXdsLRyruzVlntW
         WPYeyRrooF+ZHLcA3mUw1/gKQzI5o3HU9eWbzUiG+X8YLZmdUSzXrq6uc4XjuWoO2wem
         wAS2ghBhtASTUCJY9WFMuJ38EQ4WkYas2wBl4UOAVtrascwRERHGjbuQ0/VlCKpSYzu4
         1lUQ==
X-Forwarded-Encrypted: i=1; AFNElJ9F9XmQaVF+TBtbFmA/GWt0lzoo/wxiqe2pi9Xlonp7sEDn5uZCLclFrjO0Xxthk7psKzbBE9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YySbprnPRUzx4bRUvnfd49hjIHPT5fNEwF3wlqQ5g3df2DRq3Fh
	38Miiss+8M1kU6zcsLGdi+NtBmdBXqlGnNHqpYajHWQUIiijmDeH6HOOu3gcPzmE
X-Gm-Gg: Acq92OF474nYm272Di4Frh69QtxsO7a0acNW5SM6o7PR/b3udlyV7srM7BhY01G+STW
	uXfU4xmlTgV1G0h+dA9DhomQ00S6Bo4zQUxFAzLnKiS6u5gJX5YMVA5r2fBV/65JHHceE6CAesh
	P+rYG4mhjk9FX/l38N6TLNqY/lRkfZyaGn19J5U/UstmXCz7SiWkl3gjaqKcWldvOHqj/JR1QOZ
	c1iGa7fuITRcvPw77zHUbM/VtRTrC6AW0C0X10N3ZWGa7lqsbDlnubqaPXVbk9JNH0Qx5p0gY/n
	7fgw/ZXjgH79z3Q1zAw/H+lBeD1/ixIiV8qVJscGHBsoBi3r6ejakkndGfDgGAZ9i1Hw4imBLTT
	u/DlD166DJfElv4nA8/ugG+5A7L0EvtXlJ7pV2GhQiJ2+GSoEHOgorQA2ClOfyVEalKpS2Kt8D5
	7xPHN6bL/9lDqSFpqzA0jlYw4DJiEkGJV3bhcgfL/eGJ0vXm4vLUx9jkQ0bfcOCw8waK1qfeogI
	ZA=
X-Received: by 2002:a05:6102:f9c:b0:608:6c7b:4554 with SMTP id ada2fe7eead31-6313ea9e29fmr5337995137.16.1778491945793;
        Mon, 11 May 2026 02:32:25 -0700 (PDT)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com. [209.85.221.176])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-95f219c6d64sm4938412241.3.2026.05.11.02.32.24
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 02:32:25 -0700 (PDT)
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-56a9076813bso1591918e0c.3
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 02:32:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+95waQcX39MsuZByLAoguWz3Lcj1xkpe7/nqhQx5xSWQgdYAxnAm7usO+2wrhR1vGRSv5CPoA=@vger.kernel.org
X-Received: by 2002:a05:6122:3d08:b0:56f:2609:cd95 with SMTP id
 71dfb90a1353d-575864d866dmr5663907e0c.9.1778491944525; Mon, 11 May 2026
 02:32:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 11 May 2026 11:32:12 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX_Y6Sis7776SEjoPZP2NQ8sO7dUbWLF4oCZnWOWQy5vQ@mail.gmail.com>
X-Gm-Features: AVHnY4J6wptwE4Y5YbQ0RNvAcYZuakxv9GbDOHanQCgeHqKHbSOCIBpnNysMsU8
Message-ID: <CAMuHMdX_Y6Sis7776SEjoPZP2NQ8sO7dUbWLF4oCZnWOWQy5vQ@mail.gmail.com>
Subject: Unable to handle kernel NULL pointer dereference in percpu_ref_get()
To: cgroups@vger.kernel.org, netdev <netdev@vger.kernel.org>
Cc: linux-riscv <linux-riscv@lists.infradead.org>, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 4958E50B680
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286570-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,linux-m68k.org:email]
X-Rspamd-Action: no action

Hi all,

After merging v7.1-rc3, booting the kernel on RZ/Five hung.
When retrying with "earlycon keep_bootcon", I managed to catch the
crash report below.  Unfortunately I could not reproduce it after that,
hence no bisection result, but perhaps this rings a bell?

    Unable to handle kernel NULL pointer dereference at virtual
address 0000000000000000
    Current swapper/0 pgtable: 4K pagesize, 39-bit VAs, pgdp=0x00000000494f7000
    [0000000000000000] pgd=0000000000000000, p4d=0000000000000000,
pud=0000000000000000
    Oops [#1]
    CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted
7.1.0-rc3-rzfive-02022-ge48a16cf2dd1 #515 PREEMPT
    Hardware name: Renesas SMARC EVK based on r9a07g043f01 (DT)
    epc : percpu_ref_get+0x32/0x40
     ra : percpu_ref_get+0x10/0x40
    epc : ffffffff80089562 ra : ffffffff80089540 sp : ffffffc60000bb10
     gp : ffffffff812ea908 tp : ffffffd6018c9a00 t0 : ffffffd601997800
     t1 : ffffffff80df6a2f t2 : 69676552203a5445 s0 : ffffffc60000bb30
     s1 : ffffffff81291f18 a0 : ffffffff81291f18 a1 : 0000000000000002
     a2 : 0000000000000000 a3 : 0000000000000001 a4 : 0000000000000000
     a5 : 0000000200000022 a6 : 0000000000000508 a7 : 0000000000000038
     s2 : ffffffff8128f4f8 s3 : 0000000000001000 s4 : ffffffff812c9978
     s5 : 0000000000000010 s6 : 0000000000000000 s7 : ffffffff812ee3f8
     s8 : ffffffff80a21e58 s9 : 0000000000000008 s10: ffffffff808000aa
     s11: 0000000000000000 t3 : ffffffff812fd06f t4 : ffffffff812fd06f
     t5 : ffffffff812fd070 t6 : ffffffd6018aaa7c ssp : 0000000000000000
    status: 0000000200000100 badaddr: 0000000000000000 cause: 000000000000000d
    [<ffffffff80089562>] percpu_ref_get+0x32/0x40
    [<ffffffff8008eac8>] cgroup_sk_alloc+0x40/0x6e
    [<ffffffff8055ae8a>] sk_alloc+0xb4/0xdc
    [<ffffffff805b7718>] __netlink_create+0x32/0x8a
    [<ffffffff805b984a>] __netlink_kernel_create+0x60/0x182
    [<ffffffff80584492>] rtnetlink_net_init+0x4e/0x7a
    [<ffffffff8056aacc>] ops_init+0xc6/0xf8
    [<ffffffff8056bc3c>] register_pernet_operations+0xd0/0x148
    [<ffffffff8056bce2>] register_pernet_subsys+0x2e/0x48
    [<ffffffff8082ccb4>] rtnetlink_init+0x18/0x54
    [<ffffffff8082d27c>] netlink_proto_init+0x11c/0x140
    [<ffffffff8080100a>] do_one_initcall+0x70/0x13c
    [<ffffffff808013b2>] kernel_init_freeable+0x274/0x276
    [<ffffffff806bda22>] kernel_init+0x1e/0x12a
    [<ffffffff8000d368>] ret_from_fork_kernel+0x10/0xa2
    [<ffffffff806c37f6>] ret_from_fork_kernel_asm+0x16/0x18
    Code: 00e7 20ef d9fe 60e2 6442 64a2 6105 8082 77f3 1001 (6314) 8b89
    ---[ end trace 0000000000000000 ]---
    note: swapper/0[1] exited with irqs disabled
    BUG: sleeping function called from invalid context at
include/linux/percpu-rwsem.h:51
    in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1, name: swapper/0
    preempt_count: 0, expected: 0
    RCU nest depth: 2, expected: 0
    CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Tainted: G      D
7.1.0-rc3-rzfive-02022-ge48a16cf2dd1 #515 PREEMPT
    Tainted: [D]=DIE
    Hardware name: Renesas SMARC EVK based on r9a07g043f01 (DT)
    Call Trace:
    [<ffffffff8000fab6>] dump_backtrace+0x1c/0x24
    [<ffffffff80001226>] show_stack+0x2a/0x34
    [<ffffffff8000b57a>] dump_stack_lvl+0x32/0x4a
    [<ffffffff8000b5a6>] dump_stack+0x14/0x1c
    [<ffffffff8003861a>] __might_resched+0x110/0x11a
    [<ffffffff80038678>] __might_sleep+0x54/0x60
    [<ffffffff8002382e>] exit_signals+0x1e/0x140
    [<ffffffff80019858>] do_exit+0x14a/0x642
    [<ffffffff80019e24>] __riscv_sys_exit+0x0/0x1c
    [<ffffffff8000f50a>] die+0xdc/0xea
    [<ffffffff800015d4>] die_kernel_fault+0x1da/0x1e6
    [<ffffffff80012d20>] no_context+0x38/0x40
    [<ffffffff80012db2>] handle_page_fault+0x5e/0x23c
    [<ffffffff806bc9f8>] do_page_fault+0x1e/0x36
    [<ffffffff806c36da>] handle_exception+0x15e/0x16a
    [<ffffffff80089562>] percpu_ref_get+0x32/0x40
    [<ffffffff8008eac8>] cgroup_sk_alloc+0x40/0x6e
    [<ffffffff8055ae8a>] sk_alloc+0xb4/0xdc
    [<ffffffff805b7718>] __netlink_create+0x32/0x8a
    [<ffffffff805b984a>] __netlink_kernel_create+0x60/0x182
    [<ffffffff80584492>] rtnetlink_net_init+0x4e/0x7a
    [<ffffffff8056aacc>] ops_init+0xc6/0xf8
    [<ffffffff8056bc3c>] register_pernet_operations+0xd0/0x148
    [<ffffffff8056bce2>] register_pernet_subsys+0x2e/0x48
    [<ffffffff8082ccb4>] rtnetlink_init+0x18/0x54
    [<ffffffff8082d27c>] netlink_proto_init+0x11c/0x140
    [<ffffffff8080100a>] do_one_initcall+0x70/0x13c
    [<ffffffff808013b2>] kernel_init_freeable+0x274/0x276
    [<ffffffff806bda22>] kernel_init+0x1e/0x12a
    [<ffffffff8000d368>] ret_from_fork_kernel+0x10/0xa2
    [<ffffffff806c37f6>] ret_from_fork_kernel_asm+0x16/0x18
    Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
    ---[ end Kernel panic - not syncing: Attempted to kill init!
exitcode=0x0000000b ]---

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

