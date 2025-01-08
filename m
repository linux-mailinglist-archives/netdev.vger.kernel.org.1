Return-Path: <netdev+bounces-156379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 250B6A06398
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 18:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DAC6163B6E
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 17:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56245201033;
	Wed,  8 Jan 2025 17:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwjurc87"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DE0201027;
	Wed,  8 Jan 2025 17:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736358123; cv=none; b=LrgNsNNyeRWT9EAzoEtYrY2j6Z/fJUcMflYYu1EJ5qrz5W2k+a6TxtBdiOQAXmgfbqB3p8/Litxj7XzAWK4h9OXa756UuGK8cDTp+iV/2ejHOvTRBjOLBuKK/p72oJ8CRWiuO5dKalvGzgm4L2XPdzryy/iQNPnupa165f0MdOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736358123; c=relaxed/simple;
	bh=NEFBDVKyWyCXwUfiVzm5ftkCHrDa2rg/ogmBXzWHaOM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ihVX9nmqvS+5Rp3BM92G2ZF/GrLN6taRzjYBmtRMIOLSU6thV3+Ac4XAUyMxgXgwP/k9hGo+o9txp7skKisWYL+eCbSq4twMlTfvLzs6iUiOevqc9QHauxMNJyI74/7gDb4S4WgO/hn5a9bOSgb9TBw4VsQmxwIKV+HYXuZBUfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwjurc87; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CFC1C4CEE3;
	Wed,  8 Jan 2025 17:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736358122;
	bh=NEFBDVKyWyCXwUfiVzm5ftkCHrDa2rg/ogmBXzWHaOM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kwjurc87EG5lVS8FwlQ4JrYPU/lhzkdJYzfNk7oOBi6qqDzXnbUuwCJJ1HIh1Qo1s
	 KMYyQxfu+sXS1EMWx8M8e1grdHttbh3d91Nlws3mnNFtqRXFamK9xNL75G4+JhRHMn
	 DqqGYOXK/zro/wy0S7pys7Hh83czluBtnDAlCM9uwfLEWz1G//nKsadTUr/0WmNZAj
	 8DUT9+QtSZgyoo1BK7Tzjs+1lQN6scD4/TmB4itAJePVD1Mq/urKeCdysLxnoM7QyY
	 LrOM8rd3cYUwMBHcbftnCvixUKsumAOlGdrUqvR1DzAe2nd1x5Qp44rLrLmsEvnF1M
	 b4j7qSuCm8J0g==
Date: Wed, 8 Jan 2025 09:42:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Kory Maincent <kory.maincent@bootlin.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org, Kyle Swenson
 <kyle.swenson@est.tech>, Dent Project <dentproject@linuxfoundation.org>,
 kernel@pengutronix.de, Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next 11/14] net: pse-pd: Add support for PSE device
 index
Message-ID: <20250108094201.63463180@kernel.org>
In-Reply-To: <Z34RXjqUKBdDqAGF@pengutronix.de>
References: <20250104-b4-feature_poe_arrange-v1-0-92f804bd74ed@bootlin.com>
	<20250104-b4-feature_poe_arrange-v1-11-92f804bd74ed@bootlin.com>
	<20250107171834.6e688a6b@kernel.org>
	<Z34RXjqUKBdDqAGF@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 8 Jan 2025 06:47:10 +0100 Oleksij Rempel wrote:
> On Tue, Jan 07, 2025 at 05:18:34PM -0800, Jakub Kicinski wrote:
> > On Sat, 04 Jan 2025 23:27:36 +0100 Kory Maincent wrote:  
> > > From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> > > 
> > > Add support for a PSE device index to report the PSE controller index to
> > > the user through ethtool. This will be useful for future support of power
> > > domains and port priority management.  
> > 
> > Can you say more? How do the PSE controllers relate to netdevs?
> > ethtool is primarily driven by netdev / ifindex.
> > If you're starting to build your own object hierarchy you may be
> > better off with a separate genl family.  
>             
> I hope this schema may help to explain the topology:
> 
> 	                              +--- netdev / ifindex 0
> 	    +--- PSE power domain 0 --+--- netdev / ifindex 1
>             |                         +--- netdev / ifindex 2
> PSE ctrl 0 -+
>             |                         +--- netdev / ifindex 3
>             +--- PSE power domain 1 --+--- netdev / ifindex 4
> 	                              +--- netdev / ifindex 5
> 
> 	                              +--- netdev / ifindex 6
> 	    +--- PSE power domain 2 --+--- netdev / ifindex 7
>             |                         +--- netdev / ifindex 8
> PSE ctrl 1 -+
>             |                         +--- netdev / ifindex 9
>             +--- PSE power domain 3 --+--- netdev / ifindex 10
> 	                              +--- netdev / ifindex 11
> 
> PSE device index is needed to find actually PSE controller related to
> specific netdev / ifindex.

Makes sense. So how does it end up looking in terms of APIs 
and attributes? Will we need much more than power limits at
the domain and ctrl level?

