Return-Path: <netdev+bounces-24477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D03E77043E
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 17:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B74991C218AF
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 15:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32E918030;
	Fri,  4 Aug 2023 15:20:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB98BE6D
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 15:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29CE9C433C9;
	Fri,  4 Aug 2023 15:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691162423;
	bh=iPjxSht+GT73NRCVjDP95LlntA7GMLpiisR9HGnUIUU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Bn9Zzw9k1FkHF1zhrI4MhRo4eMnDxyg/Zsimq1Fi4smwmKP2pjckPY/sk4YLaFTQ2
	 p5gkz4G7ehIhMFxI0WhS2HdbDw5ebpbu1TTT7op8EQS+rRNsOXOsxu/Ettt2XUvx3i
	 zA1yRz3WlOHACLR3lBxHOjWHtstYfhgUckFhwKBx2c6BKFAGMB2GUl8jkc9kRi8JbA
	 lenndkMvSO9w1QWjFdqqAAoQy25tgAwLBXQhIpZMnnwvWoNHYPaRZDrIxnvrKfmsZC
	 MohckPr1rgel2SAO0QCAWOIIKvlwy5RYp8/5Pp+7bihDcOCfQM6DvKzY+R8MVHi58d
	 VAr8YwPVBkLmA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0D4C9C41620;
	Fri,  4 Aug 2023 15:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next v2] bridge: Add backup nexthop ID support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169116242305.18058.11450873952514289925.git-patchwork-notify@kernel.org>
Date: Fri, 04 Aug 2023 15:20:23 +0000
References: <20230802164115.866222-1-idosch@nvidia.com>
In-Reply-To: <20230802164115.866222-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org, dsahern@gmail.com,
 petrm@nvidia.com, razor@blackwall.org

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Wed, 2 Aug 2023 19:41:15 +0300 you wrote:
> Extend the bridge and ip utilities to set and show the backup nexthop ID
> bridge port attribute. A value of 0 (default) disables the feature, in
> which case the attribute is not printed since it is not emitted by the
> kernel.
> 
> Example:
> 
> [...]

Here is the summary with links:
  - [iproute2-next,v2] bridge: Add backup nexthop ID support
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=77430db000fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



