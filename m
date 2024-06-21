Return-Path: <netdev+bounces-105736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8368912850
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 16:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0C63281A4C
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 14:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767C32C69B;
	Fri, 21 Jun 2024 14:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="dcAgLZKf"
X-Original-To: netdev@vger.kernel.org
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC113F9D2;
	Fri, 21 Jun 2024 14:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718981164; cv=none; b=WCrtXrXDk9iHtFtoqEccgpXpAgDWVLcatXj2i9LCES96J09XGO77vz4G/qswifKUBc38SFgkuJD5cfctJQCKvpIA0SoH+/lIc6w/in4rdUpquPEdNTu0lddKsKnzenvF+jqn3SBpjWJRJM3hRFNFGqw+jqhkBx/zTom4k9Vx2CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718981164; c=relaxed/simple;
	bh=W6VBJEwx7GaHn5dQ6gebVajgnfevDIVyEUvNR5fSpkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bO6g9URfrES/1fCgfSuQqT+k0qkOgEyNSLE4AT29yAZBq2cb0ZpbZ6bi6f4IqF995zQ9ctbgPtrXak63Bez6La/ICLS9YFd7AyaTHQ8vi4s9Hl+S8GAlErrmUUMb7fba0oeGA0osDHycbtz1zhY0H5BkyXS8sjUAAtWxdl9OCz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=dcAgLZKf; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Date: Fri, 21 Jun 2024 17:45:49 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1718981149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kL1ojzvjz94owNmxXJ9QV4NNgpW2IzPOdeNUTrGd78E=;
	b=dcAgLZKfdNVw9IhB1RBz6m2tAu0hBNEskLCy03eFn23fWrwd9dAN74261/ZUN8Cgf4aHjO
	782EPFrRWZC9zbDLsqJ3C6ynSlWmYYaQj5oAE/Q9N/vsPWrudJhpHgYR0Buw/5hb+6B9yy
	nOESNV8qR4H4bjNvU+9JqKWlg4o7WJ4=
From: Andrey Kalachev <kalachev@swemel.ru>
To: syzbot <syzbot+e738404dcd14b620923c@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, kuznet@ms2.inr.ac.ru,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, yoshfuji@linux-ipv6.org
Subject: Re: [syzbot] WARNING in ip_rt_bug (2)
Message-ID: <ZnWSHbkV6qVy1KHd@ural>
References: <000000000000b1060905eada8881@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <000000000000b1060905eada8881@google.com>

