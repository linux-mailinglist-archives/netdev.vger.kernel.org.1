Return-Path: <netdev+bounces-120856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8097695B0B1
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 10:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E78A2813A5
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 08:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A2A1C6B5;
	Thu, 22 Aug 2024 08:39:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2B819470
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 08:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724315970; cv=none; b=tGA5Ay8Vz1u+XMQZ2YEfZCMTQ/VlVgNqDsBJ6+0boOEgyDV5Lx78f9XD4LBeNbq08YOlQkAygNfS6BDF2iLKCt/DdCm0RD9rFTeNxJ2QuQNDKNI3wSReYYTTx4cyGvmoPmFhTw9Cfp/pFNbXdiFeC5Z/1+mRsG+Vm1geGAEROzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724315970; c=relaxed/simple;
	bh=/WNOZVaxFcLc7rGs4i0FjqBDbnUEF3MXJf3iqIuL/DA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=SSXQrn8bq+vl9s2aa2DXwkD7WnYg3HwObz7hvn4hJU8krFaD9/94ufmyXlo+uNKSH/yLeV5Ji9ypBaufNi+Yn/48jRe+sqmY3+7+TVQ55youCThr4ruHOIo+828v8HlkWHc/XimOJOQYsana6ql6sPHKr3OGcIqcYj2/ZoabzZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-j7X9uThoNcWuUyHZ7_qjlA-1; Thu,
 22 Aug 2024 04:39:20 -0400
X-MC-Unique: j7X9uThoNcWuUyHZ7_qjlA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BA8D41955BF1;
	Thu, 22 Aug 2024 08:39:18 +0000 (UTC)
Received: from hog (unknown [10.39.192.5])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5F95819560AA;
	Thu, 22 Aug 2024 08:39:13 +0000 (UTC)
Date: Thu, 22 Aug 2024 10:39:11 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCHv3 net-next 2/3] bonding: Add ESN support to IPSec HW
 offload
Message-ID: <Zsb5L-2srQLUpMmn@hog>
References: <20240820004840.510412-1-liuhangbin@gmail.com>
 <20240820004840.510412-3-liuhangbin@gmail.com>
 <ZsS3Zh8bT-qc46s7@hog>
 <ZsXd8adxUtip773L@gauss3.secunet.de>
 <ZsXq6BAxdkVQmsID@Laptop-X1>
 <ZsXuJD4PEnakVA-W@hog>
 <ZsaHTbcZPH0O3RBJ@Laptop-X1>
 <ZsbkdzvjVf3GiYHa@gauss3.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZsbkdzvjVf3GiYHa@gauss3.secunet.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-08-22, 09:10:47 +0200, Steffen Klassert wrote:
> On Thu, Aug 22, 2024 at 08:33:17AM +0800, Hangbin Liu wrote:
> > On Wed, Aug 21, 2024 at 03:39:48PM +0200, Sabrina Dubroca wrote:
> > > > > > > +=09if (!real_dev->xfrmdev_ops ||
> > > > > > > +=09    !real_dev->xfrmdev_ops->xdo_dev_state_advance_esn) {
> > > > > > > +=09=09pr_warn("%s: %s doesn't support xdo_dev_state_advance_=
esn\n", __func__, real_dev->name);
> > > > > >=20
> > > > > > xdo_dev_state_advance_esn is called on the receive path for eve=
ry
> > > > > > packet when ESN is enabled (xfrm_input -> xfrm_replay_advance -=
>
> > > > > > xfrm_replay_advance_esn -> xfrm_dev_state_advance_esn), this ne=
eds to
> > > > > > be ratelimited.
> > > > >=20
> > > > > How does xfrm_state offload work on bonding?
> > > > > Does every slave have its own negotiated SA?
> > > >=20
> > > > Yes and no. Bonding only supports xfrm offload with active-backup m=
ode. So only
> > > > current active slave keep the SA. When active slave changes, the sa=
 on
> > > > previous slave is deleted and re-added on new active slave.
> > >=20
> > > It's the same SA, there's no DELSA+NEWSA when we change the active
> > > slave (but we call xdo_dev_state_delete/xdo_dev_state_add to inform
> > > the driver/HW), and only a single NEWSA to install the offloaded SA o=
n
> > > the bond device (which calls the active slave's xdo_dev_state_add).
> >=20
> > Yes, thanks for the clarification. The SA is not changed, we just delet=
e it
> > on old active slave
> >=20
> > slave->dev->xfrmdev_ops->xdo_dev_state_delete(ipsec->xs);
> >=20
> > And add to now one.
> >=20
> > ipsec->xs->xso.real_dev =3D slave->dev;
> > slave->dev->xfrmdev_ops->xdo_dev_state_add(ipsec->xs, NULL)
>=20
> Using the same key on two different devices is very dangerous.

It's only used by one device at a time, we only support offload with
"active-backup" mode, where only the current active slave can send
packets.

> Counter mode algorithms have the requirement that the IV
> must not repeat. If you use the same key on two devices,
> you can't guarantee that. If both devices use an internal
> counter (initialized to one) to generate the IV, then the
> IV repeats for the mumber of packets that were already
> sent on the old device. The algorithm is cryptographically
> broken in that case.

Aren't they basing the IV on the sequence number filled in the header?
If not, then I guess this stuff has been broken since 2020 :(
(18cb261afd7b ("bonding: support hardware encryption offload to slaves"))

> Instead of moving the existing state, it is better to
> request a rekey. Maybe by setting the old state to
> 'expired' and then send a km_state_expired() message.

But then you're going to drop packets during the whole rekey?

--=20
Sabrina


