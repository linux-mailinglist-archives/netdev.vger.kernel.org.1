Return-Path: <netdev+bounces-258531-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OpuxGGSKjmmrCwEAu9opvQ
	(envelope-from <netdev+bounces-258531-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 03:20:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC15E13263D
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 03:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D52C1304B582
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 02:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC791990A7;
	Fri, 13 Feb 2026 02:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u8JeUPyF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4EC70818;
	Fri, 13 Feb 2026 02:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770949217; cv=none; b=EHHDztS16+jiOblEFV5bp5uSRDSAGSOjbaRpCPfe3omn0pIqxMBGFDgEq4Sk60xJxlk7gxGi88iWiKANZLoSJc0HloCw3GknjUXHobiVgBlJKVjitzozc1fWnlcPotJjNQQ1jjzUOg34iWscLb2PxwIYamwM5HRejjvqZ+H03Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770949217; c=relaxed/simple;
	bh=KVJRW17C7sh+mCqqggDVf+p3AsjZNV+7KND16EJGoX0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=h5UQ3GOCwUsu1m3XqxW+7PJQzp9YIcqhGZKfRvhNRXEw2Ge4tsSG+qEBuE5Zy0OYqPJK4Dg9h0EljdvXN59N80Iq4JzudlGVH5gY7QRfafGsuS1Dq4GuQWCEjO4PGEmde+JrdFe3w+eMCjqsjTHlIt+21YpSxwDzSzpZa8nwVVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u8JeUPyF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E04C4CEF7;
	Fri, 13 Feb 2026 02:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770949216;
	bh=KVJRW17C7sh+mCqqggDVf+p3AsjZNV+7KND16EJGoX0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=u8JeUPyFSUOjz3+LtjcJovDa65OlPmukbHrXMJZ+qUgBzM9K2mN0+0La8q+DhNEDZ
	 jBpYY81sWxdd2ttr9x7XxnkWRmzzT2j6NLz96M/2pm6BFgARLRLW6Hm5GkJ5ZGsAX2
	 YNilifONlkw/6d1+Ec3RRkZK0El2PRQEyWFp36FDTP1++p1NmofptBSGus58ZLg0Gd
	 qmX/N5aPih7m7L81DrB1z/WovAQXLzlQfi5KsSC+C6IffU+1fVS5gVNUFAaUixxoJX
	 TFup7hoSV2WLNGFAAeI2nCqmsYVhdqVogesZNfoDVen36jpXaNOYWaGf1zWeH7Gcw6
	 Car9s+vOjrz5Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B1BB393108D;
	Fri, 13 Feb 2026 02:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 00/13] net: phy_port: SFP modules
 representation
 and phy_port listing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177094921083.1813136.18724223328419482.git-patchwork-notify@kernel.org>
Date: Fri, 13 Feb 2026 02:20:10 +0000
References: <20260205092317.755906-1-maxime.chevallier@bootlin.com>
In-Reply-To: <20260205092317.755906-1-maxime.chevallier@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, andrew@lunn.ch, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, linux@armlinux.org.uk, hkallweit1@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, christophe.leroy@csgroup.eu,
 herve.codina@bootlin.com, f.fainelli@gmail.com, vladimir.oltean@nxp.com,
 kory.maincent@bootlin.com, kabel@kernel.org, o.rempel@pengutronix.de,
 nicveronese@gmail.com, horms@kernel.org, mwojtas@chromium.org,
 romain.gantois@bootlin.com, daniel@makrotopia.org,
 dimitri.fedrau@liebherr.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258531-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[davemloft.net,lunn.ch,kernel.org,google.com,redhat.com,armlinux.org.uk,gmail.com,vger.kernel.org,bootlin.com,csgroup.eu,nxp.com,pengutronix.de,chromium.org,makrotopia.org,liebherr.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AC15E13263D
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  5 Feb 2026 10:23:03 +0100 you wrote:
> Hello everyone,
> 
> Here's V5 of the second phy_port series, this time bringing support for
> more phy_port use especially for SFP, as well as the begining of a
> ethnl uAPI.
> 
> V5 doesn't contain a lot of changes, only a doc formatting fix as well
> as a fix for a potentially un-initialized pointer.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,01/13] net: phy: initialize the port support based on the PHY's for OF ports
    https://git.kernel.org/netdev/net/c/056166710543
  - [net-next,v5,02/13] net: phy: phy_port: Cleanup the of-parsing logic for phy_port
    https://git.kernel.org/netdev/net/c/6248f3dc4ec5
  - [net-next,v5,03/13] net: phy: phy_port: Correctly recompute the port's linkmodes
    https://git.kernel.org/netdev/net/c/4cebb26ac6f0
  - [net-next,v5,04/13] net: phy: phy_link_topology: Add a helper for opportunistic alloc
    (no matching commit)
  - [net-next,v5,05/13] net: phy: phy_link_topology: Track ports in phy_link_topology
    (no matching commit)
  - [net-next,v5,06/13] net: phylink: Register a phy_port for MAC-driven SFP busses
    (no matching commit)
  - [net-next,v5,07/13] net: phy: Create SFP phy_port before registering upstream
    (no matching commit)
  - [net-next,v5,08/13] net: phy: Represent PHY-less SFP modules with phy_port
    (no matching commit)
  - [net-next,v5,09/13] net: phylink: Represent PHY-less SFP modules with phy_port
    (no matching commit)
  - [net-next,v5,10/13] net: phy: phy_port: Store information about a MII port's vacant state
    (no matching commit)
  - [net-next,v5,11/13] net: phy: phy_link_topology: Add a helper to retrieve ports
    (no matching commit)
  - [net-next,v5,12/13] netlink: specs: Add ethernet port listing with ethtool
    (no matching commit)
  - [net-next,v5,13/13] net: ethtool: Introduce ethtool command to list ports
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



