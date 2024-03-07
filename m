Return-Path: <netdev+bounces-78244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C116874782
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 06:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B95271F229F5
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 05:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C2217727;
	Thu,  7 Mar 2024 05:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IY+UpOoW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F6011184
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 05:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709787630; cv=none; b=kn1VLq/MjU+i2vByaTmj0kqALmX+TttDDggWDiBA157yG3ciPsKFVUDr2ULR04VOob41TIjS9RYhkuUEh9iwrWPUwToy2hfsWkQAbnOfOcogj6Izds4G9CsIZeH7V+kLYUzWCwyA1Zgl8JdeHtH+zOzs7kRLLF5vJPFIcWGeojM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709787630; c=relaxed/simple;
	bh=ZE0p7FBnZiLCAnQwogO96PG7w7/Z1IT7vEIWOrTqGiE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GooMNSha/ADIY5gMDulnYTuLI94KhxW869T2jbnmeKZTDssmq8/L+w6wCyYSfyZhYw1vmrmPMz/rQY6WHeZkBFZwxlD1escwa53eG8tB9PGwY0itSST1rWUrloIJ9PpUJv+ZGVZqGUKACOBQBBwKpxE8mhJdcCLrHzXt8HHrlpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IY+UpOoW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 22955C43390;
	Thu,  7 Mar 2024 05:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709787630;
	bh=ZE0p7FBnZiLCAnQwogO96PG7w7/Z1IT7vEIWOrTqGiE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IY+UpOoWpCn539R8lRIKYffLRfTp2z0XzsY/foNwhFTOVKIkDlbbJO1I83kN3rk8q
	 weq9tjYXwZp81oRcuyRYdGOARoleGnzHXxRLTCbUWQWp7hFudvwVgSxuPHRkSaPf+S
	 6qw3vO6nMIXJSCtytc3CFvuJV+fDp+CQKFQGQclNlCIc29AeV7RfR1S1wdrwORAS81
	 i2K6jVIfscMwIqXQWV4jTrT1bQg2iHVCgPegLsOEIYH78YOzed56k4XcgChfPr0K/D
	 EPn2TbMzQIcb0nomaMd6XAPSidj707nRaO425IN8naqxoTKnjGsuonjMGxjy24SaKA
	 7oHHTk3cq+M3Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 092F8D9A4BB;
	Thu,  7 Mar 2024 05:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/5] xfrm: Clear low order bits of ->flowi4_tos in
 decode_session4().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170978763003.17068.5231393966523715465.git-patchwork-notify@kernel.org>
Date: Thu, 07 Mar 2024 05:00:30 +0000
References: <20240306100438.3953516-2-steffen.klassert@secunet.com>
In-Reply-To: <20240306100438.3953516-2-steffen.klassert@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: davem@davemloft.net, kuba@kernel.org, herbert@gondor.apana.org.au,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Steffen Klassert <steffen.klassert@secunet.com>:

On Wed, 6 Mar 2024 11:04:34 +0100 you wrote:
> From: Guillaume Nault <gnault@redhat.com>
> 
> Commit 23e7b1bfed61 ("xfrm: Don't accidentally set RTO_ONLINK in
> decode_session4()") fixed a problem where decode_session4() could
> erroneously set the RTO_ONLINK flag for IPv4 route lookups. This
> problem was reintroduced when decode_session4() was modified to
> use the flow dissector.
> 
> [...]

Here is the summary with links:
  - [1/5] xfrm: Clear low order bits of ->flowi4_tos in decode_session4().
    https://git.kernel.org/netdev/net/c/1982a2a02c91
  - [2/5] xfrm: Pass UDP encapsulation in TX packet offload
    https://git.kernel.org/netdev/net/c/983a73da1f99
  - [3/5] xfrm: Avoid clang fortify warning in copy_to_user_tmpl()
    https://git.kernel.org/netdev/net/c/1a807e46aa93
  - [4/5] xfrm: fix xfrm child route lookup for packet offload
    https://git.kernel.org/netdev/net/c/d4872d70fc6f
  - [5/5] xfrm: set skb control buffer based on packet offload as well
    https://git.kernel.org/netdev/net/c/8688ab2170a5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



