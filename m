Return-Path: <netdev+bounces-219344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC8CB4106E
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 01:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACFDE1B6229A
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 23:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08855BAF0;
	Tue,  2 Sep 2025 23:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cIW2o0mL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD561A288
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 23:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756854020; cv=none; b=E/4FsULWqNQHjczm4JJ4du1dslUWod/7BS365MFS+t7nVgk5BQSWxtkQa1lOaT5zFHyxT3cgFvyywyp7H9jEaCxTI+UCgmsE7JjnMHw2EbQ/cCB71HwcSiHBJbHTCagUFSV758mD/AoQadFIxF9YPz6JO3J2/qVJtbwqGtHButE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756854020; c=relaxed/simple;
	bh=ZWB2SiqxkoXLfk75TqzSpO1gqx89D8mmAY5p9n8fnLI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gVEYPmW2TD06Xvr4zLnqjS/DxfmRCTp05XPdcpoPhWgS3H7ReidBcYPp4SuNVLBMkBrfUwqnjxpSk/CUVnlL3WPu2m+tzs8pZTxiN/9G/w6uGJlr2yZKNYmYUMGeEZG5DQGFzvi0ys3BLG0lUhhIyN5SLHSrY0M9rfJZSYZWtUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cIW2o0mL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D5BAC4CEF4;
	Tue,  2 Sep 2025 23:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756854020;
	bh=ZWB2SiqxkoXLfk75TqzSpO1gqx89D8mmAY5p9n8fnLI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cIW2o0mLUSlzU7yxeOR4dQ4S4N8c78jmvxQ5zzjFdiYi8X0mqELVOS7DEDZHMVeka
	 JteV5I0Lq55qOOuao/u1TmiZ7ynaFk/zZqFjUF9PsjIC5tDWqwhIbsjLW/9juuX4tT
	 WKXSqGHmmCmoAp0jm3LjevQg+L2ph2Qi9tYHGkv9YIAPi7W8FW5zjKTFfxFuL370Cy
	 gpA+Bhcb10P2p4936g/xq2tui3W2WvZ9f/S5KXNtQkuwaP0gYUKAFg9aHtOpaJKQ8M
	 TBqOH6Oz8VPPIe6+FQrFCfK1VY6DVGebQUkiGBd3325zNeVvz4ved//HpouhL8u8fb
	 VcvDlC3X6UX9A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D49383BF64;
	Tue,  2 Sep 2025 23:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: mvpp2: add xlg pcs inband capabilities
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175685402599.461360.856481848373648217.git-patchwork-notify@kernel.org>
Date: Tue, 02 Sep 2025 23:00:25 +0000
References: <E1uslR9-00000001OxL-44CD@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1uslR9-00000001OxL-44CD@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 marcin.s.wojtas@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 31 Aug 2025 18:01:51 +0100 you wrote:
> Add PCS inband capabilities for XLG in the Marvell PP2 driver, so
> phylink knows that 5G and 10G speeds have no inband capabilities.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> The lack of this patch meant that I didn't see the problems with 10G
> SFP modules, as phylink becomes permissive without these capabilities,
> thereby causing a weakness in my run-time testing.
> 
> [...]

Here is the summary with links:
  - [net-next] net: mvpp2: add xlg pcs inband capabilities
    https://git.kernel.org/netdev/net-next/c/99502c61e80c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



