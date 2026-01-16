Return-Path: <netdev+bounces-250415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 406BDD2AA6B
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 04:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2B513020C58
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 03:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0ADD313290;
	Fri, 16 Jan 2026 03:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UfPpHK9Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3B2277CAF;
	Fri, 16 Jan 2026 03:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768533565; cv=none; b=A/pX7NXOKPYlnFq9VEzuw3Uo1EVbkPFWlyFt3qfvzTuUoHiJD4v8JJzxv8wdRe/Jkr3nNb34dLDrNz3ulBlvqeULY2Lo1SUraV1l1Rl+TWG06bujbYCkfR0JW6xapFzV81tl5Kdg6MquLp3u56IIGVLFmojStD3UdxCm1Cixdi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768533565; c=relaxed/simple;
	bh=VdJdZpUrMYbP48ze7XiWYcrijQ8cjRhSAViY06JrWns=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ibsqJgdKT/NsbJftwb8J1c2XnkgJNK2Hpx/+P8o9CLnvSB5zRbtBFu0GlBMyrV+OptjJux1TQFlsoX9lmYizXMS5XQ8x2BSed0B6ACzaH4Eb890FzpHsBSRPOHsO7U2NnmqnjFeVocxY95XcYxymR0IzfQswcM/lbkEOaKo4vH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UfPpHK9Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B3CAC116D0;
	Fri, 16 Jan 2026 03:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768533565;
	bh=VdJdZpUrMYbP48ze7XiWYcrijQ8cjRhSAViY06JrWns=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UfPpHK9Zs+U0XolvtAoWyNifcaJ7gKJDEZDRjcx/qG9hP6oEaFsIVpncLAsQsSBf5
	 I0nd2pkfwH18qaqAe1BCUhxezG4bx7ZlzYhI9sWtDNwKQumt3mLXq5qimita/HMBUP
	 QW40JDSebPhYGO3ngLZ2OW9vCAL/McNkDv+hiUPbBvUBSmw6YAjQZsGszx0BBcL8mN
	 dvgURzsb55zeC0ZJTbDPPaYyJtr9psUVbcOvQmY2MibBL+UFaZR8/OHov8OaUrCJOe
	 ojvDq4ltLZcX0v9x5yq/XgSFPad7wGsm478xvrSuF0bF3qtinApwa6v8/VenDmGqsX
	 iRL+468HGOQGw==
Date: Thu, 15 Jan 2026 19:19:23 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Paolo Abeni <pabeni@redhat.com>, =?UTF-8?B?QmrDuHJu?= Mork
 <bjorn@mork.no>, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Daniel Golle <daniel@makrotopia.org>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, Andrew Lunn <andrew@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Eric
 Woudstra <ericwouds@gmail.com>, Marek =?UTF-8?B?QmVow7pu?=
 <kabel@kernel.org>, Lee Jones <lee@kernel.org>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v3 net-next 05/10] phy: add phy_get_rx_polarity() and
 phy_get_tx_polarity()
Message-ID: <20260115191923.640ea49d@kernel.org>
In-Reply-To: <20260115093928.hdqlxkt6bd5w4xud@skbuf>
References: <20260111093940.975359-1-vladimir.oltean@nxp.com>
	<20260111093940.975359-6-vladimir.oltean@nxp.com>
	<87o6n04b84.fsf@miraculix.mork.no>
	<20260111141549.xtl5bpjtru6rv6ys@skbuf>
	<aWeV1CEaEMvImS-9@vaman>
	<33ff22b4-ead6-4703-8ded-1be5b5d0ead0@redhat.com>
	<173d1032-386c-4188-933c-ca91ce36468f@redhat.com>
	<20260115093928.hdqlxkt6bd5w4xud@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Jan 2026 11:39:28 +0200 Vladimir Oltean wrote:
> > > Could you please share a stable branch/tag, so that we can pull patches
> > > 1-5 into the net-next tree from there?  
> > 
> > Vladimir, could you please re-post patches 1-5 after that Vinod shares
> > the above? So that we don't keep in PW the dangling (current) series.
> >  
> Vinod did share the PR:
> https://lore.kernel.org/netdev/aWeXvFcGNK5T6As9@vaman/

IIUC Paolo did not pull Vinod's PR, so pulled now, you can repost.

