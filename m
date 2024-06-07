Return-Path: <netdev+bounces-101656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A978FFBCC
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 08:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7E73B2420E
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 06:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3068B18AF4;
	Fri,  7 Jun 2024 06:03:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B027510A24
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 06:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717740187; cv=none; b=mw5iTPdRu/48T0obR6BTmzyf/ssdTfB640ff3D+mYpsLZy2N4uOKWONcy+6CYddt3ddllCsZqOUv4zduJA4M0/GV75WPzRJRKU4okF+/LhYsvFxu226y3Ccr9noGtFWKQuyamGKx435eGTjKgfAFNsqCxgrVJ8rOKVD9rzaWs7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717740187; c=relaxed/simple;
	bh=mZ798URHs1K/4mTJpM/Ve0syz/g2lCAeo09XwJNVDtU=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=Voq3TBlvdHXPH7cfqZMTtZp34OtrB+lXYYrhcjY6IFiadYAjElEsLWqUe4+rV2ttOOEZWmKIiDuDw/Gzas1t6fiK5MH0cEeIeCk3RPGKvZtnygcF4HdHz3W0YmWBZM1kMDyGmHpsUpbjWizvNvQzobXay7ay40Rfa9DcYsfo0VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from ja.int.chopps.org.chopps.org (syn-172-222-091-149.res.spectrum.com [172.222.91.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 3584B7D10E;
	Fri,  7 Jun 2024 06:03:03 +0000 (UTC)
References: <20240520214255.2590923-1-chopps@chopps.org>
 <Zk-ZEzFmC7zciKCu@Antony2201.local> <m2cypc3x46.fsf@ja.int.chopps.org>
 <ZlB_eSJKUKwJ2ElP@Antony2201.local> <m28qzz4dk5.fsf@ja.int.chopps.org>
 <m24jam4egz.fsf@ja.int.chopps.org> <ZmHbPQwk4Zgjlxjx@Antony2201.local>
User-agent: mu4e 1.8.14; emacs 28.3
From: Christian Hopps <chopps@chopps.org>
To: Antony Antony <antony@phenome.org>
Cc: Christian Hopps <chopps@chopps.org>, devel@linux-ipsec.org, Steffen
 Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org, Christian
 Hopps <chopps@labn.net>
Subject: Re: [devel-ipsec] [PATCH ipsec-next v2 0/17] Add IP-TFS mode to xfrm
Date: Fri, 07 Jun 2024 01:54:41 -0400
In-reply-to: <ZmHbPQwk4Zgjlxjx@Antony2201.local>
Message-ID: <m2y17hffxl.fsf@ja.int.chopps.org>
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


For me the flood works with no packet loss. BTW, as you mentioned not havin=
g dont-frag set in the coffee hour meeting, I did notice that it shows bein=
g set in one of your iproute(2) outputs, did you set it for this test then =
or is it perhaps getting set by strongswan inadvertently?

In any case here's what I saw:

#                       192.168.0.0/24  fd00::/64
#   --+-------------------+------ mgmt0 ------+-------------------+---
#     | .1                | .2                | .3                | .4
#   +----+              +----+ =3D=3D=3DTUNNEL=3D=3D=3D +----+             =
 +----+
#   | h1 | --- net0 --- | r1 | --- net1 --- | r2 | --- net2 --- | h2 |
#   +----+ .1        .2 +----+ .2        .3 +----+ .3        .4 +----+
#          10.0.0.0/24         10.0.1.0/24         10.0.2.0/24

[on r1 pinging h2 using r1 net0 interface]

sh-5.2# ping -f -c 10000 -I 10.0.0.2 10.0.2.4
PING 10.0.2.4 (10.0.2.4) from 10.0.0.2 : 56(84) bytes of data.

=2D-- 10.0.2.4 ping statistics ---
10000 packets transmitted, 10000 received, 0% packet loss, time 3452ms
rtt min/avg/max/mdev =3D 0.251/0.284/2.463/0.055 ms, ipg/ewma 0.345/0.287 ms

[on r1]

sh-5.2# ip x s l
src 10.0.1.3 dst 10.0.1.2
        proto esp spi 0x00000bbb reqid 9 mode iptfs
        replay-window 0
        aead rfc4106(gcm(aes)) 0x4a506a794f574265564551694d6537681a2b1a2b 1=
28
        lastused 2024-06-07 05:53:35
        anti-replay context: seq 0x0, oseq 0x0, bitmap 0x00000000
        if_id 0x37
        dir in
        iptfs-opts drop-time 1000000 reorder-window 3
        sel src 0.0.0.0/0 dst 0.0.0.0/0
src 10.0.1.2 dst 10.0.1.3
        proto esp spi 0x00000aaa reqid 8 mode iptfs
        replay-window 0
        aead rfc4106(gcm(aes)) 0x4a506a794f574265564551694d6537681a2b1a2b 1=
28
        lastused 2024-06-07 05:53:35
        anti-replay context: seq 0x0, oseq 0x4e27, bitmap 0x00000000
        if_id 0x37
        dir out
        iptfs-opts init-delay 0 max-queue-size 1048576 pkt-size 0
        sel src 0.0.0.0/0 dst 0.0.0.0/0
sh-5.2#

Thanks,
Chris.

Antony Antony <antony@phenome.org> writes:

> On Sat, May 25, 2024 at 01:55:01AM -0400, Christian Hopps via Devel wrote:
>>
>> Found. This was happening b/c the skb was locally generated on the gatew=
ay and so had no net_device. Fixed by checking for skb->dev =3D=3D NULL bef=
ore incrementing the error stats in the output path.
>
>
> Good to hear you found the bug and fixed. I am curious how the large pack=
ets
> send in case dsl gateway would work.
>
> Here is possibly another issue.
>
> With ping -f I see error. After a few several responses ping return error
> and no more ESP is send from the sender.
>
> ping -f -c 10000 -I 192.0.1.254 192.0.2.254
> PING 192.0.2.254 (192.0.2.254) from 192.0.1.254 : 56(84) bytes of data.
> EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE=
EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE=
^C
> --- 192.0.2.254 ping statistics ---
> 1428 packets transmitted, 1280 received, 10.3641% packet loss, time 28398=
ms
> rtt min/avg/max/mdev =3D 2.761/7.770/19.916/0.908 ms, pipe 2, ipg/ewma 19=
.900/9.335 ms
> root@west:/testing/pluto/ikev2-74-iptfs-01$
>
> root@east:/testing/pluto/ikev2-74-iptfs-01$ip x s
> src 192.1.2.23 dst 192.1.2.45
> 	proto esp spi 0x55067850 reqid 16389 mode iptfs dir out
> 	flag af-unspec esn
> 	aead rfc4106(gcm(aes)) 0x7aacd5115a84ee5476940c864b3f4a4fa6ca9e3c0590b1b=
33ae5c925dad38c494c2ba9ac 128
> 	lastused 2024-06-06 17:36:31
> 	oseq-hi 0x0, oseq 0x564
> 	iptfs-opts pkt-size 0 max-queue-size 1048576 drop-time 1000000 reorder-w=
indow 3 init-delay 0 dont-frag
> src 192.1.2.45 dst 192.1.2.23
> 	proto esp spi 0x54562117 reqid 16389 mode iptfs dir in
> 	flag af-unspec esn
> 	aead rfc4106(gcm(aes)) 0x8505e65031be933d5b5be57c27a618de7f5d5a2c464dbfb=
62d093dcb411b2c4f75893484 128
> 	lastused 2024-06-06 17:36:31
> 	seq-hi 0x0, seq 0x564
> 	replay-window 128, bitmap-length 4
> 	 ffffffff ffffffff ffffffff ffffffff
> 	iptfs-opts pkt-size 0 max-queue-size 1048576 drop-time 1000000 reorder-w=
indow 3 init-delay 0
>
> Also on there is kernel splat on both ends. I am not sure it is related to
> your patches. However, I see it around same time ping return error, and I
> haven't seen it before. I will try to get more inforation.
>
> [  575.515108] ------------[ cut here ]------------
> [  575.515646] refcount_t: underflow; use-after-free.
> [  575.516169] WARNING: CPU: 0 PID: 34 at lib/refcount.c:28 refcount_warn=
_saturate+0xb7/0xfc
> [  575.516996] Modules linked in:
> [  575.517332] CPU: 0 PID: 34 Comm: rb_consumer Not tainted 6.9.0-rc2-006=
96-gf549fd6ea775 #28
> [  575.518165] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1=
.16.3-debian-1.16.3-2 04/01/2014
> [  575.519105] RIP: 0010:refcount_warn_saturate+0xb7/0xfc
> [  575.519635] Code: 4c 30 c3 01 01 e8 e2 af 8b ff 0f 0b eb 5e 80 3d 3b 3=
0 c3 01 00 75 55 48 c7 c7 c0 95 4e 82 c6 05 2b 30 c3 01 01 e8 c2 af 8b ff <=
0f> 0b eb 3e 80 3d 1a 30 c3 01 00 75 35 48 c7 c7 20 97 4e 82 c6 05
> [  575.521449] RSP: 0018:ffffc90000007c90 EFLAGS: 00010282
> [  575.521992] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 000000000=
0000000
> [  575.522713] RDX: 0000000000000000 RSI: dffffc0000000000 RDI: fffff5200=
0000f83
> [  575.523448] RBP: ffff888104d4f334 R08: 0000000000000004 R09: 000000000=
0000001
> [  575.524169] R10: ffffffff82d552ab R11: fffffbfff05aaa55 R12: ffff88810=
4d4f334
> [  575.524891] R13: 1ffff92000000fa7 R14: ffff8881073d0800 R15: 000000000=
0000000
> [  575.525609] FS:  0000000000000000(0000) GS:ffffffff82cb2000(0000) knlG=
S:0000000000000000
> [  575.526413] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  575.527013] CR2: 0000558b84637af0 CR3: 000000010dc88000 CR4: 000000000=
0350ef0
> [  575.527731] Call Trace:
> [  575.528006]  <IRQ>
> [  575.528240]  ? __warn+0xb8/0x13b
> [  575.528593]  ? refcount_warn_saturate+0xb7/0xfc
> [  575.529071]  ? report_bug+0xf6/0x159
> [  575.529453]  ? refcount_warn_saturate+0xb7/0xfc
> [  575.529931]  ? handle_bug+0x3c/0x64
> [  575.530306]  ? exc_invalid_op+0x13/0x38
> [  575.530717]  ? asm_exc_invalid_op+0x16/0x20
> [  575.531167]  ? refcount_warn_saturate+0xb7/0xfc
> [  575.531639]  __refcount_sub_and_test.constprop.0+0x38/0x3d
> [  575.532200]  sock_wfree+0x13a/0x153
> [  575.532575]  skb_release_head_state+0x25/0x6b
> [  575.533032]  skb_release_all+0x13/0x3a
> [  575.533429]  napi_consume_skb+0x53/0x5e
> [  575.533836]  __free_old_xmit+0xcc/0x18d
> [  575.534243]  ? virtnet_freeze_down.isra.0+0xb4/0xb4
> [  575.534747]  ? check_preempt_wakeup_fair+0x64/0x1f3
> [  575.535269]  ? test_ti_thread_flag+0x12/0x1f
> [  575.535718]  ? tracing_record_taskinfo_sched_switch+0x25/0xbf
> [  575.536304]  free_old_xmit+0x72/0xbe
> [  575.536687]  ? __free_old_xmit+0x18d/0x18d
> [  575.537117]  ? trace_rcu_this_gp.constprop.0+0x52/0xca
> [  575.537646]  ? virtqueue_disable_cb+0x71/0xe9
> [  575.538109]  virtnet_poll_tx+0xf6/0x1d8
> [  575.538516]  __napi_poll.constprop.0+0x57/0x1a7
> [  575.539000]  net_rx_action+0x1cb/0x380
> [  575.539399]  ? __napi_poll.constprop.0+0x1a7/0x1a7
> [  575.539896]  ? __napi_schedule+0xe/0x17
> [  575.540302]  ? vring_interrupt+0xba/0xc4
> [  575.540716]  ? __handle_irq_event_percpu+0x180/0x197
> [  575.541229]  ? handle_irq_event_percpu+0x3b/0x40
> [  575.541710]  __do_softirq+0x135/0x2d7
> [  575.542102]  common_interrupt+0x93/0xb8
> [  575.542509]  </IRQ>
> [  575.542751]  <TASK>
> [  575.543004]  asm_common_interrupt+0x22/0x40
> [  575.543443] RIP: 0010:ring_buffer_consume+0xde/0x11e
> [  575.543960] Code: e8 c6 68 18 00 31 c0 4c 89 ef 49 89 45 58 e8 1e fb f=
f ff 41 0f b6 fc e8 4f ec ff ff 0f ba 64 24 20 09 73 01 fb bf 01 00 00 00 <=
e8> 4a 4e f4 ff 8b 05 64 17 28 02 85 c0 75 05 e8 63 56 e1 ff 48 85
> [  575.545757] RSP: 0018:ffffc90000237dd0 EFLAGS: 00000283
> [  575.546292] RAX: 0000000080000001 RBX: ffff8881047242e0 RCX: ffffffff8=
11324bc
> [  575.547022] RDX: 0000000000000002 RSI: dffffc0000000000 RDI: 000000000=
0000001
> [  575.547735] RBP: ffff888104654c38 R08: 0000000000000008 R09: 000000000=
0000000
> [  575.548448] R10: ffff88810469d457 R11: ffffed10208d3a8a R12: 000000000=
0000001
> [  575.549162] R13: ffff888104b43200 R14: ffff888104654c48 R15: 000000000=
0000000
> [  575.549882]  ? preempt_count_sub+0x14/0xb3
> [  575.550315]  ring_buffer_consumer_thread+0x18e/0x475
> [  575.550832]  ? wait_to_die+0x7c/0x7c
> [  575.551237]  ? preempt_latency_start+0x29/0x34
> [  575.551702]  ? wait_to_die+0x7c/0x7c
> [  575.552083]  kthread+0x1ac/0x1bb
> [  575.552434]  ? kthread+0xfd/0x1bb
> [  575.552792]  ? kthread_complete_and_exit+0x20/0x20
> [  575.553288]  ret_from_fork+0x21/0x3c
> [  575.553670]  ? kthread_complete_and_exit+0x20/0x20
> [  575.554166]  ret_from_fork_asm+0x11/0x20
> [  575.554582]  </TASK>
> [  575.554832] ---[ end trace 0000000000000000 ]---
> [  635.894864] ------------[ cut here ]------------
> [  635.895430] refcount_t: saturated; leaking memory.
> [  635.895948] WARNING: CPU: 0 PID: 35 at lib/refcount.c:22 refcount_warn=
_saturate+0x77/0xfc
> [  635.896768] Modules linked in:
> [  635.897101] CPU: 0 PID: 35 Comm: rb_producer Tainted: G        W      =
    6.9.0-rc2-00696-gf549fd6ea775 #28
> [  635.898057] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1=
.16.3-debian-1.16.3-2 04/01/2014
> [  635.898978] RIP: 0010:refcount_warn_saturate+0x77/0xfc
> [  635.899508] Code: b0 8b ff 0f 0b e9 a2 00 00 00 80 3d 81 30 c3 01 00 0=
f 85 95 00 00 00 48 c7 c7 60 96 4e 82 c6 05 6d 30 c3 01 01 e8 02 b0 8b ff <=
0f> 0b eb 7e 80 3d 5c 30 c3 01 00 75 75 48 c7 c7 c0 96 4e 82 c6 05
> [  635.901316] RSP: 0018:ffffc90000007220 EFLAGS: 00010282
> [  635.901854] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 000000000=
0000000
> [  635.902567] RDX: 0000000000000000 RSI: dffffc0000000000 RDI: fffff5200=
0000e35
> [  635.903284] RBP: ffff888104d4f334 R08: 0000000000000004 R09: 000000000=
0000001
> [  635.904010] R10: ffffffff82d552ab R11: fffffbfff05aaa55 R12: 1ffff9200=
0000e50
> [  635.904728] R13: ffffc90000007468 R14: 00000000bfffffff R15: ffff88810=
4ff48c0
> [  635.905441] FS:  0000000000000000(0000) GS:ffffffff82cb2000(0000) knlG=
S:0000000000000000
> [  635.906246] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  635.906833] CR2: 0000558b84610cb0 CR3: 000000010dc88000 CR4: 000000000=
0350ef0
> [  635.907554] Call Trace:
> [  635.907827]  <IRQ>
> [  635.908067]  ? __warn+0xb8/0x13b
> [  635.908416]  ? refcount_warn_saturate+0x77/0xfc
> [  635.908885]  ? report_bug+0xf6/0x159
> [  635.909264]  ? refcount_warn_saturate+0x77/0xfc
> [  635.909733]  ? handle_bug+0x3c/0x64
> [  635.910105]  ? exc_invalid_op+0x13/0x38
> [  635.910508]  ? asm_exc_invalid_op+0x16/0x20
> [  635.910951]  ? refcount_warn_saturate+0x77/0xfc
> [  635.911419]  sock_alloc_send_pskb+0x374/0x3d7
> [  635.911888]  ? sock_wmalloc+0x73/0x73
> [  635.912280]  ? xfrm_tmpl_resolve+0x4d1/0x4d1
> [  635.912730]  __ip_append_data+0x705/0x12f8
> [  635.913159]  ? icmp_unreach+0x2f7/0x2f7
> [  635.913572]  ? preempt_count_sub+0x14/0xb3
> [  635.914002]  ? skb_zcopy_set+0xb9/0xb9
> [  635.914400]  ? xfrm_lookup_with_ifid+0x68a/0x768
> [  635.914881]  ? sock_flag+0x15/0x20
> [  635.915255]  ip_append_data+0xc3/0xd6
> [  635.915646]  ? icmp_unreach+0x2f7/0x2f7
> [  635.916059]  icmp_push_reply+0x61/0x1b6
> [  635.916462]  icmp_reply+0x3a3/0x410
> [  635.916844]  ? __icmp_send+0x77a/0x77a
> [  635.917241]  ? fib_validate_source+0x128/0x1ca
> [  635.917703]  ? rt_cache_valid+0x70/0x8d
> [  635.918109]  ? do_csum+0xe2/0x13f
> [  635.918468]  icmp_echo.part.0+0xf5/0x130
> [  635.918881]  ? icmp_timestamp+0x19d/0x19d
> [  635.919310]  ? __skb_checksum+0x317/0x317
> [  635.919733]  ? csum_block_add_ext+0x10/0x10
> [  635.920169]  ? reqsk_fastopen_remove+0x249/0x249
> [  635.920645]  ? refcount_read+0x16/0x1a
> [  635.921039]  icmp_echo+0x58/0x5d
> [  635.921386]  icmp_rcv+0x482/0x4ec
> [  635.921743]  ip_protocol_deliver_rcu+0xd7/0x1b2
> [  635.922211]  ? ip_protocol_deliver_rcu+0x1b2/0x1b2
> [  635.922703]  ip_local_deliver_finish+0x110/0x120
> [  635.923186]  ? ip_protocol_deliver_rcu+0x1b2/0x1b2
> [  635.923678]  NF_HOOK.constprop.0+0xf8/0x138
> [  635.924116]  ? ip_sublist_rcv_finish+0x68/0x68
> [  635.924576]  ? __asan_load8+0x74/0x74
> [  635.924964]  ? do_csum+0xe2/0x13f
> [  635.925320]  ? __list_del_entry_valid_or_report+0xc8/0xed
> [  635.925868]  ip_sublist_rcv_finish+0x53/0x68
> [  635.926313]  ip_sublist_rcv+0x24f/0x29b
> [  635.926716]  ? ip_rcv_finish_core.isra.0+0x74d/0x74d
> [  635.927230]  ? skb_orphan_frags_rx.constprop.0+0x3a/0x67
> [  635.927770]  ? do_csum+0xe2/0x13f
> [  635.928136]  ? __asan_memset+0x21/0x3f
> [  635.928532]  ? ip_rcv_core+0x4a6/0x4f7
> [  635.928928]  ip_list_rcv+0x18a/0x1c2
> [  635.929308]  ? ip_rcv+0x57/0x57
> [  635.929653]  ? __list_add_valid_or_report+0x66/0xad
> [  635.930155]  ? __netif_receive_skb_list_ptype+0x3a/0xca
> [  635.930687]  __netif_receive_skb_list_core+0x17b/0x1c2
> [  635.931220]  ? __netif_receive_skb_core.constprop.0+0xb24/0xb24
> [  635.931820]  ? gro_normal_list+0x16/0x65
> [  635.932236]  ? __list_add_valid_or_report+0x66/0xad
> [  635.932738]  netif_receive_skb_list_internal+0x2bd/0x316
> [  635.933279]  ? process_backlog+0x187/0x187
> [  635.933707]  ? virtnet_poll+0x4a6/0x6cf
> [  635.934113]  ? virtnet_set_ringparam+0x595/0x595
> [  635.934591]  gro_normal_list+0x2e/0x65
> [  635.934994]  napi_complete_done+0x13b/0x246
> [  635.935431]  ? gro_normal_list+0x65/0x65
> [  635.935853]  ? gro_normal_one+0x9e/0xef
> [  635.936258]  gro_cell_poll+0x42/0x4b
> [  635.936639]  __napi_poll.constprop.0+0x57/0x1a7
> [  635.937109]  net_rx_action+0x1cb/0x380
> [  635.937511]  ? __napi_poll.constprop.0+0x1a7/0x1a7
> [  635.938003]  ? internal_add_timer+0xbf/0xbf
> [  635.938439]  ? vring_interrupt+0xba/0xc4
> [  635.938855]  ? __handle_irq_event_percpu+0x180/0x197
> [  635.939371]  ? handle_irq_event_percpu+0x3b/0x40
> [  635.939850]  __do_softirq+0x135/0x2d7
> [  635.940239]  common_interrupt+0x93/0xb8
> [  635.940643]  </IRQ>
> [  635.940883]  <TASK>
> [  635.941123]  asm_common_interrupt+0x22/0x40
> [  635.941558] RIP: 0010:__asan_store8+0x0/0x77
> [  635.942001] Code: 28 38 d0 eb 16 ba ff ff 37 00 48 c1 e8 03 48 c1 e2 2=
a 8a 04 10 84 c0 74 10 3c 07 7f 0c 31 d2 be 08 00 00 00 e9 5b f4 ff ff c3 <=
48> 8b 0c 24 48 83 ff f8 73 5d 48 b8 ff ff ff ff ff 7f ff ff 48 39
> [  635.943797] RSP: 0018:ffffc90000247cf0 EFLAGS: 00000246
> [  635.944343] RAX: ffffed1020968601 RBX: ffffc90000247df0 RCX: ffffed102=
096865e
> [  635.945049] RDX: ffffed102096865e RSI: ffffed102096865e RDI: ffff88810=
4b432e8
> [  635.945755] RBP: ffff888104b43200 R08: 0000000000000008 R09: 000000000=
0000001
> [  635.946461] R10: ffff888104b432ef R11: ffffed102096865d R12: 000000000=
0000000
> [  635.947173] R13: 00000094124d099d R14: 0000000000000fd0 R15: ffff88810=
4679140
> [  635.947893]  __rb_reserve_next.constprop.0+0x1e1/0x7e3
> [  635.948419]  ring_buffer_lock_reserve+0x26a/0x688
> [  635.948903]  ? __rb_reserve_next.constprop.0+0x7e3/0x7e3
> [  635.949444]  ring_buffer_producer_thread+0x9d/0x524
> [  635.949950]  ? ring_buffer_consumer_thread+0x475/0x475
> [  635.950473]  kthread+0x1ac/0x1bb
> [  635.950822]  ? kthread+0xfd/0x1bb
> [  635.951184]  ? kthread_complete_and_exit+0x20/0x20
> [  635.951677]  ret_from_fork+0x21/0x3c
> [  635.952061]  ? kthread_complete_and_exit+0x20/0x20
> [  635.952553]  ret_from_fork_asm+0x11/0x20
> [  635.952966]  </TASK>
> [  635.953213] ---[ end trace 0000000000000000 ]---
> [  829.757162] systemd-fstab-generator[2633]: Failed to create unit file
> '/run/systemd/generator/home.mount', as it already exists. Duplicate entry
> in '/etc/fstab'?
>
>
>
>
>>
>> Thanks!
>> Chris.
>>
>> Christian Hopps <chopps@chopps.org> writes:
>>
>> > [[PGP Signed Part:Good signature from 2E1D830ED7B83025 Christian Hopps=
 <chopps@gmail.com> (trust ultimate) created at 2024-05-24T08:08:58-0400 us=
ing RSA]]
>> >
>> > This is very helpful thanks.
>> >
>> > I think the tunnel endpoints are east/west 192.1.2.{23,45}, but I can'=
t determine the north/east endpoints b/c they don't appear connected. :)
>> >
>> > Are there any other iptfs options? The code you highlight mentions the=
 `dont-frag` option, but I wonder if you actually have that enabled?
