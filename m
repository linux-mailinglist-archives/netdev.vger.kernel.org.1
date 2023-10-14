Return-Path: <netdev+bounces-40908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8D67C919E
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 02:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 146971C20D25
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 00:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E5237161;
	Sat, 14 Oct 2023 00:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pFeUR7eh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A62A34CFF
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 00:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08763C433C7;
	Sat, 14 Oct 2023 00:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697241626;
	bh=GAcmKTUyBLVRBp9mgNkUkskecOBkPUEphMvfi6OqIhw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pFeUR7ehb0aJ/epJJrFaKRr+Fqc7erJu7beB8RbGUw7bMXJ9UeLQN0nmJAbZcwrnp
	 uo1LJeivPBWUTJnyLSyMyJkb7V0NuI6ITU/o+9x+YC8lmBVHGmpZNplJntJ+sJ45Aj
	 rbt73ULLjW2aFuvvbpKMQIffFgMiy8hLrK5W4nRxpPdai49aR/WRIxM9aM14XDCIGI
	 Wt5IqPMq4OLV3pGPXN+4EsRcAQ1cRKwDaDV9exTb7g9VmopdNCdxtWfBghdbHLkl86
	 UC1AzrUbxwI0BhATGT3Gn49BT3mVMqVW6MOY7FL1UUOPhk0rrTj+/CVbbFqPvTcPg4
	 vtm7wsLbZb1wA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EA469E1F666;
	Sat, 14 Oct 2023 00:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/3] Wangxun ethtool stats
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169724162595.10042.8891635764408879809.git-patchwork-notify@kernel.org>
Date: Sat, 14 Oct 2023 00:00:25 +0000
References: <20231011091906.70486-1-jiawenwu@trustnetic.com>
In-Reply-To: <20231011091906.70486-1-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch, mengyuanlou@net-swift.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Oct 2023 17:19:03 +0800 you wrote:
> Support to show ethtool stats for txgbe/ngbe.
> 
> v2 -> v3:
> - remove standard netdev statistics
> - move some stats to the right ethtool_ops
> - remove test strings
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/3] net: libwx: support hardware statistics
    https://git.kernel.org/netdev/net-next/c/46b92e10d631
  - [net-next,v3,2/3] net: txgbe: add ethtool stats support
    https://git.kernel.org/netdev/net-next/c/9224ade65390
  - [net-next,v3,3/3] net: ngbe: add ethtool stats support
    https://git.kernel.org/netdev/net-next/c/0a2714d5e2d3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



