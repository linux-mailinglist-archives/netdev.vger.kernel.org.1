Return-Path: <netdev+bounces-19458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E017875AC34
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 12:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4DBA1C21387
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 10:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C73156D1;
	Thu, 20 Jul 2023 10:41:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BD719A0B
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 10:41:08 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BD11723
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 03:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689849662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HFMjFukXaE4JjkHYoRsomX87HKQ2UcHd38K+1zq2VFc=;
	b=eSXQGWb5ERWuFpRdjeCmXrQwBUbNDbACuSiv+fMN07ZSDYpH19VFeOpLRDwqLBRwaZ2TKH
	mC2OUb8fpSH2sZfV58hPtu8I7DDbKMiArnnm1oD6DODtdETa1FezlfDt+qg3IJr86rKO7W
	YvJuo89LJAo5F+eRthFR3dBZxhi9TNA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-yPli34mnNOmjOpCrvZt62w-1; Thu, 20 Jul 2023 06:41:01 -0400
X-MC-Unique: yPli34mnNOmjOpCrvZt62w-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6364867fa8aso2002786d6.1
        for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 03:41:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689849660; x=1690454460;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HFMjFukXaE4JjkHYoRsomX87HKQ2UcHd38K+1zq2VFc=;
        b=KS40jETKsm4X+eYmOEg7/wzPlfDM3k3r7TxGf1HG6auij72ds9IEPHGoi1LPAvqPW/
         XaCWTwJ89ZyrHX8dVfEjT6l2jQ+T8LoWAaGFO+A4DC6RcEtxO31VZEsM/OrY7dSWzAYT
         KQj8CoyVzvwWUUdHYY97Nc4L7Fer51k3fPO8eCZcm+vAe8/3MoSp3X54+j2maY+D+Ecf
         4hqz84QN44LyPcctEY42Gp3Pi3ZSg3qAffZ7YpgHezUXK1PuQr+lbpKwvKvAeVmW+Kp/
         QL5SJlKiYNJyxifjjiO8LXJlJ40py29nhbXyz3tUearcIqUh5WkEhEr5LNiIOv5J6CVW
         RV0A==
X-Gm-Message-State: ABy/qLbJCsOBqHlbM3Qfix5gLgxhIPb+GVLDwutI4fMqQvhp5qI+RJlD
	5GsAO1/ztRWfgx2FXJMqcQii5TUvBOuU6qTUkYUiOKz5rrHVpYBq5PGYOhUxFYs5TDe+ESYIa7b
	30YeZaKu/0apX7Har8FoZohSz
X-Received: by 2002:a05:6214:c85:b0:636:dae2:dc4 with SMTP id r5-20020a0562140c8500b00636dae20dc4mr2274503qvr.5.1689849660738;
        Thu, 20 Jul 2023 03:41:00 -0700 (PDT)
X-Google-Smtp-Source: APBJJlENBVd6sTv0Hb/UYteUxuv+en/vXYUojRYUyFjRmLyKuLVcz4ppKUeGpOR0m+b75R+yR33xCQ==
X-Received: by 2002:a05:6214:c85:b0:636:dae2:dc4 with SMTP id r5-20020a0562140c8500b00636dae20dc4mr2274494qvr.5.1689849660416;
        Thu, 20 Jul 2023 03:41:00 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-170.dyn.eolo.it. [146.241.226.170])
        by smtp.gmail.com with ESMTPSA id j18-20020a0ce012000000b0063596878aaasm251869qvk.18.2023.07.20.03.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 03:41:00 -0700 (PDT)
Message-ID: <dcb23aaea64e5a890dd3c819dd6ba1ab2799dbfd.camel@redhat.com>
Subject: Re: [PATCHv3 net 2/2] team: reset team's flags when down link is
 P2P device
From: Paolo Abeni <pabeni@redhat.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <j.vosburgh@gmail.com>, "David S .
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Eric
 Dumazet <edumazet@google.com>,  Liang Li <liali@redhat.com>, Jiri Pirko
 <jiri@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>
Date: Thu, 20 Jul 2023 12:40:56 +0200
In-Reply-To: <ZLkCXLsf+K6GLS/6@Laptop-X1>
References: <20230718101741.2751799-1-liuhangbin@gmail.com>
	 <20230718101741.2751799-3-liuhangbin@gmail.com>
	 <ca0a159b39c4e1d192d225e96367c2ff7ffae25e.camel@redhat.com>
	 <ZLkCXLsf+K6GLS/6@Laptop-X1>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 2023-07-20 at 17:46 +0800, Hangbin Liu wrote:
> On Thu, Jul 20, 2023 at 10:29:19AM +0200, Paolo Abeni wrote:
> > > +static void team_ether_setup(struct net_device *dev)
> > > +{
> > > +	unsigned int flags =3D dev->flags & IFF_UP;
> > > +
> > > +	ether_setup(dev);
> > > +	dev->flags |=3D flags;
> > > +	dev->priv_flags &=3D ~IFF_TX_SKB_SHARING;
> >=20
> > I think we can't do the above. e.g. ether_setup() sets dev->mtu to
> > ethernet default, while prior to this patch dev inherited mtu from the
> > slaved device. The change may affect the user-space in bad ways.
>=20
> Hi Paolo,
>=20
> I don't see the reason why we should inherited a none ethernet dev's mtu
> to an ethernet dev (i.e. add a none ethernet dev to team, then delete it =
and
> re-add a ethernet dev to team). I think the dev type has changed, so the
> mtu should also be updated.
>=20
> BTW, after adding the port, team will also set port's mtu to team's mtu.

Let suppose the user has set the lower dev MTU to some N (< 1500) for
whatever reason (e.g. lower is a vxlan tunnel). After this change, team
will use mtu =3D 1500 breaking the connectivity in such scenario/

> > I think we just need an 'else' branch in the point2point check above,
> > restoring the bcast/mcast flags as needed.
>=20
> Reset the flags is not enough. All the dev header_ops, type, etc are
> all need to be reset back, that's why we need to call ether_setup().

As far as I can see team_setup_by_port() takes care of that, inheriting
such infor from the current slave. What I mean is something alike the
following.

Cheers,

Paolo

---
diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index 555b0b1e9a78..17c8056adbe9 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -2135,6 +2135,15 @@ static void team_setup_by_port(struct net_device *de=
v,
 	dev->mtu =3D port_dev->mtu;
 	memcpy(dev->broadcast, port_dev->broadcast, port_dev->addr_len);
 	eth_hw_addr_inherit(dev, port_dev);
+
+	if (port_dev->flags & IFF_POINTOPOINT) {
+		dev->flags &=3D ~(IFF_BROADCAST | IFF_MULTICAST);
+		dev->flags |=3D (IFF_POINTOPOINT | IFF_NOARP);
+	} else if ((port_dev->flags & (IFF_BROADCAST | IFF_MULTICAST)) =3D=3D
+		   (IFF_BROADCAST | IFF_MULTICAST)) {
+		dev->flags |=3D IFF_BROADCAST | IFF_MULTICAST;
+		dev->flags &=3D ~(IFF_POINTOPOINT | IFF_NOARP)
+	}
 }
=20
 static int team_dev_type_check_change(struct net_device *dev,



