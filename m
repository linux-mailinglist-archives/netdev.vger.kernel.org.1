Return-Path: <netdev+bounces-272723-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AAAJMFUx2lTVgUAu9opvQ
	(envelope-from <netdev+bounces-272723-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 05:10:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 471CC34D3DC
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 05:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AC6AB304A8BE
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 04:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78570359A98;
	Sat, 28 Mar 2026 04:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlha+pW4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CC010F2;
	Sat, 28 Mar 2026 04:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774671032; cv=none; b=KkGmNWAEWS5e4T+KDHMzQFmDy8F612M1ZCH7C7zIPOm9M+17rA2yBZ2+/C6EZ9hTR+F7rGu9C2llHanETzQR+dY3nwjGQWFNpPqz7ZKvJCqx5qUb3EmBsWYvIWUJaObPrHBgpt4//hhVHWAd6bY4xW4BNjTWvrAqMe7NQmP3RL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774671032; c=relaxed/simple;
	bh=yKf2T1AUe+h23GNwJLNhDG4gyygGwCV0bDosgAI3kAg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hhiRoCjbmXBn433xHXuxA5tVrqDRZkxJL/G8rg4jJKTcnzAjjUC0cOzZ/HFmvW/DwCjlx5nQHRYE1afCaOv36zYbx1pRaLClRpjVfew+6VvX36izes8qO5IEYLSCzJYp+lzoPGQ324MeHM9VEVNdzgCxoGg1ECfX11CmGzXWbec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlha+pW4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E367AC4CEF7;
	Sat, 28 Mar 2026 04:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774671031;
	bh=yKf2T1AUe+h23GNwJLNhDG4gyygGwCV0bDosgAI3kAg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nlha+pW44VxN3w5alT5oKzNDcJpZvSUo3FBkFduMlSuoiYv30In23k+cfMT6Y1Pz0
	 +opdGfyhMYo6vs9Cz971Rocu5ooFV6nh+qzWVr8nTYh124HY5b3LtK7IWLys4VXf4q
	 yjCf0/SGt7ti0i/SQRI5VG7WGlczVNSMlUeatAFGjArGORaqgqcsOvrIRmOZl15qB8
	 p0/4WO61492GYqzAIjq6uk2DR5Q7Y2huc6734RpvaRiMgldOfqmzK/Td2hHDbuEV6p
	 Av7t7Qa9pHMXbg20uXpDpanv3bMljOeBPYsEm6HQ6UmIW0y1qCC3ANyUAw/Dk/OUi7
	 jd84+3+6uOs5w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F2B3930181;
	Sat, 28 Mar 2026 04:10:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/2] net: stmmac: Disable EEE on i.MX
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177467101728.4182342.3438344923033995715.git-patchwork-notify@kernel.org>
Date: Sat, 28 Mar 2026 04:10:17 +0000
References: <20260325210003.2752013-1-laurent.pinchart@ideasonboard.com>
In-Reply-To: <20260325210003.2752013-1-laurent.pinchart@ideasonboard.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: netdev@vger.kernel.org, imx@lists.linux.dev, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, festevam@gmail.com,
 francesco.dolcini@toradex.com, Frank.Li@nxp.com, kuba@kernel.org,
 joy.zou@nxp.com, kieran.bingham@ideasonboard.com, m.felsch@pengutronix.de,
 pabeni@redhat.com, kernel@pengutronix.de, rmk+kernel@armlinux.org.uk,
 stefan.klug@ideasonboard.com, linux-arm-kernel@lists.infradead.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272723-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,lunn.ch,davemloft.net,google.com,gmail.com,toradex.com,nxp.com,kernel.org,ideasonboard.com,pengutronix.de,redhat.com,armlinux.org.uk,lists.infradead.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[i.mx:url]
X-Rspamd-Queue-Id: 471CC34D3DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 25 Mar 2026 23:00:01 +0200 you wrote:
> Hello,
> 
> This small patch series fixes a long-standing interrupt storm issue with
> stmmac on NXP i.MX platforms.
> 
> The initial attempt to fix^Wwork around the problem in DT ([1]) was
> painfully but rightfully rejected by Russell, who helped me investigate
> the issue in depth. It turned out that the root cause is a mistake in
> how interrupts are wired in the SoC, a hardware bug that has been
> replicated in all i.MX SoCs that integrate an stmmac. The only viable
> solution is to disable EEE on those devices.
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/2] net: stmmac: provide flag to disable EEE
    https://git.kernel.org/netdev/net-next/c/187b00a26679
  - [net-next,v4,2/2] net: stmmac: imx: Disable EEE
    https://git.kernel.org/netdev/net-next/c/394863097e36

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



