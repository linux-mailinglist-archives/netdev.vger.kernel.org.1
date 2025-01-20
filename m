Return-Path: <netdev+bounces-159754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 698CAA16BCD
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 12:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1357E3A6BA6
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 11:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F31A1DF75D;
	Mon, 20 Jan 2025 11:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SP6lFugz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259361DF27C;
	Mon, 20 Jan 2025 11:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737373807; cv=none; b=X6IYeDByckVsrKXzFpwQAdQ/YpxadCEt9uNm4BAwD8lxLDjZHOyz0vrCYmRJyn8x4Yw0bHXb3L62OHp8bu2eOVnBcPzG9Jly7/hSWiEOhRnFwL+gAYAvXLd7DbqhSFXSiX7MwvquCZOfZ70CjXGcDC7kxHXrrazvogj4UEX0YcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737373807; c=relaxed/simple;
	bh=qciLyTOuYq2ZPK1Je9yzp78BscveuE4fdomGkuEbFmM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cVImC8j/d0ciPdRSM0wS69r+dBRrowQpXoA3WyybaLTCo4qtrl4ryaOcM2WJfRLaxOpCr3GMDCrUsxgLJox9g8bhcyJ+BUsgqJAsBqjymdTSIscbD16tJSA78QCrBP4XUBl+w7mrm1QtEOQTdETS10Hp1gV7eUChCyjvPfdviyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SP6lFugz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81489C4CEDD;
	Mon, 20 Jan 2025 11:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737373806;
	bh=qciLyTOuYq2ZPK1Je9yzp78BscveuE4fdomGkuEbFmM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SP6lFugzS3TBIOIASZbyhso6Q80pFTES0lKKguPDng7XCAKbSEqYHDCUEP48DVtXg
	 1ksSxNjwTLdGaQfOKeOMpEUz4yR22WzPFLy7qdkmucDuCvjhPQ08uMjqLe7kAtNANl
	 i4qwWsGwjtJP5xjpe3hlm+KnZrBiTb5RIrLpyagL5Ep1iTjgGARFgt+pI4E2XyE5ps
	 JkdohyhS2v8f1sl9a2NPy491jVGumhIHJ4lnOKETwlCcfEOITiPQNKsIwRPkuwiiRg
	 imwpH0Hqfx2X6LTWQQ/Sf9nl7ZOHB4Cq7niwbHU5WbyLjpHqXFvT75MkMtX0HsrIdD
	 DfIY7UkpV99Jw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE1B380AA62;
	Mon, 20 Jan 2025 11:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH ethtool] netlink: settings: Fix PHYAD printing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173737383049.3501343.904984655087875046.git-patchwork-notify@kernel.org>
Date: Mon, 20 Jan 2025 11:50:30 +0000
References: <20250117225019.3912340-1-florian.fainelli@broadcom.com>
In-Reply-To: <20250117225019.3912340-1-florian.fainelli@broadcom.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, f.pfitzner@pengutronix.de, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ecree.xilinx@gmail.com, andrew@lunn.ch, maxime.chevallier@bootlin.com,
 danieller@nvidia.com, kory.maincent@bootlin.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to ethtool/ethtool.git (master)
by Michal Kubecek <mkubecek@suse.cz>:

On Fri, 17 Jan 2025 14:50:19 -0800 you wrote:
> The PHY address was printed in hexadecimal rather than decimal as it
> used to be and is expected.
> 
> Fixes: bd1341cd2146 ("add json support for base command")
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  netlink/settings.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [ethtool] netlink: settings: Fix PHYAD printing
    https://git.kernel.org/pub/scm/network/ethtool/ethtool.git/commit/?id=c6ea3bc04c73

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



