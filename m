Return-Path: <netdev+bounces-30625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1698678842F
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 12:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BA392817A7
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 10:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8D2C8EE;
	Fri, 25 Aug 2023 10:00:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BB9C8C4
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 10:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8A4D3C433C9;
	Fri, 25 Aug 2023 10:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692957623;
	bh=7xuqBeBfvbga7rTCOU9+bZ0TdelJLoKR7LjOAzfvw78=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=g1oFgIztbjfCqQ+8tWYSVXK139yVFoUpU6HqVC+54lVXpw1RcFzzOlQZA3qlYx+dz
	 af9y5Ow0qu6KP8iq3Bnzqt0qyVltshqpKn3iakrSAJNRCk4mFI6GBeBrC6pihBpH/G
	 4+Y0bI/S/vfcduCiaQvGhvW1ytK9LokKE/PQhnQwEVUcD30Lw7ebC4ogtR6Z+3wppR
	 g5Q5z6GKhIkblgEOylRZp2BHV0GJthq/h4J5sF4+hFKF+AXQhEeu4ufb5DVrpRogqB
	 /A91Jp87hgPVm3Fy/gSBQodKhi6uPglWexW8EfqBWNcMIT3rvqBpOgapJk9/U+2K1w
	 ctaML+bH0PauQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6F52CC595C5;
	Fri, 25 Aug 2023 10:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] mlxsw: Assorted fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169295762345.416.10292946509871943645.git-patchwork-notify@kernel.org>
Date: Fri, 25 Aug 2023 10:00:23 +0000
References: <cover.1692882702.git.petrm@nvidia.com>
In-Reply-To: <cover.1692882702.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, idosch@nvidia.com,
 jiri@resnulli.us, vadimp@nvidia.com, mlxsw@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 24 Aug 2023 15:43:07 +0200 you wrote:
> This patchset contains several fixes for the mlxsw driver.
> 
> Patch #1 - Fixes buffer size in I2C mailbox buffer.
> Patch #2 - Sets limitation of chunk size in I2C transaction.
> Patch #3 - Fixes module label names based on MTCAP sensor counter
> 
> Vadim Pasternak (3):
>   mlxsw: i2c: Fix chunk size setting in output mailbox buffer
>   mlxsw: i2c: Limit single transaction buffer size
>   mlxsw: core_hwmon: Adjust module label names based on MTCAP sensor
>     counter
> 
> [...]

Here is the summary with links:
  - [net,1/3] mlxsw: i2c: Fix chunk size setting in output mailbox buffer
    https://git.kernel.org/netdev/net/c/146c7c330507
  - [net,2/3] mlxsw: i2c: Limit single transaction buffer size
    https://git.kernel.org/netdev/net/c/d7248f1cc835
  - [net,3/3] mlxsw: core_hwmon: Adjust module label names based on MTCAP sensor counter
    https://git.kernel.org/netdev/net/c/3fc134a07438

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



