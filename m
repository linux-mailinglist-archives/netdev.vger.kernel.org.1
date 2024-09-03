Return-Path: <netdev+bounces-124496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA58B969ACE
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 12:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97031286353
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 10:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E30A1CB52C;
	Tue,  3 Sep 2024 10:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o5KjDK1W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660BE1A0BFD;
	Tue,  3 Sep 2024 10:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725360629; cv=none; b=Oqt+dLGkEKes3zwV44+b2z4KQ5AiEnXTKkx5WLPfxix5lCIQHWe5YPkEcwNG0o+bvnIvC+z4Y8am0ALw6feODFtSbfdqnbax+AJ1eb/ay2pd4BELw1kmfxXkZmc2mOIRA27FmYmzscu0BAOYldbKjCF/NrxmlVRyhkFeKEysKsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725360629; c=relaxed/simple;
	bh=QjRKkTcjVYnnxJPoVNjGx6/Ls3fonC7hPfc/7SboZ5w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pQIuUjy6KeBvKMME2gmFjLMQI+4qUKX7gE+2hhhmCh5RrF0MNwYD0ay8qodA3+dT1YwlCiquqeiUei71nJSAnt8uo/9XDwIvHJ0qkNAZutWvFoM6Xd0LINNPn5wYZdqoKTJaqBIOX+oG/e1FC5d8unHRFDN/mTtta+jPoZXgBJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o5KjDK1W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B495C4CEC4;
	Tue,  3 Sep 2024 10:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725360629;
	bh=QjRKkTcjVYnnxJPoVNjGx6/Ls3fonC7hPfc/7SboZ5w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=o5KjDK1W2HOZHZq1zXQV6aG8wIYaKwE61YXaUgkjjiD165b6NkB/piiSwMSx9qw9N
	 2a7ZAJ8+p9Lx9HJ3CljbO0lqEpHlT9WsN35cqtjvDrh3Kmyoj36kfESLSaZmgly83r
	 G9hRX5HYL7rKISD/Akyb+HEWRjbQypJ43bweFhsWzpdwi/uZQ9pnjaO2cA4FKiZpMp
	 NTlqFBGN1EDcUG+m/Z5+YGBDUesFZ2iMUsriVEuEAfPFUG7QpexDtdFQha5aeQVs/b
	 SQvRurBLL7qlNW3JtLSxhlFuvDAmtmVfeTn3YpeZrfULcfLrv7XKhUKkGOYe4YbM2w
	 IHAS0LIb1Jzgg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEC63805D82;
	Tue,  3 Sep 2024 10:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] net: phy: Fix missing of_node_put() for leds
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172536062976.252561.14904161463456653895.git-patchwork-notify@kernel.org>
Date: Tue, 03 Sep 2024 10:50:29 +0000
References: <20240830022025.610844-1-ruanjinjie@huawei.com>
In-Reply-To: <20240830022025.610844-1-ruanjinjie@huawei.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 f.fainelli@gmail.com, ansuelsmth@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 30 Aug 2024 10:20:25 +0800 you wrote:
> The call of of_get_child_by_name() will cause refcount incremented
> for leds, if it succeeds, it should call of_node_put() to decrease
> it, fix it.
> 
> Fixes: 01e5b728e9e4 ("net: phy: Add a binding for PHY LEDs")
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> 
> [...]

Here is the summary with links:
  - [net,v4] net: phy: Fix missing of_node_put() for leds
    https://git.kernel.org/netdev/net/c/2560db6ede1a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



