Return-Path: <netdev+bounces-195282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E17DCACF2D2
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 17:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 512467AAA47
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 15:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E991DDC1A;
	Thu,  5 Jun 2025 15:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JgA6t6sH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C7A1DDA32
	for <netdev@vger.kernel.org>; Thu,  5 Jun 2025 15:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749136217; cv=none; b=jBVUlztH9FOv44rS754Biwb+PYqiTUU8M3TFRu4sFXFJJUl2IpOEajHL43TREMrEZeUf0/I5EgXi8AvtWHaFEVvJsMF0oqAQPpfJ6nHT2Niez9MjSdhRzz1yTUTNXgeCk0sNDW55gKduvCeYezZKECjT8mcAxqbbpEkkACVof1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749136217; c=relaxed/simple;
	bh=j2da+68dr9luj6Bpkt6gO6xZi05z3aPGyFUj9tK4kgk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qaDaq9f9fGephnpQAuC91rm/ROfLShLw5Kh6PgIy0bAckDCtjOn7YLG3/GCMN/pZY13RXJ2kH2TEg1mPRZX5E7m0Veyb+z/JUpI+xkqv/4qyCpoow4sJW3L/N/12iRBFJSKbwetko2ldfHGU7fdDDvh1icAp7coOETw95w8mbi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JgA6t6sH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53086C4CEE7;
	Thu,  5 Jun 2025 15:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749136215;
	bh=j2da+68dr9luj6Bpkt6gO6xZi05z3aPGyFUj9tK4kgk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JgA6t6sHTL3U+9r2qaCjyxwhYfjHw89bpelcSgUa2TCPY/YR9I5wi891c4qnYQA8q
	 rZv5MJ04EfKRnm6hAloNxA55HJGTeERhDBGpBOFMSs3AOcA4WotRizT5oxFamZSE/f
	 Ev68tlzNMf1rGMYXpRFPFJGohg4/utK3r6TaArsWINbP76r/VptCObNa5Ay4YI84sw
	 jbk58jJ2NW/NqnyL0BZh3Pfm7yRerfLKKa5DMAN4QO5LxB08XAtu3/Fu8hHm3XqR8d
	 ++5khPBYwEPFctqLVGkc4HDSyxKX3LdVC1WBxONHwVODBcYUh3+BOrQDcIXWiWPWD/
	 pRqJCZJq8Dsyw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70ADE38111D8;
	Thu,  5 Jun 2025 15:10:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 1/1] wireguard: device: enable threaded NAPI
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174913624724.3108661.5339353104000181534.git-patchwork-notify@kernel.org>
Date: Thu, 05 Jun 2025 15:10:47 +0000
References: <20250605120616.2808744-1-Jason@zx2c4.com>
In-Reply-To: <20250605120616.2808744-1-Jason@zx2c4.com>
To: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: pabeni@redhat.com, netdev@vger.kernel.org, mirco.barone@polito.it

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  5 Jun 2025 14:06:16 +0200 you wrote:
> From: Mirco Barone <mirco.barone@polito.it>
> 
> Enable threaded NAPI by default for WireGuard devices in response to low
> performance behavior that we observed when multiple tunnels (and thus
> multiple wg devices) are deployed on a single host.  This affects any
> kind of multi-tunnel deployment, regardless of whether the tunnels share
> the same endpoints or not (i.e., a VPN concentrator type of gateway
> would also be affected).
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/1] wireguard: device: enable threaded NAPI
    https://git.kernel.org/netdev/net/c/db9ae3b6b43c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



