Return-Path: <netdev+bounces-44771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BD87D9A8E
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 15:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69E041C20F7F
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 13:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35478358A3;
	Fri, 27 Oct 2023 13:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmoRo7kf"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3C818AE4
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 13:58:03 +0000 (UTC)
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884779D
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 06:58:01 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id a1e0cc1a2514c-7ba0d338367so77049241.2
        for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 06:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698415080; x=1699019880; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3SmNzfE80j9lJmwk1LsQAeVJjZnjh0OJLvTGLS04UjA=;
        b=jmoRo7kfsnl/0M4MO8W9KXucK1H4PaHLg7AIKGfXMr6fcHhJhxJNCI/g5pKrFRGp5D
         rVSF0TP8xoxyIv6pqW7VmfWEwE//9HphLWzHHvp8V6Z4Gmf4Oj4jT32N4trfvYKxUA8F
         aXngNFh0cKxtrvUzH8X5YZB+fU4qk0fK7/3jca2FLEJIYZ/MkKYo2xJ0nyOzgiKuIUyC
         lIojrJGOeYOR8+6QyrXnO4T/vAMNGRJGx8227l6mEoboXrRQ/3TiqxmB+eWeRb0mmco+
         wp/iHG4TOBJ8g6BUwH9PiZJ4S9IAK6fn96PbHhiybok3/XgQKPcOLJk12fnqtMNNhqdz
         7iKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698415080; x=1699019880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3SmNzfE80j9lJmwk1LsQAeVJjZnjh0OJLvTGLS04UjA=;
        b=c9+9mFOaCbsObjNJQgFljgOTLFhculZwhMdX1uEBgtWkLKMn8QHyHj2FSWylMdVi0H
         7kjuh87XvcS+XI31t8KWfmG2L29cUHuRsfiQ08kWKq/PKD/1dze0bNjEKfK9mtWzhm4q
         wMI7l87vZzJeszleq9PwOXu3xZTdBkEBy4tmKyyyA98pN7K72ydnQapWMf4X4IibVCSb
         N9LK15qav578iAwnjnYA05AQgwcJeaZO1LjMHLGwrJvX+QjbBXXjNw2FShFNSKRD7kUq
         HMx0u2Du7wAJTmC6ra1bQ6lLTrlvMhem0JTMlUHPNu2c4ZYIx1SDw7rZQzNabmEzZP1I
         1U4g==
X-Gm-Message-State: AOJu0YxjiMYssXgn2dZ3QHbRYiTbQ2XH5dpTnrbR7jibU4XtuQOkhZTJ
	llQqpKfSaCT/R/KO+e70OOc=
X-Google-Smtp-Source: AGHT+IFdGoRqmWnOaVhbECbLWBfZVMuV2tRNu3FrBZxlb5KQXs6l16YcltbE5weg4vOyGE/vvpeqlQ==
X-Received: by 2002:a67:c31b:0:b0:45b:ecd:98c4 with SMTP id r27-20020a67c31b000000b0045b0ecd98c4mr2846327vsj.16.1698415080444;
        Fri, 27 Oct 2023 06:58:00 -0700 (PDT)
Received: from localhost ([104.192.3.74])
        by smtp.gmail.com with ESMTPSA id f14-20020a0cc30e000000b0065b5306565esm616806qvi.112.2023.10.27.06.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 06:57:59 -0700 (PDT)
Date: Fri, 27 Oct 2023 16:57:55 +0300
From: Maxim Mikityanskiy <maxtram95@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH net] net: sched: fix warn on htb offloaded class creation
Message-ID: <ZTvBoQHfu23ynWf-@mail.gmail.com>
References: <ff51f20f596b01c6d12633e984881be555660ede.1698334391.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff51f20f596b01c6d12633e984881be555660ede.1698334391.git.pabeni@redhat.com>
X-Spam-Level: **

I believe this is not the right fix.

On Thu, 26 Oct 2023 at 17:36:48 +0200, Paolo Abeni wrote:
> The following commands:
> 
> tc qdisc add dev eth1 handle 2: root htb offload
> tc class add dev eth1 parent 2: classid 2:1 htb rate 5mbit burst 15k
> 
> yeld to a WARN in the HTB qdisc:

