Return-Path: <netdev+bounces-41627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD887CB7AD
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 02:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D787B20ED2
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 00:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7390610FA;
	Tue, 17 Oct 2023 00:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUEa/0GQ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7A810EB
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 00:55:34 +0000 (UTC)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5BC9B
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 17:55:33 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-66d1a05b816so31225206d6.1
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 17:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697504132; x=1698108932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TG15oa89ZVHEW45LLrdT1pGO5yi0zAhO8czj7UoaYsU=;
        b=AUEa/0GQYaqTY26t06/hQUi2cmNfKCv6IFwBPqtm7z74CygFEmUNH6Hpk4ln8n93r0
         uvcrO6PR+5PxP9s69OQhMJNzDLre0JCp7vmgS/IMvZ6XSnmatcdmAQJTpRItvzo5NcVq
         dF/xXBdYSGlA+f7THILD36T7TSLj/VOXZaYiA1TI3tq2/yN1Xv7mMP+Ezhrbbwgo1ABZ
         OcCpPZd1rz7QqADnfiyDRtqtDO+nwwkuYslr/kxkSpFiw7YAr00qVBdeiZ0GyFSgPBlu
         qHcPMvjoVKaWMjWvuYPr4Si+M9CPbCz3auC6YgWJMzFye/p9XgD3lKTzBENBzFPuQzl2
         Hbpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697504132; x=1698108932;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TG15oa89ZVHEW45LLrdT1pGO5yi0zAhO8czj7UoaYsU=;
        b=SkCJ0fg+GZwpztCfIzRU4RL+c/aUMKh6JD26qjknPIz/htc72/ITo20HUY0cz6C/mu
         +8olOUhAZakayYHsqmPtXn2SD5JrAfVQpfZDFGdwmHXXO/Cy56d2SAkonr/8OtkuAVfv
         7zaaXaXLsBPlTT9kfU17NBMUse57e0vZ5/3l/R2AZHjr7Xxr8RVQ9S1R4aGkCJ9nhC+L
         N4F2IL1Atnj283M01rnjasloGlOeHsuLmxq57ahLt2DoZ3r4LSA6NZsxyPR60Il75tmh
         hkP5Qt9LxBKl8RAi4Hlv25LDjELYoAFxsoE04VJJ6NhgeZQUiZck4gzur8d3LogBPJfZ
         lSwg==
X-Gm-Message-State: AOJu0Yy/4J9fKKERpHZBuQ48e4AvNc6wGL61Aj0TA1P6lJ21CXkGxxoa
	h4iNMOM8y481mV24QgWn218=
X-Google-Smtp-Source: AGHT+IGwf5r1tpU6uvVEqCF3woW7ygAbpwdRv/BtZWW9R6lii2WGkUonJLb/ANE+MGnP6XrelGzqBA==
X-Received: by 2002:a05:6214:29ee:b0:66d:2af4:c423 with SMTP id jv14-20020a05621429ee00b0066d2af4c423mr1100794qvb.2.1697504132365;
        Mon, 16 Oct 2023 17:55:32 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id du19-20020a05621409b300b0065d051fc445sm140029qvb.55.2023.10.16.17.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 17:55:32 -0700 (PDT)
Date: Mon, 16 Oct 2023 20:55:31 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>, 
 syzbot <syzkaller@googlegroups.com>
Message-ID: <652ddb83d8ec7_1bc2f32945d@willemb.c.googlers.com.notmuch>
In-Reply-To: <20231016180851.3560092-1-edumazet@google.com>
References: <20231016180851.3560092-1-edumazet@google.com>
Subject: Re: [PATCH net] tun: prevent negative ifindex
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Eric Dumazet wrote:
> After commit 956db0a13b47 ("net: warn about attempts to register
> negative ifindex") syzbot is able to trigger the following splat.
> 
> Negative ifindex are not supported.
> 
> WARNING: CPU: 1 PID: 6003 at net/core/dev.c:9596 dev_index_reserve+0x104/0x210
> Modules linked in:
> CPU: 1 PID: 6003 Comm: syz-executor926 Not tainted 6.6.0-rc4-syzkaller-g19af4a4ed414 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
> pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : dev_index_reserve+0x104/0x210
> lr : dev_index_reserve+0x100/0x210
> sp : ffff800096a878e0
> x29: ffff800096a87930 x28: ffff0000d04380d0 x27: ffff0000d04380f8
> x26: ffff0000d04380f0 x25: 1ffff00012d50f20 x24: 1ffff00012d50f1c
> x23: dfff800000000000 x22: ffff8000929c21c0 x21: 00000000ffffffea
> x20: ffff0000d04380e0 x19: ffff800096a87900 x18: ffff800096a874c0
> x17: ffff800084df5008 x16: ffff80008051f9c4 x15: 0000000000000001
> x14: 1fffe0001a087198 x13: 0000000000000000 x12: 0000000000000000
> x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
> x8 : ffff0000d41c9bc0 x7 : 0000000000000000 x6 : 0000000000000000
> x5 : ffff800091763d88 x4 : 0000000000000000 x3 : ffff800084e04748
> x2 : 0000000000000001 x1 : 00000000fead71c7 x0 : 0000000000000000
> Call trace:
> dev_index_reserve+0x104/0x210
> register_netdevice+0x598/0x1074 net/core/dev.c:10084
> tun_set_iff+0x630/0xb0c drivers/net/tun.c:2850
> __tun_chr_ioctl+0x788/0x2af8 drivers/net/tun.c:3118
> tun_chr_ioctl+0x38/0x4c drivers/net/tun.c:3403
> vfs_ioctl fs/ioctl.c:51 [inline]
> __do_sys_ioctl fs/ioctl.c:871 [inline]
> __se_sys_ioctl fs/ioctl.c:857 [inline]
> __arm64_sys_ioctl+0x14c/0x1c8 fs/ioctl.c:857
> __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
> invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
> el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
> do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
> el0_svc+0x58/0x16c arch/arm64/kernel/entry-common.c:678
> el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
> el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595
> irq event stamp: 11348
> hardirqs last enabled at (11347): [<ffff80008a716574>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
> hardirqs last enabled at (11347): [<ffff80008a716574>] _raw_spin_unlock_irqrestore+0x38/0x98 kernel/locking/spinlock.c:194
> hardirqs last disabled at (11348): [<ffff80008a627820>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:436
> softirqs last enabled at (11138): [<ffff8000887ca53c>] spin_unlock_bh include/linux/spinlock.h:396 [inline]
> softirqs last enabled at (11138): [<ffff8000887ca53c>] release_sock+0x15c/0x1b0 net/core/sock.c:3531
> softirqs last disabled at (11136): [<ffff8000887ca41c>] spin_lock_bh include/linux/spinlock.h:356 [inline]
> softirqs last disabled at (11136): [<ffff8000887ca41c>] release_sock+0x3c/0x1b0 net/core/sock.c:3518
> 
> Fixes: fb7589a16216 ("tun: Add ability to create tun device with given index")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>


