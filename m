Return-Path: <netdev+bounces-110441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F53892C6B7
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 01:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7C221F22F7C
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 23:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4EED189F39;
	Tue,  9 Jul 2024 23:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ggVGNfxZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC1F185627
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 23:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720568435; cv=none; b=rxkJQBAIe8t3zJeVPVFpZNryNCXoo75mwVwpfYXYrv0GNmVQFEJJVZv1bjFySJQ/oxOs+eN1bhiL/245NYwzmCIFhsUdOB/xiksGQbsB5Dy1GwHoT0f251tljPfpyB3bukAIbDXCivHROzPnn/bc1i4U0vvGDEv2NO9mKLoEA/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720568435; c=relaxed/simple;
	bh=40Xj0jCf2OH5VS1a6pPIawp/csNBg4CVtaYU1D0WjIA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jNaFiLZgIRFNg+G1sdtn1A7o0M0bvd4UCDwr0ahFdcCxfqsg2VL+fGSvu0TDrBNM1OWL/VLMTngurUL4viIbyWs/F+Y9l/v2NKzDC4AHEJVwFcr6phn6TVSVvpymiQjGPz730r9rUP505jY3mv3ieyitphH/vVBArO9CtUF7vkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ggVGNfxZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1DF41C32786;
	Tue,  9 Jul 2024 23:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720568435;
	bh=40Xj0jCf2OH5VS1a6pPIawp/csNBg4CVtaYU1D0WjIA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ggVGNfxZnmJdPZVMQxBOZWLrwqnTarJeHZVvDYPMzQLVZyJxwGGJLrduUseqmPNEx
	 lPwmnjmMqMmz0qfczWeZnowNhh3QowGQtTFFDmBxj9HPs/lApu6TS54jMPzyQKunVn
	 UVhLPIEl8PwuQjaDmCSnlmpywmrHc7hdWLFix8jBrYHFPKFlkcdaCpF+Ft++CewiNu
	 Ucxj9MBledryBs2GNbckw72uRUkW6zX6nnVaO5ktDAh9oQ/wzHwmYDbjkutPYlSHqq
	 3agk5HpOaSf7UcHddQbed4etNrobXd6kw+5eB/yK8JN193brQ5aTPTQuwvwkt4S2jA
	 BSmei1cCTVTwg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0B786C43468;
	Tue,  9 Jul 2024 23:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/5] selftests: drv-net: rss_ctx: more tests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172056843504.21813.18385048538140587791.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jul 2024 23:40:35 +0000
References: <20240708213627.226025-1-kuba@kernel.org>
In-Reply-To: <20240708213627.226025-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, willemdebruijn.kernel@gmail.com, petrm@nvidia.com,
 przemyslaw.kitszel@intel.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  8 Jul 2024 14:36:22 -0700 you wrote:
> Add a few more tests for RSS.
> 
> v2:
>  - update the commit messages
>  - add a comment in patch 2
> v1: https://lore.kernel.org/all/20240705015725.680275-1-kuba@kernel.org/
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/5] selftests: drv-net: rss_ctx: fix cleanup in the basic test
    https://git.kernel.org/netdev/net-next/c/a0aab7d7c860
  - [net-next,v2,2/5] selftests: drv-net: rss_ctx: factor out send traffic and check
    https://git.kernel.org/netdev/net-next/c/847aa551fa78
  - [net-next,v2,3/5] selftests: drv-net: rss_ctx: test queue changes vs user RSS config
    https://git.kernel.org/netdev/net-next/c/e2c9703d424e
  - [net-next,v2,4/5] selftests: drv-net: rss_ctx: check behavior of indirection table resizing
    https://git.kernel.org/netdev/net-next/c/7e3e5b0bc51d
  - [net-next,v2,5/5] selftests: drv-net: rss_ctx: test flow rehashing without impacting traffic
    https://git.kernel.org/netdev/net-next/c/933048fec4dd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