>> >
>> > It also seems like you are pinging and forcing the source IP of a red =
interface
>> > on the tunnel endpoint gateway directly (so that it doesn't try and us=
e the
>> > black interface I would guess) is that correct?
>> >
>> > Thanks!
>> > Chris.
>> >
>> > P.S. the addresses on the NIC host in the picture seem reversed, but t=
his doesn't seem relevant to this test :)
>> >
>> > Antony Antony <antony@phenome.org> writes:
>> >
>> > > On Thu, May 23, 2024 at 07:04:58PM -0400, Christian Hopps wrote:
>> > > >
>> > > > Could you let me know some more details about this test? What is y=
our interface config / topology?. I tried to guess given the ping command b=
ut it's not replicating for me.
>> > >
>> > > I am using Libreswan testing topology. However, I am running test ma=
nually.
>> > > Yesterday tunnel between north and east. This morning I quickly tried
>> > > between west-east. Just two VM. I see the same issue there too.
>> > >
>> > > https://libreswan.org/wiki/images/f/f1/Testnet-202102.png
>> > >
>> > > I am using CONFIG_ESP_OFFLOAD. That is only thing standing out. Besi=
des it
>> > > is just a 1500 MTU tunnels using qemu/kvm and tap network.
>> > >
>> > > attached is my kernel .config
>> > >
>> > > > PS, I've changed the subject and In-reply-to to be based on the co=
rrected
>> > > > cover-letter I sent, I initially sent the cover letter with the wr=
ong
>> > > > subject. :(
>> > >
>> > > I noticed a second cover letter. However, it was not showing as rela=
ted to
>> > > patch set correctly. It showed up as a diffrent thread. That is why I
>> > > replied to the initial one
>> > >
>> > > -antony
>> > > >
>> > > >
>> > > > Antony Antony <antony@phenome.org> writes:
>> > > >
>> > > > > Hi Chris,
>> > > > >
>> > > > > On Mon, May 20, 2024 at 05:42:38PM -0400, Christian Hopps via De=
vel wrote:
>> > > > > > From: Christian Hopps <chopps@labn.net>
>> > > > > >   - iptfs: remove some BUG_ON() assertions questioned in revie=
w.
>> > > >
>> > > > ...
>> > > >
>> > > > > I ran a couple of tests and it hit KSAN BUG.
>> > > > >
>> > > > > I was sending large ping while MTU is 1500.
>> > > > >
>> > > > > north login: shed systemd-user-sessions.service - Permit User Se=
ssions.
>> > > > > north login: [   78.594770] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>> > > > > [   78.595825] BUG: KASAN: null-ptr-deref in iptfs_output_collec=
t+0x263/0x57b
>> > > > > [   78.596658] Read of size 8 at addr 0000000000000108 by task p=
ing/493
>> > > > > [   78.597435] ng rpc-statd-notify.service - Notify NFS peers of=
 a restart...
>> > > > > [   78.597651] CPU: 0 PID: 493 Comm: ping Not tainted 6.9.0-rc2-=
00697-g489ca863e24f-dirty #11
>> > > > > [   78.598645] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009=
), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
>> > > > > [   78.599747] Call Trace:tty@ttyS2.service - Serial Getty on tt=
yS2.
>> > > > > [   78.600070]  <TASK>l-getty@ttyS3.service - Serial Getty on tt=
yS3.
>> > > > > [   78.600354]  dump_stack_lvl+0x2a/0x3bogin Prompts.
>> > > > > [   78.600817]  kasan_report+0x84/0xa6rvice - Hostname Service...
>> > > > > [   78.601262]  ? iptfs_output_collect+0x263/0x57bl server.
>> > > > > [   78.601825]  iptfs_output_collect+0x263/0x57bogin Management.
>> > > > > [   78.602374]  ip_send_skb+0x25/0x57vice - Notify NFS peers of =
a restart.
>> > > > > [   78.602807]  raw_sendmsg+0xee8/0x1011t - Multi-User System.
>> > > > > [   78.603269]  ? native_flush_tlb_one_user+0xd/0xe5e Service.
>> > > > > [   78.603850]  ? raw_hash_sk+0x21b/0x21b
>> > > > > [   78.604331]  ? kernel_init_pages+0x42/0x51
>> > > > > [   78.604845]  ? prep_new_page+0x44/0x51Re=E2=80=A6line ext4 Me=
tadata Check Snapshots.
>> > > > > [   78.605318]  ? get_page_from_freelist+0x72b/0x915 Interface.
>> > > > > [   78.605903]  ? signal_pending_state+0x77/0x77cord Runlevel Ch=
ange in UTMP...
>> > > > > [   78.606462]  ? __might_resched+0x8a/0x240e - Record Runlevel =
Change in UTMP.
>> > > > > [   78.606966]  ? __might_sleep+0x25/0xa0
>> > > > > [   78.607440]  ? first_zones_zonelist+0x2c/0x43
>> > > > > [   78.607985]  ? __rcu_read_lock+0x2d/0x3a
>> > > > > [   78.608479]  ? __pte_offset_map+0x32/0xa4
>> > > > > [   78.608979]  ? __might_resched+0x8a/0x240
>> > > > > [   78.609478]  ? __might_sleep+0x25/0xa0
>> > > > > [   78.609949]  ? inet_send_prepare+0x54/0x54
>> > > > > [   78.610464]  ? sock_sendmsg_nosec+0x42/0x6c
>> > > > > [   78.610984]  sock_sendmsg_nosec+0x42/0x6c
>> > > > > [   78.611485]  __sys_sendto+0x15d/0x1cc
>> > > > > [   78.611947]  ? __x64_sys_getpeername+0x44/0x44
>> > > > > [   78.612498]  ? __handle_mm_fault+0x679/0xae4
>> > > > > [   78.613033]  ? find_vma+0x6b/0x8b
>> > > > > [   78.613457]  ? find_vma_intersection+0x8a/0x8a
>> > > > > [   78.614006]  ? __handle_irq_event_percpu+0x180/0x197
>> > > > > [   78.614617]  ? handle_mm_fault+0x38/0x154
>> > > > > [   78.615114]  ? handle_mm_fault+0xeb/0x154
>> > > > > [   78.615620]  ? preempt_latency_start+0x29/0x34
>> > > > > [   78.616169]  ? preempt_count_sub+0x14/0xb3
>> > > > > [   78.616678]  ? up_read+0x4b/0x5c
>> > > > > [   78.617094]  __x64_sys_sendto+0x76/0x82
>> > > > > [   78.617577]  do_syscall_64+0x6b/0xd7
>> > > > > [   78.618043]  entry_SYSCALL_64_after_hwframe+0x46/0x4e
>> > > > > [   78.618667] RIP: 0033:0x7fed3de99a73
>> > > > > [ 78.619118] Code: 8b 15 a9 83 0c 00 f7 d8 64 89 02 48 c7 c0 ff =
ff ff ff eb b8
>> > > > > 0f 1f 00 80 3d 71 0b 0d 00 00 41 89 ca 74 14 b8 2c 00 00 00 0f 0=
5 <48> 3d 00 f0
>> > > > > ff ff 77 75 c3 0f 1f 40 00 55 48 83 ec 30 44 89 4c 24
>> > > > > [   78.621291] RSP: 002b:00007ffff6bdf478 EFLAGS: 00000202 ORIG_=
RAX: 000000000000002c
>> > > > > [   78.622205] RAX: ffffffffffffffda RBX: 000055c538159340 RCX: =
00007fed3de99a73
>> > > > > [   78.623056] RDX: 00000000000007d8 RSI: 000055c53815f3c0 RDI: =
0000000000000003
>> > > > > [   78.623908] RBP: 000055c53815f3c0 R08: 000055c53815b5c0 R09: =
0000000000000010
>> > > > > [   78.624765] R10: 0000000000000000 R11: 0000000000000202 R12: =
00000000000007d8
>> > > > > [   78.625619] R13: 00007ffff6be0b60 R14: 0000001d00000001 R15: =
000055c53815c680
>> > > > > [   78.626480]  </TASK>
>> > > > > [   78.626773] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > > > > [   78.627656] Disabling lock debugging due to kernel taint
>> > > > > [   78.628305] BUG: kernel NULL pointer dereference, address: 00=
00000000000108
>> > > > > [   78.629136] #PF: supervisor read access in kernel mode
>> > > > > [   78.629766] #PF: error_code(0x0000) - not-present page
>> > > > > [   78.630402] PGD 0 P4D 0
>> > > > > [   78.630739] Oops: 0000 [#1] PREEMPT DEBUG_PAGEALLOC KASAN
>> > > > > [   78.631398] CPU: 0 PID: 493 Comm: ping Tainted: G    B       =
       6.9.0-rc2-00697-g489ca863e24f-dirty #11
>> > > > > [   78.632548] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009=
), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
>> > > > > [   78.633649] RIP: 0010:iptfs_output_collect+0x263/0x57b
>> > > > > [ 78.634283] Code: 73 70 0f 84 25 01 00 00 45 39 f4 0f 83 1c 01 =
00 00 48 8d 7b
>> > > > > 10 e8 27 37 62 ff 4c 8b 73 10 49 8d be 08 01 00 00 e8 17 37 62 f=
f <4d> 8b b6 08
>> > > > > 01 00 00 49 8d be b0 01 00 00 e8 04 37 62 ff 49 8b 86
>> > > > > [   78.636444] RSP: 0018:ffffc90000d679c8 EFLAGS: 00010296
>> > > > > [   78.637076] RAX: 0000000000000001 RBX: ffff888110ffbc80 RCX: =
fffffbfff07623ad
>> > > > > [   78.637923] RDX: fffffbfff07623ad RSI: fffffbfff07623ad RDI: =
ffffffff83b11d60
>> > > > > [   78.638792] RBP: ffff88810e3a1400 R08: 0000000000000008 R09: =
0000000000000001
>> > > > > [   78.639645] R10: ffffffff83b11d67 R11: fffffbfff07623ac R12: =
00000000000005a2
>> > > > > [   78.640498] R13: 0000000000000000 R14: 0000000000000000 R15: =
ffff88810e9a3401
>> > > > > [   78.641359] FS:  00007fed3dbddc40(0000) GS:ffffffff82cb2000(0=
000) knlGS:0000000000000000
>> > > > > [   78.642324] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> > > > > [   78.643022] CR2: 0000000000000108 CR3: 0000000110e84000 CR4: =
0000000000350ef0
>> > > > > [   78.643882] Call Trace:
>> > > > > [   78.644204]  <TASK>
>> > > > > [   78.644487]  ? __die_body+0x1a/0x56
>> > > > > [   78.644929]  ? page_fault_oops+0x45f/0x4cd
>> > > > > [   78.645441]  ? dump_pagetable+0x1db/0x1db
>> > > > > [   78.645942]  ? vprintk_emit+0x163/0x171
>> > > > > [   78.646425]  ? iptfs_output_collect+0x263/0x57b
>> > > > > [   78.646986]  ? _printk+0xb2/0xe1
>> > > > > [   78.647401]  ? find_first_fitting_seq+0x193/0x193
>> > > > > [   78.647982]  ? iptfs_output_collect+0x263/0x57b
>> > > > > [   78.648541]  ? do_user_addr_fault+0x14f/0x56c
>> > > > > [   78.649084]  ? exc_page_fault+0xa5/0xbe
>> > > > > [   78.649566]  ? asm_exc_page_fault+0x22/0x30
>> > > > > [   78.650100]  ? iptfs_output_collect+0x263/0x57b
>> > > > > [   78.650660]  ? iptfs_output_collect+0x263/0x57b
>> > > > > [   78.651221]  ip_send_skb+0x25/0x57
>> > > > > [   78.651652]  raw_sendmsg+0xee8/0x1011
>> > > > > [   78.652113]  ? native_flush_tlb_one_user+0xd/0xe5
>> > > > > [   78.652693]  ? raw_hash_sk+0x21b/0x21b
>> > > > > [   78.653166]  ? kernel_init_pages+0x42/0x51
>> > > > > [   78.653683]  ? prep_new_page+0x44/0x51
>> > > > > [   78.654160]  ? get_page_from_freelist+0x72b/0x915
>> > > > > [   78.654739]  ? signal_pending_state+0x77/0x77
>> > > > > [   78.655284]  ? __might_resched+0x8a/0x240
>> > > > > [   78.655784]  ? __might_sleep+0x25/0xa0
>> > > > > [   78.656255]  ? first_zones_zonelist+0x2c/0x43
>> > > > > [   78.656798]  ? __rcu_read_lock+0x2d/0x3a
>> > > > > [   78.657289]  ? __pte_offset_map+0x32/0xa4
>> > > > > [   78.657788]  ? __might_resched+0x8a/0x240
>> > > > > [   78.658291]  ? __might_sleep+0x25/0xa0
>> > > > > [   78.658763]  ? inet_send_prepare+0x54/0x54
>> > > > > [   78.659272]  ? sock_sendmsg_nosec+0x42/0x6c
>> > > > > [   78.659791]  sock_sendmsg_nosec+0x42/0x6c
>> > > > > [   78.660293]  __sys_sendto+0x15d/0x1cc
>> > > > > [   78.660755]  ? __x64_sys_getpeername+0x44/0x44
>> > > > > [   78.661304]  ? __handle_mm_fault+0x679/0xae4
>> > > > > [   78.661838]  ? find_vma+0x6b/0x8b
>> > > > > [   78.662272]  ? find_vma_intersection+0x8a/0x8a
>> > > > > [   78.662828]  ? __handle_irq_event_percpu+0x180/0x197
>> > > > > [   78.663436]  ? handle_mm_fault+0x38/0x154
>> > > > > [   78.663935]  ? handle_mm_fault+0xeb/0x154
>> > > > > [   78.664435]  ? preempt_latency_start+0x29/0x34
>> > > > > [   78.664987]  ? preempt_count_sub+0x14/0xb3
>> > > > > [   78.665498]  ? up_read+0x4b/0x5c
>> > > > > [   78.665911]  __x64_sys_sendto+0x76/0x82
>> > > > > [   78.666398]  do_syscall_64+0x6b/0xd7
>> > > > > [   78.666849]  entry_SYSCALL_64_after_hwframe+0x46/0x4e
>> > > > > [   78.667466] RIP: 0033:0x7fed3de99a73
>> > > > > [ 78.667918] Code: 8b 15 a9 83 0c 00 f7 d8 64 89 02 48 c7 c0 ff =
ff ff ff eb b8
>> > > > > 0f 1f 00 80 3d 71 0b 0d 00 00 41 89 ca 74 14 b8 2c 00 00 00 0f 0=
5 <48> 3d 00 f0
>> > > > > ff ff 77 75 c3 0f 1f 40 00 55 48 83 ec 30 44 89 4c 24
>> > > > > [   78.670097] RSP: 002b:00007ffff6bdf478 EFLAGS: 00000202 ORIG_=
RAX: 000000000000002c
>> > > > > [   78.671002] RAX: ffffffffffffffda RBX: 000055c538159340 RCX: =
00007fed3de99a73
>> > > > > [   78.671858] RDX: 00000000000007d8 RSI: 000055c53815f3c0 RDI: =
0000000000000003
>> > > > > [   78.672708] RBP: 000055c53815f3c0 R08: 000055c53815b5c0 R09: =
0000000000000010
>> > > > > [   78.673564] R10: 0000000000000000 R11: 0000000000000202 R12: =
00000000000007d8
>> > > > > [   78.674430] R13: 00007ffff6be0b60 R14: 0000001d00000001 R15: =
000055c53815c680
>> > > > > [   78.675287]  </TASK>
>> > > > > [   78.675580] Modules linked in:
>> > > > > [   78.675975] CR2: 0000000000000108
>> > > > > [   78.676396] ---[ end trace 0000000000000000 ]---
>> > > > > [   78.676966] RIP: 0010:iptfs_output_collect+0x263/0x57b
>> > > > > [ 78.677596] Code: 73 70 0f 84 25 01 00 00 45 39 f4 0f 83 1c 01 =
00 00 48 8d 7b
>> > > > > 10 e8 27 37 62 ff 4c 8b 73 10 49 8d be 08 01 00 00 e8 17 37 62 f=
f <4d> 8b b6 08
>> > > > > 01 00 00 49 8d be b0 01 00 00 e8 04 37 62 ff 49 8b 86
>> > > > > [   78.679768] RSP: 0018:ffffc90000d679c8 EFLAGS: 00010296
>> > > > > [   78.680410] RAX: 0000000000000001 RBX: ffff888110ffbc80 RCX: =
fffffbfff07623ad
>> > > > > [   78.681264] RDX: fffffbfff07623ad RSI: fffffbfff07623ad RDI: =
ffffffff83b11d60
>> > > > > [   78.682136] RBP: ffff88810e3a1400 R08: 0000000000000008 R09: =
0000000000000001
>> > > > > [   78.682997] R10: ffffffff83b11d67 R11: fffffbfff07623ac R12: =
00000000000005a2
>> > > > > [   78.683853] R13: 0000000000000000 R14: 0000000000000000 R15: =
ffff88810e9a3401
>> > > > > [   78.684710] FS:  00007fed3dbddc40(0000) GS:ffffffff82cb2000(0=
000) knlGS:0000000000000000
>> > > > > [   78.685675] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> > > > > [   78.686387] CR2: 0000000000000108 CR3: 0000000110e84000 CR4: =
0000000000350ef0
>> > > > > [   78.687246] Kernel panic - not syncing: Fatal exception in in=
terrupt
>> > > > > [   78.688014] Kernel Offset: disabled
>> > > > > [   78.688460] ---[ end Kernel panic - not syncing: Fatal except=
ion in interrupt ]---
>> > > > >
>> > > > > ping -s 2000  -n -q -W 1 -c 2 -I 192.0.3.254  192.0.2.254
>> > > > >
>> > > > > (gdb) list *iptfs_output_collect+0x263
>> > > > > 0xffffffff81d5076f is in iptfs_output_collect (./include/net/net=
_namespace.h:383).
>> > > > > 378	}
>> > > > > 379
>> > > > > 380	static inline struct net *read_pnet(const possible_net_t *pn=
et)
>> > > > > 381	{
>> > > > > 382	#ifdef CONFIG_NET_NS
>> > > > > 383		return rcu_dereference_protected(pnet->net, true);
>> > > > > 384	#else
>> > > > > 385		return &init_net;
>> > > > > 386	#endif
>> > > > > 387	}
>> > > > >
>> > > > > I suspect actual crash is from the line 1756 instead,
>> > > > > (gdb) list *iptfs_output_collect+0x256
>> > > > > 0xffffffff81d50762 is in iptfs_output_collect (net/xfrm/xfrm_ipt=
fs.c:1756).
>> > > > > 1751			return 0;
>> > > > > 1752
>> > > > > 1753		/* We only send ICMP too big if the user has configured us=
 as
>> > > > > 1754		 * dont-fragment.
>> > > > > 1755		 */
>> > > > > 1756		XFRM_INC_STATS(dev_net(skb->dev), LINUX_MIB_XFRMOUTERROR);
>> > > > > 1757
>> > > > > 1758		if (sk) {
>> > > > > 1759			xfrm_local_error(skb, pmtu);
>> > > > > 1760		} else if (ip_hdr(skb)->version =3D=3D 4) {
>> > > > >
>> > > > > Later I ran with gdb iptfs_is_too_big which is called twice and =
second time
>> > > > > it crash.
>> > > > > Here is gdb bt. Just before the crash
>> > > > >
>> > > > > #0  iptfs_is_too_big (pmtu=3D1442, skb=3D0xffff88810dbea3c0, sk=
=3D0xffff888104d4ed40) at net/xfrm/xfrm_iptfs.c:1756
>> > > > > #1  iptfs_output_collect (net=3D<optimized out>, sk=3D0xffff8881=
04d4ed40, skb=3D0xffff88810dbea3c0) at net/xfrm/xfrm_iptfs.c:1847
>> > > > > #2  0xffffffff81c8a3cb in ip_send_skb (net=3D0xffffffff83e57f20 =
<init_net>, skb=3D0xffff88810dbea3c0)
>> > > > >     at net/ipv4/ip_output.c:1492
>> > > > > #3  0xffffffff81c8a439 in ip_push_pending_frames (sk=3Dsk@entry=
=3D0xffff888104d4ed40, fl4=3Dfl4@entry=3D0xffffc90000e3fb90)
>> > > > >     at net/ipv4/ip_output.c:1512
>> > > > > #4  0xffffffff81ccf3cf in raw_sendmsg (sk=3D0xffff888104d4ed40, =
msg=3D0xffffc90000e3fd80, len=3D<optimized out>)
>> > > > >     at net/ipv4/raw.c:654
>> > > > > #5  0xffffffff81b096ea in sock_sendmsg_nosec (sock=3Dsock@entry=
=3D0xffff888115136040, msg=3Dmsg@entry=3D0xffffc90000e3fd80)
>> > > > >     at net/socket.c:730
>> > > > > #6  0xffffffff81b0c327 in __sock_sendmsg (msg=3D0xffffc90000e3fd=
80, sock=3D0xffff888115136040) at net/socket.c:745
>> > > > > #7  __sys_sendto (fd=3D<optimized out>, buff=3Dbuff@entry=3D0x55=
8edefb73c0, len=3Dlen@entry=3D2008, flags=3Dflags@entry=3D0,
>> > > > >     addr=3Daddr@entry=3D0x558edefb35c0, addr_len=3Daddr_len@entr=
y=3D16) at net/socket.c:2191
>> > > > > #8  0xffffffff81b0c40c in __do_sys_sendto (addr_len=3D16, addr=
=3D0x558edefb35c0, flags=3D0, len=3D2008, buff=3D0x558edefb73c0,
>> > > > >     fd=3D<optimized out>) at net/socket.c:2203
>> > > > > #9  __se_sys_sendto (addr_len=3D16, addr=3D94072114722240, flags=
=3D0, len=3D2008, buff=3D94072114738112, fd=3D<optimized out>)
>> > > > >     at net/socket.c:2199
>> > > > >
>> > > > > gdb) list
>> > > > > 1751			return 0;
>> > > > > 1752
>> > > > > 1753		/* We only send ICMP too big if the user has configured us=
 as
>> > > > > 1754		 * dont-fragment.
>> > > > > 1755		 */
>> > > > > 1756		XFRM_INC_STATS(dev_net(skb->dev), LINUX_MIB_XFRMOUTERROR);
>> > > > > 1757
>> > > > > 1758		if (sk) {
>> > > > > 1759			xfrm_local_error(skb, pmtu);
>> > > > > 1760		} else if (ip_hdr(skb)->version =3D=3D 4) {
>> > > > >
>> > > > > -antony
>> > > >
>> > >
>> > > [2. text/plain; .config]...
>> >
>> > [[End of PGP Signed Part]]
>>
>> a
>
>
>
>> --
>> Devel mailing list
>> Devel@linux-ipsec.org
>> https://linux-ipsec.org/mailman/listinfo/devel


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJGBAEBCgAwFiEEm56yH/NF+m1FHa6lLh2DDte4MCUFAmZiopYSHGNob3Bwc0Bj
aG9wcHMub3JnAAoJEC4dgw7XuDAlN7gP/2rKtihyIkUEB6kpaES4NCLURxIeWxan
wjPvnwxUe2jQnLt3vJT0qIPQhbvZMM7JlwHMUMDg3KTV7qy8QFw2Dz32K2pbAznW
cCjKcnzwCLTRzrOU7wVOJ2QA8qMy1ZOIY0CybvSTciiR75Qz+qm/D11/Mol5tNXf
v5kjZbjpsFQ/44okqhDBhfvRcD9hBtGAu4VippI6/T/G1kOnlcrNYGBffds69Yl6
a9fwi1JofpsLY7DF5x1csb8G0IhmzNatQl78uBqJuQg34fAfk5sJ3oJ5ZBq/7WIX
o+ld3GPCNop3fuF20IDZliqo4vGOZTJEzxSEtyrSl86aWeqVRcJwX1+nxXs2Ut9D
VgPWI9py14cTNe5nz/K/dcK4NqmX5ipuPlNVKv3kX2468aKRF08YSASoIui7OmPt
vumaUq6EMgv6axHRZn//22W9Ay2xNpzNPmEDT90uqBGKp/e4C6pvPaL23yxQzGQI
VELDJaouNW8udMXisfyeGVFJkxVUTPdlKAwYCtJ6sLTVM3ls0cfsJIiwcuroGGas
RNv9zajPkQuM7g6ELhE2T8NUodNQrO4yEkeDSprottmPEgVAXA5AU2FwqEzQqSUt
lJVr2ov0ruk7CxPduP+7wrCpVcVKFcJ6YERwhxx+sITAuVDJ3CmaD+1x82+ZWdoE
yGeAN87baDPB
=BuHa
-----END PGP SIGNATURE-----
--=-=-=--

