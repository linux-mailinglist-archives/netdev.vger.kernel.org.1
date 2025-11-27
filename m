Return-Path: <netdev+bounces-242112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C6549C8C6D3
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 01:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E6D864E5AF8
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 00:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE25E225A3B;
	Thu, 27 Nov 2025 00:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDaCXXn7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997F2225390
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 00:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764203446; cv=none; b=TpCepbfX7lwj4kbSM8yhXDQ5WCXgC0nOFuy3uqOKqgAMJ02wfRBOHAGPBBE4z1FerdVdRlo2hxFClYUGrEQcOgs7f6a9cVCiGqy/yrWU5+Z8yGiAmebcrZgh1+c92xMtqJj+0L9kIbYMRHbBwk7KPxpX43Rj+JPXWH5/aRcI2m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764203446; c=relaxed/simple;
	bh=FWlDWLN/GOvKln0+cgwxIbSneFEuh7/t32eEroEvHsE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AfUa3I8jdpZwaxJxZ77r9aIw51expMTSivIrVARvfYBj9gS+BBgT1tBvU0DkOUQ9bUXR+K5NenGag+JyY2sD9K8ZE1KQvzjAzyx8Aqx2mhwd3aHzJcZBiOEJ21s/PMM17Uwzpz/Y+PNEOsfpGHAclEZK/vyKMT1tWVFu//CKJDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDaCXXn7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D8EDC4CEF7;
	Thu, 27 Nov 2025 00:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764203446;
	bh=FWlDWLN/GOvKln0+cgwxIbSneFEuh7/t32eEroEvHsE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KDaCXXn7MofxhlXEuRUmlVkiLRk89rbWUa4IBBMh6JEuksgbUH8U6WI76P6XcSaxs
	 LCCoLYqe0/DtCn4nmvLY03bp2bDD2tpTbhWyMH3n1kbAdcyhiWsmHYX/gPGe7QtRff
	 VsnWYv9WVCaea1s2O+5Ba15pieIvHjzX8g+3rCuUIRnO8W7saQKH3784v8E5MIKqAC
	 feSYI+x14gNqsPwPiO+/h4HwXpx/mtEhzM/5OSOMv58elcuKcIaDSa3OOe+eANB21z
	 XV9y0pfeMDt8zW6E9DmjzIPOeHNrbBX1RMfDYKnAoh2rEXpqQ0fp99H/d1gA93RC+0
	 mo4X3qYesrUfg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1F517380CEF6;
	Thu, 27 Nov 2025 00:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests/net: packetdrill: pass send_omit_free to
 MSG_ZEROCOPY tests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176420340799.1898314.5169503478990413263.git-patchwork-notify@kernel.org>
Date: Thu, 27 Nov 2025 00:30:07 +0000
References: <20251125234029.1320984-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20251125234029.1320984-1-willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, willemb@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 25 Nov 2025 18:35:05 -0500 you wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> The --send_omit_free flag is needed for TCP zero copy tests, to ensure
> that packetdrill doesn't free the send() buffer after the send() call.
> 
> Fixes: 1e42f73fd3c2 ("selftests/net: packetdrill: import tcp/zerocopy")
> Closes: https://lore.kernel.org/netdev/20251124071831.4cbbf412@kernel.org/
> Suggested-by: Neal Cardwell <ncardwell@google.com>
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> 
> [...]

Here is the summary with links:
  - [net] selftests/net: packetdrill: pass send_omit_free to MSG_ZEROCOPY tests
    https://git.kernel.org/netdev/net-next/c/c01a6e5b2e4f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



