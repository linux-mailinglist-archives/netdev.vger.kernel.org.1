Return-Path: <netdev+bounces-86822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD898A060E
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 04:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04E151C22C1C
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 02:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0D213B2A4;
	Thu, 11 Apr 2024 02:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vIjaNh2Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1741B13B28F
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 02:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712803229; cv=none; b=F61ddg5YGaO4hkHi1oqSdqf+0NTNnA72oFPwkY8phwTZbdpJoH1qY3WfcNhjNdpvTWCz/vc8PU150wYNT1b5wi0alUccoJgBe+GxCCxQUGhRWnx8VXUVP66Pq6IwjXpdkmQ2iMvchgXKnU8wA9la2jwtNQSqGMz9SzOsO+Qv+VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712803229; c=relaxed/simple;
	bh=E/EdgxdxQ3SvCmT29W+W2+haNHGTBWD4IXE7WVl7s9o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qyg63eYBDlHcmcyUx28DFqYd+fVy/vkaXNylhpTiTZeUtbBIf2TpI0zz3Fq1gcHmiI/J3dAgWOsc7fTjK2QfyYrT5fr7A2Et/P+b52TGpSXA6gJiJ+UDqVefWLdQULRI9HmOA/IL1Z0RT7sxMd1wZzgljaxCeJpU9QA2hKT0P0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vIjaNh2Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8854AC433B2;
	Thu, 11 Apr 2024 02:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712803228;
	bh=E/EdgxdxQ3SvCmT29W+W2+haNHGTBWD4IXE7WVl7s9o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vIjaNh2Znqwq56VT3VQ0zJGE8o18MliCCpdxINwly6Wsv8hNVxJK8LtTieVFptXs1
	 jOEonBU3Lp+U5XiTwmcObiWaImj0Rx8y7ytMJMg00SvlhQPfpcHzC9MGenZ4g8hshw
	 GkTyThg0F0Y8EP1zKnznQQtcThEjny5fLYpm2gR3wKWL0C7OjlhqHmMhLMKdod5CNI
	 V4DDivOkMZPILtG4Z7J0OEMnXCOAGLb7a6Cu+lpFznyQUA80bNcGKSvPZFLZaxlERt
	 lNQM1C/gmRxN5AXACijzURWHW5RZ+HbfIZ1WV/NZMBTNbXWqHFEE4XJPa1lxaJJZWx
	 3f2Mq02VGy67Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 77AF4CF21C5;
	Thu, 11 Apr 2024 02:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1] ethtool: update tsinfo statistics attribute docs
 with correct type
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171280322848.23404.15524534174081611845.git-patchwork-notify@kernel.org>
Date: Thu, 11 Apr 2024 02:40:28 +0000
References: <20240409232520.237613-2-rrameshbabu@nvidia.com>
In-Reply-To: <20240409232520.237613-2-rrameshbabu@nvidia.com>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, pabeni@redhat.com, jacob.e.keller@intel.com,
 vadim.fedorenko@linux.dev

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  9 Apr 2024 16:25:16 -0700 you wrote:
> nla_put_uint can either write a u32 or u64 netlink attribute value. The
> size depends on whether the value can be represented with a u32 or requires
> a u64. Use a uint annotation in various documentation to represent this.
> 
> Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> ---
> 
> [...]

Here is the summary with links:
  - [net-next,v1] ethtool: update tsinfo statistics attribute docs with correct type
    https://git.kernel.org/netdev/net-next/c/65f35aa76c0e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



