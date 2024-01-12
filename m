Return-Path: <netdev+bounces-63172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0356482B897
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 01:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F3772882A7
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 00:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BCF379;
	Fri, 12 Jan 2024 00:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IWEBgI4y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082E7A54
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 00:30:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A4893C43390;
	Fri, 12 Jan 2024 00:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705019430;
	bh=FhgWUPVVgvgq5B9VGzMUAQX6+jg5nzuwSG0Fu4aLGhk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IWEBgI4yxeZFhhqa3X6kju+7FGmD0ioHG4AYFlsFUTr2/ccFlXJlsD7cVva7xBDEg
	 BMD8u+/XLrNFne6rdA9uMbpnS+gYvOgWZbV+WL0ngPK15vBrgQ738bDR7z56pHlc6x
	 PLOeW9z2Xp86otGA1ee/rcX3K+fdeG5D/kVu14X7KvHIln/Pl6A+5A99QoI/yUVplv
	 B0Uy9qm1NZ6J/FI7BuK6bB5IU2Qzj1zR8bdrjX3EpFC1OyHauXGG20q0lAW9e385MH
	 COMYV/pZoXSyk//k1YoHHef5HrYBYWLxPiV1UnGCQUsyaNiUKFjvKMtjlcA/W+mQ2i
	 YXijqFCXn3IoA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8E71ED8C975;
	Fri, 12 Jan 2024 00:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/10] Fix MODULE_DESCRIPTION() for net (p1)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170501943058.11195.2342094708140881647.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jan 2024 00:30:30 +0000
References: <20240108181610.2697017-1-leitao@debian.org>
In-Reply-To: <20240108181610.2697017-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  8 Jan 2024 10:16:00 -0800 you wrote:
> There are hundreds of network modules that misses MODULE_DESCRIPTION(),
> causing a warnning when compiling with W=1. Example:
> 
> 	WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/arcnet/com90io.o
> 	WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/arcnet/arc-rimi.o
> 	WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/arcnet/com20020.o
> 
> [...]

Here is the summary with links:
  - [net-next,01/10] net: fill in MODULE_DESCRIPTION()s for 8390
    (no matching commit)
  - [net-next,02/10] net: fill in MODULE_DESCRIPTION()s for SLIP
    https://git.kernel.org/netdev/net/c/e1b1d282d5cc
  - [net-next,03/10] net: fill in MODULE_DESCRIPTION()s for HSR
    https://git.kernel.org/netdev/net/c/417d8c571cb4
  - [net-next,04/10] net: fill in MODULE_DESCRIPTION()s for NFC
    https://git.kernel.org/netdev/net/c/95c236cc5fc9
  - [net-next,05/10] net: fill in MODULE_DESCRIPTION()s for Sun RPC
    https://git.kernel.org/netdev/net/c/d8610e431fe5
  - [net-next,06/10] net: fill in MODULE_DESCRIPTION()s for ieee802154
    (no matching commit)
  - [net-next,07/10] net: fill in MODULE_DESCRIPTION()s for 6LoWPAN
    (no matching commit)
  - [net-next,08/10] net: fill in MODULE_DESCRIPTION()s for ds26522 module
    https://git.kernel.org/netdev/net/c/ade98756128a
  - [net-next,09/10] net: fill in MODULE_DESCRIPTION()s for s2io
    https://git.kernel.org/netdev/net/c/c155eca07647
  - [net-next,10/10] net: fill in MODULE_DESCRIPTION()s for PCS Layer
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



