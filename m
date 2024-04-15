Return-Path: <netdev+bounces-87840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 903588A4BF6
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 11:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1A101C21E37
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 09:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0654D11F;
	Mon, 15 Apr 2024 09:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSbn3OvG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877D24CE1B
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 09:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713174630; cv=none; b=NKYqavXYboxKAZuKVuY6D2HNekpQeht3haQgxSlqzRqbKogHGgg3dzs07g7SPU0g0IbeyveubkJeRv58jPrivolcMiNS4pUING7FEYPW0IE9i7wx9RVhhPqo0gjuuohbU/EvxduZlmFzrOjjPKWFZfKCh3Mr9nBjYcXclGBI/b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713174630; c=relaxed/simple;
	bh=okSHk3G+Rk0ZJAfYvRI5NgVvoi/zgqTmU4CqF8+NYbI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Qe6NI3l+2KXRcFBnlgZuW5wKa3n+0cAgDQUhjUyyar/3ux7eTxNxFi/RR6AhWEa+lhslz+Y+zvhcuWxn4SgJR7O96EqLh7QwcJIEh1qALuC5G2gqz2Ji4iT/Ypyq8YxVdZL2RYKFN2/ybaEDdEuBQnPVrW2X2bdzFnajav1aiGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSbn3OvG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3092C2BD11;
	Mon, 15 Apr 2024 09:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713174630;
	bh=okSHk3G+Rk0ZJAfYvRI5NgVvoi/zgqTmU4CqF8+NYbI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HSbn3OvGHR0w7X8Ia2oZcPfvEOVe7iSxT0DcdyBdEqqhYbLLAk3qF7maXs5jM0VsB
	 fUk9RPnqYX5peyC09EM8Fa8COWVCmZY4iRT8QMsEr0ujp+DtDroOQUNtsX7kI0UQua
	 hia60TeMsGNCM6GPKs2GdUss4FqT+uQMG7QJ0Qvy21uOzUsSFXau27dAEGqgdpv5fv
	 dBbwiPdPNrSXy9FdaXacR74yyeLFhPv/zUe9/VjT/Z9PXBa0pOHCS8JXGC0uLYN2fY
	 H9/wgunEtNXPCkxLGXrScjjkHXOnpJIoj1wf76UkEfvqZKpfdgcDbKP3DezyVeioE5
	 gdMMSZMfD0V1g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E13FAC54BB2;
	Mon, 15 Apr 2024 09:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: constify net_class
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171317462991.17847.6124877677301888433.git-patchwork-notify@kernel.org>
Date: Mon, 15 Apr 2024 09:50:29 +0000
References: <1d59986e-8ac0-4b9c-9006-ad1f41784a08@gmail.com>
In-Reply-To: <1d59986e-8ac0-4b9c-9006-ad1f41784a08@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: edumazet@google.com, pabeni@redhat.com, kuba@kernel.org,
 davem@davemloft.net, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 12 Apr 2024 12:17:57 +0200 you wrote:
> AFAICS all users of net_class take a const struct class * argument.
> Therefore fully constify net_class.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  net/core/net-sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] net: constify net_class
    https://git.kernel.org/netdev/net-next/c/9382b4f338d2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



