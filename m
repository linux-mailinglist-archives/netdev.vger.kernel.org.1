Return-Path: <netdev+bounces-71143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C053852714
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 02:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 147A1B2A90F
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 01:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F157E1EF13;
	Tue, 13 Feb 2024 01:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+k2iObi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3DB1D688
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 01:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707788426; cv=none; b=YZrWbNp2wEIq/KeAiNdoJH9hwQWbEML7ipW7LH+iyaki73a96Q4s+w5GI+V3+7OPTK3mVRoBLxxp8whSk2kPEExNf8WfD72XogK4QkQ442B79nbh7MIlYn+dRYYjBWdkswpnNhm15mW+xIahrwWm0G3vDwijNKluUo2FsNN8Nmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707788426; c=relaxed/simple;
	bh=gZm94rOcjc+53sifIr8KM4xgD9bobTD7mzi7BsORG6U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=T/RPudv0Lwu4pDusPzZyrQa69ilcS6Z2PeFawOerm7yXWlkBi3tqxZbBGTRqEjdv0Y0vRR6CL5OvWlKAFg/p4ka6sEW49MqeirNfgAf7QEuQdi3svZgPHqu7zUGVFGgUihhmRBrVHvHkIZ1W9BsxrBYuLr0Vyh6kDPiey/KM12c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+k2iObi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4135BC433F1;
	Tue, 13 Feb 2024 01:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707788426;
	bh=gZm94rOcjc+53sifIr8KM4xgD9bobTD7mzi7BsORG6U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=i+k2iObiCuEdks1hIxO3FNiv/PNSB717nWiSOgOzO8TJcDwJ02imewG+Rcgo50TkT
	 vPGYUJxtYBgMjR/4NzZsKsEOnu69kEriYLzjFTjXlTVD2tX0pM4rx+lgS64t+NkIr9
	 pwfJHHCO1dXdMJzXMeBIm+BskdoqUh94JG64nhH5tuyg+g7WgQ7tz3Rg1Fy+CsbgSX
	 ft2/MD8oSmEP0bPqG7Es7yL3zmVQjWWu/G524hWWPNlbxzTxpNSYtrI+30OzK+zV97
	 W1JEdCZyqVICA/ZbB3wEhbclVzQNIMGYWL9OTif/o995q4NjgZRvsiuCzbz1BUXcOg
	 NqW+1iWEeULrQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 21586D84BD0;
	Tue, 13 Feb 2024 01:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] ionic: minimal work with 0 budget
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170778842613.15795.13754153243973570855.git-patchwork-notify@kernel.org>
Date: Tue, 13 Feb 2024 01:40:26 +0000
References: <20240210001307.48450-1-shannon.nelson@amd.com>
In-Reply-To: <20240210001307.48450-1-shannon.nelson@amd.com>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, brett.creeley@amd.com,
 drivers@pensando.io

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 9 Feb 2024 16:13:07 -0800 you wrote:
> We should be doing as little as possible besides freeing Tx
> space when our napi routines are called with budget of 0, so
> jump out before doing anything besides Tx cleaning.
> 
> See commit afbed3f74830 ("net/mlx5e: do as little as possible in napi poll when budget is 0")
> for more info.
> 
> [...]

Here is the summary with links:
  - [v2,net] ionic: minimal work with 0 budget
    https://git.kernel.org/netdev/net/c/2f74258d997c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



