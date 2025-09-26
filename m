Return-Path: <netdev+bounces-226808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC79BA54FD
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 00:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 935AF1BC3E29
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 22:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA70329E0E7;
	Fri, 26 Sep 2025 22:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwHT7WeU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BABD29C343;
	Fri, 26 Sep 2025 22:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758925229; cv=none; b=W1TRGL+fglU28gcPOm1voFcJBf2aYisQ2nofuXbZn2T1Gwggc2yvHhF54cNkrrImsT+7zB9FPKALCL3i3jJGLN4tLa7IfCKO1DVVWOS9ZXVV4s9KNieQlmJ1JBShgTCtNPmQlkRwGkt/j1b2I43x5sh9WwZKQzbMUf/Bi4pY0LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758925229; c=relaxed/simple;
	bh=0lh+FBpD7SxUWHD4VLefzWfvECsoVn911lKbXf+ZeS0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JDhG7EgdqLc0ouuKN+mClNM8bVABWeeq3p51qQ3gvTPpyZVqrvmUaxFTf5L89eb0vW2gC+eB6ZrP5q2wRiLS2iD1dyhfM1PuMoFdQmfstGXCWCfXre07XpZqUu1+0MbKhbg9C89k08sA5gHGM8K0+3fwt2QLcu/VrMqdtem1fE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qwHT7WeU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01A15C4CEF4;
	Fri, 26 Sep 2025 22:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758925228;
	bh=0lh+FBpD7SxUWHD4VLefzWfvECsoVn911lKbXf+ZeS0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qwHT7WeU1tqyjTWjmSWs+g5N8u995+kqybrS5kbx0thc6PZuGEOV8IQQMouxLeG8d
	 d8QcI10Jt6wRVMQEuOath+HDnaN12IloSG7l05Zhxi/pqGEpQ3OOEV7pGvjCyuIw1W
	 V4RdzZFoNiTZ30S1Spddw2JDyHK50dQf3mnU0KHna+tCM1FUUiEWNBZziM/XujiPx3
	 ETwVMQCuX9LYK0qZUHwQerZobvs75SRGeECoB2sCUKD55HPbSycB8O62IsKVwAC2TY
	 yvdw1yIPMQ9WE6C/pickTzVLf3ydSUEsUWhxTCCKHyWYxujQD9bNNQYhIr03liS3CY
	 lTMubccmwECow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E3539D0C3F;
	Fri, 26 Sep 2025 22:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] dibs: Check correct variable in dibs_init()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175892522299.77570.1577688973517973113.git-patchwork-notify@kernel.org>
Date: Fri, 26 Sep 2025 22:20:22 +0000
References: <aNP-XcrjSUjZAu4a@stanley.mountain>
In-Reply-To: <aNP-XcrjSUjZAu4a@stanley.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: julianr@linux.ibm.com, wintera@linux.ibm.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Sep 2025 17:21:17 +0300 you wrote:
> There is a typo in this code.  It should check "dibs_class" instead of
> "&dibs_class".  Remove the &.
> 
> Fixes: 804737349813 ("dibs: Create class dibs")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/dibs/dibs_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [net-next] dibs: Check correct variable in dibs_init()
    https://git.kernel.org/netdev/net-next/c/231889d9b626

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



