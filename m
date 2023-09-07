Return-Path: <netdev+bounces-32390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4764C7973A2
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 17:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E69C1C20BBC
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 15:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A64D125C6;
	Thu,  7 Sep 2023 15:29:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF4E29B4
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 15:29:09 +0000 (UTC)
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE274CA;
	Thu,  7 Sep 2023 08:28:42 -0700 (PDT)
Received: from relay3-d.mail.gandi.net (unknown [217.70.183.195])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id C0ECBCF83F;
	Thu,  7 Sep 2023 12:20:29 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id EAF1360002;
	Thu,  7 Sep 2023 12:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1694089208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JMIxgcqQLFA1Dd5kyFbxEHu6hstdO8nu7zHeGXeALaA=;
	b=URJWNqtWN3BykyhzJV3wJxdqspNgMYK52/gu6V+TpGvxvWYO3MawObSrJQIhXzgzdczVQT
	sEYuPVuTWb5+TUwezhlklVb5E0fPQo5bkkJXqqMcd481me24ItoyjLZdXfUEPFqvYVNpY9
	dVZyJO5zAx7nuvbB6ROez6xyFn4gcrqzxEBZnGAtyn068wSqADWntf0ZWkwPj/jrfk/VXM
	vxAjwV195uR72PLrFAof8FOBCpHIW5LovnkPOXAFIak5RKzWM4wYsz8grcIVJT962cPnSp
	GVQKDVDRKOAu/wRPXHTocnGH20BGDUtoLhKs9zAsH+0c/quJx1D39kgMU13X9Q==
Date: Thu, 7 Sep 2023 14:20:05 +0200
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
Subject: Re: [RFC PATCH net-next 6/7] net: ethtool: add a netlink command to
 get PHY information
Message-ID: <20230907142005.058383b8@pc-7.home>
In-Reply-To: <ZPmgSFVp8+hou3QT@shell.armlinux.org.uk>
References: <20230907092407.647139-1-maxime.chevallier@bootlin.com>
	<20230907092407.647139-7-maxime.chevallier@bootlin.com>
	<ZPmgSFVp8+hou3QT@shell.armlinux.org.uk>
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

Hello Russell,

On Thu, 7 Sep 2023 11:04:56 +0100
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Thu, Sep 07, 2023 at 11:24:04AM +0200, Maxime Chevallier wrote:
> > +	data->phyindex = req_info->phyindex;
> > +	data->drvname = phydev->drv->name;
> > +	if (phydev->is_on_sfp_module)  
> 
> Please use the accessor provided:
> 
> 	if (phy_on_sfp(phydev))

Ack, I'll switch to that then.

Thanks,

Maxime



