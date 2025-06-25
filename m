Return-Path: <netdev+bounces-201347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4570AE9149
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 00:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 474444A743C
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 22:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F822F3C16;
	Wed, 25 Jun 2025 22:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUSSk5Zz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E832F3C09;
	Wed, 25 Jun 2025 22:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750891824; cv=none; b=oGiKuCZwHclfxgt0hA4UXyAmj2vSl7C5wIZfqLyMV0EMnhaVnftF5yp5fnySNbHMoXSGrJvaqEoBh0p+A07wcPp20xQGb8ipYQVu1ZV0AH1jDXlPn+s0fWzCIa+mqZ2ZL3Tu7KmMPPJd8gsBBmBccNSPTYlpW5/kATj9eMExVz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750891824; c=relaxed/simple;
	bh=7LeeGGKAsIeZZDDBOC825WA3oYcM21phyv1HIDpgScw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=B8VVR2DZ3o5hTzDps5ahXns2S/YU046RQr8QRdTiPNwojHvEuuFk15ZSg/BVXVNEjFhT3HwBpJ+VzOaTKiYRrvgMOAwhY+h+mnbVzj+tTLsYjJgLQjxA4y/NHF4zF16dfP51xycGRL3wXWwTYNLsZ8sKfZQvM7esHEJpNzdN5hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUSSk5Zz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5B59C4CEF0;
	Wed, 25 Jun 2025 22:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750891824;
	bh=7LeeGGKAsIeZZDDBOC825WA3oYcM21phyv1HIDpgScw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZUSSk5ZzfsuT+2oAL0Eo6x0b93Fwqm1gbCyCax7ttTAfgb546snO6cV/Xum6QHHyF
	 3ajmrEFMhE4tpk1yql/D0AguI8gWv70nAa2kU2h5HBmJ/belRXCp2eRTiDhJ9DB5UV
	 2o92/1j34/IkSvr335uQPYv0hcX8ZUWy5tecCd9RVhQaOc0FjFeNnrc2DMosgQWK3L
	 CTaXhByhCm/FNxrXsrJGzb8q89/Xi0A4azFrvAQ32Ze5HSV+8DSis/ETH5/yW38K+j
	 Wxix+2srJGKmR/L3GakloX9Cr1slU0jI/ikncvYa/jzCA1q5yMrs+aThTeV74rTwDw
	 rRaO8cTdZF/TQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7104B3A40FCB;
	Wed, 25 Jun 2025 22:50:52 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] neighbour: Remove redundant assignment to err
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175089185124.646343.10093625973550254292.git-patchwork-notify@kernel.org>
Date: Wed, 25 Jun 2025 22:50:51 +0000
References: <20250624014216.3686659-1-yuehaibing@huawei.com>
In-Reply-To: <20250624014216.3686659-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, gnaaman@drivenets.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 24 Jun 2025 09:42:16 +0800 you wrote:
> 'err' has been checked against 0 in the if statement.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  net/core/neighbour.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Here is the summary with links:
  - [net-next] neighbour: Remove redundant assignment to err
    https://git.kernel.org/netdev/net-next/c/9b19b50c8d65

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



