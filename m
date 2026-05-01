Return-Path: <netdev+bounces-283063-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKAhFFgA9Gn99QEAu9opvQ
	(envelope-from <netdev+bounces-283063-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 03:22:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B28464A99B9
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 03:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E3E6302D09F
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 01:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AEE12D23B9;
	Fri,  1 May 2026 01:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IsBNqDWi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC271E492D
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 01:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777598456; cv=none; b=gGAl6K7grF+1esvNG1OSrVkYsnfJk+QwADwEKvMzfNokkUOcqxKnRSFFIqIRlXIodKp3NQASNlxwqDOQZnuacs9VBd2nW1f/uWLxuz+Hc07W39tfBcFRILMoHJ8QMYo3f8t0cHk+hn/GKAZC0zVvbeBz+I15/raPDa7nEOQUWjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777598456; c=relaxed/simple;
	bh=7rKuBfm/sZqWZkIHfGrPtqBLbz7QhI+DrjxOxPQGULw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CUhu9NVYELJefGW9ueYnRCp8rdosSfTWV/scmRlnDGZhuTkpnkSKbwerSM4gF/TucYuOVYhY0nAHdunAEQjCJTkUxla4vNhNCiOIDfT/0/LSVO/CacOhOh4n0EU8PPnQ7uawJLwrRKupxkHOZ7nPd2UTv4t9jtWET1RmTsNKi0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IsBNqDWi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA7BCC2BCB3;
	Fri,  1 May 2026 01:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777598456;
	bh=7rKuBfm/sZqWZkIHfGrPtqBLbz7QhI+DrjxOxPQGULw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IsBNqDWiGsHNeM/iuiQqKxH4swR8cjkUwEK/tmacRzj+lrUdMaXDTaGVNofROB5sF
	 bBRODprviHwVF9VQuBIYcZfE5TFhZpUthESgCf5ZlmBwO2d9jAbWnyo60NtK+kvPiB
	 ukozERPSd6GQgUthnkjU2WUEQ7hoLZF1IL8iPi1XhU844bync1gOyFnYjr/xvF8fA4
	 6vOpDxwr6dkSi/MiGP2eb3tWmb+nCsu+Ts1i2ezYiJUJiYRS93IBhoXefPfCOJ6BEu
	 kzIY2gOsalMit/H10XPtTRPMiWg/LTiI6Qew0wLk4YKCDUwxJsX40ZDqYtv7UauFVY
	 oKxsyQDxwdAuw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FC46380A957;
	Fri,  1 May 2026 01:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: airoha: Move entries to queue head in case of
 DMA mapping failure in airoha_dev_xmit()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177759841005.3278779.2333326558858237558.git-patchwork-notify@kernel.org>
Date: Fri, 01 May 2026 01:20:10 +0000
References: 
 <20260429-airoha-xmit-unmap-error-path-v2-1-32e43b7c6d25@kernel.org>
In-Reply-To: 
 <20260429-airoha-xmit-unmap-error-path-v2-1-32e43b7c6d25@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jacob.e.keller@intel.com,
 horms@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Rspamd-Queue-Id: B28464A99B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283063-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 Apr 2026 14:02:31 +0200 you wrote:
> In order to respect the original descriptor order and avoid any
> potential IOMMU fault or memory corruption, move pending queue entries
> to the head of hw queue tx_list if the DMA mapping of current inflight
> packet fails in airoha_dev_xmit routine.
> 
> Fixes: 3f47e67dff1f7 ("net: airoha: Add the capability to consume out-of-order DMA tx descriptors")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net,v2] net: airoha: Move entries to queue head in case of DMA mapping failure in airoha_dev_xmit()
    https://git.kernel.org/netdev/net/c/75df490c9e84

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



