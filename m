Return-Path: <netdev+bounces-25638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21657774F8F
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 01:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 042041C210AC
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 23:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8801CA0A;
	Tue,  8 Aug 2023 23:50:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916D31C9F0
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 23:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F33CBC433D9;
	Tue,  8 Aug 2023 23:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691538621;
	bh=XpbhhslJWadDEEWihoHnkUwP06pOoNC3XTVXTvxuGnI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZA66JGjO40krgvmIbA1ucBE9mWNsBnVmVhwjKbMvd0sdaeVr4fPI/C+3fwZ7EVQvo
	 awqXqNHiDUQGAwXqdb1q1HQmUKNWGY2vVUgRViz7p+8oCknSiXw/7/YeYgeY6jAeKZ
	 RBHDE1Xjq9l7bx512Uw249NhptqBdsgfkMUIiva1K7kiqCEcRUmKHEd33YUDvM5CX5
	 ErUsj5co4MhoPCL1dpejrZTlMagT92BmdBjgHcBSBPmK1YN3xEi0sesw0kD2ih538Z
	 7zMUQGb/bpYh73D6LBteeFqKaJ9VqizmLoHHaVM0EJdAStR/rQau48azCm1ChzdWEC
	 Lso47oDDyCefQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D8D2DC595C2;
	Tue,  8 Aug 2023 23:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] iavf: fix potential races for FDIR filters
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169153862088.1266.17935146579994534812.git-patchwork-notify@kernel.org>
Date: Tue, 08 Aug 2023 23:50:20 +0000
References: <20230807205011.3129224-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20230807205011.3129224-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, piotrx.gardocki@intel.com,
 rafal.romanowski@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  7 Aug 2023 13:50:11 -0700 you wrote:
> From: Piotr Gardocki <piotrx.gardocki@intel.com>
> 
> Add fdir_fltr_lock locking in unprotected places.
> 
> The change in iavf_fdir_is_dup_fltr adds a spinlock around a loop which
> iterates over all filters and looks for a duplicate. The filter can be
> removed from list and freed from memory at the same time it's being
> compared. All other places where filters are deleted are already
> protected with spinlock.
> 
> [...]

Here is the summary with links:
  - [net] iavf: fix potential races for FDIR filters
    https://git.kernel.org/netdev/net/c/0fb1d8eb234b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



