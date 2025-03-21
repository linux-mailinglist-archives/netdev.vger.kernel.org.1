Return-Path: <netdev+bounces-176779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB408A6C1DC
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 18:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18A143B9EC9
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 17:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4E222E3F0;
	Fri, 21 Mar 2025 17:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFh4hR10"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0498E22DF98;
	Fri, 21 Mar 2025 17:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742579398; cv=none; b=FYj07OweJFpjh28fIY49rkN+Eek/ozQW3z+xLDUvweWKp3oKSxax8csp8fwJoQMWH81v+oRAfI3VojO7IqM9y1VsGR5utxm9BxsEjppW2CrMPOj4puonkw+Rw+IoidKT5abhDKECCnEXlR4S6OMCUdCtaIIv7VoSMDDjCpxx0Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742579398; c=relaxed/simple;
	bh=j356g8WAU6v1QH11K3lIyQnqCv8MFer8e/TaMU1xpwo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IEx5ptdvaV+Z2CEMwxj/2Acz9KictkYO/C9SmswCFYgEdT0no0cOkuxpZDx1wu87I0sa+5eH6J1YcIBTNCiHk0kly6kWE1DlYJrsxn1vsCnBYOo7aXBGOCDa0mGSaT99y4m5/3gSu4CljdTWSECObvB+udSE/qabZaDt4ovAgoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tFh4hR10; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67466C4CEE3;
	Fri, 21 Mar 2025 17:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742579397;
	bh=j356g8WAU6v1QH11K3lIyQnqCv8MFer8e/TaMU1xpwo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tFh4hR10DEiD2INJJjzxGevIyq3J0H2j3GhhmKi34mCEcVitpydi3fKsgm6v1sdE/
	 Qo1mF0x03kcg2hD3sEvgKgcxOQy15ijeKE1i3oa2DDOnci1H1fhey8C/IovxR4zS4I
	 1rlYsr2sywcYTG2IztgKd2NTgraViN9wux0HoDxoszCiBSw6cBTEcgwJi/ToXKlVdO
	 elacdMVZmKfwx/Jsr5bS9qFLCH/grbPkij/muHEtaf2m3EleHSkJYHHwhWbgG6VEa1
	 RFDEKYdJlO3uHSqWP3QJ64pQ15T/aTXpszsTjKxJO6FLn6SX/ljKuIp6aXXJgguABa
	 AcXDYsC+fJSdg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFA43806659;
	Fri, 21 Mar 2025 17:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: airoha: fix CONFIG_DEBUG_FS check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174257943352.2572031.8416368231944213281.git-patchwork-notify@kernel.org>
Date: Fri, 21 Mar 2025 17:50:33 +0000
References: <20250314155009.4114308-1-arnd@kernel.org>
In-Reply-To: <20250314155009.4114308-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: lorenzo@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, arnd@arndb.de,
 horms@kernel.org, ansuelsmth@gmail.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 14 Mar 2025 16:49:59 +0100 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The #if check causes a build failure when CONFIG_DEBUG_FS is turned
> off:
> 
> In file included from drivers/net/ethernet/airoha/airoha_eth.c:17:
> drivers/net/ethernet/airoha/airoha_eth.h:543:5: error: "CONFIG_DEBUG_FS" is not defined, evaluates to 0 [-Werror=undef]
>   543 | #if CONFIG_DEBUG_FS
>       |     ^~~~~~~~~~~~~~~
> 
> [...]

Here is the summary with links:
  - net: airoha: fix CONFIG_DEBUG_FS check
    https://git.kernel.org/netdev/net-next/c/08d0185e36ad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



