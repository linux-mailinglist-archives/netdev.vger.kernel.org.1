Return-Path: <netdev+bounces-277871-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIGFLNHn22laIgkAu9opvQ
	(envelope-from <netdev+bounces-277871-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 20:43:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 181CF3E5786
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 20:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 622BC302F27F
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 18:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F3A37BE7B;
	Sun, 12 Apr 2026 18:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fyFbOPef"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B6C37B41F
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 18:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776019239; cv=none; b=uNojoiHAMa50Q1sDdSv+2+zOLfxRte+XGMaJl4LzCTCsOEWZ6tHFgGH/g6bUqiMTFc+m/cnTy1f1DLLxLdUjbPC8EXGumYtx2FdvR9tTcCe2dT80Sh6/jTjtrQdJq/6qEU0jkf3CVnA+Q6S+PYtqizWAonhHoAr6XnBiF1uQLlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776019239; c=relaxed/simple;
	bh=COsDTpK+goKtZ6v+1Eg3O5mezNOOSNJXILqQG+OL680=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sPkGYVpkubdaLzOdETxsduJIeO+f5hAn+EsQ1Zsh1pWicBw+UjKsgdJzW+P7wLeuE4BJf5+0+uJ95Jm5vemq7W/ia3Qt3cXFJBbnqyklzaLG4x1oZAdN4dUXkBZTQwFBbxncMO+7TZvV9bUTcpQ13vhJdLAR62+7leih8ZIyljw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fyFbOPef; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14721C2BCB0;
	Sun, 12 Apr 2026 18:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776019239;
	bh=COsDTpK+goKtZ6v+1Eg3O5mezNOOSNJXILqQG+OL680=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fyFbOPefESr9S9R10KtfTKx31mwLKY1l2YXY3Okb2t4icf0dAZ7EI7c/4N1DeAluc
	 +4mDvrZX/gCAhHDISQs52gYmVxxzk5ASj1s+vqeReby/izDfaWcEyDWkSp6/cBI3WR
	 GhkB9fTBOcenrOz/IPuvY/O+LmsWeHzTESRd9KYoRmIGwTwi8ZAG4sbeMJDggvg+44
	 Fagib4jdfGvlcZr3mTRhKtERc2Ze2cET3w2N9fKQjKTwl/logTm0V49GSR1Y/DjxKQ
	 ZHXp7l6uqT8Qy8ggo9jCFPTRHzcNng5rQVR69WcKfkHktLY/Karu1JL4XneJdtgxwy
	 YNF6R9JDIctOA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9DDB3809A8C;
	Sun, 12 Apr 2026 18:40:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: airoha: Add missing RX_CPU_IDX() configuration
 in
 airoha_qdma_cleanup_rx_queue()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177601921154.3370691.1789981504047499151.git-patchwork-notify@kernel.org>
Date: Sun, 12 Apr 2026 18:40:11 +0000
References: 
 <20260408-airoha-cpu-idx-airoha_qdma_cleanup_rx_queue-v1-1-8efa64844308@kernel.org>
In-Reply-To: 
 <20260408-airoha-cpu-idx-airoha_qdma_cleanup_rx_queue-v1-1-8efa64844308@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277871-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 181CF3E5786
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 08 Apr 2026 20:26:56 +0200 you wrote:
> When the descriptor index written in REG_RX_CPU_IDX() is equal to the one
> stored in REG_RX_DMA_IDX(), the hw will stop since the QDMA RX ring is
> empty.
> Add missing REG_RX_CPU_IDX() configuration in airoha_qdma_cleanup_rx_queue
> routine during QDMA RX ring cleanup.
> 
> Fixes: 514aac359987 ("net: airoha: Add missing cleanup bits in airoha_qdma_cleanup_rx_queue()")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] net: airoha: Add missing RX_CPU_IDX() configuration in airoha_qdma_cleanup_rx_queue()
    https://git.kernel.org/netdev/net/c/656121b15503

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



