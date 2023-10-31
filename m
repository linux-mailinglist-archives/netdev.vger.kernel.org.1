Return-Path: <netdev+bounces-45436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6547DCF5B
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 15:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B99F4B20F68
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 14:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2000E19450;
	Tue, 31 Oct 2023 14:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNZ6Xdqt"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF4D1DDCC
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 14:40:54 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45068DA
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 07:40:52 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9d267605ceeso418339866b.2
        for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 07:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698763251; x=1699368051; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lEH+4AEz+h7AhpdVGi2yLtqThDU2acsUlLm3D4qTdcQ=;
        b=VNZ6XdqtQYWMMvEZxcA0UCMZruiet2sC6qHAoAsfIdDxCMYb+wrVeFy19MCKVU4HI5
         U5ZfgNPj46H+D5QxEqYZ3UKdJpdNuPVVMMP6TJt2qku2SI+MqMADuPJK0HnREsC0r6OK
         cmUnowgb0ev/qI147z77OhYshxEBRgxsRBv7fiF6oqrf9CuQB4xsIkt8LtYQ5VT+rkH0
         wC8vUcNtJhsVx5/TYRtbaBtrNAdkYKWodVZ5eVMHdagMSxBffenHkrB40xrqkX5tCHPY
         8F+G0DTA+mcynZ6NZM/PMBIsUuevrDpeOa1Cull6yIW21P036sDG61fsEEI/4i8fAddP
         46/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698763251; x=1699368051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lEH+4AEz+h7AhpdVGi2yLtqThDU2acsUlLm3D4qTdcQ=;
        b=tfWdI9G1VJEP9yTOaehb6QpCvu3kTP/NkU6zGGZ5RxxcyvusSj4AZJ4CPylt4YYOqw
         hwUL3L4PXtIt84Q724tc9AzLfqVwFvc9jbJY4E5SiMBjsiDpZ42Y0kHk/iA5iElrMNjs
         1bguv/4b7u7c0IVITrdYVnIgXnNytPcZPNSoS2oyB849c2WjPOnsbtBO5SwFIY3IwIHD
         Z8Hk2+fdXOzVYGsHPs8cRamlcJIeiBxdNgRP3m/kiAEfiGv0nfbzjausp6JjFSPNuBzz
         8joe1QERf20kJvi2y28hnyku+wKz1jp/b6w55iSbwoZcOxxx4NtOKLSlho5czNtCCVbv
         UldQ==
X-Gm-Message-State: AOJu0Ywqe/KHW84GZWMuNIrV513wHeyem8V/VT1niCneVhgS2ZGC+hKP
	3rbNRPvXnq8awpKA+N+pB3A=
X-Google-Smtp-Source: AGHT+IFbFN+6vIT4audvmsaN8aOBM3HXOYClcyDXhBtgKuPnC/qwuMqufmgK8y/y1EkqGm342nylzQ==
X-Received: by 2002:a17:907:608a:b0:9ae:73ca:bbad with SMTP id ht10-20020a170907608a00b009ae73cabbadmr9842279ejc.43.1698763250250;
        Tue, 31 Oct 2023 07:40:50 -0700 (PDT)
Received: from localhost ([185.220.101.160])
        by smtp.gmail.com with ESMTPSA id fy23-20020a170906b7d700b009b2f2451381sm1073271ejb.182.2023.10.31.07.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 07:40:49 -0700 (PDT)
Date: Tue, 31 Oct 2023 16:40:44 +0200
From: Maxim Mikityanskiy <maxtram95@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH net] net: sched: fix warn on htb offloaded class creation
Message-ID: <ZUEQzsKiIlgtbN-S@mail.gmail.com>
References: <ff51f20f596b01c6d12633e984881be555660ede.1698334391.git.pabeni@redhat.com>
 <ZTvBoQHfu23ynWf-@mail.gmail.com>
 <131da9645be5ef6ea584da27ecde795c52dfbb00.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <131da9645be5ef6ea584da27ecde795c52dfbb00.camel@redhat.com>
