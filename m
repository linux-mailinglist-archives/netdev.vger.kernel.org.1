Return-Path: <netdev+bounces-63677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 542CA82ECBF
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 11:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 003FA284FCE
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 10:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEBF134DC;
	Tue, 16 Jan 2024 10:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U/ohX62O"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84D4134D5
	for <netdev@vger.kernel.org>; Tue, 16 Jan 2024 10:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705400781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HnpO098acdJplRGTYkCp3LkC8326dCzgx9K7ZJ59bc4=;
	b=U/ohX62ObQ9dNuGvYwxIC5eIxxRBdxSFSDVUbzc6VO4M8C7EDV95gtxrXhupqqYydafe4c
	FaFZaYEZ+E5bfKVvm6k50mzzoqkjqDeuRSOyRiwuo8zsXnLiygKKToI1/4jbArSB3jGPT/
	ZdGczUlqRXDtWUjpXgEvjNVoY/Z+DpE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-7l3f_XeYOnC42dhZmCufsg-1; Tue, 16 Jan 2024 05:26:20 -0500
X-MC-Unique: 7l3f_XeYOnC42dhZmCufsg-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-68143f4fd03so8543636d6.1
        for <netdev@vger.kernel.org>; Tue, 16 Jan 2024 02:26:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705400779; x=1706005579;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HnpO098acdJplRGTYkCp3LkC8326dCzgx9K7ZJ59bc4=;
        b=dyvIQsjFqJncr52tjnUDDUbsFelBoQ36pClLX086GUGQxkuLTa2pCUPMjugFJLIBNO
         jtrxMZMO2K2ZKpzMl5j6Sgs8MTGuDNBMLBkxnafaHCZLqB89u+QXMILcDFvfCJ7VZy+l
         T7n+39OPKe1ea1IG1MzeCiFq51ohYlLPn92zIZwa3r8MCmOfb19/b+JmaqWUJtStZT7x
         Z+LicyZ/r7B9ky73nVw+MRI8apvlIwp0gKUmsLzspEy1S5WdW4SWgOF0aiIQj2kkdLS8
         efLCzfGEDaPD/mOnjiUyZCnD0C9yy/jcVEK62czcxUZcgO3ExvfjTTaLG3LctR+AF/8q
         k8EQ==
X-Gm-Message-State: AOJu0Yy5+We2+bktDz8X5jEW/4eSSX5M/G/Ynej/Sf4Y1QEjAPkcQ/MS
	qtadegjPberCLkEFQUUif7PGfGm8/adrCJPAPQZrw51wvXKdTsGd54wPX1buruhaKfPmtricLTr
	ZucEKa6a+BB2hvsaRy3I0Ysu3
X-Received: by 2002:a0c:ec09:0:b0:681:5533:213 with SMTP id y9-20020a0cec09000000b0068155330213mr8899107qvo.2.1705400779397;
        Tue, 16 Jan 2024 02:26:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHH4wgfY9/gCS5X9VL48B4jA6JSjXh5Bt9UkTAu6tIREdn91Z7W8wGR8mJUXekfw5xUxnnU7Q==
X-Received: by 2002:a0c:ec09:0:b0:681:5533:213 with SMTP id y9-20020a0cec09000000b0068155330213mr8899094qvo.2.1705400779106;
        Tue, 16 Jan 2024 02:26:19 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-241-126.dyn.eolo.it. [146.241.241.126])
        by smtp.gmail.com with ESMTPSA id c8-20020ad44308000000b0067f7c11651esm4076074qvs.128.2024.01.16.02.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 02:26:18 -0800 (PST)
Message-ID: <0b0af55211d1ab8884c01e667f8bb5f8972c1622.camel@redhat.com>
Subject: Re: [PATCH net,v2] tcp: make sure init the accept_queue's spinlocks
 once
