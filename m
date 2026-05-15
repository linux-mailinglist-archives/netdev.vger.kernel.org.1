Return-Path: <netdev+bounces-288139-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNzvEB51BmoUkAIAu9opvQ
	(envelope-from <netdev+bounces-288139-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 03:21:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2285485CE
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 03:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C773430117A1
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 01:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB6236BCC2;
	Fri, 15 May 2026 01:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eeKDV1HQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BC7369996;
	Fri, 15 May 2026 01:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778808078; cv=none; b=O3GHFbr1tYYLzvXooHL3OvG1MUVuYkeCp4glaA/lLAv4RXBCg7uNNU2Zo4JBpJM3Chu3pyu19OXCfPDXibUAUCi4UPd2/s1wxOymHKXkCLR91UqtuGQz9qPiqWlUPH0Zn2ZSsxJpHxIeUNFMwAojUM3VB+JLQn13+t0ufZ5tHTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778808078; c=relaxed/simple;
	bh=EYakZJnrsCp2LtH/mUVef1nhtd/d/cDDIT3+HoDZ7es=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EurNAsTMIeBQccmFG7T6DC3EQ6BcyrCnrolXSpmb31rAnvGgZD9sawcb6/sZQoAdJRuOPv6pEXjE8j2Pty3d520VYlIbnw+GHBkG9jkQkoIbsNiLB2i+dcxz9rIcgRlfA5Sw/jzTKOJo8qBOYt/970deFuglNwm2gz1sdpGka/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eeKDV1HQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A98C2BCC6;
	Fri, 15 May 2026 01:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778808078;
	bh=EYakZJnrsCp2LtH/mUVef1nhtd/d/cDDIT3+HoDZ7es=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eeKDV1HQ1Z8nA6hTR7Lq1g1SB8+itrIZjda8YrqbL060YWPu68jbXt3LasPGRlw0h
	 r3eQPEhw4p3NR6eOXpH/eHAGOy40sYnKn563fmNwt3QUMYy6LPtNlTDikE9VoT0fwE
	 +7ZIoFsO0R6mlJ+x/B5bgFOW/UMy03E/0xOxSpvNAAi72Vqz2/2VO3povpL/JwCXLu
	 O3JmX70VHjBG7F/BpDJA/XPAFR6WJyAFom2kSryLF3Dt5GhVD9bfmapjyLVx32z7Ez
	 +yVc1SCtZpEyqlZ2ZZxfSOs/4akMMobKFJnHGnHIIGxAUPK04WHNsqLOeBEEnRACvM
	 BHLl8Cmj1eucg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E8739E4DB5;
	Fri, 15 May 2026 01:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/15] net: dsa: microchip: Remove unnecessary
 ksz_dev_ops callbacks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177880802253.150313.13537764865485542251.git-patchwork-notify@kernel.org>
Date: Fri, 15 May 2026 01:20:22 +0000
References: <20260512-clean-ksz-2nd-series-v1-0-c00f6ce037fa@bootlin.com>
In-Reply-To: <20260512-clean-ksz-2nd-series-v1-0-c00f6ce037fa@bootlin.com>
To: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux@armlinux.org.uk, richardcochran@gmail.com,
 pascal.eberhard@se.com, miquel.raynal@bootlin.com,
 thomas.petazzoni@bootlin.com, tristram.ha@microchip.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, vladimir.oltean@nxp.com
X-Rspamd-Queue-Id: 0A2285485CE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,se.com,bootlin.com,vger.kernel.org,nxp.com];
	TAGGED_FROM(0.00)[bounces-288139-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 12 May 2026 15:06:22 +0200 you wrote:
> Hi all,
> 
> This series continues the rework of the KSZ driver initiated by a previous
> series (see [1]), following the discussion we had here [2].
> 
> The KSZ driver got way too convoluted over time because it uses a common
> framework to handle more than 20 switches split in 5 families (see below
> table)
> 
> [...]

Here is the summary with links:
  - [net-next,01/15] net: dsa: microchip: remove unused phylink_mac_link_up() callback
    https://git.kernel.org/netdev/net-next/c/83ea7fd73b11
  - [net-next,02/15] net: dsa: microchip: bypass dev_ops for FDB ageing operations
    https://git.kernel.org/netdev/net-next/c/f27ae140c8da
  - [net-next,03/15] net: dsa: microchip: bypass dev_ops for change_mtu() operation
    https://git.kernel.org/netdev/net-next/c/9f16bc5c737d
  - [net-next,04/15] net: dsa: microchip: bypass dev_ops for VLAN operations
    https://git.kernel.org/netdev/net-next/c/e439c7871efb
  - [net-next,05/15] net: dsa: microchip: bypass dev_ops for FDB and MDB operations
    https://git.kernel.org/netdev/net-next/c/ede165ba0bd0
  - [net-next,06/15] net: dsa: microchip: bypass dev_ops for mirror operations
    https://git.kernel.org/netdev/net-next/c/5973ddcc1765
  - [net-next,07/15] net: dsa: microchip: bypass dev_ops for phylink_get_caps()
    https://git.kernel.org/netdev/net-next/c/82e5193a4e50
  - [net-next,08/15] net: dsa: microchip: don't reset on shutdown or driver removal
    (no matching commit)
  - [net-next,09/15] net: dsa: microchip: bypass dev_ops->setup() and teardown() for lan937x
    (no matching commit)
  - [net-next,10/15] net: dsa: microchip: bypass dev_ops->setup() and teardown() for ksz9477
    (no matching commit)
  - [net-next,11/15] net: dsa: microchip: bypass dev_ops->setup() and teardown() for ksz8
    (no matching commit)
  - [net-next,12/15] net: dsa: microchip: remove dev_ops->setup() and teardown()
    (no matching commit)
  - [net-next,13/15] net: dsa: microchip: bypass dev_ops for port_setup()
    (no matching commit)
  - [net-next,14/15] net: dsa: microchip: call DSA's phy_{read/write} to do mdio {read/write}
    (no matching commit)
  - [net-next,15/15] net: dsa: microchip: bypass dev_ops for phy_read()/phy_write()
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



