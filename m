Return-Path: <netdev+bounces-262063-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AK8mG+Biommk2gQAu9opvQ
	(envelope-from <netdev+bounces-262063-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 04:37:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CBF41C026D
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 04:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56E3730791FF
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 03:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C302D6E6C;
	Sat, 28 Feb 2026 03:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qgSyo5Ec"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AFF28641F;
	Sat, 28 Feb 2026 03:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772249801; cv=none; b=NEXygAohRa0KAlMeCVai5HLO1G6bRsXzZXNoZMnwE1twfpRbKATfnpQ38eE0yifUL0i5aut0zl5Fn+Lvum1ULo4Zgl3937itNnotBzcrG74FkJHcAP2M5bczXZL8cljf5nPo7auwCWMxb9kwmI6aEaUlCTnhRrdeovZN1KiDtmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772249801; c=relaxed/simple;
	bh=qGi3TBC4+ZZlUUd73EZcWgH044aOoOU3ydVwpDiZ2MQ=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=bjnTD6YfS02mgRbT9dnPjfQ6e3slRx6X9M+dzDJ54GAK6RrT27obt/YtqHP89fOZJ+WiGFr37U5uh1nQNZ7zAbOu1p/A9+2aI8IqEdrcvOB1XLSkcuUUwX4zyzVb9D0XRzoTi5es2RAzFOYvJ33NdrAkVVtDVtBMsYaAnoL2EG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qgSyo5Ec; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772249787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uhExI+NlEqBzfbQcIfU9xl+aEEsBqnMjFmXS+IGjlNM=;
	b=qgSyo5EcU3CTPjtNkkigPA69NE6f75rl5NuL+8ulHP3t4Hk2gdOA7dqo2JBJJPemmpJbHD
	cQ7wkQK7EFVc5hMpGpf+l1dQsVuOGWKfEa6lw9MzCJtmdREnObQke26wz1StmKBtFIXxaN
	Yb6qYrS+cBhwiuSBnI69gTGUbr6qRb0=
Date: Sat, 28 Feb 2026 03:36:24 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <08041bd78c06981b18b3de90a95e0c951bf1623c@linux.dev>
TLS-Required: No
Subject: Re: [PATCH net v3 1/2] bonding: fix null-ptr-deref in
 bond_rr_gen_slave_id()
To: "Jay Vosburgh" <jv@jvosburgh.net>
Cc: netdev@vger.kernel.org, jiayuna.chen@linux.dev, jiayuna.chen@shopee.com,
 "Jiayuan Chen" <jiayuan.chen@shopee.com>,
 syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Jesper Dangaard Brouer"
 <hawk@kernel.org>, "John Fastabend" <john.fastabend@gmail.com>,
 "Stanislav Fomichev" <sdf@fomichev.me>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "KP Singh"
 <kpsingh@kernel.org>, "Hao Luo" <haoluo@google.com>, "Jiri Olsa"
 <jolsa@kernel.org>, "Shuah Khan" <shuah@kernel.org>, "Sebastian Andrzej
 Siewior" <bigeasy@linutronix.de>, "Clark Williams"
 <clrkwllms@kernel.org>, "Steven Rostedt" <rostedt@goodmis.org>, "Jussi
 Maki" <joamaki@gmail.com>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
In-Reply-To: <999129.1772247707@famine>
References: <20260228021918.141002-1-jiayuan.chen@linux.dev>
 <20260228021918.141002-2-jiayuan.chen@linux.dev>
 <999129.1772247707@famine>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262063-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.dev,shopee.com,syzkaller.appspotmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,linutronix.de,goodmis.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,80e046b8da2820b6ba73];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,jvosburgh.net:email,appspotmail.com:email,linux.dev:mid,linux.dev:dkim,linux.dev:email,shopee.com:email]
X-Rspamd-Queue-Id: 0CBF41C026D
X-Rspamd-Action: no action

February 28, 2026 at 11:01, "Jay Vosburgh" <jv@jvosburgh.net mailto:jv@jv=
osburgh.net?to=3D%22Jay%20Vosburgh%22%20%3Cjv%40jvosburgh.net%3E > wrote:


>=20
>=20Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
>=20
>=20>=20
>=20> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> >=20
>=20> bond_rr_gen_slave_id() dereferences bond->rr_tx_counter without a N=
ULL
> > check. rr_tx_counter is a per-CPU counter only allocated in bond_open=
()
> > when the bond mode is round-robin. If the bond device was never broug=
ht
> > up, rr_tx_counter remains NULL, causing a null-ptr-deref.
> >=20
>=20> The XDP redirect path can reach this code even when the bond is not=
 up:
> > bpf_master_redirect_enabled_key is a global static key, so when any b=
ond
> > device has native XDP attached, the XDP_TX -> xdp_master_redirect()
> > interception is enabled for all bond slaves system-wide. This allows =
the
> > path xdp_master_redirect() -> bond_xdp_get_xmit_slave() ->
> > bond_xdp_xmit_roundrobin_slave_get() -> bond_rr_gen_slave_id() to be
> > reached on a bond that was never opened.
> >=20
>=20> The normal TX path (bond_xmit_roundrobin) is not affected because T=
X
> > requires the bond to be UP, which guarantees rr_tx_counter is allocat=
ed.
> > However, bond_xmit_get_slave() (ndo_get_xmit_slave) has the same code
> > pattern via bond_xmit_roundrobin_slave_get() and could theoretically
> > hit the same issue.
> >=20
>=20 As a practical matter, though, I don't think the
> ndo_get_xmit_slave path can actually hit the issue, as that looks to
> only be called from Infiniband, which is only supported in bonding for
> active-backup mode.
>=20
>=20>=20
>=20> Fix this by allocating rr_tx_counter unconditionally in bond_init()
> > (ndo_init), which is called by register_netdevice() and covers both
> > device creation paths (bond_create() and bond_newlink()). This also
> > handles the case where bond mode is changed to round-robin after devi=
ce
> > creation. The conditional allocation in bond_open() is removed. Since
> > bond_destructor() already unconditionally calls
> > free_percpu(bond->rr_tx_counter), the lifecycle is clean: allocate at
> > ndo_init, free at destructor.
> >=20
>=20> Fixes: 879af96ffd72 ("net, core: Add support for XDP redirection to=
 slave device")
> > Reported-by: syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/all/698f84c6.a70a0220.2c38d7.00cc.GAE=
@google.com/T/
> > Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> >=20
>=20 My only concern is that this will waste a percpu u32 per bond
> device for the majority of bonding use cases (which use modes other tha=
n
> balance-rr), which could be a few hundred bytes on a large machine.
>=20
>=20 Does everything work reliably if the rr_tx_counter allocation
> happens conditionally on mode =3D=3D BOND_MODE_ROUNDROBIN in bond_setup=
, as
> well as in bond_option_mode_set?
>=20



Hi=20Jay,

Thanks for the review.

bond_setup() is not suitable here as it is a void callback with no error =
return path,
so an alloc_percpu() failure cannot be propagated.

An alternative would be to allocate conditionally in bond_init() (since t=
he default mode is round-robin)
and manage allocation/deallocation in bond_option_mode_set() when the mod=
e changes.

This is a trade-off between the added complexity of conditional alloc/fre=
e across multiple code
paths and saving a per-CPU u32 for non-round-robin bonds.

For the per-CPU u32 overhead, it's only 4 extra bytes per CPU per bond de=
vice =E2=80=94 and machines with
that many CPUs tend to have plenty of memory to match.

I don't have a strong preference either way.

Thanks

>  -J
>=20
>=20>=20
>=20> ---
> >  drivers/net/bonding/bond_main.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >=20
>=20> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/=
bond_main.c
> > index 78cff904cdc3..9f63f67d8418 100644
> > --- a/drivers/net/bonding/bond_main.c
> > +++ b/drivers/net/bonding/bond_main.c
> > @@ -4279,12 +4279,6 @@ static int bond_open(struct net_device *bond_d=
ev)
> >  struct list_head *iter;
> >  struct slave *slave;
> >=20=20
>=20> - if (BOND_MODE(bond) =3D=3D BOND_MODE_ROUNDROBIN && !bond->rr_tx_c=
ounter) {
> > - bond->rr_tx_counter =3D alloc_percpu(u32);
> > - if (!bond->rr_tx_counter)
> > - return -ENOMEM;
> > - }
> > -
> >  /* reset slave->backup and slave->inactive */
> >  if (bond_has_slaves(bond)) {
> >  bond_for_each_slave(bond, slave, iter) {
> > @@ -6411,6 +6405,12 @@ static int bond_init(struct net_device *bond_d=
ev)
> >  if (!bond->wq)
> >  return -ENOMEM;
> >=20=20
>=20> + bond->rr_tx_counter =3D alloc_percpu(u32);
> > + if (!bond->rr_tx_counter) {
> > + destroy_workqueue(bond->wq);
> > + return -ENOMEM;
> > + }
> > +
> >  bond->notifier_ctx =3D false;
> >=20=20
>=20>  spin_lock_init(&bond->stats_lock);
> > --=20
>=20> 2.43.0
> >=20
>=20---
>  -Jay Vosburgh, jv@jvosburgh.net
>