X-Spam-Level: **

On Tue, 31 Oct 2023 at 10:11:14 +0100, Paolo Abeni wrote:
> Hi,
> 
> I'm sorry for the late reply.
> 
> On Fri, 2023-10-27 at 16:57 +0300, Maxim Mikityanskiy wrote:
> > I believe this is not the right fix.
> > 
> > On Thu, 26 Oct 2023 at 17:36:48 +0200, Paolo Abeni wrote:
> > > The following commands:
> > > 
> > > tc qdisc add dev eth1 handle 2: root htb offload
> > > tc class add dev eth1 parent 2: classid 2:1 htb rate 5mbit burst 15k
> > > 
> > > yeld to a WARN in the HTB qdisc:
> > 
> > Something is off here. These are literally the most basic commands one
> > could invoke with HTB offload, I'm sure they worked. Is it something
> > that broke recently? Tariq/Gal/Saeed, could you check them on a Mellanox
> > NIC?
> > 
> > > 
> > >  WARNING: CPU: 2 PID: 1583 at net/sched/sch_htb.c:1959
> > >  CPU: 2 PID: 1583 Comm: tc Kdump: loaded 6.6.0-rc2.mptcp_7895773e5235+ #59
> > >  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc37 04/01/2014
> > >  RIP: 0010:htb_change_class+0x25c4/0x2e30 [sch_htb]
> > >  Code: 24 58 48 b8 00 00 00 00 00 fc ff df 48 89 ca 48 c1 ea 03 80 3c 02 00 0f 85 92 01 00 00 49 89 8c 24 b0 01 00 00 e9 77 fc ff ff <0f> 0b e9 15 ec ff ff 80 3d f8 35 00 00 00 0f 85 d4 f9 ff ff ba 32
> > >  RSP: 0018:ffffc900015df240 EFLAGS: 00010246
> > >  RAX: 0000000000000000 RBX: ffff88811b4ca000 RCX: ffff88811db42800
> > >  RDX: 1ffff11023b68502 RSI: ffffffffaf2e6a00 RDI: ffff88811db42810
> > >  RBP: ffff88811db45000 R08: 0000000000000001 R09: fffffbfff664bbc9
> > >  R10: ffffffffb325de4f R11: ffffffffb2d33748 R12: 0000000000000000
> > >  R13: ffff88811db43000 R14: ffff88811b4caaac R15: ffff8881252c0030
> > >  FS:  00007f6c1f126740(0000) GS:ffff88815aa00000(0000) knlGS:0000000000000000
> > >  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > >  CR2: 000055dca8e5b4a8 CR3: 000000011bc7a006 CR4: 0000000000370ee0
> > >  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > >  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > >  Call Trace:
> > >  <TASK>
> > >   tc_ctl_tclass+0x394/0xeb0
> > >   rtnetlink_rcv_msg+0x2f5/0xaa0
> > >   netlink_rcv_skb+0x12e/0x3a0
> > >   netlink_unicast+0x421/0x730
> > >   netlink_sendmsg+0x79e/0xc60
> > >   ____sys_sendmsg+0x95a/0xc20
> > >   ___sys_sendmsg+0xee/0x170
> > >   __sys_sendmsg+0xc6/0x170
> > >  do_syscall_64+0x58/0x80
> > >  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> > > 
> > > The first command creates per TX queue pfifo qdiscs in
> > > tc_modify_qdisc() -> htb_init() and grafts the pfifo to each dev_queue
> > > via tc_modify_qdisc() ->  qdisc_graft() -> htb_attach().
> > 
> > Not exactly; it grafts pfifo to direct queues only. htb_attach_offload
> > explicitly grafts noop to all the remaining queues.
> 
> num_direct_qdiscs == real_num_tx_queues:
> 
> https://elixir.bootlin.com/linux/latest/source/net/sched/sch_htb.c#L1101
> 
> pfifo will be configured on all the TX queues available at TC creation
> time, right?

