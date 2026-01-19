Return-Path: <netdev+bounces-251122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFCED3ABD6
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 15:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1C924304C710
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 14:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1465B37E2E0;
	Mon, 19 Jan 2026 14:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pmUW/8Tu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66A737C10D
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 14:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768832571; cv=none; b=VfTaw73fa6UB5lQCcDcPYhr64OxBgGOArCD42doL08oDKo7mIugJ44p5iVeyego2hjLmxFloICitkWx5IM4rV2xWJXgA717YUPFE06syjOductckp+7s1iLH4bcAjh0SdzMBsaD5fz4/2jsn74hRRlQIyrrzox4knWAj4O7WIp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768832571; c=relaxed/simple;
	bh=iel0DGd+o7YdAm/0CQY6DbLhXg4Ch8q2C+sIyw5cVsc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oSV3V0YniJcan2m1nUaLkbZeuOUiE92n66SCeFIuiADhMDDOhdzFjE2DGeB8vmxKxG3PC3Z4jTdKFWomw33HazsgbTWUSOZN+nckAYUzgD9lMQEyiPZVJCRZGCXiwT7ACgYvMJwRRLttZn42244Bo1a2vv0EmadafApBZtzDcvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pmUW/8Tu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77E53C116C6;
	Mon, 19 Jan 2026 14:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768832570;
	bh=iel0DGd+o7YdAm/0CQY6DbLhXg4Ch8q2C+sIyw5cVsc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pmUW/8TuBqOMdEh45Xlya+A5LFhiUXZft+YkLYZz4MX4TTLLgBukSekW26UUGCdkX
	 qfIn6ICpmnU59KzLoU2ByoGuW6poqy/zlv/SpaKB4T0Um/6RZ9vdGfFy5EeZQD0JhP
	 mm9x6VxltaUS7QnJ8v++HTqT8EYHEMKgxuMLsGbYTAyrI0mYLU91wXq89X1VzT3/LE
	 fcjZ/XowaofkMOrgURSQlr6CRWBHZq5GRuAGsADPX9WvlvKAgKu763o3oQ4TPM8twP
	 rQ+ziX0YQ2wCJh7uFYWF4sQM0U2ybqAFvhr5TpmUDL+cSustp0arkyYD81hX7RJUMo
	 Vo5eGNM5rFnVA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7891E3A55FAF;
	Mon, 19 Jan 2026 14:19:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: stmmac: fix dwmac4 transmit performance
 regression
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176883236002.1426077.3751892963025257662.git-patchwork-notify@kernel.org>
Date: Mon, 19 Jan 2026 14:19:20 +0000
References: <E1vgY1k-00000003vOC-0Z1H@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1vgY1k-00000003vOC-0Z1H@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 16 Jan 2026 00:49:24 +0000 you wrote:
> dwmac4's transmit performance dropped by a factor of four due to an
> incorrect assumption about which definitions are for what. This
> highlights the need for sane register macros.
> 
> Commit 8409495bf6c9 ("net: stmmac: cores: remove many xxx_SHIFT
> definitions") changed the way the txpbl value is merged into the
> register:
> 
> [...]

Here is the summary with links:
  - [net-next] net: stmmac: fix dwmac4 transmit performance regression
    https://git.kernel.org/netdev/net-next/c/5ccde4c81e84

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