Something is off here. These are literally the most basic commands one
could invoke with HTB offload, I'm sure they worked. Is it something
that broke recently? Tariq/Gal/Saeed, could you check them on a Mellanox
NIC?

> 
>  WARNING: CPU: 2 PID: 1583 at net/sched/sch_htb.c:1959
>  CPU: 2 PID: 1583 Comm: tc Kdump: loaded 6.6.0-rc2.mptcp_7895773e5235+ #59
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc37 04/01/2014
>  RIP: 0010:htb_change_class+0x25c4/0x2e30 [sch_htb]
>  Code: 24 58 48 b8 00 00 00 00 00 fc ff df 48 89 ca 48 c1 ea 03 80 3c 02 00 0f 85 92 01 00 00 49 89 8c 24 b0 01 00 00 e9 77 fc ff ff <0f> 0b e9 15 ec ff ff 80 3d f8 35 00 00 00 0f 85 d4 f9 ff ff ba 32
>  RSP: 0018:ffffc900015df240 EFLAGS: 00010246
>  RAX: 0000000000000000 RBX: ffff88811b4ca000 RCX: ffff88811db42800
>  RDX: 1ffff11023b68502 RSI: ffffffffaf2e6a00 RDI: ffff88811db42810
>  RBP: ffff88811db45000 R08: 0000000000000001 R09: fffffbfff664bbc9
>  R10: ffffffffb325de4f R11: ffffffffb2d33748 R12: 0000000000000000
>  R13: ffff88811db43000 R14: ffff88811b4caaac R15: ffff8881252c0030
>  FS:  00007f6c1f126740(0000) GS:ffff88815aa00000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 000055dca8e5b4a8 CR3: 000000011bc7a006 CR4: 0000000000370ee0
>  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>  Call Trace:
>  <TASK>
>   tc_ctl_tclass+0x394/0xeb0
>   rtnetlink_rcv_msg+0x2f5/0xaa0
>   netlink_rcv_skb+0x12e/0x3a0
>   netlink_unicast+0x421/0x730
>   netlink_sendmsg+0x79e/0xc60
>   ____sys_sendmsg+0x95a/0xc20
>   ___sys_sendmsg+0xee/0x170
>   __sys_sendmsg+0xc6/0x170
>  do_syscall_64+0x58/0x80
>  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> 
> The first command creates per TX queue pfifo qdiscs in
> tc_modify_qdisc() -> htb_init() and grafts the pfifo to each dev_queue
> via tc_modify_qdisc() ->  qdisc_graft() -> htb_attach().

Not exactly; it grafts pfifo to direct queues only. htb_attach_offload
explicitly grafts noop to all the remaining queues.

> When the command completes, the qdisc_sleeping for each dev_queue is a
> pfifo one. The next class creation will trigger the reported splat.
> 
> Address the issue taking care of old non-builtin qdisc in
> htb_change_class().
> 
> Fixes: d03b195b5aa0 ("sch_htb: Hierarchical QoS hardware offload")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  net/sched/sch_htb.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
> index 0d947414e616..dc682bd542b4 100644
> --- a/net/sched/sch_htb.c
> +++ b/net/sched/sch_htb.c
> @@ -1955,8 +1955,7 @@ static int htb_change_class(struct Qdisc *sch, u32 classid,
>  				qdisc_refcount_inc(new_q);
>  			}
>  			old_q = htb_graft_helper(dev_queue, new_q);
> -			/* No qdisc_put needed. */
> -			WARN_ON(!(old_q->flags & TCQ_F_BUILTIN));
> +			qdisc_put(old_q);

We can get here after one of two cases above:

1. A new queue is allocated with TC_HTB_LEAF_ALLOC_QUEUE. It's supposed
to have a noop qdisc by default (after htb_attach_offload).

2. An existing leaf is converted to an inner node with
TC_HTB_LEAF_TO_INNER, its queue is reused. htb_graft_helper(dev_queue,
NULL) makes sure that the qdisc is noop, not pfifo anymore.

This WARN_ON is here for a reason. If it triggered, it indicates a bug
somewhere else, because we don't expect anything but noop_qdisc after
the `if` above. Silencing the warning doesn't fix the bug and may lead
to damaging the consistency of the data structures.

>  		}
>  		sch_tree_lock(sch);
>  		if (parent && !parent->level) {
> -- 
> 2.41.0
> 

