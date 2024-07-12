Return-Path: <netdev+bounces-111085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F3392FD05
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 16:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED185284905
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 14:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54A7172BAE;
	Fri, 12 Jul 2024 14:56:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7571E4A9
	for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 14:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720796203; cv=none; b=emudwYizVcZHASEQVzh19IbseNWSmpR/RZSXHyEroYB62HC1JgBkgmu58fA6AOezkI16MnT4p9VXwGWv6gQ5fVl0CAOKtONpARt5oEbHaasOC0KUJYYI9gai0JPSG7RkDO5T8tGY0bB+bijl/K88qzF9Wc+Gi9CBI0K4Rpg/llI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720796203; c=relaxed/simple;
	bh=qosK8kyeYcgCOZq0j3+LMVxskVgvLDpUzlaOw5qjIC8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IRg25m3XTBKSPQOt5Pnh1Z88yqzBfG3lnZS7tUvHZeIz83/BUET2vjJf7HgwrUcnGlnj8swtRlLQZ/RUpCcQWTn1b41eOeKmqjCDBDXIef9HT0kWLIEyT0AgVtGQiLcptRrG51TkP9x3ri5BCpYzcptoyuEKYPnMNcczgcpqC5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a77dc08db60so263153966b.1
        for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 07:56:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720796200; x=1721401000;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bGDz4ahuF9yVsDXMP9oVtmyKtWQnnlex8CnWjbAFYtY=;
        b=Yb1zhQmQLwqTWvOrTye3/E5fGuB55S3Jo2ykLw6/UqNOSY6R84aAit2JH8Swmq2o/e
         ftBUQqXceu5F46pFIdRVWI54C+4GNgmrqLvQB5dML1Osx57f65sf5D+hPDnkCRXXeoku
         LViBSWwGrxVp8NFKkhz085d7bhtLYuyw802wo4EQX7uMrdGSVmnggUVsm7eXhC282zal
         j42iyTRPZqScSo6OuEWDIddAYJ2+e1OButBWQp1k1OWDLRHQMFBbZVXqdWOEjiKP2In8
         pQzYmthxBLFl7lRRRgk1lzGe61XkdT/EaGYvyhznZ1RPA5gGEsuGyRCl8x9JSmaPdYau
         /+pQ==
X-Gm-Message-State: AOJu0Yzok3b0//fWQ4f2tF1Yi8eAMZvzrtXNrsG13YRorZu293Za6TFG
	yxN5Z0hUQxwn7aK10AuC+NPPQfXc5Oar5XjPd2Oej5l9wNdF0jRfd1cdYA==
