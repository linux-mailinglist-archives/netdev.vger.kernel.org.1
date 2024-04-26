Return-Path: <netdev+bounces-91682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E57EF8B36D1
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 14:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CB251F22D39
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 12:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CB2145B30;
	Fri, 26 Apr 2024 12:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGeMctLP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFAC14533D
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 12:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714132828; cv=none; b=E3IdeXJLDl0XFzZuk7qjrD/4MKZqDZAz0gKsyHK9mhos+WH7HEY0mVWI6a5PUwq2Bo4dyF5A1snposHn81SWr2kvfObtENxZpe3eUsedTR46NMB1qQItwYohhPs4twfZ/tn92QOOcWUAZul9RZTp3LWCUAkqbGNIPBUa6Guf0hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714132828; c=relaxed/simple;
	bh=ne70PURqEiaa9Hl/ixIpJdJPYbLfkCSt7HhjAd4DQoE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dgVqJTJSYX0foOQSbnTK0M62kaaH6Ggvf6mgOOV+FU/ailGEEPLhDBp3sH/vTHhl6b8nsUtj8DF7W/kLE5qnFGNJcjy/0uIBs9ArG8Pzn9tcREdzmcXXbMNn0x9U4Tf7MTo3hvdyerjAEEMwvij+P8u+4KQc0gTJHb7IWG9UOPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGeMctLP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BEEB7C2BD11;
	Fri, 26 Apr 2024 12:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714132827;
	bh=ne70PURqEiaa9Hl/ixIpJdJPYbLfkCSt7HhjAd4DQoE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cGeMctLPqy/plKdJHDbE1TwmIf2Ci5BLL0aN5qm+s6SpMoaZRLE+Y0Fvl7R6sKQ/y
	 vhTN7qNCOm08ZM3f5k3EcJjXyIUuncaKqQaOLqU8xSQsVMzOrOJ/dh6wyh/iMp9z3h
	 41Fs6bVSNiYotDLpBNZdYIF6zCMksAPokXfP65m2RxDL4STYu2urr4AqNf4moQt1wm
	 K1ZGG4lM81EPbT4dxRBwa8GaixxDNQd2K/pc5ljFnt1cd0lnmwEHoCEJyqrG7KQqnu
	 c1fqyoVliClZBueM5GAOJ6rVg0QbS6IHj8bankPpX/GVPvwJ6/IUy3DsRNSkN5nXVl
	 plQHek/4ykmEQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AEE44C54BA8;
	Fri, 26 Apr 2024 12:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net l2tp: drop flow hash on forward
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171413282771.13774.5719089005903756841.git-patchwork-notify@kernel.org>
Date: Fri, 26 Apr 2024 12:00:27 +0000
References: <20240424171110.13701-1-mail@david-bauer.net>
In-Reply-To: <20240424171110.13701-1-mail@david-bauer.net>
To: David Bauer <mail@david-bauer.net>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, jchapman@katalix.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 24 Apr 2024 19:11:10 +0200 you wrote:
> Drop the flow-hash of the skb when forwarding to the L2TP netdev.
> 
> This avoids the L2TP qdisc from using the flow-hash from the outer
> packet, which is identical for every flow within the tunnel.
> 
> This does not affect every platform but is specific for the ethernet
> driver. It depends on the platform including L4 information in the
> flow-hash.
> 
> [...]

Here is the summary with links:
  - [net] net l2tp: drop flow hash on forward
    https://git.kernel.org/netdev/net/c/42f853b42899

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



