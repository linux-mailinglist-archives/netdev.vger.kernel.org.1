Return-Path: <netdev+bounces-15949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 016BE74A8E1
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 04:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96695280DEB
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 02:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118B77F;
	Fri,  7 Jul 2023 02:20:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A80A15A4
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 02:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 90E4CC43391;
	Fri,  7 Jul 2023 02:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688696424;
	bh=v/sxdOUwnWXS1LagMLEUTFH7mjuxEv0dF05FFKvTtVc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kDQcmkvRwTkhyCkT7FYSzx0TpO9x+pVS3Se25rVBZbzxfxX91X2hWVAniP5UkMqRj
	 twp138yKUYCvKJgCEXlvbVkzK3hC8TwlYny2bNDYqecrPnangsNtPK9hYciZRDI3fu
	 aDxF2+rF4TdCdRoLSjTCg6P1VeBOcfBirO8dM4Ob2MXVFXEjMP0UT+yIjJyDMhPsUv
	 Y0U8fVwzVnFPHHl9EMOgfosRHl7Sngx49DgxV22J6ALWfuB9EwPgk5M158n3QJYjP0
	 7VFOZ2JqH0rO0sqm095mLB6lgLrePLyKLhF78hLCAsGbOMWq2uodJwoT/TyFactcgT
	 2SkqnB8g1vdGA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6FE69C74002;
	Fri,  7 Jul 2023 02:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] gve: Set default duplex configuration to full
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168869642445.27656.733398020265898815.git-patchwork-notify@kernel.org>
Date: Fri, 07 Jul 2023 02:20:24 +0000
References: <20230706044128.2726747-1-junfeng.guo@intel.com>
In-Reply-To: <20230706044128.2726747-1-junfeng.guo@intel.com>
To: Junfeng Guo <junfeng.guo@intel.com>
Cc: netdev@vger.kernel.org, jeroendb@google.com, pkaligineedi@google.com,
 shailend@google.com, haiyue.wang@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  6 Jul 2023 12:41:28 +0800 you wrote:
> Current duplex mode was unset in the driver, resulting in the default
> parameter being set to 0, which corresponds to half duplex. It might
> mislead users to have incorrect expectation about the driver's
> transmission capabilities.
> Set the default duplex configuration to full, as the driver runs in
> full duplex mode at this point.
> 
> [...]

Here is the summary with links:
  - [net] gve: Set default duplex configuration to full
    https://git.kernel.org/netdev/net/c/0503efeadbf6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



