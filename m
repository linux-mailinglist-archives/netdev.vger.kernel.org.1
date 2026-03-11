Return-Path: <netdev+bounces-266453-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOozNojisGkuoAIAu9opvQ
	(envelope-from <netdev+bounces-266453-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 04:33:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A1625BA3D
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 04:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9333B3003EDB
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 03:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E47D36F427;
	Wed, 11 Mar 2026 03:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YSYk97sJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEA736F405
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 03:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773199810; cv=none; b=WLE6CPRmP6eYYlxmijPLwHOJcAEGcroQMTxJHvtWwzrBkpwg57ADKPpEDa4xalRKWMRhVF4gmosjk3DQAPs9W10xT3WPuqSfLREGOjuAE1n6MUdFslEeNOy00JzQuqCuzNxCMm7juuyPAQ2OTEZ/FyZWFOIqpJT+iOfQEWpZTpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773199810; c=relaxed/simple;
	bh=QzIz1oAt5fWaXwhtPtnUhZGfo0RgjSN2Ov4ZHm+h1n4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PotyVwzqyfkiGGuNTwO/cSwfsnoS6u1WT7alsc8bnX83PS0uQG1bRoza/v8rjvyBx3wTo8T87tDQKDeLte8HZwrM/CD81N7zJkxQ8Z2hca6zhWqBJpgt/VZekKrcRldTjWEtTT64pDmgEBBSh8e78v/3IkDcZcTQUIQGytPhoN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YSYk97sJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FF97C4CEF7;
	Wed, 11 Mar 2026 03:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773199809;
	bh=QzIz1oAt5fWaXwhtPtnUhZGfo0RgjSN2Ov4ZHm+h1n4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YSYk97sJ9SqJysQZ2e+LKe5JF2oeMon669dvsrnXF/CPKtTT+iX7CFn9Cyxi0312O
	 hjPuinU77t+AakOLyy0Nt8Z/SU+mshhieo01ogQCeB5EoSOGAodB2JSB14cEPkIoBk
	 BdQD1AYP1mkigaRaXDaiq3JdDvfLdu/B8Q7kCXLex3UpYDHtahM1bhRD6vuMAsB4KX
	 4FZMBAyAJnRAmjFxpyPBNPu5QhGiZOyKLx85V2VyRdPt0yiCwEuai7+6fH2eHbCnCO
	 bs6GzBlgbHfZk4nKVweehjerVJIcwspqC+TVlTy3scnr9i6JXsb9GQ5EbFdW4UBy/F
	 B2opx+ImsewJg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FDBA3808200;
	Wed, 11 Mar 2026 03:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: bcmgenet: fix broken EEE by converting to
 phylib-managed state
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177319980605.3028873.12544875647923886814.git-patchwork-notify@kernel.org>
Date: Wed, 11 Mar 2026 03:30:06 +0000
References: <20260310054935.1238594-1-nb@tipi-net.de>
In-Reply-To: <20260310054935.1238594-1-nb@tipi-net.de>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: netdev@vger.kernel.org, opendmb@gmail.com, florian.fainelli@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 o.rempel@pengutronix.de, rmk+kernel@armlinux.org.uk, andrew@lunn.ch
X-Rspamd-Queue-Id: 35A1625BA3D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266453-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,pengutronix.de,armlinux.org.uk];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Mar 2026 06:49:35 +0100 you wrote:
> The bcmgenet EEE implementation is broken in several ways.
> phy_support_eee() is never called, so the PHY never advertises EEE
> and phylib never sets phydev->enable_tx_lpi.  bcmgenet_mac_config()
> checks priv->eee.eee_enabled to decide whether to enable the MAC
> LPI logic, but that field is never initialised to true, so the MAC
> never enters Low Power Idle even when EEE is negotiated - wasting
> the power savings EEE is designed to provide.  The only way to get
> EEE working at all is a manual 'ethtool --set-eee eth0 eee on' after
> every link-up, and even then bcmgenet_get_eee() immediately clobbers
> the reported state because phy_ethtool_get_eee() overwrites
> eee_enabled and tx_lpi_enabled with the uninitialised PHY eee_cfg
> values.  Finally, bcmgenet_mac_config() is only called on link-up,
> so EEE is never disabled in hardware on link-down.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: bcmgenet: fix broken EEE by converting to phylib-managed state
    https://git.kernel.org/netdev/net/c/908c344d5cfa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



