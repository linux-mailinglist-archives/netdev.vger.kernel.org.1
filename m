Return-Path: <netdev+bounces-181862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7517A86A59
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 04:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F2A81897422
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 02:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9703314EC73;
	Sat, 12 Apr 2025 02:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dobj37m6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7140514C5B0
	for <netdev@vger.kernel.org>; Sat, 12 Apr 2025 02:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744423255; cv=none; b=EHuXQ7E9KzVhCveXUaGh87kfTZoNhttx1qDYeBleJuKDBkIu8h71AzcmYhI/38Ktm26k9V7gRBJvz2qPX7NXoly17fEAapoeVZ9j7hHRZV7noqve5q2MYstxkub5KEr6nck9MntewkTG1wj8uoJ66ww3flREUiGhB/tYFsIfMG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744423255; c=relaxed/simple;
	bh=HM6DtyY6+agoKvjKNNOemporJ3rDMJTAbCHGSiWn0BE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ffb4iNJgqNYJUJMrLWm+0zxkyi+9wPnIfxFnX/VKp8NN7I5N3Abb4WcMB8y5gPtuX82jOCfVVyCSD9mQu+uYKT50lCA65R4ZGrIdM1/c9mV6aI1kf18g7rFXxb5iEZsu7NVy7Cn83r978hpbeN2I7TadAJLubrE5MPQPUQgEAvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dobj37m6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCEA7C4CEE2;
	Sat, 12 Apr 2025 02:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744423254;
	bh=HM6DtyY6+agoKvjKNNOemporJ3rDMJTAbCHGSiWn0BE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Dobj37m6DAHUiUfr8XeMF9oarhOqxXdPLWn3qghESi2T04mfZB4zjN8fF3tlMLX2S
	 GHOMdphtempZn6k9VgTKp/6m7fK8yHpeVmOFUYDecne0wEACHe3wnelOXIRZEsJC7m
	 Pw/oRakU8N99+4YD2uw81TlqKl3TO0mRAf+tWvl92OkzLEMDw4Q6IrFZbLJLE2GiAh
	 rtKicKMOYUCs4dOeS4FUqpdkeP//BL1+c1zlwB1BVs8nmt4ErqDLcMEzmYVhs7QFQT
	 WPl3nrXtNI5SC0LzXfR37VoHsUE5FtPxHWG3fatQ7erv9O34v702SOHRL7vatGKeZh
	 yQknj0GftUlIA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC1B38111DD;
	Sat, 12 Apr 2025 02:01:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: mctp: Set SOCK_RCU_FREE
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174442329225.549857.3805362016810226826.git-patchwork-notify@kernel.org>
Date: Sat, 12 Apr 2025 02:01:32 +0000
References: <20250410-mctp-rcu-sock-v1-1-872de9fdc877@codeconstruct.com.au>
In-Reply-To: <20250410-mctp-rcu-sock-v1-1-872de9fdc877@codeconstruct.com.au>
To: Matt Johnston <matt@codeconstruct.com.au>
Cc: jk@codeconstruct.com.au, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 10 Apr 2025 11:53:19 +0800 you wrote:
> Bind lookup runs under RCU, so ensure that a socket doesn't go away in
> the middle of a lookup.
> 
> Fixes: 833ef3b91de6 ("mctp: Populate socket implementation")
> Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>
> ---
>  net/mctp/af_mctp.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> [...]

Here is the summary with links:
  - [net] net: mctp: Set SOCK_RCU_FREE
    https://git.kernel.org/netdev/net/c/52024cd6ec71

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



