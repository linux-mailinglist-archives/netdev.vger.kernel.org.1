Return-Path: <netdev+bounces-188186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7280AAB820
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 08:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C71E3AF344
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 06:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B9628C5CF;
	Tue,  6 May 2025 01:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFbcGhKI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA25312819
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 23:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746489044; cv=none; b=E5HRJMCLKhQ/oMRWYo5IKPq+N06qhW0NZUTJJ2rGjjBqEJyck33W9pk/o4FI4IjML7sd/YKI63aZYFaFKLq5h1A/KrrG1LGOSAJz9ij3CCYYYWqmBrQwYaSiPkN7H0TRmC6RGRfPrKTqKSJ5ldGsiK0klrmwYAGVZvTKGWm8NKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746489044; c=relaxed/simple;
	bh=Imvs25kNyD3wbRL8FIIKi8JHDwJ1XTQgKqj9YAt0RsQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XpkTfWf0MjObVuCTEgJfMeYcFCs2NukwF1EpBwS/pGlN20CGTtOxcL/Ie/6Y/VmJHk+JEwhib1mKGhwIg6SXOWKxluHrB09y4gS81DuWqLia8CEHlCliGqH2x68zTJMfBZdJGVnNLEmPQ7C9wn/RjX4Xs0zsJt7GrsKiG0MdndE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFbcGhKI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7854EC4CEE4;
	Mon,  5 May 2025 23:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746489042;
	bh=Imvs25kNyD3wbRL8FIIKi8JHDwJ1XTQgKqj9YAt0RsQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TFbcGhKIS1spVbUgOrTyJZORk1R5t7ss5dGQwpDCbYNIB7T0QhIYNt/3N8dNV1ya9
	 1EAGvVI4EbJ0TJiHATf4ANrfLZQjnXjBKYDOrDMfbSMH/ibr/1KFLcXXiakyTRiUdE
	 YeldDxxGBwgm9lTSIQE1kvtmireRM99RqV+Vx1Z05edwvAPejkWARUlf873Ywz8Sx9
	 8hSvYZ/U64MNg9QuJCAmvu1v/FJ1J58U5Jrm/4BRoyUZH5wr+xrkpmaWuCKEVeoQPW
	 pE5+KrgGcffBh9kJWPT5IxMXImAz0ozfbIkODbjHJ4Ral4YP1DLtVVKPWTqCUH/V3B
	 rE44Es4keETlg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD23380CFD9;
	Mon,  5 May 2025 23:51:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Patch net 0/2] net_sched: fix a regression in sch_htb
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174648908149.967302.17523654895263433591.git-patchwork-notify@kernel.org>
Date: Mon, 05 May 2025 23:51:21 +0000
References: <20250428232955.1740419-1-xiyou.wangcong@gmail.com>
In-Reply-To: <20250428232955.1740419-1-xiyou.wangcong@gmail.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
 alan@wylie.me.uk

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 28 Apr 2025 16:29:53 -0700 you wrote:
> This patchset contains a fix for the regression reported by Alan and a
> selftest to cover that case. Please see each patch description for more
> details.
> 
> ---
> 
> Cong Wang (2):
>   sch_htb: make htb_deactivate() idempotent
>   selftests/tc-testing: Add a test case to cover basic HTB+FQ_CODEL case
> 
> [...]

Here is the summary with links:
  - [net,1/2] sch_htb: make htb_deactivate() idempotent
    https://git.kernel.org/netdev/net/c/376947861013
  - [net,2/2] selftests/tc-testing: Add a test case to cover basic HTB+FQ_CODEL case
    https://git.kernel.org/netdev/net/c/63890286f557

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



