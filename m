Return-Path: <netdev+bounces-64031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF0E830BD5
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 18:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32040B21DD7
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 17:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC38225D1;
	Wed, 17 Jan 2024 17:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFRS8YHV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87E92030D
	for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 17:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705512026; cv=none; b=Xwpgwi6i3BKq9hRQHfEbd1Z8eajyKAkKVJ5NWA+FRRYRQnaQ3LjZ/6D3eINU9pbGxvF42iz8yPRrtBYLZHQHBOaK7aOWtY3boxEhiCh2u64Y3O6/hL9A+WoLQyj8HFkjN2MmdJCwgvRNGyUnp1hln+sdnug54qJ8iY1D/QLpdKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705512026; c=relaxed/simple;
	bh=AHqgc5lsOR1IxRMY/9RH9uEYs4OmkldCjl1YKIsODFo=;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BzqdbZ3sDEHD8AOCoXyNoakzKU66cLesnSEVjyuUnhPtRCP9/r6i/N+ZLzY3tF1kl3166DNcbh5IMtJFizDmoyZDmlNyP3uR1DX3pE9c3U84//Qxvkz56TJLkIC09PTyUHK8eQl79TJrCMdcOdBjUZoBsiyGDRA0famPCVYRBww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFRS8YHV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1F33DC43390;
	Wed, 17 Jan 2024 17:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705512026;
	bh=AHqgc5lsOR1IxRMY/9RH9uEYs4OmkldCjl1YKIsODFo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UFRS8YHVKk0Wf2+fLvKWjhANpC5rMTrbrWIlE/0tdUT2uGmp5u+VzcznDOPip/7X0
	 19yWcnf5eCo05lOaufRcmjsrYL6dUm2MxPo81xB4h27Jzws4OJPB9QzTuKl0WK29qa
	 QoZwCMqXa7RZ/2gKtHQarmXVds60Zkr51+A+OGQj1yo7lZ1mo2Kg6He0bp9SFlK0EK
	 2mFnLGdkxNaOPd6bQqodI7DGWbBsHn7Ah44/g5CtQHUoZvGGUhteDnP+aR8eYoD30D
	 uQF4cfhMP2wBEf5FSEpftE0rwpUbHxhV9d79rGQmr6hMg7o7bVMyzu0st6bODPPSnP
	 2XztcnNu6975g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F3C43D8C97D;
	Wed, 17 Jan 2024 17:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2] ss: show extra info when '--processes' is not
 used
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170551202599.9915.18061579827470063001.git-patchwork-notify@kernel.org>
Date: Wed, 17 Jan 2024 17:20:25 +0000
References: <20240113-ss-fix-ext-col-disabled-v1-1-cf99a7381dec@kernel.org>
In-Reply-To: <20240113-ss-fix-ext-col-disabled-v1-1-cf99a7381dec@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: stephen@networkplumber.org, netdev@vger.kernel.org, qde@naccy.de

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Sat, 13 Jan 2024 18:10:21 +0100 you wrote:
> A recent modification broke "extra" options for all protocols showing
> info about the processes when '-p' / '--processes' option was not used
> as well. In other words, all the additional bits displayed at the end or
> at the next line were no longer printed if the user didn't ask to show
> info about processes as well.
> 
> The reason is that, the "current_field" pointer never switched to the
> "Ext" column. If the user didn't ask to display the processes, nothing
> happened when trying to print extra bits using the "out()" function,
> because the current field was still pointing to the "Process" one, now
> marked as disabled.
> 
> [...]

Here is the summary with links:
  - [iproute2] ss: show extra info when '--processes' is not used
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=87d804ca0854

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



