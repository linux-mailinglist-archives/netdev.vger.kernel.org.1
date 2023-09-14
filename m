Return-Path: <netdev+bounces-33811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEC77A044B
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 14:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66501B20DD8
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 12:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADED024208;
	Thu, 14 Sep 2023 12:47:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37C4241F9
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 12:47:52 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCC31FD0;
	Thu, 14 Sep 2023 05:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BqdX0hV4tEYYiC/8IPMSmeBje/hkN8pxNeaKmKo60TU=; b=aYrPSq1Z0wwYWNUTdYynOkxBA6
	E+w/1eZhLHk4s58sCaIEJ1KFtUw+st8SkT7226R2SLYuikfBIlgVVOVDAFvbyp2B8O+ASrDt0TAht
	EoSM3A6tvITFl6WHoCdEfs4Yq5cRbq0jPQ9gN7wdenjmmtXKpw5ctvd+/YbeLPe5g/8Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qgll2-006P6o-Qu; Thu, 14 Sep 2023 14:47:44 +0200
Date: Thu, 14 Sep 2023 14:47:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Oleksij Rempel <linux@rempel-privat.de>,
	=?iso-8859-1?Q?Nicol=F2?= Veronese <nicveronese@gmail.com>,
	"thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>
Subject: Re: [RFC PATCH net-next 0/7] net: phy: introduce phy numbering
Message-ID: <60703503-e592-4467-a942-74400583369d@lunn.ch>
References: <20230907092407.647139-1-maxime.chevallier@bootlin.com>
 <e7b49a60-4422-4f3f-3e77-d924f967e939@csgroup.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7b49a60-4422-4f3f-3e77-d924f967e939@csgroup.eu>

> FWIW when thinking about multiple PHY to a single MAC, what comes to my 
> mind is the SIS 900 board, and its driver net/ethernet/sis/sis900.c
> 
> It has a function sis900_default_phy() that loops over all phys to find 
> one with up-link then to put all but that one in ISOLATE mode. Then when 
> the link goes down it loops again to find another up-link.
> 
> I guess your series would also help in that case, wouldn't it ?

Yes, it would. However, that driver would need its PHY handling
re-written because it is using the old MII code, not phylib.

	Andrew

