Return-Path: <netdev+bounces-71412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8C785338D
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 15:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 800D81F29C0B
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 14:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C32D58122;
	Tue, 13 Feb 2024 14:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VF7dZcBw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385CD58106
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 14:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707835829; cv=none; b=E1rgZ7noc/Pv42UVDSud1QDNx/qpHAXe0rNpNRuaD1gW9MWga0qAj7WMuDDVEM/UYJzQ9QE9wzIm1A5ggBgiBtO8Q4FWflVIVoEnyWh08A6hcg7iU8tzhCdesqAWG6pAuqLtrfk6XXlP5P6xFP5hIlpnmPdyB00k/n4yqQPENc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707835829; c=relaxed/simple;
	bh=nuwDpzpgnkVRucjebBeLIw8GNzbznDyRtCOGK5Bhf0I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IM8e4972QBJx8RWn6IiyvxcOFOMsFiPL7G7ysV6LTH/1oCii/pQNovMLOao8Jx2+66M9rKFOB7yZC7jfQ6N4VU0HiqPgbloJmB8q4piT3JOWZwr7nYqML/Ou+F1pg5gAc6A3IB7FG8wKFL1djfgvom+vlqjvMpdfp1Va+DI4yM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VF7dZcBw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B42D0C43390;
	Tue, 13 Feb 2024 14:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707835828;
	bh=nuwDpzpgnkVRucjebBeLIw8GNzbznDyRtCOGK5Bhf0I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VF7dZcBwKHSiSK2XJq2XS/3ts4/CI9xfL1zUm2oabvc+n/3Y8Kxw3OLMyYPIyg+Yd
	 quyEXtWNlTkVzKeqv/pwTI5nyo9mN/paXGNPcZu03V08kWEPCpzsUCsfV10IK+OJyU
	 rDvenOTIHDeo2nyaxDPZoOL9Mn5h4An6xFne1cqS53/WkvR+J1IALg2hZuVk9SnMir
	 hPh3UliOpM2/pNo8lvKgtNwmk4lallawunXAzYbdyd9LEZBaJTs0G0f9l0ZqzFwPIo
	 khb0WjcLoFNRowUA2h+mv57xH8FEWr9+VeHgnbzMHSfxttCZ0rl7DRd9RyJ8CJ7wrc
	 aLWpWlFfD/BmA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9AD8CC1614E;
	Tue, 13 Feb 2024 14:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: sched: codel replace GPLv2/BSD boilerplate
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170783582862.26385.121428605620155999.git-patchwork-notify@kernel.org>
Date: Tue, 13 Feb 2024 14:50:28 +0000
References: <20240211172532.6568-1-stephen@networkplumber.org>
In-Reply-To: <20240211172532.6568-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, dave.taht@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 11 Feb 2024 09:24:55 -0800 you wrote:
> The prologue to codel is using BSD-3 clause and GPL-2 boiler plate
> language. Replace it by using SPDX. The automated treewide scan in
> commit d2912cb15bdd ("treewide: Replace GPLv2 boilerplate/reference with
> SPDX - rule 500") did not pickup dual licensed code.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> Acked-by: Dave Taht <dave.taht@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: sched: codel replace GPLv2/BSD boilerplate
    https://git.kernel.org/netdev/net-next/c/32c7eec21c11

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



