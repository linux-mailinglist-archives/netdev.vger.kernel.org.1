Return-Path: <netdev+bounces-204931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B573CAFC918
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 13:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 801621AA08BC
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 11:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1222D8768;
	Tue,  8 Jul 2025 11:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="trzAjsWU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875D22D8764
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 11:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751972402; cv=none; b=f6Q89lCSUmYLRhl3Aun9INT/5/iKk1yT3FMoYojp6nVdo2eNld3/dprjhKw7QTfyEfgUYaBBxMLhuCrAWmFxiD9iE/RuI01nARk8H7xyzPdfRf5J+rcM2HCYNNBFXM+Oj0wyg3K1W/2+KpXzrwXujfRNjmpy+TjDSVoZheDaKKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751972402; c=relaxed/simple;
	bh=mVwSeLq8a1VGYPuJQZcrCJEYz09VXxFZ6ICwhYGF/G0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SLT99E9ITtsYcHA4n9UzlIPHk9jPKCCEmOGC+2T+wUCvv/ApJra0M1MyQNLOrxc5Ec9RdwAn0TFnK2ybpoc/XXHaRZY2junB53qw/1OnPB3DrtZm/M6JJrzd3m8Rky0Gy0hsgKgK8fM+ktaWNycgmp7DBwwxekdWd9uo5FJCHpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=trzAjsWU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53204C4CEED;
	Tue,  8 Jul 2025 11:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751972402;
	bh=mVwSeLq8a1VGYPuJQZcrCJEYz09VXxFZ6ICwhYGF/G0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=trzAjsWUa8HWvakg6pr2L1EpQdn6N6hY4GjNTAFCERjGaZOPjETCs5hqIOZV0e8rs
	 wrb2C1gAYbVhDSfg7nSfnZNYic9vRFidr6qHdOucly4HvEbRsZ0y5ZGf4YVq56V62/
	 8OC0gPN/3TONjRBQf08Dld+rSXrVIqbKAG+bB5yLN/Jrt4KbGelOATdoU5mgAGt5K0
	 MLHoAUGhehbwA4qbOyarQ0Sk75XCSi4XsZPLKWiGh/W+ohY1jKY125//LAGAmXoeKt
	 gyti2F5BeSN0GFvQ6nKCRPqThWE/1wAnQ3tlc6uVoGYM+r7b2+72xLJlJ5pcjQ8c+A
	 p9rs5mtxrOa1Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710F5380DBEE;
	Tue,  8 Jul 2025 11:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 00/14] net: mctp: Add support for gateway
 routing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175197242527.4024640.15516341824210236859.git-patchwork-notify@kernel.org>
Date: Tue, 08 Jul 2025 11:00:25 +0000
References: <20250702-dev-forwarding-v5-0-1468191da8a4@codeconstruct.com.au>
In-Reply-To: <20250702-dev-forwarding-v5-0-1468191da8a4@codeconstruct.com.au>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: matt@codeconstruct.com.au, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 02 Jul 2025 14:20:00 +0800 you wrote:
> This series adds a gateway route type for the MCTP core, allowing
> non-local EIDs as the match for a route.
> 
> Example setup using the mctp tools:
> 
>     mctp route add 9 via mctpi2c0
>     mctp neigh add 9 dev mctpi2c0 lladdr 0x1d
>     mctp route add 10 gw 9
> 
> [...]

Here is the summary with links:
  - [net-next,v5,01/14] net: mctp: don't use source cb data when forwarding, ensure pkt_type is set
    https://git.kernel.org/netdev/net-next/c/e0f3c79cc0bb
  - [net-next,v5,02/14] net: mctp: test: make cloned_frag buffers more appropriately-sized
    https://git.kernel.org/netdev/net-next/c/fc2b87d036e2
  - [net-next,v5,03/14] net: mctp: separate routing database from routing operations
    https://git.kernel.org/netdev/net-next/c/269936db5eb3
  - [net-next,v5,04/14] net: mctp: separate cb from direct-addressing routing
    https://git.kernel.org/netdev/net-next/c/3007f90ec038
  - [net-next,v5,05/14] net: mctp: test: Add an addressed device constructor
    https://git.kernel.org/netdev/net-next/c/96b341a8e782
  - [net-next,v5,06/14] net: mctp: test: Add extaddr routing output test
    https://git.kernel.org/netdev/net-next/c/46ee16462fed
  - [net-next,v5,07/14] net: mctp: test: move functions into utils.[ch]
    https://git.kernel.org/netdev/net-next/c/80bcf05e54e0
  - [net-next,v5,08/14] net: mctp: test: add sock test infrastructure
    https://git.kernel.org/netdev/net-next/c/19396179a0f1
  - [net-next,v5,09/14] net: mctp: test: Add initial socket tests
    https://git.kernel.org/netdev/net-next/c/9b4a8c38f4fe
  - [net-next,v5,10/14] net: mctp: pass net into route creation
    https://git.kernel.org/netdev/net-next/c/48e6aa60bf28
  - [net-next,v5,11/14] net: mctp: remove routes by netid, not by device
    https://git.kernel.org/netdev/net-next/c/4a1de053d7f0
  - [net-next,v5,12/14] net: mctp: allow NL parsing directly into a struct mctp_route
    https://git.kernel.org/netdev/net-next/c/28ddbb2abe13
  - [net-next,v5,13/14] net: mctp: add gateway routing support
    https://git.kernel.org/netdev/net-next/c/ad39c12fcee3
  - [net-next,v5,14/14] net: mctp: test: Add tests for gateway routes
    https://git.kernel.org/netdev/net-next/c/48e1736e5dc1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



