Return-Path: <netdev+bounces-73527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 970C985CE52
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 03:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50BB7283135
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 02:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FAC282F7;
	Wed, 21 Feb 2024 02:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SoG6oVDF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08D879FD
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 02:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708483829; cv=none; b=mvnrRZqpfHT99Kt5l+VO6ULh460uo+1zgqGsjJdIc3SfdXcu6DrWy5pprhsNtCrZ2mWY2Vm86LC65dE5y11TP2/GkLHrR/jNOQR58Ug05BfX7SmV7+mcwEMJTiLrBpxVGJ+bKCfOO8AosBiPHOKBxJH8u62gAIVa1FhJxbdoZbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708483829; c=relaxed/simple;
	bh=LBoGaCWDxjIQ37nHIujYBMHcQVCOelQRLfkG7aUqHws=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=N3lvONOp50asB5zfO1PkJ9nEhctCuvtFmju5lsmdoUxGCGMmurCyD3ToPPuGLW+IIuwQf4DyOyP5pnenkA8DbLexgC19+OR2hBNiC0Gdajd6/AXya3F0uWX5jji+e6If9ICxrlZtdQ60qOwy63YqbFhBMgAphMoSMG9aTaQLnpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SoG6oVDF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4510FC43390;
	Wed, 21 Feb 2024 02:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708483829;
	bh=LBoGaCWDxjIQ37nHIujYBMHcQVCOelQRLfkG7aUqHws=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SoG6oVDFaKLMNXa5E9DEh2dknov/A7kKqzN/TuyXZovQHHS6FG9og6nEMy0dMKw9c
	 sV/2iM9IUq+qlFwSoh26AoAmtIo8CnOjcZF60zK9pSzT3eSBkwJoZcZldt9FKPw2+B
	 KO1gtsuyzjl2E0oy+IVUweXgPodoANb4r/p5Cok0MJV8m6dPQmNecVkzYHxllqHfKv
	 5sGY81ItusrWsKg6AD+bRDaZRECpqCissXoOT/VKP6+g2C5wTB7sTJ5Mkc8F35e5uD
	 BfZ8Rv+0Y5UPgfYFVVEDH1je0Z3grRBJHeoUg25MK3C68UQplSjZso2Y2lkLGUVrE5
	 Oj1xTdlsZkkqA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2C409D84BBB;
	Wed, 21 Feb 2024 02:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] r8169: add MODULE_FIRMWARE entry for RTL8126A
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170848382917.20526.9255067299787639965.git-patchwork-notify@kernel.org>
Date: Wed, 21 Feb 2024 02:50:29 +0000
References: <47ef79d2-59c4-4d44-9595-366c70c4ad87@gmail.com>
In-Reply-To: <47ef79d2-59c4-4d44-9595-366c70c4ad87@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: pabeni@redhat.com, edumazet@google.com, kuba@kernel.org,
 davem@davemloft.net, nic_swsd@realtek.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 17 Feb 2024 15:48:23 +0100 you wrote:
> Add the missing MODULE_FIRMWARE entry for RTL8126A.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [net-next] r8169: add MODULE_FIRMWARE entry for RTL8126A
    https://git.kernel.org/netdev/net-next/c/f4d3e595c000

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



