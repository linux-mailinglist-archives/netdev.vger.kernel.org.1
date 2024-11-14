Return-Path: <netdev+bounces-144828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BA49C8895
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 12:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03A51B2529F
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 10:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440F01F77B8;
	Thu, 14 Nov 2024 10:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vEv7v7Lz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2F91D95A1
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 10:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731581418; cv=none; b=a5je488Pn1KqohA83J0/9UdCwoGpjBX+wR7DWE1vTFZk7xYcSk6b4LxUcUT9d2iFP/SiaL8uOkTgH86WBYD5QoIa1dPws4Yk6lIpaTmny2k7719tPFzOBWBxgVu10s4gNgD2ZZkVAfgp3k1Lp81cLT//CKtLq2JSvSbqe5f2JUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731581418; c=relaxed/simple;
	bh=eI2hABARqnIpAlWnV5hOCtmJWGJIMjlflKOZcAk4hW4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RyanJoMKTEqT22lDJXM8NA7ZvSBXn4yiyYzdeB5jMeQSLvfUd5WPywERDxxJz7zwnK5sNrD7MnzY7/wh4laTTAiULGxV6Od7UYTj5taQ27Q5Dkrof/e167Rzy9K+iTgjpxOeDSQPk84G/LsMBYlXi1WcWNUN0Ecy4EpS8y52exg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vEv7v7Lz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3786C4CECD;
	Thu, 14 Nov 2024 10:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731581417;
	bh=eI2hABARqnIpAlWnV5hOCtmJWGJIMjlflKOZcAk4hW4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vEv7v7LzHWzVSAAO3SrO4ZrjeEPdEagpXld7HA5tCopHWrVxenOCiIN6W4j9xZ9oE
	 rFwJl/MbpYAEAsJEfhc4TpqqcGAOMjRVrrcSSO4Pfq9ooimMsAh+qJxU+aFc5vifzS
	 AIF0GS8go/emPYlZTOVS2lzZqr7mUJblDUpQNcqzC8bU/37cmp61x5GzFQQb+V5GJh
	 hWqulYmaFCH3QZmm9a7U1DKe8tQ2yuIBpcJlirz48q4E/aFz4BpEvoDVsEYw3RJBra
	 NNXqQwPNkpaqE7oKJK70h6Nrp+4ZhCA4z9jICvP66kRI9srPqwnrL5PGzqEu1NQA4k
	 PIGXiF3y3Q4hw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7100C3809A80;
	Thu, 14 Nov 2024 10:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: sched: u32: Add test case for systematic hnode IDR
 leaks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173158142826.1878093.3534954441382318562.git-patchwork-notify@kernel.org>
Date: Thu, 14 Nov 2024 10:50:28 +0000
References: <20241113100428.360460-1-alexandre.ferrieux@orange.com>
In-Reply-To: <20241113100428.360460-1-alexandre.ferrieux@orange.com>
To: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
Cc: edumazet@google.com, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, horms@kernel.org, alexandre.ferrieux@orange.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 13 Nov 2024 11:04:28 +0100 you wrote:
> Add a tdc test case to exercise the just-fixed systematic leak of
> IDR entries in u32 hnode disposal. Given the IDR in question is
> confined to the range [1..0x7FF], it is sufficient to create/delete
> the same filter 2048 times to fill it up and get a nonzero exit
> status from "tc filter add".
> 
> Signed-off-by: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
> 
> [...]

Here is the summary with links:
  - [net] net: sched: u32: Add test case for systematic hnode IDR leaks
    https://git.kernel.org/netdev/net/c/ca34aceb322b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



