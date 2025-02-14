Return-Path: <netdev+bounces-166571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9195A36790
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 22:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C5863B2E47
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 21:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A841C862C;
	Fri, 14 Feb 2025 21:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBTDagEP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503CC1DC9AB
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 21:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739568607; cv=none; b=rM0aGqcFl+Ipkl/f7jpcmC60EguKMBtu9jMBSmwm6CA2pRSNon+MJCTD8IaWbJ2OwWmmctdFyIYhh+QAoVENNGPiOXA5MlQI7Ta0vWspXUFezVUCfQnuXPrRxmWI9HrrwmVNt+693mtUvwejkWqzYzsVmRcw0AF5xA2vbLMZ9SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739568607; c=relaxed/simple;
	bh=zsatcmmjVtuJLdqbmVIni/VC6fLq0DtiTgHxQbkTqjo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qeOHbJBRVxELYW7wT2lQkLQ7Q8ds06UJv+NUkuq1dWkyM3bi3UA+H9aoCXeRM2MpsFz1GMyTPN6uk23e4+uSRbiu07e0h1eI+tvFPaSM7iSJylaMkGKIKxL8ur0u4c2jhSd2hexCK7OuGM3grD9oxwko40FBijtsKRPgL4DUDOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBTDagEP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C046BC4CED1;
	Fri, 14 Feb 2025 21:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739568606;
	bh=zsatcmmjVtuJLdqbmVIni/VC6fLq0DtiTgHxQbkTqjo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aBTDagEPbI0rYArNiNUQn5NS+chpdNND5O5aMJ7VzoixSYTcZaolyeeKlvVXYsikp
	 4sa+3pe9dAU/wNtKH6hEx+bit/k5loOya0Rwhqw1izywz1PmLKqrN23hVITHhiySGH
	 /XppsxPGj/7+qtmSHbwzwxyjOZ2LJMFH55l3dT46GRikRzgqeXpoDo/JaedXh0lMJF
	 idCMcmXfjTKGH85aN2pXsBVxInHC5QoLQ8uGQMu/FI7cOcZUrdCxxULc5PNgorn/0j
	 NYG/pJpbm2jbBE3u0ad1g3xoslH+KPVSr8NTG+Wea/RT225SDySDHs/j1xugLBXv4l
	 YgallM9Z1Hp3Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710D0380CEE8;
	Fri, 14 Feb 2025 21:30:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/4] net: add EXPORT_IPV6_MOD()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173956863628.2110293.421662337450973550.git-patchwork-notify@kernel.org>
Date: Fri, 14 Feb 2025 21:30:36 +0000
References: <20250212132418.1524422-1-edumazet@google.com>
In-Reply-To: <20250212132418.1524422-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, horms@kernel.org, willemb@google.com,
 sd@queasysnail.net, ncardwell@google.com, kuniyu@amazon.com,
 mateusz.polchlopek@intel.com, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 12 Feb 2025 13:24:14 +0000 you wrote:
> In this series I am adding EXPORT_IPV6_MOD and EXPORT_IPV6_MOD_GPL()
> so that we can replace some EXPORT_SYMBOL() when IPV6 is
> not modular.
> 
> This is making all the selected symbols internal to core
> linux networking.
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/4] net: introduce EXPORT_IPV6_MOD() and EXPORT_IPV6_MOD_GPL()
    https://git.kernel.org/netdev/net-next/c/54568a84c95b
  - [v2,net-next,2/4] inetpeer: use EXPORT_IPV6_MOD[_GPL]()
    https://git.kernel.org/netdev/net-next/c/95a3c96c7460
  - [v2,net-next,3/4] tcp: use EXPORT_IPV6_MOD[_GPL]()
    https://git.kernel.org/netdev/net-next/c/6dc4c2526f6d
  - [v2,net-next,4/4] udp: use EXPORT_IPV6_MOD[_GPL]()
    https://git.kernel.org/netdev/net-next/c/2f8f4f22452a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



