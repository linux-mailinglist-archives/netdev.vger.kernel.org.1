Return-Path: <netdev+bounces-50897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BD07F77D4
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 16:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 559E81C20FBD
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 15:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC8B2F500;
	Fri, 24 Nov 2023 15:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRSDpw44"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0152EB14
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 15:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A077C43397;
	Fri, 24 Nov 2023 15:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700839826;
	bh=ujozh1RTxnZAxs552sPXpQOYywcBLv309mkMeENbdE8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cRSDpw44O7287c7YArNBGKi3cuOTtmXXuICCR6y07VFhv6FgplYhGrZvmcp6IDDIO
	 86NReM5nNzlGsjrbiiHoKtw59IChBgls1Ms4ARoJ1Ol02GMSh3XbrUaRxTo3tsBERa
	 xbuL57lB0C9uV9XB24ak3kEQerldeBMMSnvlig1lI/uosYmTZFrl+hlo+TJPSY5A9z
	 A3CqXsrtzs/OKIi+1rfa+gr6kKY0l0RpCP8+PeWek92mML7Eh/2knfxieGXyitl9G7
	 FdNtpB/Ip28Zjk6mdsqoLg+W3oz9ZkPs0I99dcNAt+NrLrkJwbLwURKNz7RTBB8oyl
	 /lJxxGNosmxPA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 33949E2A02B;
	Fri, 24 Nov 2023 15:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] bonding: remove print in bond_verify_device_path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170083982620.9628.14358170274251923179.git-patchwork-notify@kernel.org>
Date: Fri, 24 Nov 2023 15:30:26 +0000
References: <20231123015515.3318350-1-shaozhengchao@huawei.com>
In-Reply-To: <20231123015515.3318350-1-shaozhengchao@huawei.com>
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, j.vosburgh@gmail.com, andy@greyhouse.net,
 weiyongjun1@huawei.com, yuehaibing@huawei.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 23 Nov 2023 09:55:15 +0800 you wrote:
> As suggested by Paolo in link[1], if the memory allocation fails, the mm
> layer will emit a lot warning comprising the backtrace, so remove the
> print.
> 
> [1] https://lore.kernel.org/all/20231118081653.1481260-1-shaozhengchao@huawei.com/
> 
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> 
> [...]

Here is the summary with links:
  - [net-next] bonding: remove print in bond_verify_device_path
    https://git.kernel.org/netdev/net-next/c/486058f42a47

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



