Return-Path: <netdev+bounces-31746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A05F578FEA8
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 15:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64156281B11
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 13:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A7CBE69;
	Fri,  1 Sep 2023 13:56:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1177EBE66
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 13:56:36 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7DC10EB
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 06:56:35 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-22-pkRJQVBBP3OykYT9LU4nRQ-1; Fri, 01 Sep 2023 09:56:31 -0400
X-MC-Unique: pkRJQVBBP3OykYT9LU4nRQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4DCB8920282;
	Fri,  1 Sep 2023 13:56:25 +0000 (UTC)
Received: from hog (unknown [10.45.224.12])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3CFD821D4F3D;
	Fri,  1 Sep 2023 13:56:22 +0000 (UTC)
Date: Fri, 1 Sep 2023 15:56:20 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Radu Pirea <radu-nicolae.pirea@nxp.com>,
	"atenart@kernel.org" <atenart@kernel.org>,
	"Radu-nicolae Pirea (OSS)" <radu-nicolae.pirea@oss.nxp.com>,
	"andrew@lunn.ch" <andrew@lunn.ch>,
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
Message-ID: <ZPHthKXGKwcyBARo@hog>
References: <20230824091615.191379-1-radu-nicolae.pirea@oss.nxp.com>
 <20230824091615.191379-6-radu-nicolae.pirea@oss.nxp.com>
 <ZOx0L722xg5-J_he@hog>
 <5d42d6c9-2f0c-8913-49ec-50a25860c49f@oss.nxp.com>
 <ZO8pbtnlOVauabjC@hog>
 <518c11e9000f895fddb5b3dc4d5b2bf445cf320f.camel@nxp.com>
 <ZPG35HfRseiv80Pb@hog>
 <ZPG9s1LDbphnBHUE@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZPG9s1LDbphnBHUE@shell.armlinux.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

2023-09-01, 11:32:19 +0100, Russell King (Oracle) wrote:
> On Fri, Sep 01, 2023 at 12:07:32PM +0200, Sabrina Dubroca wrote:
> > 2023-09-01, 09:09:06 +0000, Radu Pirea wrote:
> > > We can do a flush very simple, but to restore the configuration maybe
> > > we should to save the key in the macsec_key structure. I am not sure if
> > > the key can be extracted from crypto_aead structure.
> > 
> > Either that or in the driver. I have a small preference for driver,
> > because then cases that don't need this restore won't have to keep the
> > key in memory, reducing the likelihood of accidentally sharing it.
> > OTOH, if we centralize that code, it's easier to make sure everything
> > is cleared from kernel memory when we delete the SA.
> 
> Maybe consider about doing it as a library function, so drivers that
> need this don't have to reimplement the functionality in randomly
> buggy ways?

But then the driver would depend on the macsec module, right? It's not
a large module, but that seems a bit undesirable.

I think I'd rather add the key to macsec_key, and only copy it there
in case we're offloading (we currently don't allow enabling offloading
after installing some SAs/keys so that would be fine). Maybe add a
driver flag to request keeping the keys in memory (I don't know if all
drivers will require that -- seems like all PHY drivers would, but what
about the MAC ones?).

-- 
Sabrina


