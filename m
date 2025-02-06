Return-Path: <netdev+bounces-163333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66994A29EF5
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 03:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B56353A6B3D
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 02:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDD413AD18;
	Thu,  6 Feb 2025 02:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCrOugaY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B83728F1
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 02:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738810210; cv=none; b=eo6GfxOoTCTocEwRYPvez/m7UbKBI3k5dK5BdP3Ubz+FAf0wF38WUafBKBxMq55VHRwyFM60GYFn2LsOX0qHw9/EkxF7aUWJSoPqPtQZjByVvjKEBgHHOX1alY7+WO8q0sOPJfbvRKuHwKSHuKdqzzivlnF+vnn8QxBx4tbBFUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738810210; c=relaxed/simple;
	bh=whImiPs8/P3YikMJgjmIiMN0/GzQk0UFbHqkl8/xyO4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Cs6IQDdyuAHrQw8t/0S5DhelgQ+F8r+J2CxpvjcRBeDVkXIw1fBkuNSOdEHxA5dwTHtwwfwkU9NQZVK4f04Ka72KFDdDrRvzOHIHbCc42LzyE8sRC+NYOozA/7mnqRRn8VuzmIGsOWkhDJHuO255MI4wV03dY1tFm+R2CH8kuBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PCrOugaY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE03FC4CED1;
	Thu,  6 Feb 2025 02:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738810209;
	bh=whImiPs8/P3YikMJgjmIiMN0/GzQk0UFbHqkl8/xyO4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PCrOugaYqOHMxudUT9nwariwLCh8d8lXBxSVxs5bb2azK8+J6nqdSIlr/XyxQMqVA
	 aPufEska15j6uSGnV9Vqqef08eksCtveWyIT7H5o0lJpSp7wgHmUjObPiJvuDmSpDv
	 GQrq3xdg/F5yQrnCzcKx6UJ+dCFmP1tRuHzWs70Ak6p55gfOHhkPI7Pq8pSayEzzTo
	 HwwicDahHsQUbbrutNhG+7tJd5lrmgbtsNapZXdwNW9c0MehgalzlfYDtv14Tq8akO
	 BlgZ4bKLech42ysDJQSjgFXyaoHnd5NFfSDYEuHcv5J/mghWT9XbJhr8dezb3rkzKQ
	 X9OTMd75v2QqQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADECF380AAD0;
	Thu,  6 Feb 2025 02:50:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: flush_backlog() small changes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173881023725.981335.7335096980650133391.git-patchwork-notify@kernel.org>
Date: Thu, 06 Feb 2025 02:50:37 +0000
References: <20250204144825.316785-1-edumazet@google.com>
In-Reply-To: <20250204144825.316785-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, kuniyu@amazon.com, horms@kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  4 Feb 2025 14:48:25 +0000 you wrote:
> Add READ_ONCE() around reads of skb->dev->reg_state, because
> this field can be changed from other threads/cpus.
> 
> Instead of calling dev_kfree_skb_irq() and kfree_skb()
> while interrupts are masked and locks held,
> use a temporary list and use __skb_queue_purge_reason()
> 
> [...]

Here is the summary with links:
  - [net-next] net: flush_backlog() small changes
    https://git.kernel.org/netdev/net-next/c/cbe08724c180

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



