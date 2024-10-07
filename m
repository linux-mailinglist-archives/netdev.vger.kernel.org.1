Return-Path: <netdev+bounces-132903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FACB993B53
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 01:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7845284F9C
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 23:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2A9193097;
	Mon,  7 Oct 2024 23:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DV4p0uHp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D069B193082;
	Mon,  7 Oct 2024 23:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728344433; cv=none; b=KxVaAhObwN+elM1LsYdbeaR6dVb5viXwnOvadfYTUYtIsylvqaiqJgKTJHa0nJryHcyPGN5Ib9HtfHFypnWMP5WyowDh50AN/VbKuvPTF5Soa/g8G8bHlP4VIH7HA8Z26Ub19Xr1l0K9MkunsdPHuxfkPocGTd+1z1O1FE5P0lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728344433; c=relaxed/simple;
	bh=AMUryrUKiXz7jRRCPj8fNp4soR5GyS63WzFfoFg6l5U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SLIt3Nr9b7B6134FXjMSfNvJc3reSzklFwWTI7J4Cg6Wkb3iJPBGLEiyEVIXjogJCCcfLokcB2ad6P5WTaI3usZ8VgYBdPIV8sRgse+9uPTEpBTHaoV1J25johS+5MdSCcKbi91sVf0jWx7EZ03mHniVlKVXTkrm3rzaYUvJc9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DV4p0uHp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F0F2C4CEC6;
	Mon,  7 Oct 2024 23:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728344433;
	bh=AMUryrUKiXz7jRRCPj8fNp4soR5GyS63WzFfoFg6l5U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DV4p0uHpv1fRof3Ju93U028CIuMu/W8zpcP/QFdolXJ4V1uJT6CStQ27oa2IYlzjF
	 V3qQMpvxyLwlT2bINJmGJho6YSGwilTx3VJ7EcBvjg8NmOM0XTSVvbvFn74yPQW9hS
	 CeSfiMi5rCMqoEp+E+GTYM1Z6TFZCk4OCez6l+LNGtodsbyUIJqRZtmM8gYdYIQhrV
	 ZgO+XH+sbw6KZ7apvS+kBralr09+dRV9ejuXL+0wVn9UAgf/afmwzE7dvtcc2bT5la
	 CFaxTUME2ApOYkR2UkFEKT4bmATb1P6BzZ5nZGWkMD4DaQUyRtzxJApCQd9s3l2kek
	 R1S0/beLHhqOA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE9B3803262;
	Mon,  7 Oct 2024 23:40:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] mlxsw: spectrum_acl_flex_keys: Constify struct
 mlxsw_afk_element_inst
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172834443748.18821.2044156392058705252.git-patchwork-notify@kernel.org>
Date: Mon, 07 Oct 2024 23:40:37 +0000
References: <8ccfc7bfb2365dcee5b03c81ebe061a927d6da2e.1727541677.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <8ccfc7bfb2365dcee5b03c81ebe061a927d6da2e.1727541677.git.christophe.jaillet@wanadoo.fr>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: idosch@nvidia.com, petrm@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  4 Oct 2024 07:26:05 +0200 you wrote:
> 'struct mlxsw_afk_element_inst' are not modified in these drivers.
> 
> Constifying these structures moves some data to a read-only section, so
> increases overall security.
> 
> Update a few functions and struct mlxsw_afk_block accordingly.
> 
> [...]

Here is the summary with links:
  - [net-next] mlxsw: spectrum_acl_flex_keys: Constify struct mlxsw_afk_element_inst
    https://git.kernel.org/netdev/net-next/c/bec2a32145d5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



