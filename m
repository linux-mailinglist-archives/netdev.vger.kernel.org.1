Return-Path: <netdev+bounces-78599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74795875D68
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 06:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A7881F22B35
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 05:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF8B3BBD2;
	Fri,  8 Mar 2024 05:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZpm+Yke"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10342EB14
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 05:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709874038; cv=none; b=RRVYm4FGZPtenPK3hXRCSF3eawHGTCUkbWgyGd3ALUlYCuoioa84SLz746eejWG0aqbehLVgACCYcY9lr2oIk1eAbcnOH3/usNNzqCS1MZXaBvNEn6lGGiOTREAXaA/tzB/sbCyd4DIpz2B3dBJSmbUQqr764SOzxoBq2DAZrko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709874038; c=relaxed/simple;
	bh=sG9hHsaYimK1B4wz23rUYoo0pJSIxegc1K8hUR6DKL8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=frkycxBkC6YInTtgmQpD4X+Dh7tLVsqPrOXtM6w5gitaJ5dXfl38yCXeXsQjYVqTR8Pb5rHL4y15SKVBVkWQlH63UacucmRvV1uW/uQXgQAyrMGl6/esr0tv0nOiwqTYBoU/NbfzUUdC0Ursknw12OqSk9SS1YrSYPyRjWd5k+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZpm+Yke; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AFDF4C41674;
	Fri,  8 Mar 2024 05:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709874037;
	bh=sG9hHsaYimK1B4wz23rUYoo0pJSIxegc1K8hUR6DKL8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FZpm+YkeyzCpwAPxSaIWcj0TkWJHQ1W9t1C9pqfBda/zKmlTtxuQvLDF08BoHF92G
	 KR2wRyTRcxFPTNDsb9qVRzvhpvF2MDemCKnoT5JR4md9TxjQk54PvWuGmoeasn3WlL
	 otXNjl7PdWEs+edojutXfkpplflV6RkcoXYyBr/wCZmG49LJdPxqeC2oz3gHgK6VPt
	 gzNWylkoH7dkBc13qUPggpWTxiCVZHm+ORz/3LrINkYa+3cL3H2MF2C2f62kiNocqx
	 ONDRk1hK+2O8p9wm03PsBbYCXPcyVyPMlPMOEu4LznewjZCKvaecF7rZ4VinnhMvMb
	 yRV+BaQrrXKEQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9D64ED84BDB;
	Fri,  8 Mar 2024 05:00:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: mv88e6xxx: update 88e6185 PCS driver to
 use neg_mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170987403763.8362.3667469523942724138.git-patchwork-notify@kernel.org>
Date: Fri, 08 Mar 2024 05:00:37 +0000
References: <E1rhosE-003yuc-FM@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1rhosE-003yuc-FM@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, f.fainelli@gmail.com,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 06 Mar 2024 10:51:46 +0000 you wrote:
> Update the Marvell 88e6185 PCS driver to use neg_mode rather than the
> mode argument to match the other updated PCS drivers.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/dsa/mv88e6xxx/pcs-6185.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] net: dsa: mv88e6xxx: update 88e6185 PCS driver to use neg_mode
    https://git.kernel.org/netdev/net-next/c/84c49aac0ea4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



