Return-Path: <netdev+bounces-255304-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id bwdEJoJdfWnaRgIAu9opvQ
	(envelope-from <netdev+bounces-255304-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 02:40:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B5AC00BA
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 02:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 82A833004630
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 01:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4723093C1;
	Sat, 31 Jan 2026 01:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LSsGjh+F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF0A2FE078
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 01:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769823616; cv=none; b=c+GZXG31d33Zz4BZA3+vbXs2EdpuzxSWxcdumsL12A9xqWfHh3vztLpVN9wmZwJHlRAUANqapCbtGywCBbtmqEBAFzxuY2UFu3+hiZa2mcJR4ywA9gB2vy0OsP1fDNjGDcuZr1NclHBxYZ6re9haqxXCZjp33dbR7SFQKRxlL54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769823616; c=relaxed/simple;
	bh=hK1tQTsvZhIDk118dbaaJLk80Rf5EfXazKjkSAUi5Lw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GHM3LjIvvri/2GAOADJB91tT9saYwVynwjClFX3yNumK1MN3To2U4GJP7KHlwbAHefg6KYxhlSrDDLdS8H0QvKtblKk4Kk9lSMOSx8zy6oBvKnwJsc934tk6gHNNOFyE7Spjx+fzOLroBpnkCyTl5O/0AQcHdwhO02vbKv9ECok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LSsGjh+F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA86C4CEF7;
	Sat, 31 Jan 2026 01:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769823615;
	bh=hK1tQTsvZhIDk118dbaaJLk80Rf5EfXazKjkSAUi5Lw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LSsGjh+FtuNLdSERLGFDGsjQrtkSSw3d28RNE47VzWTs+JdS2/XFN7BB/VdxnwvFL
	 kF9FAKqdb8B7hWpbn3Z1lOZjdfi5jS3IePFvaHIHoSqbrcnaRlcQVBF5vRUA8+Eqc/
	 +/EfggwmS1Y26cRRG9vHxKvaZg5OnKAzpALXpWgVDjNSLQK3jR++ZxM1sRXslBc4AD
	 qcFqBvNuGIfj0iJOGYYR26UIVPVAF3zTC5tJY4AD/dv7Wt0adj+vASASx0PFKMNCLl
	 nu4cdS0BRcCX8omwMyJbAKjWkXjswlfBfARa+G0RlemTiF0G70U9g4II5wm/H5W0QK
	 eZhXxGvN0tQHw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8C17380CFFB;
	Sat, 31 Jan 2026 01:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: sfp: Fix quirk for Ubiquiti U-Fiber Instant
 SFP
 module
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176982360761.3959411.13092213705743627382.git-patchwork-notify@kernel.org>
Date: Sat, 31 Jan 2026 01:40:07 +0000
References: <20260129082227.17443-1-kabel@kernel.org>
In-Reply-To: <20260129082227.17443-1-kabel@kernel.org>
To: =?utf-8?q?Marek_Beh=C3=BAn_=3Ckabel=40kernel=2Eorg=3E?=@codeaurora.org
Cc: netdev@vger.kernel.org, linux@armlinux.org.uk, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 hkallweit1@gmail.com, andrew@lunn.ch, maxime.chevallier@bootlin.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:-];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,armlinux.org.uk,redhat.com,kernel.org,google.com,davemloft.net,gmail.com,lunn.ch,bootlin.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-255304-lists,netdev=lfdr.de,netdevbpf];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20201202];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.786];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 38B5AC00BA
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 29 Jan 2026 09:22:27 +0100 you wrote:
> Commit fd580c9830316eda ("net: sfp: augment SFP parsing with
> phy_interface_t bitmap") did not add augumentation for the interface
> bitmap in the quirk for Ubiquiti U-Fiber Instant.
> 
> The subsequent commit f81fa96d8a6c7a77 ("net: phylink: use
> phy_interface_t bitmaps for optical modules") then changed phylink code
> for selection of SFP interface: instead of using link mode bitmap, the
> interface bitmap is used, and the fastest interface mode supported by
> both SFP module and MAC is chosen.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: sfp: Fix quirk for Ubiquiti U-Fiber Instant SFP module
    https://git.kernel.org/netdev/net/c/adcbadfd8e05

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



