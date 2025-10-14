Return-Path: <netdev+bounces-229199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 805E3BD916B
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 13:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1460D4FB735
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 11:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA66B2F6588;
	Tue, 14 Oct 2025 11:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5TwHJRh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89799296BD1;
	Tue, 14 Oct 2025 11:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760442388; cv=none; b=Y1VVH90SpXbzxiFWgCEFXL3f2KY8C4bfksi6xpJr3ORQJ0QPGzpNNtTGTR5n3RpLPuXkcljd5LlIzGTPXeHYoC/amRADOCoXc/8QMRDZ+cShr2jcS+MiQQLgwyMNBN2a2ue49aroyklOOAESJw7n7jP4r56FGJO9fZv3PlTZ5E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760442388; c=relaxed/simple;
	bh=vcIGTHRCj5MmeQHSbDtUZ67MD6ygHFobH9RTcibtcrI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=s+bpmbryhZ0U3r83odffHHuv4dMFndOrWfoV6pmzdNeOFgqQ0nMebTiAC9Y38pmm7MOieIxzLXMfUVPV7LoOjmMZ/js3T7JBc7pMoUcgv2Zm71NmQHZ5oUCptDz72GkJZDNRvduDaiAua/PhVtZsGT2MG0xFyd9rMPDayp3hk68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5TwHJRh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F53C113D0;
	Tue, 14 Oct 2025 11:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760442388;
	bh=vcIGTHRCj5MmeQHSbDtUZ67MD6ygHFobH9RTcibtcrI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P5TwHJRhOL1gpHd7lIHK9nEUxL+Xu+GrT+MVBVwGDBRxkriSKBVEAa4Sv93gkgWK4
	 W5Lznls3NSmUb6WyGQNTCkbe0RA+VNP9kXTfRvoda3t72KsJShABMv/qlEqgFBQU8Q
	 pBBgjC6fZcUV4F7NwvTxJ9JnoePeeCdpDRaaRIa6/qBGemoVN93R3yngVB1FI0OJ3l
	 2Hw6AqK2BxCYlhGyBnl7hmJQgnbirDO5en8vz9JkoAZ3mHg3MHnJ0PtBom2g1lmdt2
	 4b2YEAnUeBT6a8XS91VniyiQgLT/mr223p6uxT17BWHedpZDRf6hMmD0nx2OG42Q2i
	 qOthaS5zdO7NQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE3D380AA4F;
	Tue, 14 Oct 2025 11:46:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] hdlc_ppp: fix potential null pointer in
 ppp_cp_event logging
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176044237324.3633772.6732423895611911042.git-patchwork-notify@kernel.org>
Date: Tue, 14 Oct 2025 11:46:13 +0000
References: <20251013014319.1608706-1-kriish.sharma2006@gmail.com>
In-Reply-To: <20251013014319.1608706-1-kriish.sharma2006@gmail.com>
To: Kriish Sharma <kriish.sharma2006@gmail.com>
Cc: khalasa@piap.pl, khc@pm.waw.pl, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 13 Oct 2025 01:43:19 +0000 you wrote:
> drivers/net/wan/hdlc_ppp.c: In function ‘ppp_cp_event’:
> drivers/net/wan/hdlc_ppp.c:353:17: warning: ‘%s’ directive argument is null [-Wformat-overflow=]
>   353 |                 netdev_info(dev, "%s down\n", proto_name(pid));
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/net/wan/hdlc_ppp.c:342:17: warning: ‘%s’ directive argument is null [-Wformat-overflow=]
>   342 |                 netdev_info(dev, "%s up\n", proto_name(pid));
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Here is the summary with links:
  - [net-next,v3] hdlc_ppp: fix potential null pointer in ppp_cp_event logging
    https://git.kernel.org/netdev/net-next/c/3dacc900c00b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



