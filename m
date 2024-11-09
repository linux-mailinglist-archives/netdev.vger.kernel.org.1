Return-Path: <netdev+bounces-143545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5974D9C2EEF
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 18:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1790A282295
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 17:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCF31A0BD1;
	Sat,  9 Nov 2024 17:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LN92y7FL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3D61A0B05;
	Sat,  9 Nov 2024 17:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731174628; cv=none; b=uKAYJTgqEf/Tl2geqcTxXtlkodnHTeg9eiqaZ61bCbDn0+YjTgh4NNRMvxFAxCzmOutMKV+r+JDmTKchxq5RqjqsMRSnDO7eYhqoI0h+tSOrJ2fw8outN2wd7gXDWHxqNma2VGhmgdXcszOIvS3+fwnB25UIgbdB2NYBN42vyPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731174628; c=relaxed/simple;
	bh=BqSDgx3rRRPUullizx1fW1wgjhzqtFXnN02Sl9o9nfo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dPOf6E/p/pjBbmzcFmG/go7Lgfq9IuiGyUeGEGOCMBia3Bc6bhtX4QdbJ/hJ+whdtfmysE9WWiNAEpKfw6CN67yufea10/6mwRgtGI4L4JvmqqTL9OcdPQ61BtNYCXElUL7GVsUbl1HUBl2gKFq8vdU//yjDBPsumQlkQE4GoFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LN92y7FL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E1E2C4CED3;
	Sat,  9 Nov 2024 17:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731174628;
	bh=BqSDgx3rRRPUullizx1fW1wgjhzqtFXnN02Sl9o9nfo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LN92y7FLw+9jg8BzPq2rNV/yMqyXsgyD1YqadLVeq2Ow99mNm9GV0lpJir4Ce74oQ
	 dPrKxfbLYLLFByBoa45rq9wqlDAwWI5ut2dJgN7Zz9SNRlyctYQa2wGg5XaCAca48P
	 pBe1uFkO72e6RxH+qo4JIRNkzkESkeh2aWwXT1FwK3dY9tHqOgU8InRjG5PU0zkqSb
	 +JgTUQYNZK7BKCPOrYpmPsJiN272MxLHNuQxk7eIf0flDkXr54MvQr2tQn/pn63EuR
	 wrGcuJ8IJZySf+hsMFf9HwNbCZvDiVG41N7SFtGUCsFZkt56x4tNJAaoUntrc+f7BZ
	 0mqCVD9MNZksA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0353809A80;
	Sat,  9 Nov 2024 17:50:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] mptcp: remove the redundant assignment of 'new_ctx->tcp_sock'
 in subflow_ulp_clone()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173117463774.2982634.14877671745218810649.git-patchwork-notify@kernel.org>
Date: Sat, 09 Nov 2024 17:50:37 +0000
References: <20241106071035.2591-1-moyuanhao3676@163.com>
In-Reply-To: <20241106071035.2591-1-moyuanhao3676@163.com>
To: MoYuanhao <moyuanhao3676@163.com>
Cc: matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  6 Nov 2024 15:10:35 +0800 you wrote:
> The variable has already been assigned in the subflow_create_ctx(),
> So we don't need to reassign this variable in the subflow_ulp_clone().
> 
> Signed-off-by: MoYuanhao <moyuanhao3676@163.com>
> ---
>  net/mptcp/subflow.c | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - mptcp: remove the redundant assignment of 'new_ctx->tcp_sock' in subflow_ulp_clone()
    https://git.kernel.org/netdev/net-next/c/7d28f4fc868c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



