Return-Path: <netdev+bounces-26686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5015778960
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 11:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21B651C21334
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 09:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DD9568D;
	Fri, 11 Aug 2023 09:00:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C87753B2
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 09:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7AF07C433CB;
	Fri, 11 Aug 2023 09:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691744424;
	bh=MTPtbImRSDiDQ9iz3Dhc9omtbXud8FvkvxRZfpFR/7s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Zw7mJV9TflqvWK8DekbF1mqhD98Oi0Tf9niwMnI+7nYjRh34rUzr6L+yWgnQIvUsG
	 C/KmMCZksY9CzmrGWJw1cBWZxkOqiZ21e1jm6XBZd7jbtWxxhTS8AruEO76BBW4v6n
	 svmaMDFq1+0qNoCmpXhfIPX4vi5oO8zTwfqw1lEHWyZvID3jFjUTVHA5dz+98e/rJH
	 RV+6HwJVKixLkGA4NocZt3YP0YwfWXfDoAsrPWaP9yv6dyAEP82FAbIMA3KHqX8DjA
	 vD2dXXL4NAmM1v3cXgWxXdV77LoSTt+r/3atiHTbVrWyGs1myR1wJMHT+TKm85/Q+R
	 7/fRVLdH7FJyg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 64713E1CF31;
	Fri, 11 Aug 2023 09:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH v3] octeon_ep: Add control plane host and firmware
 versions.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169174442440.10902.15244631640819475211.git-patchwork-notify@kernel.org>
Date: Fri, 11 Aug 2023 09:00:24 +0000
References: <20230809112933.716736-1-sedara@marvell.com>
In-Reply-To: <20230809112933.716736-1-sedara@marvell.com>
To: Sathesh Edara <sedara@marvell.com>
Cc: linux-kernel@vger.kernel.org, sburla@marvell.com, vburru@marvell.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, hgani@marvell.com, andrew@lunn.ch

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 9 Aug 2023 04:29:33 -0700 you wrote:
> Implement control plane mailbox versions for host and firmware.
> Versions are published in info area of control mailbox bar4
> memory structure.Firmware will publish minimum and maximum
> supported versions.Control plane mailbox apis will check for
> firmware version before sending any control commands to firmware.
> Notifications from firmware will similarly be checked for host
> version compatibility.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] octeon_ep: Add control plane host and firmware versions.
    https://git.kernel.org/netdev/net-next/c/a20b4c5f3a0e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



