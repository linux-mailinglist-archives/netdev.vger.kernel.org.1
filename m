Return-Path: <netdev+bounces-52813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2181380049D
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 08:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCD351F20CD1
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 07:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A61114276;
	Fri,  1 Dec 2023 07:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOGBcOl7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC8012B78
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 07:20:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 07C30C433CA;
	Fri,  1 Dec 2023 07:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701415227;
	bh=4V8u9ZIIwytvKoDoA3nxmOMiLC0tVk9c5+V/JLtyz8g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SOGBcOl7z2z8nKMlcHgh4M9C7MtZ+q2L07boxgszLvfZxE3enOw7IcJi33niBNW6J
	 1q48vvOreW0RyfkPVol67XAwSkaS5usCduOyrqDGbv2949V8614eTgLbJ+4g0UiiWt
	 LXvxzudOOUntbT1ZoSqx3oEVFyDhpC3U2nCysAJBAnWij26hvUyRLEfImfFEHzjOdr
	 izhtwvcp8tIuMvOqGKMW3i00EoOpleT5STp6KXIUNxBr23zgGx5Dt+ra0yk6d6/1cx
	 N1Tss6ovVUz5BvTZy7tBUZhwfRT3fjokGKiETMBAnvmjCa5Bd8d+wHHuCX57mMdGaH
	 6cau4Ss28qccA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DC7D1E19E31;
	Fri,  1 Dec 2023 07:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] support OCTEON CN98 devices
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170141522689.3845.10892409258943079543.git-patchwork-notify@kernel.org>
Date: Fri, 01 Dec 2023 07:20:26 +0000
References: <20231129045348.2538843-1-srasheed@marvell.com>
In-Reply-To: <20231129045348.2538843-1-srasheed@marvell.com>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, hgani@marvell.com,
 vimleshk@marvell.com, egallen@redhat.com, mschmidt@redhat.com,
 pabeni@redhat.com, horms@kernel.org, kuba@kernel.org, davem@davemloft.net,
 wizhao@redhat.com, konguyen@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 Nov 2023 20:53:46 -0800 you wrote:
> Implement device unload control net API required for CN98
> devices and add support in driver for the same.
> 
> Changes:
> V2:
>   - Changed dev_info print to dev_dbg in device_remove API
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] octeon_ep: implement device unload control net API
    https://git.kernel.org/netdev/net-next/c/b77e23f1b03e
  - [net-next,v2,2/2] octeon_ep: support OCTEON CN98 devices
    https://git.kernel.org/netdev/net-next/c/068b2b649fc1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



