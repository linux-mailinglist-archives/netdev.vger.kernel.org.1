Return-Path: <netdev+bounces-210907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF6FB155FF
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 01:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89F2F7A8999
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 23:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044342874FB;
	Tue, 29 Jul 2025 23:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbWVtMmD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4EA2877FC
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 23:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753831795; cv=none; b=Fa1jdg3LYsEV/wYx5sbhDkIslVRsMJ6HJEJMhH+y3qimmC4dj7lbQtq4dfLC3XitLq3Q4UV7BTRm92VPl+v7JsaNKT9rE0LmGzcP233I0h1SBnPZ5ldbWaFmqLxdMFoJPPXQw53On6R8a3qZ98v60uW+OQOSC6W+Z/hAUHJdcZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753831795; c=relaxed/simple;
	bh=wfQdSlpyvsEMEgwnjIe3tPzZrPmLQP+GLWYHzwtoXPA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NTSxS0oOP00H04AmWlQvKLeZHAa3vRnnq7c54LvN8SRpLXRIF4HZtFKquic4d7dVJAgSewWk5aNhCuSOqvfaOhBd9eH8VqSqi0+VxUUTIsxvRlmdzVckBqOe2r+NgQJA3FlF8cw9XdWZUf5P/Yudpa+d+4EEq48iY4ogXuecA6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RbWVtMmD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B31C4CEF8;
	Tue, 29 Jul 2025 23:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753831795;
	bh=wfQdSlpyvsEMEgwnjIe3tPzZrPmLQP+GLWYHzwtoXPA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RbWVtMmDhnqt9QOsis0sivZK0ZQqWVgD3tV8TuFqF4E3qFgbsCAj4E9xp+V+3xnYm
	 SjzpEwQ1jjJWmf9ldhl6AcJoCavcJiBb8TdK7LS7XsM+wspdPGzQ27SezojVPLTJTX
	 s8wrglzPiXJiz4LTs50QoRMwsqi0ciY2KfmalIf6JgZeZEtUcieKBOTC95LzT1qqUQ
	 +JnLmknqvtUa/xjJ6TBI5ybTPGtsSEZTlcW95HPiKzey6ES+90BW1QbqeaQKfPtB/m
	 g+MeLfqtDUyY9jaaOr+piWW7wXkm4ARDl8N5bMO2MNuaaz1SaGVA7q3eb6qeFIV1ft
	 yBcE9ykNwcAaw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 339B9383BF5F;
	Tue, 29 Jul 2025 23:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next] misc: ss.c: fix logical error in main
 function
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175383181174.1684209.4059441878838888598.git-patchwork-notify@kernel.org>
Date: Tue, 29 Jul 2025 23:30:11 +0000
References: <20250719163122.51904-1-ant.v.moryakov@gmail.com>
In-Reply-To: <20250719163122.51904-1-ant.v.moryakov@gmail.com>
To: Anton Moryakov <ant.v.moryakov@gmail.com>
Cc: netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Sat, 19 Jul 2025 19:31:22 +0300 you wrote:
> In the line if (!dump_tcpdiag) { there was a logical error
> in checking the descriptor, which the static analyzer complained
> about (this action is always false)
> 
> fixed by replacing !dump_tcpdiag with !dump_fp
> 
> Reported-by: SVACE static analyzer
> Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>
> 
> [...]

Here is the summary with links:
  - [iproute2-next] misc: ss.c: fix logical error in main function
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=27d11a81197c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



