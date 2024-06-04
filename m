Return-Path: <netdev+bounces-100510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1798FAF42
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 11:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16C911C20BF1
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 09:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F4000144315;
	Tue,  4 Jun 2024 09:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IlClGBU4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D071213A415
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 09:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717494631; cv=none; b=CZnl1y10PGsd0uCrob1hxpT3jfyKatkOO/9kO/9ycsQu3WPE5A0E9lYxUIVUmFZqs9Nl/rd583v+NPN9lAYdJYmaAcbfnCY4YVS/v0XYDStDJdB1a1KbaQ0B9MrDmak7oE7EboVEIF4+i5Rdb5xpeU3nfBFRQF2zlF8Y7Fx+71o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717494631; c=relaxed/simple;
	bh=I+Gbb6iAW8497MNgN3CPR9129LIlEwzKgokU2EXE7QA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t2ticxAjESHKn1W5ldPKSvB0vtJ3olYCOCGbBodCW4XGmCXlBPe9j4KhxApnsMTpJrwoEgKRT5GLhukGUYFPlYeuPhV33n1o4wqaHfGoXXmJWkVa1fBz1Lkrnss2OWxmue0DBmIukJjNkdv5CMG9D9l7BqUYjILnkMMy9af8tGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IlClGBU4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4AECCC32782;
	Tue,  4 Jun 2024 09:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717494630;
	bh=I+Gbb6iAW8497MNgN3CPR9129LIlEwzKgokU2EXE7QA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IlClGBU4kFV9emLonij7UXxcU1U++++sEyMDVIc6xDsGCuJo3a7Iw5VWCacc2dJeG
	 vEJPcchrSj1nZTBDCo/bdl1mPIrEKDhbhvAyyDW9hr7OvfqDSELmQvkV2lHtS3E5/l
	 TnBAoJbP4Dip9Vra1jj+oDQUZZencs5rYskmWmPfeCO6uEizKIiRd/kO4W1AQuuZwA
	 9cpfDL9TwddgkRwN13noeDf5akywnIlUwhKTzHEyO5aS/BsTas9nDvp7Zn9xrPc6U6
	 QYjLx56T22amUWpKuLVVEcQ7HZHTgwy7AkEo4/yuzd6r5mzzf6MAJa+cTPVkASn5C2
	 /Ol4SKs6VSIvQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 35831DEFB90;
	Tue,  4 Jun 2024 09:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/2] net: allow dissecting/matching tunnel control
 flags
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171749463020.15457.3342638051928140051.git-patchwork-notify@kernel.org>
Date: Tue, 04 Jun 2024 09:50:30 +0000
References: <cover.1717088241.git.dcaratti@redhat.com>
In-Reply-To: <cover.1717088241.git.dcaratti@redhat.com>
To: Davide Caratti <dcaratti@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, i.maximets@ovn.org,
 jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, lucien.xin@gmail.com,
 marcelo.leitner@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com,
 xiyou.wangcong@gmail.com, echaudro@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 30 May 2024 19:08:33 +0200 you wrote:
> Ilya says: "for correct matching on decapsulated packets, we should match
> on not only tunnel id and headers, but also on tunnel configuration flags
> like TUNNEL_NO_CSUM and TUNNEL_DONT_FRAGMENT. This is done to distinguish
> similar tunnels with slightly different configs. And it is important since
> tunnel configuration is flow based, i.e. can be different for every packet,
> even though the main tunnel port is the same."
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/2] flow_dissector: add support for tunnel control flags
    https://git.kernel.org/netdev/net-next/c/668b6a2ef832
  - [net-next,v4,2/2] net/sched: cls_flower: add support for matching tunnel control flags
    https://git.kernel.org/netdev/net-next/c/1d17568e74de

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



