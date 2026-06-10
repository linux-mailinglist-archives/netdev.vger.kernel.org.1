Return-Path: <netdev+bounces-297371-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8XOdBCW5KGquIgMAu9opvQ
	(envelope-from <netdev+bounces-297371-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 03:08:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B55C66520A
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 03:08:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YLy2frFx;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297371-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297371-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AAC253120DBA
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 01:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85656223323;
	Wed, 10 Jun 2026 01:00:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DCA226D18;
	Wed, 10 Jun 2026 01:00:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781053217; cv=none; b=RbFQ0d5/EWKjiKO/fgA0eckDdbqmThdMuXARV63wBLZt4Ncd5YxaZgPIBLdduqi9xhkSs/rT86u8Y6ovj2eq0lUGMQw3+tZjhjAygvcBfJ3Va76LadWWtZpBVM5MfSFlcIAJvR5tsQML2T2kuakFJD0QpSpW49UwJUW9xecDt6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781053217; c=relaxed/simple;
	bh=0ar/UDNoB5FQEeJyoj/YGB3CudkL8SGpwux+5efRZCM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eexc5HnGvesjORhzn2ClFHNCKIYJCuA01HCrwYQnw5IAtMTqBQlgUyp7aHqveLdiADtxvFE/dRwfc5Vn433X0lnBm078AX4iODXWGzG8fMl4nXjkuNCC1D4zq7Yt6keWMg/eTJ9KWCGI9efxjKMRrONQ21iYDNrZcSV3ydmQXIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLy2frFx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3552F1F00893;
	Wed, 10 Jun 2026 01:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781053216;
	bh=hDAoTDOuNjUpEdVRg9HkIxCJgD+RvY9+JZm3bcdtg9k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=YLy2frFxaE9uau9A0s59GCxNTvMZsTEvUu8A6DslOLlpvRvPxPBEKwq0ICKkAzjAg
	 LhobBANkwRLfzGCUrI4Ep6FllynNzo5Zf9pBE0sjSneZr01G5vRCtyoHv9dsVjgehi
	 OKteZLQsRFAmnskK+LwCTeFLgUOPTJKtNYyZoo615jMXK6Vwvc59IYcx6rD97WvNU1
	 X7l4Y84W6Ec59JZbDblPQvFNgAYwQ3TUxJ+UJbKMQlXXXAo2rXPqGOruLCM6H5MGN9
	 aKSiuOAb4iv+6M3lD/iYLlTXfMw7pQa5ryAEwfskdAn5S6pnYmvF/73vjmQwDfCh5t
	 kruHgvUth8EzQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939363930A12;
	Wed, 10 Jun 2026 01:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next v6 0/3] Add motorcomm 8531s set ds func and 8522 driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178105321414.2773882.3399080630177524080.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jun 2026 01:00:14 +0000
References: <20260605060212.41895-1-minda.chen@starfivetech.com>
In-Reply-To: <20260605060212.41895-1-minda.chen@starfivetech.com>
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Frank.Sae@motor-comm.com, andrew+netdev@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[motor-comm.com,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-297371-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:minda.chen@starfivetech.com,m:Frank.Sae@motor-comm.com,m:andrew+netdev@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5B55C66520A

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  5 Jun 2026 14:02:09 +0800 you wrote:
> This patch is for Starfive JHB100 EVB board. JHB100  contain
> 1 RGMII/RMII and 1 RMII synopsys GMAC cores. In the EVB board, RGMII
> interface connect with YT8531s Ethernet PHY. RMII interface connect
> with YT8522 ethernet PHY. So patch 1-2 is for RGMII interface
> patch 3 is RMII is for RMII interface.
> 
> JHB100 is a Starfive new RISC-V SoC for datacenter BMC (BaseBoard
> Managent Controller). Similar with Aspeed 27x0.
> 
> [...]

Here is the summary with links:
  - [net-next,v6,1/3] net: phy: motorcomm: move mdio lock out from yt8531_set_ds()
    https://git.kernel.org/netdev/net-next/c/0bfd6c8c959d
  - [net-next,v6,2/3] net: motorcomm: phy: set drive strength in YT8531s RGMII
    https://git.kernel.org/netdev/net-next/c/284975d609d0
  - [net-next,v6,3/3] net: phy: motorcomm: Add YT8522 100M RMII PHY support
    https://git.kernel.org/netdev/net-next/c/554cfeb72e09

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



