Return-Path: <netdev+bounces-134449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C386F9999D2
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 03:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D7AB1F2327E
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 01:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A718D16419;
	Fri, 11 Oct 2024 01:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLfefOQo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBD5FC0B;
	Fri, 11 Oct 2024 01:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728611427; cv=none; b=cR6QFFuMganHsf8g+B834rYlxJ6aYIEi6tqFxo+bY0QPHtqLBQ7s+GfI4nYMbTtByv2u5oWYNVqfYIhHia1kz8D1ezbJ+Mt65TGFLxt3A92zfcM/eEQ6pg2sRX+y31HldgKi0xHvp2J8YaSaCznWHh+wgZf0NCHpmZm/KRmV6Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728611427; c=relaxed/simple;
	bh=FBvyDh2LA9stC8fceX+G7zSMkqttfkMzdlsCQrZom5g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dmWfHAVCW0LoD+xnEr0lmKN6afhM8hbbUUv1P+iKWNHP9t1SjWhBiW+Uwyp5Qjzo6c+QhxbklgIC/0BpPMTcusMunCg2SOUYiJC2pot3ViGK4sRe0FyPe+kJjOsRnGYfJ9w6l5yFkQRKUQjYPleEwtf8BKPgjSUFg89hJfdZNQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLfefOQo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F16C4CEC5;
	Fri, 11 Oct 2024 01:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728611427;
	bh=FBvyDh2LA9stC8fceX+G7zSMkqttfkMzdlsCQrZom5g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dLfefOQob4wg67nCQoe9BCY4fYen7SG2tabM90Vx9TBSfIWhTf1DBJp8/FkFt8Cal
	 i6imyw4v8pRU9Z3dXBiAjNuZS/WlGFtGeVoTOabbFviP0zcBon8OBxeA+Do/SwUHKn
	 Sprvi+DJ2iWm+jG7oA89IyM2RMnG6c9lbgRzS/Sxy/xLYfgAGptIncdlba7GUMiv5W
	 dSuHHf3cko37JuXP6XreDqxfdZLDHwIcu07bIAnUmbxaLjHF9IsCrP56E1mSmj/u9y
	 EG919/B+7zkmCDKj3JIxC0e7kao8CD0n+bysuwo+pYFJfwyHW4LW2izomk7WlOrqxv
	 VtwRp1aDVBYeg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE433803263;
	Fri, 11 Oct 2024 01:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next v4 0/2] tg3: Link IRQs, NAPIs, and queues
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172861143152.2243561.11098545561216260571.git-patchwork-notify@kernel.org>
Date: Fri, 11 Oct 2024 01:50:31 +0000
References: <20241009175509.31753-1-jdamato@fastly.com>
In-Reply-To: <20241009175509.31753-1-jdamato@fastly.com>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-kernel@vger.kernel.org, mchan@broadcom.com,
 pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  9 Oct 2024 17:55:07 +0000 you wrote:
> Greetings:
> 
> Welcome to v4, now an actual submission instead of an RFC.
> 
> This follows from a previous RFC (wherein I botched the subject lines of
> all the messages) [1].
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/2] tg3: Link IRQs to NAPI instances
    https://git.kernel.org/netdev/net-next/c/25118cce6627
  - [net-next,v4,2/2] tg3: Link queues to NAPIs
    https://git.kernel.org/netdev/net-next/c/aec5514d739f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



