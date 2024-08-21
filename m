Return-Path: <netdev+bounces-120603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E60959EE4
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 15:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 102CC282A44
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 13:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CBF1ACE0A;
	Wed, 21 Aug 2024 13:40:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CBB1ACDFB
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 13:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724247611; cv=none; b=QoLB4v0rJxQo5gKYLjsWGC+xOtBodjH8ggI5kJr3C+fyOemGP6P5KvR/X58SwU1we7QrXxuIqLDPUsdXtkoO0VUq8XFTgXnpFg/6lxUPKWcHk9TResItahRgZQxuSybTeX2VmDvUTtjFFSN6sMTb4jDsi+FxPpHSNoykR6sIjbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724247611; c=relaxed/simple;
	bh=ZpHRSLONSgywh3IYV5sXpj7FPybyYpdkyGP2cYdeoFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=PNJeyhd1Z+Kr2J8fFz7u5g10NFiwXGQLBuWN3lqhc5CZvsLXzN7njBA1KnJP5YRbL1wWhq/KWj1AbpOXJEmXhV0tat5BENDRFT1xMEVNSHfAYX/vMyKNnOOzw3PaYO1tLq0i+M/b1HRDOg/gz3FKk6xa43vBCPnTbGTcgpowV94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-353-WVomOFIWOumCtWNeXs695g-1; Wed,
 21 Aug 2024 09:39:57 -0400
X-MC-Unique: WVomOFIWOumCtWNeXs695g-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 731BB1955F3F;
	Wed, 21 Aug 2024 13:39:55 +0000 (UTC)
Received: from hog (unknown [10.39.192.5])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DF5B519560AA;
	Wed, 21 Aug 2024 13:39:50 +0000 (UTC)
Date: Wed, 21 Aug 2024 15:39:48 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCHv3 net-next 2/3] bonding: Add ESN support to IPSec HW
 offload
Message-ID: <ZsXuJD4PEnakVA-W@hog>
References: <20240820004840.510412-1-liuhangbin@gmail.com>
 <20240820004840.510412-3-liuhangbin@gmail.com>
 <ZsS3Zh8bT-qc46s7@hog>
 <ZsXd8adxUtip773L@gauss3.secunet.de>
 <ZsXq6BAxdkVQmsID@Laptop-X1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZsXq6BAxdkVQmsID@Laptop-X1>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-08-21, 21:26:00 +0800, Hangbin Liu wrote:
> On Wed, Aug 21, 2024 at 02:30:41PM +0200, Steffen Klassert wrote:
> > > > +/**
> > > > + * bond_advance_esn_state - ESN support for IPSec HW offload
> > > > + * @xs: pointer to transformer state struct
> > > > + **/
> > > > +static void bond_advance_esn_state(struct xfrm_state *xs)
> > > > +{
> > > > +=09struct net_device *real_dev;
> > > > +
> > > > +=09rcu_read_lock();
> > > > +=09real_dev =3D bond_ipsec_dev(xs);
> > > > +=09if (!real_dev)
> > > > +=09=09goto out;
> > > > +
> > > > +=09if (!real_dev->xfrmdev_ops ||
> > > > +=09    !real_dev->xfrmdev_ops->xdo_dev_state_advance_esn) {
> > > > +=09=09pr_warn("%s: %s doesn't support xdo_dev_state_advance_esn\n"=
, __func__, real_dev->name);
> > >=20
> > > xdo_dev_state_advance_esn is called on the receive path for every
> > > packet when ESN is enabled (xfrm_input -> xfrm_replay_advance ->
> > > xfrm_replay_advance_esn -> xfrm_dev_state_advance_esn), this needs to
> > > be ratelimited.
> >=20
> > How does xfrm_state offload work on bonding?
> > Does every slave have its own negotiated SA?
>=20
> Yes and no. Bonding only supports xfrm offload with active-backup mode. S=
o only
> current active slave keep the SA. When active slave changes, the sa on
> previous slave is deleted and re-added on new active slave.

It's the same SA, there's no DELSA+NEWSA when we change the active
slave (but we call xdo_dev_state_delete/xdo_dev_state_add to inform
the driver/HW), and only a single NEWSA to install the offloaded SA on
the bond device (which calls the active slave's xdo_dev_state_add).

--=20
Sabrina


