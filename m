Return-Path: <netdev+bounces-61433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E923823A86
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 03:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2EE7B24678
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 02:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B92A4C67;
	Thu,  4 Jan 2024 02:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8Ga89W9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521114A32
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 02:10:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D8A9FC433CA;
	Thu,  4 Jan 2024 02:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704334229;
	bh=UBL258WHkM7t5mkSEO3dqSAYGCHMZK95SMFmJM4k6bc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k8Ga89W9TwbsHUa5fJ0OPhmGfyv6Zj0OVL/99mUuEHU1tHhINKkRG67ffXstHjL3L
	 AZ1lm9uFQLCng5KYvCBohH847su6eUwUbE7Uahe2RMIkt33/19r2oovMCVLQvzDAHi
	 gbpDktcLd0E3PLqRhTLbicZfqz0p2IpxC6xKwG0mViFYS4bpA95xErJnqzjgTA4QNw
	 dhBUEXLxC8DCfMSDtMHKzSAoUtQawaP8zLtP1cf3wP49bq0+A1Oe2N0BHAxdnTZ+dd
	 s3gN+Ko4cCzGdv2vWhblO8EySqA5e1w2cnq/Btz5jS4CPEiDfL19JPclneQn62Dmn/
	 mDbIJv8/8iN8A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C2B9DC395C5;
	Thu,  4 Jan 2024 02:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5][pull request] Intel Wired LAN Driver Updates
 2024-01-02 (ixgbe, i40e)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170433422979.9915.17534171146563949848.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jan 2024 02:10:29 +0000
References: <20240102222429.699129-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240102222429.699129-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Tue,  2 Jan 2024 14:24:18 -0800 you wrote:
> This series contains updates to ixgbe and i40e drivers.
> 
> Ovidiu Panait adds reporting of VF link state to ixgbe.
> 
> Jedrzej removes uses of IXGBE_ERR* codes to instead use standard error
> codes.
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] ixgbe: report link state for VF devices
    https://git.kernel.org/netdev/net-next/c/738808ae82d9
  - [net-next,2/5] ixgbe: Refactor overtemp event handling
    https://git.kernel.org/netdev/net-next/c/6c1b4af8c1b2
  - [net-next,3/5] ixgbe: Refactor returning internal error codes
    https://git.kernel.org/netdev/net-next/c/5795f533f30a
  - [net-next,4/5] i40e: Fix VF disable behavior to block all traffic
    https://git.kernel.org/netdev/net-next/c/31deb12e85c3
  - [net-next,5/5] i40e: Avoid unnecessary use of comma operator
    https://git.kernel.org/netdev/net-next/c/55f96e8bbea0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



