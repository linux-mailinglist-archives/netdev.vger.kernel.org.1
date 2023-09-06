Return-Path: <netdev+bounces-32208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 364F47937FC
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 11:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB56E2812DE
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 09:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F511378;
	Wed,  6 Sep 2023 09:22:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D6A1C3A
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 09:22:08 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C9CCC2
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 02:22:07 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 63C91C000D;
	Wed,  6 Sep 2023 09:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1693992125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kKtd7U0prdwB9BH+FffDN+/r29akSXqYo1S+FI1cevM=;
	b=I2HCpgCw2NKssgFwLrq7H+e0A2FER1MfHQlpxbEnGo1M9b913n1Sz2vPbigmsXGZ6xq4I7
	CklOXqa8GeT5tDfJOn19NmoleWMHqjtEpL8yNic/OPtpbZSnlmWuphvBK01wOi2UMpEYAl
	OAKvp+puRX98asK6wBgxH2BSztC7LPcr5/IZ/TORj74NJ0mXwLr0zYv0VGapiwCr5dC0C4
	+Ax7PckEgK3n2SHdc2N+EXZAwd/FzXBkpl8SbH9wlOKNnBBO26qDEmxmjpzEpL0qNhcY/t
	ArB1H9QQKKHKWK7at4vXicCzyobGRkiBYsF5a/ku0fqkJrzNc+7mdFscXtA27w==
Date: Wed, 6 Sep 2023 11:22:03 +0200
From: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, Richard Cochran
 <richardcochran@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 "Russell King (Oracle)" <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 glipus@gmail.com, maxime.chevallier@bootlin.com, vadim.fedorenko@linux.dev,
 gerhard@engleder-embedded.com, thomas.petazzoni@bootlin.com,
 krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Subject: Re: [PATCH net-next RFC v4 2/5] net: Expose available time stamping
 layers to user space.
Message-ID: <20230906112203.4ea69bf8@kmaincent-XPS-13-7390>
In-Reply-To: <8fd9f2bc-f8a2-4290-8e52-17a39175b3d7@lunn.ch>
References: <20230511230717.hg7gtrq5ppvuzmcx@skbuf>
	<20230511161625.2e3f0161@kernel.org>
	<20230512102911.qnosuqnzwbmlupg6@skbuf>
	<20230512103852.64fd608b@kernel.org>
	<20230517121925.518473aa@kernel.org>
	<2f89e35e-b1c9-4e08-9f60-73a96cc6e51a@lunn.ch>
	<20230517130706.3432203b@kernel.org>
	<20230904172245.1fa149fd@kmaincent-XPS-13-7390>
	<ZPYYFFxhALYnmXrx@hoboy.vegasvil.org>
	<20230905114717.4a166f79@kernel.org>
	<8fd9f2bc-f8a2-4290-8e52-17a39175b3d7@lunn.ch>
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
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 5 Sep 2023 22:29:51 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> > Maybe we should try to enumerate the use cases, I don't remember now
> > but I think the concern was that there may be multiple PHYs?  
> 
> You often see a Marvell 10G PHY between a MAC and an SFP cage. You can
> then get a copper SFP module which has a PHY in it.
> 
> So:
> 
> "Linux" NIC: [DMA MAC][PHY][PHY] 
> 
> And just to make it more interesting, you sometimes see:
> 
> [MAC] - MII MUX -+---[PHY][PHY]
>                  |
>                  +---[PHY]
> 
> This is currently not supported, but there is work in progress to
> address this, by giving each PHY and ID, and extending the netlink
> ethtool so you can enumerate PHYs and individually configure them.

Yes, I have talked to maxime about his PHY ID support patch series.

> And i pointed out maybe the worst case scenario:
> 
> [MAC][PHY][PHY][MAC]switch core[MAC][PHY][PHY]

always more complex! :)

