Return-Path: <netdev+bounces-32405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 619707974DC
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 17:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F40428172B
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 15:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02BD12B7A;
	Thu,  7 Sep 2023 15:42:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A476128E7
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 15:42:03 +0000 (UTC)
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162BB61B1;
	Thu,  7 Sep 2023 08:41:42 -0700 (PDT)
Received: from relay4-d.mail.gandi.net (unknown [217.70.183.196])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 8EDAFCE1CF;
	Thu,  7 Sep 2023 12:19:28 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 56519E0018;
	Thu,  7 Sep 2023 12:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1694089147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2N1ajiY5KFcTcBjiKJ+b+1rY6w1VBl45Vs0Qtl5rCco=;
	b=RsvtL+yG2/Cp2hr9aB3pAsHlrn1n6qzZhI1Yw9cBvE7c4VteysSW9VEtAfXY+ZApj+y1lF
	WDwh+E1O4kpBI8VKMimgdnW9UocKjj8sAYD7fk3YuWOFg3krmpcJ6F00jmxy/pqmBivUos
	UN3o30WQIcMN+YpgQCio9u7UFqgmqJtsQPTzTJI3czpIo6vpN1sNdg9Km74pY1OZYlKpSt
	pGsFF73lfOOMswO3mnEyszRHWAPIR80PyIOb6YyYPkXcTSemW8WpKYZso8e1RgfUkCZOxn
	H0dz9/wylwMudWzqB89qqbS+2NZhDIXlhazVminJhm5+VlbGNt1zrX9JB6BJ5Q==
Date: Thu, 7 Sep 2023 14:19:04 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Heiner
 Kallweit <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Oleksij Rempel <linux@rempel-privat.de>, =?UTF-8?B?Tmljb2zDsg==?= Veronese
 <nicveronese@gmail.com>, thomas.petazzoni@bootlin.com, Christophe Leroy
 <christophe.leroy@csgroup.eu>
Subject: Re: [RFC PATCH net-next 1/7] net: phy: introduce phy numbering and
 phy namespaces
Message-ID: <20230907141904.1be84216@pc-7.home>
In-Reply-To: <ZPmicItKuANpu93w@shell.armlinux.org.uk>
References: <20230907092407.647139-1-maxime.chevallier@bootlin.com>
	<20230907092407.647139-2-maxime.chevallier@bootlin.com>
	<ZPmicItKuANpu93w@shell.armlinux.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 7 Sep 2023 11:14:08 +0100
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Thu, Sep 07, 2023 at 11:23:59AM +0200, Maxime Chevallier wrote:
> > Link topologies containing multiple network PHYs attached to the same
> > net_device can be found when using a PHY as a media converter for use
> > with an SFP connector, on which an SFP transceiver containing a PHY can
> > be used.
> > 
> > With the current model, the transceiver's PHY can't be used for
> > operations such as cable testing, timestamping, macsec offload, etc.
> > 
> > The reason being that most of the logic for these configuration, coming
> > from either ethtool netlink or ioctls tend to use netdev->phydev, which
> > in multi-phy systems will reference the PHY closest to the MAC.
> > 
> > Introduce a numbering scheme allowing to enumerate PHY devices that
> > belong to any netdev, which can in turn allow userspace to take more
> > precise decisions with regard to each PHY's configuration.
> > 
> > The numbering is maintained per-netdev, hence the notion of PHY
> > namespaces. The numbering works similarly to a netdevice's ifindex, with
> > identifiers that are only recycled once INT_MAX has been reached.
> > 
> > This prevents races that could occur between PHY listing and SFP
> > transceiver removal/insertion.
> > 
> > The identifiers are assigned at phy_attach time, as the numbering
> > depends on the netdevice the phy is attached to.  
> 
> I think you can simplify this code quite a bit by using idr.
> idr_alloc_cyclic() looks like it will do the allocation you want,
> plus the IDR subsystem will store the pointer to the object (in
> this case the phy device) and allow you to look that up. That
> probably gets rid of quite a bit of code.
> 
> You will need to handle the locking around IDR however.

Oh thanks for pointing this out. I had considered idr but I didn't spot
the _cyclic() helper, and I had ruled that out thinking it would re-use
ids directly after freeing them. I'll be more than happy to use that.

Thanks,

Maxime



