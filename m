Return-Path: <netdev+bounces-165021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE2AA30168
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 03:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FEAB165D09
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 02:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E681CAA70;
	Tue, 11 Feb 2025 02:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvWg+K0v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9211C5D76;
	Tue, 11 Feb 2025 02:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739240409; cv=none; b=LUrI9KqPWJtSiytaMFA20AXgG4asGVCsjQotZt53CQkba4WHyoxqqG/djxeXM66v8RZyj1Mqe5YaZRnUdum+TkwVdwl88tr43Vb5l9+YcxnP8joWIOeQClsWM6x2SRBhQ5dUERBHgQvfj/E+lkO6kug4g6WMflX9kl93vEt+czE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739240409; c=relaxed/simple;
	bh=/GN4N5nnO94WYMURaR0RvvgyUUFidE5XpUnXxRw733s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jM6RRN5bnXnouGnwFyrtxiMmt6X+ppx+xpFVOwOmH+nxt8Np97SZIismS27CUxRaChV2k2wE6eTDHQFYi8aD6qIn46HYfGk85yirgT0sZ0lpPxJP9n5iDwqR4PQdm6A8EryM7ZtkgUCK7NSiNPQqvJuIG68CKrB8sXrHBOLqBn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hvWg+K0v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20754C4CED1;
	Tue, 11 Feb 2025 02:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739240409;
	bh=/GN4N5nnO94WYMURaR0RvvgyUUFidE5XpUnXxRw733s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hvWg+K0vwEV6OgFY2ctLrbT7/PP0BbBN+qlXZiX4Cgy41YQDEKl5XuXNmqAxcUycj
	 J//rAqWqvB/0jZfsw9CCLtZCoAIT0BBC6P66/QxCVlPqlg0bbXKuWnBAz89aDdHYtk
	 cjYZSdz6Y4jb896OAawwfUPnSlI6lzPqmsDZmV4r0x46RsOHzFWFHOdV5J5B+J9+M9
	 UZvwD9sMFveF8Y/xBRlwwT+ZXi/jrtmDULvG/H52fUwaC0puBuYFypNh6bZLgFPCEI
	 2YZbkbpZpr0yw3QSeQzVrJqO4VdJMQ8KNrXlXnZU4rI9oufbkA3HL3KePxv+0Pwz7E
	 Ft/wnWNrrbjmQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB8ED380AA7A;
	Tue, 11 Feb 2025 02:20:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1] net: stmmac: Apply new page pool parameters when SPH
 is enabled
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173924043750.3915440.1883546430698083121.git-patchwork-notify@kernel.org>
Date: Tue, 11 Feb 2025 02:20:37 +0000
References: <20250207085639.13580-1-0x1207@gmail.com>
In-Reply-To: <20250207085639.13580-1-0x1207@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, xfr@outlook.com, jonathanh@nvidia.com,
 bgriffis@nvidia.com, idosch@idosch.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  7 Feb 2025 16:56:39 +0800 you wrote:
> Commit df542f669307 ("net: stmmac: Switch to zero-copy in
> non-XDP RX path") makes DMA write received frame into buffer at offset
> of NET_SKB_PAD and sets page pool parameters to sync from offset of
> NET_SKB_PAD. But when Header Payload Split is enabled, the header is
> written at offset of NET_SKB_PAD, while the payload is written at
> offset of zero. Uncorrect offset parameter for the payload breaks dma
> coherence [1] since both CPU and DMA touch the page buffer from offset
> of zero which is not handled by the page pool sync parameter.
> 
> [...]

Here is the summary with links:
  - [net,v1] net: stmmac: Apply new page pool parameters when SPH is enabled
    https://git.kernel.org/netdev/net/c/cb6cc8ed7717

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



