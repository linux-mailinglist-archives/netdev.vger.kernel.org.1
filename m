Return-Path: <netdev+bounces-73066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8008985AC78
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 20:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3FBD1C22EA9
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 19:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A8F50A6C;
	Mon, 19 Feb 2024 19:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rbYo42fK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8833252F68
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 19:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708372227; cv=none; b=oQy2YtAq3SZQhsXFVza8ytAm3nlX85B5PkyZyDRoDoJFW0zsR+Z6kryTo+zsW3XOsEZiY9GLBNplra2VAGUFRZ7xOD83LudQL3enlmR7DkFwIFfpu83cXYtm9zZpuU3MNoz7zjz2YNflY2aS5omwbdfJCqpgC2EXAno+1Mr3z6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708372227; c=relaxed/simple;
	bh=94IGITlXHiF+aijsxYv3GDTet1aY9nKbAumjN58saqo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NaBWom94ZvspDt10Hhb/i2ZkWSy7ahbIVuBmm3mXFuLwj6lvZVHxwSfCpGBsPKCl8AB4LM7LfE3qgxRSp6ror9bw9ssdcuZ3nLab50YOD2MOeydlYZ2n3+a24VMpg3m7SzvsoRuDG7kjS8wYAHTz2CH6TIXmZnieWHazIoxqtPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rbYo42fK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 12790C43141;
	Mon, 19 Feb 2024 19:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708372227;
	bh=94IGITlXHiF+aijsxYv3GDTet1aY9nKbAumjN58saqo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rbYo42fKZ14FeYEailW2Rl++dTZQYrb070upcC8WBh+8tx4KCR4srAkpzPXrYIgo8
	 7S37Me3zTbd84QdUK9je4XBnpfZZmZbKb/RWAo9rTHojm3M1OV9cLRa66PHdWOfLqk
	 9cCPbeSDe24jWtgGEtkT89proy0Hdx7wG1F9cFoHtGoo0YazlzY1Zm6GfJXz6eoedD
	 shpR5aNiuuk6Tn4zsTd3zVBD+u7ph54+c6PuR8meY+wRDvJbr/UxAYfmvlZL1LDuli
	 0FgZdEH84TTCPCGY1eL90U7KFyZiT0k5OqV3N5/7dykjVWpJX9I8VXaidl/H/xjZSx
	 4VTenHwwXqbPg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 01648D990D9;
	Mon, 19 Feb 2024 19:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2] man: ip-link.8: add a note for gso_ipv4_max_size
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170837222700.28614.4209857023428754430.git-patchwork-notify@kernel.org>
Date: Mon, 19 Feb 2024 19:50:27 +0000
References: <76a426018ec585c7dc40148fc832746e119dae60.1708370164.git.lucien.xin@gmail.com>
In-Reply-To: <76a426018ec585c7dc40148fc832746e119dae60.1708370164.git.lucien.xin@gmail.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: netdev@vger.kernel.org, dsahern@gmail.com, stephen@networkplumber.org,
 pabeni@redhat.com, edumazet@google.com

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Mon, 19 Feb 2024 14:16:04 -0500 you wrote:
> As Paolo noticed, a skb->len check against gso_max_size was added in:
> 
>   https://lore.kernel.org/netdev/20231219125331.4127498-1-edumazet@google.com/
> 
> gso_max_size needs to be set to a value greater than or equal to
> gso_ipv4_max_size to make BIG TCP IPv4 work properly.
> 
> [...]

Here is the summary with links:
  - [iproute2] man: ip-link.8: add a note for gso_ipv4_max_size
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=1d7f908103be

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



