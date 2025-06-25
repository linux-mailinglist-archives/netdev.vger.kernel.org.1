Return-Path: <netdev+bounces-200885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44959AE73B7
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 02:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C80F917AF2B
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 00:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE1820330;
	Wed, 25 Jun 2025 00:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJTfz/Y1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D0F29408;
	Wed, 25 Jun 2025 00:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750810788; cv=none; b=LTRCvm0ZhbmBqGy5oAFOT/RwA4cDE7Da2Ebtewuv/1eJL7gUATZpJXDkSCa++ibkCyu6UwZe74OU9GGd1BBLDPsSRFBKf6XVs9KcAXP9rQDkXE1Gu9hkO0ZqjuJLZPNDcBYpQ8ZDpQNcc/Xz1D0LjT7Spy4TSHhmokgdZtdiZq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750810788; c=relaxed/simple;
	bh=AEysO/7hrlR6JL0IE++5oBEgqmDvVKEURUzZQDzyRTM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SFlFaeP/SZFXs4/7AwYWXkbYgn0i/b4P3M3LCgtIv2k1ZVq5y2cs8Ofw4+hep5BDurPNu6FVpMq4zOr5Mfo97tC6JTegkICA9uN1tqZTYUa1ILysFRAMdumbjmsQRtMtHPYfOkPMOS1AOYzNLSVIuEj8hD8CM+WbbKJUzjnw1dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJTfz/Y1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F705C4CEF0;
	Wed, 25 Jun 2025 00:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750810788;
	bh=AEysO/7hrlR6JL0IE++5oBEgqmDvVKEURUzZQDzyRTM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RJTfz/Y1tA+lvrjhi7eMKJHnLa0CJAg0kDCxdzdV7dtTDx7vI//2F0CoEOSoC+fzY
	 cgrTZTaUkk8W8Y+JazGyyIIWc6NVsGmhmHrej1BX7clj0B85vwa0bmVz0WDvpR67/p
	 kJTxUytWMdqbj6hrf7KKmxzipKWwRkH4OBdUks1EFx35Ds+7FU5aQtAhOjApU38iBP
	 oQmV8qJBwZt1K5TN95kq8FckyLnDlitUcy8XgsvND2w37c/uKzrugt+eQYVZpP+MMB
	 aWSfExxnKzAAjeeCM29RyhRHlr1MDWuYS0oFIZUxHneRf68oTPb+xSY3YExNMDBrhm
	 H1qABnK5IQj3w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE3D39FEB7C;
	Wed, 25 Jun 2025 00:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 net-next 0/7]There are some cleanup for hns3 driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175081081475.4081312.3746271660520654145.git-patchwork-notify@kernel.org>
Date: Wed, 25 Jun 2025 00:20:14 +0000
References: <20250623040043.857782-1-shaojijie@huawei.com>
In-Reply-To: <20250623040043.857782-1-shaojijie@huawei.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shenjian15@huawei.com, wangpeiyang1@huawei.com, liuyonglong@huawei.com,
 chenhao418@huawei.com, jonathan.cameron@huawei.com,
 shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 23 Jun 2025 12:00:36 +0800 you wrote:
> There are some cleanup for hns3 driver
> 
> ---
> ChangeLog:
> v3 -> v4:
>   - Drop the patch about pointer set to NULL operation, suggested by Jakub Kicinski
>   v3: https://lore.kernel.org/all/20250621083310.52c8e7ae@kernel.org/
> v2 -> v3:
>   - Remove unnecessary pointer set to NULL operation, suggested by Simon Horman.
>   v2: https://lore.kernel.org/all/20250617010255.1183069-1-shaojijie@huawei.com/
> v1 -> v2:
>   - Change commit message and title, suggested by Michal Swiatkowski.
>   v1: https://lore.kernel.org/all/20250612021317.1487943-1-shaojijie@huawei.com/
> 
> [...]

Here is the summary with links:
  - [v4,net-next,1/7] net: hns3: fix spelling mistake "reg_um" -> "reg_num"
    https://git.kernel.org/netdev/net-next/c/befd4e971a78
  - [v4,net-next,2/7] net: hns3: use hns3_get_ae_dev() helper to reduce the unnecessary middle layer conversion
    https://git.kernel.org/netdev/net-next/c/2031f01394b2
  - [v4,net-next,3/7] net: hns3: use hns3_get_ops() helper to reduce the unnecessary middle layer conversion
    https://git.kernel.org/netdev/net-next/c/5306c1039686
  - [v4,net-next,4/7] net: hns3: add \n at the end when print msg
    https://git.kernel.org/netdev/net-next/c/dd9480f6ed28
  - [v4,net-next,5/7] net: hns3: delete redundant address before the array
    https://git.kernel.org/netdev/net-next/c/ad0cf0729f53
  - [v4,net-next,6/7] net: hns3: add complete parentheses for some macros
    https://git.kernel.org/netdev/net-next/c/84c0564b1c51
  - [v4,net-next,7/7] net: hns3: clear hns alarm: comparison of integer expressions of different signedness
    https://git.kernel.org/netdev/net-next/c/169d07e7e41c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



