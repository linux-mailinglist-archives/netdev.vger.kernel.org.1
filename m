Return-Path: <netdev+bounces-268390-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6M1OHrW0uGmtiAEAu9opvQ
	(envelope-from <netdev+bounces-268390-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 02:56:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C8F2A2AEC
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 02:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B0521300DEEC
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 01:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890953446C3;
	Tue, 17 Mar 2026 01:55:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw2.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A57933689E
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 01:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773712557; cv=none; b=T54WV51FCUASKhmSk3NipjXN9tTFLab425wAYO7jYz3ZXKm6CBLBRW0/B33vxNsA/hJtk4gPN2CMAW8S4PoU0MA3UBm+pwpXRra4mTE6u4GyL/NUERvZCqqoL5sCEJ38HngYSEpmv2H0Sx6Yi72wLTa2ZSaHbEiBR8ztOx2b5Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773712557; c=relaxed/simple;
	bh=2/2HUA3By2NMFsSVRVdn3kpZAEtduULy9QuRLuXffQw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U680YOrj+Nw4+5ZIfnoaBKXgKo6qznTmGzNInQ9hfhA91dF6eyZu04KIg/zzgpxOdgFTKfnadBt+eMMGZefp689iZhgxDUx/vOc42rkKRzA0aHfKKTMUX4z5K5NFKjCo9vzMeIr6q4Pl6R9dloK4EB7m3nYWWbeTihBVzyVPiVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
	by mailgw2.hygon.cn (Postfix) with ESMTP id 4fZZmT2dCFz1YQpmG;
	Tue, 17 Mar 2026 09:55:37 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
	by mailgw2.hygon.cn (Postfix) with ESMTP id 4fZZmS6n3cz1YQpmG;
	Tue, 17 Mar 2026 09:55:36 +0800 (CST)
Received: from cncheex05.Hygon.cn (unknown [172.23.18.115])
	by maildlp1.hygon.cn (Postfix) with ESMTPS id BA69D16D8;
	Tue, 17 Mar 2026 09:55:32 +0800 (CST)
Received: from cncheex04.Hygon.cn (172.23.18.114) by cncheex05.Hygon.cn
 (172.23.18.115) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 17 Mar
 2026 09:55:36 +0800
Received: from cncheex04.Hygon.cn ([fe80::1b6f:6c58:58a4:430d]) by
 cncheex04.Hygon.cn ([fe80::1b6f:6c58:58a4:430d%10]) with mapi id
 15.02.1544.036; Tue, 17 Mar 2026 09:55:36 +0800
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
Thread-Index: AQHctRWZ2ojSo6zfekKUjfvJ+iW5wbWwWqSAgACMBDD//43AAIAAnuoQ//+OZQCAAIguYP//jUqAACbTdJA=
Date: Tue, 17 Mar 2026 01:55:36 +0000
Message-ID: <7f7c217bb44f496a8111a785b2776666@hygon.cn>
References: <20260316072152.910857-1-zhud@hygon.cn>
 <20260316051327-mutt-send-email-mst@kernel.org>
 <607818aba89a44d88afa213f39611451@hygon.cn>
 <20260316063139-mutt-send-email-mst@kernel.org>
 <a82cd6088e554fe1bb3daa6ad3df18dc@hygon.cn>
 <20260316092707-mutt-send-email-mst@kernel.org>
 <4e3ce2d6120545719a286d3daafbef38@hygon.cn>
 <20260316095919-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260316095919-mutt-send-email-mst@kernel.org>
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
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-268390-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhud@hygon.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.867];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	DMARC_DNSFAIL(0.00)[hygon.cn : query timed out];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 64C8F2A2AEC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> On Mon, Mar 16, 2026 at 01:57:22PM +0000, Zhud wrote:
> >  > On Mon, Mar 16, 2026 at 12:57:00PM +0000, Zhud wrote:
> > > > > On Mon, Mar 16, 2026 at 10:18:04AM +0000, Zhud wrote:
> > > > > > > Thanks! Yes something to improve:
> > > > > > >
> > > > > > > On Mon, Mar 16, 2026 at 03:21:52PM +0800, Di Zhu wrote:
> > > > > > > > Although VIRTIO_NET_F_CTRL_GUEST_OFFLOADS is negotiated,
> > > > > > > > which indicates the device supports dynamic control of
> > > > > > > > guest offloads, it does not necessarily mean the device
> > > > > > > > supports specific hardware GRO
> > > > > features.
> > > > > > > >
> > > > > > > > If none of the features defined in
> > > > > > > > GUEST_OFFLOAD_GRO_HW_MASK (such as TSO4, TSO6, or UFO) are
> > > > > > > > present in
> > > > > > > > vi->guest_offloads_capable, the device effectively lacks
> > > > > > > > vi->the hardware
> > > capability to perform GRO.
> > > > > > >
> > > > > > > So what is the user-visible problem this is trying to address=
?
> > > > > >
> > > > > > A key concern is that once a user enables NETIF_F_GRO_HW via
> > > > > > ethtool, they might manually disable software GRO (ethtool -K
> > > > > > eth0 gro off) assuming the hardware is now handling the aggrega=
tion.
> > > > >
> > > > > Thanks!
> > > > > Sorry could you be even more specific please?
> > > > > Is this a theoretical concern or did some users encounter this?
> > > > > Note that NETIF_F_GRO_HW is best effort anyway: e.g.
> > > > > it can apply only to TCPv6 and v4 will still need software.
> > > >
> > > > This might not be the best example, but I want to draw an analogy
> > > > to show how this hardware offload capability can be misleading.
> > > > For instance, if I enable GRO_HW expecting to see lower CPU usage
> > > > when receiving packets, but it doesn't happen, that would be very c=
onfusing.
> > >
> > > It still can happen if hardware does not offload the specific traffic=
, yes?
> >
> > Yes, of course, but there's still a difference between "best-effort" an=
d "no-effort."
> Right?
>=20
> I am not saying this does not improve the user experience.
> But let us set the expectations correctly.
>=20
> What this does (I think):
>=20
> 	When a virtio device does not have either GUEST_TSO6 or
> 	GUEST_TSO4 offloads, this means it can't really do
> 	hardware GRO.
>=20
> 	however, the driver will set NETIF_F_GRO_HW whenever
> 	the device allows control over offload support - even
> 	if the offloads that can be controlled have nothing
> 	to do with GRO.
>=20
> 	As a result, in such a setup, rx-gro-hw reported for the device
> 	is too optimistic.  Improve the situation by masking off
> 	NETIF_F_GRO_HW.


	Thank you for the much clearer explanation of the problem.=20
	It perfectly captures the intent. I will use this description for the v3 p=
