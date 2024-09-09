Return-Path: <netdev+bounces-126501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB549718E6
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 14:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F368B22C6A
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 12:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542131AC8B1;
	Mon,  9 Sep 2024 12:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qR0EKqwv"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66DC1531E0;
	Mon,  9 Sep 2024 12:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725883441; cv=none; b=C/CidW1G2wEoVJ+qpDhi9sQAyd1DyqfnLmM/exq/AtFQmMAveLCzcFukB0Ixy3ZkBSv5vz7eTg9Fdz+0RZBf+sYD3PuAff9O1b8DbGTjdXfkIMwEsF+WV8wfnf0qnSSU35BtUokWgRj/TMZZKTNxASn4x0pquAY/BP8q7NDIve4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725883441; c=relaxed/simple;
	bh=gzsvO2iD7JIym/mcLsJQSZM62CIKSBUEmMy9AW3fv0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kujx6N4tTVE9dkozwYZ2fy+vnn8c1CfDMOh/sGSl7Jq0BQz+8ngM1evTg/3Obm4cWQgjL8dQhDQl5vzKgCNsAFnewmRWakJBW8MdsIHt7c8qu7uWQQ0ikKOnhe7NXnzXxQ92WcqiTnaF/HHUERxq/r5pQk4nvyXG4AXTKBNjk+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qR0EKqwv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wIrwxiU2sI6CPIK1O2C6jwUn1fiYoV2NS1Jz9hz/afk=; b=qR0EKqwvseERBzPgUWa9bfMkKz
	8bbDG5nYC/cGoN8ObALeXdsbcQtvfMXMu37cMBl37BJEL+OvNETbDeYkzJAmLCxJGow1aEF2TMO9/
	aAM/mmv3q+NmBojF0mFSQIq9UZz1cGmMSqIoCnRgOQPrRILcXKad/00X72CTt7TK05AI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1snd7E-00704w-Q0; Mon, 09 Sep 2024 14:03:32 +0200
Date: Mon, 9 Sep 2024 14:03:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Jacob Keller <jacob.e.keller@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue6KaGOiBbUEFUQ0ggbmV0LW5l?= =?utf-8?Q?xt=5D_net?=
 =?utf-8?Q?=3A?= ftgmac100: Fix potential NULL dereference in error handling
Message-ID: <6261c529-0a15-4395-a8e9-3840ae4dddd6@lunn.ch>
References: <3f196da5-2c1a-4f94-9ced-35d302c1a2b9@stanley.mountain>
 <SEYPR06MB51342F3EC5D457CC512937259D9E2@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <6c60860b-dd3c-4d1c-945b-edb8ef6a8618@lunn.ch>
 <SEYPR06MB513433B0DBD9E8008F094CE39D992@SEYPR06MB5134.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEYPR06MB513433B0DBD9E8008F094CE39D992@SEYPR06MB5134.apcprd06.prod.outlook.com>

> > Are you actually saying:
> > 
> >         if (netdev->phydev) {
> >                 /* If we have a PHY, start polling */
> >                 phy_start(netdev->phydev);
> >         }
> > 
> > is wrong, it is guaranteed there is always a phydev?
> > 
> This patch is focus on error handling when using NC-SI at open stage.
> 
>          if (netdev->phydev) {
>                  /* If we have a PHY, start polling */
>                  phy_start(netdev->phydev);
>          }
> 
> This code is used to check the other cases.
> Perhaps, phy-handle or fixed-link property are not added in DTS.

I'm guessing, but i think the static analysers see this condition, and
deducing that phydev might be a NULL. Hence when phy_stop() is called,
it needs the check.

You say the static analyser is wrong, probably because it cannot check
the bigger context. It can be NULL for phy_start() but not for
phy_stop(). Maybe you can give it some more hints?

Dan, is this Smatch? Is it possible to dump the paths through the code
where it thinks it might be NULL?

	Andrew

