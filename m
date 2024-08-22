Return-Path: <netdev+bounces-120764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F65B95A8E3
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 02:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCC641F22643
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 00:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC22D17C9E;
	Thu, 22 Aug 2024 00:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DwJS3u44"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E99179AE;
	Thu, 22 Aug 2024 00:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724286635; cv=none; b=VaEhVXutT5JwcLP1xNzIbCilYTP+iYVkdPlxI8XlzOh3CLOgx/Vkx1YIe/DiFurhvoRpiWaVDP/sSeCGA5p+298meaArlU8GHeR7cRX5Kso2gKgtg0MoZdme9e5QfoOgQfXjZmekQIwsI2OF3y/No92q5pJKu4JqGA9OL6YGAtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724286635; c=relaxed/simple;
	bh=8Af66LklSnyrx8SbvxcwozQbPqEQJvdk+hXfzN5Zkw0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FevQnPk/yrHB298qnpiBkfVkic81b/hc/Hoj53BQ75KgTcnzQEw84ZxFIy3sSYXUP/XYfY1vdPsRaJE4VkYZkvgAuF3t6XYGvJrzzC2pxwa21VNVR045ulk+aJvKVI6KT45hT6NHcSm9cxCs3kiDzQ9F2aGjea9qQ7OZrQzSbgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DwJS3u44; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60EEFC32781;
	Thu, 22 Aug 2024 00:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724286635;
	bh=8Af66LklSnyrx8SbvxcwozQbPqEQJvdk+hXfzN5Zkw0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DwJS3u44Ub/pNvIBgiN4oNDzomZUhAPDwLKpN/QfPTyViMWV6rx7x30DHa3lHcF7Q
	 KwsLGplMYcHYTqcLC4NiwGT84LUT6jthjwAJnWbL3H9WTtWHqFxvvIVaCu0rAYv2pC
	 Y1UGVP5JjhEBnXBaUM3EX4V5raPGt87ZGiHMJHLnep28oDhD6GOPgo9uiM5Yb3RX+f
	 rydDwxlO8DlsXjhLs0INprkIdg28IH0XP1v3U1o8o9xrT9Q9v6h1VhGcKx2JvPj7R1
	 p8euFI3shzMxv84F8L001R82nsnqKNZyvKzI6nGiioTn8oEyy8wDYecZ/XeyElCqR0
	 YVGAi2XscXCFQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B6F3804CAB;
	Thu, 22 Aug 2024 00:30:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -next] net: dsa: ocelot: Simplify with scoped for each OF
 child loop
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172428663474.1870122.8568204254119294706.git-patchwork-notify@kernel.org>
Date: Thu, 22 Aug 2024 00:30:34 +0000
References: <20240820074805.680674-1-ruanjinjie@huawei.com>
In-Reply-To: <20240820074805.680674-1-ruanjinjie@huawei.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: vladimir.oltean@nxp.com, claudiu.manoil@nxp.com,
 alexandre.belloni@bootlin.com, andrew@lunn.ch, f.fainelli@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Aug 2024 15:48:05 +0800 you wrote:
> Use scoped for_each_available_child_of_node_scoped() when iterating over
> device nodes to make code a bit simpler.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  drivers/net/dsa/ocelot/felix.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Here is the summary with links:
  - [-next] net: dsa: ocelot: Simplify with scoped for each OF child loop
    https://git.kernel.org/netdev/net-next/c/e58c3f3d5196

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



