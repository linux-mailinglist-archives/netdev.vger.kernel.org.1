Return-Path: <netdev+bounces-293817-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uB84BJKsHWondAkAu9opvQ
	(envelope-from <netdev+bounces-293817-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 18:00:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5986B62232C
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 18:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D18AD320145F
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 15:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD83B2749E6;
	Mon,  1 Jun 2026 15:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SNZ0DRN5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291CC37F8C0
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 15:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780328223; cv=none; b=bAX+XR+2LpjinikUQlqoUQgYCudmv6LhL10Fkzlya4aKsGCsTyGeoP5v5JAP1RdthUMrKaLkbAOGgJFPSBovqyrDnFQI+rXWrBVgVorf59u0PpSKjs4qjq9oHEe5PMmTD6mc89yJL2L0zPmMWhUhB1BrRU7cxv+9zYJvzly0p3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780328223; c=relaxed/simple;
	bh=echYVRj5/x66AF2ay7s59L9VxR6d767bHowtgBy2/Qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJyJB/d+upyZlqXUfdq6i+UJm3XFvCJYBCZNqw/MglWdox6EDo3c01A0VfRG3VImMW20puNGz0l3eIz0JuezHmYHHAWNwUDYHog3R2fPJFi8Yt4kXQp+EeVtwSrWuFur25UlQr6PbgNdHSjop2S5/W+YC+qnDkhtQpKSSlpLdCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SNZ0DRN5; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-36bcf3d2565so1705716a91.3
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 08:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780328221; x=1780933021; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0+cFueaoZMxXbMpRDWNCY5m3NUrj+ZOjy/resW0a/c0=;
        b=SNZ0DRN55NYGymFZthDHYRexR4hGT2pLt1QUY6cmHwQtvVDfeVMA+ayhg0bpp8dS8m
         tzqH83g4Zf86LHUpQxUtcChCN6q3LoqKfevSVmpaOtT4hy1OzzX7jKGbmTIYardpeVc3
         FGl50DlXYpksAEYgdcOMgSA4pKhxF81So7deUVjSpMHvFHtSUQtQliS09tWTDIfwqP5b
         tl4eDCq+YjLjukgOw/VrMw+LmRlBDefL0YtEangYlxzYwuK1wukRQuMID0xI/qVHu0/h
         M7h+WJQDakGRdIqxm/L912Eha1VhJlXoipFUITUgbm05Xh1bAUdFAeiX07jZn8XCaKf2
         qegQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780328221; x=1780933021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0+cFueaoZMxXbMpRDWNCY5m3NUrj+ZOjy/resW0a/c0=;
        b=GLUXX+KFSiyIe7GMJFP1qfYv5KaN1bp/shrCymI6rye6AAuxMEEn+HRiRjuOquLjgQ
         nfQ9p4XJ03QrW7fFXUEx6idZwEVP7eUHo8lzmmO9WX5f15jsksT7taTpTFYRDNgt43Y2
         /WE3Q3foEJRcYMhfuwGFmf2jsYRmFI3MTZgq8YPdQPg9Z/GX6wWzsZCOUaRQKltzXe8F
         bTMpnErZWp+A5ysVwNfHOb8ZFAodwBDeve0y/NK27EyJWckxI0MMXJmi0D8JUMgyI7h3
         JEMEqMsCCmisfyZgEHhaIeeXW57ECxcd9iAnAYH0uOaMx3bitGKfTCDT4tVVKDolrA77
         NhNw==
X-Forwarded-Encrypted: i=1; AFNElJ+dk5f+VU7OeMIbf3DAZUjpfCaE6i9Vr53KrRppoTHtYWoH2sd+B6s5BfI/+7/xLGLG/mn9c3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyISEKHGgpV2oJ+Bg39icrmtOWY9rbUaPou7mgBW4LdPep9GtzK
	WqbSYrNoGvHSGGL00VAipUapNLqcJU7tzr6yREJNq0LGGIdEO0asDRsgJslPB+4m
X-Gm-Gg: Acq92OHVJ6vy/U8I6ogcHDmRTkRF7KEJXl3wLMACDjkvCtCHw8vU7Dvn7jpxBpcg1ak
	lOgP2/uTgY6yfcTHk9BZvtmLiahH8MMtHC2og2W9YJUZbWADV/PzDU6k8b/k5T6uuuFxaDH32Kw
	335qgjxJaP5cWhM485LT7Woh1thcGZohyi0NBeh9J194t/rLXhSzJLkGxkGOL6kMzRPXbyEj1/R
	dynQKaNUUpV+3ZBUwvnRJLA/DSN2E1EP5pppmXijE+NEU1Ut6G9syES55y0xBxBxZx49UTdgKJ0
	+HXZ8sE+Jw8WfyWsqDeND6D8sXfckmPfPRLInC4Up2gSyKZlf20HZ0olWFvQ1gejHuH0r81NWte
	ngM3kj8DizNc0EH2e7d8Z73OfI1yhZX+vpW/wT//XDksr1K1bM7PYWRrBlnzM/Cgz4saEsGppw4
	5JtFnbxxaITRtd+JFYPAKL198yoA==
X-Received: by 2002:a17:90b:3d84:b0:369:7421:75cf with SMTP id 98e67ed59e1d1-36c501eb0a7mr12058661a91.16.1780328221317;
        Mon, 01 Jun 2026 08:37:01 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:7::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36dd98797fesm2850a91.13.2026.06.01.08.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 08:37:00 -0700 (PDT)
Date: Mon, 1 Jun 2026 08:37:00 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: syzbot <syzbot+b54df935b5872a351231@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] BUG: sleeping function called from invalid
 context in netif_rx_mode_run
