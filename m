Return-Path: <netdev+bounces-143567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D82CD9C3027
	for <lists+netdev@lfdr.de>; Sun, 10 Nov 2024 01:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 733E72820E7
	for <lists+netdev@lfdr.de>; Sun, 10 Nov 2024 00:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46E84A32;
	Sun, 10 Nov 2024 00:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEkjV5Kx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBB11876
	for <netdev@vger.kernel.org>; Sun, 10 Nov 2024 00:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731198017; cv=none; b=tVM9qfFTecxZdg2AC1ZRrnC7+7fEpzHNX19ANH7VTOM181H43D7MjGI9ZF075VRPVDUboIeXOTK+VRTZvaKWLO4nBkJv11AFB2xLnNCKo1D3RvyCaGiGGuNppj9KphSkY3nuZN8uV/Thipt/MWEgz95JVixcxLFhkR3m+NBDnrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731198017; c=relaxed/simple;
	bh=hNQplMOzHArtekQbsuDedkklzKYHwLGqm043rZOhIVQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=boQxZwNNqWUksMlXSVsJ8ZjruTOze+bFBbZ04UW74w5t8jER15w07RZpZtJmgB7cOoGJhklXtCiHuRES/5t3dQBjxLR1SXakwIBl+xjji7/Cv5kfeXwJjYH5M9kd34nWgp1zCCTEuT9Dr2grvImkv9Ft/16bZXEK6CZtjtM8Rcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEkjV5Kx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BD8DC4CECE;
	Sun, 10 Nov 2024 00:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731198017;
	bh=hNQplMOzHArtekQbsuDedkklzKYHwLGqm043rZOhIVQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NEkjV5KxUq0X0RBKNQ9MiqUYNzkHnXB66MDvMAMOERlzHO2E7/m9WtKAhpjU0AzMn
	 T1XrWubXAUqcKSUtlkLLkB0/Rps4eNnPps56ZBSkXfNrMdSg5pEI7dOUOwAd9GpLp7
	 Z7KPPHZGtCs7ZtSklNHWKX6c9EGgAx/lwo1Ax6adtgShE+0fvz+8NCggk0i3OZTU59
	 Eo+uK0U9mlafW/e10bh9TgdhZzqCXER2Td2VMgmiVUq2eqepMYw+uB7KR8pz2VTYb9
	 nDGg/AmWeuK7+tYJd8w8yhOi4x+KwmTP/l50TJTV7dtnEKnbVdE76yz+kSGCQtbUOu
	 gLRpOwbrxeCEQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC0F3809A80;
	Sun, 10 Nov 2024 00:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: net: add netlink-dumps to .gitignore
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173119802676.3042462.8440783690860629114.git-patchwork-notify@kernel.org>
Date: Sun, 10 Nov 2024 00:20:26 +0000
References: <20241108004731.2979878-1-kuba@kernel.org>
In-Reply-To: <20241108004731.2979878-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  7 Nov 2024 16:47:31 -0800 you wrote:
> Commit 55d42a0c3f9c ("selftests: net: add a test for closing
> a netlink socket ith dump in progress") added a new test
> but did not add it to gitignore.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/testing/selftests/net/.gitignore | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [net] selftests: net: add netlink-dumps to .gitignore
    https://git.kernel.org/netdev/net/c/252e01e68241

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



