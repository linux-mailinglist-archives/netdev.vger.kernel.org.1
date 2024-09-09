Return-Path: <netdev+bounces-126573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE40A971E0E
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 17:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 056241C2250F
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 15:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A2038FAD;
	Mon,  9 Sep 2024 15:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="em/zf3BP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D980FBA4B
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 15:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725895830; cv=none; b=WUJfb2MZtP6sLzgNpH83gUusHXYyH/xwBk+ras2yrDjF7WoJkGXnNcehslFdOuNkya2JEIc0DMO3t/TQMzmDCl/FOax9RO/7pQ7mJeTzoKpJe1mLYWKMQViJM2Oo9/M2KMeWtifhdm1auMtDMCEqBcE6ZfATFKFW8+yefTBMxZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725895830; c=relaxed/simple;
	bh=RmgLoZQxNL+Vxno5nIFdn5JsIif2jovIPYyRPf6xvic=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=i4EG79+Uu6XgZn7ZP6lWMwGC3qu+EX79pdTiOZI9kGjT0vYEHN1EvBDFpk/kBB3AdvjmZLN9yDfovvc3uZZPeCiaUubIyz4JXOLeZ1b2s2ubiBcBuUZdRXq1uph8dQlZJCxDy7HO5uZBLz02c6Sov7QbV1EiFFCSXlvkHWplX68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=em/zf3BP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A998C4CEC5;
	Mon,  9 Sep 2024 15:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725895830;
	bh=RmgLoZQxNL+Vxno5nIFdn5JsIif2jovIPYyRPf6xvic=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=em/zf3BPEqdI3GkilY3iPf30oPYGpe5rN1c36BX7cQs1Wv+zt0O+rQwZRdLA0Rjtn
	 mZ7Zyy+81xWtjSeCT0iwbv0AHkyQkXsg+XIhugWlmuTrq0R+xKkAS2QsWGOEwDw1z8
	 Di/q1ljPs17hT+bFpBbIMC7yo1AJY1zbM/1/1ukCx6D3kM6aEyG8TV3B2n9REyott5
	 wSv68VUlZBJHQF5sIyM0wmO+bwkPUHqEQkFF1jItKplcuKyluPq77CEOQhW9fJsmzY
	 m+aVuYRLp/YW3sZcMy+DHsELQUqAzNYFWjK2Yre7pkDWo09Xe4ttUvWrckVVCRd2iu
	 a26oD+oD/vI2w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE6FE3806654;
	Mon,  9 Sep 2024 15:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next v3 0/2] add support for tunsrc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172589583151.3832797.10774348319849809281.git-patchwork-notify@kernel.org>
Date: Mon, 09 Sep 2024 15:30:31 +0000
References: <20240829091524.8466-1-justin.iurman@uliege.be>
In-Reply-To: <20240829091524.8466-1-justin.iurman@uliege.be>
To: Justin Iurman <justin.iurman@uliege.be>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, stephen@networkplumber.org

Hello:

This series was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Thu, 29 Aug 2024 11:15:22 +0200 you wrote:
> v3:
> - s/print_string/print_color_string/g for INET6 (thanks Stephen!)
> v2:
> - removed uapi patch (@David please pull from net-next, thanks)
> 
> This series provides support for the new ioam6 feature called
> "tunsrc".
> 
> [...]

Here is the summary with links:
  - [iproute2-next,v3,1/2] ip: lwtunnel: tunsrc support
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=42ba9a6fb8b2
  - [iproute2-next,v3,2/2] man8: ip-route: update documentation
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=9dafac4fdd3d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



