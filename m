Return-Path: <netdev+bounces-223306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCDFB58B38
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 03:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BD76523535
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 01:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D5B22689C;
	Tue, 16 Sep 2025 01:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kVN3WDzP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0DF22424C
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 01:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757986242; cv=none; b=Mw5g5CM1e08XXs6LBqaVUmK1Np6rct6nUVUFo6Sq4o+WKOmUb7V1FMLZWh0Ucx33Y38D8dZ6SVFOk0IlYYYost4/A2+QGyzekGvFVOFoy1Su49Gs0kFBiucYrnJtcZEsqXwjepJP3AnuXnFEjYlezOMs1c7lklJ02H4Cnj1IZ7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757986242; c=relaxed/simple;
	bh=oVZBNvAMtsmGsBicdWlVBaliYBpFKM5ICHsrfDkxVn8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mqYPszXzIE9lOzAxvhT1hcrecTxTbI5f55p0SPSRxdW4B4zoEDEeicZzf7YEkA2EgO76EwJCcBH4r1nrx9G9SusE6c5lw/e1qCfMwktFG8y/UFXn1/4ogooPoBLT8zMMMkTOQyRQMQvOXGZa/E+ysSR2zS+SmOcYCuZZ57wGsIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kVN3WDzP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD290C4CEF1;
	Tue, 16 Sep 2025 01:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757986241;
	bh=oVZBNvAMtsmGsBicdWlVBaliYBpFKM5ICHsrfDkxVn8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kVN3WDzP3LxWjNcCnpeSMt/kbS6y//V6UjP+ObcY3BxrqfajIfV3WbmwnEkIZjKiC
	 jJKA7EUiEBnm5vgQNCuE2tZQarmSKaZXlFeKeE7M9wO1CUi20riXJN1/X41q5cJxFA
	 rMybgrmzf6hO4GeHYtHQAEk+lV9c8PVSBzLmUoUXrBKNjDfdgqOd9FIMVRvJMTXiVl
	 sMotqOS78qnCcP2CKd2OUgRX6I+tyKif4Tng5efwkXniUYbd6HtWN4gFHRZluPGbjT
	 rwivLO9Khygvj1ERxzV8ynxJxzES1k8iygqZM9Bght/vLkEDX/jC9HvXT/eZ9+zhDB
	 eLFmwIVXU8SLQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C8539D0C17;
	Tue, 16 Sep 2025 01:30:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] r8169: log that system vendor flags ASPM as safe
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175798624299.559370.12302827590227780630.git-patchwork-notify@kernel.org>
Date: Tue, 16 Sep 2025 01:30:42 +0000
References: <a532b46b-ef68-4d68-a129-35ff0ee35150@gmail.com>
In-Reply-To: <a532b46b-ef68-4d68-a129-35ff0ee35150@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, andrew+netdev@lunn.ch, pabeni@redhat.com,
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 12 Sep 2025 21:11:23 +0200 you wrote:
> ASPM isn't disabled if system vendor flags it as safe. Log this,
> in order to know whom to blame if a user complains about ASPM
> issues on such a system.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [net-next] r8169: log that system vendor flags ASPM as safe
    https://git.kernel.org/netdev/net-next/c/4d01e55b1ac9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



