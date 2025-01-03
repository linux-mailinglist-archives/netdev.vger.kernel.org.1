Return-Path: <netdev+bounces-154862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCADA00243
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 02:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EDC11884005
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 01:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEC517B402;
	Fri,  3 Jan 2025 01:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QoqX9BLo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D3F167DB7;
	Fri,  3 Jan 2025 01:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735867214; cv=none; b=caT9E2DL2XCCSZbNlQ0CKMO8S9d9ANDCroPC0n827ndC/iEARtrC5iUAn4ZVPBlLR6birhLsGokXBChfv1calNcsngtKcnOvej6/ABGyZwFbLi7Zx8X9iX+a6rzwwUF/8w1Cj8ITakiMmEa/tO72n/cdNVa3B14QTIKp3SnYt7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735867214; c=relaxed/simple;
	bh=xZaqeBv5CKoQskEwFuSdPNq6XCDw5DNB6VQwSzCRljk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KppBxuXAi77f86QZlX/uBNLGTtCqD1VVffdEq4UgI3/zO1Sqkvw1cuNSGPYiQUBidt1nUDGY/JwoYFen9i03iW+pE3nJwm99A3QM7xsMBCi+zgutMH7rK/1LLHWVHeD1rMlcXOh9yqBs4MTbxHHivzeRLC8z5wbrSdAzJacoTFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QoqX9BLo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D81C4CEDE;
	Fri,  3 Jan 2025 01:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735867214;
	bh=xZaqeBv5CKoQskEwFuSdPNq6XCDw5DNB6VQwSzCRljk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QoqX9BLonCem0liT6G6JfkFsojFLtA7Rr4d+qa8TnT6wce+X9mKaJwsThjmMxR1x3
	 p3UTYb8VxEk+XaU0ugc+SpoleA/LrDjy5NHqnkmMkim6pjSGi0fUg2H5CaIoBfPwAa
	 VL3qOJtYSE8BWNVvhoCHEHkk8Xi6lrWTmPHvqaTjxQeBx+UGmMBt0mdfPP4fVpMXb8
	 Aos0Nv1N2Re+3AZbUExkmf0TFB8Z9DDLlXsNcDnQK0RoIPFnYm86KvkglpHRTvUG46
	 iCH364JH7VIvS0uroaZfJP85bCj8RL2/ef9zLD/YiiGzK2Ard5zXCaXdcBJL/Kjmwq
	 gj/2D0vfOOkyg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF87380A964;
	Fri,  3 Jan 2025 01:20:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ptp: ocp: constify 'struct bin_attribute'
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173586723475.2076853.11984424771742466245.git-patchwork-notify@kernel.org>
Date: Fri, 03 Jan 2025 01:20:34 +0000
References: <20241222-sysfs-const-bin_attr-ptp-v1-1-5c1f3ee246fb@weissschuh.net>
In-Reply-To: <20241222-sysfs-const-bin_attr-ptp-v1-1-5c1f3ee246fb@weissschuh.net>
To: =?utf-8?q?Thomas_Wei=C3=9Fschuh_=3Clinux=40weissschuh=2Enet=3E?=@codeaurora.org
Cc: richardcochran@gmail.com, jonathan.lemon@gmail.com,
 vadim.fedorenko@linux.dev, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 22 Dec 2024 21:08:20 +0100 you wrote:
> The sysfs core now allows instances of 'struct bin_attribute' to be
> moved into read-only memory. Make use of that to protect them against
> accidental or malicious modifications.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>  drivers/ptp/ptp_ocp.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> [...]

Here is the summary with links:
  - [net-next] ptp: ocp: constify 'struct bin_attribute'
    https://git.kernel.org/netdev/net-next/c/be16b46f9ebd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



