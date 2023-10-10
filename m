Return-Path: <netdev+bounces-39450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9951C7BF48E
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 09:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B299B1C20A45
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 07:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB66AFBEA;
	Tue, 10 Oct 2023 07:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kjM9mNev"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAC3D2F2
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 07:40:39 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763B192;
	Tue, 10 Oct 2023 00:40:36 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id DD85424000E;
	Tue, 10 Oct 2023 07:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1696923634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z5mbSaDFWT4F1pg9/UQXeQubE+UDM5n2XaAROADfaZ8=;
	b=kjM9mNev2AShbfug3CIC1p9m8VPnj9VN7bck6ZwquYIEqgJR4gpvuw2KTym4bvC8IyW+OK
	sDxtdebTx/AyoV75d9kTHd7RSZhDV7SBhI6M4U+0Qx3l36ZpW1PSg22etM0QTtyoWqRNom
	sDrS+jVE/LU8phy9/GEr/0Q/Q1XVyfko1wgpc1AIJ1USRwz1Y5qmNMdOhIL12MC2dFcalb
	+11WLE8TRR/kgj3agsoSyCrRTMRWY4X2/l74Rc6g8nfo91SrYBhWsrYn580bKwXfpEHI3i
	1U4ucR8u+igLPRt+X1CruJfne4fZ8pySUkM133/aiQ75wr1PDOJKLmZ0ZvFTug==
Date: Tue, 10 Oct 2023 09:40:28 +0200
From: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Jay Vosburgh
 <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Florian Fainelli
 <florian.fainelli@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Richard Cochran <richardcochran@gmail.com>, Radu
 Pirea <radu-nicolae.pirea@oss.nxp.com>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Michael Walle <michael@walle.cc>, Jacob Keller
 <jacob.e.keller@intel.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v5 05/16] net: Make dev_set_hwtstamp_phylib
 accessible
Message-ID: <20231010094028.74185a50@kmaincent-XPS-13-7390>
In-Reply-To: <57791a7d-04ce-4d02-815d-7f540ea15b89@gmail.com>
References: <20231009155138.86458-1-kory.maincent@bootlin.com>
	<20231009155138.86458-6-kory.maincent@bootlin.com>
	<57791a7d-04ce-4d02-815d-7f540ea15b89@gmail.com>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 9 Oct 2023 14:09:29 -0700
Florian Fainelli <f.fainelli@gmail.com> wrote:

> > -static int dev_set_hwtstamp_phylib(struct net_device *dev,
> > -				   struct kernel_hwtstamp_config *cfg,
> > -				   struct netlink_ext_ack *extack)
> > +int dev_set_hwtstamp_phylib(struct net_device *dev,
> > +			    struct kernel_hwtstamp_config *cfg,
> > +			    struct netlink_ext_ack *extack)
> >   {
> >   	const struct net_device_ops *ops = dev->netdev_ops;
> >   	bool phy_ts = phy_has_hwtstamp(dev->phydev);  
> 
> Missing EXPORT_SYMBOL_GPL() here?

True. Will be fixed in next version.

