Return-Path: <netdev+bounces-262412-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id VLoXGC5kpGkEfgUAu9opvQ
	(envelope-from <netdev+bounces-262412-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 17:07:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8541D0883
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 17:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 01A9D300EC90
	for <lists+netdev@lfdr.de>; Sun,  1 Mar 2026 16:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2A830FC39;
	Sun,  1 Mar 2026 16:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="g/2OFQbR"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266B530F52A;
	Sun,  1 Mar 2026 16:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772381227; cv=none; b=GHG3aGpfFF/iemYaRHb/yzEfvdCf9mvoatv+qEWcfTu8MC4tz7FwReRLuXrAuA6DyjbOfAQvdhUeV18dBhS4tSrb8ocFjKSyEjAPu4Z028X0o5LWT1NUMEgbzhH2mvod5qsGEKNkf23lWi9j0emX01xpn0xlRBCjUjwUmbCo7zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772381227; c=relaxed/simple;
	bh=+llgIQSiCgyCTrSRZ0Rz6MkwRQ99zmp/mxB+MF4YJ78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RbBUvCovdpiDSudj/BG7cgFTvmGD/KDqh5Okc1oWtFKeUNwQ4A5TImNvXY5H08eA+i9ovpKpPZ+SrJ+qWnD+2Kbm868Fl2rD2IvCAMqqKAcplHka2wUdGfTyeBLfwkgpfFOaGnUYu3QkRL21doOnzwHjhlsX+WpNsGsPJYvAS6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=g/2OFQbR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=sOb8j05vBdsrUTlJv+rQrw8oPgLqIwNpKX3pun5b7nM=; b=g/
	2OFQbRTKzvv9wn4MPLJwNGpl0nyA7s8nIfgbcadb2VU7S3BP2N5dJK3EoxzEKctkxEIUD/TEmYSau
	SSaAVQ5q5HVz5OClljNz8Kf10arjsrvIHyUhalaBH/SVdl8AypDn7VATKJUXL5RXXOdLSMX3rV5Sm
	rsBkATazrMUzDcI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vwjJq-009Oqm-5n; Sun, 01 Mar 2026 17:06:58 +0100
Date: Sun, 1 Mar 2026 17:06:58 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub =?utf-8?B?VmFuxJtr?= <linuxtardis@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Frank <Frank.Sae@motor-comm.com>,
	Sai Krishna <saikrishnag@marvell.com>,
	Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH net-next v2 0/5] net: phy: Disable MDIO broadcast address
 on YT8821
Message-ID: <d0b2a87a-e981-4245-803d-d57c401b6156@lunn.ch>
References: <20260228232241.1274236-1-linuxtardis@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260228232241.1274236-1-linuxtardis@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262412-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,motor-comm.com,marvell.com,makrotopia.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: AD8541D0883
X-Rspamd-Action: no action

On Sun, Mar 01, 2026 at 12:22:36AM +0100, Jakub Vaněk wrote:
> Hello,
> 
> this series is a rewrite of patch [1], which attempted to make the
> Motorcomm YT8821 PHY operate reliably in the Cudy M3000 WiFi router.
> 
> Background
> ==========
> 
> The issue on the Cudy M3000 is an MDIO address collision at address 0:
> 
>  * The MediaTek MT7981B internal Gigabit PHY appears to be hardwired
>    to respond only at MDIO address 0.
> 
>  * The Motorcomm YT8821 external PHY responds, by default, at address 0
>    in addition to address 1 selected by its strapping pins.
> 
> At a minimum, this means that MDIO transactions intended for the
> MT7981B PHY are also interpreted by the YT8821, which causes the
> YT8821 to not work reliably.
> 
> The YT8821 is not unique in this regard. At least two other vendors
> ship PHYs with similar behavior:
> 
>  * Realtek RTL8221B-VB-CG
>  * Micrel KSZ8081
> 
> It appears to me that multiple vendors may have interpreted IEEE 802.3
> Clause 22.2.4.5.5 to mean that MDIO address 0 is a reserved broadcast
> address ("A PHY [...] shall always respond to transactions addressed
> to PHY Address zero"). However, the omitted part of that sentence
> limits the scope, and it does not apply to many PHY types.

I stopped being lazy and looked at 802.3:

  22.2.4.5.5 PHYAD (PHY Address)

  The PHY Address is five bits, allowing 32 unique PHY addresses. The
  first PHY address bit transmitted and received is the MSB of the
  address. A PHY that is connected to the station management entity
  via the mechanical interface defined in 22.6 shall always respond to
  transactions addressed to PHY Address zero <00000>. A station
  management entity that is attached to multiple PHYs has to have
  prior knowledge of the appropriate PHY Address for each PHY.

And

  22.6 Mechanical characteristics

  When the MII is used to interconnect two printed circuit assemblies
  via a short length of cable, the cable shall be connected to the
  circuit assembly that implements the Reconciliation sublayer by
  means of the mechanical interface defined in this clause.

  22.6.1 Definition of mechanical interface

  A 40-pole connector having the mechanical mateability dimensions as
  specified in IEC 61076-3-101:1997 shall be used for the MII
  connector. The circuit assembly that contains the MAC sublayer and
  Reconciliation sublayer shall have a female connector with screw
  locks, and the mating cable shall have a male connector with jack
  screws.

Does your board have this 40-pole connector and screw locks?

I don't think i have seen one of these in the last 30 years. I do
remember during my University times some Sun Microsystems, maybe a
Sun-2, with a fat maybe 2 meter cable running into the false floor to
a transceiver box onto the one Ethernet cable which snaked around the
Computing Department.

So this should not apply to any board from this century which is
conforming to the 802.3 standard.

So i would say the board you are trying to support is broken twice.

1) It is using part of 802.3 which does not apply.

2) It has two PHYs which using the same address.

I can understand a PHY might support this, optionally, with a
pull-up/down strapping, saying "Break the standard, also respond to
address 0". But this clearly should be an opt in, and an extra
component is required.

I'm still not convinced Linux should be handling either of these
conditions. And even if it did, it should not be in the core, but
hidden away in a driver.

       Andrew

