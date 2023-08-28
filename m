Return-Path: <netdev+bounces-31015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDE778A8F4
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 11:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E5C91C208BA
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 09:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBF36AAD;
	Mon, 28 Aug 2023 09:30:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B02C6120
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 09:30:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BC247C43397;
	Mon, 28 Aug 2023 09:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693215029;
	bh=1mUVSkZPKH7u8z26qi6cFxdQdL21UFNogMKF4apJdsA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YDcLysjNQA66+ciLltaQjRCHJWUTFEJyZSb/pLxYsSN1a5deq0XX8qPWRIJxSa5Q0
	 Li2wBkDZgYYpmYafyQq0nSQ7uhtR2Ga3jK0SqjAaqs4J138k+Ws/gSrKGktZldBs57
	 C2WXATCDB44uDitYHmEakkz9MrjPcTfYZ2kWTagpjvUXwNKIqOS4Y/jNj7s5kiR5gG
	 YeQfy8ZgzAfCW0sKh3PAhxk2GB2dmFoSEMYV5IA1UdnGe7bhzgENXXGY0JJGsmCkp0
	 RMa9hDH67BHihWpBG1/PZqD12K8hP4uqFlvkVG1tbEfm2oSMyQtw9l+Z7/VuMK2jUk
	 k1/OMZG7P9z9w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A9E8BE21EDF;
	Mon, 28 Aug 2023 09:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] r8169: fix ASPM-related issues on a number of systems
 with NIC version from RTL8168h
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169321502969.13199.14532680995855021279.git-patchwork-notify@kernel.org>
Date: Mon, 28 Aug 2023 09:30:29 +0000
References: <d198a4d6-0c91-7870-9648-5a087fe634aa@gmail.com>
In-Reply-To: <d198a4d6-0c91-7870-9648-5a087fe634aa@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: kuba@kernel.org, davem@davemloft.net, nic_swsd@realtek.com,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 25 Aug 2023 21:44:01 +0200 you wrote:
> This effectively reverts 4b5f82f6aaef. On a number of systems ASPM L1
> causes tx timeouts with RTL8168h, see referenced bug report.
> 
> Fixes: 4b5f82f6aaef ("r8169: enable ASPM L1/L1.1 from RTL8168h")
> Cc: stable@vger.kernel.org
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217814
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net] r8169: fix ASPM-related issues on a number of systems with NIC version from RTL8168h
    https://git.kernel.org/netdev/net/c/90ca51e8c654

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



