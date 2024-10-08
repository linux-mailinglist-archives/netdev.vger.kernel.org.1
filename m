Return-Path: <netdev+bounces-133189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E853C99543F
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 18:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCDA61C23DB2
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 16:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B871E0DBB;
	Tue,  8 Oct 2024 16:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYIAgG+o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334811E0DB5
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 16:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728404427; cv=none; b=ZwEzweO4LKK2FdgrO2xS9DWXW18cOPPH9x6icpTYw7v8SEd/ubg+7djFS60YgDLEfL3U80+iWudSjT2NOg71m8QOHXsHVzRc4vugLk4ddd6VdGfAkMHtBbK+8DnOc/cdl9hl7cOE+FwTSxS8l4Vx9BGbRO/ULMdaAkoSmX3sCxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728404427; c=relaxed/simple;
	bh=oxQvGk/AtVpkpa0LB++Qk8A37SxKyJsKseNNtT4e+/A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=B0Ol6zctzoMBznR3a7OoLYtiKf7X3lVwAH6tQFKINupJ0mgDKNseXE5obs+pejx4nJEf1GD0HWIv7Q9NcA/aMHe3l8IHAHC8N03Mov2HzkzfrHHyAUK8kAIOCz/Roi+go3xKRFM+C6JlJsdKT5D4L/YicRMSp/1Zkr7lAfdZEuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYIAgG+o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1923C4CEC7;
	Tue,  8 Oct 2024 16:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728404426;
	bh=oxQvGk/AtVpkpa0LB++Qk8A37SxKyJsKseNNtT4e+/A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XYIAgG+owxKdao2UtAtGzavRaMSS+D6KpuLM5jDVwfL8Tk7kb1F5puJ5cuMcbQh/Y
	 hpBi4aUevGMTB78dQpgG/iYfShfXYdyzvEjlJlo9KCAU9cfI5Av2kBrEdcdnnsXx5/
	 26oNHw/sF8QOW07bUD2102GyY+T+kfBggWE3uQJgenbM6jVq3SfbI8r9il2KnUlcAK
	 Ohw5xH7AnjQWpWNMai02Nh1RxGyNzJB4SD3YfSMwFjvHccRhuJLRxBzL/YSfY2uKn5
	 cI+s3g2yPerWVFkPuZ+tbhULboVpmmbVque9opEh6uti5sMfYrfVrPm1ZjX4rhBHmS
	 +YXi7g2CAbMNA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 348453810938;
	Tue,  8 Oct 2024 16:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute] netem: swap transposed calloc args
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172840443074.601483.11645951076597821309.git-patchwork-notify@kernel.org>
Date: Tue, 08 Oct 2024 16:20:30 +0000
References: <20241007163812.499944-1-stephen@networkplumber.org>
In-Reply-To: <20241007163812.499944-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Mon,  7 Oct 2024 09:38:04 -0700 you wrote:
> Gcc with -Wextra complains about transposed args to calloc
> in netem.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  tc/q_netem.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [iproute] netem: swap transposed calloc args
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=95f4021b4865

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



