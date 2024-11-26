Return-Path: <netdev+bounces-147357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A76379D940F
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 10:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B75BB168377
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 09:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127651B78F3;
	Tue, 26 Nov 2024 09:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMoVL8rg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07D01B652C;
	Tue, 26 Nov 2024 09:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732612822; cv=none; b=WOsM6h8fhzBTa31s8CRjZgujPC1AAF3dO0R0DDaJq6xBhFh+P8zOopVBY3Aa68W6s5S8m1xG4hKX5peHI+TbuonvxDd41h7jTUo7nhTbD+FKeM2UV9h7SERul13XMFzZcwgq6+ENyIgob3kNyJcIx2jTL8sweMSA/1UCkSrRta8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732612822; c=relaxed/simple;
	bh=Ctg6MXostCZ1aJoI4FFc/g312bq9jtegH+oNd3mbPbM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ijbbeS8PcnEUv7um2MDt1P34CwFZ+ZPCZtRE9zrfrSnsw84voIRRiyOkwVz2dcdh1knnr1M8rfqFUhT6X6HztAEUwQc5kgq5LLQWGH9GOIvFnyt2FBS7GWk9TfrHuERsJC6KQWCEh0uWdVCEmGP2e9/jeHvraH9mTRoABK4VGHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMoVL8rg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFAE4C4CED0;
	Tue, 26 Nov 2024 09:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732612821;
	bh=Ctg6MXostCZ1aJoI4FFc/g312bq9jtegH+oNd3mbPbM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hMoVL8rgbDSJZsho/GqGrLQfqMe65YqL/OcfkOgVu/5jtxIXo8eRmaxd5wQMHI7Nw
	 NOpZRQVuhvE4/31lTFsVwpoOXbRIjh8MmLZlhrpC8eIOoSvx1X0a5myta69XiHNnyh
	 WbGIGB6h6kr7sxp3NIu2OXa4/KGahf4K56dR1iU5okxS2CJ+uTHGVlypIj7r5/mfuD
	 3zpFVLmxKFDzPZB1ZIgdNYca9r8eZ0h9j2Hlf75mjRDYzvGWLEgkZg8EL+YJibtO9G
	 w6Drte+7iDFIi6DA5fcAK/wscZBGCqtrcTo55HOA0ug0sHRJ8vpIzIYNYlFzcCoNWR
	 veNEsxTuP20/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AEB873809A00;
	Tue, 26 Nov 2024 09:20:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/1] net: stmmac: set initial EEE policy configuration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173261283425.319179.1006458233398022415.git-patchwork-notify@kernel.org>
Date: Tue, 26 Nov 2024 09:20:34 +0000
References: <20241120083818.1079456-1-yong.liang.choong@linux.intel.com>
In-Reply-To: <20241120083818.1079456-1-yong.liang.choong@linux.intel.com>
To: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Cc: andrew+netdev@lunn.ch, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 mcoquelin.stm32@gmail.com, o.rempel@pengutronix.de, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 20 Nov 2024 16:38:18 +0800 you wrote:
> Set the initial eee_cfg values to have 'ethtool --show-eee ' display
> the initial EEE configuration.
> 
> Fixes: 49168d1980e2 ("net: phy: Add phy_support_eee() indicating MAC support EEE")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
> 
> [...]

Here is the summary with links:
  - [net,1/1] net: stmmac: set initial EEE policy configuration
    https://git.kernel.org/netdev/net/c/59c5e1411a0a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



