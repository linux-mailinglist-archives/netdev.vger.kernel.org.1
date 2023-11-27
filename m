Return-Path: <netdev+bounces-51367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1057FA597
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 17:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EDB4B210CF
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 16:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5E134CFA;
	Mon, 27 Nov 2023 16:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2Juu8c4d"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341F5DD;
	Mon, 27 Nov 2023 08:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gD6ndoFSiIawhejTksq7339holqrYq7T22/Pc0bwGD0=; b=2Juu8c4dNms+1ahcAz7GTNR+EX
	alFo2SGFqf5yEolR92f1nWCAuInJqBdf6ha3vyP3LHEymyEAda7ljySui06PxXE0y3eEl285Gdnw9
	BMm5Ow0I8hY8TmxSIp5JG6cmVVcrt3tIybtxofy9q+2hCmECLFwrbfl2SqXOdahflzbg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r7e5S-001MhD-JX; Mon, 27 Nov 2023 17:03:54 +0100
Date: Mon, 27 Nov 2023 17:03:54 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?Ram=F3n?= Nordin Rodriguez <ramon.nordin.rodriguez@ferroamp.se>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] net: microchip_t1s: additional phy support and
 collision detect handling
Message-ID: <270f74c0-4a1d-4a82-a77c-0e8a8982e80f@lunn.ch>
References: <20231127104045.96722-1-ramon.nordin.rodriguez@ferroamp.se>
 <d79803b5-60ec-425b-8c5c-3e96ff351e09@lunn.ch>
 <ZWS2GYBGGZg2MS0d@debian>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWS2GYBGGZg2MS0d@debian>

> * 3-4 nodes (depending on how many usb ports and dongles I have)
> * run iperf with long cables and CSMA/CD
> * run iperf with long cables and CMSA/No CD
> 
> I'll report back the results. Anything you'd like to add/focus on with
> evaluation?

Humm, thinking about how CSMA/CD works...

Maybe look at what counters the MAC provides. Does it have collisions
and bad FCS? A collision should result in a bad FCS, if you are not
using CD. So if things are working correctly, the count for CD should
move to FCS if you turn CD off. If CD is falsely triggering, FCS as a
% should not really change, but you probably get more frames over the
link?

	Andrew


