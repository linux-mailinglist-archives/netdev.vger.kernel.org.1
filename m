Return-Path: <netdev+bounces-194461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23865AC98EF
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 04:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44EF69E469F
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 02:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385D64EB38;
	Sat, 31 May 2025 02:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrXFW70h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128EC1096F
	for <netdev@vger.kernel.org>; Sat, 31 May 2025 02:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748659195; cv=none; b=A2hMR1h2NRvO3+4IOO1PjTz66iSrcKeAwu+Oa8Ql0jqadZZD3/O7uLbY5eONMn9uhQJpNg5T9szhxk6JCuypBZlSU3tzRnOsRc4lBFIAbLFlRFjUBWtA/tIzpfEFRCAh+0U4B0gVPXxixWcRVTQdJowF8fy/aaC9EplH/HrrAj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748659195; c=relaxed/simple;
	bh=8aEffykvU0v5dzPiCeUk5v35ZSw2IomsBpIPCpOjXA4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Bxg7+cynzvL3Wt+Ix0fkcgm2Wj6+jxtdgujzX4KgypaDMiaf8h4s7lW+0E2qn4DzuaIh1MhUTX3k2yemaPwolzhnscc6MjQ1WnxxEbp0kMPrdafUIjkORGO+v2SA3st3RfglBfOrZ4O932bk4E70OcHsGVaaeEgMcPM8MFWk0Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lrXFW70h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E06AEC4CEEB;
	Sat, 31 May 2025 02:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748659194;
	bh=8aEffykvU0v5dzPiCeUk5v35ZSw2IomsBpIPCpOjXA4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lrXFW70h10oabKQmfpbX8medJl1kCGaED4KDRWwTQJc+q6aivgmm3i28jFsvzKotK
	 manvoFPLV7TQ2HQ7LE0Kh8eQSOMjc4DzU2IYW3XDjtqLT0Zkexdvutj+Ic0WTIC8XC
	 azffFK4cS3Rw7yo+6JIMBa8Z8D54FdP5LNybBpnQQJHprwi2NwbxcK3AjLNuJhnzFL
	 2tB5um4vERp4tyRUYe/YNpo7yKTud0lDgT5DXa0eJ/fLjdLsRU0P5NhqVNlBalu1aN
	 Gqli1DOe2s4ZDueF3GjGl8SDqaMk83Kov/h+h5V2Ni4BabGB/8X7WkVouegdXpBbOl
	 T8LXEE0LYuAEQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7180939F1DF3;
	Sat, 31 May 2025 02:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: Fix net_devmem_bind_dmabuf for non-devmem
 configs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174865922825.10348.16576687297132828921.git-patchwork-notify@kernel.org>
Date: Sat, 31 May 2025 02:40:28 +0000
References: <20250528211058.1826608-1-praan@google.com>
In-Reply-To: <20250528211058.1826608-1-praan@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, willemb@google.com,
 almasrymina@google.com, kaiyuanz@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 28 May 2025 21:10:58 +0000 you wrote:
> Fix the signature of the net_devmem_bind_dmabuf API for
> CONFIG_NET_DEVMEM=n.
> 
> Fixes: bd61848900bf ("net: devmem: Implement TX path")
> Signed-off-by: Pranjal Shrivastava <praan@google.com>
> ---
>  net/core/devmem.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] net: Fix net_devmem_bind_dmabuf for non-devmem configs
    https://git.kernel.org/netdev/net/c/c1f4cb8a8d48

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



