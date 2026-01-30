Return-Path: <netdev+bounces-254989-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFlmNYAcfGmAKgIAu9opvQ
	(envelope-from <netdev+bounces-254989-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 03:50:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8FAB68DB
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 03:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DEDAC3003812
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 02:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CC52E6CBF;
	Fri, 30 Jan 2026 02:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6hO5yg6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A021A294
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 02:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769741437; cv=none; b=lro7hEWRuiuAJbvxIcC5ys8RygP3aRaksYQXP2pytDlec6/n8mUGtEktJVxsGHLK5DjHVIrEaMPC/3cz2rQAfaQYVsi2T51bgztKSXTNv6zf/jrS++PP//Z694B0kny4VVZnUflooGYIxMMPd/ao8srGwuhD5Mq65rA4DH0AVxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769741437; c=relaxed/simple;
	bh=4mP/h3GbYCa8J/6dvAXmJ6ho0qAayCfhutvBl6V6NfY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VkKNIp7fieTJLpqBGAZBtaJYJK3oqWrscNTZ7VgyBE4evVqrJffLWRulXhhajnHSW2kF1Hq6rw7ubU847WBjxNq5D6BJHzaA9DFpzr7zaefCielnYGHQMq2w2ysDLd/kEQswL+F0xBecL1CwvN/OPK+alMRSC9gNlzpTmfKxLJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6hO5yg6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D00D5C4CEF7;
	Fri, 30 Jan 2026 02:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769741436;
	bh=4mP/h3GbYCa8J/6dvAXmJ6ho0qAayCfhutvBl6V6NfY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=h6hO5yg6lf5vPq1Wlfxr6sBAyZcIHnKybPLZHh/9EhZCclmPxY9p0JbrJJkxQMPmx
	 w0EZLHXoF2MF4Qxp6cIEURHhWBbv3G4CU3R3RZNia7Zuci1kLxPrbCuIXJZlwBlPKp
	 NmZ1P3g9uJ+ynn0ScQqAPtlcJrgsPm5TgdKlBAWtD6VbqNqwnc51utlQ3qgj1OUtFt
	 RZdkKLH9GjWdfg6kMNUWLr1wuQARPoHTAejBCTciyyIfYq/gtMYEPNye9EXazRVFus
	 B+GfbJF3EWcG0l4ILS+LQfQ3QCKBzk32eDVNXjUqKGGPPYfL0QBHZT2uWP47Hixy5p
	 IZ+oZsj2HUEtg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8D16380CEE0;
	Fri, 30 Jan 2026 02:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] net: stmmac: rk: second chunk of cleanups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176974142934.3149010.15875331264465182185.git-patchwork-notify@kernel.org>
Date: Fri, 30 Jan 2026 02:50:29 +0000
References: <aXnrzIbZN-gaZTia@shell.armlinux.org.uk>
In-Reply-To: <aXnrzIbZN-gaZTia@shell.armlinux.org.uk>
To: Russell King (Oracle) <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, alexandre.torgue@foss.st.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, heiko@sntech.de, kuba@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
 pabeni@redhat.com, p.zabel@pengutronix.de
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254989-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[14];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7D8FAB68DB
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 28 Jan 2026 10:58:20 +0000 you wrote:
> Hi,
> 
> This series is a cut-down installment of the dwmac-rk cleanups, covering
> up to the point that the AI review had its first issue with the patches.
> Unfortunately, this means that we introduce ->init but do not add any
> users for it yet. That will be in the next round once this has got
> through AI review and merged.
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] net: stmmac: rk: fix missing reset_control_put()
    https://git.kernel.org/netdev/net-next/c/1c249fc1e19e
  - [net-next,2/3] net: stmmac: rk: add GMAC_CLK_xx constants, simplify RGMII definitions
    https://git.kernel.org/netdev/net-next/c/f7aaa6fb1193
  - [net-next,3/3] net: stmmac: rk: add SoC specific ->init() method
    https://git.kernel.org/netdev/net-next/c/1639ba67bfb5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



