Return-Path: <netdev+bounces-264704-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPYzB/WFqmkhTAEAu9opvQ
	(envelope-from <netdev+bounces-264704-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 08:44:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADD921C98E
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 08:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DD9803013244
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 07:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1817366DD2;
	Fri,  6 Mar 2026 07:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="VjO/guHN"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002DB364E8A;
	Fri,  6 Mar 2026 07:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772783089; cv=none; b=QWqMCy91+n3DUkbQeTpUgZIgbJogNFRjhDHOMs0eRCqKudQl9rhloq5qs6MSLCZVDmr7onRexxIp0ym3m9TsLf2qcjfj+mrboG1IUPOSICgUXlFDAuv1kH7RRnOVgzQZ4CmsEya0rzp95cpCzw35wmJR68C9hAUBW1gb6FsAQq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772783089; c=relaxed/simple;
	bh=GGs5K0a8sj0yZfVPyLlBsZgRxciOjzMFLOedQP4ymwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Iwnwrj5+LVEtX2pG3xnunqzj5vawiCJAvbu+PGDJ0Dd/9h8iaMPqCOJ47HOyz1tkwQlb9vwzkZPyKorZObCO7mqyBxuFZFCSTL9/ch2vvlOUTDDJW8m23CKWqCvYDPvU5fFOMfMVj76R9ftQ+Zdvia5lWJch3u+QkE9BCN34kpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=VjO/guHN; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Z77oM3Hhq+11TZjmMs7gNBFpwTLEebZI4fT7c+syuZg=;
	b=VjO/guHNPGCb7AUhnA0VThRkAu3VTGuvrdQsy0GbZjMlIbRLG5UNYs13XwPYulw3RmuPpb3P9
	QXjdI6Jk8qr+uHHKPhHnUo5sr74LAUz6hFvbvF9mKNRrd5H3OzT4HNVTE6zK6/l2PMFda4XGX9e
	QVEijiNZ4aPXqUHyFliNB5U=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4fRyw80j1nzcZyR;
	Fri,  6 Mar 2026 15:39:20 +0800 (CST)
Received: from kwepemj500018.china.huawei.com (unknown [7.202.194.48])
	by mail.maildlp.com (Postfix) with ESMTPS id 2DF01404AD;
	Fri,  6 Mar 2026 15:44:37 +0800 (CST)
Received: from [10.174.178.79] (10.174.178.79) by
 kwepemj500018.china.huawei.com (7.202.194.48) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 6 Mar 2026 15:44:36 +0800
Message-ID: <15be94dc-4096-4487-81c2-27c0743dbf9a@huawei.com>
Date: Fri, 6 Mar 2026 15:44:35 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8] l2tp: fix double dst_release() on
 sk_dst_cache race
To: Jakub Kicinski <kuba@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, David Bauer <mail@david-bauer.net>, James Chapman
	<jchapman@katalix.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>, Mikhail
 Lobanov <m.lobanov@rosa.ru>, <weiyongjun1@huawei.com>,
	<yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>
References: <20251215145537.5085-1-m.lobanov@rosa.ru>
 <20251216083541.70fb3b54@kernel.org>
From: Li Xiasong <lixiasong1@huawei.com>
In-Reply-To: <20251216083541.70fb3b54@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemj500018.china.huawei.com (7.202.194.48)
X-Rspamd-Queue-Id: 7ADD921C98E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-264704-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lixiasong1@huawei.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,huawei.com:dkim,huawei.com:mid]
X-Rspamd-Action: no action

Hi Jakub,

On 12/17/2025 12:35 AM, Jakub Kicinski wrote:
> On Mon, 15 Dec 2025 17:55:33 +0300 Mikhail Lobanov wrote:
>> A reproducible rcuref - imbalanced put() warning is observed under
>> IPv6 L2TP (pppol2tp) traffic with blackhole routes, indicating an
>> imbalance in dst reference counting for routes cached in
>> sk->sk_dst_cache and pointing to a subtle lifetime/synchronization
>> issue between the helpers that validate and drop cached dst entries.
> 
> This seems to be causing a leak:
> 
> unreferenced object 0xffff888017774e40 (size 64):
>   comm "ip", pid 3486, jiffies 4298584595
>   hex dump (first 32 bytes):
>     10 00 00 00 e9 01 00 00 01 00 00 00 00 00 00 00  ................
>     ff ff ff ff 00 00 00 00 48 4e 77 17 80 88 ff ff  ........HNw.....
>   backtrace (crc b523287):
>     __kmalloc_node_noprof+0x579/0x8c0
>     crypto_alloc_tfmmem.isra.0+0x2e/0xf0
>     crypto_create_tfm_node+0x81/0x2e0
>     crypto_spawn_tfm2+0x4e/0x80
>     crypto_rfc4106_init_tfm+0x41/0x190
>     crypto_create_tfm_node+0x108/0x2e0
>     crypto_spawn_tfm2+0x4e/0x80
>     aead_init_geniv+0x14c/0x2a0
>     crypto_create_tfm_node+0x108/0x2e0
>     crypto_alloc_tfm_node+0xe0/0x1d0
>     esp_init_aead.constprop.0+0xe4/0x340
>     esp_init_state+0x83/0x4c0
>     __xfrm_init_state+0x6f2/0x13d0
>     xfrm_state_construct+0x1455/0x2480 [xfrm_user]
>     xfrm_add_sa+0x137/0x3c0 [xfrm_user]
>     xfrm_user_rcv_msg+0x502/0x920 [xfrm_user]

