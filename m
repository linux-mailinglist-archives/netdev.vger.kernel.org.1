Return-Path: <netdev+bounces-296843-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PBISG2BxJ2rNwwIAu9opvQ
	(envelope-from <netdev+bounces-296843-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 03:50:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D89C65BBF9
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 03:50:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=gWmJUGF3;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296843-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296843-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5540930190A0
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 01:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C871F3148D8;
	Tue,  9 Jun 2026 01:50:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E6E26B2D3;
	Tue,  9 Jun 2026 01:50:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780969814; cv=none; b=V5NwTMUSOnnb6NtdSMdMtOV9FX4Co/EVjzQY7SGuIgckbpwIK+2eah/yZio0qeVbOmeVavpNi/NKfrYKAwdbZSAENl696BacN8dIp7XsNhyrHFUicEWXWrj9u+pYqsaoFTuVzxUFUqjwR88nWpuSfw8+m09BvxAul8s3fOYUUzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780969814; c=relaxed/simple;
	bh=+S+lC0jY+Jo/2wR3SS6lDlzMKUfNQOME3/2fjYtUNf0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MxnjROf8q6F67asBI0FmHSKGESUHpzZpNjZed1L54adH6TIwf0RklBcG5gAQo8+HQhsxCFQ9sOwCIntgzzCNmNLPpMtxCr7L36ejyM5nnugkrM6BjJx5E9DIHoAETWsyjfN0zoF4Dy50N2J5xPppeGR2Hhmr0SpqFIJw2ZO8snw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gWmJUGF3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 714661F00893;
	Tue,  9 Jun 2026 01:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780969813;
	bh=I/qW2ZWDmN1uGRnA6d/46veWaR2fOxtQbLCPBaAnt5E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gWmJUGF3hkkV+dgGtZ++tnZcAmv+R/J7eoJ3YT9O5Z/tu/i61K6NUKRqIoOqQ0Mqk
	 t1k+IlA88aVcuOeptmddGd3X9ff4TN/8ubyY/6rjaCo8qy3o7TXcT+Jq+g5t9IrdFr
	 U8LaeZWY4lrm6vWU4FaxlEwbk1Q3HrQNU01WicIFso92ooQn9FeYb8gKg48vkd5O2z
	 Do4EOecfwPo1BFFDOYOzrbQE71aZKvzpEbRNK/s1Vkp1tV0cxZhjmuotINHN2c7pJZ
	 U9JrSRRMZAI2Ro03lVVZXjh7O4sNMX/oje/mx8Z2jRZ0eQp6OZrXrEXlxEz93qEMZY
	 ZHu6vXeKSFsqA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569313822D43;
	Tue,  9 Jun 2026 01:50:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/4] net: phy: some cleanups following phy_port SFP
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178096981189.1750436.8360276227071708223.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jun 2026 01:50:11 +0000
References: <20260604092819.723505-1-maxime.chevallier@bootlin.com>
In-Reply-To: <20260604092819.723505-1-maxime.chevallier@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
 hkallweit1@gmail.com, nb@tipi-net.de, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296843-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,gmail.com,tipi-net.de,vger.kernel.org,bootlin.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:maxime.chevallier@bootlin.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:hkallweit1@gmail.com,m:nb@tipi-net.de,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:thomas.petazzoni@bootlin.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5D89C65BBF9

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  4 Jun 2026 11:28:14 +0200 you wrote:
> While posting the v11 of phy_port netlink, sashiko found some
> pre-existing issues, and following the tentative fix, Nicolai found
> some more :)
> 
> This is V3, with a re-ordering of the port/sfp cleanup, as well as a new
> patch (patch 3) that also reorders the phy_remove() path.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/4] net: phy: clean the sfp upstream if phy probing fails
    https://git.kernel.org/netdev/net/c/48774e87bbaa
  - [net,v3,2/4] net: phy: remove phy ports upon probe failure
    https://git.kernel.org/netdev/net/c/b1e780bb37c6
  - [net,v3,3/4] net: phy: Clean the phy_ports after unregistering the downstream SFP bus
    https://git.kernel.org/netdev/net/c/4497f5028675
  - [net,v3,4/4] net: phy: don't try to setup PHY-driven SFP cages when using genphy
    https://git.kernel.org/netdev/net/c/5a0082ec20a0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



