Return-Path: <netdev+bounces-67785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D797844EAE
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 02:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B52C1C2AE90
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 01:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70313FE0;
	Thu,  1 Feb 2024 01:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tBFjE+RD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832624A2E
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 01:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706751027; cv=none; b=McbMuz2st43ryxER4leRip+H5VSeZlvsMY+IPZ3Vd/F4F5hAPiV6gA+1ImDnwlqU1m4TPhr6MuxNx1CzUKOawN9OGb9hiECEJByEubxfNDKrapI1cn8v6ieGr74ZN9eEv+cu7NO0ga13TvhucPfGXwL+qgcKAf8gWjx9rMhHwoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706751027; c=relaxed/simple;
	bh=3OfHfKO9j8mtyXZtmJwxO//LMmiJgGV27lETzSuOQbk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j7jUUbqxvLlG5y4Tbw/0LBJwln91rEAwHPBqmSTOCzROdxwGKV9EhjECsd+X/+pPeqt3egPMZoebR7OuUOjJYlrmixZMBFevf++7KErMWzzhuL1HKB+lOcRWW8M73l0UQ+kTVJmz2kjgQszCQCrb2uvEhYGlC9dwbURO0Mbvga8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tBFjE+RD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D969AC43390;
	Thu,  1 Feb 2024 01:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706751026;
	bh=3OfHfKO9j8mtyXZtmJwxO//LMmiJgGV27lETzSuOQbk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tBFjE+RDcAQd3kzRlT/BNVLgtibrpKGTLkb6VPb3ypw9BoIyMoTorYeqkM3XbDTol
	 bJq+8ZIew2QLYuauXQPnXbhV6wmNrtzm0sisg/hZ1qzkOKU/Fn0D1TCMlHfM0TN4P2
	 /bHfSGcNRuIv2QoiRebjQcPNJ+49uvQgPsegEeeFxAGu0JHWh1foUlxMwe6P3nmDXs
	 CCFcoTOBlzi21AKicv+DWHogGcKV/mE37jr4VTxLk/wVQN1k/r+O8uwwFPkALNfpGt
	 1SM8kF/+KZfCKyRFlYeuvr6fjECTMWGDSs+6JrSDY11mNXqTN41/CyhlmGs7aT0MqN
	 RjTysROAwF8Fg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BCE9CC595C5;
	Thu,  1 Feb 2024 01:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next 0/3] af_unix: Remove io_uring dead code in GC.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170675102677.14193.5602586421212500450.git-patchwork-notify@kernel.org>
Date: Thu, 01 Feb 2024 01:30:26 +0000
References: <20240129190435.57228-1-kuniyu@amazon.com>
In-Reply-To: <20240129190435.57228-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, axboe@kernel.dk, asml.silence@gmail.com,
 kuni1840@gmail.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 29 Jan 2024 11:04:32 -0800 you wrote:
> I will post another series that rewrites the garbage collector for
> AF_UNIX socket.
> 
> This is a prep series to clean up changes to GC made by io_uring but
> now not necessary.
> 
> 
> [...]

Here is the summary with links:
  - [v1,net-next,1/3] af_unix: Replace BUG_ON() with WARN_ON_ONCE().
    https://git.kernel.org/netdev/net-next/c/d0f6dc263468
  - [v1,net-next,2/3] af_unix: Remove io_uring code for GC.
    https://git.kernel.org/netdev/net-next/c/11498715f266
  - [v1,net-next,3/3] af_unix: Remove CONFIG_UNIX_SCM.
    https://git.kernel.org/netdev/net-next/c/99a7a5b9943e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



