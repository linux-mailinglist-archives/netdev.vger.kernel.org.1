Return-Path: <netdev+bounces-257272-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMXLMVvXhGlo5gMAu9opvQ
	(envelope-from <netdev+bounces-257272-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 18:46:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C69F61FB
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 18:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A0DB30A90C8
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 17:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DE62FB997;
	Thu,  5 Feb 2026 17:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NhIK2MM/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EAF2FB612;
	Thu,  5 Feb 2026 17:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770313216; cv=none; b=oZR7iYLyCttXrY4SOn3oVeYGsWkb8d6ig+dw5pEoVqyFY3dqo5oTdUxCBXjY/BlGXsco1oMMtmPX0nG6cK1rS0yMLGZfKFJx2RPMGFI12zAAHujlJYCStJdXbWvuXubQMrGZpVe3gHiqT743yVywUdXOaz+pYvyY6pgbzF/h0Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770313216; c=relaxed/simple;
	bh=PlcHdDqlGOyoVV/PwNUW7cRCJ2IJFzAj92C8MJ6HqrA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KlhxOOnOBSF/+7yOGPnFcFtm9Yltr4//9pIj7LnucLHDES1JEYwzhJO9lLxCCOHZVvbtolCJDp9z8x78FZtiTZHJi6G3VZ7hGQmpNdxcVXEk1xPP93QoZ5AMZZq8zIbJTHkbXHq0YnQc2CYJCoo6VnckF87RCdTrrnhOfY0hagI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NhIK2MM/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86D56C116D0;
	Thu,  5 Feb 2026 17:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770313216;
	bh=PlcHdDqlGOyoVV/PwNUW7cRCJ2IJFzAj92C8MJ6HqrA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NhIK2MM/FKJsRSf1wVPRCASRwziq9qpHvgaRa7SmsXH9VjtuwPwt5gUlV5TUXm+Xz
	 XkslV/OC7bOdgcdu5XnNDhLnN1zusH261fVj9jivft7BFPwHw6GAvRmxnBvZiCMWoS
	 +/r90Q6CoUCXAHM5APn68uTzZC+BlE5J4QEbtmpGPfmMrK6S6wAisEY7FvbwIV+KBa
	 8CHtvOKErI+swfHIpywk0Bvau1Y+/T8PZDUIHwJ/yMGWd9iJL8ngU/hWcuerhaMG1y
	 IhjbkBAqVmxF5rw/5ZgB8J6SzFNguadKPF/9EnsBxOldLurmdbxMCAQ8Ip9SCFb4lq
	 Oi5ocOrUzolNw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8524B3808200;
	Thu,  5 Feb 2026 17:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: stmmac: imx: fix iMX93 register definitions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177031321407.505259.5073683709420571661.git-patchwork-notify@kernel.org>
Date: Thu, 05 Feb 2026 17:40:14 +0000
References: <E1vnaGl-00000007i9f-0ZMw@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1vnaGl-00000007i9f-0ZMw@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, alexandre.torgue@foss.st.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, imx@lists.linux.dev,
 kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
 pabeni@redhat.com, kernel@pengutronix.de, s.hauer@pengutronix.de,
 shawnguo@kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257272-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[15];
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
	TAGGED_RCPT(0.00)[netdev,kernel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 50C69F61FB
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 04 Feb 2026 10:37:59 +0000 you wrote:
> When looking at the iMX93 documentation, the definitions in the driver
> do not correspond with the documentation, which makes the driver
> confusing.
> 
> The driver, for example, re-uses a definition for bit 0 for two
> different registers, where this bit have completely different purposes.
> 
> [...]

Here is the summary with links:
  - [net-next] net: stmmac: imx: fix iMX93 register definitions
    https://git.kernel.org/netdev/net-next/c/7e7fcfb0798a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



