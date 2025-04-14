Return-Path: <netdev+bounces-182133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8386A87FB2
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 13:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A18243B8ADD
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 11:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FE728EA4C;
	Mon, 14 Apr 2025 11:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfkKp4Wo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E28629615F
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 11:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744631443; cv=none; b=PXiLnYcGZfpsq/GBbVYXyFglmCM+oPGPf5axrexxVHu7CuaCNtvmDU492y8zicznYBDr+v1g3ZRG5iVx/pCHASsi+/loXg6tUEhvLK5fJtFvxZ4hHQJKiMhPCnjPBn8i3FGnjYxZNOoafvDaY59LqpBQGpbwqD78UiBmsYgm+i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744631443; c=relaxed/simple;
	bh=Xm77gjArbLCc6ye7xSBBkCIayzzAowIt9TeJqqMRUZs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oy3RaS9RRt0ttk8X4bpgtTnwKO+/RL0WuP0T+C8Jq1SNECdgYwkNrt9Dbsao/uLEIIpYET0b7Gvp/9WDO8NfZzCquHH3n7Em/FVHDNMlYcD1IschHq1J0tfkeoZA3mYb4cjo9eM1wbeXSQGuKF1DRyF00f4gwq20uTMbc+xXWI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mfkKp4Wo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8FDBC4CEE2;
	Mon, 14 Apr 2025 11:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744631443;
	bh=Xm77gjArbLCc6ye7xSBBkCIayzzAowIt9TeJqqMRUZs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mfkKp4Wo9HfQ5Pbo5R7uhJKk941aUNQJpVKtb4CoaQgth/K/yobY0aVvrboc4LV69
	 PXkJAvmzBDuL+z/wFbjc8YYXxnVxtxXpUbHIVLTZot0owq9Q7DL6dVMovb3y1+R90I
	 h0p7Q7+DaflBoG4Bs6RWePidQGF5aUntlBCgDQHz9FZNRQMbJwadVx8Xe+1CLBCcPn
	 W5inL5GAbx01ASEj0NolJCulYQSgV95E/90nnsNAV8jJ8rg8WjD9jdW6jM9/W1cjOa
	 2XSMX9aqTHUHxL42exa3MVW4+pj9kdop9FGuOn/Ldlhn2yDuOaqpKTqQ6334V2XTve
	 JLCiVGRWIb5Dg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEB9380CEF9;
	Mon, 14 Apr 2025 11:51:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next] net: hsr: sync hw addr of slave2 according to
 slave1 hw addr on PRP
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174463148062.1862892.15248243101265815428.git-patchwork-notify@kernel.org>
Date: Mon, 14 Apr 2025 11:51:20 +0000
References: <20250409101911.3120-1-ffmancera@riseup.net>
In-Reply-To: <20250409101911.3120-1-ffmancera@riseup.net>
To: Fernando Fernandez Mancera <ffmancera@riseup.net>
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 shannon.nelson@amd.com, horms@kernel.org, lukma@denx.de, kuba@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed,  9 Apr 2025 12:19:11 +0200 you wrote:
> In order to work properly PRP requires slave1 and slave2 to share the
> same MAC address. To ease the configuration process on userspace tools,
> sync the slave2 MAC address with slave1. In addition, when deleting the
> port from the list, restore the original MAC address.
> 
> Signed-off-by: Fernando Fernandez Mancera <ffmancera@riseup.net>
> 
> [...]

Here is the summary with links:
  - [v3,net-next] net: hsr: sync hw addr of slave2 according to slave1 hw addr on PRP
    https://git.kernel.org/netdev/net-next/c/b65999e7238e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



