Return-Path: <netdev+bounces-198830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D21ADDF8A
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 01:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BAA316C453
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 23:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1DA29826D;
	Tue, 17 Jun 2025 23:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNCj+k3q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6322D1F5847;
	Tue, 17 Jun 2025 23:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750202402; cv=none; b=cBYJa8qlqKsvvnGKL+nkuaKku3RbcXHM4reLIXt3vY/8bv+zzOb97UMGqLZ4QoKBZZD3JeWqS4/eE2zwZSpau7WVDD3oU7U/7qUR8Iohb1XfTTy+xGIQwWof+wGcl7Rs+OdAyJ0AE1Fali7cFrv/9pMgjejeRg94QiwNHJ4MP9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750202402; c=relaxed/simple;
	bh=tUMfbZaV2KdqnBHZfGQhAgjQy/l7+5wMfermKy1C0Xs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RYlC9SNkSiBWU2CFSnn2Kz5joj8Gl1BCAae7vVqSCrA8dJ8n/1aaM0yltheumOO7LQdsTm4P6F8RYUdTc+1ua7Mp7eqS1zseT2Xaa5MkaMKoG/UTLiYPZIkTdvVv7G4RYtC0nW2dgNAnA24qELJdejeZ0nbp0TEQpjXo1xyrAbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNCj+k3q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB9ACC4CEE3;
	Tue, 17 Jun 2025 23:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750202402;
	bh=tUMfbZaV2KdqnBHZfGQhAgjQy/l7+5wMfermKy1C0Xs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BNCj+k3q0uLbx1jAxYLpfFz/Pa4F3J3n9K2AiR1YNH4Y92v9MlWecdNPYoG4S/ujb
	 PHlnbVao3Hj0xmvBC8pzYhZdOHENJYHFsLSv+Wp626xp8blbGgx9C1a3p1zVon0wod
	 EoR9lBNnSyL5iRORJmTShxwVwkTDHt4dzABYPnlJwMMV5m4U9GCg8s1t2QV+w8ZNtz
	 OYEIz6p8VW7gCiGykaNabC/1aFkS9G8F0UdpaB0eiN064XWyriZdLyguxGqJpSpt8Y
	 Kia9TZh87uRe6ZQyE0mkaedm0SLSFOqbEwDEMC50WOLWr8as5Up9wo1JldgdGteEC3
	 rcnI3VkihdF5Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD3538111DD;
	Tue, 17 Jun 2025 23:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bnxt_en: Improve comment wording and error return code
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175020243050.3732875.7654821234752870349.git-patchwork-notify@kernel.org>
Date: Tue, 17 Jun 2025 23:20:30 +0000
References: <20250615154051.1365631-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20250615154051.1365631-1-alok.a.tiwari@oracle.com>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: netdev@vger.kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 darren.kenny@oracle.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 15 Jun 2025 08:40:40 -0700 you wrote:
> Improved wording and grammar in several comments for clarity.
>   "the must belongs" -> "it must belong"
>   "mininum" -> "minimum"
>   "fileds" -> "fields"
> 
> Replaced return -1 with -EINVAL in hwrm_ring_alloc_send_msg()
> to return a proper error code.
> 
> [...]

Here is the summary with links:
  - bnxt_en: Improve comment wording and error return code
    https://git.kernel.org/netdev/net-next/c/10f3829a1309

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



