Return-Path: <netdev+bounces-32389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F927973A0
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 17:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABAA028165A
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 15:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7661F125D1;
	Thu,  7 Sep 2023 15:28:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE8F12B67
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 15:28:50 +0000 (UTC)
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42FC1FD2;
	Thu,  7 Sep 2023 08:28:26 -0700 (PDT)
Received: from relay4-d.mail.gandi.net (unknown [217.70.183.196])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id C78CCCECB4;
	Thu,  7 Sep 2023 12:17:00 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0A117E0014;
	Thu,  7 Sep 2023 12:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1694089000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eS0v+VHUqtxVc+8EW+fjSWrwzAlhi5oKaoIMevibDZ0=;
	b=KAqGlJaXSIaZnrnz9oXNudMAE5iHcxC9BzVRFnvhJOErcm1AX/IBpE/sgmEmXiQARYcghU
	GnVXquFWR0YTKisVkAWoJyIMZ9R2cE4BXdrrO/H+VZ79joIqcX3GtPmkEBNfuwWDKP0xGg
	45UcPlexSUbur2WUWfdGCWcaBVeyfRcpvI/blfJC5PEUxsRJflcpWj4qeGd2V2HnSygHgC
	YMckGmXObOnDS4CG6FPYMvBmIDvjRYs95n9VRFoXi6MoKD6KTjfV8ZUUmiFoWBNkexyubP
	rkTxi1yhRsBQsves4FNJriZ1ZbYdWhyHmKN9UbYhuPlRKFt1P3lFAxYpob/jew==
Date: Thu, 7 Sep 2023 14:16:35 +0200
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
Subject: Re: [RFC PATCH net-next 4/7] net: ethtool: add a netlink command to
 list PHYs
Message-ID: <20230907141635.20bcaa59@pc-7.home>
In-Reply-To: <ZPmfOOsqoO02AcBH@shell.armlinux.org.uk>
References: <20230907092407.647139-1-maxime.chevallier@bootlin.com>
	<20230907092407.647139-5-maxime.chevallier@bootlin.com>
	<ZPmfOOsqoO02AcBH@shell.armlinux.org.uk>
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

On Thu, 7 Sep 2023 11:00:24 +0100
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Thu, Sep 07, 2023 at 11:24:02AM +0200, Maxime Chevallier wrote:
> > +#define PHY_MAX_ENTRIES	16
> > +
> > +struct phy_list_reply_data {
> > +	struct ethnl_reply_data		base;
> > +	u8 n_phys;
> > +	u32 phy_indices[PHY_MAX_ENTRIES];  
> 
> Please could you detail the decision making behind 16 entries - is this
> arbitary or based on something?
> 
> Also, please consider what we should do if we happen to have more than
> 16 entries.

Ah indeed it was totally arbitrary, the idea was to have a fixed-size
reply struct, so that we can populate the
ethnl_request_ops.reply_data_size field and not do any manual memory
management. But I can store a pointer to the array of phy devices,
dynamically allocated and we won't have to deal with this fixed,
arbitrary-sized array anymore.

Sorry for not documenting this.

> Finally, using u8 before an array of u32 can leave 3 bytes of padding.
> It would be better to use u32 for n_phys to avoid that padding.

Sure thing, I'll change this

> > +	mutex_lock(&phy_ns->ns_lock);
> > +	list_for_each_entry(phydev, &phy_ns->phys, node)
> > +		data->phy_indices[data->n_phys++] = phydev->phyindex;  
> 
> I think this loop should limit its iterations to ensure that the
> array can't overflow.

Thanks,

Maxime



