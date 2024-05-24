Return-Path: <netdev+bounces-97955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 882B28CE4EB
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 13:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2966A1F21B39
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 11:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6083386242;
	Fri, 24 May 2024 11:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/t+YlXf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346C2433A4;
	Fri, 24 May 2024 11:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716550830; cv=none; b=OPHh0AeaRyJqZtpQVRN94JdJRc9ZssSqb5hdG9jznXmfJtuVZ4sNbpwVKuMOsneTGLcszc/2GUEIHyRsgVInbtwiyKDGBdi8wr7OLaDUWQUGPxTulZK+EgsW8wtriyJk10mxGEdrfDuhwNhs5ynNLqfmKJTSmzfC5Ss5Yg3dkcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716550830; c=relaxed/simple;
	bh=KQY3xqXY4b0WUCiY/yDkJ1BTG4PoCIuLFe0eHGjoJzs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OX6H0Z8CLTF4lgt8AWpBYhkJre18ywknb3l4UaaAiaQkw1q1E83MvqVgtQypddUrd8VU4+4socbxshLDlgD53kmq+VdqXwGe4pCLTi/iqJ42ggfi6YW3O6sgm3IdGTbh+BGTem/r0xJUsoCTq0jy7NKEae9vIv1t4yZfmgdtAjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/t+YlXf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88BE7C3277B;
	Fri, 24 May 2024 11:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716550829;
	bh=KQY3xqXY4b0WUCiY/yDkJ1BTG4PoCIuLFe0eHGjoJzs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=f/t+YlXfMCVfI9ayEdS037pVDq6M9uaIeQecOY5jirbRTgBqkSCPipRzXounCxOrJ
	 AQjPe9wX1fMTZevwmerERkKl9AuzTwU8UmX8gcVjHql8zt70Cg/TdhRh4SNqI7Lh3t
	 Zqa8wYQ2Ngw3Dfq76QhHdofqS4k3Oa//JlX+UWPtDcw38Q4bq3dQXjlngp2Oztf2mW
	 nDy5r6mxNinIQQ3nJxctzVOhWjaWSHtscTUU911sbnZ5jd8VBTqEbIHZua3IaYjReU
	 8WnMw5qjMyBl9sRQCKW1p0zgrKOo1FK1+5jDY/E1jK/eoD93FiS0xOAc9ov4DRcZdI
	 ioJdqIqZQ+89w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 77EF7CF21E0;
	Fri, 24 May 2024 11:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: phy: micrel: set soft_reset callback to
 genphy_soft_reset for KSZ8061
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171655082948.14489.8867165637123853171.git-patchwork-notify@kernel.org>
Date: Fri, 24 May 2024 11:40:29 +0000
References: <20240521065406.4233-1-othacehe@gnu.org>
In-Reply-To: <20240521065406.4233-1-othacehe@gnu.org>
To: Mathieu Othacehe <othacehe@gnu.org>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 f.fainelli@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 karim.benhoucine@landisgyr.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 21 May 2024 08:54:06 +0200 you wrote:
> Following a similar reinstate for the KSZ8081 and KSZ9031.
> 
> Older kernels would use the genphy_soft_reset if the PHY did not implement
> a .soft_reset.
> 
> The KSZ8061 errata described here:
> https://ww1.microchip.com/downloads/en/DeviceDoc/KSZ8061-Errata-DS80000688B.pdf
> and worked around with 232ba3a51c ("net: phy: Micrel KSZ8061: link failure after cable connect")
> is back again without this soft reset.
> 
> [...]

Here is the summary with links:
  - net: phy: micrel: set soft_reset callback to genphy_soft_reset for KSZ8061
    https://git.kernel.org/netdev/net/c/128d54fbcb14

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



