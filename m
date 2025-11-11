Return-Path: <netdev+bounces-237424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0BFC4B373
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 03:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 539D618934C9
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 02:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEEE3054CE;
	Tue, 11 Nov 2025 02:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qrMIyZw6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9B97082A
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 02:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762828242; cv=none; b=q/lMv036zd/asQg4uKRrg3uemdgUtC+aqKtNEpmcfznw0o2vRt6d5L1BCyPUJ2neWUxkQBY+qCZ2lzWUwJhWgjQa/Mc8KZDliR6YwIK1CaHQsnakCWLNXP14AWOMFl0pUYEY33i2wyB9C2Yle9soTWe/LX6ruBRQ7GFoM00XSAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762828242; c=relaxed/simple;
	bh=toZi0xOBzJTVNr85M2IMKvMs7J8fEKOog5EbQujjrr4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fwQzM1JyU3R6/rg2ZeyI7RcFQxkyjM30Xmozs6caWgCuFj7f30LSFlUwXINQtCCY2lK6UtIacZNU/GM7B5IvL0dWQF/vYi2mOo5cYQKhd7UjFWfKKG8z4rSPehsEhwwNe467AM6U/A6ZNklc1E/Ty3Uo+Lo0y6SXiCAJyJX5Png=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qrMIyZw6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B7B2C2BC86;
	Tue, 11 Nov 2025 02:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762828242;
	bh=toZi0xOBzJTVNr85M2IMKvMs7J8fEKOog5EbQujjrr4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qrMIyZw6Vk1wWJjMyk3GSxT4P4Bu79+So2lsXixM0w8kVvMS6fweQUDVtdRW1rVZk
	 llITtOhlqJNBVDLZbV0JXrPLaTIlS9CA/sBw/UNM9uSYY0EQAqysGw/TJDfwGVhJ2F
	 FnpTeznd9oeSsLFJdbYe5sppczjWVmiWyAPitI4b/pvdZBvJKU6as0BGpBq6++ePPQ
	 J7DCYDHXOd5Y6A2tvebLGhxHoML4N556iXjXiQ6P1HJFIY+F00N+ugoFLVdQAAnw1c
	 LK1QVXMySE/PmVmhjTCRCfIUFlZbPpwdQMPaM+nXQr36X4X7/KiaCqHxllksXN/QJQ
	 jnRDrg1K4oLMA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EC430380CFD7;
	Tue, 11 Nov 2025 02:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: loop: use new helper
 fixed_phy_register_100fd to simplify the code
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176282821274.2856551.3861629047302770070.git-patchwork-notify@kernel.org>
Date: Tue, 11 Nov 2025 02:30:12 +0000
References: <922f1b45-1748-4dd2-87eb-9d018df44731@gmail.com>
In-Reply-To: <922f1b45-1748-4dd2-87eb-9d018df44731@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: olteanv@gmail.com, andrew@lunn.ch, pabeni@redhat.com, edumazet@google.com,
 davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 8 Nov 2025 22:59:51 +0100 you wrote:
> Use new helper fixed_phy_register_100fd to simplify the code.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/dsa/dsa_loop.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)

Here is the summary with links:
  - [net-next] net: dsa: loop: use new helper fixed_phy_register_100fd to simplify the code
    https://git.kernel.org/netdev/net-next/c/b981e100c19d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



