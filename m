Return-Path: <netdev+bounces-111088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F3F92FD17
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 17:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 806F82849B2
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 15:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC603173343;
	Fri, 12 Jul 2024 15:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G94/R3lL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B311B173348;
	Fri, 12 Jul 2024 15:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720796404; cv=none; b=Q3MSlMn5E8JoP5w3fSZbRIVHSlurAfevROU30j/V4aaO4xA3+LjQbOo/qQ3CeGS8WBIhafszI69XXxruHh4r5y6Il3VYzmNF7MQL0tKg6M1+EaFNPTF6eeafWsbgZnkEsQ0CLUveujngEbdPSWaGc14gaJs2KsoKKF4GWQU/L3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720796404; c=relaxed/simple;
	bh=pLkYVWWa4KVYmUB7SuThwAZhsHjrcNB+hX34mYYBkrU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rad0KNHPhSKbtib30huwk3oufO1ds8xhIuyQGlWGQXG54xi28HVRtogsgdbW/xDHTtjLPzolrOE3gLT1vwKswoL0rZngcq6SKZ8Ldv+VICBf60hnJ5c0d6uGwwzacSayALBXF/Xzlf4C3DXCM78gB1kMD3IqUZPLzJeTeMK8xzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G94/R3lL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7831CC32782;
	Fri, 12 Jul 2024 15:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720796404;
	bh=pLkYVWWa4KVYmUB7SuThwAZhsHjrcNB+hX34mYYBkrU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G94/R3lLY3+LV0geoU6JHl7pjmqr4IPDSqahqtDnYG5cqNo7tvR/0Njx7CZjJNe+b
	 9oDsJlmmJdcxM63FbL81CdKuHdLHftDAT396o+nG8xHeQGRgbsAe2ywqRgWzIeNVux
	 jEnkiCRB0xibLSL5t5tkRora7AFfW4mUHKLIkFoO34hZabrf6cJwqjxLZqc64NCVtP
	 IQA8h7yKQV7odGEDD/0NF/K4f4DPjlGm5/SRe4B4oARWtTnXahSgVdUKJHHy/qBte8
	 RhjXbIiye4W5LFb0x9gefTJEGUVrDL5p9gvK+j+CeT2+aX1ltjzJazQBI+D9hGa5nL
	 kr4T/eV5BJlFg==
Date: Fri, 12 Jul 2024 08:00:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, nbd@nbd.name, lorenzo.bianconi83@gmail.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 conor@kernel.org, linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org,
 upstream@airoha.com, angelogioacchino.delregno@collabora.com,
 benjamin.larsson@genexis.eu, rkannoth@marvell.com, sgoutham@marvell.com,
 andrew@lunn.ch, arnd@arndb.de, horms@kernel.org
Subject: Re: [PATCH v7 net-next 2/2] net: airoha: Introduce ethernet support
 for EN7581 SoC
Message-ID: <20240712080002.37c11d02@kernel.org>
In-Reply-To: <ZpFBLkYyMXtMgbA8@lore-desk>
References: <cover.1720600905.git.lorenzo@kernel.org>
	<8ca603f8cea1ad64b703191b4c780bab87cb7dff.1720600905.git.lorenzo@kernel.org>
	<20240711181003.4089a633@kernel.org>
	<ZpEz-o1Dkg1gF_ud@lore-desk>
	<20240712072819.4f43062c@kernel.org>
	<ZpFBLkYyMXtMgbA8@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jul 2024 16:43:58 +0200 Lorenzo Bianconi wrote:
> > On Fri, 12 Jul 2024 15:47:38 +0200 Lorenzo Bianconi wrote:  
> > > The Airoha eth SoC architecture is similar to mtk_eth_soc one (e.g MT7988a).
> > > The FrameEngine (FE) module has multiple GDM ports that are connected to
> > > different blocks. Current airoha_eth driver supports just GDM1 that is connected
> > > to a MT7530 DSA switch (I have not posted a tiny patch for mt7530 driver yet).
> > > In the future we will support even GDM{2,3,4} that will connect to differ
> > > phy modues (e.g. 2.5Gbps phy).  
> > 
> > What I'm confused by is the mentioned of DSA. You put the port in the
> > descriptor, and there can only be one switch on the other side, right?  
> 
> do you mean fport in msg1 (airoha_dev_xmit())?
> 
> 	fport = port->id == 4 ? FE_PSE_PORT_GDM4 : port->id;
> 	msg1 = FIELD_PREP(QDMA_ETH_TXMSG_FPORT_MASK, fport) |
> 	       ...
> 
> fport refers to the GDM port and not to the dsa user port. Am I missing
> something?

Ooh, I see, reading what you explained previously now makes sense.
So only 1 of the ports goes to the DSA switch, and the other ones
are connected to SoC pins? A diagram would be worth a 1000 words ;)

> > be in a setup like this :( It will have no way to figure out the real
> > egress rate given that each netdev only sees a (non-)random sample
> > of traffic sharing the queue :(  
> 
> do you prefer to remove BQL support?

No strong preference, I worry it will do more harm than good in
this case. It's not what it's designed for basically. But without
testing it's all speculation, so up to you, users can always disable
using sysfs.

