Return-Path: <netdev+bounces-30852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B529789352
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 04:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 167622819B2
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 02:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F752659;
	Sat, 26 Aug 2023 02:20:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E7F394
	for <netdev@vger.kernel.org>; Sat, 26 Aug 2023 02:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F60DC433C9;
	Sat, 26 Aug 2023 02:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693016422;
	bh=ydtqHRMBVPGvLaOuoxkDBTXZoeexFhI+9uv5SMycFjw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=o2kvZL/VlidC5ct25daeuKlRuiTTJv1XloGUwu28A3W/ePsz2vnkagwSE9DBkBjxE
	 Pm4E8Vb5EI+QjFkRtG+YTB54x5rZ/xyWmfufqrXpEzs3zeBg4+1VtutHcxWGarHNdo
	 hcf6xeyADqoIwMssUmVEoAqipAf650VASk7LhpIUDsPDItOKSxtK+XxVENWzhuzA/5
	 yZFyKY96qgYD3DsWqUP1d4QQdxluFDoE9zMGQnYo4DOii6PgzGDl22kZNdqZzABZID
	 7dc5VsYd71mswtciOCtbc3gJ93MeiE6MYBH5DR08vwY/zD/G0tuF0QTJrM4oYT3ea4
	 m3/zh5kV9BUmQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 77096C595C5;
	Sat, 26 Aug 2023 02:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3][pull request] Intel Wired LAN Driver Updates
 2023-08-24 (igc, e1000e)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169301642248.20455.15582438799040767630.git-patchwork-notify@kernel.org>
Date: Sat, 26 Aug 2023 02:20:22 +0000
References: <20230824204418.1551093-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20230824204418.1551093-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, sasha.neftin@intel.com

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Thu, 24 Aug 2023 13:44:15 -0700 you wrote:
> This series contains updates to igc and e1000e drivers.
> 
> Vinicius adds support for utilizing multiple PTP registers on igc.
> 
> Sasha reduces interval time for PTM on igc and adds new device support
> on e1000e.
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] igc: Add support for multiple in-flight TX timestamps
    https://git.kernel.org/netdev/net-next/c/3ed247e78911
  - [net-next,2/3] igc: Decrease PTM short interval from 10 us to 1 us
    https://git.kernel.org/netdev/net-next/c/6b8aa753a9f9
  - [net-next,3/3] e1000e: Add support for the next LOM generation
    https://git.kernel.org/netdev/net-next/c/1fe4f45ea461

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



