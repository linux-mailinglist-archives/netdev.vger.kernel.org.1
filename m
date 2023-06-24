Return-Path: <netdev+bounces-13766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7886373CD55
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 00:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32D7C281116
	for <lists+netdev@lfdr.de>; Sat, 24 Jun 2023 22:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03991882F;
	Sat, 24 Jun 2023 22:50:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D064111B2
	for <netdev@vger.kernel.org>; Sat, 24 Jun 2023 22:50:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4BD81C433C9;
	Sat, 24 Jun 2023 22:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687647027;
	bh=KD4wDIQ24m6dNWYR3CdhY9AN3XPQHqZmGTFqVEZE+io=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bQj8s4DOxK6XAfXSK+LAYAxv0Q9aUFYLsbERxccL9GThr+RdrVCuOZpE8kS0M7Hwz
	 6fqsyj8UQK9dZYufY8eBQrI+fbun6aDalT+Boz5KyPRi9feEllADG+uPtRbRauYojB
	 3kJjXDDApse0RFA4jgLCa7RciwzmUAwjGFyiDiw1vM1zttOkqL/6DYHKR725UD8gi3
	 bUmPoDuzt+2ZD6o+/Q/YMAdHc+ji1ppqfWeudvtDPuhFragWcISJCIdeSg011K5YfX
	 9BarJW1oUpIUYOZiYC8vn6ZYSjJ5Ke9zGxsYqgF7lLM74wWm8MSnBHUt4rml7utn+Z
	 hfDHNY9cFH0jg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 38432E26D3E;
	Sat, 24 Jun 2023 22:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1 0/3] netlink: add display-hint to ynl
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168764702722.4822.17812728555437534756.git-patchwork-notify@kernel.org>
Date: Sat, 24 Jun 2023 22:50:27 +0000
References: <20230623201928.14275-1-donald.hunter@gmail.com>
In-Reply-To: <20230623201928.14275-1-donald.hunter@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, donald.hunter@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 23 Jun 2023 21:19:25 +0100 you wrote:
> Add a display-hint property to the netlink schema, to be used by generic
> netlink clients as hints about how to display attribute values.
> 
> A display-hint on an attribute definition is intended for letting a
> client such as ynl know that, for example, a u32 should be rendered as
> an ipv4 address. The display-hint enumeration includes a small number of
> networking domain-specific value types.
> 
> [...]

Here is the summary with links:
  - [net-next,v1,1/3] netlink: specs: add display-hint to schema definitions
    https://git.kernel.org/netdev/net-next/c/737eab775d36
  - [net-next,v1,2/3] tools: ynl: add display-hint support to ynl
    https://git.kernel.org/netdev/net-next/c/d8eea68d913c
  - [net-next,v1,3/3] netlink: specs: add display hints to ovs_flow
    https://git.kernel.org/netdev/net-next/c/334f39ce17ef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



