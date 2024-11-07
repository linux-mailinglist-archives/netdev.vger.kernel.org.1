Return-Path: <netdev+bounces-143045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4048C9C0F50
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 20:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05455285586
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 19:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74C4217F37;
	Thu,  7 Nov 2024 19:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJ7jqKMg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD366217F2A;
	Thu,  7 Nov 2024 19:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731009021; cv=none; b=MbG27v6QXrrnKg5IKLfvLo34ls0/E0HQH6Q3UQxa77fOEjnSlg9qnDIEjf3RUReR+SoKzhGj+1Id2lp+5k0j7jhwbNi7hvVWiRcKlBAq5qK69ME+RJn2AIFrqQ0w38W+pRWsRp3H2BoxghBt98XdgpoGIwP9n3KvwOSKkEpVxCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731009021; c=relaxed/simple;
	bh=Ok/dgzSj7Jak8LZx+j4OYXbO427N25pLHWaGDt4Hb2k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DHlK5T5XOvl6PFVdPpLNkF8wNMJ55zXMzIvR1Qeb1M8S+rSBJTdOK0m8vxA6pT1XFUAiKb9BT9dExL/sPZLpfKwua6DJw2zzb1cLsh0/5nm/o4zHZgH6lgajPTHUhD/DI881ll7j6CjoR9aJXMVhON7XSaujnmEUdL/E35M+E00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJ7jqKMg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB18C4CECC;
	Thu,  7 Nov 2024 19:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731009021;
	bh=Ok/dgzSj7Jak8LZx+j4OYXbO427N25pLHWaGDt4Hb2k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kJ7jqKMgfN00v6NJoBfBM49pH0QN1v4zkDesbBBUMolDYX5JKbpPCJhLVLUKlzFbu
	 QPlNM8JZCiGKjitMF+XdiEMRp5thOx3sAW0urXYV9UgAV+5VSFkQSW8PuDGAjc3fJk
	 y+6yXOb8DPAehKM4KVe9FK6xn9BW2kxEmMuuheKX/sndyGZkKOXqA4JEIe5biIq2Dw
	 6WdVk7ziTKbhb9ja4bHgYZz0WjFrrNvdRWpviW+wdhpI0EshbApb7qqwzBiGXAm681
	 NkMii/K4mO1/y2tiNSyoGyE3VC41UXWJL+3U1UWCFPy8zNubU8+PI6h48PnOE++laG
	 /kOzygQ7sQtCQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC863809A80;
	Thu,  7 Nov 2024 19:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] drivers: net: ionic: add missed debugfs cleanup to
 ionic_probe() error path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173100903051.2076172.17377192055284707962.git-patchwork-notify@kernel.org>
Date: Thu, 07 Nov 2024 19:50:30 +0000
References: <20241107021756.1677-1-liangwentao@iscas.ac.cn>
In-Reply-To: <20241107021756.1677-1-liangwentao@iscas.ac.cn>
To: Wentao Liang <liangwentao@iscas.ac.cn>
Cc: shannon.nelson@amd.com, brett.creeley@amd.com, davem@davemloft.net,
 kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Wentao_liang_g@163.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  7 Nov 2024 10:17:56 +0800 you wrote:
> From: Wentao Liang <Wentao_liang_g@163.com>
> 
> The ionic_setup_one() creates a debugfs entry for ionic upon
> successful execution. However, the ionic_probe() does not
> release the dentry before returning, resulting in a memory
> leak.
> 
> [...]

Here is the summary with links:
  - [net,v3] drivers: net: ionic: add missed debugfs cleanup to ionic_probe() error path
    https://git.kernel.org/netdev/net/c/71712cf519fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



