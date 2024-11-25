Return-Path: <netdev+bounces-147125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A47D49D7985
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 01:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A8AF2820C4
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 00:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2A27485;
	Mon, 25 Nov 2024 00:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HaV6XMyo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49A2524C
	for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 00:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732495821; cv=none; b=kz0xNedYq2lewB7vyZEbRgo0XKxUqPu6DxtL+/TSZNVXirkLDWnW7qAc3jbDJxFvknPLNB0e5/Ch8Iw8LHqiAPptHpwBB6xCrR5Q8Zi828qD/2wiPNlZ6wEXGCkXNfGzGW6MHR3JiyE0YA1tjN7iFtxSE+qkLw09jgRBMY4g+IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732495821; c=relaxed/simple;
	bh=sIGVh+2QQzg7s6zZYAiSMp4TFwPsiHgaBzGyWz78Mf4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t7l0TCBELswRU5CxAl8s44DO/Q4agE47xHK4fDhnOlC7IgWD8kEx9tQZsWQ1WX1EuWZeiTfs3aXKhPYeqeo+gywIOjKxE9Q6MfgFjX8dEiTuaGm3Vnmz01uMQN2RJrYyyhJzgkT5HolEkusKwsYPKGmrvTM0lv+gUoPVxNdnQ9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HaV6XMyo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7028DC4CED1;
	Mon, 25 Nov 2024 00:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732495820;
	bh=sIGVh+2QQzg7s6zZYAiSMp4TFwPsiHgaBzGyWz78Mf4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HaV6XMyoGA6ip8a3uOIoUKH6ivGvYwQYaAUshKhaxM1Qov9Wmq3jaZ3+sxmR6PEJy
	 711ur4zNJCx8VvDqe0jawLJ1GksfI2DkHjvF+XNIY+DbSp31+ruWwMmnPHQNBs09s3
	 2r0fipSy+Cnqiu4tqKHnm7akF8sAGwhmDax5hEtN6UOcA9pdiQ8bkA2xYEAaBNt5i/
	 FX75zFfl6/kuJAkJU+3GVF7RiipbA2pD0bfTk2IrEQHTKPYhVU0ByzQv8osfSBv1Jb
	 D4ASPx7Ky5UB5jqQ20Rih0k764vpdqrHfeCrbVNxQ4xgKFXwEj/NyfN6YuoFCQnDFT
	 5EIElNyJyyIrw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EA63809A00;
	Mon, 25 Nov 2024 00:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1] selftests: fix nested double quotes in f-string
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173249583300.3408383.10008998713300867772.git-patchwork-notify@kernel.org>
Date: Mon, 25 Nov 2024 00:50:33 +0000
References: <20241122064821.2821199-1-dw@davidwei.uk>
In-Reply-To: <20241122064821.2821199-1-dw@davidwei.uk>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, mohan.prasad@microchip.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 21 Nov 2024 22:48:21 -0800 you wrote:
> Replace nested double quotes in f-string with outer single quotes.
> 
> Fixes: 6116075e18f7 ("selftests: nic_link_layer: Add link layer selftest for NIC driver")
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>  tools/testing/selftests/drivers/net/hw/lib/py/linkconfig.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net,v1] selftests: fix nested double quotes in f-string
    https://git.kernel.org/netdev/net/c/078f644cb81b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



