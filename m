Return-Path: <netdev+bounces-13236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A5073AE9D
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 04:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 225CD1C20E82
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 02:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0EE20E6;
	Fri, 23 Jun 2023 02:30:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D8E17F7
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 02:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 09B52C433C9;
	Fri, 23 Jun 2023 02:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687487421;
	bh=LoT1cg4zyU11gDTCuPqAyvdFlyVJgFvFy/QlS8hr4XU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YkgvgL5c4c/zY8R4e0PxRR28AXKWn42A0n/H9LJXBCK68W1n+sRfNIpe5rGZyDpTs
	 bky/evCmc+DK5sfjbhJUwF3ZDIAHoI0sKC+dBXU1eyo5WXihEHGfmv40U4q39qf859
	 8W/Z16o1VHQPqH8t24XG86TCA0SBvY4Bs95uMKfWLn5s3jAsxSNKlyabnXVXHCqk70
	 rykVHm2Wz+NmixfsIUvopexBJcTkKmYu/EfkSA+02JQNjw9yr5PxhF/Xol9QQUzSmq
	 qK19YxAuz5ng2H5HCEbMf4D5LaObNEyV1LczF99NVGmrnA3+VP0KwPcc9w2vJQc9qg
	 91ajVHqNuM56Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CDF80C395F1;
	Fri, 23 Jun 2023 02:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] MAINTAINERS: update email addresses of octeon_ep driver
 maintainers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168748742083.21061.10549192533508725101.git-patchwork-notify@kernel.org>
Date: Fri, 23 Jun 2023 02:30:20 +0000
References: <20230621101649.43441-1-sedara@marvell.com>
In-Reply-To: <20230621101649.43441-1-sedara@marvell.com>
To: Sathesh Edara <sedara@marvell.com>
Cc: linux-kernel@vger.kernel.org, sburla@marvell.com, vburru@marvell.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, hgani@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 21 Jun 2023 03:16:49 -0700 you wrote:
> Update email addresses of Marvell octeon_ep driver maintainers.
> Also remove a former maintainer.
> 
> As a maintainer below are the responsibilities:
> - Pushing the bug fixes and new features to upstream.
> - Responsible for reviewing the external changes
>   submitted for the octeon_ep driver.
> - Reply to maintainers questions in a timely manner.
> 
> [...]

Here is the summary with links:
  - [v2] MAINTAINERS: update email addresses of octeon_ep driver maintainers
    https://git.kernel.org/netdev/net/c/b9ec61be2d91

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



