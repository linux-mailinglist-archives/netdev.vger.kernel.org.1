Return-Path: <netdev+bounces-142185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 304869BDB69
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 02:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6F71284900
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 01:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B85B174EF0;
	Wed,  6 Nov 2024 01:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2KUKoGO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F8433F3;
	Wed,  6 Nov 2024 01:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730857821; cv=none; b=cX4tZembM5b1vmiw9gWVC8ELCd4HvGhVn42AKI71ees3gf1jLm0XshnU4Mldwg9V48DhJK93dcjfGM4PTvR/a4F58hZv4OvAhXlR/wfFF/2AwJKUzNk5Hxs7wytTbB0loFyh6ZWl1iiUNBlMW4Sz49uxgk5Tlg9pTnyg+1iBhqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730857821; c=relaxed/simple;
	bh=L6P3STORHXz/IlH6rKF7obNTMBxK6fdL5lQ/Pm2GVjU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=anh97OkCArrLPPZU/XEr/0rCFmbIPeV0KISB6tnK4x2jok5PjHzzr0LTbSY0nmi5ViBjHpTtQZHQGo5Y1ey1+Z2FKxzhjfzWlLBZkxsz2LKinZ0UdPZnVtju1S1lv1d6BTbWvGg3052C4BBgMNpLtkBsWrw+2TkDYPRmsFJX5qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T2KUKoGO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E02C4CECF;
	Wed,  6 Nov 2024 01:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730857821;
	bh=L6P3STORHXz/IlH6rKF7obNTMBxK6fdL5lQ/Pm2GVjU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=T2KUKoGO5YU25JFYhcCdBnYk8DoFLQKtJ4+P2aG39F3I0KznOa+rA/drSProKPlsU
	 1dCaisyfGpthrbIg0qZrr80+nDTUw1i8217Z9EY4m84ask47flrNjHuzo8P5h7IAkh
	 i+jbY3lJOaX4NbZFmstDIh+9kSDkUq70dXrdkba9JWd3pE9WBXS9yBLCbAfpTH408c
	 rRZobsHAbDyX2QkRHZJl/CcFji/AjcjNLpSg8lu+mDQzjbHZJYuvjyQ7MnecUHpgIw
	 vZG8MEV8G4KhOWMkOrtfOOep7Z09UEew55c1q0aJ+N8Rs0qHee8Yt55AwShJzZXQa9
	 MlMImzp5to2Sg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 717AE3809A80;
	Wed,  6 Nov 2024 01:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: phy: ti: add PHY_RST_AFTER_CLK_EN flag
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173085783025.762099.6107128022531561396.git-patchwork-notify@kernel.org>
Date: Wed, 06 Nov 2024 01:50:30 +0000
References: <20241102151504.811306-1-paissilva@ld-100007.ds1.internal>
In-Reply-To: <20241102151504.811306-1-paissilva@ld-100007.ds1.internal>
To: Diogo Silva <diogompaissilva@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, marex@denx.de,
 tolvupostur@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  2 Nov 2024 16:15:05 +0100 you wrote:
> From: Diogo Silva <diogompaissilva@gmail.com>
> 
> DP83848	datasheet (section 4.7.2) indicates that the reset pin should be
> toggled after the clocks are running. Add the PHY_RST_AFTER_CLK_EN to
> make sure that this indication is respected.
> 
> In my experience not having this flag enabled would lead to, on some
> boots, the wrong MII mode being selected if the PHY was initialized on
> the bootloader and was receiving data during Linux boot.
> 
> [...]

Here is the summary with links:
  - net: phy: ti: add PHY_RST_AFTER_CLK_EN flag
    https://git.kernel.org/netdev/net/c/256748d5480b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



