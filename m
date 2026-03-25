Return-Path: <netdev+bounces-271465-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOEAMBWpw2nbtAQAu9opvQ
	(envelope-from <netdev+bounces-271465-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 10:21:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F0F32211C
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 10:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAC263007E16
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 09:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9143345CD3;
	Wed, 25 Mar 2026 09:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="xOo+/+6S"
X-Original-To: netdev@vger.kernel.org
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C32724DFF3;
	Wed, 25 Mar 2026 09:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774429952; cv=none; b=FRjerPndDfgUvfPjolpSNBwTNdio2fvtDb3CzNlXr2g0XJ/igqTPtvQVlrhXqg2w8Bfj7OkKLtB66aTW6yCPj/H9STkJ/QE3IuTCf4zo6SdAwe0g6tFmWYpQZe+0MKt3w0YWNTMg/ZTu6YMf8duQipFiwE5aD3CeMfAILVG9rh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774429952; c=relaxed/simple;
	bh=7sjIAF6Y4pA90r8SW6hjDbE4KQgDXlaYo44sYcV1hYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JQkLFsKcZ899Pi/IGl2XbBGsg34C0WYJy1N6gOmj857TxHAHAJgA8wl7TTAk9R7hHj8Vw+qC8Dcp/xJ24bNNuE5DteSC1nbzet9pcphzUFvTVKKt1StCYZIff6NqIZBhLcOwVjKPd2ccaFIQxm6CpFWR0hHgTTSKFbiK3GLw5xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=xOo+/+6S; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Received: from x1 (39.25.31.150.dy.iij4u.or.jp [150.31.25.39])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 62P9CEN5076027
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 25 Mar 2026 18:12:14 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=edtYkGRJV3gYT9SXCi4jX9/DuvUQzuZSJ7QfmLUWaQ4=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20251215; t=1774429935; v=1;
        b=xOo+/+6SkW+y2AbaNR8+H/hPfyZfkBGEzmUVxJOrhsNwSwQSjrtwCpIO6M0QdiNE
         e6wEfhaM0SgbsUFC9613PXvet01H8SngXCaH4LdacswYnQ/pkRnI8NIB8o5zZOnB
         VzW8h+8oMMc7YYzqJqwA8wwBpoglNxKqFjxE8o6fClKjnejAVHLrdrV53GL4nY/s
         /2HhFxPJ25SsPkVzt3PX/4//13AXm8UKfW/NgLoBm5eqzd6bBWRYilRLyWMiUAT9
         tD1XN6ca/uREXgiD/MlW/TwgA0rscoziopMoJHy3liLd7OZgoHsnwN1Z+i0hFrCr
         d9RbS738WorbeHClr02Ryw==
From: Kohei Enju <kohei@enjuk.jp>
To: syzbot+9db6c624635564ad813c@syzkaller.appspotmail.com
Cc: kuniyu@google.com, andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] [net?] KMSAN: uninit-value in rtl8150_open (2)
Date: Wed, 25 Mar 2026 18:12:09 +0900
Message-ID: <20260325091214.24516-1-kohei@enjuk.jp>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <69c34b1c.050a0220.abc16.000b.GAE@google.com>
References: <69c34b1c.050a0220.abc16.000b.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=963de479f54c6dbb];
	DMARC_POLICY_ALLOW(-0.50)[enjuk.jp,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[enjuk.jp:s=rs20251215];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[kohei@enjuk.jp,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-271465-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,enjuk.jp:dkim,enjuk.jp:mid,appspotmail.com:email,storage.googleapis.com:url];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[enjuk.jp:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev,9db6c624635564ad813c];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 00F0F32211C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

+ Iwashima-san

On Tue, 24 Mar 2026 19:40:28 -0700, syzbot wrote:
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    c612261bedd6 Merge tag 'io_uring-7.0-20260320' of git://gi..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=155801d6580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=963de479f54c6dbb
> dashboard link: https://syzkaller.appspot.com/bug?extid=9db6c624635564ad813c
> compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/aa2bdf537bf6/disk-c612261b.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/8fcd98072431/vmlinux-c612261b.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/737b94c52155/bzImage-c612261b.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+9db6c624635564ad813c@syzkaller.appspotmail.com
>
> usb 2-1: device reset failed
> =====================================================
> BUG: KMSAN: uninit-value in set_carrier drivers/net/usb/rtl8150.c:726 [inline]
> BUG: KMSAN: uninit-value in rtl8150_open+0x1131/0x1360 drivers/net/usb/rtl8150.c:763
>  set_carrier drivers/net/usb/rtl8150.c:726 [inline]
>  rtl8150_open+0x1131/0x1360 drivers/net/usb/rtl8150.c:763
>  __dev_open+0x8e3/0xd40 net/core/dev.c:1702
>  __dev_change_flags+0x32f/0x950 net/core/dev.c:9764
>  netif_change_flags+0x8d/0x1e0 net/core/dev.c:9827
>  dev_change_flags+0x18c/0x320 net/core/dev_api.c:68
>  devinet_ioctl+0x10dd/0x25a0 net/ipv4/devinet.c:1199
>  inet_ioctl+0x4c0/0x6f0 net/ipv4/af_inet.c:1015
>  sock_do_ioctl net/socket.c:1254 [inline]
>  sock_ioctl+0x769/0x1140 net/socket.c:1375
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:597 [inline]
>  __se_sys_ioctl+0x23c/0x400 fs/ioctl.c:583
>  __x64_sys_ioctl+0x97/0xe0 fs/ioctl.c:583
>  x64_sys_call+0x1975/0x3ea0 arch/x86/include/generated/asm/syscalls_64.h:17
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0x134/0xf80 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Local variable tmp.i created at:
>  set_carrier drivers/net/usb/rtl8150.c:723 [inline]
>  rtl8150_open+0xc26/0x1360 drivers/net/usb/rtl8150.c:763
>  __dev_open+0x8e3/0xd40 net/core/dev.c:1702

I see Iwashima-san was previously working on this issue here:
  https://lore.kernel.org/all/20250827233108.3768855-1-kuniyu@google.com/T/

The issue seems to be that set_carrier() ignores the return value of
get_registers() and may use an uninitialized tmp.

rtl8150 appears to have other call sites that use get_registers() the
same way as mentioned in the thread above.

