Return-Path: <netdev+bounces-289702-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AADWBqwVDWq5tAUAu9opvQ
	(envelope-from <netdev+bounces-289702-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 04:00:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CBD586ABA
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 04:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D829A304EA1D
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 02:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E7E2EC0A6;
	Wed, 20 May 2026 02:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9f4NwEb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938752F60CC;
	Wed, 20 May 2026 02:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779242407; cv=none; b=j8IXkQeuTYYKu8KkNBZbM9uotTM+TDpV0atlaDQdnPFbaiY3pOuv1VpVEsyMQM3Hs1ZXRxBX8PtMNQRmmc7heSXyErfvdkpdSa5HSwC1xw6AxP1myqJeXoW0u7fRWHoe2gZxrlv/j60qwEqhhiFfFoiuo0WRFZosJ/gsHNXlErA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779242407; c=relaxed/simple;
	bh=BYGPsytrtkRO+sSiddM+AZqQ/HNotpAfxkMGtcT1rUo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OoV636DhtrQmyi+oDnnYjpc8a66Rylz6MO7wxSEcoeFlvg47b42mLbVtDZ5ZJpUigSqluIPsOAKw9+++hijfIxFCYU38oZVBbdUEYn14DahIswQuVN6M5TdrmSFeJIms2drHhE7ovNHoUXv2hfrz5Q1fVmtJcSZods3CztHnhes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N9f4NwEb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B2E41F000E9;
	Wed, 20 May 2026 02:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779242405;
	bh=KJL+VNKQIYqPGR7y+zxbrQJi9fZGd82JKXah/thK31g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=N9f4NwEbJPSwXvT33Pduas1R6SWtdVSonbdxx2Hk2BuXWhHL18E6XQiLrI8Y9HTsZ
	 ASqRCVi8K2Cf8ar59fjSPHGw/XefMr44ehCLB0+PF9qNJ5Wbk821JMatvaPSaJdTEm
	 3YdNy9s9TNsJx48viIj7eBzhJ0YMUhGIF8vhxgVzds9AgsR10wZh3BUm3ERGscNOJl
	 ibJBpr+8B/SjNsU+/y4oFYHKB7CBo7hQNubfT8s9FFCP+3tdpA8EZmdZ5B6MVpynWl
	 XUY6CfCk4rnEIOWDok5E7cOCNqFigETRvu9fWV4wmMiSfJVnAjrzepFd/ieLaCa2lA
	 CJTSxT03lPTpg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56917383BF53;
	Wed, 20 May 2026 02:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] net: phy: honor eee_disabled_modes when
 advertising EEE
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177924241589.2949285.12161397652811928988.git-patchwork-notify@kernel.org>
Date: Wed, 20 May 2026 02:00:15 +0000
References: <20260518-devel-phy-support-eee-fix-v2-0-05b52626fa68@tipi-net.de>
In-Reply-To: 
 <20260518-devel-phy-support-eee-fix-v2-0-05b52626fa68@tipi-net.de>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 o.rempel@pengutronix.de, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289702-lists,netdev=lfdr.de,netdevbpf];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,pengutronix.de,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: B7CBD586ABA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 18 May 2026 10:23:08 +0200 you wrote:
> While debugging why ethtool --show-eee reports "not supported" on a
> Raspberry Pi CM4 with eee-broken-1000t / eee-broken-100tx set on the
> PHY node, I noticed two phylib helpers copy phydev->supported_eee
> into phydev->advertising_eee without applying
> phydev->eee_disabled_modes: phy_support_eee() and
> phy_advertise_eee_all(). That undoes the filtering phy_probe() set
> up after of_set_phy_eee_broken(), so the PHY ends up advertising EEE
> for modes that were marked broken in DT (or by the driver via
> eee_disabled_modes).
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] net: phy: honor eee_disabled_modes in phy_support_eee()
    https://git.kernel.org/netdev/net/c/3655063e0838
  - [net,v2,2/2] net: phy: honor eee_disabled_modes in phy_advertise_eee_all()
    https://git.kernel.org/netdev/net/c/8baa7506d793

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



