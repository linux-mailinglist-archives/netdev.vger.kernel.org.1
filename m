Return-Path: <netdev+bounces-32472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D37C5797BE2
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 20:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0975E1C20B12
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 18:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024F78BF5;
	Thu,  7 Sep 2023 18:30:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C2A1400E
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 18:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DC52CC433CA;
	Thu,  7 Sep 2023 18:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694111424;
	bh=tPFCro4n4XqbzbiVH/c6S+dFL87j2IymQ5QNMO7GpnA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q6Uql2sI+pjR+2RawyCVkn6PrmAL3ckHOnxI1qEQ2N6P0MnQepCQ8j5WoRBKn4WCu
	 mAocpfL3E0NiZuSeVMKHyoEXEqTOqRyVoxe1dK69uUAjL832v3IWSRVgCqHw7YfAK1
	 AF/Zz8IpZnepTbKqAt+38NOhH+5+S1Id0iGac2qbmqcKPonuFqfT04FyKBM6mUApv6
	 DPRMXSm4PgZToZK5nu3d/pA1f6BI8vc1tW5YO6iMt6MqrG2klCniz8T1xuZja4FWSW
	 FWuHSOOkgiwIQQnRWrmC/rKNUSBXKJZqLDTUqp/dkWVk/o+QIL9MuqujFlzydUw2Xm
	 9cWgXAugeQVDg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BE3D8C4166F;
	Thu,  7 Sep 2023 18:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: enetc: distinguish error from valid pointers in
 enetc_fixup_clear_rss_rfs()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169411142477.4092.10947806557916457815.git-patchwork-notify@kernel.org>
Date: Thu, 07 Sep 2023 18:30:24 +0000
References: <20230906141609.247579-1-vladimir.oltean@nxp.com>
In-Reply-To: <20230906141609.247579-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, claudiu.manoil@nxp.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, dan.carpenter@linaro.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  6 Sep 2023 17:16:09 +0300 you wrote:
> enetc_psi_create() returns an ERR_PTR() or a valid station interface
> pointer, but checking for the non-NULL quality of the return code blurs
> that difference away. So if enetc_psi_create() fails, we call
> enetc_psi_destroy() when we shouldn't. This will likely result in
> crashes, since enetc_psi_create() cleans up everything after itself when
> it returns an ERR_PTR().
> 
> [...]

Here is the summary with links:
  - [net] net: enetc: distinguish error from valid pointers in enetc_fixup_clear_rss_rfs()
    https://git.kernel.org/netdev/net/c/1b36955cc048

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



