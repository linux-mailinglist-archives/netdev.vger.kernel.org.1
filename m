Return-Path: <netdev+bounces-45386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 079EF7DC92A
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 10:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 288DB1C20BA7
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 09:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D16134C2;
	Tue, 31 Oct 2023 09:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="APkLOveo"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE63134B3
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 09:11:25 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD83C1
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 02:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698743479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DuGikEkfltFMdgsAJ8jY84VlCvsNPDZp/v+6NfZt8h0=;
	b=APkLOveoO8aMbB9g98EE/6OdGBpDvzNQgHXHtTipff7qoQcJMUIsarVxk0QJOgHcNGFRqL
	EqQMhgw4UgpNW1kG3LoiEW8+RZstuEP8Cs5ccmPlx0Pxezn5SUXVR08q/uJ1+EUsubngJM
	q2OPD2j08sF6sG65lUU/QG/E1WUCyt0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-Ty5tP9d-OwWjlEdB4h82Jw-1; Tue, 31 Oct 2023 05:11:18 -0400
X-MC-Unique: Ty5tP9d-OwWjlEdB4h82Jw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-32f7b52caf2so269760f8f.1
        for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 02:11:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698743477; x=1699348277;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DuGikEkfltFMdgsAJ8jY84VlCvsNPDZp/v+6NfZt8h0=;
        b=AcZzia6F9dJkNuHgsvVSnT8YvUp0Hd2k+TMt3xiWPnRER5SN4Ul5uyzd2f/PXRAo5r
         4FBGMBsa/dLs2anhWC6ifhu0trzLXvq2vm/mJR5ESB48LBMu5a8bjt+9p0op3EzG3z4A
         wnqOPu5tsHWpxp9ZXTwvbtzTqXP0ndY7DaG5Jw3eiCfrNQs4TfagVVqQ9ajJ3PaNn/kW
         hRiW+4tUfjOZucEP4kPT2Cj74Oi1RrgPDDpaYG+AF7VCgcNRzO0edonSIbmkJtixDzbD
         +3ZAfMw1LaeTEjzdOi1EieaLiQDlogrfleydgQYoA90TwpfCxKvL7RnHqvpRtlCTlybC
         DCPg==
X-Gm-Message-State: AOJu0YwZ98cb6qzTZKdTeLHdcf+LdJs9vlkYSidC/ylzVonTDtQlE/Fq
	efUp6ptasZX6h6rnNMTLCwrLCEjSfDSYS1bsKoslNCrOaXZfllC9xyInc/zt6Xx90cY7PgpbjFE
	mglVw183LEuM5jhTF
X-Received: by 2002:a5d:598f:0:b0:32d:d932:5848 with SMTP id n15-20020a5d598f000000b0032dd9325848mr9939417wri.2.1698743476777;
        Tue, 31 Oct 2023 02:11:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGucAxvmcpWNem37easpghDPo97H4g5C9unnEYJ4zG2yp34R8sbard0OhSh+LJpVtuDHj3raQ==
X-Received: by 2002:a5d:598f:0:b0:32d:d932:5848 with SMTP id n15-20020a5d598f000000b0032dd9325848mr9939400wri.2.1698743476397;
        Tue, 31 Oct 2023 02:11:16 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-227-179.dyn.eolo.it. [146.241.227.179])
        by smtp.gmail.com with ESMTPSA id z10-20020adff74a000000b0032f78feb826sm987360wrp.104.2023.10.31.02.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 02:11:16 -0700 (PDT)
Message-ID: <131da9645be5ef6ea584da27ecde795c52dfbb00.camel@redhat.com>
Subject: Re: [PATCH net] net: sched: fix warn on htb offloaded class creation
From: Paolo Abeni <pabeni@redhat.com>
To: Maxim Mikityanskiy <maxtram95@gmail.com>
Cc: netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Gal Pressman
 <gal@nvidia.com>,  Saeed Mahameed <saeedm@nvidia.com>
Date: Tue, 31 Oct 2023 10:11:14 +0100
In-Reply-To: <ZTvBoQHfu23ynWf-@mail.gmail.com>
References: 
	<ff51f20f596b01c6d12633e984881be555660ede.1698334391.git.pabeni@redhat.com>
	 <ZTvBoQHfu23ynWf-@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

I'm sorry for the late reply.

On Fri, 2023-10-27 at 16:57 +0300, Maxim Mikityanskiy wrote:
> I believe this is not the right fix.
>=20
> On Thu, 26 Oct 2023 at 17:36:48 +0200, Paolo Abeni wrote:
> > The following commands:
> >=20
> > tc qdisc add dev eth1 handle 2: root htb offload
> > tc class add dev eth1 parent 2: classid 2:1 htb rate 5mbit burst 15k
> >=20
> > yeld to a WARN in the HTB qdisc:
>=20
> Something is off here. These are literally the most basic commands one
> could invoke with HTB offload, I'm sure they worked. Is it something
> that broke recently? Tariq/Gal/Saeed, could you check them on a Mellanox
> NIC?
>=20
> >=20
> >  WARNING: CPU: 2 PID: 1583 at net/sched/sch_htb.c:1959
> >  CPU: 2 PID: 1583 Comm: tc Kdump: loaded 6.6.0-rc2.mptcp_7895773e5235+ =
#59
> >  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc37=
 04/01/2014
