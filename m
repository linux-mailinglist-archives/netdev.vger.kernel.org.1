Return-Path: <netdev+bounces-263716-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHNBMUIGqGmEnQAAu9opvQ
	(envelope-from <netdev+bounces-263716-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 11:15:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 313791FE29C
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 11:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 678E73056DA8
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 10:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B5639FCAF;
	Wed,  4 Mar 2026 10:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EiixbXs4"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB01339F18B
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 10:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772619305; cv=none; b=rTF2pI1k0G9512+UJnF4Yfnb5hbPVwB7zb898J8Q1LX1NBYL7vciDMYfsTR6vV2l7H1XJpbHIy7OVKvWF44PGgYsNErMNOV/VQP1iZ6BLUZYpEXuykhYAdj++sbObzkesL6SljiGHr+O6mOfYKBONcfyp8nSbmd2lQ3SnyRDkKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772619305; c=relaxed/simple;
	bh=OEAAfEKfsn2JcuL9Awl0Weq0r+u/vOWftHWfhhqAtSA=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=rSDkob50yeMctMcRtm0yzTXtIj9vy8R4KDV0Mfh+IyNsSk3kvovpfl1hxMZue/aWVwqLOJdAgPi52KIuSmyz4gYnyKXf5yf7A6afL4Utj+kCN2tD8stNFvUc8SsI3Hb3ZLeE+MfJJmguKFS912P/ocVKV3DVtxg7R/PV15dGOlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EiixbXs4; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772619300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EThCce009gcEi7uBsJt/0OWbt3TAZS8GnSCuQpt202M=;
	b=EiixbXs466ErH+Qt824+cuS733CaqeSsMJSGd15wFnO1SkowgQVrLfaVZ6cyQkyRIoVHMQ
	oCj30ytB702PzCYSdnPY1bOyby54P5TzyZVyAnd6+lnRDtCP6uYC5v6CtJTP5wC2tjrRZy
	SycvvMkNaswIzChs6DyzNAILy+2faPI=
Date: Wed, 04 Mar 2026 10:14:55 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <30b87ec07b9558a0eca2c1a4d0e7009454d8612d@linux.dev>
TLS-Required: No
Subject: Re: [PATCH net v1] bonding: fix type confusion in
 bond_setup_by_slave()
To: "Jay Vosburgh" <jv@jvosburgh.net>
Cc: netdev@vger.kernel.org, "Jiayuan Chen" <jiayuan.chen@shopee.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Pravin B Shelar"
 <pshelar@nicira.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1268309.1772601838@famine>
References: <20260228095854.391093-1-jiayuan.chen@linux.dev>
 <1268309.1772601838@famine>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 313791FE29C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263716-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xxx:email,shopee.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Action: no action

March 4, 2026 at 13:23, "Jay Vosburgh" <jv@jvosburgh.net mailto:jv@jvosbu=
rgh.net?to=3D%22Jay%20Vosburgh%22%20%3Cjv%40jvosburgh.net%3E > wrote:


>=20
>=20Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
>=20
>=20>=20
>=20> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> >=20
[...]
>=20>  bond_dev->header_ops =3D slave_dev->header_ops;


Hi Jay,

Thank you for reviewing this patch.


>  This is true only for devices that are not ARPHRD_ETHER
> >=20
>=20> This causes a type confusion when dev_hard_header() is later called
> > on the bond device. Functions like ipgre_header(), ip6gre_header(),
> > vlan_dev_hard_header(), and macvlan_hard_header() all use
> > netdev_priv(dev) to access their device-specific private data. When
> > called with the bond device, netdev_priv() returns the bond's private
> > data (struct bonding) instead of the expected type (e.g. struct
> > ip_tunnel), leading to garbage values being read and kernel crashes.
> >=20
>=20 I believe that vlan and macvlan are both ARPHRD_ETHER, and thus
> won't take the bond_setup_by_slave path (which was originally
> implemented for Infiniband).
>  That said, your description for the GRE paths seems correct.



Thanks. You are right. vlan and macvlan are both ARPHRD_ETHER and go thro=
ugh
bond_ether_setup(), not bond_setup_by_slave(). I'll remove them from
the description in v2.

[...]
> >  ip link add dummy0 type dummy
> >  ip addr add 10.0.0.1/24 dev dummy0
> >  ip link set dummy0 up
> >  ip link add gre1 type gre local 10.0.0.1
> >  ip link add bond1 type bond mode active-backup
> >  ip link set gre1 master bond1
> >  ip link set gre1 up
> >  ip link set bond1 up
> >  ip addr add fe80::1/64 dev bond1
> >=20
>=20> Fixes: c54419321455 ("GRE: Refactor GRE tunneling code.")
> >=20
>=20 Has something relevant changed more recently than this? I seem
> to recall hearing of folks using bonding with GRE more recently than th=
e
> 2013 date on c54419321455. I didn't do an exhaustive search, but I feel
> like someone would have run into this in the prior 13-ish years if it's
> been broken the whole time.

