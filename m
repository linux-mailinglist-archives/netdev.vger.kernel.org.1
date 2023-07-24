Return-Path: <netdev+bounces-20596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CEE76033F
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 01:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA3D2281354
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 23:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72879134A1;
	Mon, 24 Jul 2023 23:40:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D85C125D6
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 23:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8E29DC433C8;
	Mon, 24 Jul 2023 23:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690242019;
	bh=ZagSX846/VB+56WNwmLCa6W0VYBLzVVWnPbapOXzXkU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DkWalFaq28neAAlCnl5bdxjr0sMKVGsGJoHRTRqIC7BUc7vymJkBoEYzPZrnq/zjv
	 KUzjTX6Y4JrrYbp0uQNZ3+K4hQ8MzfrEJ2+byHL7+cf8lxmsvX8k3yUx6L+sgVf0oF
	 RxvFcx65G2B3C0vJ68njxNqq3jDSfx1k6pjzgEZ7MaRIMq5f4so93OolVgBZNsn2kk
	 LpNVRIsnFBJGywT2JSCZmEDJ1O37hRXLSyqsZWX+B1wGhPrCX2ontvNvT8SyCaQqAd
	 TBf57oS2PRLMi6fe/huXG9++Fx1NA0lJqkBmZqPL/gpa9zaNCxasWzMTqZtIHI4lAJ
	 UKjs1iwhgfMAA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 724E7E21EDD;
	Mon, 24 Jul 2023 23:40:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/2] netconsole: Use sysfs_emit() instead of
 snprintf()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169024201946.28598.11174713234443035562.git-patchwork-notify@kernel.org>
Date: Mon, 24 Jul 2023 23:40:19 +0000
References: <20230721092146.4036622-1-leitao@debian.org>
In-Reply-To: <20230721092146.4036622-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, leit@meta.com, pmladek@suse.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 21 Jul 2023 02:21:44 -0700 you wrote:
> According to the sysfs.rst documentation, _show() functions should only
> use sysfs_emit() instead of snprintf().
> 
> Since snprintf() shouldn't be used in the sysfs _show() path, replace it
> by sysfs_emit().
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] netconsole: Use sysfs_emit() instead of snprintf()
    https://git.kernel.org/netdev/net-next/c/9f64b6e459d3
  - [net-next,2/2] netconsole: Use kstrtobool() instead of kstrtoint()
    https://git.kernel.org/netdev/net-next/c/004a04b97bbc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