On Wed, Oct 12, 2022 at 11:26:40AM -0700, syzbot wrote:
>Hello,
>
>syzbot found the following issue on:
>
>HEAD commit:    a0ba26f37ea0 Merge git://git.kernel.org/pub/scm/linux/kern..
>git tree:       net
>console output: https://syzkaller.appspot.com/x/log.txt?x=1594a825e00000
>kernel config:  https://syzkaller.appspot.com/x/.config?x=27392dd2975fd692
>dashboard link: https://syzkaller.appspot.com/bug?extid=e738404dcd14b620923c
>compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16851c6de00000
>C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11f5d605e00000
>
>Bisection is inconclusive: the issue happens on the oldest tested release.
>
>bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1422a825e00000
>final oops:     https://syzkaller.appspot.com/x/report.txt?x=1622a825e00000
>console output: https://syzkaller.appspot.com/x/log.txt?x=1222a825e00000
>
>IMPORTANT: if you fix the issue, please add the following tag to the commit:
>Reported-by: syzbot+e738404dcd14b620923c@syzkaller.appspotmail.com
>
>syz-executor857 uses obsolete (PF_INET,SOCK_PACKET)
>------------[ cut here ]------------
>WARNING: CPU: 1 PID: 7033 at net/ipv4/route.c:1243 ip_rt_bug+0x11/0x20 net/ipv4/route.c:1242
>Kernel panic - not syncing: panic_on_warn set ...
>CPU: 1 PID: 7033 Comm: syz-executor857 Not tainted 5.6.0-rc7-syzkaller #0
>Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>Call Trace:
> __dump_stack lib/dump_stack.c:77 [inline]
> dump_stack+0x188/0x20d lib/dump_stack.c:118
> panic+0x2e3/0x75c kernel/panic.c:221
> __warn.cold+0x2f/0x35 kernel/panic.c:582
> report_bug+0x27b/0x2f0 lib/bug.c:195
> fixup_bug arch/x86/kernel/traps.c:174 [inline]
> fixup_bug arch/x86/kernel/traps.c:169 [inline]
> do_error_trap+0x12b/0x220 arch/x86/kernel/traps.c:267
> do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:286
> invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
>RIP: 0010:ip_rt_bug+0x11/0x20 net/ipv4/route.c:1243
>Code: ff ff e8 c2 d7 33 fb e9 eb fe ff ff e8 b8 d7 33 fb e9 59 ff ff ff 0f 1f 00 55 48 89 d5 e8 17 0e f7 fa 48 89 ef e8 6f 0c 8f ff <0f> 0b 31 c0 5d c3 66 0f 1f 84 00 00 00 00 00 41 54 49 89 fc e8 f6
>RSP: 0018:ffffc90001937300 EFLAGS: 00010293
>RAX: ffff8880a2bc2540 RBX: 0000000000000000 RCX: 0000000000000000
>RDX: 0000000000000000 RSI: ffffffff867b1711 RDI: 0000000000000286
>RBP: ffff8880a31fb940 R08: 0000000000000000 R09: ffffed1015ce7074
>R10: ffffed1015ce7073 R11: ffff8880ae73839b R12: ffff8880970b0e00
>R13: ffff8880a31fb940 R14: ffff8880a4a71240 R15: ffff8880a31fb998
> dst_output include/net/dst.h:436 [inline]
> ip_local_out+0xaf/0x1a0 net/ipv4/ip_output.c:125
> ip_send_skb+0x3e/0xe0 net/ipv4/ip_output.c:1560
> ip_push_pending_frames+0x5f/0x80 net/ipv4/ip_output.c:1580
> icmp_push_reply+0x33f/0x490 net/ipv4/icmp.c:390
> __icmp_send+0xc44/0x14a0 net/ipv4/icmp.c:740
> icmp_send include/net/icmp.h:43 [inline]
> ip_options_compile+0xad/0xf0 net/ipv4/ip_options.c:486
> ip_rcv_options net/ipv4/ip_input.c:278 [inline]
> ip_rcv_finish_core.isra.0+0x4aa/0x1ec0 net/ipv4/ip_input.c:370
> ip_rcv_finish+0x144/0x2f0 net/ipv4/ip_input.c:426
> NF_HOOK include/linux/netfilter.h:307 [inline]
> NF_HOOK include/linux/netfilter.h:301 [inline]
> ip_rcv+0xd0/0x3c0 net/ipv4/ip_input.c:538
> __netif_receive_skb_one_core+0xf5/0x160 net/core/dev.c:5187
> __netif_receive_skb+0x27/0x1c0 net/core/dev.c:5301
> netif_receive_skb_internal net/core/dev.c:5391 [inline]
> netif_receive_skb+0x16e/0x960 net/core/dev.c:5450
> tun_rx_batched.isra.0+0x47b/0x7d0 drivers/net/tun.c:1553
> tun_get_user+0x134a/0x3be0 drivers/net/tun.c:1997
> tun_chr_write_iter+0xb0/0x147 drivers/net/tun.c:2026
> call_write_iter include/linux/fs.h:1902 [inline]
> new_sync_write+0x49c/0x700 fs/read_write.c:483
> __vfs_write+0xc9/0x100 fs/read_write.c:496
> vfs_write+0x262/0x5c0 fs/read_write.c:558
> ksys_write+0x127/0x250 fs/read_write.c:611
> do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:294
> entry_SYSCALL_64_after_hwframe+0x49/0xbe
>RIP: 0033:0x440699
>Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
>RSP: 002b:00007fffce0515b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
>RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000440699
>RDX: 000000000000100c RSI: 0000000020000240 RDI: 0000000000000005
>RBP: 0000000000000000 R08: 0000000000002c00 R09: 00007fff0000000d
>R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401f20
>R13: 0000000000401fb0 R14: 0000000000000000 R15: 0000000000000000
>Kernel Offset: disabled
>Rebooting in 86400 seconds..
>
>
>---
>This report is generated by a bot. It may contain errors.
>See https://goo.gl/tpsmEJ for more information about syzbot.
>syzbot engineers can be reached at syzkaller@googlegroups.com.
>
>syzbot will keep track of this issue. See:
>https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>syzbot can test patches for this issue, for details see:
>https://goo.gl/tpsmEJ#testing-patches

Hello all!

Here a simple "humanitized" reproducer for WARNING-in-ip_rt_bug.

It's looks cryptic a bit, so, may be network subsystem mantainers has some thoughts about.

