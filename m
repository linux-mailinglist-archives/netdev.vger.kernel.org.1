Return-Path: <netdev+bounces-144668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 768B69C8140
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 04:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9D171F24E9C
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 03:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4DD1E9060;
	Thu, 14 Nov 2024 03:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="By3ianoe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8962D1E885C
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 03:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731553242; cv=none; b=ZQjnhTFLyXThlz8NqmymlJywDDv9dbmtrXV7dXgdCw4ky/17DNgxL87MJF0LNltEK3yXpPx3V89KMQ4eoFhPbc84Q7plAjrz50xoRX/uifFm5EkhU3K5KHKtknPfBl9AOVrunWuLFVWM+UOZ4X3iP4PJGjH5FHgvCr5crFc5N/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731553242; c=relaxed/simple;
	bh=HmMV/SkzfTmGC99WcA8f4ZfMi6U+B+sJDLhYBqNj1Tc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=USEbIzr7sQhXxHUwUbWmKkGNkBBdMGq6kqEXROFlnou2eO5pRt3Xxl9zAb1apDU7UYJmQKTIH3NfhkYC/QbdBYdsLSPLyHP4FeQacRVyWgLLKS+ZD/Jj1H99CVKVTQXCnmCLqIflbU3rfVhjn4Vo5TBHGgzgdUai9mnVUphYEzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=By3ianoe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 188E1C4CED2;
	Thu, 14 Nov 2024 03:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731553242;
	bh=HmMV/SkzfTmGC99WcA8f4ZfMi6U+B+sJDLhYBqNj1Tc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=By3ianoeq8ndQppknVJKlpagyyEZKNBzi9UPpMaX5u/ADjJZczXm+zXEFNY+IQj80
	 s3A30hc4t7AWpuVdLLhjWeBPHSThGW7gCXZmJtJ11Pci2RznE6TzCUwrrQCcJ3XAOE
	 ZS70BaKUsYnYY5JWpyOsBZZ8QXU7k0DLPD+QEfio55iCSkTJ5E2y2NMm2gdLE2g5Ut
	 SMsj94auZf/zhvyr7A3/B7bun731NAAAsTP1gJfq+aM7dFLwPQxuRy+WqSsUT0sf1n
	 2P6XhxbDgGn/yy48jPJLZO/YEwDq9tHCdhad04q8MNDNSsISq6vl06Fk9xh7hrmlBg
	 IJlC7rjB4P4UQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCC83809A80;
	Thu, 14 Nov 2024 03:00:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: c45: don't use temporary linkmode bitmaps
 in genphy_c45_ethtool_get_eee
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173155325239.1464897.16456366423295726290.git-patchwork-notify@kernel.org>
Date: Thu, 14 Nov 2024 03:00:52 +0000
References: <b0832102-28ab-4223-b879-91fb1fc11278@gmail.com>
In-Reply-To: <b0832102-28ab-4223-b879-91fb1fc11278@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux@armlinux.org.uk, andrew@lunn.ch, pabeni@redhat.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 12 Nov 2024 21:33:11 +0100 you wrote:
> genphy_c45_eee_is_active() populates both bitmaps only if it returns
> successfully. So we can avoid the overhead of the temporary bitmaps.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/phy/phy-c45.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Here is the summary with links:
  - [net-next] net: phy: c45: don't use temporary linkmode bitmaps in genphy_c45_ethtool_get_eee
    https://git.kernel.org/netdev/net-next/c/3bf8163a36ad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



