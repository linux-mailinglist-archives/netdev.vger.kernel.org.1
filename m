Return-Path: <netdev+bounces-195028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 134A8ACD87E
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 09:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD7C7174C90
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 07:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0131E7C11;
	Wed,  4 Jun 2025 07:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HB/eFCnp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522002B9A9;
	Wed,  4 Jun 2025 07:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749021886; cv=none; b=N8loxfyhUWHh4178RbjVMWMuodkDzrSAoGn07KkhduBEGCuLrMRDqrULvM+H0QmTfcDPKAZiCFwbz9wgTKj/FNZptwb1JaLL0LVsoAMSsxGds/8NctpCAj6jiLldydg1kB+V6vq6mpRbIqOn9ujyWAkpef9DvR460T4gXjXkQYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749021886; c=relaxed/simple;
	bh=5SyUvppNuSDFqKzdDCKf9UQfWjYA+/m0ZdXQA8ZCk04=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=UjEN+dQ5gCLFVOTzU7dWEhFIbhzzbHSXWoNgA9gjBtqW1WOsaatQBc8+k5l4iy1wPrceK3Mi3M/maqSRjRQCAs4V8OBKjBAMfzp+2vsqK5ZkNpR36HR/YC9d14m/5EP95foSB9jofTdDk1JzscqqXfBq4s8hZOlMp567Mj+epBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HB/eFCnp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7113BC4CEF3;
	Wed,  4 Jun 2025 07:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749021884;
	bh=5SyUvppNuSDFqKzdDCKf9UQfWjYA+/m0ZdXQA8ZCk04=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=HB/eFCnpX+ZayuBp8txIrg5VYlULfE/p9+roKKsskMKtDPDWg3iddFh9c0PKAwgHQ
	 Tly9R/+1+C4r+KZn7sSpeEQYBunh1UkK8DGxqRQ0vrGw4RGfSsxB7YM/Sl4WPbQmys
	 IufgNyTgI00B5gSiglvXfe+Hj3Ksf2yPPGz0V3zMm053tXbb5N5GUg3pgihCdWxBp8
	 QHOnjbFKzNi19tm6jZVM5NE+CxtQ3bx1kVA6CaxC/PtPcGUqZJDc2N6/cTVmrrfi5v
	 UiWUewSS13sxl21kkENnQQ7x2ytAbLUNOrGGU8tnls5pKMbPx5F1i2Ga/XEaHehFS7
	 5auOw4CmWmj7g==
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 53D511200043;
	Wed,  4 Jun 2025 03:24:43 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Wed, 04 Jun 2025 03:24:43 -0400
X-ME-Sender: <xms:u_Q_aM0p66c7BTBlfuIYsSicCe_pViw9XN91-QilwIDc3PiTvTfObQ>
    <xme:u_Q_aHEWoV0s6rTr_mdGh1Z8Zo48w71MXZNmxSxmsnyRP3r7ZMx5rNMRPQ01nrMTO
    Fi-5oH7tiPLS8-pJT0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddujeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnhgvlh
    drohhrgheqnecuggftrfgrthhtvghrnhepjeejffetteefteekieejudeguedvgfeffeei
    tdduieekgeegfeekhfduhfelhfevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdduvdekhedujedtvdegqddvkeejtddtvdeigedqrghrnhgupeepkhgvrhhnvghlrd
    horhhgsegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpth
    htohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrges
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepihhmgieslhhishhtshdrlhhinhhugidrug
    gvvhdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghp
    thhtoheptghlrghuughiuhdrmhgrnhhoihhlsehngihprdgtohhmpdhrtghpthhtohepvh
    hlrgguihhmihhrrdholhhtvggrnhesnhigphdrtghomhdprhgtphhtthhopeifvghirdhf
    rghnghesnhigphdrtghomhdprhgtphhtthhopeigihgrohhnihhnghdrfigrnhhgsehngi
    hprdgtohhm
X-ME-Proxy: <xmx:u_Q_aE5sTD0Kdfr_d2GhRgaixAi4cDUozX84ZsqAQekzD2Odxix8Zw>
    <xmx:u_Q_aF2do4Prs4IglGpFHWYGkpGD4m9Y-ATuFOpdEw4urR-6I5qIXw>
    <xmx:u_Q_aPFSCwDMnHJ9SKYi0HZA3GHdSOkGE76ZHFR45MARKZjOFyk2WQ>
    <xmx:u_Q_aO9yaSbSBjSKAcVGz4qq4Lo_P0Ulge5Vjb0JlDXTyFCTkfh1lw>
    <xmx:u_Q_aEk7GsFRp93W9iXWe4RGVXQK5UWMlfvk2tVEZ-jz5CImLKGqCYQE>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2BEE3700060; Wed,  4 Jun 2025 03:24:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tcd26d72acdec76a4
