Return-Path: <netdev+bounces-145522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C019CFBA0
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 01:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B4B3B2BC63
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 00:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DD3184E;
	Sat, 16 Nov 2024 00:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uyH3FFSS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139DC10E9;
	Sat, 16 Nov 2024 00:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731716417; cv=none; b=AX87FidnQ7Vk20Cw8OZkMukZzoW68wUrbj/3wo2JoZffof0ZifdMtsl7JzlURhUj6NE5urepdEs5e4zRn8elCTUCF9XTVuvqNEYNjIR0KlIO0jb3NzyOiSwFA07cuqABRI5UJFGMsOY17Esg2e4YvBo0B9FZWPR+8jeeg3RolLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731716417; c=relaxed/simple;
	bh=1ObQtB5rkm++rVSRlWaXFVCFxZ687s3aiQ0sZIWrAlI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XP0WmI8hcuFWJx6ChpYbBE06QuAAYgf0YRNqXAAMsYYKO1hR0ZysKpIsnZUOZb/vHfRSSxHl5lmS/TaTmpOV+OAtVEuTbT0YoNk6oTdL5MA5tOQdv767ffxQrgULWe3TMlC6/sOdTWSPudunYI8faVGj48oZAy1FCVJ1vyMi41I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uyH3FFSS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E1ABC4CECF;
	Sat, 16 Nov 2024 00:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731716416;
	bh=1ObQtB5rkm++rVSRlWaXFVCFxZ687s3aiQ0sZIWrAlI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uyH3FFSSlwje6+6tCcPSR5DXOzq6Wq9dG6CjdiIvywIbc0gKLBXydaHprl/MFmNUH
	 tqj6C5XpClFVANqO0A1j7DrsbvCxKvhdmGGgrmxhvlXxErMWmxxKcX/nbhfeFKkyuv
	 5Ginyjpg9nW7m9kwAn1OBrCCSMY0hKBtZ4v7nWAcfmFPQgJDxEkuztGT0XBzrFuH4m
	 6tFuF+pAsN1uS9jXahqYToiqqCqhN5QMtvRC6eyQjWk7aGxFqHXExRzkK49I33otXP
	 VBZ9TzDeuFh1ZL7uSSVLeyM85gAv/Cr6NF05hep3ZyBjWEJm4zbnn9fkCXcxD6JZEI
	 zdGsZ9muzNXCA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BDF3809A80;
	Sat, 16 Nov 2024 00:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] octeontx2-pf: Fix spelling mistake "reprentator" ->
 "representor"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173171642725.2779297.12906858184939692054.git-patchwork-notify@kernel.org>
Date: Sat, 16 Nov 2024 00:20:27 +0000
References: <20241114102012.1868514-1-colin.i.king@gmail.com>
In-Reply-To: <20241114102012.1868514-1-colin.i.king@gmail.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 hkelam@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 14 Nov 2024 10:20:12 +0000 you wrote:
> There is a spelling mistake in a NL_SET_ERR_MSG_MOD error message.
> Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/net/ethernet/marvell/octeontx2/nic/rep.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [next] octeontx2-pf: Fix spelling mistake "reprentator" -> "representor"
    https://git.kernel.org/netdev/net-next/c/11ee317d883e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



