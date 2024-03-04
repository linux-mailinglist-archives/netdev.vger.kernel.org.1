Return-Path: <netdev+bounces-77041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A54E386FE72
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 11:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 463501F23475
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 10:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00CB224F9;
	Mon,  4 Mar 2024 10:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mjy3A1JQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB37224DF
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 10:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709547028; cv=none; b=UqLHOWL1z47LzLwOkTNgnBeR+gSsVY/jVoaAtCQX3XJaeJaxT/YhZm8/m8UIdDp9lUv7YFjMZDX5VH5HFIIze/4xtB5dakeWjQYZqy98otIUOMalqyCAFONDt3rajzyxwV/ItGh6W6Udry3KebgRBb2Ft0JtrPI2Gf49zYlbkxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709547028; c=relaxed/simple;
	bh=hk8TGQMRtTxgPeCH1vivDUlZ1M0h4KszU+p66HNbbxY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hHoopozEo2C5E9qh8GZrxBA0s5m0Iawaz2FD2pw2J2gYt/DKJ0hk82yA0vozwTx82SnfFEKUgEYSD8zUM/PzR0QV5AbapbXUJ6Hzzt0BY2s46/HNowOEatwSD3o4haYCUJkJxpXD+lUiWfBzn2WgX9L8M5Am6mG9p2bXBvVrEnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mjy3A1JQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3CE62C43390;
	Mon,  4 Mar 2024 10:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709547028;
	bh=hk8TGQMRtTxgPeCH1vivDUlZ1M0h4KszU+p66HNbbxY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mjy3A1JQ/CbvmRbtI13eEjVrGfvoI1hUnH0rBUKvxIQbLeV2lhzXCyshWdhvtbz3W
	 l27nqqaTQmAgkQHeFmLVNZxPBlWnX5arwEgod4/FMCurXh/6lKcIO1I9/yzccwKago
	 9zTTVAt0GQ4THuLBKfvAMUWAjbhhvm0ypiJLwlowsvOgv1cNOcBUBdQ5rrjLVzQl6H
	 Y8wiZqI1JzRKb9RPEMN1AI3iO3852ywVS1uIdZ0ha//7pjlbvK6giLDDDECMdy/7LX
	 dw9RFxTXBQ+qg0BntHZTTRIwcf6q1hKBizFheLkyRW+LDkL41cleRTiTyAigbkE0Wa
	 v3S9nj5p38Kgw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1D827D9A4B9;
	Mon,  4 Mar 2024 10:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] eth: igc: remove unused embedded struct net_device
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170954702811.29163.12079126596096428666.git-patchwork-notify@kernel.org>
Date: Mon, 04 Mar 2024 10:10:28 +0000
References: <20240301070255.3108375-1-kuba@kernel.org>
In-Reply-To: <20240301070255.3108375-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 29 Feb 2024 23:02:55 -0800 you wrote:
> struct net_device poll_dev in struct igc_q_vector was added
> in one of the initial commits, but never used.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: jesse.brandeburg@intel.com
> CC: anthony.l.nguyen@intel.com
> 
> [...]

Here is the summary with links:
  - [net-next] eth: igc: remove unused embedded struct net_device
    https://git.kernel.org/netdev/net-next/c/c2a22688c931

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



