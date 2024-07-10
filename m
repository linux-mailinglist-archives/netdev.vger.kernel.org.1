Return-Path: <netdev+bounces-110472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EECC92C849
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 04:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A17F282C02
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 02:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4997FC8E0;
	Wed, 10 Jul 2024 02:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WyWjwyNi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23ECDB663
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 02:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720577433; cv=none; b=TQHpTJlhndSWqte6+wJDjhV9YpQFEQF2K3elrlb49U2Ynnhgtf5Q4mI8NYfrr+aGvtaycTSIQX27MUaoSalHuwW/tr6K3yqyGbMcjiWS1JvFuiE2AHhxraD4s/SQBAv+6hfrmvrMLDNy6bndYe9PZ4dha7x3oNOczk39aVL5Y1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720577433; c=relaxed/simple;
	bh=Y5FMNRvVPU+pYx/0/KpfVB1NqWL4sHIfLFCHuIeotzo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=C9S1RHtl0ct+VrrK/DluQjsqfO3ZbtUSNLRuHIB4M2we9VsythPz6jh+tipr6Yhwbxa36DKpdaHd8vg45qraOh/1JAaYc/VN28uvqdNuSaShsMdfYm5qUjbuSPW/+wqRRhdTuyHpn2AnbgD0HcZrf1RvNxOQvfreymHtC0ySLkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WyWjwyNi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CCC39C4AF0A;
	Wed, 10 Jul 2024 02:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720577432;
	bh=Y5FMNRvVPU+pYx/0/KpfVB1NqWL4sHIfLFCHuIeotzo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WyWjwyNi++3ApJKfriW3KnXMmLBKbVkiVLTSscWLLvGTQ+UndwdUzII4h7HkR38h5
	 UhH+bVPEoj/mrSQctu2SPn7N/l7zi2U0yEFmP8pthAU84PSNBTfBHVXrRz6CtIKR4W
	 n1OeHW1sXIGMKM9bDGLK9n9jOE1cE32g2gzpR1gLjBUwJEwiC8WxCS2P26Bm7zKans
	 nXzL5dLROiITchYaylhMbVh6Jv+oyooxm9sdgFgKot71EbcebGMrooC4ZkIqG3VRa2
	 zlV9r27LTkKNGVJGnzQXGgDbFi4G5zxiQTStUzYg9Gv1PNF7OZDXApJMT9kN6dsCeB
	 gUtzgqiU7MIYg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BD911C4332C;
	Wed, 10 Jul 2024 02:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] mlxsw: Improvements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172057743277.1917.11660224520323271282.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jul 2024 02:10:32 +0000
References: <cover.1720447210.git.petrm@nvidia.com>
In-Reply-To: <cover.1720447210.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, idosch@nvidia.com,
 mlxsw@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 8 Jul 2024 16:23:39 +0200 you wrote:
> This patchset contains assortments of improvements to the mlxsw driver.
> Please see individual patches for details.
> 
> v2:
> - Patch #1:
>     - changed to WARN_ONCE() with some prints
> - Patch #2:
>     - call thermal_cooling_device_unregister() unconditionally and mention
>       it in the commit message
> - Patch #3:
>     - reword the commit message to reflect the fact that the change both
>       suppresses a warning and avoid concurrent access
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] mlxsw: Warn about invalid accesses to array fields
    https://git.kernel.org/netdev/net-next/c/b45c76e5f43f
  - [net-next,v2,2/3] mlxsw: core_thermal: Report valid current state during cooling device registration
    https://git.kernel.org/netdev/net-next/c/a22f3bc80075
  - [net-next,v2,3/3] mlxsw: pci: Lock configuration space of upstream bridge during reset
    https://git.kernel.org/netdev/net-next/c/0970836c348b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



