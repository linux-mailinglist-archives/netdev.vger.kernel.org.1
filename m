Return-Path: <netdev+bounces-213649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 814D8B26192
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 11:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4F3C3B41F8
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 09:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF972EFD98;
	Thu, 14 Aug 2025 09:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAv3LaY5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908D31DE8BF;
	Thu, 14 Aug 2025 09:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755164995; cv=none; b=D44q0vHMT6rkLBc1onkZImUKGErtiuuYqteheAiyBobZPWNMT8FEC8d1fb5fwmbJ5qpsrtRa3U2C4V93JUmwkUsoIp43vftG2VGloke0oPcq3M30PdQcQPiI10uiKU9o5s53HvacaA8iFacTKL8jhZQUhVn8DrUuackGkFFvAKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755164995; c=relaxed/simple;
	bh=QijqeeZAJk/tmvxKzXV7P+Cfz+DAXyiUtDAsQsmKCYI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=izD6ovS7vQ0v7P48GDTrhX+a23SBsUSQcw6v2S0t+ZAD0ysZ1+yg4Wq39t+6/xBBFRqUqI8wQ+l4J/Hg7nIAi+VB91Nvxg+7MTgG/x937UkUz6PJkHcxPnDlsXyAvJcAN0n1Z56lOVHy7+9INfVYqHMkHLjMJBDDsCMrVlKwPjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAv3LaY5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B7FFC4CEED;
	Thu, 14 Aug 2025 09:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755164995;
	bh=QijqeeZAJk/tmvxKzXV7P+Cfz+DAXyiUtDAsQsmKCYI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lAv3LaY5WdUGABnzZuYvAD8yJN68DPkKwIsBoQSC52GqO/pa4ezwk7mg0Lz3WIftx
	 62MH9/DKVbtkEtJJphCUZiKtDIDW1sTIHSEzU6g6bDX9TLAbefkcv4BFW31EThDe5g
	 jUCOQA5lRQyQ1zUaIdTLweL4lLd1ebDIbIz/ZHQS/3vexJp5xY7/FLsdHgsMMun3RL
	 8VkKz8yZ1Z/mzpxcfc8DQaKsLrKgp0d2t8dNLTclDYp9BQNiXBZBKh5HrxSJA0G3X3
	 65QtIfe9ixq8O2vgwcKNOfKwPOFuhqsOXhRsfkidtmHTKe2lEU25VbF+9FOD5wKsNc
	 C5pHUAX5xZLxQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE0E39D0C3B;
	Thu, 14 Aug 2025 09:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: usb: asix_devices: add phy_mask for ax88772 mdio
 bus
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175516500650.217992.13483905383920200275.git-patchwork-notify@kernel.org>
Date: Thu, 14 Aug 2025 09:50:06 +0000
References: <20250811092931.860333-1-xu.yang_2@nxp.com>
In-Reply-To: <20250811092931.860333-1-xu.yang_2@nxp.com>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, max.schulze@online.de, khalasa@piap.pl,
 o.rempel@pengutronix.de, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 imx@lists.linux.dev

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 11 Aug 2025 17:29:31 +0800 you wrote:
> Without setting phy_mask for ax88772 mdio bus, current driver may create
> at most 32 mdio phy devices with phy address range from 0x00 ~ 0x1f.
> DLink DUB-E100 H/W Ver B1 is such a device. However, only one main phy
> device will bind to net phy driver. This is creating issue during system
> suspend/resume since phy_polling_mode() in phy_state_machine() will
> directly deference member of phydev->drv for non-main phy devices. Then
> NULL pointer dereference issue will occur. Due to only external phy or
> internal phy is necessary, add phy_mask for ax88772 mdio bus to workarnoud
> the issue.
> 
> [...]

Here is the summary with links:
  - [v2] net: usb: asix_devices: add phy_mask for ax88772 mdio bus
    https://git.kernel.org/netdev/net/c/4faff70959d5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



