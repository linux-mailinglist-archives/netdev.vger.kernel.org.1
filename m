Return-Path: <netdev+bounces-282559-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EN5HOF+l8mk0tQEAu9opvQ
	(envelope-from <netdev+bounces-282559-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 02:42:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA0949BCEA
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 02:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 59153303103D
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 00:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2006D22D792;
	Thu, 30 Apr 2026 00:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ArM23fB9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1739225A38;
	Thu, 30 Apr 2026 00:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777509672; cv=none; b=e9PFg+8W3IAhVpyOim28eUBzKLxo8u6D5yj7vtUnK+CkNSMMfMc16FVTB/g5Ws+XfPJ3bbjNq9CeSVfMgBezQNDw0ZaU1fMqrw5Uc1QqxDDdUiSQoVN5E1a8zGjivu+GT6+mOjG9bMuei2aRq3mnu0psIph42ipdg+ttY1PN2zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777509672; c=relaxed/simple;
	bh=9g7hPQj7KsWkXttmPzPB+EGrRNIrrqTQepE1DzM2lAc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZLlioIougs/MWr9yWUIkchpusmio1m0lInQibDASqXOA+rVylppQOmXzFe/9fDaJlyDMt1c1ZZg9mlwzutM9qxIJnwei9UEyCi/3EacOVEIbg2Dh64DXVikN9AhonZoS7DQw9/A2IM5I7u1Vb25wA+zZcooEd0cAJ50S4OoJJz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ArM23fB9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D26C2BCB4;
	Thu, 30 Apr 2026 00:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777509671;
	bh=9g7hPQj7KsWkXttmPzPB+EGrRNIrrqTQepE1DzM2lAc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ArM23fB9Mi8voLl/zbrCLaxVuLJFv7+fSE8N3wM5vTh3mymHyI6If2Abq+PH4v/tl
	 9ZXS38uJL4N6ImI7bybi5b0CntrcxI6LMPwLoTHDvTBHbZdfcXN/rwqqeOCrb0xUbu
	 RAiDB55jc5BAxGFgjnWo72iOUtRcqOfUv+2lMjspOQLbwG/7mkVBILqEt2IavUwI31
	 1oX/8Hciym61WltB/mo5vqoxCXLITrAhc5JHTKdN+T4AUAoYtrKx1m7Nt/pixaReBx
	 UznKp3HjkH/w4q5TWWskXYkAooXksl2o/hVbUzzGVq6lX3QBiHU5J4SNLWFefNTgAR
	 yDOx3FmCIUkmQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02CD63809A2A;
	Thu, 30 Apr 2026 00:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: drv-net: rss: add case for field
 config
 on RSS context
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177750962654.2238701.16028526030021659024.git-patchwork-notify@kernel.org>
Date: Thu, 30 Apr 2026 00:40:26 +0000
References: <20260428203624.1224387-1-kuba@kernel.org>
In-Reply-To: <20260428203624.1224387-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 dimitri.daskalakis1@gmail.com, pavan.chebbi@broadcom.com,
 linux-kselftest@vger.kernel.org
X-Rspamd-Queue-Id: 7CA0949BCEA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,broadcom.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-282559-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:email]

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 Apr 2026 13:36:24 -0700 you wrote:
> We had some issues with a suspected traffic imbalance on an RSS
> context. Make sure the tests cover the RXFH field selection
> vs additional contexts.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: shuah@kernel.org
> CC: dimitri.daskalakis1@gmail.com
> CC: pavan.chebbi@broadcom.com
> CC: linux-kselftest@vger.kernel.org
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: drv-net: rss: add case for field config on RSS context
    https://git.kernel.org/netdev/net-next/c/1656f1788342

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