Yes, all real TX queues will be used as direct queues (for unclassified
traffic). num_tx_queues should be somewhat bigger than
real_num_tx_queues - it should reserve a queue per potential leaf class.

pfifo is configured on direct queues, and the reserved queues have noop.
Then, when a new leaf class is added (TC_HTB_LEAF_ALLOC_QUEUE), the
driver allocates a new queue and increases real_num_tx_queues. HTB
assigns a pfifo qdisc to the newly allocated queue.

Changing the hierarchy (deleting a node or converting an inner node to a
leaf) may reorder the classful queues (with indexes >= the initial
real_num_tx_queues), so that there are no gaps.

> Lacking a mlx card with offload support I hack basic htb support in
> netdevsim and I observe the splat on top of such device. I can as well
> share the netdevsim patch - it will need some clean-up.

I will be happy to review the netdevsim patch, but I don't promise
prompt responsiveness.

> > 
> > > When the command completes, the qdisc_sleeping for each dev_queue is a
> > > pfifo one. The next class creation will trigger the reported splat.
> > > 
> > > Address the issue taking care of old non-builtin qdisc in
> > > htb_change_class().
> > > 
> > > Fixes: d03b195b5aa0 ("sch_htb: Hierarchical QoS hardware offload")
> > > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > > ---
> > >  net/sched/sch_htb.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > 
> > > diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
> > > index 0d947414e616..dc682bd542b4 100644
> > > --- a/net/sched/sch_htb.c
> > > +++ b/net/sched/sch_htb.c
> > > @@ -1955,8 +1955,7 @@ static int htb_change_class(struct Qdisc *sch, u32 classid,
> > >  				qdisc_refcount_inc(new_q);
> > >  			}
> > >  			old_q = htb_graft_helper(dev_queue, new_q);
> > > -			/* No qdisc_put needed. */
> > > -			WARN_ON(!(old_q->flags & TCQ_F_BUILTIN));
> > > +			qdisc_put(old_q);
> > 
> > We can get here after one of two cases above:
> > 
> > 1. A new queue is allocated with TC_HTB_LEAF_ALLOC_QUEUE. It's supposed
> > to have a noop qdisc by default (after htb_attach_offload).
> 
> So most likely the trivial netdevsim implementation I used was not good
> enough.
> 
> Which constrains should respect TC_HTB_LEAF_ALLOC_QUEUE WRT the
> returned qid value? should it in the (real_num_tx_queues,
> num_tx_queues] range?

Let's say N is real_num_tx_queues as it was at the moment of attaching.
HTB queues should be allocated from [N, num_tx_queues), and
real_num_tx_queues should be increased accordingly. It should not return
queues number [0, N).

Deletions should fill the gaps: if queue X is being deleted, N <= X <
real_num_tx_queues - 1, then the gap should be filled with queue number
real_num_tx_queues - 1 by swapping the queues (real_num_tx_queues will
be decreased by 1 accordingly). Some care also needs to be taken when
converting inner-to-leaf (TC_HTB_LEAF_DEL_LAST) and leaf-to-inner (it's
better to get insights from [1], there are also some comments).

> Can HTB actually configure H/W shaping on
> real_num_tx_queues?

It will be on real_num_tx_queues, but after it's increased to add new
HTB queues. The original queues [0, N) are used for direct traffic, same
as the non-offloaded HTB's direct_queue (it's not shaped).

> I find no clear documentation WRT the above.

I'm sorry for the lack of documentation. All I have is the commit
message [2] and a netdev talk [3]. Maybe the slides could be of some
use...

I hope the above explanation clarifies something, and feel free to ask
further questions, I'll be glad to explain what hasn't been documented
properly.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/mellanox/mlx5/core/en/htb.c?id=5a6a09e97199d6600d31383055f9d43fbbcbe86f
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d03b195b5aa015f6c11988b86a3625f8d5dbac52
[3]: https://netdevconf.info/0x14/session.html?talk-hierarchical-QoS-hardware-offload

> Thanks!
> 
> Paolo
> 

