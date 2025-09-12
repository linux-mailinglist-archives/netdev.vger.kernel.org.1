Return-Path: <netdev+bounces-222642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4DDB553D8
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 17:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D66E5C26BE
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 15:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACE7313275;
	Fri, 12 Sep 2025 15:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQLbzMEQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB33B3112D3
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 15:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757691606; cv=none; b=ugr3BRzWAsb9yzRlJkh3WYqWFpY1ZT2k1jiFLQ+mvgwudhRZ7Ct52r5rqIMbQT7VklvHWHk7lQYWKnAX4KFoz1SQVQ9NZaY+yadMuuv633cZdGU0gaQaMhfQ+O8Vr4tM/RAeddzEfTWYPA0WCsRd7C23F+8Ou8WYU2M91hiieWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757691606; c=relaxed/simple;
	bh=veSWlJd08jmkDNILcZzFDiTBjAnDH321ZRPUzMLiqog=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=APO7GIThlE6CBZ9kkRTMHFvhKbTR+hEPOPBBulg8W2OAMKMp1nXmdHoACYpcGz66glp9PSwzbzCzXnYXHjVH0MmQhlzuFqg+7lDIrTXPRXm7zsJNjRWVWn9yLy67qYcmrCXEcscQxGUJeKuOpJsIz3hiq9UHjVXB7ALbS6cSHNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQLbzMEQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D6F0C4CEF1;
	Fri, 12 Sep 2025 15:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757691605;
	bh=veSWlJd08jmkDNILcZzFDiTBjAnDH321ZRPUzMLiqog=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GQLbzMEQXXfATWNNkM/iejuB4yzfzcdDKH0I+yoZz5MuYMRZTix3Phi5TJijCzYcd
	 gYp0KGMImzCVkfIUEn3GVUeKNewY9DrMGmQ8Gx1laVU7tgt18IUAoLvGtxYjAujmY/
	 wDOGaZQIt4oFHPfbs5C/6Ni9KA9A0UPfmP32nDhtUbZRW5Bx2WiUrWsBHxmtKx4IZ/
	 VPCNYMd2edcSLlAz2zSBW38TIIgzikvrcLzN60qXb3g3j1ZIL9Plr6TgsLyOoRD3rl
	 XP7v7/WMP77zKoOun8kqrirnShTbYfHdMBoZulhgYftyCcgfO1sQVoXnpELwklzm4m
	 4DiwLKLtlvfpA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF52383BF4E;
	Fri, 12 Sep 2025 15:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-main] Update email address
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175769160776.2988995.10548201266371155993.git-patchwork-notify@kernel.org>
Date: Fri, 12 Sep 2025 15:40:07 +0000
References: <20250911204915.2236-1-dsahern@kernel.org>
In-Reply-To: <20250911204915.2236-1-dsahern@kernel.org>
To: David Ahern <dsahern@kernel.org>
Cc: stephen@networkplumber.org, netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Thu, 11 Sep 2025 14:49:15 -0600 you wrote:
> Use kernel.org address everywhere in place of gmail.
> 
> Signed-off-by: David Ahern <dsahern@kernel.org>
> ---
>  .mailmap    | 3 ++-
>  MAINTAINERS | 2 +-
>  README      | 2 +-
>  3 files changed, 4 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [iproute2-main] Update email address
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=b930798bc63e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



