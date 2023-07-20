Return-Path: <netdev+bounces-19372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA45775A94B
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 10:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA2901C21310
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 08:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F11174CF;
	Thu, 20 Jul 2023 08:29:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8337F443A
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 08:29:27 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23063FD
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 01:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689841765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XfRLnC0isZNT4bSSTAC1X7lhBSBqQr9IKm6um/AEVDg=;
	b=e3jTgjljnodlSw+kxNJw5XNrVRavzJYR51mbysBeplkGIG1I/PWlGvAqaCQzbKM5NAVIC8
	lmNjYYDQTdb/mEx+ahr6vIwHNXu355Ykk/q240TDK3igCmSquHK28XFAT6fBxhhw2mg5ZK
	hv5rJyTtG4hm/egGanKXmoSsK4uWI1w=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-ABsvGxn7OCiMz-ijsggJYQ-1; Thu, 20 Jul 2023 04:29:24 -0400
X-MC-Unique: ABsvGxn7OCiMz-ijsggJYQ-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-767b80384a3so14992985a.0
        for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 01:29:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689841763; x=1690446563;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XfRLnC0isZNT4bSSTAC1X7lhBSBqQr9IKm6um/AEVDg=;
        b=LwUoy0E9/KGE54+spqIMsd12NDfmU7fKZOf5cmBxYYuFXnU0rJNVYBhd+r92/tSNuU
         1oUSYhWLaCIzpI87aLvnv0HUKBtmS1R9GmsVYYbbh750FkcQbN9RdysOZNzi84RsgeJj
         TXq4Nnk8//Sjm4kZhKpMdzZoorW7gzu0pGDuM1PYFnArOCYdZaB3uZ50HtcZXstiYsdT
         6Glga6PaoF7qRo3csoKz1XTCRhs4CnWSgstkzU9fuZHf3HMEprkEAIjJHddvxR6HVfb9
         nHpVVRieCqJbIz+tXBrYGAMsmI5ZJyEg6RrdzvIr4o9jFDs9TTh6UEgYttEjD78sjHN7
         uWsQ==
X-Gm-Message-State: ABy/qLbq/lyE9voVenKzk76qayNASG5BNZwbF1z8eo1NN3qNayCROegG
	SJs2DEjz208UyvgRIvNvaEv5yug64OM8j1wMN34EWJLw9Et0eCCW9mRd2sCjFx383W8gDRgYt3y
	QjJjONgtkQFnLLSoLqXxx78ja
X-Received: by 2002:a05:620a:c50:b0:767:f178:b517 with SMTP id u16-20020a05620a0c5000b00767f178b517mr2546911qki.0.1689841763451;
        Thu, 20 Jul 2023 01:29:23 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGgKg6p1SchSmwfu0+JbD5tbPCZeetHE/imSKJN8mQUsbzLtvoPuMnRja792ehe8j+WX2BBcQ==
X-Received: by 2002:a05:620a:c50:b0:767:f178:b517 with SMTP id u16-20020a05620a0c5000b00767f178b517mr2546901qki.0.1689841763196;
        Thu, 20 Jul 2023 01:29:23 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-170.dyn.eolo.it. [146.241.226.170])
        by smtp.gmail.com with ESMTPSA id p12-20020ae9f30c000000b00767e1c593acsm87923qkg.79.2023.07.20.01.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 01:29:22 -0700 (PDT)
Message-ID: <ca0a159b39c4e1d192d225e96367c2ff7ffae25e.camel@redhat.com>
Subject: Re: [PATCHv3 net 2/2] team: reset team's flags when down link is
 P2P device
From: Paolo Abeni <pabeni@redhat.com>
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Liang Li <liali@redhat.com>, Jiri Pirko
 <jiri@nvidia.com>,  Nikolay Aleksandrov <razor@blackwall.org>
Date: Thu, 20 Jul 2023 10:29:19 +0200
In-Reply-To: <20230718101741.2751799-3-liuhangbin@gmail.com>
References: <20230718101741.2751799-1-liuhangbin@gmail.com>
	 <20230718101741.2751799-3-liuhangbin@gmail.com>
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

On Tue, 2023-07-18 at 18:17 +0800, Hangbin Liu wrote:
> When adding a point to point downlink to team device, we neglected to res=
et
> the team's flags, which were still using flags like BROADCAST and
> MULTICAST. Consequently, this would initiate ARP/DAD for P2P downlink
> interfaces, such as when adding a GRE device to team device. Fix this by
> remove multicast/broadcast flags and add p2p and noarp flags.
>=20
> After removing the none ethernet interface and adding an ethernet interfa=
ce
> to team, we need to reset team interface flags and hw address back. Unlik=
e
> bonding interface, team do not need restore IFF_MASTER, IFF_SLAVE flags.
>=20
> Reported-by: Liang Li <liali@redhat.com>
> Closes: https://bugzilla.redhat.com/show_bug.cgi?id=3D2221438
> Fixes: 1d76efe1577b ("team: add support for non-ethernet devices")
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
> v3: add function team_ether_setup to reset team back to ethernet.
> v2: Add the missed {} after if checking.
> ---
>  drivers/net/team/team.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
> index 555b0b1e9a78..2e124a3b81d1 100644
> --- a/drivers/net/team/team.c
> +++ b/drivers/net/team/team.c
> @@ -2135,6 +2135,20 @@ static void team_setup_by_port(struct net_device *=
dev,
>  	dev->mtu =3D port_dev->mtu;
>  	memcpy(dev->broadcast, port_dev->broadcast, port_dev->addr_len);
>  	eth_hw_addr_inherit(dev, port_dev);
> +
> +	if (port_dev->flags & IFF_POINTOPOINT) {
> +		dev->flags &=3D ~(IFF_BROADCAST | IFF_MULTICAST);
> +		dev->flags |=3D (IFF_POINTOPOINT | IFF_NOARP);
> +	}
> +}
> +
> +static void team_ether_setup(struct net_device *dev)
> +{
> +	unsigned int flags =3D dev->flags & IFF_UP;
> +
> +	ether_setup(dev);
> +	dev->flags |=3D flags;
> +	dev->priv_flags &=3D ~IFF_TX_SKB_SHARING;

I think we can't do the above. e.g. ether_setup() sets dev->mtu to
ethernet default, while prior to this patch dev inherited mtu from the
slaved device. The change may affect the user-space in bad ways.

I think we just need an 'else' branch in the point2point check above,
restoring the bcast/mcast flags as needed.

Yes, we have slightly different behaviours between bond and team, but
we can't change that easily.

Cheers,

Paolo