> >  RIP: 0010:htb_change_class+0x25c4/0x2e30 [sch_htb]
> >  Code: 24 58 48 b8 00 00 00 00 00 fc ff df 48 89 ca 48 c1 ea 03 80 3c 0=
2 00 0f 85 92 01 00 00 49 89 8c 24 b0 01 00 00 e9 77 fc ff ff <0f> 0b e9 15=
 ec ff ff 80 3d f8 35 00 00 00 0f 85 d4 f9 ff ff ba 32
> >  RSP: 0018:ffffc900015df240 EFLAGS: 00010246
> >  RAX: 0000000000000000 RBX: ffff88811b4ca000 RCX: ffff88811db42800
> >  RDX: 1ffff11023b68502 RSI: ffffffffaf2e6a00 RDI: ffff88811db42810
> >  RBP: ffff88811db45000 R08: 0000000000000001 R09: fffffbfff664bbc9
> >  R10: ffffffffb325de4f R11: ffffffffb2d33748 R12: 0000000000000000
> >  R13: ffff88811db43000 R14: ffff88811b4caaac R15: ffff8881252c0030
> >  FS:  00007f6c1f126740(0000) GS:ffff88815aa00000(0000) knlGS:0000000000=
000000
> >  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >  CR2: 000055dca8e5b4a8 CR3: 000000011bc7a006 CR4: 0000000000370ee0
> >  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >  Call Trace:
> >  <TASK>
> >   tc_ctl_tclass+0x394/0xeb0
> >   rtnetlink_rcv_msg+0x2f5/0xaa0
> >   netlink_rcv_skb+0x12e/0x3a0
> >   netlink_unicast+0x421/0x730
> >   netlink_sendmsg+0x79e/0xc60
> >   ____sys_sendmsg+0x95a/0xc20
> >   ___sys_sendmsg+0xee/0x170
> >   __sys_sendmsg+0xc6/0x170
> >  do_syscall_64+0x58/0x80
> >  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> >=20
> > The first command creates per TX queue pfifo qdiscs in
> > tc_modify_qdisc() -> htb_init() and grafts the pfifo to each dev_queue
> > via tc_modify_qdisc() ->  qdisc_graft() -> htb_attach().
>=20
> Not exactly; it grafts pfifo to direct queues only. htb_attach_offload
> explicitly grafts noop to all the remaining queues.

num_direct_qdiscs =3D=3D real_num_tx_queues:

https://elixir.bootlin.com/linux/latest/source/net/sched/sch_htb.c#L1101

pfifo will be configured on all the TX queues available at TC creation
time, right?

Lacking a mlx card with offload support I hack basic htb support in
netdevsim and I observe the splat on top of such device. I can as well
share the netdevsim patch - it will need some clean-up.
>=20
> > When the command completes, the qdisc_sleeping for each dev_queue is a
> > pfifo one. The next class creation will trigger the reported splat.
> >=20
> > Address the issue taking care of old non-builtin qdisc in
> > htb_change_class().
> >=20
> > Fixes: d03b195b5aa0 ("sch_htb: Hierarchical QoS hardware offload")
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> >  net/sched/sch_htb.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >=20
> > diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
> > index 0d947414e616..dc682bd542b4 100644
> > --- a/net/sched/sch_htb.c
> > +++ b/net/sched/sch_htb.c
> > @@ -1955,8 +1955,7 @@ static int htb_change_class(struct Qdisc *sch, u3=
2 classid,
> >  				qdisc_refcount_inc(new_q);
> >  			}
> >  			old_q =3D htb_graft_helper(dev_queue, new_q);
> > -			/* No qdisc_put needed. */
> > -			WARN_ON(!(old_q->flags & TCQ_F_BUILTIN));
> > +			qdisc_put(old_q);
>=20
> We can get here after one of two cases above:
>=20
> 1. A new queue is allocated with TC_HTB_LEAF_ALLOC_QUEUE. It's supposed
> to have a noop qdisc by default (after htb_attach_offload).

So most likely the trivial netdevsim implementation I used was not good
enough.

Which constrains should respect TC_HTB_LEAF_ALLOC_QUEUE WRT the
returned qid value? should it in the (real_num_tx_queues,
num_tx_queues] range? Can HTB actually configure H/W shaping on
real_num_tx_queues?

I find no clear documentation WRT the above.

Thanks!

Paolo


