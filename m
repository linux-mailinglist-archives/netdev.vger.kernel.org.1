Return-Path: <netdev+bounces-240427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD718C74B69
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 16:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id D001D2B812
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 15:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56472E62C4;
	Thu, 20 Nov 2025 15:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bq+zbsKP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3D02D3A96;
	Thu, 20 Nov 2025 15:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763650849; cv=none; b=WHmWIQ/xIzmbWSaMLOoa8FGITbGIwbdmygKr6bMyAtWnukMi2Lo09PZ0j12G4cgjYchaP9j6bnI1Qh7QSP3FHjmC2JjCqcWmWcm4mu1h2VKN7CsLM9/+dKRQ9oslJvHCA2DEnko9/QbvMAxOGyOrHN0HeB4+xuVG+QV915mwd9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763650849; c=relaxed/simple;
	bh=qOLDXwSo6tNYPEYXmBkGtDCBymPoojze6blkqSOqtL0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qLBf3B48Wl6h1GWaSAh+WNfYJBFmYA2vcNKWT6l5rJ4hjD4oFtO0SqxeJz3oR+OHbos9nrhIyQ80kCFh48YHnifOlaX5qPoWnFz0tWR72vPf4pxo0I4SFf03bO6Fz/qTeK0Sm6rvqONQFp+FhmXyr20qiCeiIxm00k/nro27fMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bq+zbsKP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A1EC4CEF1;
	Thu, 20 Nov 2025 15:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763650849;
	bh=qOLDXwSo6tNYPEYXmBkGtDCBymPoojze6blkqSOqtL0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bq+zbsKPiFYmj+VLYHAJ0VeR10BbUewTKtW5i8XUmmnY+rc1Tt4pMfEcUv9HWoIC8
	 zFXWTEXe+8BSqRCb33wFalhbtPTN3rdGR1SiTtppEtT2jU9efh4XOjwdLt1q+q6ebI
	 T8G6UyZJIOF8Sbbu2HGnomwLVcNHzECaCyM3EiGKspf7Qz7DcCspEZR+CZRd9NVmn4
	 l4D/PQfNdZE5KeX739TWqbkP7aHTBNC/a9nh5ajZUUXSUKsHLmvLcJjs+Z+VMNA5jR
	 Gx0iclo4Xl12uABQQ47Jeu7R6kriDT6xHbf0gD3/jH03yKZn7JIZ0Cr0PpCgEQcFTI
	 ASEn6/huUgR3g==
Date: Thu, 20 Nov 2025 07:00:47 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, netdev@vger.kernel.org, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, linux-kernel@vger.kernel.org, Serge Semin
 <fancer.lancer@gmail.com>, Herve Codina <herve.codina@bootlin.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 14/15] net: dsa: sja1105: replace mdiobus-pcs
 with xpcs-plat driver
Message-ID: <20251120070047.4c8411af@kernel.org>
In-Reply-To: <aR8KZZa63ygR-e1N@shell.armlinux.org.uk>
References: <20251118190530.580267-1-vladimir.oltean@nxp.com>
	<20251118190530.580267-15-vladimir.oltean@nxp.com>
	<20251118190530.580267-1-vladimir.oltean@nxp.com>
	<20251118190530.580267-15-vladimir.oltean@nxp.com>
	<20251118164130.4e107c93@kernel.org>
	<20251118164130.4e107c93@kernel.org>
	<20251119095942.bu64kg6whi4gtnwe@skbuf>
	<aR2cf91qdcKMy5PB@smile.fi.intel.com>
	<20251119112522.dcfrh6x6msnw4cmi@skbuf>
	<20251119081112.3bcaf923@kernel.org>
	<aR8KZZa63ygR-e1N@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Nov 2025 12:32:37 +0000 Russell King (Oracle) wrote:
> On Wed, Nov 19, 2025 at 08:11:12AM -0800, Jakub Kicinski wrote:
> > On Wed, 19 Nov 2025 13:25:22 +0200 Vladimir Oltean wrote:  
> > > I think it's due to the fact that the "contest" checks are fundamentally
> > > so slow, that they can't be run on individual patch sets, and are run on
> > > batches of patch sets merged into a single branch (of which there seem
> > > to be 8 per day).  
> > 
> > Correct, looking at the logs AFAICT coccicheck takes 25min on a
> > relatively beefy machine, and we only run it on path that were actually
> > modified by pending changes. We get 100+ patches a day, and 40+ series,
> > and coccicheck fails relatively rarely. So on the NIPA side it's not
> > worth it.  
> 
> On "contest" I find when looking at patchwork, it's just best to ignore
> the result that NIPA posts for that, because more often than not it
> reports "fail" when there's nothing wrong.
> 
> For example, the qcom-ethqos patches - v1 passed contest, and this
> morning I submitted v2. The only change was removing the double space
> in patch 2. What I see in v2 is that _all_ the patches failed contest,
> even those that are unchanged and previously passed. This makes
> contest unreliable and IMHO misleading - and as such I hate it.

Fair, I'll fix it over the weekend. tl;dr it shows up as failing until
we get a clean run because of patchwork UI shortcomings.

Long version is that unfortunately patchwork UI does not show "pending"
tests on the main page. So when we eyeball the queue to get a sense
of patches which are fully validated its hard to tell "done" from 
"in progress". I believe BPF's KPD system also uses "fail until
finished", I'm guessing for the same reason. 

That said I stopped using the patchwork UI completely now, and switch 
to my own UIs within NIPA. So patchwork shortcomings are no longer 
a concern.