Message-ID: <ah2m_8FVMzJTZKwX@devvm7509.cco0.facebook.com>
References: <6a1a0d30.0a9e871e.332604.0009.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6a1a0d30.0a9e871e.332604.0009.GAE@google.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=a834c6344141a58b];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293817-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devvm7509.cco0.facebook.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,storage.googleapis.com:url,syzkaller.appspot.com:url,appspotmail.com:email,googlegroups.com:email];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,b54df935b5872a351231];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 5986B62232C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 05/29, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    4b4362973b6f Merge branch 'for-next/core' into for-kernelci
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=14a4c62e580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a834c6344141a58b
> dashboard link: https://syzkaller.appspot.com/bug?extid=b54df935b5872a351231
> compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
> userspace arch: arm64
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/f69f86c90ee5/disk-4b436297.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/79fa7b33aaab/vmlinux-4b436297.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/ef080156d0de/Image-4b436297.gz.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+b54df935b5872a351231@syzkaller.appspotmail.com
> 
> netlink: 28 bytes leftover after parsing attributes in process `syz.8.1045'.
> vlan2: left promiscuous mode
> geneve0: left promiscuous mode
> BUG: sleeping function called from invalid context at net/core/dev_addr_lists.c:1262
> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 13679, name: syz.8.1045
> preempt_count: 201, expected: 0
> RCU nest depth: 0, expected: 0
> 2 locks held by syz.8.1045/13679:
>  #0: ffff800089b97600 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
>  #0: ffff800089b97600 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock+0x38/0x10c net/core/rtnetlink.c:341
>  #1: ffff0000d6170e58 (&br->lock){+.-.}-{3:3}, at: spin_lock_bh include/linux/spinlock.h:348 [inline]
>  #1: ffff0000d6170e58 (&br->lock){+.-.}-{3:3}, at: br_port_slave_changelink+0x40/0x15c net/bridge/br_netlink.c:1212
> Preemption disabled at:
> [<ffff8000857ffa50>] spin_lock_bh include/linux/spinlock.h:348 [inline]
> [<ffff8000857ffa50>] br_port_slave_changelink+0x40/0x15c net/bridge/br_netlink.c:1212
> CPU: 0 UID: 0 PID: 13679 Comm: syz.8.1045 Tainted: G             L      syzkaller #0 PREEMPT 
> Tainted: [L]=SOFTLOCKUP
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/18/2026
> Call trace:
>  show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:499 (C)
>  __dump_stack+0x30/0x40 lib/dump_stack.c:94
>  dump_stack_lvl+0xd8/0x12c lib/dump_stack.c:120
>  dump_stack+0x1c/0x28 lib/dump_stack.c:129
>  __might_resched+0x350/0x4ac kernel/sched/core.c:9163
>  __might_sleep+0x84/0xdc kernel/sched/core.c:9092
>  netif_rx_mode_run+0x124/0xb64 net/core/dev_addr_lists.c:1262
>  netif_rx_mode_sync+0x2c/0xbc net/core/dev_addr_lists.c:1428
>  dev_set_promiscuity+0x110/0x1fc net/core/dev_api.c:289
>  br_port_clear_promisc net/bridge/br_if.c:135 [inline]
>  br_manage_promisc+0x2c0/0x33c net/bridge/br_if.c:172
>  nbp_update_port_count+0xf8/0x148 net/bridge/br_if.c:242
>  br_port_flags_change+0x60/0xa8 net/bridge/br_if.c:747
>  br_setport+0xac4/0x1230 net/bridge/br_netlink.c:1000
>  br_port_slave_changelink+0x134/0x15c net/bridge/br_netlink.c:1213
>  rtnl_changelink net/core/rtnetlink.c:3793 [inline]
>  __rtnl_newlink net/core/rtnetlink.c:3973 [inline]
>  rtnl_newlink+0xf80/0x113c net/core/rtnetlink.c:4110
>  rtnetlink_rcv_msg+0x66c/0x9c8 net/core/rtnetlink.c:6996
>  netlink_rcv_skb+0x22c/0x410 net/netlink/af_netlink.c:2550
>  rtnetlink_rcv+0x28/0x38 net/core/rtnetlink.c:7023
>  netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
>  netlink_unicast+0x610/0x800 net/netlink/af_netlink.c:1344
>  netlink_sendmsg+0x63c/0x920 net/netlink/af_netlink.c:1894
>  sock_sendmsg_nosec net/socket.c:787 [inline]
>  __sock_sendmsg+0xc8/0x138 net/socket.c:802
>  ____sys_sendmsg+0x418/0x70c net/socket.c:2698
>  ___sys_sendmsg+0x198/0x224 net/socket.c:2752
>  __sys_sendmsg+0x160/0x214 net/socket.c:2784
>  __do_sys_sendmsg net/socket.c:2789 [inline]
>  __se_sys_sendmsg net/socket.c:2787 [inline]
>  __arm64_sys_sendmsg+0x80/0x94 net/socket.c:2787
>  __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>  invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
>  el0_svc_common+0xe8/0x23c arch/arm64/kernel/syscall.c:121
>  do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:140
>  el0_svc+0x64/0x260 arch/arm64/kernel/entry-common.c:740
>  el0t_64_sync_handler+0x48/0x148 arch/arm64/kernel/entry-common.c:759
>  el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:594
> geneve0: entered promiscuous mode
> bridge0: port 2(bridge_slave_1) entered disabled state
> bridge_slave_1: left allmulticast mode
> bridge_slave_1: left promiscuous mode
> bridge0: port 2(bridge_slave_1) entered disabled state
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title

#syz fix: bridge: Fix sleep in atomic context in netlink path