Date: Wed, 04 Jun 2025 09:24:22 +0200
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Wei Fang" <wei.fang@nxp.com>, "Vladimir Oltean" <vladimir.oltean@nxp.com>
Cc: "Claudiu Manoil" <claudiu.manoil@nxp.com>,
 "Clark Wang" <xiaoning.wang@nxp.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, Netdev <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "imx@lists.linux.dev" <imx@lists.linux.dev>
Message-Id: <b2068b86-dcbb-4fee-b091-4910e975a9b9@app.fastmail.com>
In-Reply-To: 
 <PAXPR04MB85104C607BF23FFFD6663ABB886CA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250603105056.4052084-1-wei.fang@nxp.com>
 <20250603204501.2lcszfoiy5svbw6s@skbuf>
 <PAXPR04MB85104C607BF23FFFD6663ABB886CA@PAXPR04MB8510.eurprd04.prod.outlook.com>
Subject: Re: [PATCH net] net: enetc: fix the netc-lib driver build dependency
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Jun 4, 2025, at 04:44, Wei Fang wrote:
>> Ok, so to summarize, you want nxp-netc-lib.ko to be separate from
>> fsl-enetc-core.ko, because when you upstream the switch driver (also a
>> consumer of ntmp.o), you want it to depend just on nxp-netc-lib.ko but
>> not on the full fsl-enetc-core.ko.
>> If the only reverse dependency of NXP_NETC_LIB, NXP_ENETC4, becomes m,
>> then NXP_NETC_LIB also becomes m, but in reality, FSL_ENETC_CORE, via
>> cbdr.o, still depends on symbols from NXP_NETC_LIB.
>> 
>> So you influence NXP_NETC_LIB to not become m when its only selecter is m,
>> instead stay y.
>> 
>> Won't this need to change, and become even more complicated when
>> NXP_NETC_LIB gains another selecter, the switch driver?
>
> The dependency needs to be updated as follows when switch driver is
> added, to avoid the compilation errors.
>
> default y if FSL_ENETC_CORE=y && (NXP_ENETC4=m || NET_DSA_NETC_SWITCH=m)
>
>> 
>> >  	help
>> >  	  This module provides common functionalities for both ENETC and NETC
>> >  	  Switch, such as NETC Table Management Protocol (NTMP) 2.0, common tc
>> > --
>> > 2.34.1
>> >
>> 
>> What about this interpretation? cbdr.o uses symbols from NXP_NETC_LIB,
>> so the Kconfig option controlling cbdr.o, aka FSL_ENETC_CORE, should
>> select NXP_NETC_LIB. This solves the problem in a way which is more
>> logical to me, and doesn't need to change when the switch is later added.
>> 
>
> Yes, this is also a solution. I thought that LS1028A does not need the netc-lib
> driver at all. Doing so will result in netc-lib being compiled on the LS1028A
> platform, which may be unacceptable, so I did not do this. Since you think
> this is better, I will apply this solution next. Thanks.

I think this version should work, and make logical sense:

--- a/drivers/net/ethernet/freescale/enetc/Kconfig
+++ b/drivers/net/ethernet/freescale/enetc/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 config FSL_ENETC_CORE
        tristate
+       select NXP_NETC_LIB if NXP_ENETC_NTMP
        help
          This module supports common functionality between the PF and VF
          drivers for the NXP ENETC controller.
@@ -22,6 +23,9 @@ config NXP_NETC_LIB
          Switch, such as NETC Table Management Protocol (NTMP) 2.0, common tc
          flower and debugfs interfaces and so on.
 
+config NXP_ENETC_NTMP
+       bool
+
 config FSL_ENETC
        tristate "ENETC PF driver"
        depends on PCI_MSI
@@ -45,7 +49,7 @@ config NXP_ENETC4
        select FSL_ENETC_CORE
        select FSL_ENETC_MDIO
        select NXP_ENETC_PF_COMMON
-       select NXP_NETC_LIB
+       select NXP_ENETC_NTMP
        select PHYLINK
        select DIMLIB
        help

FSL_ENETC selects the feature it actually wants, and FSL_ENETC_CORE
enables the module based on the set of features that are enabled.
The switch module can then equally enable bool symbol. Not sure
what the best name would be for that symbol, that depends on what
you expect to get added to NXP_NETC_LIB.

     Arnd

