Return-Path: <netdev+bounces-231502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F090BF9AA8
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 04:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AA6384F3D94
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 02:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA2221019C;
	Wed, 22 Oct 2025 02:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTTIUdcp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A923E1E5213
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 02:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761098426; cv=none; b=XICaYd5UJXms51psVyawSlttZB6HOluK9PgIyz5v+IJovLrFUMwlgyW1JtHlc86qqKyxdCqYsZ67A+L4A3KvDJ+/4EcImQ7dr38y+TdssdvrvAj/L+xPsa50vo5k5LJItrR/wDkjw8D5w2BCH3eyEL/rkqIhsqePb8i5xxtgunk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761098426; c=relaxed/simple;
	bh=ky6aD+ofimLoEi1qj/fLf0sxZ7Lvzy5eSuoob8Psdb4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LoYztwHuszAo9+ZTNVOdmFspMk17wqx6GqTeM7/IlbXVc7Dgc3CB6G2wHIwiBq85mXrvpOcFBnZodbbCgjcSFo8orgo6BQ6hWUFoxoWQ7EwhJbll5v/t3zkccFd0hqW9vGBAS4Q5Msy7F0qWXS9kmzU+nPIA2qe4Jt3ArgX60I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTTIUdcp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34672C4CEFF;
	Wed, 22 Oct 2025 02:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761098426;
	bh=ky6aD+ofimLoEi1qj/fLf0sxZ7Lvzy5eSuoob8Psdb4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hTTIUdcp/Hs1f2Ovx37HT5DxN9cnRABnHAjn+MYScCmorxAJir44TnSOAJmdfvIkI
	 f7KBQa9eqI7e4/CEkP2Z7vE/QQC6SxC2GDFSAZiubCvtQNQiNWpWQlJH9g9+iksjtK
	 IB4z9wqwEhPVIB+vv3lSLOF5gOV5vq+pFsDt38xP3zl6WP1K3Vt9ss0GiAj+jw3TdB
	 wJpu+lFYXPbnULTYpcyOWOX/VAZ8yA+Utxpp6MTtvAzbgrscceTSXNX0VehqZopaiL
	 /3k2L+phZoHti/ircM2yqCaM5/4HVCK6IGKsVmEhfvCAo7Yy5Z9xDpuNV9ZEOYG9jQ
	 6+zvUW+V40qeg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE5D3A55FAA;
	Wed, 22 Oct 2025 02:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: hibmcge: select FIXED_PHY
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176109840751.1307287.17313015917223123484.git-patchwork-notify@kernel.org>
Date: Wed, 22 Oct 2025 02:00:07 +0000
References: <c4fc061f-b6d5-418b-a0dc-6b238cdbedce@gmail.com>
In-Reply-To: <c4fc061f-b6d5-418b-a0dc-6b238cdbedce@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: shenjian15@huawei.com, salil.mehta@huawei.com, andrew+netdev@lunn.ch,
 pabeni@redhat.com, kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 20 Oct 2025 08:54:54 +0200 you wrote:
> hibmcge uses fixed_phy_register() et al, but doesn't cater for the case
> that hibmcge is built-in and fixed_phy is a module. To solve this
> select FIXED_PHY.
> 
> Note: This could also be treated as a fix, but as no problems are known,
> treat it as an improvement.
> 
> [...]

Here is the summary with links:
  - [net-next] net: hibmcge: select FIXED_PHY
    https://git.kernel.org/netdev/net/c/d63f0391d6c7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



