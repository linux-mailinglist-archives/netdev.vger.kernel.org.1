Return-Path: <netdev+bounces-277883-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEMDL9L122lTJgkAu9opvQ
	(envelope-from <netdev+bounces-277883-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 21:43:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2799B3E5C35
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 21:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E61D300D148
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 19:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90413783CE;
	Sun, 12 Apr 2026 19:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0ZSsHhv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85775373C0B;
	Sun, 12 Apr 2026 19:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776022849; cv=none; b=knsoFIv1FCtn5sxkpNK5Pi82wYjiorERQR2kOl+RFcIB6okrcTgIOTxGpUqY6fn3I6WHa2G0Kb0mDML2RC4Z9gmo9tzsGf86kLldcuhYrmm9rnCcINjdP+ezd5R1hEbSQHG7ubpzexUpXEI9LlcBhb2qfeZFFU50PanW76Qg1C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776022849; c=relaxed/simple;
	bh=UUv9Q5z6qenMw6do4CqKrZErSGt5eJr/+pTUCYz+5HM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FS/xBKUlDxNbqWhP8jrSvRUr5PiLmANqe5M6P8wQnaTPFcTDM/lBPCitX0JxZpSLyblH3/ogtU8TwmSLCii1pF4ATWtIshn+jTbQMXDRBqJUxqstZP4t/uaUJPyPGQyN6f4HRGxMgNusFwzHSrzyJqOJopykRT91w1gavq84/fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0ZSsHhv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E636C19424;
	Sun, 12 Apr 2026 19:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776022849;
	bh=UUv9Q5z6qenMw6do4CqKrZErSGt5eJr/+pTUCYz+5HM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=g0ZSsHhvJG3GiMsDkjpByTh6frMng7weQ7JZBItFCh8O1nend6EM3lQO09/RHEaPV
	 PTVjT0PGgMclUtkA60vsBRLKHiL96aWQUiVCSXHcT17OYWc7s7LhZCO4DCxCKmMZGx
	 d8SpVGN2n4wnYgzYXMHmb4s5oI8f+pwyW3i5KMyxg/A6u4X5jy6oZ7PNUylXq8wZhh
	 Sc45VGSQPGQOIuCzwXNQk+Wh0WALkgHfXGMNMyT2jbL0TCPmVAmzT0oFn5rtieoBIB
	 DhmJIXAIStF8WnDBTfe7zvXNN2LiJRSvN3bFcQ4IHwqsLRQN42pzhylaxbpcq3P9k0
	 2A/4ssK6RgM6w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9DF73809A8C;
	Sun, 12 Apr 2026 19:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] net: phy: add support for disabling
 autonomous EEE
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177602282128.3388150.5265096246328636677.git-patchwork-notify@kernel.org>
Date: Sun, 12 Apr 2026 19:40:21 +0000
References: <20260406-devel-autonomous-eee-v1-0-b335e7143711@tipi-net.de>
In-Reply-To: <20260406-devel-autonomous-eee-v1-0-b335e7143711@tipi-net.de>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,broadcom.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-277883-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[12];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2799B3E5C35
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 06 Apr 2026 09:13:06 +0200 you wrote:
> Some PHYs implement autonomous EEE where the PHY manages EEE
> independently, preventing the MAC from controlling LPI signaling.
> This conflicts with MACs that implement their own LPI control.
> 
> This series adds a .disable_autonomous_eee callback to struct phy_driver
> and calls it from phy_support_eee(). When a MAC indicates it supports
> EEE, the PHY's autonomous EEE is automatically disabled. The setting is
> persisted across suspend/resume by re-applying it in phy_init_hw() after
> soft reset, following the same pattern suggested by Russell King for PHY
> tunables [1].
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] net: phy: add support for disabling PHY-autonomous EEE
    https://git.kernel.org/netdev/net-next/c/7ef629b45801
  - [net-next,2/3] net: phy: broadcom: implement .disable_autonomous_eee for BCM54xx
    https://git.kernel.org/netdev/net-next/c/bcb3e89fc0ec
  - [net-next,3/3] net: phy: realtek: convert RTL8211F to .disable_autonomous_eee
    https://git.kernel.org/netdev/net-next/c/bb14e3b63c63

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



