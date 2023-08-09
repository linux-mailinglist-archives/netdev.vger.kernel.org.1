Return-Path: <netdev+bounces-25926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FBD7762E1
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 16:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6DD61C21298
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 14:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE48219BCE;
	Wed,  9 Aug 2023 14:46:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BA219BCC
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 14:46:13 +0000 (UTC)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8FA1FF5
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 07:46:11 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bbd03cb7c1so45165185ad.3
        for <netdev@vger.kernel.org>; Wed, 09 Aug 2023 07:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1691592371; x=1692197171;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lm03DBd4vBCIYxgLftSEXfGwCK7m+GhHKWTGFbSa6Jw=;
        b=dstmsg0GjtB1so0YwSjAgcuOGq3Hf++b45aImy2SMb8DRCG0Q69ADp4wg1btOPO7xx
         2Ze6tA9aqwGlsbwiDtmBXPMoZviH8J64/J7SxT6LGKo1Mmmk2gjEFZMj/DN61079gP8m
         2Ir/o1/JcB/cTX3+gh5CjE96HeuIExxQsbTwO//T3W5DT3kk/Q4qqTwcYFFokrqznn6Z
         LZ4HqoJ07POG8j2z/7JLYuEvoNp5BwjAdz/Xn5ZF9TMxohnDeyCS/gJNZglOVlT7Ta/m
         msQwynZyZo0TrdUqhgodkDRStVnExgT1M0tQ22OGkbOfUKryBBlqJEr++xta9XuUziBG
         7iaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691592371; x=1692197171;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lm03DBd4vBCIYxgLftSEXfGwCK7m+GhHKWTGFbSa6Jw=;
        b=G+Wnc3CWF/H5kYG5o25ElOQPcrnTNhwK3pz4RJCLalEIB3JsYztLbAar7QSb4CAwDA
         MNBGgpbAVnFIiOeJuxG215UXDdjSpPD86YPci8Pwfq/gatWjRI59pTvbNANcxuENO3xq
         V1tcomP6H1qvNE+vW4Qoig4jzGjCgzSofwSWUO9qTIo7RMM9NukUDsETUGu5+t34ChiZ
         jI4Wd9zaomJgGDA7EDFR5cJFrWcbL5uQKcmAJXZNsHbF00ok/MiqE9LflmqnPm/0Bllt
         vfkCysLlPlwVBGh/OzzhHstTX4iesM3Tzev4NlOvkHQm047A/wcPgBJjYR7nhSCUKQbW
         X7KQ==
X-Gm-Message-State: AOJu0Yw6FnGYO0aQy29Q5F/zL/jd32N6DaTaQ6JsrkqBCVfNxu2JDJ83
	SHqlKU9CEZ1CakU5glhPBL5AEA==
X-Google-Smtp-Source: AGHT+IHT6Apcd57Axb1tPyw+Bw3hkCuPoxybQVElg4c+JJmqEZFZd3vXvwfmGLRPseUq/m5dvRNfTw==
X-Received: by 2002:a17:902:f688:b0:1bc:8e6a:6382 with SMTP id l8-20020a170902f68800b001bc8e6a6382mr2692125plg.53.1691592371053;
        Wed, 09 Aug 2023 07:46:11 -0700 (PDT)
Received: from hermes.local (204-195-127-207.wavecable.com. [204.195.127.207])
        by smtp.gmail.com with ESMTPSA id 17-20020a170902ee5100b001bb6c5ff4edsm11238652plo.173.2023.08.09.07.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 07:45:59 -0700 (PDT)
Date: Wed, 9 Aug 2023 07:45:46 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: alexandre.torgue@foss.st.com, joabreu@synopsys.com
Cc: netdev@vger.kernel.org
Subject: Fw: [Bug 217772] SoC development environment Linux LAN
 disconnection
Message-ID: <20230809074546.6ecc484e@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This bug report doesn't have a lot of info.
But in the dmesg is:

WARNING: CPU: 0 PID: 0 at /home/kaihatsu/linux_home/thread_\\\\\\\\\\/firm/kernel/linux-4.4-*****/net/sched/sch_generic.c:303 dev_watchdog+0x230/0x23c()
NETDEV WATCHDOG: eth0 (stmmaceth): transmit queue 0 timed out
Modules linked in: qgpio(O) qm3(O) qmem(O)
CPU: 0 PID: 0 Comm: swapper Tainted: G        W  O    4.4.0 #1
Hardware name: ********* (Flattened Device Tree)
[<8002a2e0>] (unwind_backtrace) from [<800289a4>] (show_stack+0x10/0x14)
[<800289a4>] (show_stack) from [<800357b0>] (warn_slowpath_common+0x84/0xb0)
[<800357b0>] (warn_slowpath_common) from [<8003580c>] (warn_slowpath_fmt+0x30/0x40)
[<8003580c>] (warn_slowpath_fmt) from [<8048bd20>] (dev_watchdog+0x230/0x23c)
[<8048bd20>] (dev_watchdog) from [<80075028>] (call_timer_fn+0x30/0x110)
[<80075028>] (call_timer_fn) from [<80075370>] (run_timer_softirq+0x140/0x264)
[<80075370>] (run_timer_softirq) from [<8003851c>] (__do_softirq+0xf4/0x2cc)
[<8003851c>] (__do_softirq) from [<8006b144>] (__handle_domain_irq+0x58/0xa8)
[<8006b144>] (__handle_domain_irq) from [<8000942c>] (gic_handle_irq+0x38/0x64)
[<8000942c>] (gic_handle_irq) from [<8056a280>] (__irq_svc+0x40/0x54)
Exception stack(0x807d7f50 to 0x807d7f98)
7f40:                                     807e3a78 0000067f 807dd6f8 80031b20
7f60: 80849050 807d6000 807d810c 808413c0 80840643 80840643 80849000 807c5a28
7f80: 00a00000 807d7fa0 80025c4c 80025c50 60010013 ffffffff
[<8056a280>] (__irq_svc) from [<80025c50>] (arch_cpu_idle+0x38/0x3c)
[<80025c50>] (arch_cpu_idle) from [<8005e5d4>] (cpu_startup_entry+0x110/0x14c)
[<8005e5d4>] (cpu_startup_entry) from [<80789c9c>] (start_kernel+0x3d0/0x3dc)
---[ end trace cb88537fdc8fa202 ]---

Begin forwarded message:

Date: Wed, 09 Aug 2023 12:29:07 +0000
From: bugzilla-daemon@kernel.org
To: stephen@networkplumber.org
Subject: [Bug 217772] SoC development environment Linux LAN disconnection


https://bugzilla.kernel.org/show_bug.cgi?id=217772

Ryosuke Motoyoshi (motoyoshi@phoenix-group.co.jp) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
     Kernel Version|                            |Linux 4.4

--- Comment #2 from Ryosuke Motoyoshi (motoyoshi@phoenix-group.co.jp) ---
(In reply to Stephen Hemminger from comment #1)


> Need to know both the kernel config, and which network device is being used.  

Our designer
He said that he uses the Linux kernel as it is, so he doesn't know how to
answer.

> Did you check the kernel log (dmesg).  

Attach separately.

> Check with LWN articles or kernel newbies
> https://kernelnewbies.org/Linux_4.19  

Let me check them in parallel.

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.

