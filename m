Return-Path: <netdev+bounces-200077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5BAAE30E4
	for <lists+netdev@lfdr.de>; Sun, 22 Jun 2025 18:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C57216E26E
	for <lists+netdev@lfdr.de>; Sun, 22 Jun 2025 16:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C2C1E376C;
	Sun, 22 Jun 2025 16:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kqb16c5R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDA535953
	for <netdev@vger.kernel.org>; Sun, 22 Jun 2025 16:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750611579; cv=none; b=V0U/tGzAie+Dc0LMKg4yWBAqlxZlt5JDir5PDaBsfJlraicgmu4H7IDXAfAgY4CjOjoo87EZd8XT8vlk/tRYJYS0PbvkxsRmyq53zogOCGo/b9G88QZKp5uJJOIR4yYG2SQTuW+EnCwWdeNLbDUvi7sAg1nCIRQWOCVGd3ebdP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750611579; c=relaxed/simple;
	bh=ERZxHJgHP2M5LfsR3wHgCjJcw6ul31IKfxPqlBuXJdw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=krxJo7HnihrmWK4oSqNBQsg8BnEPCDlla2cKTAtsZjNdJesXdLLsmD5yVtveePUArxX4mrSUF5zyPHi0hbvWjuiPCLVj1QUenRqEgsn/lHtTVbQfSyBDvszxJ/oOM5DXRASsYJz7PexDPTZsxUVaqAiZyrnAEtPH/d1z1tkeWgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kqb16c5R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D273AC4CEE3;
	Sun, 22 Jun 2025 16:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750611578;
	bh=ERZxHJgHP2M5LfsR3wHgCjJcw6ul31IKfxPqlBuXJdw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Kqb16c5RsWJ1vu9iGQGRZEQ8wNNCUWu9lXB1/ZxmdkI0VeEbzL8dRpDL5yuC4FYuB
	 9k/dzzK2a1H29BV2va1xfXYk6oAR1GQlCIP215vXtT80SwjoNlqO8QyHNNMqiQzLKp
	 mbdDT+/Wy4XLiz5vZSj+DBk7OJMBnzfRr5nb8Ew+RL6tQ5Uby3t7+5/8k4wgZ2gTEs
	 shdp77xvwm5FlUdwcoMPaupUWaP79UaUKrILrD9ZA9XdFOZm82snPQmVYLjhyuUSi+
	 +EILwctppK1ZHVAoh7UgDuFYYj6JW37afDUpmIoA1T2HpxmQosHBtCqfFA8gS7ixcs
	 1xpb20+Uih2bw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BCC39FEB77;
	Sun, 22 Jun 2025 17:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next] ip: VXLAN: Add support for
 IFLA_VXLAN_MC_ROUTE
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175061160625.2104780.3165956777441095941.git-patchwork-notify@kernel.org>
Date: Sun, 22 Jun 2025 17:00:06 +0000
References: 
 <14b0000cd0f10a03841ce62c40501a2dc1df2bc4.1750259118.git.petrm@nvidia.com>
In-Reply-To: 
 <14b0000cd0f10a03841ce62c40501a2dc1df2bc4.1750259118.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: dsahern@gmail.com, netdev@vger.kernel.org, idosch@nvidia.com

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Wed, 18 Jun 2025 17:44:43 +0200 you wrote:
> The flag controls whether underlay packets should be MC-routed or (default)
> sent to the indicated physical netdevice.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
>  ip/iplink_vxlan.c     | 10 ++++++++++
>  man/man8/ip-link.8.in | 10 ++++++++++
>  2 files changed, 20 insertions(+)

Here is the summary with links:
  - [iproute2-next] ip: VXLAN: Add support for IFLA_VXLAN_MC_ROUTE
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=633144499523

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



