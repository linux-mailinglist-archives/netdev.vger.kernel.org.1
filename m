Return-Path: <netdev+bounces-268596-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UONeJx5MuWnG/QEAu9opvQ
	(envelope-from <netdev+bounces-268596-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 13:42:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B01A2AA0B1
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 13:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 22A95304C2E1
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 12:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2E83C3BEB;
	Tue, 17 Mar 2026 12:42:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw2.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C8D16CD33
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 12:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773751323; cv=none; b=royM3V4oZE2fa5GJe6SUcXHPZnG+Ov6A0e53zrbIjAg+0NObFB5wHmEkOUdojWy3iRLy0shJ5zb3OHOGJp3JDhjkcTzWEv4vHP8tR2/RYIwAs3Oj0csbk7XeFg64FXubwzRrT8rnYSo5eQ9UnQH48+yl/pAfDOYs3yG6du3lMG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773751323; c=relaxed/simple;
	bh=wJ3TqCPsJ9sgu2hk7KOZS3SiUIi/vswN/ohyvPKIMJ0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rL8SEhAJn2ji1htAVqzNXnFyDUVCSsXVgYMqIEhQxBgHGL25dwx9ooFyoPcsf354+hbV4f03goz0D72Qw5MiEcAh0GMPZUh0po/mJoiuk1JgDYNROK4KkJUbVVTGk0ExrBnzbi8/G6FgXNuC8osS/v4WQLN3+gkGUyhnfZYv20A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
	by mailgw2.hygon.cn (Postfix) with ESMTP id 4fZs5y2QDNz1YQpmJ;
	Tue, 17 Mar 2026 20:41:42 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
	by mailgw2.hygon.cn (Postfix) with ESMTP id 4fZs5x5Q2Lz1YQpmJ;
	Tue, 17 Mar 2026 20:41:41 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
	by maildlp1.hygon.cn (Postfix) with ESMTPS id 9FD0C849E;
	Tue, 17 Mar 2026 20:41:37 +0800 (CST)
Received: from cncheex04.Hygon.cn (172.23.18.114) by cncheex04.Hygon.cn
 (172.23.18.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 17 Mar
 2026 20:41:42 +0800
Received: from cncheex04.Hygon.cn ([fe80::1b6f:6c58:58a4:430d]) by
 cncheex04.Hygon.cn ([fe80::1b6f:6c58:58a4:430d%10]) with mapi id
 15.02.1544.036; Tue, 17 Mar 2026 20:41:42 +0800
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
	<yingzhiwei@hygon.cn>, Philo Lu <lulie@linux.alibaba.com>, Joe Damato
	<jdamato@fastly.com>
Subject: RE: [PATCH net v3] virtio-net: enable NETIF_F_GRO_HW only if
 GRO-related offloads are supported
Thread-Topic: [PATCH net v3] virtio-net: enable NETIF_F_GRO_HW only if
 GRO-related offloads are supported
Thread-Index: AQHctgIsDY8nIT6XukqVKwAnhqpvxrWyGjwAgACLEdA=
Date: Tue, 17 Mar 2026 12:41:42 +0000
Message-ID: <1e4274c76b86429aac86216a97a97cbd@hygon.cn>
References: <20260317113433.927022-1-zhud@hygon.cn>
 <20260317074739-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260317074739-mutt-send-email-mst@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[hygon.cn : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-268596-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhud@hygon.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.854];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2B01A2AA0B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> On Tue, Mar 17, 2026 at 07:34:33PM +0800, Di Zhu wrote:
> > Negotiating VIRTIO_NET_F_CTRL_GUEST_OFFLOADS indicates the device
> > allows control over offload support, but the offloads that can be
> > controlled may have nothing to do with GRO (e.g., if neither
> > GUEST_TSO4 nor GUEST_TSO6 is supported).
> >
> > In such a setup, reporting NETIF_F_GRO_HW as available for the device
> > is too optimistic and misleading to the user.
> >
> > Improve the situation by masking off NETIF_F_GRO_HW unless the device
> > possesses actual GRO-related offload capabilities. Out of an abundance
> > of caution, this does not change the current behaviour for hardware
> > with just v6 or just v4 GRO: current interfaces do not allow
> > distinguishing between v6/v4 GRO, so we can't expose them to userspace
> precisely.
> >
> > Fixes: dbcf24d15388 ("virtio-net: use NETIF_F_GRO_HW instead of
> > NETIF_F_LRO")
> > Signed-off-by: Di Zhu <zhud@hygon.cn>
> > ---
> > /* v3 */
> >   -Update Fixes tag to dbcf24d15388
> >   -Refine commit message using Maintainer's "too optimistic"
> >     phrasing to clarify the risk of misleading configurations.
> >
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
>=20
> Hmm wait a second. Isn't this late? netdev registered, even link is up al=
ready.
>=20
> Documentation/networking/netdev-features.rst says:
>=20
>  1. netdev->hw_features set contains features whose state may possibly
>     be changed (enabled or disabled) for a particular device by user's
>     request.  This set should be initialized in ndo_init callback and not
>     changed later.
>=20
>=20
>=20
> I'd say let's move it up?

"Thanks for the feedback. My initial thought was that performing the modifi=
cation under=20
rtnl_lock after register_netdevice() would be safe from races with ethtool =
or link-up. However,=20
I agree that staying consistent with the documentation and initializing hw_=
features before the device
becomes globally visible is a much cleaner approach.

>=20
> Having said that, we already have a bug:
>=20
>   dev->hw_features &=3D ~NETIF_F_RXHASH;
> is after register, too.

To be honest, I was misled by the existing code where dev->hw_features &=3D=
 ~NETIF_F_RXHASH;=20
is also set after registration.


>=20
> This is because we take pains to recover from these commands failing.
> Except, we completely ignore that in virtnet_set_rxfh ...
>=20
>=20
> Cc relevant contributors to maybe take a look at fixing all that.
>=20
>=20
>=20
> >  	rtnl_unlock();
> >
> >  	err =3D virtnet_cpu_notif_add(vi);
> > --
> > 2.34.1
> >
>=20



