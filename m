Return-Path: <netdev+bounces-32829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D46279A821
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 15:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75B701C2088C
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 13:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333D3F9F9;
	Mon, 11 Sep 2023 13:05:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233B5C2CA
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 13:05:53 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A393DF;
	Mon, 11 Sep 2023 06:05:48 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 38CEF60004;
	Mon, 11 Sep 2023 13:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1694437547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VwIYsqLUnY+qjK/+Si2acqNJrj9pOQtmxP0WNxCQT64=;
	b=Ju0jNKa1DfjDdVEOGca+OtlrWcjg+2BqJgRZfn753HkWcFLYPaMRZ9UrsphyjWn7y9ilq/
	0cYvAlkrdvSgMcTL/nzM3sf2bTQYX7eDhiG1C5SzJwgbG7aSiQcaWh7DbrCqFJRpnlBioF
	7p4LtAslZ7f+HFKBmo/1PxXQ9hzszvl1JrS2xCAwYYl5dEahVISzosQ2OUKCX0zxaFbWEO
	8RoSx6QHHC/INgrZ30TgPi3NfpqktifbI3l+l26VZcbF4lzNtLVLvbpnIPo0lRv5rkgw+V
	w4sFFmiebQIBk04mvmWtVqtav85esJQn1nwNxDH8MefDomRLV1fHk0i2YEeCLQ==
Date: Mon, 11 Sep 2023 15:05:44 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Lunn
 <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Florian Fainelli <f.fainelli@gmail.com>, Heiner
 Kallweit <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Oleksij Rempel <linux@rempel-privat.de>, =?UTF-8?B?Tmljb2zDsg==?= Veronese
 <nicveronese@gmail.com>, thomas.petazzoni@bootlin.com, Christophe Leroy
 <christophe.leroy@csgroup.eu>
Subject: Re: [RFC PATCH net-next 1/7] net: phy: introduce phy numbering and
 phy namespaces
Message-ID: <20230911150544.5304e763@fedora>
In-Reply-To: <20230908083608.4f01bf2c@kernel.org>
References: <20230907092407.647139-1-maxime.chevallier@bootlin.com>
	<20230907092407.647139-2-maxime.chevallier@bootlin.com>
	<ZPmicItKuANpu93w@shell.armlinux.org.uk>
	<20230907141904.1be84216@pc-7.home>
	<20230908083608.4f01bf2c@kernel.org>
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

Hello Jakub,

On Fri, 8 Sep 2023 08:36:08 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Thu, 7 Sep 2023 14:19:04 +0200 Maxime Chevallier wrote:
> > > I think you can simplify this code quite a bit by using idr.
> > > idr_alloc_cyclic() looks like it will do the allocation you want,
> > > plus the IDR subsystem will store the pointer to the object (in
> > > this case the phy device) and allow you to look that up. That
> > > probably gets rid of quite a bit of code.
> > > 
> > > You will need to handle the locking around IDR however.    
> > 
> > Oh thanks for pointing this out. I had considered idr but I didn't spot
> > the _cyclic() helper, and I had ruled that out thinking it would re-use
> > ids directly after freeing them. I'll be more than happy to use that.  
> 
> Perhaps use xarray directly, I don't think we need the @base offset or
> quick access to @next which AFAICT is the only reason one would prefer
> IDR?

Oh indeed xa_alloc_cyclic looks to fit perfectly, thanks !

Maxime