--

/* WARNING in ip_rt_bug (2)
  *
  * syzkaller bug links:
  * https://syzkaller.appspot.com/bug?id=702906331957f4cfed2a64192e9bc6bfb668bf58
  * https://syzkaller.appspot.com/bug?extid=e738404dcd14b620923c
  *
  * crash links:
  * crash date: 2022/02/07
  * kernel:     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/?id=d8ad2ce873abab1cfd38779c626b79cef6307aac
  * syzkaller:  https://github.com/google/syzkaller/commits/a7dab6385c1d95547a88e22577fb56fbcd5c37eb
  * config:     https://syzkaller.appspot.com/text?tag=KernelConfig&x=6f043113811433a5
  * crash log:  https://syzkaller.appspot.com/text?tag=CrashLog&x=17244b58700000
  * report:     https://syzkaller.appspot.com/text?tag=CrashReport&x=1512f108700000
  * c-repro:    https://syzkaller.appspot.com/text?tag=ReproC&x=12bb07c8700000
  * syz-repro:  https://syzkaller.appspot.com/text?tag=ReproSyz&x=16ee284fb00000
  */

#define _GNU_SOURCE

#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <errno.h>
#include <fcntl.h>
#include <arpa/inet.h>
#include <net/if.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <linux/ip.h>
#include <linux/in.h>
#include <linux/if_tun.h>
#include <linux/netlink.h>
#include <linux/virtio_net.h>

#if 0 
// 10 byte virtio_net_hdr + 44 ip packet size (from header) = 54
const char b[54] =
"\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
"\x48\x00\x00\x2c\x00\x00\x00\x00\x00\x2f"
"\x42\xc0\xac\x14\x14\x00\xac\x14\x08\xbb"
"\x0d\x00\xf2\xff\x00\x00\x00\x00\x00\x00"
"\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
"\x00\x00\x00\x00";
#endif

#define IP4_SRC_ADDR "172.20.20.0"
#define IP4_DST_ADDR "172.20.8.187"

union misericorde {
	struct __attribute__ ((__packed__)) {
		struct virtio_net_hdr v;
		struct iphdr ip;
		char   opt[12];//_u32   options[3];
	} h;
	char placeholder[54];
} m = {
	.h = {
		.ip={
			.version  = 4,
			.ihl      = 8,
			.protocol = IPPROTO_GRE,
		},
		.opt = "\x0d\x00\xf2\xff",
	}
};

const struct ifreq ifr_tuns = { "syzkaller1", (IFF_TUN|IFF_NO_PI|IFF_VNET_HDR) };

// { "syzkaller1", (IFF_UP|IFF_BROADCAST|IFF_DEBUG) }; // original repro
const struct ifreq ifr_sioc = { "syzkaller1", (IFF_UP) }; 

int main(void)
{
	int tun, route, ret;

	inet_pton(AF_INET, IP4_SRC_ADDR, &m.h.ip.saddr);
	inet_pton(AF_INET, IP4_DST_ADDR, &m.h.ip.daddr);
	m.h.ip.tot_len = htons(44);
	m.h.ip.check   = htons(0x42c0);

	system("ip xfrm policy update src 254.136.0.0/0 dst 255.1.0.0/0 dir out flag icmp");

	// ioctl return error, but change state
	tun = openat(AT_FDCWD, "/dev/net/tun", O_RDWR|O_LARGEFILE|O_CLOEXEC);
	ret = ioctl(tun, TUNSETIFF, &ifr_tuns); // TUNSETIFF ioctl ret: -1 errno: EFAULT (14)
	fprintf(stderr, "TUNSETIFF ioctl ret: %d errno: %d\n", ret, errno);

	route = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
	ret = ioctl(route, SIOCSIFFLAGS, &ifr_sioc); // SIOCSIFFLAGS ioctl ret: 0
	fprintf(stderr, "SIOCSIFFLAGS ioctl ret: %d errno: %d\n", ret, errno);
	
	// call write() ..
	// randoms in `ip options`: "\x0d\x00\xf2\xff", ip_options_compile() return EINVAL (-22)
	// so, unsuccessful attempt to send ICMP PARAMETERPROB back
	ret = write(tun, &m, sizeof(m)); //  ip_rt_bug: IPv4: ip_rt_bug: 172.20.8.187 -> 172.20.20.0, ?
	fprintf(stderr, "write ret: %d errno: %d\n", ret, errno); // write ret: 54
}

--

Regards,
Andrey.

