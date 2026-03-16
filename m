Return-Path: <netdev+bounces-268096-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMMqJ//Zt2mcWAEAu9opvQ
	(envelope-from <netdev+bounces-268096-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 11:22:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F4B297D6D
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 11:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2FB233022D35
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 10:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FD338D69E;
	Mon, 16 Mar 2026 10:18:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw2.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68D31E520A
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 10:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773656305; cv=none; b=gMXV+WpVcpJFWatVGUKEEeVVtNwt/lWZ0zykg7TkMeH3SXxxV7Kp15oQsIU3x6K8DWaSvesN0HDesppp0tW0PESVGcoO9M2xiNVUrJZm0g8guyR7FRo11wISm3dzsUoJEnbwF0gvs/Mi0LxclWzchZg2SQZhsS5U8en3xYoo5s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773656305; c=relaxed/simple;
	bh=1HjdbNbfcmSXQnz9z8qFvZA/wH0eYWpTbEZsCCL/LtI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ucm3NnXyxnvNcahdSbyOJ+04adgN/c5loafA80azGkFrX43gI3qli6xuwUuibt0k5vwocX2FhqjA+JLt6KxZwP1ftTAy2cMXmBdkRNlJ0XQ5PPpXGLSkZsLbP7ICwXVBJWWLoQ37qHBWZNXteDjBk7+J8Hn4kBSgb9iMeAA+HFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
	by mailgw2.hygon.cn (Postfix) with ESMTP id 4fZ9yj2Khsz1YHN2d;
	Mon, 16 Mar 2026 18:18:05 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
	by mailgw2.hygon.cn (Postfix) with ESMTP id 4fZ9yh2TpQz1YHN2d;
	Mon, 16 Mar 2026 18:18:04 +0800 (CST)
Received: from cncheex06.Hygon.cn (unknown [172.23.18.116])
	by maildlp1.hygon.cn (Postfix) with ESMTPS id B97B3596C;
	Mon, 16 Mar 2026 18:18:01 +0800 (CST)
Received: from cncheex04.Hygon.cn (172.23.18.114) by cncheex06.Hygon.cn
 (172.23.18.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 16 Mar
 2026 18:18:05 +0800
Received: from cncheex04.Hygon.cn ([fe80::1b6f:6c58:58a4:430d]) by
 cncheex04.Hygon.cn ([fe80::1b6f:6c58:58a4:430d%10]) with mapi id
 15.02.1544.036; Mon, 16 Mar 2026 18:18:05 +0800
From: Zhud <zhud@hygon.cn>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>, "eperezma@redhat.com" <eperezma@redhat.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"willemb@google.com" <willemb@google.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, Jing Li <lijing@hygon.cn>, Zhiwei Ying
	<yingzhiwei@hygon.cn>
Subject: RE: [PATCH net-next v2] virtio-net: enable NETIF_F_GRO_HW only if
 GRO-related offloads are supported
Thread-Topic: [PATCH net-next v2] virtio-net: enable NETIF_F_GRO_HW only if
 GRO-related offloads are supported
Thread-Index: AQHctRWZ2ojSo6zfekKUjfvJ+iW5wbWwWqSAgACMBDA=
Date: Mon, 16 Mar 2026 10:18:04 +0000
Message-ID: <607818aba89a44d88afa213f39611451@hygon.cn>
References: <20260316072152.910857-1-zhud@hygon.cn>
 <20260316051327-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260316051327-mutt-send-email-mst@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[hygon.cn : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-268096-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhud@hygon.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.848];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 92F4B297D6D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Thanks! Yes something to improve:
>=20
> On Mon, Mar 16, 2026 at 03:21:52PM +0800, Di Zhu wrote:
> > Although VIRTIO_NET_F_CTRL_GUEST_OFFLOADS is negotiated, which
> > indicates the device supports dynamic control of guest offloads, it
> > does not necessarily mean the device supports specific hardware GRO fea=
tures.
> >
> > If none of the features defined in GUEST_OFFLOAD_GRO_HW_MASK (such as
> > TSO4, TSO6, or UFO) are present in vi->guest_offloads_capable, the
> > device effectively lacks the hardware capability to perform GRO.
>=20
> So what is the user-visible problem this is trying to address?

A key concern is that once a user enables NETIF_F_GRO_HW via ethtool,=20
they might manually disable software GRO (ethtool -K eth0 gro off) assuming=
 the=20
hardware is now handling the aggregation.

Secondly, while we haven't encountered a specific hardware failure yet,=20
enabling a hardware offload feature that the DPU does not physically suppor=
t=20
introduces the risk of undefined hardware behavior

> >
> > So, making NETIF_F_GRO_HW conditional on these feature bits ensures
> > the stack does not enable an unsupported hardware offload configuration=
.
>=20
> I guess the assumption is that without this, something enables such a con=
fig? Which
> stack is this and what happens then?
>=20

Sorry for the confusion, let me clarify the intent.
The 'stack' here refers to the ethtool interface and the netset (ioctl/netl=
ink) path.=20

>=20
> > Fixes: a02e8964eaf9 ("virtio-net: ethtool configurable LRO")
> > Signed-off-by: Di Zhu <zhud@hygon.cn>
>=20
> judging by this, has something to do with LRO?
>=20
> > ---
> > /* v2 */
> >   -make the modified logic clearer
> > ---
> >  drivers/net/virtio_net.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c index
> > 72d6a9c6a5a2..b233c99925e9 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -6781,8 +6781,6 @@ static int virtnet_probe(struct virtio_device *vd=
ev)
> >  	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
> >  	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6))
> >  		dev->features |=3D NETIF_F_GRO_HW;
> > -	if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS))
> > -		dev->hw_features |=3D NETIF_F_GRO_HW;
> >
> >  	dev->vlan_features =3D dev->features;
> >  	dev->xdp_features =3D NETDEV_XDP_ACT_BASIC |
> NETDEV_XDP_ACT_REDIRECT |
> > @@ -7058,6 +7056,10 @@ static int virtnet_probe(struct virtio_device *v=
dev)
> >  	}
> >  	vi->guest_offloads_capable =3D vi->guest_offloads;
> >
> > +	if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS) &&
> > +	    (vi->guest_offloads_capable & GUEST_OFFLOAD_GRO_HW_MASK))
> > +		dev->hw_features |=3D NETIF_F_GRO_HW;
> > +
> >  	rtnl_unlock();
> >
> >  	err =3D virtnet_cpu_notif_add(vi);
> > --
> > 2.34.1
> >
>=20