Good question. Here is the full timeline:

1. 1da177e4c3f4 ("Linux-2.6.12-rc2", 2005) - ipgre_header() already
uses dev->priv (later netdev_priv(dev)), but bonding cannot
enslave non-Ethernet devices at all, so no issue.

2. 872254dd6b1f ("net/bonding: Enable bonding to enslave non
ARPHRD_ETHER", 2007-10-09) - bond_setup_by_slave() is introduced
for IPoIB support, but it does NOT copy hard_header or header_ops.
Still no issue.

3. 3b04ddde02cf ("[NET]: Move hardware header operations out of
netdevice.", 2007-10-09) - dev->hard_header is refactored into
dev->header_ops->create. GRE gets ipgre_header_ops. Still no issue
because bond doesn't copy header_ops yet.

4. 1284cd3a2b74 ("bonding: two small fixes for IPoIB support",
2007-10-15) - bond_setup_by_slave() starts copying header_ops from
slave to bond. This is the commit that introduces the flawed pattern.

The problem is not limited to the panic shown in the crash
log. The fundamental issue is that netdev_priv(bond_dev) returns a
pointer to struct bonding, which ipgre_header() interprets as struct
ip_tunnel. Fields like t->hlen and t->parms.iph contain whatever
garbage happens to be at those offsets in the bonding structure.

When t->hlen is abnormally large or negative, it triggers the BUG_ON in
pskb_expand_head(). But even without a panic, the corrupted values
would produce malformed packets with wrong IP headers and GRE flags.

So now I think 1284cd3a2b74 is more appropriate.

I also tested on kernel 5.10 and added printk to show dev->name, it was
still "bond1".

~# dmesg -c

[    0.000000] Linux version 5.10.248+ (root@xxx) (gcc (Ubuntu 13.3.0-6ub=
untu2~24.04) 13.3.0, GNU ld (GNU Binutils for Ubuntu) 2.42) #4 SMP PREEMP=
T Wed Mar 46
[    0.000000] Command line: console=3DttyS0 root=3D/dev/sda earlyprintk=
=3Dserial net.ifnames=3D0 rw tmpfs=3D20G kmsan.panic=3D0
[    0.000000] KERNEL supported cpus:
......
[   44.942850] bond1: (slave gre1): The slave device specified does not s=
upport setting the MAC address
[   44.942859] bond1: (slave gre1): Setting fail_over_mac to active for a=
ctive-backup mode
[   44.944602] bond1: (slave gre1): making interface the new active one
[   44.944697] bond1: (slave gre1): Enslaving as an active interface with=
 an up link
[   44.951456] 8021q: adding VLAN 0 to HW filter on device bond1
[   44.969646] dev name bond1
[   45.333625] dev name bond1
[   45.941654] IPv6: ADDRCONF(NETDEV_CHANGE): bond1: link becomes ready
[   45.953612] dev name bond1
[   46.357629] dev name bond1
[   46.549627] dev name bond1
[   46.581614] dev name bond1
[   47.381737] dev name bond1
[   47.381749] dev name bond1
[   47.489620] dev name bond1=20



[...]
>=20> +
> > +static const struct header_ops bond_header_ops =3D {
> > + .create =3D bond_header_create,
> > + .parse =3D bond_header_parse,
> > +};
> > +
> >  static void bond_setup_by_slave(struct net_device *bond_dev,
> >  struct net_device *slave_dev)
> >  {
> > @@ -1516,7 +1554,8 @@ static void bond_setup_by_slave(struct net_devi=
ce *bond_dev,
> >=20=20
>=20>  dev_close(bond_dev);
> >=20=20
>=20> - bond_dev->header_ops =3D slave_dev->header_ops;
> > + bond_dev->header_ops =3D slave_dev->header_ops ?
> > + &bond_header_ops : NULL;
> >=20
>=20 Can slave_dev->header_ops actually be NULL?



Yes. For example, a GRE tunnel created with a unicast remote
ip link add gre1 type gre local 10.0.0.1 remote 10.0.0.2
does not set header_ops (see ipgre_tunnel_init(), the iph->daddr && !tunn=
el->collect_md branch).

>  -J
>=20
>=20>=20
>=20> bond_dev->type =3D slave_dev->type;
> >  bond_dev->hard_header_len =3D slave_dev->hard_header_len;
> > --=20
>=20> 2.43.0
> >=20
>=20---
>  -Jay Vosburgh, jv@jvosburgh.net
>

