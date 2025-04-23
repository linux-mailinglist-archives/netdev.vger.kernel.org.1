Return-Path: <netdev+bounces-184964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D2CA97D26
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 05:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 914373B8E9E
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 03:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A923263F5D;
	Wed, 23 Apr 2025 03:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IVNi4u0P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BCE263F28
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 03:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745377794; cv=none; b=GIvU2lB65xXV9gKDPLR+ku3U3aVcI4B1uh2q48jSx2YG0FfM4YYPmqiGryZebh8EQKFgb0zoFlNGu+QnC09dN9h7wpzbU5LShhFSGr8fn/XEyLukBk5mOYB5+h20PF2QqibGrXq9QUTC3GSHPEybS2e3eJU94v12Qwh59vXXx9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745377794; c=relaxed/simple;
	bh=rco2GV0ZjCU4E3EyQQmX2eAtBe65fESWQqc1L14VPtk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bi4O61aexGZayyR7bHebT4t23lw3ZE+TRlTpEkUNf+wzRGWVc7IGF7tHkl0r2kx9L9NtSCbrP4gGQJWv+RfhYh8qDYFTy5bcY4GQWO3EFnH2PXTc2LnT99nyJ07AK34kcoGqsCFH9jKXp5BzcQekjYJ31yJpLUI+3KgXpgnpmEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IVNi4u0P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BC98C4CEEB;
	Wed, 23 Apr 2025 03:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745377793;
	bh=rco2GV0ZjCU4E3EyQQmX2eAtBe65fESWQqc1L14VPtk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IVNi4u0Pu7GTB5LNeHf4le3wqqt3A7yk2h1POYwhzdEcQvgVM01e4gd9pbX7YZkrc
	 2HL4F/NtWZt+YQzrJrkTTM/A9PB7QViAck91PnBbu9UiRsXJc+fP+3TUB7Ndm9XWih
	 SuDeLZWnzBtVfZVA8302v8u0y2bfBlvPn+ivlp3jtC5fIPZW5Ha4dQI4hNBaacmRxx
	 80g52rRd8hjImIsbT17zF9K55y1HAS4Td/Zq1JJa9UcZVhps+FJYADjLsZdgFuF8km
	 kJXAzlbBg6wMHEV1rzXBQWBiFl7oIjyjjC1+2HzoVw197aCAYgkjp79fT4J283UecI
	 f5qhxkmg9cmDQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CF5380CEF4;
	Wed, 23 Apr 2025 03:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/2] Implement udp tunnel port for txgbe
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174537783200.2126900.12383356657602798619.git-patchwork-notify@kernel.org>
Date: Wed, 23 Apr 2025 03:10:32 +0000
References: <20250421022956.508018-1-jiawenwu@trustnetic.com>
In-Reply-To: <20250421022956.508018-1-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 dlemoal@kernel.org, jdamato@fastly.com, saikrishnag@marvell.com,
 vadim.fedorenko@linux.dev, przemyslaw.kitszel@intel.com,
 ecree.xilinx@gmail.com, rmk+kernel@armlinux.org.uk, mengyuanlou@net-swift.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 21 Apr 2025 10:29:54 +0800 you wrote:
> v4:
>  - Lint to v3: https://lore.kernel.org/all/20250417080328.426554-1-jiawenwu@trustnetic.com/
>  - Remove udp_tunnel_nic_reset_ntf()
> 
> v3:
>  - Link to v2: https://lore.kernel.org/all/20250414091022.383328-1-jiawenwu@trustnetic.com/
>  - Use .sync_table to simplify the flow
>  - Remove SLEEP flag and add OPEN_ONLY flag
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/2] net: txgbe: Support to set UDP tunnel port
    https://git.kernel.org/netdev/net-next/c/f294516f1ff2
  - [net-next,v4,2/2] net: wangxun: restrict feature flags for tunnel packets
    https://git.kernel.org/netdev/net-next/c/3b05aa997c49

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



