Return-Path: <netdev+bounces-96172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA728C4902
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 23:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1263A1C20CC4
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 21:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8F583CDF;
	Mon, 13 May 2024 21:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AhTdwtnb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5980183CD6
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 21:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715637031; cv=none; b=FKWOFHxExg7u2jk3kKp+rITUFGicRWPD9uWs+gPo2dwaEHNMtDtn5oLt05W5wpkpMOh3F3mQ4J8VVlVrQFWCHa8ZB1amsIDk3muOd3uW7q6L06seZ3dydpKHu39vYou4pn16qkUg3VQ3jShB8zVY3+ZKJHsVjFWqMn9r3FKrzRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715637031; c=relaxed/simple;
	bh=bMz/BblnLCSGKHotBSH6hZUgHsL3QZ8SXt+KXFMtCcg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Tn65EioI5fa555mMb77zpz8Lq0aFq7wv8TPMeB0sc1xh6doCMEJanwT8Shgpy98/1740rO0TfRksLWcDVGEcgbZbIk1jIvpuRjmHMjSzb4kb/InwC+JAY6wyFs1QwMYab3e2Quk9JyY2wY+RCMlBa0XfnxFPMlHS//ym8fH/V1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AhTdwtnb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC89DC32786;
	Mon, 13 May 2024 21:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715637030;
	bh=bMz/BblnLCSGKHotBSH6hZUgHsL3QZ8SXt+KXFMtCcg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AhTdwtnbYtaWiAbSPp7k9Ezkbr5l1gpDaQ8FM5KJgFRfX7IDnHBj79fJM6Ceh5MJo
	 n0MRn+QHHBL7drsyYyAqFtFpf11rqKm8vJMYZE4XpSgP9+DHMF7PqCL6pKNVGU7rCU
	 1DAkP+KyfopYShRQdheVCZojrMDirGBW9lS68bzQ2XNmC0BcHrtPu51KNe2R7vtT3X
	 s3uLu58gcLBBsdoK0vZNjKlR33N/sMBcUaCBlUrdRd9yUO1MNqecEUv7kkF0HUqeIb
	 QKZA1UjLrvrcG63A5Z0kBCnwmd74v42ZasVc7RqMHt6xfDfSxh+rJKE/mCYgFFSXNT
	 D/veE/gKmf+ug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B16D8C43445;
	Mon, 13 May 2024 21:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/5] ENA driver changes May 2024
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171563703072.25518.432149157131052401.git-patchwork-notify@kernel.org>
Date: Mon, 13 May 2024 21:50:30 +0000
References: <20240512134637.25299-1-darinzon@amazon.com>
In-Reply-To: <20240512134637.25299-1-darinzon@amazon.com>
To: Arinzon@codeaurora.org, David <darinzon@amazon.com>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 edumazet@google.com, pabeni@redhat.com, dwmw@amazon.com, zorik@amazon.com,
 matua@amazon.com, saeedb@amazon.com, msw@amazon.com, aliguori@amazon.com,
 nafea@amazon.com, netanel@amazon.com, alisaidi@amazon.com, benh@amazon.com,
 akiyano@amazon.com, ndagan@amazon.com, shayagr@amazon.com, itzko@amazon.com,
 osamaabb@amazon.com, evostrov@amazon.com, ofirt@amazon.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 12 May 2024 13:46:32 +0000 you wrote:
> From: David Arinzon <darinzon@amazon.com>
> 
> This patchset contains several misc and minor
> changes to the ENA driver.
> 
> Changes from v1:
> - Removed interrupt moderation hint from the
>   patchset. The change is moved back to
>   development state and will be released as
>   part of a different patchset in the future.
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/5] net: ena: Add a counter for driver's reset failures
    https://git.kernel.org/netdev/net-next/c/62a261f6c1dd
  - [v2,net-next,2/5] net: ena: Reduce holes in ena_com structures
    https://git.kernel.org/netdev/net-next/c/48673ef44431
  - [v2,net-next,3/5] net: ena: Add validation for completion descriptors consistency
    https://git.kernel.org/netdev/net-next/c/b37b98a3a0c1
  - [v2,net-next,4/5] net: ena: Changes around strscpy calls
    https://git.kernel.org/netdev/net-next/c/97776caf6c6e
  - [v2,net-next,5/5] net: ena: Change initial rx_usec interval
    https://git.kernel.org/netdev/net-next/c/1cc0a47daa7a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



