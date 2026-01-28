Return-Path: <netdev+bounces-254051-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEqDJLFoeWmPwwEAu9opvQ
	(envelope-from <netdev+bounces-254051-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 02:38:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B68599BF49
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 02:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 68FD7300600E
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 01:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6381DED4C;
	Wed, 28 Jan 2026 01:38:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDEF10A1E;
	Wed, 28 Jan 2026 01:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769564332; cv=none; b=nYWN8UnB3WMQUzBdmUpJZUZZ3/ddPuSExqkfnDLyF48WtMO5JEAuCDXz1PeDhET4IT+RF3UbdULTBpp/J01c27HneEXVsOUHFUQbAwvgemwfmud2XbtrwCpm+bgd6gldgWS+aJ8VFZDoF57HfoTup4jBotSV14qv+eXW0hZX+5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769564332; c=relaxed/simple;
	bh=E+LMQtobqNeqqaw4wHk4HwVp+Oa8DY+zHi8isomu0u4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n302i/bmmfeU1SNtLajs11O6QNHw5PA+Dp6lgkqHiNK/UJXUJEPDF+BM08397wrw9CjfeOSq8nd+B1eJXefKkSFmu8gi8HT/C778KlqCGqTMulOQAcgfDdIt6cvzzy57L2m7bUV5Ls9+lgftyGaETrJuEL63kAlT8v0Suq4/nIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vkuW1-000000003lK-38Ef;
	Wed, 28 Jan 2026 01:38:41 +0000
Date: Wed, 28 Jan 2026 01:38:38 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v9 0/4] net: dsa: initial support for MaxLinear
 MxL862xx switches
Message-ID: <aXlonmq2eM6dLqnZ@makrotopia.org>
References: <cover.1769549559.git.daniel@makrotopia.org>
 <20260127225643.qe4lpeyjmtl6flc4@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127225643.qe4lpeyjmtl6flc4@skbuf>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-254051-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[makrotopia.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,vger.kernel.org,gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,makrotopia.org:mid,0.0.0.0:email]
X-Rspamd-Queue-Id: B68599BF49
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 12:56:43AM +0200, Vladimir Oltean wrote:
> On Tue, Jan 27, 2026 at 09:37:40PM +0000, Daniel Golle wrote:
> > This series adds very basic DSA support for the MaxLinear MxL86252
> > (5 PHY ports) and MxL86282 (8 PHY ports) switches.
> > 
> > MxL862xx integrates a firmware running on an embedded processor (running
> > Zephyr RTOS). Host interaction uses a simple netlink-like API transported
> > over MDIO/MMD.
> > 
> > This series includes only what's needed to pass traffic between user
> > ports and the CPU port: relayed MDIO to internal PHYs, basic port
> > enable/disable, and CPU-port special tagging.
> > Follow up series will bring bridge, VLAN, ... offloading,
> 
> I'm surprised the Kconfig help text says:
> 
> 	  These switches have two 10GE SerDes interfaces, one typically
> 	  used as CPU port.
> 
> yet only PHY_INTERFACE_MODE_INTERNAL is set in phylink supported_interfaces.
> You're also not making any mention of future SerDes support. What's up
> with that, how do the SerDes ports currently work and how are they
> described? (as internal?!)

Oh, sure, I'm obviously going to add both SerDes interfaces which support
various interface modes as phylink_pcs instances in a follow-up series.
I was planning to do basic bridge offloading and FDB access first, then
SerDes PCS, then LAG, then VLAN, and then last but not least using the
802.1Q-based special tag (LoC of just that feature is almost as much
as all the rest together in the vendor driver).

> 
> > and support for using a 802.1Q-based special tag instead of the
> > proprietary 8-byte tag.
> 
> Why is that?

Using an 802.1Q-based special tag is advantageous in some situations,
for example PPE offloading engines typically do support 802.1Q and
802.1ad VLANs, but do not support any special tag apart from those
of the same vendor (eg. MediaTek's PPE supports MediaTek's 4-byte
special tag, but includes "plain" 802.1Q or 802.1ad/Q-in-Q as part of
the tuple identifying a flow). Hence by implementing an 802.1Q-based
tag one can benefit from better performance, less CPU load and less
energy consumption when combining these switches with router SoCs
of other vendors if they implementing "picky" offloading fast-paths.

> 
> Another (related) question. You have this comment in tag_mxl862xx.c:
> 
> 	/* switch firmware expects ports to be counted starting from 1 */
> 
> from which I don't completely understand how is the firmware involved
> (does it process the tags?). Would the expectation also apply to the
> 802.1Q based tagger?

No. The 802.1Q-based tagger is basically implemented entirely by
setting up additional bridges, virtual bridge ports and special VLAN
forwarding rules. It takes more than just "switching" the tag protocol...
But hence it can be implemented in pretty much any way we want.

> 
> What's the real story behind port index 0? Does it really not exist, or
> is it some attempt to hide an internal port that's not supposed to be used?

It's just an oddity of the management firmware which runs on the switch.
Port ID 0 has special meaning, physical ports are counted started from 1.
For example, when adding FDB entries, port_id == 0 means not specifying a
port (eg. for filter rules). However, it *is* weird that BIT(0) of any
portmap isn't ever used in the driver, and it looks like it could be like
you describe below. I will ask.

> 
> If the latter, I guess something like the snippet below (seen in
> arch/arm64/boot/dts/freescale/fsl-lx2160a-bluebox3.dts) would simplify
> the driver by a bit:
> 
> 	ethernet-switch@0 {
> 		...
> 		ethernet-ports {
> 			...
> 			/* Microcontroller port */
> 			port@0 {
> 				reg = <0>;
> 				status = "disabled";
> 			};

This construct could never the less help to make things more easy and
less annoying to deal with. I might just start counting from reg = <1>
in DT and have a dummy/reserved port 0.

Always having add/substract 1 is often confusing because then you have
to remember if a port number or mask stored in some structure or
variable denotes the DSA perspective or the switch firmware perspective.
Unifying the two would definitely be beneficial. I can give that a short
tomorrow.

