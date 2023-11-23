Return-Path: <netdev+bounces-50529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B5A7F60A5
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 14:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D09D281DBB
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 13:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952A725112;
	Thu, 23 Nov 2023 13:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mvaQaAVe"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7991A8;
	Thu, 23 Nov 2023 05:44:44 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 74C05FF809;
	Thu, 23 Nov 2023 13:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1700747083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0SVq2leikZhcuCjNPEWn24EXcg6OrcejWDGU6KH+wxM=;
	b=mvaQaAVeQHUqaxhEpF9xDBXjfaTza5gX4dMJ4I+oveEwmyblCHlO+NLkLLgUkGqO1/nABi
	V7vmvqknl5evqx2MOFldGWYujGyXGsdIvEzCegf447ii9fp7S3RoXdz1ok0gaQGOslqNci
	cCFqr7l1UMvWF4rN/mgyg0S7FLbjEx1afEmEEH6HB3DdXgBcpM6Ws+JVK7bfoATzkBNWdM
	/dA9wIJtkgrA0Icm2nuCzuZS8cvvZ+a2lDo7XLnutYpeYkA2Lf8LhAsu8WX9qDyGC2tgBt
	bD9pwJj+SoYUcjmNZxDG6CpEdUIjbta9IDrsYXTG0trxq+wx7gvZ9W1KW/duYw==
Date: Thu, 23 Nov 2023 14:44:41 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>
Subject: Re: [RFC PATCH net-next v2 01/10] net: phy: Introduce ethernet link
 topology representation
Message-ID: <20231123144441.3d73bf51@device.home>
In-Reply-To: <9079c9f5-5531-4c38-b9c9-975ed3d96104@lunn.ch>
References: <20231117162323.626979-1-maxime.chevallier@bootlin.com>
	<20231117162323.626979-2-maxime.chevallier@bootlin.com>
	<9079c9f5-5531-4c38-b9c9-975ed3d96104@lunn.ch>
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

On Tue, 21 Nov 2023 01:24:47 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

[...]
> 
> > diff --git a/include/linux/link_topology.h b/include/linux/link_topology.h  
> 
> I think this filename is too generic. Maybe phy_link_topology.h, or
> move it into include/net.

Yeah naming again, phy_link_topology would make sense indeed. I know
that Florian suggested phy_devices_list last time, However I'd like
this to be more than just about PHYs, to keep track of ports, mii-muxes
and such. So, phy_link_topology sounds good to me :)

Maxime

