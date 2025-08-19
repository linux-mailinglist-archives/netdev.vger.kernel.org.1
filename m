Return-Path: <netdev+bounces-214927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB366B2BEF6
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 12:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00FD61BA1286
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 10:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CAF532277E;
	Tue, 19 Aug 2025 10:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJtCQo4n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F98322777
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 10:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755599400; cv=none; b=oQhTTdJ4BZyUSeUXFqg7kywBPOa3nOSBD7mHmf0NkhauwMZIthvupPRvI+QFXiIGONQ5RkHA76DLOg1tr9PpnjPGGp4H75szi+wZOGtWfm+sXysUD+gIdTdG5gBFswnWwz1daTnc696Ya1KjXMytGvCTzupiu7mcIPC+/4M/P1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755599400; c=relaxed/simple;
	bh=nqC4QDhsQBWXsgUgFUNWX/IR69ZH1dQVC1Q2G3yVz/c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XocoLSSSJUeTMltdjjXgG8GUDAG101xLq4HiUiZVZ/a/51Mio6dWwiTbfNI+NO5aJfCszPvG51Al0moImeUaegJ8La+x719dOC7n+fx6RSE20crqJyvudLjSsOBU37BouXzYywwerl/yoGOWcGU4IlrO+AhBMM3VtT/XwGVsM/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJtCQo4n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9C89C4CEF1;
	Tue, 19 Aug 2025 10:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755599399;
	bh=nqC4QDhsQBWXsgUgFUNWX/IR69ZH1dQVC1Q2G3yVz/c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IJtCQo4nfCaTwGPYVpy2RQLbIQHXme+o/hBnZ/eWJxUwnpcYt8zTFKnpaQS05SFo5
	 VOvj8KuiQhF7VjtlWbITVRzLNbjqquqPRe8ab4UvcwTzSld+CKsVC7n2VqPcps/U7f
	 G/fS4HGM0zYBMH8b1WuQGevGNg1RkDzT65gymcbZ3y+7O5DJ4jVL92Z+fw7VFmVeEO
	 MCStfTFBjh/03yKvv7vMs3VRgBMvy9cSRBmwwGJKSyKOqWuNT9xIrjDxVjRkiSyIZI
	 vA7bTMWkbTBBZhF8N0o3f6EEoQNrmY5X7IYJAJ1sUro2zkFLjT6iAnwgeQEAha2nIH
	 5CDjRR7t7fQRA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF45383BF58;
	Tue, 19 Aug 2025 10:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: airoha: Add wlan flowtable TX offload
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175559940949.3486708.13434043940019659826.git-patchwork-notify@kernel.org>
Date: Tue, 19 Aug 2025 10:30:09 +0000
References: 
 <20250814-airoha-en7581-wlan-tx-offload-v1-1-72e0a312003e@kernel.org>
In-Reply-To: 
 <20250814-airoha-en7581-wlan-tx-offload-v1-1-72e0a312003e@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 14 Aug 2025 09:51:16 +0200 you wrote:
> Introduce support to offload the traffic received on the ethernet NIC
> and forwarded to the wireless one using HW Packet Processor Engine (PPE)
> capabilities.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.h |  11 ++++
>  drivers/net/ethernet/airoha/airoha_ppe.c | 103 ++++++++++++++++++++++---------
>  2 files changed, 85 insertions(+), 29 deletions(-)
> 
> [...]

Here is the summary with links:
  - [net-next] net: airoha: Add wlan flowtable TX offload
    https://git.kernel.org/netdev/net-next/c/a8bdd935d1dd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



