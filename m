Return-Path: <netdev+bounces-159599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C79BA15FE2
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 03:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DDFD165E29
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 02:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1E6179BC;
	Sun, 19 Jan 2025 02:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WuIvH7aE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3852E38385
	for <netdev@vger.kernel.org>; Sun, 19 Jan 2025 02:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737252011; cv=none; b=foSMhcmxCLrNOGXIiDG+IenjAaqOVgEkSxiq3MXjmYnhU9jtbHs2lnCwPQ5W1uxEBZfYa67wU0DsrDqFSDSfdZjRTsmREO5dXoyZGy6jqxaJoNHMPRzpe8aqHkmXHX6ihPsj3odb0cfNTmWI6r0iGkY+bAcEZY/QX0iPiYU1j9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737252011; c=relaxed/simple;
	bh=DjRTsBOhcA5XnZuYmwJnO3ZTDpN0ORte/+dZIcV34Pc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hlaFBwTH2B/IwGgwJdhxV7z073Rlkmhv6Nt3VQlzhOLAg+ff4cM83K6T3cLw6pFqWWk/S2TH1ytYAkfvPfSRIKuCpi9++X/lvqxArOAewc5hxKJW/e2bFJjIgp2hQtblZTNXbORVg1PHw6d7dlCs2i+l3bJ8hf3TJTVxc9zUJUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WuIvH7aE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91363C4CEDF;
	Sun, 19 Jan 2025 02:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737252009;
	bh=DjRTsBOhcA5XnZuYmwJnO3ZTDpN0ORte/+dZIcV34Pc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WuIvH7aEghgnDIXN7gmAkFkQYqif5MfuGUwd3Akixv+OUlnS5xam8WOwzi+I5Nkm0
	 87MDsCPR7Y3l1YGIRKQUGkvRqN+hVwzPWHSzpNkv/l/qFPA35FT/W4EaD1oiRICIV5
	 wjesp2Y9r7ZDgHt7DSwvG06b63q8avJbK1R3fFWBYWIc++YWRx7X4UQHDzVegckYOG
	 xZn0wtG0NHR2VvrJ9Z9Cp1XbNmFoNURfj/VAlr00mU4nqK88p7KOT+eJE7mB6Kju6j
	 L5NZI4Ly6kfPB9CcQCOruk02/dSUbfE5rE07kB971xRMJr6zvfvaDVGhNnDEGAnjeL
	 5wEWUs32wJ3Ng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70AF7380AA62;
	Sun, 19 Jan 2025 02:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] net: sched: Disallow replacing of child qdisc from one
 parent to another
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173725203300.2534672.8306526375845405228.git-patchwork-notify@kernel.org>
Date: Sun, 19 Jan 2025 02:00:33 +0000
References: <20250116013713.900000-1-kuba@kernel.org>
In-Reply-To: <20250116013713.900000-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 15 Jan 2025 17:37:13 -0800 you wrote:
> From: Jamal Hadi Salim <jhs@mojatatu.com>
> 
> Lion Ackermann was able to create a UAF which can be abused for privilege
> escalation with the following script
> 
> Step 1. create root qdisc
> tc qdisc add dev lo root handle 1:0 drr
> 
> [...]

Here is the summary with links:
  - [net,v4] net: sched: Disallow replacing of child qdisc from one parent to another
    https://git.kernel.org/netdev/net/c/bc50835e83f6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



