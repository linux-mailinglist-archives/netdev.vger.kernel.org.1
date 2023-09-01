Return-Path: <netdev+bounces-31760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BFE790005
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 17:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FAB22817DB
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 15:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313CEC12F;
	Fri,  1 Sep 2023 15:38:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223EE23BF
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 15:38:08 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFEC10E0
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 08:38:07 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-250-_sMitSrMPp-aigNXGlT-DA-1; Fri, 01 Sep 2023 11:38:03 -0400
X-MC-Unique: _sMitSrMPp-aigNXGlT-DA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DEA99805C10;
	Fri,  1 Sep 2023 15:38:02 +0000 (UTC)
Received: from hog (unknown [10.45.224.12])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E81EAD4781C;
	Fri,  1 Sep 2023 15:38:00 +0000 (UTC)
Date: Fri, 1 Sep 2023 17:37:59 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: "Radu Pirea (OSS)" <radu-nicolae.pirea@oss.nxp.com>
Cc: "atenart@kernel.org" <atenart@kernel.org>,
	"andrew@lunn.ch" <andrew@lunn.ch>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	Sebastian Tobuschat <sebastian.tobuschat@nxp.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [RFC net-next v2 5/5] net: phy: nxp-c45-tja11xx: implement
 mdo_insert_tx_tag
Message-ID: <ZPIFV7aFjxJqkmN1@hog>
References: <20230824091615.191379-1-radu-nicolae.pirea@oss.nxp.com>
 <20230824091615.191379-6-radu-nicolae.pirea@oss.nxp.com>
 <ZOx0L722xg5-J_he@hog>
 <5d42d6c9-2f0c-8913-49ec-50a25860c49f@oss.nxp.com>
 <ZO8pbtnlOVauabjC@hog>
 <518c11e9000f895fddb5b3dc4d5b2bf445cf320f.camel@nxp.com>
 <ZPG35HfRseiv80Pb@hog>
 <831bc700-a9a2-7eda-e97b-e1d54dc806f9@oss.nxp.com>
 <ZPHt1vgPzayHfu-z@hog>
 <ba7e5fbb-126f-8240-4784-e8e25e53b8f0@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ba7e5fbb-126f-8240-4784-e8e25e53b8f0@oss.nxp.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

2023-09-01, 17:22:49 +0300, Radu Pirea (OSS) wrote:
> 
> 
> On 01.09.2023 16:57, Sabrina Dubroca wrote:
> > 2023-09-01, 14:58:12 +0300, Radu Pirea (OSS) wrote:
> > > On 01.09.2023 13:07, Sabrina Dubroca wrote:
> > > > > (the interface was up before)
> > > > > [root@alarm ~]# ip link add link end0 macsec0 type macsec encrypt on
> > > > > offload phy
> > > > > [root@alarm ~]# ip link set end0 down
> > > > > [root@alarm ~]# ip macsec add macsec0 rx port 1 address
> > > > > 00:01:be:be:ef:33
> > > > > RTNETLINK answers: Operation not supported
> > > > 
> > > > Where does that EOPNOTSUPP come from? nxp_c45_mdo_add_rxsc from this
> > > > version of the code can't return that, and macsec_add_rxsc also
> > > > shouldn't at this point.
> > > 
> > > This is the source of -EOPNOTSUPP
> > > https://elixir.bootlin.com/linux/latest/source/drivers/net/macsec.c#L1928
> > 
> > Could you check which part of macsec_get_ops is failing? Since
> > macsec_newlink with "offload phy" worked, macsec_check_offload
> > shouldn't fail, so why does macsec_get_ops return NULL?
> > real_dev->phydev was NULL'ed?
> 
> This check logical and returns false:
> https://elixir.bootlin.com/linux/latest/source/drivers/net/macsec.c#L343
> 
> real_dev->phydev was nulled.
> The call stack is next:
> fec_enet_close -> phy_disconnect -> phy_detach ->
> https://elixir.bootlin.com/linux/latest/source/drivers/net/phy/phy_device.c#L1815

Ok, thanks for looking this up. So we can't have a consistent behavior
between SW and PHY modes unfortunately.

-- 
Sabrina