atch


> 	Out of abundance of caution, this does not change the
> 	current behaviour for hardware with just v6 or just v4 GRO:
> 	current interfaces do not allow
> 	distinguishing between v6/v4 GRO, so we can't expose
> 	them to userspace precisely.

	Yes, exactly. That is why I used GUEST_OFFLOAD_GRO_HW_MASK to
	maintain the current behavior.

> Also:
> > Fixes: a02e8964eaf9 ("virtio-net: ethtool configurable LRO")
>=20
> are you sure it's right?

	Fixes: dbcf24d15388 ("virtio-net: use NETIF_F_GRO_HW instead of NETIF_F_LR=
O")=20
	Maybe the more accurate target. I will update the Fixes tag, thanks.

>=20
> > >
> > > > > > Secondly, while we haven't encountered a specific hardware
> > > > > > failure yet, enabling a hardware offload feature that the DPU
> > > > > > does not physically support introduces the risk of undefined
> > > > > > hardware behavior
> > > > >
> > > > > This would be a major concern but I don't get it - how would one =
trigger this?
> > > > > It seems that guest_offloads_capable only includes offloads actua=
lly
> supported.
> > > >
> > > > You're absolutely right. Upon rechecking the code,
> > > > virtnet_set_features already ensures that only bits within
> > > vi->guest_offloads_capable are sent to the device.
> > > > Thank you for pointing that out.
> > > >
> > > > > > > >
> > > > > > > > So, making NETIF_F_GRO_HW conditional on these feature
> > > > > > > > bits ensures the stack does not enable an unsupported
> > > > > > > > hardware offload
> > > > > configuration.
> > > > > > >
> > > > > > > I guess the assumption is that without this, something
> > > > > > > enables such a config? Which stack is this and what happens t=
hen?
> > > > > > >
> > > > > >
> > > > > > Sorry for the confusion, let me clarify the intent.
> > > > > > The 'stack' here refers to the ethtool interface and the
> > > > > > netset (ioctl/netlink)
> > > path.
> > > > >
> > > > >
> > > > > A bit more detail about the specific set of commands that leads
> > > > > to confusion in the commit log would be helpful.
> > > >
> > > > > Thanks!
> > > > >
> > > > > > >
> > > > > > > > Fixes: a02e8964eaf9 ("virtio-net: ethtool configurable
> > > > > > > > LRO")
> > > > > > > > Signed-off-by: Di Zhu <zhud@hygon.cn>
> > > > > > >
> > > > > > > judging by this, has something to do with LRO?
> > > > > > >
> > > > > > > > ---
> > > > > > > > /* v2 */
> > > > > > > >   -make the modified logic clearer
> > > > > > > > ---
> > > > > > > >  drivers/net/virtio_net.c | 6 ++++--
> > > > > > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/net/virtio_net.c
> > > > > > > > b/drivers/net/virtio_net.c index
> > > > > > > > 72d6a9c6a5a2..b233c99925e9 100644
> > > > > > > > --- a/drivers/net/virtio_net.c
> > > > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > > > @@ -6781,8 +6781,6 @@ static int virtnet_probe(struct
> > > > > > > > virtio_device
> > > *vdev)
> > > > > > > >  	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
> > > > > > > >  	    virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO6))
> > > > > > > >  		dev->features |=3D NETIF_F_GRO_HW;
> > > > > > > > -	if (virtio_has_feature(vdev,
> VIRTIO_NET_F_CTRL_GUEST_OFFLOADS))
> > > > > > > > -		dev->hw_features |=3D NETIF_F_GRO_HW;
> > > > > > > >
> > > > > > > >  	dev->vlan_features =3D dev->features;
> > > > > > > >  	dev->xdp_features =3D NETDEV_XDP_ACT_BASIC |
> > > > > > > NETDEV_XDP_ACT_REDIRECT |
> > > > > > > > @@ -7058,6 +7056,10 @@ static int virtnet_probe(struct
> > > > > > > > virtio_device
> > > *vdev)
> > > > > > > >  	}
> > > > > > > >  	vi->guest_offloads_capable =3D vi->guest_offloads;
> > > > > > > >
> > > > > > > > +	if (virtio_has_feature(vdev,
> > > > > > > > +VIRTIO_NET_F_CTRL_GUEST_OFFLOADS)
> > > &&
> > > > > > > > +	    (vi->guest_offloads_capable &
> > > GUEST_OFFLOAD_GRO_HW_MASK))
> > > > > > > > +		dev->hw_features |=3D NETIF_F_GRO_HW;
> > > > > > > > +
> > > > > > > >  	rtnl_unlock();
> > > > > > > >
> > > > > > > >  	err =3D virtnet_cpu_notif_add(vi);
> > > > > > > > --
> > > > > > > > 2.34.1
> > > > > > > >
> > > > > > >
> > > > > >
> > > > >
> > > >
> > >
> >
>=20



