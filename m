Return-Path: <netdev+bounces-32138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8782792FFA
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 22:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 633BC1C209A4
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 20:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C17ADF5A;
	Tue,  5 Sep 2023 20:30:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D42ADF54
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 20:30:00 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C5D8E
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 13:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uDkWuZyMLQMnIq2qZJd/Hy90Ye3IhmwIA0hr/2LJ+ug=; b=5XzonQHNYRXjlxkiRpjlBlBpk3
	Vfh9x4U7GSagm0sjkbzCGReY9lN0HhN1Jf1Jk//j7v66pgPl4dwXUnfOpjhh1F8KlyQDyKmLiYsD3
	KKyFJOctF3dR0Rf53UnGXXiosJQjub4toDwOX+3j5z39PJKspdhVhmk+x/bzHDWzHPuI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qdcgJ-005pOC-5Z; Tue, 05 Sep 2023 22:29:51 +0200
Date: Tue, 5 Sep 2023 22:29:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	netdev@vger.kernel.org, glipus@gmail.com,
	maxime.chevallier@bootlin.com, vadim.fedorenko@linux.dev,
	gerhard@engleder-embedded.com, thomas.petazzoni@bootlin.com,
	krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Subject: Re: [PATCH net-next RFC v4 2/5] net: Expose available time stamping
 layers to user space.
Message-ID: <8fd9f2bc-f8a2-4290-8e52-17a39175b3d7@lunn.ch>
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
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905114717.4a166f79@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> Maybe we should try to enumerate the use cases, I don't remember now
> but I think the concern was that there may be multiple PHYs?

You often see a Marvell 10G PHY between a MAC and an SFP cage. You can
then get a copper SFP module which has a PHY in it.

So:

"Linux" NIC: [DMA MAC][PHY][PHY] 

And just to make it more interesting, you sometimes see:

[MAC] - MII MUX -+---[PHY][PHY]
                 |
                 +---[PHY]

This is currently not supported, but there is work in progress to
address this, by giving each PHY and ID, and extending the netlink
ethtool so you can enumerate PHYs and individually configure them.

And i pointed out maybe the worst case scenario:

[MAC][PHY][PHY][MAC]switch core[MAC][PHY][PHY]

	Andrew

