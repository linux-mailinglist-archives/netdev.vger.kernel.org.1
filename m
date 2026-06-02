Return-Path: <netdev+bounces-293970-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GC3uEptBHmraiAkAu9opvQ
	(envelope-from <netdev+bounces-293970-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 04:36:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3956274F6
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 04:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37C6030A8CE8
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 02:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953BB3655C0;
	Tue,  2 Jun 2026 02:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ipPSxWZy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E28364029;
	Tue,  2 Jun 2026 02:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780367412; cv=none; b=UerR1F2d09klfzRCHt9pC9/2ZCMacuUdG8pSkD/yqjyOGNITWx99Ir1lY7ECkgQb7HL93cdKbMuWyRgN59Lew6YociPWZLlliR4/rACJvB50hN5j+PSon9LeKLqNGCo8J9GKO/zT2EUxHOV6gSTaHrra6V4JlrMg0iOOEjHzblw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780367412; c=relaxed/simple;
	bh=5BLhMfZGw3k4uvxqP+iHP+KyXtJEAN5IoB4Q+aovCKs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FqEgyteYruuQK1EVWtKXCaUmb1OTUm8MeaPMmUINTyJIlBhKwNU/AhzuNxs811wSMAlObwmS90d5hti93GMqb90dnPXaV68qyGM4xZUnYtNML3p1TQunGYvTbWBeAH9BPM+omBu9c1WFe1ZDKx1gG1R9afvZfgrB1XnZadCAnPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ipPSxWZy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B4A1F00893;
	Tue,  2 Jun 2026 02:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780367411;
	bh=lZkSUSYjEMHGPTXhxEmeSrFeNGSiRBa+fB1Z4/owV4I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ipPSxWZy6ltxXo0W9mbZWoBXIhi0svB+AyKAP0MPHzNKQe7CWsVAWhc6xr1iTI6Oh
	 yZg4s5nIOsPen9DY93iuV83OSCrmHVYfqSl2+8Ga5oMKmJuQKHZcLnTnWP3mM5xpNR
	 l4DDMfV6RH+FwxVxShP7bLaOpaMJvefM3TP/NVyx3jbhTkYMEeog6eykhhrgOWK1Pj
	 8ID7mybWm/FxQ0vZOS8rWmE5KxEhMaYY4U0yNTiUU8QMTawc3xGhMAuzVTL0+zXYkM
	 iUFAONcZ5LZfdrHSHTnjTkTipQUaVR90woFfdnmKMCXyGRcB7/IDD4RU47ut79JzNY
	 qXsqxAcHfQnLg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939AE38119F9;
	Tue,  2 Jun 2026 02:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v8] net: phy: sfp: probe for RollBall I2C-to-MDIO
 bridge in mdio-i2c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178036741314.211970.4263055978278493592.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jun 2026 02:30:13 +0000
References: <20260527053909.2118-1-petr.wozniak@gmail.com>
In-Reply-To: <20260527053909.2118-1-petr.wozniak@gmail.com>
To: Petr Wozniak <petr.wozniak@gmail.com>
Cc: netdev@vger.kernel.org, maxime.chevallier@bootlin.com, bjorn@mork.no,
 andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, jan@3e8.eu
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293970-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,bootlin.com,mork.no,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,lists.infradead.org,3e8.eu];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[14];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: AA3956274F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 27 May 2026 07:39:09 +0200 you wrote:
> The "OEM"/"SFP-10G-T" quirk entry in sfp_fixup_rollball_cc()
> unconditionally forces MDIO_I2C_ROLLBALL for all modules matching that
> vendor/part-number combination.  This works for modules that genuinely
> implement a RollBall I2C-to-MDIO bridge, but silently breaks modules
> that share the same EEPROM strings without having such a bridge.
> 
> The Realtek RTL8261BE-CG is one such module: a pure copper 10G SFP+
> media converter with no I2C-to-MDIO bridge.  Its EEPROM reports
> vendor="OEM", part="SFP-10G-T-I", and -- critically -- Vendor OUI
> 00:00:00, making OUI-based differentiation impossible.  With
> MDIO_I2C_ROLLBALL forced, the module silently ACKs the unlock password
> write, the MDIO bus is created, but no PHY responds; the SFP state
> machine cycles through the RollBall PHY-probe retry window before
> reporting no PHY.
> 
> [...]

Here is the summary with links:
  - [net-next,v8] net: phy: sfp: probe for RollBall I2C-to-MDIO bridge in mdio-i2c
    https://git.kernel.org/netdev/net-next/c/8fe125892f40

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



