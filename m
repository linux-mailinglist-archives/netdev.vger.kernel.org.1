Return-Path: <netdev+bounces-255734-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCqSIKtGgGkE5gIAu9opvQ
	(envelope-from <netdev+bounces-255734-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 07:39:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E62C8E0A
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 07:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 55FCA3011F66
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 06:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316C83033FB;
	Mon,  2 Feb 2026 06:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zs6BR8BD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com [209.85.219.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF1A2FCBF0
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 06:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770013843; cv=pass; b=FBxGe2cI3JvNoEBaj5GxwuMmKZuiY90K1yFFrlQdX2W3iZMs6zMFctZI3vrWwgBwNLXXrAap2XqW0zDkqUausnlN7wUmn6xiRyMeInpTllQJObgS9JMbpIIVy4FTYMdvkJCIcUvGXCW9sfdYKLaSzJQlMK4B69gMtNnEJUU70vA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770013843; c=relaxed/simple;
	bh=0zraJzkxOajgXTgtKkUFw2uXCSWJ9QuHB8iGSCYjh90=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=OZrRSA60qHUUUyAsgFqXiwo2p3VXsMULB5LkqV0tQNgR2AlzKPqhpbCv/KiFAbJjPYPmkpHt+UVSbOPIR88nWY/LCX3HDtBbHl80ZIqH77OxF2kh7GTjG6Px13bn7CVa5van+Xt1RkH2ZiPmVgjDPdl+hO3t7Rui9P+CSJENiH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zs6BR8BD; arc=pass smtp.client-ip=209.85.219.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f68.google.com with SMTP id 6a1803df08f44-88888c41a13so53107746d6.3
        for <netdev@vger.kernel.org>; Sun, 01 Feb 2026 22:30:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770013840; cv=none;
        d=google.com; s=arc-20240605;
        b=dnZkIjYqOIy5Z7a68OQCKs98HMQcL8bLiDlP5soZDXkr3oMIatBwZUh4fWtSO0oQ4y
         oQyEjYNwicz0iJEUzcJGtOK5zAm9gOdCSKGT4tY3hxWzarOCf+t3avFkKkVOEWZRU+Hh
         aW6YeZR9M70wrIE53pQ+2ZMZeHwZ59pi+AmrhMGuBzWp2G3ygIIj8RPJmQr2OsNHtGXC
         rTXVffvs/khZXznzMMH3DzKNlVNPHgo6ntSzF/jRbDhP9njeHD9hGjfmjQ0SYLlyGrc0
         02h5m6B4fq/R6Sh0oeUiMlXRrDalQbNoy5rTDduCzuRJSiSvgySiRV8Sh7fpAuxQW9/W
         Eoow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=2y6ySxf5NVRWcDzQ+3oBiGHXVLADtYNaXVj1D+wkB4w=;
        fh=0MZHTIZSOTnyU9O5PV+kSpyb88pl47JZ+e3WYORTrsE=;
        b=Htq8mmGeHI3IOKq+jVqj7zwFXVp0TxUcT7GTxmE6EfrbAqo8CImXS+YB/u+4vvTGil
         DqfkdqaG8/KivuHeJMIH9aTsO4/l0gE0QioudwZxfcvE7avxZ13qozWgx/knS7oCMopc
         6+nxZXilFQmzKiCgpP2QTELcwNknSqXTuGhUTZN892aoBfEDIGyU+4/4NXe11GJ73xWP
         NssUyxhZNehHP41FNh64mr5WLqvEsgi/enNzppV2Mb1voy1FhqZONICG4RUTfSr0ix2Y
         esnoNuMQpaJXnApP4xD9KnayPv6lJBKE9RPWFextievCrQX7r0Rdi029kenjN+GUzyAe
         dwaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770013840; x=1770618640; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2y6ySxf5NVRWcDzQ+3oBiGHXVLADtYNaXVj1D+wkB4w=;
        b=Zs6BR8BDGeElumZqvczw/a1hgdmHV1aLR1+GI72N3t3uVKYMKEndZs+r3MOsZ6A/AB
         861elzNLEF7Ms+OoxFrMl3Xc232CN30PTAT6uly+cwaRdLCliDJ1Pz2YZpHPL2TtK2vY
         NcCDBfb295DZxajjzZmrAhdZFtGoR99XzZBsClIPEUT2ENaE0gQ85FnJUDP3HBoeOwUF
         LN90gHJMtSFxJFeSwjZTHqUStybH4MMyHwH8piUYU42R3Xh3jaPhjKLPUn5EVQTAEcoa
         4vhZP8t0VGq64AkySlGF7YGp/tiQhnqhQcRYv2IMWVArw+goQZ17ak1nMF7JHiPJg6oD
         C4WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770013840; x=1770618640;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2y6ySxf5NVRWcDzQ+3oBiGHXVLADtYNaXVj1D+wkB4w=;
        b=p+zgx0uoaqueVrieMpJi8BpHZYMgvEEbGx/MYtN7zAO9L+iUq+wOJpvvAAsW3b8wNm
         O1AdCKgdKCHBH49N77wof2Sp5ppnV2ZmwQCxH3M+ldkjy1x+44fvsEVrTytEcsBQKmPa
         LA61acH6uiuBSf77yc74d/uWjsG/U01fzjeMV0oAdjgyZ5zk3AmGGtV5Fs9580wMpSob
         FhHWQXfasnv9PdYCqa2udmsT2key/vU+B2ViqSRhZjj4JkYwqHutBwi5ZNGB2o/Bv9gu
         uG7B2tbjSkDteyt+7SuUxT3FapoIJAypduY7vc/Qwfsj/LAJbBlekIMPOOaSC0oONtwn
         HO/A==
X-Forwarded-Encrypted: i=1; AJvYcCUxf+IakK7AQhqw/thjqZCsZaK1TRUohZb/GmrNuaz+5C1Nzhp+WtFIOf2NTNqOrBEHGlpaWpI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhn5blEAOUlDbteeKiK9KjcdYbQFp/jVanQgOQ+v2UlXB/EXTX
	m0rUFq4funT01ZDI2JlwTWBhbXHFJ0+UtccxPQrsO152ohzUJI7jPozRaD0eH9B2vmvnQLeaiTc
	huoQKnEXwosWVpbeMOza2Trav5Ybs+RQ=
X-Gm-Gg: AZuq6aL2MyFa8Z5PjxrekVsV4YxrnkYeHeyUGLI2cyqlbdELBRI8T+0aSOP5C+C3ob4
	+A8ZQBVAeGRuk4SUPUaE4ozz8mSmVCgftxyjK5WWoMSfzdegNVb2y/q6cUOOg87GVpIbkD7NkVM
	5R2eB+HqjGgC0Z8ArIhFt9998X9xtSs7VAExr1wyE3zqqLCDi4pJixW06yK7F+/31FAazFX7ox4
	7HbMktKngoly98CjJZFuNWjMm0TiI7mwsZJa1pLqztjxfdEbtZUd/8E+srbtftRj5oZqueo3Tci
	ygPGcwSc4h2CDOm3p15RUovJ7Q==
X-Received: by 2002:a05:6214:5014:b0:894:6f21:3138 with SMTP id
 6a1803df08f44-894ea021037mr156253926d6.45.1770013839953; Sun, 01 Feb 2026
 22:30:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?5p2O6b6Z5YW0?= <coregee2000@gmail.com>
Date: Mon, 2 Feb 2026 14:30:28 +0800
X-Gm-Features: AZwV_QhYYkmtXjFL7ZCH2_jrIfOuTZMZ8Ea49A-mLoShnudMUuffcVum-dUymCc
Message-ID: <CAHPqNmyOxnhrqOCkbBXqHOPN0AU5GmzEsNLDbi9vU42skk0aCg@mail.gmail.com>
Subject: [Kernel Bug] possible deadlock in ipv6_mc_config
To: syzkaller@googlegroups.com, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255734-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[coregee2000@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: B1E62C8E0A
X-Rspamd-Action: no action

Dear Linux kernel developers and maintainers,

We would like to report a new kernel bug found by our tool. possible
deadlock in ipv6_mc_config. Details are as follows.

Kernel commit: v6.18.2
Kernel config: see attachment
report: see attachment

We are currently analyzing the root cause and  working on a
reproducible PoC. We will provide further updates in this thread as
soon as we have more information.

Best regards,
Longxing Li

======================================================
WARNING: possible circular locking dependency detected
6.18.2 #1 Not tainted
------------------------------------------------------
syz.1.2664/55127 is trying to acquire lock:
ffffffff8e364140 (fs_reclaim){+.+.}-{0:0}, at: might_alloc
include/linux/sched/mm.h:318 [inline]
ffffffff8e364140 (fs_reclaim){+.+.}-{0:0}, at: slab_pre_alloc_hook
mm/slub.c:4929 [inline]
ffffffff8e364140 (fs_reclaim){+.+.}-{0:0}, at: slab_alloc_node
mm/slub.c:5264 [inline]
ffffffff8e364140 (fs_reclaim){+.+.}-{0:0}, at: __do_kmalloc_node
mm/slub.c:5649 [inline]
ffffffff8e364140 (fs_reclaim){+.+.}-{0:0}, at:
__kmalloc_noprof+0xc3/0x880 mm/slub.c:5662

but task is already holding lock:
ffff88810d75e558 (k-sk_lock-AF_INET6){+.+.}-{0:0}, at: lock_sock
include/net/sock.h:1679 [inline]
ffff88810d75e558 (k-sk_lock-AF_INET6){+.+.}-{0:0}, at:
ipv6_mc_config+0x42/0xf0 net/ipv6/addrconf.c:3000

which lock already depends on the new lock.

...

other info that might help us debug this:

Chain exists of:
  fs_reclaim --> sk_lock-AF_INET6 --> k-sk_lock-AF_INET6

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(k-sk_lock-AF_INET6);
                               lock(sk_lock-AF_INET6);
                               lock(k-sk_lock-AF_INET6);
  lock(fs_reclaim);

 *** DEADLOCK ***

2 locks held by syz.1.2664/55127:
 #0: ffffffff8fee6948 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock
include/linux/rtnetlink.h:130 [inline]
 #0: ffffffff8fee6948 (rtnl_mutex){+.+.}-{4:4}, at:
inet6_rtm_newaddr+0x4e4/0x1c70 net/ipv6/addrconf.c:5027
 #1: ffff88810d75e558 (k-sk_lock-AF_INET6){+.+.}-{0:0}, at: lock_sock
include/net/sock.h:1679 [inline]
 #1: ffff88810d75e558 (k-sk_lock-AF_INET6){+.+.}-{0:0}, at:
ipv6_mc_config+0x42/0xf0 net/ipv6/addrconf.c:3000

stack backtrace:
CPU: 0 UID: 0 PID: 55127 Comm: syz.1.2664 Not tainted 6.18.2 #1 PREEMPT(full)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_circular_bug+0x275/0x350 kernel/locking/lockdep.c:2043
 check_noncircular+0x14c/0x170 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3165 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain kernel/locking/lockdep.c:3908 [inline]
 __lock_acquire+0x126f/0x1c90 kernel/locking/lockdep.c:5237
 lock_acquire kernel/locking/lockdep.c:5868 [inline]
 lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5825
 __fs_reclaim_acquire mm/page_alloc.c:4264 [inline]
 fs_reclaim_acquire+0x102/0x150 mm/page_alloc.c:4278
 might_alloc include/linux/sched/mm.h:318 [inline]
 slab_pre_alloc_hook mm/slub.c:4929 [inline]
 slab_alloc_node mm/slub.c:5264 [inline]
 __do_kmalloc_node mm/slub.c:5649 [inline]
 __kmalloc_noprof+0xc3/0x880 mm/slub.c:5662
 kmalloc_noprof include/linux/slab.h:961 [inline]
 sock_kmalloc+0x111/0x170 net/core/sock.c:2850
 __ipv6_sock_mc_join+0x3ef/0x8f0 net/ipv6/mcast.c:216
 ipv6_mc_config+0x64/0xf0 net/ipv6/addrconf.c:3002
 inet6_addr_add+0x1f2/0x960 net/ipv6/addrconf.c:3039
 inet6_rtm_newaddr+0x1619/0x1c70 net/ipv6/addrconf.c:5059
 rtnetlink_rcv_msg+0x95e/0xe90 net/core/rtnetlink.c:6951
 netlink_rcv_skb+0x158/0x420 net/netlink/af_netlink.c:2552
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x5aa/0x870 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x8c8/0xdd0 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 ____sys_sendmsg+0xa98/0xc70 net/socket.c:2630
 ___sys_sendmsg+0x134/0x1d0 net/socket.c:2684
 __sys_sendmsg+0x16d/0x220 net/socket.c:2716
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x5656ed
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4a9d192fc8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000715f80 RCX: 00000000005656ed
RDX: 0000000000000000 RSI: 00000000200001c0 RDI: 0000000000000048
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000715f8c
R13: 0000000000000000 R14: 0000000000715f80 R15: 00007f4a9d173000
 </TASK>

https://drive.google.com/file/d/17HbDTI_iPjA72SkV5MnO-_w7IQZ9HIHW/view?usp=drive_link

https://drive.google.com/file/d/1xHrRE-c-KtJRuWz_HLANn7z5r-LKYC4v/view?usp=drive_link

