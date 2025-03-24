Return-Path: <netdev+bounces-177129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CEFA6DFFD
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 17:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0FDE3B28AC
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 16:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7F92641C5;
	Mon, 24 Mar 2025 16:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcVil8TR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E5B25F96B;
	Mon, 24 Mar 2025 16:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742834402; cv=none; b=itNIDqSLeoBFqQY4DT+hBUhICP56bb1x+XlL1lIprRRe/Q+hS59RONTPA7O7fBBKaWBNpkmy8oU4DsBBY7KZsXAv/4Uf5tDVlU07OxVI3nAZBs/7qQkDkNc4w8F+eNg3Sm4IrDInNCNpAewJmR9Uy8pSF2VtoDa29tWmdmS/uLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742834402; c=relaxed/simple;
	bh=ScvMxJI186dl4CQyaDxTn9qhivQxRTBmg5YWV6j7RAo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ebdpBz2BQFKQGWOl/yasKWDkCYOHyIJksfygs97WFFKQ6+6xAJUOJyUiQt3GyK4tchh9xT3K2YKUDb3WvxIv5Mrk1HRyW7HdyLCCmVdjErt9VCWGdMlwH1xrgWNbgqP57kNnCaiCnTOvzHrO77Dyo7u3nbuTfyBGqAauNH9iZPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hcVil8TR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F35EC4CEDD;
	Mon, 24 Mar 2025 16:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742834402;
	bh=ScvMxJI186dl4CQyaDxTn9qhivQxRTBmg5YWV6j7RAo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hcVil8TRfzS2hEfvDVxQ3tmxRCv25jmBOxAgwa9BhRdLK8zC3qgNl7ARNTQK91Igk
	 TrICu1AYnObX632AHHtLPwWBzIVt6so4SsvyRclrvw2W/ODxuwL8C9eBa9hjnI+iXT
	 z5XxWAPXjrUyS+kBsDK61xbID9r6L1dHueJzA5fAh7HKmuQmQ3AMeUIZxeu/N0nosT
	 3UcOX8ZO9jmSnnX9u1xQw6/7wld/kMxV+VbjeuCUUiS2+KFl3cYEGBzcGP0fYPlK+T
	 0ReZInUBPYryI0ikYy8TL+iZIiHIyDiy49OYST7LBfh0BXCRe5ms01Ssk2WPejmBR3
	 SGLlzIQyudpQw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70FD3380664D;
	Mon, 24 Mar 2025 16:40:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: phy: phy_interface_t: Fix RGMII_TXID code comment
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174283443813.4090423.15655049016392813950.git-patchwork-notify@kernel.org>
Date: Mon, 24 Mar 2025 16:40:38 +0000
References: <20250316071551.9794-1-ihor.matushchak@foobox.net>
In-Reply-To: <20250316071551.9794-1-ihor.matushchak@foobox.net>
To: Ihor Matushchak <ihor.matushchak@foobox.net>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 16 Mar 2025 08:15:51 +0100 you wrote:
> Fix copy-paste error in the code comment for Interface Mode definitions.
> The code refers to Internal TX delay, not Internal RX delay. It was likely
> copied from the line above this one.
> 
> Signed-off-by: Ihor Matushchak <ihor.matushchak@foobox.net>
> ---
>  include/linux/phy.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - net: phy: phy_interface_t: Fix RGMII_TXID code comment
    https://git.kernel.org/netdev/net-next/c/ca1914a32cdc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



