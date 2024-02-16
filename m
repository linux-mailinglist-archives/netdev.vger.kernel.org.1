Return-Path: <netdev+bounces-72288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 141E385776B
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 09:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6C87281F5B
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 08:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89D120B0E;
	Fri, 16 Feb 2024 08:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUXnXbAK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D8C20B09
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 08:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708071027; cv=none; b=A1jrATmHoMTDdPenX0q9jvqHpCTep2INelJ8EmeUaqoi4HN3vNfyNtt6W9ckd05E+PXtmh04mtO1Awier95+KrDk6+jnZQkBk81c1uzV5l75kp2r1XGpPNZiFssvOgGCEMvgCzyrDl9foBeFTcGEsKJo8KcU4NtqH0cOtBwwEKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708071027; c=relaxed/simple;
	bh=I4aaUiQAZkuOtcjzyOyyRahjBJELdKyuXNCj7oeZcRY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TsznWMjRW0su2Ot50Oq5MB+QeDtu3Nczr0G4nG4lDUgsvGpGJJXdaHX2szsIWbl0hSvVvgAiN/cRmFSs3aE2HZfwNwqpF+q5xkkOtyfch4WIuv/vbO5lJ8z2kyBgqGT3VESiDPLTdriEUl6yGUKmZE3IlPt8MK5Th06WdIKVX6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUXnXbAK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3E8EC43390;
	Fri, 16 Feb 2024 08:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708071027;
	bh=I4aaUiQAZkuOtcjzyOyyRahjBJELdKyuXNCj7oeZcRY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iUXnXbAKL+wKLRY+lX0+Djv1vuCsq+HdtcEy5RZVPjTjiZyTvJHsD3a4G5gHvWWMR
	 aMs+k6waTdQ37LjeFiIXn7NR6eJw17rd7/sK20lIr2uAoYCKzRRdrsb1dtpCDIOIyb
	 7/nDB5uGPKPYfcpOHWKupyvKO96Bt9xLdPGBnKRHPnK5/M2GImxSJcIouscQ/FTdtT
	 3/jNxu1yyYlsp5JH5ZqGKt2hysFTRqlf+g3HKZKW56NNutzu7UaOsbkbx7Inq3LsLp
	 W+fb2lbxb1YmaoXEr9thHbCrWVTRUpc52ISN0DeTWoMMclUf6mGkhbSR9cQbK2VTD2
	 TJ8hY7jyDFGQw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D1447D8C966;
	Fri, 16 Feb 2024 08:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: bonding: make sure new active is not null
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170807102685.26288.13518483144734460041.git-patchwork-notify@kernel.org>
Date: Fri, 16 Feb 2024 08:10:26 +0000
References: <20240214092128.3041109-1-liuhangbin@gmail.com>
In-Reply-To: <20240214092128.3041109-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, j.vosburgh@gmail.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, liali@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 14 Feb 2024 17:21:28 +0800 you wrote:
> One of Jakub's tests[1] shows that there may be period all ports
> are down and no active slave. This makes the new_active_slave null
> and the test fails. Add a check to make sure the new active is not null.
> 
>  [  189.051966] br0: port 2(s1) entered disabled state
>  [  189.317881] bond0: (slave eth1): link status definitely down, disabling slave
>  [  189.318487] bond0: (slave eth2): making interface the new active one
>  [  190.435430] br0: port 4(s2) entered disabled state
>  [  190.773786] bond0: (slave eth0): link status definitely down, disabling slave
>  [  190.774204] bond0: (slave eth2): link status definitely down, disabling slave
>  [  190.774715] bond0: now running without any active interface!
>  [  190.877760] bond0: (slave eth0): link status definitely up
>  [  190.878098] bond0: (slave eth0): making interface the new active one
>  [  190.878495] bond0: active interface up!
>  [  191.802872] br0: port 4(s2) entered blocking state
>  [  191.803157] br0: port 4(s2) entered forwarding state
>  [  191.813756] bond0: (slave eth2): link status definitely up
>  [  192.847095] br0: port 2(s1) entered blocking state
>  [  192.847396] br0: port 2(s1) entered forwarding state
>  [  192.853740] bond0: (slave eth1): link status definitely up
>  # TEST: prio (active-backup ns_ip6_target primary_reselect 1)         [FAIL]
>  # Current active slave is null but not eth0
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: bonding: make sure new active is not null
    https://git.kernel.org/netdev/net-next/c/31f26e4fec1f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



