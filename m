Return-Path: <netdev+bounces-12317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE4E737159
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 18:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B793328132C
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 16:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA931775F;
	Tue, 20 Jun 2023 16:22:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1431773F
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 16:22:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D7A7C433C8;
	Tue, 20 Jun 2023 16:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687278144;
	bh=eGT84W7C6FNeSe7INXD8qi4waFUqmug0OQUsmlDgLPw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Mukg8JJY1NcvGDMsdE92e2ju9hZwdHwXyWBiHPz7APGcQZhI44TWjJItLMuk52Pxk
	 h9cPcyAry8D0xV71bKEhknh7yYjSGRwadPmr8L3qbAKguyUR9WKzNQZ2o6zYedeWhP
	 754gD8McPlgDGqVN9NX5G50PyBs87RoNYnvTFWUrDCEVd9nopTKLXdCmmmIZ3uBB7D
	 Ifv6UipahZV7ZdzRUFuA/2wP8QBUjO5R+l5lA/5cTo5mXE6NdXxY+I2TLYeHLeSAwP
	 yrl25zjb5NoIvWHrL22YPB9Rp8Ts6RitVGX88qK9H8eTG9b0IwSHyqTXU8Cqjxx6UD
	 TNPs1Z46QbTCA==
Date: Tue, 20 Jun 2023 09:22:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Alexander Couzens
 <lynxis@fe80.eu>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Claudiu Beznea
 <claudiu.beznea@microchip.com>, Daniel Golle <daniel@makrotopia.org>,
 Daniel Machon <daniel.machon@microchip.com>, DENG Qingfang
 <dqfext@gmail.com>, Eric Dumazet <edumazet@google.com>, Florian Fainelli
 <f.fainelli@gmail.com>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Jose Abreu
 <Jose.Abreu@synopsys.com>, Landen Chao <Landen.Chao@mediatek.com>, Lars
 Povlsen <lars.povlsen@microchip.com>, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Madalin Bucur <madalin.bucur@nxp.com>,
 Marcin Wojtas <mw@semihalf.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 Michal Simek <michal.simek@amd.com>, netdev@vger.kernel.org, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Radhey Shyam Pandey
 <radhey.shyam.pandey@xilinx.com>, Sean Anderson <sean.anderson@seco.com>,
 Sean Wang <sean.wang@mediatek.com>, Steen Hegelund
 <Steen.Hegelund@microchip.com>, Taras Chornyi <taras.chornyi@plvision.eu>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next 11/15] net: qca8k: update PCS driver to use
 neg_mode
Message-ID: <20230620092222.16ed226a@kernel.org>
In-Reply-To: <20230620112858.p7v5w767vfhksyrn@skbuf>
References: <ZIxQIBfO9dH5xFlg@shell.armlinux.org.uk>
	<E1qA8EU-00EaG9-1l@rmk-PC.armlinux.org.uk>
	<ZJFu1cPT2sOVuczK@shell.armlinux.org.uk>
	<20230620112858.p7v5w767vfhksyrn@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Jun 2023 14:28:58 +0300 Vladimir Oltean wrote:
> On Tue, Jun 20, 2023 at 10:18:13AM +0100, Russell King (Oracle) wrote:
> > I see netdevbpf patchwork is complaining that I didn't Cc a maintainer
> > for this patch (ansuelsmth@gmail.com). Why is it complaining? This
> > address is *not* in the MAINTAINERS file in the net-next tree neither
> > for the version I generated the patch against (tip on submission date),
> > today's tip, nor the net tree.
> > 
> > Is patchwork using an outdated MAINTAINERS file?
> > 
> > -- 
> > RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> > FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!  
> 
> I can presume that patchwork runs scripts/get_maintainer.pl, which looks
> not only at the MAINTAINERS file, but also at the recent authors and
> sign offs from git for a certain file path.

The exact incantation it uses is:

./scripts/get_maintainer.pl --git-min-percent 25

But it's just a warning because get_maintainer sometimes reports 
stupid stuff.

