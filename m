Return-Path: <netdev+bounces-31390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A54F78D5C5
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 14:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B5E71C203BE
	for <lists+netdev@lfdr.de>; Wed, 30 Aug 2023 12:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE47D5394;
	Wed, 30 Aug 2023 12:06:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD67920E2
	for <netdev@vger.kernel.org>; Wed, 30 Aug 2023 12:06:50 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B561B0;
	Wed, 30 Aug 2023 05:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=14UPWfWyHDR8jpQfLIsE1AHR7QeHn2xjLd6uBNjzZCo=; b=xaF4O9l0w8PZ4R8HMjPPUL5QS3
	NMmylAo9FTCzxO0CIC17vgVAdsuaghNDujeTsJKrSUckrU+/O/JMZjQ4C7L9gcyLrEOXwnTBWkbkV
	sPxKXwUzEZvJV0nAwBrggx+8bea5ww83j1zFJZ10/9YS8d+5+MX62C243EHpXXy+GgpenA0Dsk73D
	hQE9xtdHHFw7viB1Z3Rt1WBjXz5EtOw0mojI57/eAljELAoPb+TUfJ2t8xcYM6rpxOLxJ2T2XoLQK
	x0v9GrxyRB3o7Ninp+q9PuMdyIpwKvY/2ICRqMQTEeXQdeWalo5frMqbljJMUEr8zT/vjnTqmLmQI
	+yD7sBCw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54800)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qbJy3-0001Zg-3D;
	Wed, 30 Aug 2023 13:06:40 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qbJy3-0005fa-Am; Wed, 30 Aug 2023 13:06:39 +0100
Date: Wed, 30 Aug 2023 13:06:39 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Radu Pirea (OSS)" <radu-nicolae.pirea@oss.nxp.com>,
	Sabrina Dubroca <sd@queasysnail.net>, hkallweit1@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, richardcochran@gmail.com,
	sebastian.tobuschat@nxp.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next v2 3/5] net: phy: nxp-c45-tja11xx add MACsec
 support
Message-ID: <ZO8wz9KwCbSHATFm@shell.armlinux.org.uk>
References: <20230824091615.191379-1-radu-nicolae.pirea@oss.nxp.com>
 <20230824091615.191379-4-radu-nicolae.pirea@oss.nxp.com>
 <ZOikKUjRvces_vVj@hog>
 <95f66997-c6dd-4bbc-b1ef-dad1e7ed533e@lunn.ch>
 <a1baef3d-ad81-5e10-6b8f-7578b3b8d5b8@oss.nxp.com>
 <e2e26d30-86fb-4005-9a0e-ac9b793df86a@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2e26d30-86fb-4005-9a0e-ac9b793df86a@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 25, 2023 at 03:50:06PM +0200, Andrew Lunn wrote:
> > > > > +static bool nxp_c45_rx_sc_valid(struct nxp_c45_secy *phy_secy,
> > > > > +				struct macsec_rx_sc *rx_sc)
> > > > > +{
> > > > > +	u16 port =  (__force u64)rx_sc->sci >> (ETH_ALEN * 8);
> > > > 
> > > > u64 sci = be64_to_cpu((__force __be64)rx_sc->sci);
> > > 
> > > why is the __force needed? What happens with a normal cast?
> > > 
> > 
> > Sparse will print warnings if __force is missing.
> 
> What is the warning? I just want to make sure __force is the correct
> solution, not that something has the wrong type and we should be
> fixing a design issue.

Hi Andrew,

rx_sc->sci is sci_t, which is defined as:

typedef u64 __bitwise sci_t;

Sparse documentation (Documentation/dev-tools/sparse.rst) states that:

  "__bitwise" is a type attribute, so you have to do something like this::
...
  which makes PM_SUSPEND and PM_RESUME "bitwise" integers (the "__force"
  is there because sparse will complain about casting to/from a bitwise
  type, but in this case we really _do_ want to force the conversion).

So basically, sci is a bitwise type, which means sparse gives it
special properties that ensures it can only be operated on using
similarly typed integers.

So, those __force casts are needed to convert sci to something else.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

