Return-Path: <netdev+bounces-22231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CE27669EE
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 12:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F28FA1C217CF
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 10:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D5611C87;
	Fri, 28 Jul 2023 10:10:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B7911C88
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 10:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5F690C433C8;
	Fri, 28 Jul 2023 10:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690539024;
	bh=GFD7yQTW1E+U5yucY34yXq1bDEXUfFmL7ocQylgukHQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=l8STCjesLUUCibFf0oaoLRIugxQiP1GVNA3MeXPArWQot6O+NuNhBhpH716yGsSiU
	 jB2xphIxzTWAtjhFAkeBiRIC8hZgzHal6QNLB8rQyNTz5lhuW9YOAWApf8L8hd6MwH
	 ViEcTJ5/cWWxv6H0PavoLGnQBtfEi4o34AiqB0yEw53OORCKU85RmQSJn/E6rE1Xhx
	 hA1KILLmyk3iRPZnzuskDBDv1ORlFWn8Ra08fjVOzGB5j6BHjFEcKA3KPTHlO/FpCL
	 tgcVv0ST3g+UmiQ1vdC71BbwumSn4R3ygI0poD8bkuaU/jAC+af77MXaD6ZaV8jbLj
	 rRA6O0e1bPtRA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 44C46E21ECC;
	Fri, 28 Jul 2023 10:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] selftests/ptp: Add support for new timestamp
 IOCTLs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169053902427.13986.1880918301983575939.git-patchwork-notify@kernel.org>
Date: Fri, 28 Jul 2023 10:10:24 +0000
References: <cover.1690321709.git.alex.maftei@amd.com>
In-Reply-To: <cover.1690321709.git.alex.maftei@amd.com>
To: Alex Maftei <alex.maftei@amd.com>
Cc: richardcochran@gmail.com, shuah@kernel.org, rrameshbabu@nvidia.com,
 davem@davemloft.net, kuba@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 25 Jul 2023 22:53:32 +0100 you wrote:
> PTP_SYS_OFFSET_EXTENDED was added in November 2018 in
> 361800876f80 (" ptp: add PTP_SYS_OFFSET_EXTENDED ioctl")
> and PTP_SYS_OFFSET_PRECISE was added in February 2016 in
> 719f1aa4a671 ("ptp: Add PTP_SYS_OFFSET_PRECISE for driver crosstimestamping")
> 
> The PTP selftest code is lacking support for these two IOCTLS.
> This short series of patches adds support for them.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] selftests/ptp: Add -x option for testing PTP_SYS_OFFSET_EXTENDED
    https://git.kernel.org/netdev/net-next/c/c8ba75c4eb84
  - [net-next,v2,2/2] selftests/ptp: Add -X option for testing PTP_SYS_OFFSET_PRECISE
    https://git.kernel.org/netdev/net-next/c/3cf119ad5dc2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



