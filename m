Return-Path: <netdev+bounces-57713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE9C813F8A
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 03:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40E941C20A72
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 02:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7B3650;
	Fri, 15 Dec 2023 02:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LYG2xC5+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5D15382
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 02:01:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54C9BC433C9;
	Fri, 15 Dec 2023 02:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702605678;
	bh=Or/ZKP96HsPKi+i7G/pvUgsIB6RuzIH+Rn2FXg+BpKw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LYG2xC5+u3J2CS7PxrfUzqcVDyvb3tVu7Skg0F3dxnI9897xXbcNVPulA1pLdpMt4
	 uPng7nshaz5wl+g1CbmCN13a0u4r9XfC1+EqtbhoLp4pyHHH6ZcjcEVkh9H4vKVKpL
	 kd4kCjoMj2vVS6pb1MauJULWgvOZlYxHBWTUWsyVaz6Ak0mV+8I2bF6mdYSYPdeibV
	 t71YpFImjhIA2AJ46CE0ntDY/vc+z8zEps5xJFSQ4ktDOk+j033nO09vdA+EsrMNW1
	 v5duvaLJTujGAsq2q7FhI9Qhs0A1/WYKZjseup8blNNoeViCJSplZ7eXpdQWHr9mjF
	 7eH8FFQ6uy7zg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 37211DD4EF9;
	Fri, 15 Dec 2023 02:01:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/8] tools: ynl-gen: fill in the gaps in support of
 legacy families
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170260567822.29932.4186848634489676352.git-patchwork-notify@kernel.org>
Date: Fri, 15 Dec 2023 02:01:18 +0000
References: <20231213231432.2944749-1-kuba@kernel.org>
In-Reply-To: <20231213231432.2944749-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, nicolas.dichtel@6wind.com, jiri@resnulli.us,
 donald.hunter@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 13 Dec 2023 15:14:24 -0800 you wrote:
> Fill in the gaps in YNL C code gen so that we can generate user
> space code for all genetlink families for which we have specs.
> 
> The two major changes we need are support for fixed headers and
> support for recursive nests.
> 
> For fixed header support - place the struct for the fixed header
> directly in the request struct (and don't bother generating access
> helpers). The member of a fixed header can't be too complex, and
> also are by definition not optional so the user has to fill them in.
> The YNL core needs a bit of a tweak to understand that the attrs
> may now start at a fixed offset, which is not necessarily equal
> to sizeof(struct genlmsghdr).
> 
> [...]

Here is the summary with links:
  - [net-next,1/8] tools: ynl-gen: add missing request free helpers for dumps
    https://git.kernel.org/netdev/net-next/c/4dc27587dcba
  - [net-next,2/8] tools: ynl-gen: use enum user type for members and args
    https://git.kernel.org/netdev/net-next/c/139c163b5b0b
  - [net-next,3/8] tools: ynl-gen: support fixed headers in genetlink
    https://git.kernel.org/netdev/net-next/c/f6805072c2aa
  - [net-next,4/8] tools: ynl-gen: fill in implementations for TypeUnused
    https://git.kernel.org/netdev/net-next/c/f967a498fce8
  - [net-next,5/8] tools: ynl-gen: record information about recursive nests
    https://git.kernel.org/netdev/net-next/c/38329fcfb757
  - [net-next,6/8] tools: ynl-gen: re-sort ignoring recursive nests
    https://git.kernel.org/netdev/net-next/c/aa75783b95a1
  - [net-next,7/8] tools: ynl-gen: store recursive nests by a pointer
    https://git.kernel.org/netdev/net-next/c/461f25a2e433
  - [net-next,8/8] tools: ynl-gen: print prototypes for recursive stuff
    https://git.kernel.org/netdev/net-next/c/7b5fe80ebc63

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



