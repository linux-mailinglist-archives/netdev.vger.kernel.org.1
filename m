Return-Path: <netdev+bounces-159729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9385DA16A7B
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 11:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE4B8160A6E
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 10:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D522C1B423D;
	Mon, 20 Jan 2025 10:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ndkng54a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE9D1B4232;
	Mon, 20 Jan 2025 10:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737367805; cv=none; b=OHnritIpi4CEvy2YQKuLlz2Bd90YgI/GnY2A3kPj5Rp8Nuah3eaHPhObvyGg6Pgu+69Y1XP51EERaPfyJG8B8KHEtN8/xl9lB59T/KQAsnHKH0N7CIQ1z0fyQTuRjMZ+slxpegGgNlyZs8DxfBHUuS/SI1ZSHJVQ87Xuwer80Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737367805; c=relaxed/simple;
	bh=5kVUEYGd1O3X+LS0/N3Nv0ai5flB4MmsxqkP1YSXZiQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SULck1aM4TLRktKWMjvMcGOBfPYSMSch/vz+TOEcQrOe7ndt/7sKPyex6yzdwu7KDq56yjXMRt4jrIXnXhkIRM/xM3ir9fPxk4Dl8DBiPDsBgALoA5wgX/fg7JMe1tQnHH0jMxbFnv6fBn+DyTD/GyfbFNSZg5wq+lXJy6EBzyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ndkng54a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E70C4CEDD;
	Mon, 20 Jan 2025 10:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737367805;
	bh=5kVUEYGd1O3X+LS0/N3Nv0ai5flB4MmsxqkP1YSXZiQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ndkng54aMZN4gqZhKEtFuzLJjwENjULMPLb9Bn1rjAU2/d3pyi3Yilxmn9msTWpd1
	 L27aMUASzmeugGBr+f2RWyKDJ3FXiY0aZvxcDIW/+6VTXjAyuagx/FwJXxUatB5U6v
	 c4NHmg91aUpSIJDQWQYh/GBecnk7YGbD7yK8md5kyqRryDQ3YxzNznJiAOyylO+1iQ
	 h8zqSBu4aVnBCLJq4BcwZvFsiu7kEyldLpY589nq2JDD/VUsheQ4oGXuI/+cqINmrl
	 oyNnKFKuVtYT3XDOcIwwZdKFsPkdJRtJTXdZM9NSONaXAcslyH5vhMhjrs/w/X1rm7
	 Dy17/sx6IjKGQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33A84380AA62;
	Mon, 20 Jan 2025 10:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: ethernet: ti: am65-cpsw: fix freeing IRQ in
 am65_cpsw_nuss_remove_tx_chns()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173736782902.3476879.17872430916654869095.git-patchwork-notify@kernel.org>
Date: Mon, 20 Jan 2025 10:10:29 +0000
References: <20250116-am65-cpsw-fix-tx-irq-free-v2-1-ada49409a45f@kernel.org>
In-Reply-To: <20250116-am65-cpsw-fix-tx-irq-free-v2-1-ada49409a45f@kernel.org>
To: Roger Quadros <rogerq@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, grygorii.strashko@ti.com,
 s-vadapalli@ti.com, srk@ti.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 16 Jan 2025 15:54:49 +0200 you wrote:
> When getting the IRQ we use k3_udma_glue_tx_get_irq() which returns
> negative error value on error. So not NULL check is not sufficient
> to deteremine if IRQ is valid. Check that IRQ is greater then zero
> to ensure it is valid.
> 
> There is no issue at probe time but at runtime user can invoke
> .set_channels which results in the following call chain.
> am65_cpsw_set_channels()
>  am65_cpsw_nuss_update_tx_rx_chns()
>   am65_cpsw_nuss_remove_tx_chns()
>   am65_cpsw_nuss_init_tx_chns()
> 
> [...]

Here is the summary with links:
  - [net,v2] net: ethernet: ti: am65-cpsw: fix freeing IRQ in am65_cpsw_nuss_remove_tx_chns()
    https://git.kernel.org/netdev/net/c/4395a44acb15

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



