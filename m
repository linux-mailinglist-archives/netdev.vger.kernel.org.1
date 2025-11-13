Return-Path: <netdev+bounces-238429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 24929C58C8C
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 17:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B7C104EFBF0
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 16:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E0A35A94D;
	Thu, 13 Nov 2025 16:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/iCAXXK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC4A3271F9
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 16:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763050239; cv=none; b=gkKELAkoe3C1rZdK6C34m0C4ntpOwhRshZ7ifbCzbfKBbEczjbA/gLTHhf6QCErpj+Zsi3M0WsYv3jnsDgeRrbkqDZIrC9XgeRsCwmClcT+eWUxStH3gYCjRPlVNHNTvmksmytdTdGV/3dBW0NVyeFaHk9Kx0FCeUDXKU8GJVxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763050239; c=relaxed/simple;
	bh=ar/J7la8s0fj40xp4GiCiAlJdslTGn7uYA1smJ+0H1o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IQA8BnrMSVN9R0TYKWq3vUCWErIQNWPOs5NjTAyp3paoeXpXGGReNILQXii4S5+tyiF6/3/SZBefP9gShuepOzg1DedmUz+K9wBixRt9yLEmLDquUgPwkhRzlMaNSzbxYkMFhhcCYQShzFsf87ZqnjdOPFNW+ehoMdNQiSoaInI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/iCAXXK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D50DC4CEF1;
	Thu, 13 Nov 2025 16:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763050239;
	bh=ar/J7la8s0fj40xp4GiCiAlJdslTGn7uYA1smJ+0H1o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=n/iCAXXKC7XSO7b+UMgqZqQ2tnpepOXebi5CtmTlP+jqmaup8o9CUv2mjUFSGCso+
	 nRaA/IwsE5JfZHKODj+imNGnNtYI4lO3kfKrO8KbmtG1AS2N4LQhd2zu2Y3SuykQC+
	 VcbGhyeuk3jlas72rsmW2QCi0C/wEO87EygXOK/h4CyzbwQTr6mqwlNiRQpKafU6uK
	 fQ0sBofZBox0zMJGG6M6X1Obnb2fYeI/0Wc+xpbR09R6Eo2tomZBuXBaqkzXl6KtRU
	 uSXIfP2khZbjfJLF7LlpaTOuG1PKzbHHy35tiSm7YDOkBXfGD/xY+7AhijyRBxvMy5
	 5SkiaGAtzFWBg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDD9380DBD2;
	Thu, 13 Nov 2025 16:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: stmmac: clean up stmmac_reset()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176305020851.908070.9331102777618461950.git-patchwork-notify@kernel.org>
Date: Thu, 13 Nov 2025 16:10:08 +0000
References: <E1vImWF-0000000DrIr-1fmn@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1vImWF-0000000DrIr-1fmn@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 11 Nov 2025 11:26:39 +0000 you wrote:
> stmmac_reset() takes the stmmac_priv and an ioaddr. It has one call
> site, which passes the priv pointer, and dereferences priv for the
> ioaddr.
> 
> stmmac_reset() then checks whether priv is NULL. If it was, the caller
> would have oopsed. Remove the checks for NULL, and move the dereference
> for ioaddr into stmmac_reset().
> 
> [...]

Here is the summary with links:
  - [net-next] net: stmmac: clean up stmmac_reset()
    https://git.kernel.org/netdev/net-next/c/d0af55df5a78

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



