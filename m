Return-Path: <netdev+bounces-239358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B57CBC672FD
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 04:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9C2CC4E12D8
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 03:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2A42D0631;
	Tue, 18 Nov 2025 03:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DB4bd4mX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885111EB5C2
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 03:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763437841; cv=none; b=Az4zn+obsyIjuG/xBizDftq1HD3IUy5IN8J6i7GQnf6cEOwOAW/uKJntwXhKVZK2Pk66s5uLiLSsB5/ibFYVdliEXlUXP1qJkXr5JCQBO0RW9nQ2IUQ5seWeVp5HtFELZjrIgLmTss0py1iUuyQlDTe3eGJifZ73ilpiOhxa2gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763437841; c=relaxed/simple;
	bh=gWqwlbJ3QnFexv2PTe0fEhEOco+COc6eoZb5q1GfFf8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gP5srHvNq34DcAXo9CsRmgQyUppqOGpEsxW7aLyUMfo0KIyBPUFFHBi31dWG9ve+KAamnks/zu7EneOjmP5+wOGwl/3M+fUYvhqVIg/M4xmTp04v8yZKHAodDLQYvZltHNNvXqJUHtuZvL0zvjfoAcjZqWCIce1QBiic6vCM/Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DB4bd4mX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B5BC116B1;
	Tue, 18 Nov 2025 03:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763437840;
	bh=gWqwlbJ3QnFexv2PTe0fEhEOco+COc6eoZb5q1GfFf8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DB4bd4mXtEDs0hoauxAcbGxO6c9/3+c0BD/UnFZOrckrbnhpBqx6vXK9yVs87uuOH
	 EjFYFqJqWX10hyov4ydKVwBVv34xv9A/6G/362uAn9fHiHpW/jo6B4ev+6JKCNpuAU
	 FmkQbLUVwyU6DJ5pVgealb0m3B/PQSJzCvm8APDHoKfS4A2q62HLsEYd7ZXmI4xg+U
	 zE69ePaTxyiCwsvjKcqND59s+btBGaxNJi6DZaeaC4GrXbj1k1AshfVOfrNUPOTAds
	 192AFSju0FAf7gjw0s2HQCRBvTKc+9wtIsRAZJrg+qgjw1KbFyZh7ykc5GfNtqzVr9
	 +EZ+GjhRqUiRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEB03809A1D;
	Tue, 18 Nov 2025 03:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: net: lib: Do not overwrite error messages
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176343780651.3575942.2866332066219229124.git-patchwork-notify@kernel.org>
Date: Tue, 18 Nov 2025 03:50:06 +0000
References: <20251116081029.69112-1-idosch@nvidia.com>
In-Reply-To: <20251116081029.69112-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 16 Nov 2025 10:10:29 +0200 you wrote:
> ret_set_ksft_status() calls ksft_status_merge() with the current return
> status and the last one. It treats a non-zero return code from
> ksft_status_merge() as an indication that the return status was
> overwritten by the last one and therefore overwrites the return message
> with the last one.
> 
> Currently, ksft_status_merge() returns a non-zero return code even if
> the current return status and the last one are equal. This results in
> return messages being overwritten which is counter-productive since we
> are more interested in the first failure message and not the last one.
> 
> [...]

Here is the summary with links:
  - [net] selftests: net: lib: Do not overwrite error messages
    https://git.kernel.org/netdev/net/c/bed22c7b90af

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



