Return-Path: <netdev+bounces-105094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0934690FA47
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 02:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C3A4282547
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 00:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBE78BF3;
	Thu, 20 Jun 2024 00:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2K89D3Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CE14C99;
	Thu, 20 Jun 2024 00:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718843428; cv=none; b=Xhqjso5M+OTr978rsiSVNx9rCD8X7VvzFdoIPKMHNVKtkmCGKytiNoyVVVELhLsF6DjNHcvKrepthHkInaaPEIc7h4TxhlglDKCGUZbdocUQDHLkfHvFVAa+65bHvnrWrNuOwXRQk9jVE3Jt1PRCVq93sUOxvqzKCbHy1Q77We8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718843428; c=relaxed/simple;
	bh=sE395wgxeS06XLcvUHk+YTQZ7KmNXAJvs7ixKcvKWBo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mem5QM2sZBkAErgRCqurAgPxZZAQXWzG0hZvi3w2YVhZWq/+NkgmttdQGIxrvvfbGcz4AMFis3olk9CNUn2lxwHupKJzkpDQTMiDpFA1wC7ssJWAvX8Jquj/ThSiOcy3y11I1MaEHbR7QoOqhAkUqmd59JgDwD0z6SW+Tvc5ItA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2K89D3Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14DE5C4AF13;
	Thu, 20 Jun 2024 00:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718843428;
	bh=sE395wgxeS06XLcvUHk+YTQZ7KmNXAJvs7ixKcvKWBo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=N2K89D3YhKO18G2Wh9RAwh3N6Lc2gPIEKrw9aIOQ+8HXt8hiDjIEnkNM2KO22Uixs
	 z8d42hK9BKUiLD6qtC8L4kBPznVCCOuX0MMjvPIuUwRmXcaxQqNX8oZv0ZRJ9xTDQ/
	 677HhRmbty+wrIaoCr5JRJZ5uToIj3ahCTipFP4KFwuaELN2LBgSnDV+nKz8G+Nojl
	 9Gyjq3hJ30//qsFhTFtVIP+IFwllY8T722HDWn7Pj2r1Dae2sCGG42rK+2XqcuZVG6
	 reeoViUVOm6/Rr0RkqF/sDdEUpK03odfQCPH5iK2YrcCPjpNqp2C44LqfquHYryREJ
	 WWyz1ievXNaow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 09237C39563;
	Thu, 20 Jun 2024 00:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: amd: add missing MODULE_DESCRIPTION() macros
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171884342803.23279.11576838242021716545.git-patchwork-notify@kernel.org>
Date: Thu, 20 Jun 2024 00:30:28 +0000
References: <20240618-md-m68k-drivers-net-ethernet-amd-v1-1-50ee7a9ad50e@quicinc.com>
In-Reply-To: <20240618-md-m68k-drivers-net-ethernet-amd-v1-1-50ee7a9ad50e@quicinc.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Jun 2024 10:26:20 -0700 you wrote:
> With ARCH=m68k, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/amd/a2065.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/amd/ariadne.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/amd/atarilance.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/amd/hplance.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/amd/7990.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/amd/mvme147.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/amd/sun3lance.o
> 
> [...]

Here is the summary with links:
  - [net-next] net: amd: add missing MODULE_DESCRIPTION() macros
    https://git.kernel.org/netdev/net-next/c/deb9d5766206

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



