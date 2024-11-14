Return-Path: <netdev+bounces-144806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7B69C87EB
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 11:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B25FB31662
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 10:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C301F943D;
	Thu, 14 Nov 2024 10:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHRbrM4t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701731F9402;
	Thu, 14 Nov 2024 10:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731579020; cv=none; b=hjbKE8UDXB6DFoEz+b05G4zj1e4QJJdOcwNrbiFIjKNNk8Knkh6M9s/S61k0+vTLbK2yFeOM4hfsuNJZ3xilxTe/mlemKIiMQSSOq/eaU/m2ZklINxRTubQqOuBKOjmojCe6AVr299uNLoFOuDdu6/Y3nIn+rzOej4zIajqxULc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731579020; c=relaxed/simple;
	bh=zIXoVPuLxS46P+2i3Z4nmPDd0XPDfcNwgdZycvncv+w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=P767SUP+nDyGxea9Xvfk4Zc2AXnzKh0ho5fddXwZqmFryf7FUrs6EU6djMhOvcIzmYjQYQEEyVe1YWmR74pVqjGKfRCsLz3EPWtaQv+YWgL4UEuWRHH639uIuSMgbnMLY2HoSUFVw4VXI0kh1qcvxml9lY6Yxa+ZoOZJdW9n6HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHRbrM4t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFFC3C4CECD;
	Thu, 14 Nov 2024 10:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731579018;
	bh=zIXoVPuLxS46P+2i3Z4nmPDd0XPDfcNwgdZycvncv+w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CHRbrM4tcguZd7l9uc7J+VttnK1I2vUOgOSwFNF7UCmjXoTOe/7CyDW0H7jFHGHDG
	 saGQ7gTZU3zDTlbumMOmQ7Z6mMZdnFN6y763tekJ9zeSRt0dZOEFV79pKwAatLLO+F
	 /4lipHoacF3cjwrTDqcoH/yhC8WfEZcWbY3hFb85v+8a5kroRlJeCJVbu8tqpZNSKh
	 PUCPoaxztlV0h86DbTcvLneQuS44bF4hZMdyfVRHMqAUf/WvWZqi7wzvE3hE/xUDE2
	 ZXgG95CC2JDgX5TBSB6f29t8C9UkYjnHnuaLeUYJuVq0Xk/Z+pGBFSKuEEzxRUU0/g
	 VF/fsw00+lVCw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDEC3809A80;
	Thu, 14 Nov 2024 10:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5] net: ti: icssg-prueth: Fix 1 PPS sync
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173157902851.1866232.9016016024902028479.git-patchwork-notify@kernel.org>
Date: Thu, 14 Nov 2024 10:10:28 +0000
References: <20241111095842.478833-1-m-malladi@ti.com>
In-Reply-To: <20241111095842.478833-1-m-malladi@ti.com>
To: Meghana Malladi <m-malladi@ti.com>
Cc: vigneshr@ti.com, horms@kernel.org, jan.kiszka@siemens.com,
 diogo.ivo@siemens.com, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com, rogerq@kernel.org,
 danishanwar@ti.com, vadim.fedorenko@linux.dev

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 11 Nov 2024 15:28:42 +0530 you wrote:
> The first PPS latch time needs to be calculated by the driver
> (in rounded off seconds) and configured as the start time
> offset for the cycle. After synchronizing two PTP clocks
> running as master/slave, missing this would cause master
> and slave to start immediately with some milliseconds
> drift which causes the PPS signal to never synchronize with
> the PTP master.
> 
> [...]

Here is the summary with links:
  - [net,v5] net: ti: icssg-prueth: Fix 1 PPS sync
    https://git.kernel.org/netdev/net/c/dc065076ee77

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



