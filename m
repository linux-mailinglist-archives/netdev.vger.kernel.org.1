Return-Path: <netdev+bounces-128161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D80D97850D
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 17:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86FCA1C21D6B
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 15:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9C34778C;
	Fri, 13 Sep 2024 15:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOKFVQMq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0582EB02
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 15:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726242031; cv=none; b=mTjpsQZpIU97JNdEiCav7g1oHPmNBxZhIaeKOEps+s/3PR1pYNcSjvyHv4Eb0RWjFT+bR+gB2FDxt6Q9GUj+M+/hZzBaFC/wk+ZRAf9tgc5ObbmBByh7Q5fdHPZYASIoXFGHZVnu5ITvQL54qpqUOTxsEj9p4n8fP1G306K3Mow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726242031; c=relaxed/simple;
	bh=wPDvraI95nGStqtH99uRLUtBdQYqO2Wdm0S8dmrBiWk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pf8R7gl3aW6GOkXHMltjv91GHrTggm1CGLQ+JP4ADc/4DDb8m7BUHpqxfxfVH7T9hWRfPM9ECwufq//Q5ZG5eLQ1+hplHbUjmzb+CnevyhZgDg+8OE6lODhp69CFX2NEJZNaiPOU96qsSFbGx+D9Dg7D2G5AbriNEllbmX9azAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOKFVQMq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CF07C4CEC0;
	Fri, 13 Sep 2024 15:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726242031;
	bh=wPDvraI95nGStqtH99uRLUtBdQYqO2Wdm0S8dmrBiWk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VOKFVQMqY+GO1J2vsDUqgd7BgTc2oBMHJkHkq4UszSArxaoohOBidKY54kEI6iryf
	 +ATH7nFtq588RiKNl//Lv7WhbvTYitIWY5W4OJJIrqn8OijB87pTISnwZ1bGnIdd/0
	 Lviu4/WmIQHT3x1qIx5aV4VgVh4viZYNAapIWAe4U4vl6DEN1xbgCf6842kj8G/T0d
	 Z1f2odvoATx8y3rkzvvTC5sQHjMwnYAwC3TaKizs6IUEdDtt7Qw98AHkUkQN/CFL2v
	 sOpEjizu87qfqYZ/zrDAIyIzcZGrp9DCpHX9vLmG5ItZVLYzn6gnyn725JYi+K/axf
	 YkFCRmwIOxbhw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE2673806655;
	Fri, 13 Sep 2024 15:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute] replace use of term 'Sanity check'
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172624203254.2279687.3787529002626384904.git-patchwork-notify@kernel.org>
Date: Fri, 13 Sep 2024 15:40:32 +0000
References: <20240912171446.12854-1-stephen@networkplumber.org>
In-Reply-To: <20240912171446.12854-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Thu, 12 Sep 2024 10:14:20 -0700 you wrote:
> The term "sanity check" is on the Tier2 word list (should replace).
> See https://inclusivenaming.org/word-lists/tier-2/sanity-check/
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  misc/arpd.c | 3 +--
>  tipc/node.c | 2 +-
>  2 files changed, 2 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [iproute] replace use of term 'Sanity check'
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=058e82cb2f48

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



