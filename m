Return-Path: <netdev+bounces-109237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55183927808
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 16:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EC8A281BBD
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 14:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FEE1AE0AB;
	Thu,  4 Jul 2024 14:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQYI4o0R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA93A1E893;
	Thu,  4 Jul 2024 14:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720102562; cv=none; b=LmdiPjloMkNkZbGYjhI5Om1q8fUtO7E7RFMEQS+aemhydBbkEBzLxEI1BFSGwn8puglwzU58xTa2yI6WmaQXlcigy3Xu9/vuFBfVLo102R1GBJEu/tLahWuFd72blHSO0aByudVWCQIjviXFmAH9h/EsvzeEaQSw+346igdxAc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720102562; c=relaxed/simple;
	bh=L/ihgEjN6zr5GAj54jflSDxostKdn540NYuea9kyg08=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rpwB/W5dz5Y+TT1eq6YvNNrRzFsMwB2ZjM6EmobucsxKH6iVHSMOkAcx0YcvpLRqmyqgq/kwkalVmoUvrBTAFAxwi2t0EkKKT4Afm/J1/msc8qbELNzDm0H/OK6FLTDmnfZCRl1MFZ9Qdon7qBgs5KAk7aHJ4nXQMHsw8NA4wg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sQYI4o0R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FBB9C4AF07;
	Thu,  4 Jul 2024 14:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720102562;
	bh=L/ihgEjN6zr5GAj54jflSDxostKdn540NYuea9kyg08=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sQYI4o0RHwMW6+z/7Bkp1VyyXCl59E4+94LfYY86Ht9ygiOhLD5QN9f93eN92tKUa
	 2R0+M4zxxrWBVUz1V0DZderPRZXbg6E6/mawFZ1vlc/oF6BCg5jMzocRzKsJjRzOPe
	 QXRdGFAyaYz4ApGpvJWtUkQENiip262KVpR7i5vUfEfOkCrhgWr0E/p5Ngvte8Zptu
	 NZQgBX/LXUSHW2A+Rdk3AwMHLXrr33qdWr7voxsTtbZlXe8EHBTKkws0lzUqgm4WVK
	 eqCbCK3N4ZqJLQTY3CYc5O+4D/P5NUKKtQobXSigPXtu9Gk92sl81cfmVamjucjEhK
	 LfKULublCMPpQ==
Date: Thu, 4 Jul 2024 07:16:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>, DENG Qingfang
 <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>, Andrew Lunn
 <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Landen Chao
 <Landen.Chao@mediatek.com>, Frank Wunderlich <linux@fw-web.de>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 regressions@lists.linux.dev
Subject: Re: [PATCH net v3] net: dsa: mt7530: fix impossible MDIO address
 and issue warning
Message-ID: <20240704071600.36e45294@kernel.org>
In-Reply-To: <ZoZ-ClhHUWzAPB1D@makrotopia.org>
References: <7e3fed489c0bbca84a386b1077c61589030ff4ab.1719963228.git.daniel@makrotopia.org>
	<20240703191308.3703099c@kernel.org>
	<ZoZ-ClhHUWzAPB1D@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Jul 2024 11:48:42 +0100 Daniel Golle wrote:
> > > +return ((((phy_addr - MT7530_NUM_PORTS) & ~MT7530_NUM_PORTS) % PHY_MAX_ADDR) +
> > > +	MT7530_NUM_PORTS) & (PHY_MAX_ADDR - 1);  
> > 
> > nit: the return statement lacks indentation  
> 
> Yes, lacks an additional space to match the level of the first open parentheses.
> I'll fix that in the next round.

To be clear I meant the line with "return", not the continuation line
starting with MT7530_NUM_PORTS

> > but also based on the comment, isn't it:
> > 
> > 	return (round_down(phy_addr, MT7530_NUM_PORTS + 1) - 1)	& (PHY_MAX_ADDR - 1);  
> 
> The original, more complicated statement covers also the correct addresses,
> ie. 31 -> 31, 7 -> 7, 15 -> 15, 23 -> 23. However, the function is never
> called if the address is deemed correct, so that doesn't actually matter.
> 
> It's kinda difficult to decide whether it is more important to return
> correct results also for values never used with the current code, or
> have a slightly more readable and shorter function but with expectations
> regarding the input values given by the caller.
> 
> Opinions?

No strong opinion, but I do think "% PHY_MAX_ADDR" is superfluous, no?
The masking at the end with "& (PHY_MAX_ADDR - 1)" will take care of
truncation.

