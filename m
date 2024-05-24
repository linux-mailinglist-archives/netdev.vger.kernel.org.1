Return-Path: <netdev+bounces-97957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8218CE50E
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 14:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 568522821E2
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 12:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98B38615C;
	Fri, 24 May 2024 12:09:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C978563E
	for <netdev@vger.kernel.org>; Fri, 24 May 2024 12:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716552545; cv=none; b=oF/2xuLKynZx6ZAQqcUJZOKCTNykfGfa+azjlOFJ8KWT6CRhT28BZKmxHnwEfZY4wR2HMqx1elXlgbzeHTjPoi8D6LLNtns1KdzPSPUN4uv9fmHgKJCFlP8Dlo+6nMiEAlcQ9non6cerRApUg3gtu/JyxcINNvZs0dwPHKf5y+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716552545; c=relaxed/simple;
	bh=ujqpBmJAF2hibpXgDlGtK4IOmmjLONfgiHhQf7LiZe0=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=lLKzPVJKjzCqlBaM+fZ3aV8HmZp4kIImV8Ed6UBdq53YzwaMpzX77pkDZQWlrfoWGB5WekrfXI9T1+SzT1Vh5p7TH3ceHRwRxixEk69rWcAUnanc4ym0BwdWm8PSBNYjjXRQ5huZpbCwaWDwpt2BjtVLGOQsHHcDwUKrgp85kMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from ja.int.chopps.org.chopps.org (syn-172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 05A9D7D03C;
	Fri, 24 May 2024 12:09:01 +0000 (UTC)
References: <20240520214255.2590923-1-chopps@chopps.org>
 <Zk-ZEzFmC7zciKCu@Antony2201.local> <m2cypc3x46.fsf@ja.int.chopps.org>
 <ZlB_eSJKUKwJ2ElP@Antony2201.local>
User-agent: mu4e 1.8.14; emacs 28.2
From: Christian Hopps <chopps@chopps.org>
To: Antony Antony <antony@phenome.org>
Cc: Christian Hopps <chopps@chopps.org>, devel@linux-ipsec.org, Steffen
 Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org, Christian
 Hopps <chopps@labn.net>
Subject: Re: [PATCH ipsec-next v2 0/17] Add IP-TFS mode to xfrm
Date: Fri, 24 May 2024 07:56:38 -0400
In-reply-to: <ZlB_eSJKUKwJ2ElP@Antony2201.local>
Message-ID: <m28qzz4dk5.fsf@ja.int.chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable


This is very helpful thanks.

I think the tunnel endpoints are east/west 192.1.2.{23,45}, but I can't det=
ermine the north/east endpoints b/c they don't appear connected. :)

Are there any other iptfs options? The code you highlight mentions the `don=
t-frag` option, but I wonder if you actually have that enabled?

It also seems like you are pinging and forcing the source IP of a red inter=
face on the tunnel endpoint gateway directly (so that it doesn't try and us=
e the black interface I would guess) is that correct?

Thanks!
Chris.

P.S. the addresses on the NIC host in the picture seem reversed, but this d=
oesn't seem relevant to this test :)

Antony Antony <antony@phenome.org> writes:

> On Thu, May 23, 2024 at 07:04:58PM -0400, Christian Hopps wrote:
>>
>> Could you let me know some more details about this test? What is your in=
terface config / topology?. I tried to guess given the ping command but it'=
s not replicating for me.
>
> I am using Libreswan testing topology. However, I am running test manuall=
y.
> Yesterday tunnel between north and east. This morning I quickly tried
> between west-east. Just two VM. I see the same issue there too.
>
> https://libreswan.org/wiki/images/f/f1/Testnet-202102.png
>
> I am using CONFIG_ESP_OFFLOAD. That is only thing standing out. Besides it
> is just a 1500 MTU tunnels using qemu/kvm and tap network.
>
> attached is my kernel .config
>
>> PS, I've changed the subject and In-reply-to to be based on the corrected
>> cover-letter I sent, I initially sent the cover letter with the wrong
>> subject. :(
>
> I noticed a second cover letter. However, it was not showing as related to
> patch set correctly. It showed up as a diffrent thread. That is why I
> replied to the initial one
>
> -antony
>>
>>
>> Antony Antony <antony@phenome.org> writes:
>>
>> > Hi Chris,
>> >
>> > On Mon, May 20, 2024 at 05:42:38PM -0400, Christian Hopps via Devel wr=
ote:
>> > > From: Christian Hopps <chopps@labn.net>
>> > >   - iptfs: remove some BUG_ON() assertions questioned in review.
>>
>> ...
>>
>> > I ran a couple of tests and it hit KSAN BUG.
>> >
>> > I was sending large ping while MTU is 1500.
>> >
>> > north login: shed systemd-user-sessions.service - Permit User Sessions.
>> > north login: [   78.594770] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>> > [   78.595825] BUG: KASAN: null-ptr-deref in iptfs_output_collect+0x26=
3/0x57b
>> > [   78.596658] Read of size 8 at addr 0000000000000108 by task ping/493
>> > [   78.597435] ng rpc-statd-notify.service - Notify NFS peers of a res=
tart...
>> > [   78.597651] CPU: 0 PID: 493 Comm: ping Not tainted 6.9.0-rc2-00697-=
g489ca863e24f-dirty #11
>> > [   78.598645] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIO=
S 1.16.3-debian-1.16.3-2 04/01/2014
>> > [   78.599747] Call Trace:tty@ttyS2.service - Serial Getty on ttyS2.
>> > [   78.600070]  <TASK>l-getty@ttyS3.service - Serial Getty on ttyS3.
>> > [   78.600354]  dump_stack_lvl+0x2a/0x3bogin Prompts.
>> > [   78.600817]  kasan_report+0x84/0xa6rvice - Hostname Service...
>> > [   78.601262]  ? iptfs_output_collect+0x263/0x57bl server.
>> > [   78.601825]  iptfs_output_collect+0x263/0x57bogin Management.
>> > [   78.602374]  ip_send_skb+0x25/0x57vice - Notify NFS peers of a rest=
art.
>> > [   78.602807]  raw_sendmsg+0xee8/0x1011t - Multi-User System.
>> > [   78.603269]  ? native_flush_tlb_one_user+0xd/0xe5e Service.
>> > [   78.603850]  ? raw_hash_sk+0x21b/0x21b
>> > [   78.604331]  ? kernel_init_pages+0x42/0x51
>> > [   78.604845]  ? prep_new_page+0x44/0x51Re=E2=80=A6line ext4 Metadata=
 Check Snapshots.
>> > [   78.605318]  ? get_page_from_freelist+0x72b/0x915 Interface.
>> > [   78.605903]  ? signal_pending_state+0x77/0x77cord Runlevel Change i=
n UTMP...
>> > [   78.606462]  ? __might_resched+0x8a/0x240e - Record Runlevel Change=
 in UTMP.
>> > [   78.606966]  ? __might_sleep+0x25/0xa0
>> > [   78.607440]  ? first_zones_zonelist+0x2c/0x43
>> > [   78.607985]  ? __rcu_read_lock+0x2d/0x3a
>> > [   78.608479]  ? __pte_offset_map+0x32/0xa4
>> > [   78.608979]  ? __might_resched+0x8a/0x240
>> > [   78.609478]  ? __might_sleep+0x25/0xa0
>> > [   78.609949]  ? inet_send_prepare+0x54/0x54
>> > [   78.610464]  ? sock_sendmsg_nosec+0x42/0x6c
>> > [   78.610984]  sock_sendmsg_nosec+0x42/0x6c
>> > [   78.611485]  __sys_sendto+0x15d/0x1cc
>> > [   78.611947]  ? __x64_sys_getpeername+0x44/0x44
>> > [   78.612498]  ? __handle_mm_fault+0x679/0xae4
>> > [   78.613033]  ? find_vma+0x6b/0x8b
>> > [   78.613457]  ? find_vma_intersection+0x8a/0x8a
>> > [   78.614006]  ? __handle_irq_event_percpu+0x180/0x197
>> > [   78.614617]  ? handle_mm_fault+0x38/0x154
>> > [   78.615114]  ? handle_mm_fault+0xeb/0x154
>> > [   78.615620]  ? preempt_latency_start+0x29/0x34
>> > [   78.616169]  ? preempt_count_sub+0x14/0xb3
>> > [   78.616678]  ? up_read+0x4b/0x5c
>> > [   78.617094]  __x64_sys_sendto+0x76/0x82
>> > [   78.617577]  do_syscall_64+0x6b/0xd7
>> > [   78.618043]  entry_SYSCALL_64_after_hwframe+0x46/0x4e
>> > [   78.618667] RIP: 0033:0x7fed3de99a73
>> > [ 78.619118] Code: 8b 15 a9 83 0c 00 f7 d8 64 89 02 48 c7 c0 ff ff ff =
ff eb b8
>> > 0f 1f 00 80 3d 71 0b 0d 00 00 41 89 ca 74 14 b8 2c 00 00 00 0f 05 <48>=
 3d 00 f0
>> > ff ff 77 75 c3 0f 1f 40 00 55 48 83 ec 30 44 89 4c 24
>> > [   78.621291] RSP: 002b:00007ffff6bdf478 EFLAGS: 00000202 ORIG_RAX: 0=
00000000000002c
>> > [   78.622205] RAX: ffffffffffffffda RBX: 000055c538159340 RCX: 00007f=
ed3de99a73
>> > [   78.623056] RDX: 00000000000007d8 RSI: 000055c53815f3c0 RDI: 000000=
0000000003
>> > [   78.623908] RBP: 000055c53815f3c0 R08: 000055c53815b5c0 R09: 000000=
0000000010
>> > [   78.624765] R10: 0000000000000000 R11: 0000000000000202 R12: 000000=
00000007d8
>> > [   78.625619] R13: 00007ffff6be0b60 R14: 0000001d00000001 R15: 000055=
c53815c680
>> > [   78.626480]  </TASK>
>> > [   78.626773] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > [   78.627656] Disabling lock debugging due to kernel taint
>> > [   78.628305] BUG: kernel NULL pointer dereference, address: 00000000=
00000108
>> > [   78.629136] #PF: supervisor read access in kernel mode
>> > [   78.629766] #PF: error_code(0x0000) - not-present page
>> > [   78.630402] PGD 0 P4D 0
>> > [   78.630739] Oops: 0000 [#1] PREEMPT DEBUG_PAGEALLOC KASAN
>> > [   78.631398] CPU: 0 PID: 493 Comm: ping Tainted: G    B             =
 6.9.0-rc2-00697-g489ca863e24f-dirty #11
>> > [   78.632548] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIO=
S 1.16.3-debian-1.16.3-2 04/01/2014
>> > [   78.633649] RIP: 0010:iptfs_output_collect+0x263/0x57b
>> > [ 78.634283] Code: 73 70 0f 84 25 01 00 00 45 39 f4 0f 83 1c 01 00 00 =
48 8d 7b
>> > 10 e8 27 37 62 ff 4c 8b 73 10 49 8d be 08 01 00 00 e8 17 37 62 ff <4d>=
 8b b6 08
>> > 01 00 00 49 8d be b0 01 00 00 e8 04 37 62 ff 49 8b 86
>> > [   78.636444] RSP: 0018:ffffc90000d679c8 EFLAGS: 00010296
>> > [   78.637076] RAX: 0000000000000001 RBX: ffff888110ffbc80 RCX: fffffb=
fff07623ad
>> > [   78.637923] RDX: fffffbfff07623ad RSI: fffffbfff07623ad RDI: ffffff=
ff83b11d60
>> > [   78.638792] RBP: ffff88810e3a1400 R08: 0000000000000008 R09: 000000=
0000000001
>> > [   78.639645] R10: ffffffff83b11d67 R11: fffffbfff07623ac R12: 000000=
00000005a2
>> > [   78.640498] R13: 0000000000000000 R14: 0000000000000000 R15: ffff88=
810e9a3401
>> > [   78.641359] FS:  00007fed3dbddc40(0000) GS:ffffffff82cb2000(0000) k=
nlGS:0000000000000000
>> > [   78.642324] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> > [   78.643022] CR2: 0000000000000108 CR3: 0000000110e84000 CR4: 000000=
0000350ef0
>> > [   78.643882] Call Trace:
>> > [   78.644204]  <TASK>
>> > [   78.644487]  ? __die_body+0x1a/0x56
>> > [   78.644929]  ? page_fault_oops+0x45f/0x4cd
>> > [   78.645441]  ? dump_pagetable+0x1db/0x1db
>> > [   78.645942]  ? vprintk_emit+0x163/0x171
>> > [   78.646425]  ? iptfs_output_collect+0x263/0x57b
>> > [   78.646986]  ? _printk+0xb2/0xe1
>> > [   78.647401]  ? find_first_fitting_seq+0x193/0x193
>> > [   78.647982]  ? iptfs_output_collect+0x263/0x57b
>> > [   78.648541]  ? do_user_addr_fault+0x14f/0x56c
>> > [   78.649084]  ? exc_page_fault+0xa5/0xbe
>> > [   78.649566]  ? asm_exc_page_fault+0x22/0x30
>> > [   78.650100]  ? iptfs_output_collect+0x263/0x57b
>> > [   78.650660]  ? iptfs_output_collect+0x263/0x57b
>> > [   78.651221]  ip_send_skb+0x25/0x57
>> > [   78.651652]  raw_sendmsg+0xee8/0x1011
>> > [   78.652113]  ? native_flush_tlb_one_user+0xd/0xe5
>> > [   78.652693]  ? raw_hash_sk+0x21b/0x21b
>> > [   78.653166]  ? kernel_init_pages+0x42/0x51
>> > [   78.653683]  ? prep_new_page+0x44/0x51
>> > [   78.654160]  ? get_page_from_freelist+0x72b/0x915
>> > [   78.654739]  ? signal_pending_state+0x77/0x77
>> > [   78.655284]  ? __might_resched+0x8a/0x240
>> > [   78.655784]  ? __might_sleep+0x25/0xa0
>> > [   78.656255]  ? first_zones_zonelist+0x2c/0x43
>> > [   78.656798]  ? __rcu_read_lock+0x2d/0x3a
>> > [   78.657289]  ? __pte_offset_map+0x32/0xa4
>> > [   78.657788]  ? __might_resched+0x8a/0x240
>> > [   78.658291]  ? __might_sleep+0x25/0xa0
>> > [   78.658763]  ? inet_send_prepare+0x54/0x54
>> > [   78.659272]  ? sock_sendmsg_nosec+0x42/0x6c
>> > [   78.659791]  sock_sendmsg_nosec+0x42/0x6c
>> > [   78.660293]  __sys_sendto+0x15d/0x1cc
>> > [   78.660755]  ? __x64_sys_getpeername+0x44/0x44
>> > [   78.661304]  ? __handle_mm_fault+0x679/0xae4
>> > [   78.661838]  ? find_vma+0x6b/0x8b
>> > [   78.662272]  ? find_vma_intersection+0x8a/0x8a
>> > [   78.662828]  ? __handle_irq_event_percpu+0x180/0x197
>> > [   78.663436]  ? handle_mm_fault+0x38/0x154
>> > [   78.663935]  ? handle_mm_fault+0xeb/0x154
>> > [   78.664435]  ? preempt_latency_start+0x29/0x34
>> > [   78.664987]  ? preempt_count_sub+0x14/0xb3
>> > [   78.665498]  ? up_read+0x4b/0x5c
>> > [   78.665911]  __x64_sys_sendto+0x76/0x82
>> > [   78.666398]  do_syscall_64+0x6b/0xd7
>> > [   78.666849]  entry_SYSCALL_64_after_hwframe+0x46/0x4e
>> > [   78.667466] RIP: 0033:0x7fed3de99a73
>> > [ 78.667918] Code: 8b 15 a9 83 0c 00 f7 d8 64 89 02 48 c7 c0 ff ff ff =
ff eb b8
>> > 0f 1f 00 80 3d 71 0b 0d 00 00 41 89 ca 74 14 b8 2c 00 00 00 0f 05 <48>=
 3d 00 f0
>> > ff ff 77 75 c3 0f 1f 40 00 55 48 83 ec 30 44 89 4c 24
>> > [   78.670097] RSP: 002b:00007ffff6bdf478 EFLAGS: 00000202 ORIG_RAX: 0=
00000000000002c
>> > [   78.671002] RAX: ffffffffffffffda RBX: 000055c538159340 RCX: 00007f=
ed3de99a73
>> > [   78.671858] RDX: 00000000000007d8 RSI: 000055c53815f3c0 RDI: 000000=
0000000003
>> > [   78.672708] RBP: 000055c53815f3c0 R08: 000055c53815b5c0 R09: 000000=
0000000010
>> > [   78.673564] R10: 0000000000000000 R11: 0000000000000202 R12: 000000=
00000007d8
>> > [   78.674430] R13: 00007ffff6be0b60 R14: 0000001d00000001 R15: 000055=
c53815c680
>> > [   78.675287]  </TASK>
>> > [   78.675580] Modules linked in:
>> > [   78.675975] CR2: 0000000000000108
>> > [   78.676396] ---[ end trace 0000000000000000 ]---
>> > [   78.676966] RIP: 0010:iptfs_output_collect+0x263/0x57b
>> > [ 78.677596] Code: 73 70 0f 84 25 01 00 00 45 39 f4 0f 83 1c 01 00 00 =
48 8d 7b
>> > 10 e8 27 37 62 ff 4c 8b 73 10 49 8d be 08 01 00 00 e8 17 37 62 ff <4d>=
 8b b6 08
>> > 01 00 00 49 8d be b0 01 00 00 e8 04 37 62 ff 49 8b 86
>> > [   78.679768] RSP: 0018:ffffc90000d679c8 EFLAGS: 00010296
>> > [   78.680410] RAX: 0000000000000001 RBX: ffff888110ffbc80 RCX: fffffb=
fff07623ad
>> > [   78.681264] RDX: fffffbfff07623ad RSI: fffffbfff07623ad RDI: ffffff=
ff83b11d60
>> > [   78.682136] RBP: ffff88810e3a1400 R08: 0000000000000008 R09: 000000=
0000000001
>> > [   78.682997] R10: ffffffff83b11d67 R11: fffffbfff07623ac R12: 000000=
00000005a2
>> > [   78.683853] R13: 0000000000000000 R14: 0000000000000000 R15: ffff88=
810e9a3401
>> > [   78.684710] FS:  00007fed3dbddc40(0000) GS:ffffffff82cb2000(0000) k=
nlGS:0000000000000000
>> > [   78.685675] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> > [   78.686387] CR2: 0000000000000108 CR3: 0000000110e84000 CR4: 000000=
0000350ef0
>> > [   78.687246] Kernel panic - not syncing: Fatal exception in interrupt
>> > [   78.688014] Kernel Offset: disabled
>> > [   78.688460] ---[ end Kernel panic - not syncing: Fatal exception in=
 interrupt ]---
>> >
>> > ping -s 2000  -n -q -W 1 -c 2 -I 192.0.3.254  192.0.2.254
>> >
>> > (gdb) list *iptfs_output_collect+0x263
>> > 0xffffffff81d5076f is in iptfs_output_collect (./include/net/net_names=
pace.h:383).
>> > 378	}
>> > 379
>> > 380	static inline struct net *read_pnet(const possible_net_t *pnet)
>> > 381	{
>> > 382	#ifdef CONFIG_NET_NS
>> > 383		return rcu_dereference_protected(pnet->net, true);
>> > 384	#else
>> > 385		return &init_net;
>> > 386	#endif
>> > 387	}
>> >
>> > I suspect actual crash is from the line 1756 instead,
>> > (gdb) list *iptfs_output_collect+0x256
>> > 0xffffffff81d50762 is in iptfs_output_collect (net/xfrm/xfrm_iptfs.c:1=
756).
>> > 1751			return 0;
>> > 1752
>> > 1753		/* We only send ICMP too big if the user has configured us as
>> > 1754		 * dont-fragment.
>> > 1755		 */
>> > 1756		XFRM_INC_STATS(dev_net(skb->dev), LINUX_MIB_XFRMOUTERROR);
>> > 1757
>> > 1758		if (sk) {
>> > 1759			xfrm_local_error(skb, pmtu);
>> > 1760		} else if (ip_hdr(skb)->version =3D=3D 4) {
>> >
>> > Later I ran with gdb iptfs_is_too_big which is called twice and second=
 time
>> > it crash.
>> > Here is gdb bt. Just before the crash
>> >
>> > #0  iptfs_is_too_big (pmtu=3D1442, skb=3D0xffff88810dbea3c0, sk=3D0xff=
ff888104d4ed40) at net/xfrm/xfrm_iptfs.c:1756
>> > #1  iptfs_output_collect (net=3D<optimized out>, sk=3D0xffff888104d4ed=
40, skb=3D0xffff88810dbea3c0) at net/xfrm/xfrm_iptfs.c:1847
>> > #2  0xffffffff81c8a3cb in ip_send_skb (net=3D0xffffffff83e57f20 <init_=
net>, skb=3D0xffff88810dbea3c0)
>> >     at net/ipv4/ip_output.c:1492
>> > #3  0xffffffff81c8a439 in ip_push_pending_frames (sk=3Dsk@entry=3D0xff=
ff888104d4ed40, fl4=3Dfl4@entry=3D0xffffc90000e3fb90)
>> >     at net/ipv4/ip_output.c:1512
>> > #4  0xffffffff81ccf3cf in raw_sendmsg (sk=3D0xffff888104d4ed40, msg=3D=
0xffffc90000e3fd80, len=3D<optimized out>)
>> >     at net/ipv4/raw.c:654
>> > #5  0xffffffff81b096ea in sock_sendmsg_nosec (sock=3Dsock@entry=3D0xff=
ff888115136040, msg=3Dmsg@entry=3D0xffffc90000e3fd80)
>> >     at net/socket.c:730
>> > #6  0xffffffff81b0c327 in __sock_sendmsg (msg=3D0xffffc90000e3fd80, so=
ck=3D0xffff888115136040) at net/socket.c:745
>> > #7  __sys_sendto (fd=3D<optimized out>, buff=3Dbuff@entry=3D0x558edefb=
73c0, len=3Dlen@entry=3D2008, flags=3Dflags@entry=3D0,
>> >     addr=3Daddr@entry=3D0x558edefb35c0, addr_len=3Daddr_len@entry=3D16=
) at net/socket.c:2191
>> > #8  0xffffffff81b0c40c in __do_sys_sendto (addr_len=3D16, addr=3D0x558=
edefb35c0, flags=3D0, len=3D2008, buff=3D0x558edefb73c0,
>> >     fd=3D<optimized out>) at net/socket.c:2203
>> > #9  __se_sys_sendto (addr_len=3D16, addr=3D94072114722240, flags=3D0, =
len=3D2008, buff=3D94072114738112, fd=3D<optimized out>)
>> >     at net/socket.c:2199
>> >
>> > gdb) list
>> > 1751			return 0;
>> > 1752
>> > 1753		/* We only send ICMP too big if the user has configured us as
>> > 1754		 * dont-fragment.
>> > 1755		 */
>> > 1756		XFRM_INC_STATS(dev_net(skb->dev), LINUX_MIB_XFRMOUTERROR);
>> > 1757
>> > 1758		if (sk) {
>> > 1759			xfrm_local_error(skb, pmtu);
>> > 1760		} else if (ip_hdr(skb)->version =3D=3D 4) {
>> >
>> > -antony
>>
>
> [2. text/plain; .config]...


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJGBAEBCgAwFiEEm56yH/NF+m1FHa6lLh2DDte4MCUFAmZQg1oSHGNob3Bwc0Bj
aG9wcHMub3JnAAoJEC4dgw7XuDAlAxYP/1+jSz/gtGFrLbKYGEGwPvIeXuX5bK38
KAhlgBeHdi3t+Kb7ha1Rzvxlspi/53xcwtQZpBu0mueXCZyfhznYoYC8TRfyBlUQ
fqARNDkziLys6Dxu91O8RFYYNINhzOHz04KLHni8mPXFZICLBxnNnTxqTE6tBSBq
XfkAS4r51cWdRi4Wiko0KFDITmZClvI55+qN3+ZTBlZSXsFdsjeUE7XzbYa/yDO8
cxkCh+X9XpdvAAmFzVq0gS6PqjOt3qnLVjThlF3VqjJ0rCwVvNDZFDERYxIgGs2q
1tWv8dpLF+wwKRnielx7AMhflh9ttSOvfy1vbBTTBAs3ycpK8N3E6HiFYdTLH0k6
h1uwLYpDqYmZenYO1rPOY51QpaVsqt9ffCYpEgE5C/ImfmFt78Rj1qJZ/qkOR757
VdB0LN0Ku4cTydquFQQzA7wprjMBVsffcLjb08F4+Knukd7hdZaVKZQa/vDC3EfS
1hGj5qLkt6OJFfU+xo2IQ/llfO3MSfsF3bVQcrjeilYvRQ25MDnXwB9El+tK8qYs
TloG6767Oq80upRSr6d/fg62XaEtVvSGynLA3/Szq7Vyf5dZXNSDqVXhmNledJRg
EYYZKVzjZiHyqxBIZRRDJW0Co2iAMJtmxR5XhjMU0icUbbjSoEIgkxVQdXaILqnY
qkGPXR7dEAC6
=qvll
-----END PGP SIGNATURE-----
--=-=-=--

