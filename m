Return-Path: <netdev+bounces-222643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C925EB553D9
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 17:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75AFB3A72CB
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 15:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DC53148B8;
	Fri, 12 Sep 2025 15:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFOJfdtC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D7F313E27
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 15:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757691607; cv=none; b=ouUKgAfrHli/hh2cG5FErMeH0iFannaZvKRbmu+0H+ChUEQGFdAjfTyBmjDHMg3rA3qTlt96Wmx04ATd44Jj9RORcrfSmDB4RMgLYXR0KbynaElC4wxPqDzJjDBgKV695Q0joJK2ZNOTEbR9+KQPtkJKW1I0u4DCxdcUGbrewT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757691607; c=relaxed/simple;
	bh=UCyqAwz7O7Vx0g93K7ZzX6CJkFIRqeK0+CjXfpbpIqE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ky85ctynb6YlI0xJRvaLZxFzGrbCesTP84wKcx+SojyRnKGJwLFeATWsTStP9dTvD1q4jggUZgqd/87Cvkf605NHpkIFZM8gm0R+zy/OXMGcjd3exPjaQ1pitd0uRncVZMURTNzugKLYcUTrCfl3u+VkiVOcBuLfWI0PELBJ8sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFOJfdtC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 945C5C4CEF1;
	Fri, 12 Sep 2025 15:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757691606;
	bh=UCyqAwz7O7Vx0g93K7ZzX6CJkFIRqeK0+CjXfpbpIqE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lFOJfdtCWcI6XKW+TLgJqlRXI+9pnFQZI7SwwtjkEkhIPUADQ6gmOULk4Jc1HRWaa
	 UsKyNbVN6pdpRnFTNXYBTOqE8ugNXGH3Wh5bb0he5I/SM2lpzxYu6ckbC+vIq+HO5z
	 wiAY3Ie5aLVsJ0lSOvxvoSk57nTnbElz2rg5nW9fNaGocsWy4LzPqSE9e2rWfTcliP
	 36EvXQdBOE/6+ySg4CONdxTQe2AqCJajk1n2ONxYNcqczR2Ts59+TuLODxTvt547r4
	 V1+LZ4qq3UsGpsaQ93CfuyP2cuuFlauEE9iQDZE7UHIJHyS2ag60jjpFjsx6V7UEN+
	 8VRCoKJsKSm0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C07383BF4E;
	Fri, 12 Sep 2025 15:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-main] Add tc entry to MAINTAINERS file
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175769160898.2988995.3916802935594953013.git-patchwork-notify@kernel.org>
Date: Fri, 12 Sep 2025 15:40:08 +0000
References: <20250911204956.2252-1-dsahern@kernel.org>
In-Reply-To: <20250911204956.2252-1-dsahern@kernel.org>
To: David Ahern <dsahern@kernel.org>
Cc: stephen@networkplumber.org, netdev@vger.kernel.org, jhs@mojatatu.com

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Thu, 11 Sep 2025 14:49:56 -0600 you wrote:
> Add Jamal as a maintainer of tc files.
> 
> Signed-off-by: David Ahern <dsahern@kernel.org>
> ---
>  MAINTAINERS | 4 ++++
>  1 file changed, 4 insertions(+)

Here is the summary with links:
  - [iproute2-main] Add tc entry to MAINTAINERS file
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=bd63ac4980f3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



