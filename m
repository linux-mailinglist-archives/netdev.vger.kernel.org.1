Return-Path: <netdev+bounces-118808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BCC952D24
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 13:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DF7828181A
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 11:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89ED1AC897;
	Thu, 15 Aug 2024 11:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjKtLJpx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D67B1AC88B;
	Thu, 15 Aug 2024 11:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723719634; cv=none; b=HKcj66Oey+TjLZSrDZ09Jm89nZOzZQVFZjPp7yrqiYNbkY8fkX1oP8QeP4JHe2mp9tj1vPWS2+yB4S193vkBWAu4i7UNaSFIKKtLJQyIu4lnl6US+e4eYSOQEOtUvcRtVGQfWHvpB1x8Adb33Ipr33dZABSBdyQcmWqx3NUemhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723719634; c=relaxed/simple;
	bh=O+CoYyg2426DsdYP06h6zsQ/M0suIVGCgtbbPNA/XuI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=otuDG/p72BstCKnGvhy1yoBfSqNH1DV4ZIjmdbSoVUj86GHo6ZF16/SoKjS+4lIWkPuRt649AK4qTI/aBCaxuV+nkL/cw57JV0YM6hkT2+E1FggtcOEwNRNc297R4vUP64INSxeGR8qRkLQ6z2OJY7UKMfwyjCElz4r3TdEs0ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sjKtLJpx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 128CCC32786;
	Thu, 15 Aug 2024 11:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723719634;
	bh=O+CoYyg2426DsdYP06h6zsQ/M0suIVGCgtbbPNA/XuI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sjKtLJpxoNDshdriu1I7jfYgERaXFAPtSY3yMqP0wiu1zVKjTmzyywVWZyI3kMQS9
	 P2GqOdsnNhdd4LGD4GBp2L0thamuYKL9XRlQjxpS0n5EYN05ZcumPM1EN+m7CVgMkH
	 HrkidDbzRLTQl7BZ9k61yNDwvvjOyzrL/IEU76oxDN9wx3uVS6pAwcpW+krBBUcph9
	 pA4kaB7X6sLfviVJEmIxe3W7BZHPxw2NKDomyVSSAg890nYRj6jjcwJe2FYlNOIsD8
	 pfS2VSYlRepJw/U3jkZ1hGHFGnNEZ23E0LdByrJRafLlMMQbrb7cCvogK3xp4kne7M
	 BGkbi/PgWdPnw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71652382327A;
	Thu, 15 Aug 2024 11:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: thunder_bgx: Fix netdev structure allocation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172371963327.2820806.10090628006772754958.git-patchwork-notify@kernel.org>
Date: Thu, 15 Aug 2024 11:00:33 +0000
References: <20240812141322.1742918-1-maz@kernel.org>
In-Reply-To: <20240812141322.1742918-1-maz@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, leitao@debian.org, sgoutham@marvell.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 12 Aug 2024 15:13:22 +0100 you wrote:
> Commit 94833addfaba ("net: thunderx: Unembed netdev structure") had
> a go at dynamically allocating the netdev structures for the thunderx_bgx
> driver.  This change results in my ThunderX box catching fire (to be fair,
> it is what it does best).
> 
> The issues with this change are that:
> 
> [...]

Here is the summary with links:
  - [net] net: thunder_bgx: Fix netdev structure allocation
    https://git.kernel.org/netdev/net/c/1f1b19428409

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