X-Google-Smtp-Source: AGHT+IFl/NKU278rbk3PiMoys33DrCCbsLcoCWu9qujXlpNyNnPxP3jmSTuIfqBR4Io/dRGs/2TKAg==
X-Received: by 2002:a17:906:f6d5:b0:a75:3c2d:cd8e with SMTP id a640c23a62f3a-a780b6b1941mr753787166b.27.1720796200268;
        Fri, 12 Jul 2024 07:56:40 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-004.fbsv.net. [2a03:2880:30ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6e1737sm349866566b.89.2024.07.12.07.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 07:56:39 -0700 (PDT)
Date: Fri, 12 Jul 2024 07:56:37 -0700
From: Breno Leitao <leitao@debian.org>
To: michael.chan@broadcom.com, kuba@kernel.org
Cc: netdev@vger.kernel.org
Subject: net: bnxt: Crash on 6.10 ioctl
Message-ID: <ZpFEJeNpwxW1aW9k@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

Testing commit 24ca36a562 ("Merge tag 'wq-for-6.10-rc5-fixes' of
git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq") I am getting the
following crash in bnxt driver:

	BUG: kernel NULL pointer dereference, address: 00000000000000b8
	#PF: supervisor read access in kernel mode
	#PF: error_code(0x0000) - not-present page
	PGD 0 P4D 0
	Oops: Oops: 0000 [#1] SMP
	Hardware name: ...
	RIP: 0010:bnxt_get_max_rss_ctx_ring (drivers/net/ethernet/broadcom/bnxt/bnxt.c:?)
	Code: e7 03 44 89 ca 83 e2 fc 31 c0 eb 19 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 4d 8b 12 4d 39 f2 0f 84 92 00 00 00 45 85 c9 74 ef <49> 8b b2 b8 00 00 00 31 db 49 83 f8 03 73 30 48 85 ff 74 db 48 8d
	All code
	========
	   0:	e7 03                	out    %eax,$0x3
	   2:	44 89 ca             	mov    %r9d,%edx
	   5:	83 e2 fc             	and    $0xfffffffc,%edx
	   8:	31 c0                	xor    %eax,%eax
	   a:	eb 19                	jmp    0x25
	   c:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
	  13:	00 00 00
	  16:	0f 1f 00             	nopl   (%rax)
	  19:	4d 8b 12             	mov    (%r10),%r10
	  1c:	4d 39 f2             	cmp    %r14,%r10
	  1f:	0f 84 92 00 00 00    	je     0xb7
	  25:	45 85 c9             	test   %r9d,%r9d
	  28:	74 ef                	je     0x19
	  2a:*	49 8b b2 b8 00 00 00 	mov    0xb8(%r10),%rsi		<-- trapping instruction
	  31:	31 db                	xor    %ebx,%ebx
	  33:	49 83 f8 03          	cmp    $0x3,%r8
	  37:	73 30                	jae    0x69
	  39:	48 85 ff             	test   %rdi,%rdi
	  3c:	74 db                	je     0x19
	  3e:	48                   	rex.W
	  3f:	8d                   	.byte 0x8d

	Code starting with the faulting instruction
	===========================================
	   0:	49 8b b2 b8 00 00 00 	mov    0xb8(%r10),%rsi
	   7:	31 db                	xor    %ebx,%ebx
	   9:	49 83 f8 03          	cmp    $0x3,%r8
	   d:	73 30                	jae    0x3f
	   f:	48 85 ff             	test   %rdi,%rdi
	  12:	74 db                	je     0xffffffffffffffef
	  14:	48                   	rex.W
	  15:	8d                   	.byte 0x8d
	RSP: 0018:ffffc900014d3cb8 EFLAGS: 00010202
	RAX: 0000000000000000 RBX: 0000000000000008 RCX: 0000000000000001
	RDX: 0000000000000080 RSI: 0000000000000206 RDI: 0000000000000000
	RBP: 00000000ffffffea R08: 000000000000007f R09: 0000000000000080
	R10: 0000000000000000 R11: 00000003246184b4 R12: 00007ffc260f65c0
	R13: ffff888103158000 R14: ffff888103158978 R15: ffff888103158840
	FS:  00007fbc65e3e940(0000) GS:ffff88903fe40000(0000) knlGS:0000000000000000
	CR2: 00000000000000b8 CR3: 0000000109c98003 CR4: 00000000007706f0
	05:56:10  PKRU: 55555554
	Call Trace:
	<TASK>
	? __die_body (arch/x86/kernel/dumpstack.c:421)
	? page_fault_oops (arch/x86/mm/fault.c:711)
	? schedule_hrtimeout_range_clock (kernel/time/hrtimer.c:1449 kernel/time/hrtimer.c:2293)
	? exc_page_fault (./arch/x86/include/asm/irqflags.h:37 ./arch/x86/include/asm/irqflags.h:72 arch/x86/mm/fault.c:1489 arch/x86/mm/fault.c:1539)
	? asm_exc_page_fault (./arch/x86/include/asm/idtentry.h:623)
	? bnxt_get_max_rss_ctx_ring (drivers/net/ethernet/broadcom/bnxt/bnxt.c:?)
	? bnxt_get_max_rss_ctx_ring (drivers/net/ethernet/broadcom/bnxt/bnxt.c:?)
	bnxt_set_channels
	ethtool_set_channels (net/ethtool/ioctl.c:1941)
	dev_ethtool (net/ethtool/ioctl.c:? net/ethtool/ioctl.c:3177)
	dev_ioctl (net/core/dev_ioctl.c:?)
	sock_do_ioctl (net/socket.c:1236)
	sock_ioctl (net/socket.c:1341)
	__se_sys_ioctl (fs/ioctl.c:52 fs/ioctl.c:907 fs/ioctl.c:893)
	do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)

Are you aware of this problem?
Unfortunately I don't have a reproducer at this time.

Thanks

