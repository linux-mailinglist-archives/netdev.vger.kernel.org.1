Return-Path: <netdev+bounces-34259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 671D97A2F45
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 12:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57C4F1C209BC
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 10:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8492412B79;
	Sat, 16 Sep 2023 10:40:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757AAEAE5
	for <netdev@vger.kernel.org>; Sat, 16 Sep 2023 10:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB828C433C9;
	Sat, 16 Sep 2023 10:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694860823;
	bh=gMjmVOJ/+tUIG7QXWPuL0HqhSpfLApgRTDaNzDhJKto=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ORRtssDw+IZq/dYNr3OoPgJ8nDNoEe7JYHUXYVmoXtLSCzEZj787CZ23urIS/T4Kv
	 aCGCtycVv7CbCORSrW7fHJynT9YkaUpopCHPnGq18rA8DXeNQ0WisZQeOZY+Cgna1H
	 bqS50j6XMz4zOBUWlocApSIHP3WEXTXzs0W3Ugof9xG5iubb7vWGRv/KfTLh10Q8ye
	 4E5PBgDMRZ7DZX+4goXQYMVSDXQnLoFSM5STtJ4VLtYXJzYwoWJ6CBscZ/UBvpIrI4
	 84Nr8Ani/+Zln7VXyhVOMLDmYW+mzNVjS2p4WUbSwTwBhN2BInMnIUKMXuIucQST/A
	 KpW03L3XdMi7g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AE10CE26882;
	Sat, 16 Sep 2023 10:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] sfc: make coding style of PTP addresses consistent
 with core
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169486082370.31413.1577389710976551346.git-patchwork-notify@kernel.org>
Date: Sat, 16 Sep 2023 10:40:23 +0000
References: <20230914151916.21044-1-alex.austin@amd.com>
In-Reply-To: <20230914151916.21044-1-alex.austin@amd.com>
To: Alex Austin <alex.austin@amd.com>
Cc: netdev@vger.kernel.org, linux-net-drivers@amd.com, ecree.xilinx@gmail.com,
 habetsm.xilinx@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 14 Sep 2023 16:19:16 +0100 you wrote:
> Follow the style used in the core kernel (e.g.
> include/linux/etherdevice.h and include/linux/in6.h) for the PTP IPv6
> and Ethernet addresses. No functional changes.
> 
> Signed-off-by: Alex Austin <alex.austin@amd.com>
> Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] sfc: make coding style of PTP addresses consistent with core
    https://git.kernel.org/netdev/net-next/c/487e1937b9c0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