I'm writing to follow up on Mikhail's patch, which aims to fix a race
condition in sk_dst_cache.

I've encountered the exact same issue. Specifically, the problem occurs
when using L2TP with a UDP socket file descriptor specified via netlink.
Below is the call stack from our system where the issue manifested:

rcuref - imbalanced put()
WARNING: CPU: 13 PID: 1222 at lib/rcuref.c:266 rcuref_put_slowpath+0x10c/0x120
Modules linked in:
CPU: 13 PID: 1222 Comm: l2tp Not tainted 6.6.0+ #9
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
RIP: 0010:rcuref_put_slowpath+0x10c/0x120
Code: 83 e4 01 31 ff 44 89 e6 e8 21 bb 53 ff 45 84 e4 75 1a e8 f7 c4 53 ff
48 c7 c7 4e ee c8 86 c6 05 41 22 01 06 01 e8 a4 10 39 ff <0f> 0b e8 dd c4
53 ff c7 03 00 00 00 e0 e9 2d ff ff ff 66 90 90 90
RSP: 0018:ffffc90006b7b9d8 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff88811df01740 RCX: ffffffff8134b438
RDX: ffff8881223fd080 RSI: 0000000000000000 RDI: 0000000000000001
RBP: 00000000dfffffff R08: 0000000000000000 R09: 6e616c61626d6920
R10: 0000000000000000 R11: 2928747570206465 R12: 0000000000000000
R13: ffff88811df01740 R14: 00000000ffffffea R15: 0000000000000000
FS:  00007f5dd7d22500(0000) GS:ffff88813b480000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000ee11668 CR3: 000000012259e000 CR4: 00000000000006e0
Call Trace:
 <TASK>
 dst_release+0x141/0x160
 ip6_dst_lookup_tail.constprop.0+0xa0/0x9b0
 ? sysvec_apic_timer_interrupt+0xf/0x90
 ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
 ? sk_dst_check+0x1c/0x160
 ip6_dst_lookup_flow+0x54/0xe0
 ip6_sk_dst_lookup_flow+0x1f6/0x2d0
 udpv6_sendmsg+0xc08/0x1760
 ? __pfx_ip_generic_getfrag+0x10/0x10
 ? sysvec_apic_timer_interrupt+0xf/0x90
 ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
 ? update_curr+0x35/0x3e0
 ? __pfx_udpv6_sendmsg+0x10/0x10
 ? inet6_sendmsg+0xb2/0xd0
 inet6_sendmsg+0xb2/0xd0
 __sock_sendmsg+0x60/0x120
 __sys_sendto+0x17a/0x230
 ? timerqueue_add+0xe1/0x140
 ? sched_clock+0x37/0x60
 ? sched_clock_cpu+0x11/0x1b0
 ? irqtime_account_irq+0x53/0x100
 ? handle_softirqs+0x189/0x320
 __x64_sys_sendto+0x2d/0x40
 do_syscall_64+0x5b/0x110
 entry_SYSCALL_64_after_hwframe+0x78/0xe2
RIP: 0033:0x7f5dd7722c4d
Code: ff ff ff ff eb b6 0f 1f 80 00 00 00 00 48 8d 05 c1 dc 2c 00 41 89 ca
8b 00 85 c0 75 20 45 31 c9 45 31 c0 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff
ff 77 6b f3 c3 66 0f 1f 84 00 00 00 00 00 41 56 41
RSP: 002b:00007ffcbf9e36d8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f5dd7722c4d
RDX: 0000000000000009 RSI: 000055cefbc01a57 RDI: 0000000000000003
RBP: 00007ffcbf9e4790 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000055cefbc00bf0
R13: 00007ffcbf9e4870 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Our investigation led us to the same root cause that Mikhail identified. I
have applied his patch and can confirm that it resolves the issue perfectly.

Thank you for looking into this previously. We noted your concern about a
potential memory leak during your review. We have been running the patch
but haven't been able to reproduce the leak ourselves.

Could you perhaps share the specific conditions or steps required to
trigger the memory leak? Any details you can provide would be very helpful
for us to further validate the patch or identify the root cause of the leak.

Thanks for your time and effort on this.

Best regards,

Li Xiasong



