Return-Path: <netdev+bounces-29031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3150D7816D5
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 04:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDEC7281C91
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 02:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B26C63C;
	Sat, 19 Aug 2023 02:50:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7640A65B
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 02:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EAEB5C433C7;
	Sat, 19 Aug 2023 02:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692413425;
	bh=pd5GunhyUmBlcMLPbhp3fXo1MtgoOXZq9O8Oj9ws/qw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dKp8bj4BqGW/ytADDUb98mgBlbaQvimBw2u907CUQjwe89OnFQUjzgKgseGd4HAvy
	 YGq5lhnCNPSnAd9GQNiEorjPpWBZWosXNGVOs7WoHjbnqjz7H2Bj4KPuvLMzwPrZGw
	 /oJj3o+JFs9bBUsktdWxIjpJYp2zZNI/v5JcmhMJ29npT6ZH3TJ5Qoo3wISsQNcNpq
	 pPysv8jDVEarXIntGklWigaCUev85u55n5jpOuAdzRE/6AQ/99ByNyYCjO5UB85BZb
	 VRt7QIFUSSCuMftTiBXqwBCBZJtRi1hejIHE3HsXE373D09lY7vBOmaTCyT6+DOope
	 ZrT8KIMSOwDeg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CEDA0C395DC;
	Sat, 19 Aug 2023 02:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4] mlxsw: Fixes for Spectrum-4
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169241342484.21912.18432169048267516418.git-patchwork-notify@kernel.org>
Date: Sat, 19 Aug 2023 02:50:24 +0000
References: <cover.1692268427.git.petrm@nvidia.com>
In-Reply-To: <cover.1692268427.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, idosch@nvidia.com,
 amcohen@nvidia.com, danieller@nvidia.com, mlxsw@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 17 Aug 2023 15:58:21 +0200 you wrote:
> This patchset contains an assortment of fixes for mlxsw Spectrum-4 support.
> 
> Amit Cohen (1):
>   mlxsw: Fix the size of 'VIRT_ROUTER_MSB'
> 
> Danielle Ratson (1):
>   mlxsw: pci: Set time stamp fields also when its type is MIRROR_UTC
> 
> [...]

Here is the summary with links:
  - [net,1/4] mlxsw: pci: Set time stamp fields also when its type is MIRROR_UTC
    https://git.kernel.org/netdev/net/c/bc2de151ab6a
  - [net,2/4] mlxsw: reg: Fix SSPR register layout
    https://git.kernel.org/netdev/net/c/0dc63b9cfd4c
  - [net,3/4] mlxsw: Fix the size of 'VIRT_ROUTER_MSB'
    https://git.kernel.org/netdev/net/c/348c976be0a5
  - [net,4/4] selftests: mlxsw: Fix test failure on Spectrum-4
    https://git.kernel.org/netdev/net/c/f520489e99a3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



