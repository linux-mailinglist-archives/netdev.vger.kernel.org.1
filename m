Return-Path: <netdev+bounces-231047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A54DBF42FF
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 02:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D737418A85C0
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 00:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B3E24418F;
	Tue, 21 Oct 2025 00:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DX0I9Di1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E65A1FECBA;
	Tue, 21 Oct 2025 00:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761007835; cv=none; b=hDCmbwywa1g7G5d/5KKXjn6jtkpfSUosjHbxX1IntcU8qzLHBi/6xSUXlPylxbpYwjeRE/7cal2qUxaGp9JavLYoXz/hS13bMGxXgMvNsohH+qY3OhZbIEd9hf9PGvOBQmpwNfkL/ZXM9f9Zeja//TNAjBX38Q75qb6weq03ZIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761007835; c=relaxed/simple;
	bh=++2nJTm74huLKwpPw1ivw2ptlPcp89e+q5Hll80mG/A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JwD/x8WbdcfsW9dXcutScDILclyAUGPjSWpM8cesYOvKB/une/6vtO+P2+g7gLoTb2JkH82hxaO8ouVyFckx7U3mcnX/xtIqpWnxeA561qLl4d8GzhQ1Y5Wi89x13ZjmNzghM+UyVuJQBuRXdsxm5tuF6wcY6dfEdQunBuz6LJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DX0I9Di1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F3ADC4CEFB;
	Tue, 21 Oct 2025 00:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761007835;
	bh=++2nJTm74huLKwpPw1ivw2ptlPcp89e+q5Hll80mG/A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DX0I9Di1uck5KP5k6668adYTpOdK/6/380Ih+DqZvcwIAKcjhPlSUiMC3qciLDx/4
	 gm+fREKADe3CsgXnP9+ycyKYZDuB+ybttNLTW9nQw/q988FPCHFlEwkCecPhIz8Zhl
	 AGg7m/KwnmCuS1aM4DbdBWkGu5Xj7w07vFtJwt3SmRK2upkW3ovDGCr5Ji16ujPCAl
	 wZmI7JbAa+gtXNrEpQzGZG+CQfm7IGDLk9D6i84SiuJiyAl7CIni049Y3vb18X1k0a
	 aI69VC/oN9ekSgFoBenYvPotrVIcGO+hSrzhhlYl5rPbatOZ6YY44nPB89DQj/63ze
	 m/tmmX3XPuahQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 340923A4102D;
	Tue, 21 Oct 2025 00:50:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] gve: Consolidate and persist ethtool ring
 changes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176100781699.473459.13729279070260421346.git-patchwork-notify@kernel.org>
Date: Tue, 21 Oct 2025 00:50:16 +0000
References: <20251017012614.3631351-1-joshwash@google.com>
In-Reply-To: <20251017012614.3631351-1-joshwash@google.com>
To: Joshua Washington <joshwash@google.com>
Cc: netdev@vger.kernel.org, nktgrg@google.com, hramamurthy@google.com,
 jordanrhee@google.com, willemb@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 pkaligineedi@google.com, ziweixiao@google.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 16 Oct 2025 18:25:42 -0700 you wrote:
> From: Ankit Garg <nktgrg@google.com>
> 
> Refactor the ethtool ring parameter configuration logic to address two
> issues: unnecessary queue resets and lost configuration changes when
> the interface is down.
> 
> Previously, `gve_set_ringparam` could trigger multiple queue
> destructions and recreations for a single command, as different settings
> (e.g., header split, ring sizes) were applied one by one. Furthermore,
> if the interface was down, any changes made via ethtool were discarded
> instead of being saved for the next time the interface was brought up.
> 
> [...]

Here is the summary with links:
  - [net-next] gve: Consolidate and persist ethtool ring changes
    https://git.kernel.org/netdev/net-next/c/c30fd916c4d7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



