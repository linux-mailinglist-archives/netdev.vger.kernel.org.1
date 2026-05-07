Return-Path: <netdev+bounces-285087-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDUcD17d+2n9FwAAu9opvQ
	(envelope-from <netdev+bounces-285087-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 02:31:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A81FE4E1B38
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 02:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE58230160E7
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 00:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEF1175A9F;
	Thu,  7 May 2026 00:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBgkpQ7O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3873140DFD6;
	Thu,  7 May 2026 00:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778113871; cv=none; b=RDJLU5dlxVrgmehJnh3X3USKCJRpqJJdnzKGVwa44aYiBgqxIUHlaHjSpgjQixT2Z6FTYN+MSsP0ZAruik4+nkrlVorijPP1z468fTdPgASs+1Q4vVT8/4LVac1r7ZiNJm44IN939QFTndSE4UYRC/AaNV4zrZePr34Y9sP9WdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778113871; c=relaxed/simple;
	bh=iMntnkhcKMleC+GwTkKtM1pWRK+8Df7Da/8SXOeUK5M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=C4SW6KVNrSqthvNM0AF98HYpLWVSRbYFaoLFILYnv2s0xah7LRmTLkuCn6IQEYgEBpTePeLu7djoQXGg6kfqVzbK/hW++b26opUkavgxMSodkrDyattnqRuP+WAg/6qqEJBI08oDmTUQHopPG4Ci2s+gzecibLRu1MuzvRFLVac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBgkpQ7O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3BCEC2BCB2;
	Thu,  7 May 2026 00:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778113870;
	bh=iMntnkhcKMleC+GwTkKtM1pWRK+8Df7Da/8SXOeUK5M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MBgkpQ7OSb39Mw627vVr8ez7QCzax494QVxEhz3GBqWF72geznOCxwQCGcyjxZo/L
	 wwvO3WyNVuEW+eikDDSx+5b/0rb8Jo/cztQ7nMwfTA4RIRQapVXvMBvcY5j9yvAvkY
	 SN0/mpMXdGWUiREwYO9QT6IIG7qAjbl4NDp6FCmbr14IIt4/WrXbZAF3xDKdMLfwRK
	 JQthLHO0l2kgoA2vUlCuiSISSl6PWXequG3hUptPgkDkEuCo+Ug+IFmqEUGzwGYu2m
	 w3PysIdSlPMUP/yptH8bTh4DDNwFiDK3YtwV/seLZ2reJG0g90oO6VhFY6ZJpGchbL
	 z64jEBTgdTabQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CDB1393089F;
	Thu,  7 May 2026 00:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] rtase: Fix flow control configuration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177811382004.3276081.6488234094395420706.git-patchwork-notify@kernel.org>
Date: Thu, 07 May 2026 00:30:20 +0000
References: <20260505064121.31286-1-justinlai0215@realtek.com>
In-Reply-To: <20260505064121.31286-1-justinlai0215@realtek.com>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, horms@kernel.org, pkshih@realtek.com,
 larry.chiu@realtek.com
X-Rspamd-Queue-Id: A81FE4E1B38
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
	TAGGED_FROM(0.00)[bounces-285087-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 5 May 2026 14:41:21 +0800 you wrote:
> The hardware has two sets of registers controlling TX/RX flow control.
> The effective flow control state is determined by the logical OR of
> these two sets of bits.
> 
> RTASE_FORCE_TXFLOW_EN and RTASE_FORCE_RXFLOW_EN in RTASE_CPLUS_CMD are
> the bits used by the driver to control TX/RX flow control according to
> the ethtool pause configuration.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] rtase: Fix flow control configuration
    https://git.kernel.org/netdev/net-next/c/fea3521e043f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



