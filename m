Return-Path: <netdev+bounces-175683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C8FA671CA
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 11:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 106B11894661
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 10:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CB620896A;
	Tue, 18 Mar 2025 10:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDmQOXPc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3873207677
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 10:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742294998; cv=none; b=mMZOPplL3lzyPWEbV3Gj3G/9Lg0zJrXjgqodiA2bRWC+P98ka2LxNnt5dng1eft8WZIBYlmV8qGAPKO+1n9aI5wdYZOwUk0aBFwwjMkrU+KYnmx4MzJqAJuLqGYPaamFDothD6C6Vx+t+T9/WMf2n2aM+T6qR2PUOIICSkhShHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742294998; c=relaxed/simple;
	bh=eoFT/RxPdBJnB9wwVIH55JmyNKRGwUae8xxMOd4nTU8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ku9TAdeb+C4eXHGVsq4xLaK1NcFEPe/FVIRElLc7KNoVrjVbRsgzOBa/X5GVHg3m47XF0hEqbUmAnAcqgaV9jHoz+FJSljXpt7HOB3NZjuKgpZWvC41dArC9m4OfJuK+LxXClaZWd/rY+zIy+0oRdj6dB5ZPjit7bJWcqlHk14g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDmQOXPc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C766C4CEE3;
	Tue, 18 Mar 2025 10:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742294997;
	bh=eoFT/RxPdBJnB9wwVIH55JmyNKRGwUae8xxMOd4nTU8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FDmQOXPcPsJNr36bzTfRIkuvWmGDepPOLaPT5p2xjP1OfA6WNqVo/X7O7bpDecopp
	 ryX/1+Qgcav2i9BzFzheGwwTVijZVOXpORKqI4wVVVORYLl0urnhK8ZUjVpM15Tf37
	 5BYVcWPu2S8K39yHEzUGzW98blA0kMSXSbWKrV1kFJpT+gaxWqCW86QQGI79rNDhen
	 fzpSjwhUFXrIw2B0LCs5kFFG/rLOdyDQZZDaaNUKokDsflh0ju+E6TW0gXDGQrkWeX
	 AQ4wDq4YAzOqn6nSeyg+VAyXTSXb3x4h8PhFCsE7btuD2ZfvEANonYlMDA6K+Y7IxN
	 pUFhgNKR7gOHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF3E380DBE8;
	Tue, 18 Mar 2025 10:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 net-next 0/2] udp_tunnel: GRO optimizations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174229503276.4125034.9280386198001897544.git-patchwork-notify@kernel.org>
Date: Tue, 18 Mar 2025 10:50:32 +0000
References: <cover.1741718157.git.pabeni@redhat.com>
In-Reply-To: <cover.1741718157.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, horms@kernel.org,
 dsahern@kernel.org, kuniyu@amazon.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 11 Mar 2025 21:42:27 +0100 you wrote:
> The UDP tunnel GRO stage is source of measurable overhead for workload
> based on UDP-encapsulated traffic: each incoming packets requires a full
> UDP socket lookup and an indirect call.
> 
> In the most common setups a single UDP tunnel device is used. In such
> case we can optimize both the lookup and the indirect call.
> 
> [...]

Here is the summary with links:
  - [v4,net-next,1/2] udp_tunnel: create a fastpath GRO lookup.
    https://git.kernel.org/netdev/net-next/c/8d4880db3783
  - [v4,net-next,2/2] udp_tunnel: use static call for GRO hooks when possible
    https://git.kernel.org/netdev/net-next/c/311b36574cea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



