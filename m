Return-Path: <netdev+bounces-148784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F589E31DD
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 04:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04C7E282287
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 03:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DD1156962;
	Wed,  4 Dec 2024 03:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ts7VVDMS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DFC155C97
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 03:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733281822; cv=none; b=ag3iOLhK5xU8kvpRV/M91Yi3QLwJq3IxKMPK/gpjU/b08sRjFwIx6XnYl4ZrjW49b6LIWBaY2ukGn00ZYXayrt4KE5ZXsiFoDMggN4bwxJMY3Iy/dv+ReR+0wWzjVorQUHmZGjrcRDBjvYoC0jyVduuhEeP/Apl2kosefiE/ev4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733281822; c=relaxed/simple;
	bh=dldjZ6FjbJAhNwaUtz6Z28e7gnmKzQtlo2Q4bp+od3c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=N9BodXHgQnLPnK1KAxLCOSfjmgmubsdM3afCdykDhk7uRt7WRkPpWF/54u4Fn8OXTOUpo5YrI8Aa/ZBInJzSpwNdqDmlOAeMxR8DFXFlNHIXt8geDavFL4xETTsi4n8xw5qz/P1NzKbuOvoI+D1pytQ/9OnBArs7scdfQEIs/C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ts7VVDMS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 951C7C4CEE1;
	Wed,  4 Dec 2024 03:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733281822;
	bh=dldjZ6FjbJAhNwaUtz6Z28e7gnmKzQtlo2Q4bp+od3c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ts7VVDMS0T6gOULHIb+6RoGcGNiOSBzoSpN6XMhcHcQlprQ9wu4oKSHvGkIqv1ZN+
	 NgZDTZDeQdMHySalBI2Udxzt6UHlyW5E4KBjo2rRqxb+MBj7k5nlZd4NR1HAvZ/Mz9
	 u7n6cEn2/Cpnhltvw6wk154KARYn/ymzL6C/4x0C7zH1kR1RY7853dXRzJn1gj5JjD
	 v3qOLgxRScbbd/cKdLLG2hTx+eGeQr1RIrp77vvjdwh+PGrkmi8PhaP9m4Q3KGPa/x
	 Cm5npKV0k5IB1Ca86NELg1qDeD08/BRaNKs8yZgPVR3XlqP6onN5nAiveCFySylv/A
	 QJSHLMTAtwyng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 341453806656;
	Wed,  4 Dec 2024 03:10:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] r8169: remove support for chip version 11
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173328183674.718738.14975736117873223643.git-patchwork-notify@kernel.org>
Date: Wed, 04 Dec 2024 03:10:36 +0000
References: <b689ab6d-20b5-4b64-bd7e-531a0a972ba3@gmail.com>
In-Reply-To: <b689ab6d-20b5-4b64-bd7e-531a0a972ba3@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, andrew+netdev@lunn.ch, pabeni@redhat.com,
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 2 Dec 2024 21:20:02 +0100 you wrote:
> This is a follow-up to 982300c115d2 ("r8169: remove detection of chip
> version 11 (early RTL8168b)"). Nobody complained yet, so remove
> support for this chip version.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/ethernet/realtek/r8169.h            |  2 +-
>  drivers/net/ethernet/realtek/r8169_main.c       | 14 +-------------
>  drivers/net/ethernet/realtek/r8169_phy_config.c | 10 ----------
>  3 files changed, 2 insertions(+), 24 deletions(-)

Here is the summary with links:
  - [net-next] r8169: remove support for chip version 11
    https://git.kernel.org/netdev/net-next/c/bb18265c3aba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



