Return-Path: <netdev+bounces-101177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E3A8FDA2E
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 01:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D571E1C22C3B
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 23:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52C81667D6;
	Wed,  5 Jun 2024 23:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L66IlVmW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F25161901
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 23:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717629031; cv=none; b=o+7WBhv6wjgug8rpLG8OOe2uMxvNxaBQyziISCV2J+NH2d+SSmHDJpIDYY1V98nm0CsPMYYBZE3sYNn1eCu2kxq/+6qb/g1IDUj5p9+K7NiPm8h55lJ1Yk5mhICUcwWlJbZou+LL1bIdTsnAI2t92KJQR9dScZ6rsm897TIc/pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717629031; c=relaxed/simple;
	bh=n4GtrpV+DKCglbkLRZImy2IZsNZMXy1Jygkf9L7kYIg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CtOeaj40MxdwRHuA7e7uzjEBepQk9xQZjA7hdro5WJZaotDHN9ww8iFFF0Bi1iy4BiPz2fSvB5PsTcQTStn6KpzB/P8TyiqvhXsvtfl7lSSJkHgGZrnUbZItQdW3af7iuvQaq1N8JJW+j8BPbSCKTMKzH/CBldPqgtNjGEgSn+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L66IlVmW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9273EC4AF07;
	Wed,  5 Jun 2024 23:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717629030;
	bh=n4GtrpV+DKCglbkLRZImy2IZsNZMXy1Jygkf9L7kYIg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=L66IlVmWneBKSJLmb0UmH0l5vWOrCjn8etsYQLNz5BN2F4LNMoEHq+Qy35NOTn43q
	 FWyinKfoP+3C7B34CXwrpFRYfSketcEm+jJ0AzIxVyL7EMtHchHgsyGqbnERDWFt97
	 JR1MhG7BF/B1oeMpo5KkJk+jqdk3z5zQLXnpyBMrUswzs2vV7eI7nURrVOW4lFROor
	 YCYRwHYlnEtdlpssoltd1z2OoPlzyC64VbJMoFtDf6u4TXPpXTSdutkDD+GON+PewU
	 RW0M1pbQV2HKertiKQx0qtwhxyRqQcgf+jIDzrOMw2eb2zAn9VJIDj7CzzKeEm6oY2
	 8tKkoeH4WwpgQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 79757D3E996;
	Wed,  5 Jun 2024 23:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/sched: taprio: always validate
 TCA_TAPRIO_ATTR_PRIOMAP
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171762903049.13835.9283763966651536465.git-patchwork-notify@kernel.org>
Date: Wed, 05 Jun 2024 23:10:30 +0000
References: <20240604181511.769870-1-edumazet@google.com>
In-Reply-To: <20240604181511.769870-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, noamr@ssd-disclosure.com, vinicius.gomes@intel.com,
 vladimir.oltean@nxp.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  4 Jun 2024 18:15:11 +0000 you wrote:
> If one TCA_TAPRIO_ATTR_PRIOMAP attribute has been provided,
> taprio_parse_mqprio_opt() must validate it, or userspace
> can inject arbitrary data to the kernel, the second time
> taprio_change() is called.
> 
> First call (with valid attributes) sets dev->num_tc
> to a non zero value.
> 
> [...]

Here is the summary with links:
  - [net] net/sched: taprio: always validate TCA_TAPRIO_ATTR_PRIOMAP
    https://git.kernel.org/netdev/net/c/f921a58ae208

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



