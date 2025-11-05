Return-Path: <netdev+bounces-235655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6C4C3397A
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 02:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DAE918C4694
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 01:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911BD246BC7;
	Wed,  5 Nov 2025 01:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+vFABp5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696A0246770;
	Wed,  5 Nov 2025 01:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762305041; cv=none; b=Epz5+pt0a32duAO2xWeaSb6WSdhfFuEAgb3iRvwXRS6G7H825NC77FqEpPmzKMC/QJpF0fnl4xky0e7DRA3sy40mSakJk88TvOD8UggBYTt/8U0DfQoRLyoGqSees27psAtRk5V+bbckdnWoO7xgMjsYxbn8jzk9N6KXQVbFfdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762305041; c=relaxed/simple;
	bh=Azv52bsIeKWa7QSW1vxmRSp2Zri86Y2h560msvWaCxY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uQjdUlEElcUtJatVQzsSez8TvJMxdwT/YM9RsoKLI2o3I+7Cp/DWPaGj++cr9JGp+zOkqD/SNWSWJfDKjx4EMTqhBNvjArWBRZgngmz8QeeJYFkiSQ6Zn/GRqNtJO4lcfOkhPKWLMFihL0X8eFFFhzDcdyrImvA/eaTEurmSU5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+vFABp5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EACECC116B1;
	Wed,  5 Nov 2025 01:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762305041;
	bh=Azv52bsIeKWa7QSW1vxmRSp2Zri86Y2h560msvWaCxY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=V+vFABp5elm84Ss97Uw9f0l2rd7J1m5ys2OvlQ2FI62hO3sWjbXhw+xsmyE0DkDYq
	 v70qxtIHD4GdSy/IQJ20zPZ2ISx2E6afClcfzrY6axaZGfRMz+inyMudse+ruZO0ei
	 zvz4zH08UjhDXJhbfXpym77/PGd0dbTZB1h6SVVQthgZhZ7yZshY/J+k3FI4FC3UcP
	 wfg5xDe3NJLFJ1cjk7PLdBYTPgrKUO/ZNyRd5zoDBGg1FqcdgASiDNz9GfA9POkq4R
	 mdzFl97BUZORZXX9uCbZb8hr/Pe72T+XrWqvev8nNO0WPpH+M2yeLIsfl5HWech4VE
	 rbZDIvWqx8Ovw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE14380AA54;
	Wed,  5 Nov 2025 01:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] xen/netfront: Comment Correction: Fix Spelling Error and
 Description of Queue Quantity Rules
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176230501449.3047110.1916177253371882159.git-patchwork-notify@kernel.org>
Date: Wed, 05 Nov 2025 01:10:14 +0000
References: <20251103032212.2462-1-chuguangqing@inspur.com>
In-Reply-To: <20251103032212.2462-1-chuguangqing@inspur.com>
To: Chu Guangqing <chuguangqing@inspur.com>
Cc: jgross@suse.com, sstabellini@kernel.org, oleksandr_tyshchenko@epam.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, xen-devel@lists.xenproject.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 3 Nov 2025 11:22:12 +0800 you wrote:
> The original comments contained spelling errors and incomplete logical
> descriptions, which could easily lead to misunderstandings of the code
> logic. The specific modifications are as follows:
> 
> Correct the spelling error by changing "inut max" to "but not exceed the
> maximum limit";
> 
> [...]

Here is the summary with links:
  - xen/netfront: Comment Correction: Fix Spelling Error and Description of Queue Quantity Rules
    https://git.kernel.org/netdev/net-next/c/52665fcc2241

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



