Return-Path: <netdev+bounces-204765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3DFAFC03B
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 03:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC61B4247FD
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 01:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53261E570B;
	Tue,  8 Jul 2025 01:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oa7n8Xic"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D07C1B4236;
	Tue,  8 Jul 2025 01:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751939383; cv=none; b=KegHeMIiJwx9iOu1szYlrEiloA6Sd7kgf/GJpGj7ixTDGon3Snv1ihPaLoKDF5A7mCnsJDLpQvLHIKNWOFmm6/1z1eC3ckaBNWq2dac9cOtWcrX+ff7GV3wNMph7kz2EvVFd1Rw9OW7xxBPIBXtyC5wd+Aj0GMSCt3XqWVVpakI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751939383; c=relaxed/simple;
	bh=oGLdRxSgO3pgBT1aAOSVL2VzLRKy8VF85MjJrzkGN3g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u3QfrinRsqiEk+aT9AA8fWVmQpP4Of/JQvE0lWh8kxDU5S0yPQJJQ6Qx3cIMYBrGqloWaJaEyBHNRScdhO5auIhgL4cgemnx9lNwDJft3yHElJo7eAr0L8a9RLTjdoXA+lJZhsRWJCV2j5006HAd96PL3RS//DFfgXFOSKRf7g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oa7n8Xic; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F15C4CEE3;
	Tue,  8 Jul 2025 01:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751939383;
	bh=oGLdRxSgO3pgBT1aAOSVL2VzLRKy8VF85MjJrzkGN3g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Oa7n8Xicb3dcTpRdjhUjufIG3pQLKGsbeA2NMnO9vlWErSEXwrWxai7nT2gO4bS08
	 bKr7XNSMqwIWDIrUtAkBxnH1sAngfGgmx9XLhsKcnl9CHWfNNkwWGAcnh66IQ4NnCx
	 jK/fEdBNqvmoOm3/OVT8JPT6h1/kzLmGe2MESZ/gqWO8KjRQQDeJN+YENfbJtP5gRv
	 FfeR25eCONfqRyc7lJLhxoCeEMv+Nau1ANWRnzlig0xFMz3pyyrMVrAkYYc0SHggcd
	 EcKg2VV6WmVNf3ZgsdAXf02B0q4eYwy8yKZBadCIKDr7XiG2bi0g0of39qBZSKNdWM
	 lY7qKUZcZ1gBg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CD838111DD;
	Tue,  8 Jul 2025 01:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] mlxbf_gige: emit messages during open and
 probe
 failures
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175193940627.3539644.1756814742067008441.git-patchwork-notify@kernel.org>
Date: Tue, 08 Jul 2025 01:50:06 +0000
References: <20250701180324.29683-1-davthompson@nvidia.com>
In-Reply-To: <20250701180324.29683-1-davthompson@nvidia.com>
To: David Thompson <davthompson@nvidia.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, asmaa@nvidia.com,
 u.kleine-koenig@baylibre.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 1 Jul 2025 14:03:24 -0400 you wrote:
> The open() and probe() functions of the mlxbf_gige driver
> check for errors during initialization, but do not provide
> details regarding the errors. The mlxbf_gige driver should
> provide error details in the kernel log, noting what step
> of initialization failed.
> 
> Signed-off-by: David Thompson <davthompson@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] mlxbf_gige: emit messages during open and probe failures
    https://git.kernel.org/netdev/net-next/c/e2793101d6a9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



