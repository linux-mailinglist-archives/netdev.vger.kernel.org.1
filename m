Return-Path: <netdev+bounces-240623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C00C77027
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 03:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 85ED134C540
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 02:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF72D279DCE;
	Fri, 21 Nov 2025 02:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBd3l9ak"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8501E279334
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 02:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763692261; cv=none; b=bbecUC4jmhZigMmr198yNVzntrJXjPzuQ+tmOe/YluItbpFNyQKKF8wqpxsW99NqIh0gSlTlebtAr6S4WTEvDauHToipNc+s2WFC100+Wq3zzt7PIDS3IvpEoDeEvVxo4AMTcHmrtRimCwim+Vzcd7Hgyaxp9b+6AoETIIJFCjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763692261; c=relaxed/simple;
	bh=3yKTr0Cdw9W0EuR5wWtIFRMyY6jj3XceSZAn/BKNoqE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aH099wHGMH0A8jxl7Q/iclM71GR0RzZxcfFouxLLPZyIlkKt0zcG7Nw9f9UjQrL2uBUN+4T3Cy7rHswSSUIeEFrfxSXii6rbhpxbsjG7siPvTh2M78KjfCaEMz4pIQHjpGLyuDavV5G1cbOPlRjBo3aaz/8jDCYJGZrkQ7/wW6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBd3l9ak; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFAD8C116B1;
	Fri, 21 Nov 2025 02:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763692261;
	bh=3yKTr0Cdw9W0EuR5wWtIFRMyY6jj3XceSZAn/BKNoqE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aBd3l9akCqc7+VaaxKt8E+RzkUL/PpGaRbIzkOXEmzM4CX5K+UrNfXIENjgGUb+7v
	 6OHvJyPIZe74kx+86PmfUshfXPeC9bD135g5wXRdQJJOuUnKNYWDAUphDrD2RPnq4M
	 M47N4lg6ROmkZKsMCD8sKxQGlYRBnIl48vj5lKY2XY4Iv8Zyf+zObXBOpCE6fr6g/N
	 +AECejqNQWVW2F63UX4qsihSAIazPHLkLoH3zVLDOUf/fbUwcFu1nhC3CtcmdGBVxk
	 nCg7v1b45YxCWQkOy2lj9fH5MEOaZ7c3UOztq8hNa2id1wC2dQnoJTdXA6Jlda8M3x
	 4PLJ/x2QrG6Mg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F883A41003;
	Fri, 21 Nov 2025 02:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: fixed_phy: remove not needed
 initialization of phy_device members
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176369222574.1865531.6277105012964028365.git-patchwork-notify@kernel.org>
Date: Fri, 21 Nov 2025 02:30:25 +0000
References: <bc666a53-5469-4e9c-85a1-dd285aadfe4f@gmail.com>
In-Reply-To: <bc666a53-5469-4e9c-85a1-dd285aadfe4f@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: andrew@lunn.ch, linux@armlinux.org.uk, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, davem@davemloft.net, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 19 Nov 2025 07:55:47 +0100 you wrote:
> All these members are populated by the phylib state machine once the
> PHY has been started, based on the fixed autoneg results.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/phy/fixed_phy.c | 7 -------
>  1 file changed, 7 deletions(-)

Here is the summary with links:
  - [net-next] net: phy: fixed_phy: remove not needed initialization of phy_device members
    https://git.kernel.org/netdev/net-next/c/d99b408ed8e5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



