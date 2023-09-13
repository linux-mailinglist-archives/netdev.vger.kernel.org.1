Return-Path: <netdev+bounces-33445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6054A79DFFD
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 08:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A6691C20B1D
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 06:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BE316438;
	Wed, 13 Sep 2023 06:28:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD3515AE0
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 06:28:19 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D958172E
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 23:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694586498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mm/plAWXqfBz3sg3bj2QdcbICP3BeMmgTHqd03bTES8=;
	b=OwW6Upa7DqS5MNLZv2CqSCOBjS2jwjiRsp0nRCOsi09Qk/VNRYG06o4jAxaz6CypUUQ9lg
	V1SiNY1WVMi8V8azrfTulVVYI0uQMTIhlEVOd9sASl93+ey+Fs+UqVNF12PLP31os/g94I
	QYVPqXgMBYxf44R/NidSoCr2DT2WaQ0=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-z947US6gM-We5RIoDzXvAA-1; Wed, 13 Sep 2023 02:28:17 -0400
X-MC-Unique: z947US6gM-We5RIoDzXvAA-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2be48142a6cso14539081fa.1
        for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 23:28:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694586496; x=1695191296;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mm/plAWXqfBz3sg3bj2QdcbICP3BeMmgTHqd03bTES8=;
        b=l2nb1S6uRvldxl0ljKfaE29TWXaV5nDcX6SQ3bgArQ9gNl8UfdnGlhdrmUxYEIJtsw
         JqcDhDTZfYKBFAWWnnBPYTL+T/GHeRP5sB0D8XZgDGacbAjJRkH1aovT1zlEtbpFDRYV
         Nil52JIqFtDoW9QGINOzV6786srne/QXQB7AS5AsbY2+fAqmTIFxWabKYEc4JklJ8NTf
         9nS8jcxKopsd+S90ev3ouoYTlpjITwt6gQB80iI3wohpoHDe70O/9r1lqfHY0OnfaaOp
         E3HvahfS8T2Yo0eYMVoKPfDVKvyy1GuQRkMIRcAMkmBk++s2eu3U6hVWVmdgElVbSmEn
         YgmQ==
X-Gm-Message-State: AOJu0YxIFt55SX7HdKIgKzrjFmpJ56VxIzy0QDkAA0Gav+5lIn4Anjnq
	gQMt3lX+kXT7FzL0mJYSiFJdrTUREzM93L5tlhF/F9ORzI6cZDm9Pl0/We9jnO8mLNVXyDS8oYh
	5U+M/WbZZDE3/4mPQ
X-Received: by 2002:a2e:b5cc:0:b0:2bb:7710:1cea with SMTP id g12-20020a2eb5cc000000b002bb77101ceamr1173757ljn.0.1694586495793;
        Tue, 12 Sep 2023 23:28:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgSLZtrx5XK8KF4yIzCYd7g5m65fc35oV1uWbbU5gRuRbiyXJ2kuNa3b1WC6s4HLi3HKtGtw==
X-Received: by 2002:a2e:b5cc:0:b0:2bb:7710:1cea with SMTP id g12-20020a2eb5cc000000b002bb77101ceamr1173746ljn.0.1694586495367;
        Tue, 12 Sep 2023 23:28:15 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-245-169.dyn.eolo.it. [146.241.245.169])
        by smtp.gmail.com with ESMTPSA id cm21-20020a170907939500b009ad87fd4e65sm2007143ejc.108.2023.09.12.23.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 23:28:15 -0700 (PDT)
Message-ID: <06082c443dbaf83495dde16c33884adc30872ec8.camel@redhat.com>
Subject: Re: [PATCH net v4] team: fix null-ptr-deref when team device type
 is changed
From: Paolo Abeni <pabeni@redhat.com>
To: "Ziyang Xuan (William)" <william.xuanziyang@huawei.com>,
 jiri@resnulli.us,  davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, netdev@vger.kernel.org,  leon@kernel.org,
 ye.xingchen@zte.com.cn, liuhangbin@gmail.com
Date: Wed, 13 Sep 2023 08:28:13 +0200
In-Reply-To: <2cad19f1-552b-792f-f074-daadd8753a59@huawei.com>
References: <20230911094636.3256542-1-william.xuanziyang@huawei.com>
	 <2910908aeafc8ff133168045ee19f290a7bb35e0.camel@redhat.com>
	 <2cad19f1-552b-792f-f074-daadd8753a59@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-09-13 at 14:15 +0800, Ziyang Xuan (William) wrote:
> > > diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
> > > index d3dc22509ea5..12fb5f4cff06 100644
> > > --- a/drivers/net/team/team.c
> > > +++ b/drivers/net/team/team.c
> > > @@ -2127,7 +2127,10 @@ static const struct ethtool_ops
> > > team_ethtool_ops =3D {
> > > =C2=A0static void team_setup_by_port(struct net_device *dev,
> > > =C2=A0			       struct net_device *port_dev)
> > > =C2=A0{
> > > -	dev->header_ops	=3D port_dev->header_ops;
> > > +	if (port_dev->type =3D=3D ARPHRD_ETHER)
> > > +		dev->header_ops	=3D &eth_header_ops;
> > > +	else
> > > +		dev->header_ops	=3D port_dev->header_ops;
> > > =C2=A0	dev->type =3D port_dev->type;
> > > =C2=A0	dev->hard_header_len =3D port_dev->hard_header_len;
> > > =C2=A0	dev->needed_headroom =3D port_dev->needed_headroom;
> >=20
> > If I read correctly, for !vlan_hw_offload_capable() lower dev,
> > egress
> > packets going trough the team device will not contain the vlan tag.
> >=20
> > Additionally, why is vlan special? Why others lower devices with
> > custom
> > header_ops do not need any care?=20
>=20
> We have also got ipvlan device problem as following:
>=20
> BUG: KASAN: slab-out-of-bounds in ipvlan_hard_header+0xd1/0xe0
> Read of size 8 at addr ffff888018ee1de8 by task syz-executor.1/3469
> ...
> Call Trace:
> =C2=A0<IRQ>
> =C2=A0dump_stack+0xbe/0xfd
> =C2=A0print_address_description.constprop.0+0x19/0x170
> =C2=A0? ipvlan_hard_header+0xd1/0xe0
> =C2=A0__kasan_report.cold+0x6c/0x84
> =C2=A0? ipvlan_hard_header+0xd1/0xe0
> =C2=A0kasan_report+0x3a/0x50
> =C2=A0ipvlan_hard_header+0xd1/0xe0
> =C2=A0? ipvlan_get_iflink+0x40/0x40
> =C2=A0neigh_resolve_output+0x28f/0x410
> =C2=A0ip6_finish_output2+0x762/0xef0
> =C2=A0? ip6_frag_init+0xf0/0xf0
> =C2=A0? nf_nat_icmpv6_reply_translation+0x460/0x460
> =C2=A0? do_add_counters+0x370/0x370
> =C2=A0? do_add_counters+0x370/0x370
> =C2=A0? ipv6_confirm+0x1ee/0x360
> =C2=A0? nf_ct_bridge_unregister+0x50/0x50
> =C2=A0__ip6_finish_output.part.0+0x1a8/0x400
> =C2=A0ip6_finish_output+0x1a9/0x1e0
> =C2=A0ip6_output+0x146/0x2b0
> =C2=A0? ip6_finish_output+0x1e0/0x1e0
> =C2=A0? __ip6_finish_output+0xb0/0xb0
> =C2=A0? __sanitizer_cov_trace_switch+0x50/0x90
> =C2=A0? nf_hook_slow+0xa3/0x150
> =C2=A0mld_sendpack+0x3d9/0x670
> =C2=A0? mca_alloc+0x210/0x210
> =C2=A0? add_grhead+0xf5/0x140
> =C2=A0? ipv6_icmp_sysctl_init+0xd0/0xd0
> =C2=A0? add_grec+0x4e1/0xa90
> =C2=A0? _raw_spin_lock_bh+0x85/0xe0
> =C2=A0? _raw_read_unlock_irqrestore+0x30/0x30
> =C2=A0mld_send_cr+0x426/0x630
> =C2=A0? migrate_swap_stop+0x400/0x400
> =C2=A0mld_ifc_timer_expire+0x22/0x240
> =C2=A0? ipv6_mc_netdev_event+0x80/0x80
> =C2=A0call_timer_fn+0x3d/0x230
> =C2=A0? ipv6_mc_netdev_event+0x80/0x80
> =C2=A0expire_timers+0x190/0x270
> =C2=A0run_timer_softirq+0x22c/0x560
>=20
> ipvlan problem is slightly different from vlan.
>=20
> // add ipvlan to team device
> team_port_add
> =C2=A0=C2=A0team_dev_type_check_change
> =C2=A0=C2=A0=C2=A0=C2=A0team_setup_by_port // assign ipvlan_header_ops to=
 team_dev-
> >header_ops=09
> =C2=A0=C2=A0netdev_rx_handler_register // fail out without restore team_d=
ev-
> >header_ops
>=20
> // add other ether type device to team device
> team_port_add
> =C2=A0=C2=A0team_dev_type_check_change // return directly because port_de=
v-
> >type and team_dev->type are same
>=20
> team_dev->head_ops has be assigned to ipvlan_header_ops. That will
> trigger excption.

To me both cases look the same in the end: the team driver sets and use
header_ops of a different device that will assume dev_priv() being a
different struct.

I'm guessing a generic solution could be implementing 'trampoline'
header_ops that just call into the lower port corresponding op, and
assigning such ops to the team device every time the lower has non
ethernet header_ops.

team_dev_type_check_change() should then probably check both dev->type
and dev->header_ops.

> > Exporting 'eth_header_ops' for team's sake only looks a bit too
> > much to
> > me. I think could instead cache the header_ops ptr after the
> > initial
> > ether_setup().
>=20
> Is it possible to use ether_setup() like bonding driver andmodify MTU
> individually later?

That could be another option to get the eth_header_ops.

Note that in the end both are quite similar, you will have to cache
some info (the mtu with the latter); ether_setup() possibly will have
more side effects, as it touches many fields. I personally would use
the thing I suggested above.

Cheers,

Paolo


