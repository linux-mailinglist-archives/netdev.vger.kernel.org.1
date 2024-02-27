Return-Path: <netdev+bounces-75222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9B2868AAF
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 09:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCCF3283D9E
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 08:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FA056465;
	Tue, 27 Feb 2024 08:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rf91JTqS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9305786B
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 08:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709022028; cv=none; b=V9FNDaJh5R9Lebs9+8w2kJMrPGfU0HrmYdd8pdOoMwmocGrs/vgwnzlAMQPhVgyo3aNwMRRvJ7ZFrG+3ilzLEP6WJgirTm7CKPcucDADCT9q1CbAnWjscRopluEHh0gg9zXJrBSJun76LOIP924U7fknMQs1j4BT8yDlgsZ5Kdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709022028; c=relaxed/simple;
	bh=CujN8ziOpSGZNOsHvLSruAOrGyQZGwG9eqszp5x9qHI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OaTmnNdsBh7w1L29E10aW6uBZf4xmOTf7ShVzq1eKQGDzBufCCbMmRriWJe/uvNWN8cEA5OSz4x0kZECawkK/9kOmhxtQHVdQVEPGN/zWQ4CswSrS7uSIMYYM4ltL1A0bFRWtHHQtdnrwAxRrhS7qgiBPirCuQOvMSe2VAHHpTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rf91JTqS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 12B1BC43390;
	Tue, 27 Feb 2024 08:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709022028;
	bh=CujN8ziOpSGZNOsHvLSruAOrGyQZGwG9eqszp5x9qHI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rf91JTqSqGyJS5gB8/l02ujSyVISmHckBVKQVlSb5BFJWQTDftL+If6j7s8hDstFW
	 jCxyrH8Qhnwb4+kBTnhFzqYC2XW38uDhpdgRnDHMpkTfuMip1ncumiCko+zXHanldT
	 MINkiiwXpq49ywlstDKz00bxcCyRYpEUnxpiyRQQ4LqFCtWgx8stk4pDm6DRYzE5i+
	 XJkxpffoMxLdpcXTCevpGNVWEk7y/avvPXP1mEZQ5UrCFuoSGv39OYRyr/2pap3Kqu
	 ewBnSX3Vw+Vodmh6B4Vms8bdptOWMMI0XmpB0nF9tIgbdHxP4/tPez2mWjxMM47CAR
	 SAkyVfxEYNu2Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EB7CCD88FB0;
	Tue, 27 Feb 2024 08:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: simplify genphy_c45_ethtool_set_eee
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170902202796.11569.16085442551536026354.git-patchwork-notify@kernel.org>
Date: Tue, 27 Feb 2024 08:20:27 +0000
References: <442277c7-7431-4542-80b5-1d3d691714d7@gmail.com>
In-Reply-To: <442277c7-7431-4542-80b5-1d3d691714d7@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: andrew@lunn.ch, linux@armlinux.org.uk, pabeni@redhat.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 20 Feb 2024 22:55:38 +0100 you wrote:
> Simplify the function, no functional change intended.
> 
> - Remove not needed variable unsupp, I think code is even better
>   readable now.
> - Move setting phydev->eee_enabled out of the if clause
> - Simplify return value handling
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: simplify genphy_c45_ethtool_set_eee
    https://git.kernel.org/netdev/net-next/c/b38061fe9cfa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