From: Paolo Abeni <pabeni@redhat.com>
To: Zhengchao Shao <shaozhengchao@huawei.com>, netdev@vger.kernel.org, 
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 dsahern@kernel.org
Cc: hkchu@google.com, weiyongjun1@huawei.com, yuehaibing@huawei.com
Date: Tue, 16 Jan 2024 11:26:15 +0100
In-Reply-To: <20240113030739.3446338-1-shaozhengchao@huawei.com>
References: <20240113030739.3446338-1-shaozhengchao@huawei.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-01-13 at 11:07 +0800, Zhengchao Shao wrote:
> When I run syz's reproduction C program locally, it causes the following
> issue:
> pvqspinlock: lock 0xffff9d181cd5c660 has corrupted value 0x0!
> WARNING: CPU: 19 PID: 21160 at __pv_queued_spin_unlock_slowpath (kernel/l=
ocking/qspinlock_paravirt.h:508)
> Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
> RIP: 0010:__pv_queued_spin_unlock_slowpath (kernel/locking/qspinlock_para=
virt.h:508)
> Code: 73 56 3a ff 90 c3 cc cc cc cc 8b 05 bb 1f 48 01 85 c0 74 05 c3 cc c=
c cc cc 8b 17 48 89 fe 48 c7 c7
> 30 20 ce 8f e8 ad 56 42 ff <0f> 0b c3 cc cc cc cc 0f 0b 0f 1f 40 00 90 90=
 90 90 90 90 90 90 90
> RSP: 0018:ffffa8d200604cb8 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff9d1ef60e0908
> RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff9d1ef60e0900
> RBP: ffff9d181cd5c280 R08: 0000000000000000 R09: 00000000ffff7fff
> R10: ffffa8d200604b68 R11: ffffffff907dcdc8 R12: 0000000000000000
> R13: ffff9d181cd5c660 R14: ffff9d1813a3f330 R15: 0000000000001000
> FS:  00007fa110184640(0000) GS:ffff9d1ef60c0000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020000000 CR3: 000000011f65e000 CR4: 00000000000006f0
> Call Trace:
> <IRQ>
>   _raw_spin_unlock (kernel/locking/spinlock.c:186)
>   inet_csk_reqsk_queue_add (net/ipv4/inet_connection_sock.c:1321)
>   inet_csk_complete_hashdance (net/ipv4/inet_connection_sock.c:1358)
>   tcp_check_req (net/ipv4/tcp_minisocks.c:868)
>   tcp_v4_rcv (net/ipv4/tcp_ipv4.c:2260)
>   ip_protocol_deliver_rcu (net/ipv4/ip_input.c:205)
>   ip_local_deliver_finish (net/ipv4/ip_input.c:234)
>   __netif_receive_skb_one_core (net/core/dev.c:5529)
>   process_backlog (./include/linux/rcupdate.h:779)
>   __napi_poll (net/core/dev.c:6533)
>   net_rx_action (net/core/dev.c:6604)
>   __do_softirq (./arch/x86/include/asm/jump_label.h:27)
>   do_softirq (kernel/softirq.c:454 kernel/softirq.c:441)
> </IRQ>
> <TASK>
>   __local_bh_enable_ip (kernel/softirq.c:381)
>   __dev_queue_xmit (net/core/dev.c:4374)
>   ip_finish_output2 (./include/net/neighbour.h:540 net/ipv4/ip_output.c:2=
35)
>   __ip_queue_xmit (net/ipv4/ip_output.c:535)
>   __tcp_transmit_skb (net/ipv4/tcp_output.c:1462)
>   tcp_rcv_synsent_state_process (net/ipv4/tcp_input.c:6469)
>   tcp_rcv_state_process (net/ipv4/tcp_input.c:6657)
>   tcp_v4_do_rcv (net/ipv4/tcp_ipv4.c:1929)
>   __release_sock (./include/net/sock.h:1121 net/core/sock.c:2968)
>   release_sock (net/core/sock.c:3536)
>   inet_wait_for_connect (net/ipv4/af_inet.c:609)
>   __inet_stream_connect (net/ipv4/af_inet.c:702)
>   inet_stream_connect (net/ipv4/af_inet.c:748)
>   __sys_connect (./include/linux/file.h:45 net/socket.c:2064)
>   __x64_sys_connect (net/socket.c:2073 net/socket.c:2070 net/socket.c:207=
0)
>   do_syscall_64 (arch/x86/entry/common.c:51 arch/x86/entry/common.c:82)
>   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129)
>   RIP: 0033:0x7fa10ff05a3d
>   Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89=
 f7 48 89 d6 48 89 ca 4d 89
