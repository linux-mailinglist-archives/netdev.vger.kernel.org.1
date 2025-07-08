Return-Path: <netdev+bounces-204768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01850AFC048
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 04:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27CEE189D657
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 02:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE89D21931C;
	Tue,  8 Jul 2025 01:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LbIRtuw+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA29B218ACA
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 01:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751939996; cv=none; b=YH88Mi/DgClP/ySHJaZ7zGOPyVe8Lfcqd21AlrOkCwY1Z20FGLleX8U9PUW+6M6bGxtcStFdPztVVfFI5Q+2Q+gK2VJJ+uuvGhS+BCI+5qjjGLWR35LM8GEqtvIEsPDvc19fWou5a2c8pF/I5MJsC9jzcxWaWrJ0xglipp3yMhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751939996; c=relaxed/simple;
	bh=TuubnkDhftYWxL6/0sRYBtoF7s7ev/w6dsdzDp9Tth4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GIZbUXAEd3KwcwRkT+BN7zfycuIn+YiMrdBJr1bRkeNJuuXGs3psE5tmsuIM5fiDiYv7QDMqI+7GqS/4xvDDtza/qnCX+sEQKI/5x8uZZ5nBPOVi+rw6JAUJcHpvKqw6HvYjRrsJQzbkjGav+iN0C5shUW8UiCza3fK+PBBNBQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LbIRtuw+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29535C4CEF4;
	Tue,  8 Jul 2025 01:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751939996;
	bh=TuubnkDhftYWxL6/0sRYBtoF7s7ev/w6dsdzDp9Tth4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LbIRtuw+0Mb2Eas2E/mMzvjAWlVXniOSTmDjQseQK1NrUtJypEqi99MHpXXmSqTKt
	 iUZZAfK8AaV5SjRfMyW8EeZvnLcog/CNGYfWxGFHLL4HvglpFfF6/mktBq2oEa7r2C
	 k5PaNKDvZzzU9vDkp1MGhyj7xzU93rJP+Y2AbeuIvaXoEHNP8DL1toLPxVTBV08bD0
	 u9cGvV+247l0kS90dHS710qoNWb2Pt4eanqx0ZGYVtjSKDUIaZRqECtS0OW1/xkMEE
	 1zoxbZeZPnSXXRix0Hsc9038a1E19tThcLekqEd7GzO+LpDrGHGlYKvuD3kNcfC0hu
	 Qa2LPlvFFar5w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BFD38111DD;
	Tue,  8 Jul 2025 02:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] net: remove RTNL use for
 /proc/sys/net/core/rps_default_mask
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175194001901.3541197.13780733522193768438.git-patchwork-notify@kernel.org>
Date: Tue, 08 Jul 2025 02:00:19 +0000
References: <20250702061558.1585870-1-edumazet@google.com>
In-Reply-To: <20250702061558.1585870-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, kuniyu@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  2 Jul 2025 06:15:58 +0000 you wrote:
> Use a dedicated mutex instead.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
> v2: addressed Jakub feedback
> v1: https://lore.kernel.org/netdev/20250627130839.4082270-1-edumazet@google.com/
> 
> [...]

Here is the summary with links:
  - [v2,net-next] net: remove RTNL use for /proc/sys/net/core/rps_default_mask
    https://git.kernel.org/netdev/net-next/c/6058099da5e5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



