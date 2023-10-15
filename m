Return-Path: <netdev+bounces-41102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC13C7C9AF0
	for <lists+netdev@lfdr.de>; Sun, 15 Oct 2023 21:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D38F1C20979
	for <lists+netdev@lfdr.de>; Sun, 15 Oct 2023 19:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D960F9F8;
	Sun, 15 Oct 2023 19:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NyBHbEbj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3C1F9E9
	for <netdev@vger.kernel.org>; Sun, 15 Oct 2023 19:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 02B12C433C9;
	Sun, 15 Oct 2023 19:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697397025;
	bh=RN0NGHUYPedHiC6SYb3gNz26CFkynA2t5TB3FnLOLTk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NyBHbEbj9EmhV4IPNOAiML2oDe5VUJSsrDzJZDrq935DgAFp0Dt9lk6YbBU4/xRlg
	 BYQiATSqQbn4/xMaIVyewfrCstzdbmCF2c7Q2ypemjBRv7W2BodABTJdAQnb7mbAd4
	 C8qEjZGHJ4pPQu92eMaKmagnUTlDznF9kbpnKKMxViLtvg+Qzalg92mWQZTcnEly0L
	 14Tl+pgV86+OtlL3rhZEj8WF7JB3QhHxPbYVGXnSNa7VJvxpP8MmWBd3tfZYTLWNvr
	 AfWwSO5PzVS/8Y3f9Wdp+xsfvMTPNlBsJ2keZcALYi76P2tna+iB4dIUiEx/sRDLyX
	 eUNiFaLzc94fQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DFC1AC39563;
	Sun, 15 Oct 2023 19:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6 0/6] ptp: Support for multiple filtered timestamp
 event queue readers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169739702490.16848.5167099930461687378.git-patchwork-notify@kernel.org>
Date: Sun, 15 Oct 2023 19:10:24 +0000
References: <cover.1697062274.git.reibax@gmail.com>
In-Reply-To: <cover.1697062274.git.reibax@gmail.com>
To: Xabier Marquiegui <reibax@gmail.com>
Cc: netdev@vger.kernel.org, richardcochran@gmail.com, tglx@linutronix.de,
 jstultz@google.com, horms@kernel.org, chrony-dev@chrony.tuxfamily.org,
 mlichvar@redhat.com, ntp-lists@mattcorallo.com, vinicius.gomes@intel.com,
 davem@davemloft.net, rrameshbabu@nvidia.com, shuah@kernel.org,
 kuba@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 12 Oct 2023 00:39:52 +0200 you wrote:
> On systems with multiple timestamp event channels, there can be scenarios
> where multiple userspace readers want to access the timestamping data for
> various purposes.
> 
> One such example is wanting to use a pps out for time synchronization, and
> wanting to timestamp external events with the synchronized time base
> simultaneously.
> 
> [...]

Here is the summary with links:
  - [net-next,v6,1/6] posix-clock: introduce posix_clock_context concept
    https://git.kernel.org/netdev/net-next/c/60c6946675fc
  - [net-next,v6,2/6] ptp: Replace timestamp event queue with linked list
    https://git.kernel.org/netdev/net-next/c/d26ab5a35ad9
  - [net-next,v6,3/6] ptp: support multiple timestamp event readers
    https://git.kernel.org/netdev/net-next/c/8f5de6fb2453
  - [net-next,v6,4/6] ptp: support event queue reader channel masks
    https://git.kernel.org/netdev/net-next/c/c5a445b1e934
  - [net-next,v6,5/6] ptp: add debugfs interface to see applied channel masks
    https://git.kernel.org/netdev/net-next/c/403376ddb422
  - [net-next,v6,6/6] ptp: add testptp mask test
    https://git.kernel.org/netdev/net-next/c/26285e689c6c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