>   c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d =
ab a3 0e 00 f7 d8 64 89 01 48
>   RSP: 002b:00007fa110183de8 EFLAGS: 00000202 ORIG_RAX: 000000000000002a
>   RAX: ffffffffffffffda RBX: 0000000020000054 RCX: 00007fa10ff05a3d
>   RDX: 000000000000001c RSI: 0000000020000040 RDI: 0000000000000003
>   RBP: 00007fa110183e20 R08: 0000000000000000 R09: 0000000000000000
>   R10: 0000000000000000 R11: 0000000000000202 R12: 00007fa110184640
>   R13: 0000000000000000 R14: 00007fa10fe8b060 R15: 00007fff73e23b20
> </TASK>
>=20
> The issue triggering process is analyzed as follows:
> Thread A                                       Thread B
> tcp_v4_rcv	//receive ack TCP packet       inet_shutdown
>   tcp_check_req                                  tcp_disconnect //disconn=
ect sock
>   ...                                              tcp_set_state(sk, TCP_=
CLOSE)
>     inet_csk_complete_hashdance                ...
>       inet_csk_reqsk_queue_add                 inet_listen  //start liste=
n
>         spin_lock(&queue->rskq_lock)             inet_csk_listen_start
>         ...                                        reqsk_queue_alloc
>         ...                                          spin_lock_init
>         spin_unlock(&queue->rskq_lock)	//warning
>=20
> When the socket receives the ACK packet during the three-way handshake,
> it will hold spinlock. And then the user actively shutdowns the socket
> and listens to the socket immediately, the spinlock will be initialized.
> When the socket is going to release the spinlock, a warning is generated.
> Also the same issue to fastopenq.lock.
>=20
> Add 'init_done' to make sure init the accept_queue's spinlocks once.
>=20
> Fixes: fff1f3001cc5 ("tcp: add a spinlock to protect struct request_sock_=
queue")
> Fixes: 168a8f58059a ("tcp: TCP Fast Open Server - main code path")
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> ---
> v2: Add 'init_done' to make sure init the accept_queue's spinlocks once.
> ---
>  include/net/request_sock.h | 1 +
>  net/core/request_sock.c    | 7 +++++--
>  net/ipv4/tcp.c             | 1 +
>  3 files changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/net/request_sock.h b/include/net/request_sock.h
> index 144c39db9898..0054746fe92d 100644
> --- a/include/net/request_sock.h
> +++ b/include/net/request_sock.h
> @@ -175,6 +175,7 @@ struct fastopen_queue {
>  struct request_sock_queue {
>  	spinlock_t		rskq_lock;
>  	u8			rskq_defer_accept;
> +	bool			init_done;
> =20
>  	u32			synflood_warned;
>  	atomic_t		qlen;
> diff --git a/net/core/request_sock.c b/net/core/request_sock.c
> index f35c2e998406..51fe631a4af2 100644
> --- a/net/core/request_sock.c
> +++ b/net/core/request_sock.c
> @@ -33,9 +33,12 @@
> =20
>  void reqsk_queue_alloc(struct request_sock_queue *queue)
>  {
> -	spin_lock_init(&queue->rskq_lock);
> +	if (!queue->init_done) {
> +		spin_lock_init(&queue->rskq_lock);
> +		spin_lock_init(&queue->fastopenq.lock);
> +		queue->init_done =3D true;
> +	}
> =20
> -	spin_lock_init(&queue->fastopenq.lock);
>  	queue->fastopenq.rskq_rst_head =3D NULL;
>  	queue->fastopenq.rskq_rst_tail =3D NULL;
>  	queue->fastopenq.qlen =3D 0;

I looks like the last bits of reqsk_queue_alloc() could still race with
a 3rd ack. Could the latter end-up touching a corrupted/unexpectedly
zeroed fastopenq?

Cheers,

Paolo


