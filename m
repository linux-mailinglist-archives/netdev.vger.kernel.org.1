Return-Path: <netdev+bounces-112002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E9D9347A2
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 07:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EBB9B21983
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 05:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CD643172;
	Thu, 18 Jul 2024 05:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0c4OBMo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F8F3BB30
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 05:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721280632; cv=none; b=A3Y3c5VTVXIuMkoXRVmQJmm5cbGDm0PrnTV8cUjzDSoVuYKZzwu8NEvJUAHYtc+8MNnhqmcrMrRxRRZEmCwPe268xGxKke3CfmYPnKbEPpPaWebIhFqTc7i1P5BkqqLDmSH4TmXqkkYdjqHX7ijIGXogvi6U/q8FJ6ZI/vLjzE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721280632; c=relaxed/simple;
	bh=4cQgv4qBIOo+6Fvoh75w/bjOepa4qDCeaaX7guILOEk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lTikwqH80rVDVwrjnmaCPavlMjCZQznlzPvD4oWW98k/ZRpgH9KpmHNmvNtrwKaZl6QBRhCSGBfXulJzm96HFAC8PxWF5Ky8mC2qmaxlo8Mg4982FwRhWXjcXcYADW2Gw1qlmRzwS+JdXAOqIfHbrjxkuchzPXrwOFJ87/IV7f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A0c4OBMo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 59AD8C4AF0C;
	Thu, 18 Jul 2024 05:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721280632;
	bh=4cQgv4qBIOo+6Fvoh75w/bjOepa4qDCeaaX7guILOEk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=A0c4OBMoMQmwQSJPQPQSmlIVBGgB9r1DHA4jyZYEF7N2ChHLexIG7d/eKI2SNApHv
	 /fQLQYPfRrO0OivxgkpII2As4GkrPyxq2UlpXkGYTV3xnZI6liCMbngS6ryPBgzE9u
	 YgavTNO0eKBkxyd1izMr1mL1xFzZELLtNJ7cae0eULphcZGqjallinFaNS2nYDtso8
	 RJRkJMICUrnriqxqEdY9RfRHQQxPbsBupwHPfKpMoKW1pq02aARtLzpPaW5UXuIc0V
	 /cisZvFrvayLy1Ruyys2vi0DKICj9dPK3pjZn8QPxnsOIWKIG6O7+BhGjaaGED6znp
	 +YU7dYphG/0sw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 41EACC433E9;
	Thu, 18 Jul 2024 05:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] driver core: auxiliary bus: Fix documentation of
 auxiliary_device
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172128063226.29494.18156508760229241411.git-patchwork-notify@kernel.org>
Date: Thu, 18 Jul 2024 05:30:32 +0000
References: <20240717172916.595808-1-saeed@kernel.org>
In-Reply-To: <20240717172916.595808-1-saeed@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, saeedm@nvidia.com, netdev@vger.kernel.org,
 tariqt@nvidia.com, gal@nvidia.com, leonro@nvidia.com, shayd@nvidia.com,
 sfr@canb.auug.org.au

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 17 Jul 2024 10:29:16 -0700 you wrote:
> From: Shay Drory <shayd@nvidia.com>
> 
> Fix the documentation of the below field of struct auxiliary_device
> 
> include/linux/auxiliary_bus.h:150: warning: Function parameter or struct member 'sysfs' not described in 'auxiliary_device'
> include/linux/auxiliary_bus.h:150: warning: Excess struct member 'irqs' description in 'auxiliary_device'
> include/linux/auxiliary_bus.h:150: warning: Excess struct member 'lock' description in 'auxiliary_device'
> include/linux/auxiliary_bus.h:150: warning: Excess struct member 'irq_dir_exists' description in 'auxiliary_device'
> 
> [...]

Here is the summary with links:
  - [net-next] driver core: auxiliary bus: Fix documentation of auxiliary_device
    https://git.kernel.org/netdev/net/c/c14112a5574f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



