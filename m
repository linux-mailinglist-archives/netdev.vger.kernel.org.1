Return-Path: <netdev+bounces-270145-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qN/XLJf3vWm+EQMAu9opvQ
	(envelope-from <netdev+bounces-270145-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 02:42:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E53F2E2D28
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 02:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5C99C3093BF0
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 01:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F0F3368A5;
	Sat, 21 Mar 2026 01:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJSsJGgn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906E533688F
	for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 01:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774057238; cv=none; b=EYE/axgirx1m8EFLCN2WKjCvRJ87LBQx6HlO0VaRExGG2C8l6hxJ27R8EInVLfCtx0404Hu0o45tQhrHT/hiEYdzZeM/8WTihYZXVVaNRAYQOvYgcLPsLblixf0m3JFFKYU24h4qfu+Y2zmQOx91nDu0W8EG6tuhe7O07Os26nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774057238; c=relaxed/simple;
	bh=JgeT9ShCXXUNi1nLV7S4fvmxaPQsiDWiTuJ1NNUWg6s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eKuEoYKOdeCw3egytQ8po2czRPR377rHG8QYmiqXMdf6hNPnjHDMytG8u4neZtn6XkDDIdOF0kzqgQgoBpg+y93X7QHB5caCxz6xG4xmCgIKGatMK1jgxnlfPLi/NB4+5miiGm4lfIMwgdQXCYfQqXkDDOw0btMww1O43o83bVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJSsJGgn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 392DEC2BCAF;
	Sat, 21 Mar 2026 01:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774057238;
	bh=JgeT9ShCXXUNi1nLV7S4fvmxaPQsiDWiTuJ1NNUWg6s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GJSsJGgnKZglb2lom6thwG02Nj//MQLb7vySle2Pqga27CYTOxRCqKZnRzOdSZIAX
	 PKMcHk87xf8lsn+FBc5AzXoSr+wAhupaZSVVZlrmDpuTljCLNda9p/HRliEd5umcnm
	 sL7SIC5DbD7+1sLYQDEVrJM8YH2ZbvMI2PoooUkm1mvd9qNd9IfM72GiMiNQ1r3IBv
	 BEmGVlWBjpAc2V8wrn+OoRwEEB8fBjQR7wciZvH+Ril2+6f5Y16YfkAtamOsbYhROJ
	 F2k/kyJRCqOUT3f8jgKqX1NDGbdY04tSavpfriE27BFO6ocAZKT7rl4MWao/T49JaF
	 +3wQ8a7Y2/NSg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CDD83808200;
	Sat, 21 Mar 2026 01:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phylink: add debug for phy_config_inband()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177405722803.2718727.15388908581603538478.git-patchwork-notify@kernel.org>
Date: Sat, 21 Mar 2026 01:40:28 +0000
References: <E1w2mFk-0000000DXW2-2PR9@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1w2mFk-0000000DXW2-2PR9@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270145-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,armlinux.org.uk:email]
X-Rspamd-Queue-Id: 2E53F2E2D28
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 18 Mar 2026 08:27:44 +0000 you wrote:
> Add debug for the phy_config_inband() call so we can see which inband
> modes are being configured at the PHY.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/phy/phylink.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Here is the summary with links:
  - [net-next] net: phylink: add debug for phy_config_inband()
    https://git.kernel.org/netdev/net-next/c/eb2415854f3b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



