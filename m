Return-Path: <netdev+bounces-159753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82618A16BCC
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 12:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 392741885438
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 11:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0844B1B87C4;
	Mon, 20 Jan 2025 11:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7vFC5TI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D4A2770C
	for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 11:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737373805; cv=none; b=mCz4r5UifNTKsShB+ktupCx7h8ptoi5BGv84iyhC6ZZ/pPvEqoGEWfgCnuCN8ugRYlZnlnMM20Y1gPUlDUJEtX2s/7dF8CmgXY8nT43YiPvw8Tbe+67xdxvSUttYq5H52RHAsBuFyctv5nwyWp6IFZczNMjrhJEJFvO9H9R0VBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737373805; c=relaxed/simple;
	bh=erV6uvOKg6f1G8nPFINIBFr5PqXAOWs2YW7S9DAWC0U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aP2k5Ry7yGGLjFjR8ukEkKNWVos2Is4Ys3sig6iQyMzCo0gG8mTtSMGsSXKAaWMGnaBXa9LHB0XIXzXKJMwKYJT1k9z0oNgRU2E6A/zhZlbsa7EPzrqwcwIZGmwM8c33EsM+9WFYJiwpnOIOFKapMNJKisHvjdupuweF3j8D4zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L7vFC5TI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A9DCC4CEDD;
	Mon, 20 Jan 2025 11:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737373805;
	bh=erV6uvOKg6f1G8nPFINIBFr5PqXAOWs2YW7S9DAWC0U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=L7vFC5TI4t2sQ7O98m+Wfwmr8vF+eqYuMAWGa7E6/4/llrd3vL8SvcWSMRTKJppiT
	 9Zdj5mp02J3Qy8V2XO4XcMwbJNlZGEBCdOCQxZhNFCdlq24xskF2804NRxJYemMyJy
	 VQ8vBTITOLlhEwi8OfIrK1AzzFCjY+Q7zkXLasrD5FXC0yp/ABUO0Erlf9h/nYYI+g
	 Hby/NCK54jQxR/TEIuB3IVetwmqUtcK4JFeVE/7Wr3OlYRd7t92rBPdUJJGmLAB1AM
	 ar9IpKRA5na5e2xTNHn9DgSYGanVQfRqd95BTzpYpDvOo5yYeIvn07b02CbO/HNCgw
	 PMe4eUKJ5Ie7w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71570380AA62;
	Mon, 20 Jan 2025 11:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH ethtool] ethtool: Fix incorrect success return value on RX
 network flow hashing error
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173737382926.3501343.7537911497671210545.git-patchwork-notify@kernel.org>
Date: Mon, 20 Jan 2025 11:50:29 +0000
References: <20250107171755.3059447-1-gal@nvidia.com>
In-Reply-To: <20250107171755.3059447-1-gal@nvidia.com>
To: Gal Pressman <gal@nvidia.com>
Cc: netdev@vger.kernel.org, mkubecek@suse.cz, dtatulea@nvidia.com

Hello:

This patch was applied to ethtool/ethtool.git (master)
by Michal Kubecek <mkubecek@suse.cz>:

On Tue, 7 Jan 2025 19:17:55 +0200 you wrote:
> In case of an error on RX network flow hashing configuration, return an
> error in addition to the error message.
> 
> Fixes: 1bd87128467b ("Add support for rx flow hash configuration in a network device")
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Gal Pressman <gal@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [ethtool] ethtool: Fix incorrect success return value on RX network flow hashing error
    https://git.kernel.org/pub/scm/network/ethtool/ethtool.git/commit/?id=9103197d24aa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



