Return-Path: <netdev+bounces-167551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10351A3AC9E
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 00:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11E3818897F0
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 23:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24A61DDA2D;
	Tue, 18 Feb 2025 23:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PI5kP+JQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D41E1CEAC3
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 23:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739922002; cv=none; b=dyptHze+V5dzPq+VUliaZitZa4C9cQ5kdHXOWH6XbX19TODMEfpaHgib1UxvJiXNDRGGPf9E0ShgCBi01jT1NA0Ks5+MByzSJenq5GDKw9N7h4fwcLf32pKiAnBUdnu1mQ6YQVNTDvalyuJKqcEV4FPIgJdxBI6ROpCAYcA7lxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739922002; c=relaxed/simple;
	bh=fyl0+Ypds+UM/TE8oRGskVHmoIZpP1nG0XuIrmJHvX8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XvkOG0cP524zy8a7zV4CHmAomsLjJSMf9fFyWFkrF7/041hiZ83mdGxn2rL4az8ZTOs5RAM7MYRGYP6zG9hEtxPgJXpPWFBEahXwEQxUJmU9+LliMc2ywpOd4GQQnseFUpQCDbgH7ytsTWwHsMYmCqnOfyIxOE5AGUN3x0y9eRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PI5kP+JQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BBB6C4CEE2;
	Tue, 18 Feb 2025 23:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739922002;
	bh=fyl0+Ypds+UM/TE8oRGskVHmoIZpP1nG0XuIrmJHvX8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PI5kP+JQCwZDH8cS/NkbKzY92N7AWIL7Rt6KcdLD2t5CK79HjzXcrZ+POsxTsvtim
	 gFahjNFMVMh44l8S7s7qYLwS+NEkvQlu8pDQQUlmLnYYcP8Wt70wb/d5j71hb8OZdH
	 2kX6hx92OQF2otMN1pelyN70bTaZdd3f1g7vChzIYL7d5GE2fqCBjhOIxAfPF+xCbD
	 MkB3pINSLzV9LOK+CtrGcfSS4sgugLfqY2yqVL6fa8HnciJJ7MqPYrjx5lt4Yuth/u
	 cg65bYl51SZjZILUuTtj/NU4FCRtAm+s3nMva+ZkVHlmwVuuNPlQ8EKXqo21dMRbYb
	 FChi3QGTBBB2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE20A380AAE9;
	Tue, 18 Feb 2025 23:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/4] eth: mlx4: use the page pool for Rx buffers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173992203251.66396.7782136856830583801.git-patchwork-notify@kernel.org>
Date: Tue, 18 Feb 2025 23:40:32 +0000
References: <20250213010635.1354034-1-kuba@kernel.org>
In-Reply-To: <20250213010635.1354034-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, tariqt@nvidia.com, idosch@idosch.org,
 hawk@kernel.org, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 12 Feb 2025 17:06:31 -0800 you wrote:
> Convert mlx4 to page pool. I've been sitting on these patches for
> over a year, and Jonathan Lemon had a similar series years before.
> We never deployed it or sent upstream because it didn't really show
> much perf win under normal load (admittedly I think the real testing
> was done before Ilias's work on recycling).
> 
> During the v6.9 kernel rollout Meta's CDN team noticed that machines
> with CX3 Pro (mlx4) are prone to overloads (double digit % of CPU time
> spent mapping buffers in the IOMMU). The problem does not occur with
> modern NICs, so I dusted off this series and reportedly it still works.
> And it makes the problem go away, no overloads, perf back in line with
> older kernels. Something must have changed in IOMMU code, I guess.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/4] eth: mlx4: create a page pool for Rx
    (no matching commit)
  - [net-next,v3,2/4] eth: mlx4: don't try to complete XDP frames in netpoll
    https://git.kernel.org/netdev/net-next/c/8fdeafd66eda
  - [net-next,v3,3/4] eth: mlx4: remove the local XDP fast-recycling ring
    (no matching commit)
  - [net-next,v3,4/4] eth: mlx4: use the page pool for Rx buffers
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



