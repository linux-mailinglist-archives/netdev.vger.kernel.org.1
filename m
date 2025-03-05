Return-Path: <netdev+bounces-171865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5892A4F2BE
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 01:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F300B169049
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 00:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFBD1A29A;
	Wed,  5 Mar 2025 00:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KxJKehgR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6D627456;
	Wed,  5 Mar 2025 00:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741134599; cv=none; b=WjVYYRoXnQFnA9qjqSTYPRKYk9l8nAIboOI9VuHo6sgkEGIQmSZSfqtNDCa2ND+lW57bI/D6bH2UMc//W97iC07zHKdvYAWL5DCQ9PtK4PmRKIjRNhE6GrajLZvaOrH29HCKG/3QlYLVUi6waG5niLLvW1Bu6lqqp6MQuspm3gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741134599; c=relaxed/simple;
	bh=Byb9Fn5sdn7q5Onud0bJf9pe9X56OHaqd58xQ8U6HHQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lrGV4wt+gSU49Y0OiH04upXd045eh5J8C0sD7IlXEXNmROn2+XehcZUbcg4RWr2llts6e+1IcO3wupFXp6KtISsLFvzd2EH7ibJzR/ZL6X5bYOSoZ+fjfK+9YCsEMAWGLlR1ESeDx5ysKLV7utH99zY0UsCzUVLV0QEH1mhQ5XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KxJKehgR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B537C4CEE5;
	Wed,  5 Mar 2025 00:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741134599;
	bh=Byb9Fn5sdn7q5Onud0bJf9pe9X56OHaqd58xQ8U6HHQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KxJKehgRAd2bl+h+Yvv7nJkhM1Cby+CbdDXUXHyxBhsvw9mTUSofxgHtTERAYKT2K
	 IXFuBRiIRI8ViMbun2iZAUc5cB1xBmu8N41a/3/ksDYIZjSvmfqQQ5nesJ3+nI92Ya
	 mghuYFBsMlu5HIkspEe2jRywSosjZ9iT6vFYS8S1oEbNvxy4FMDjP++I8yEKoKq2e5
	 VAhqF7bs7X3dDdr9CVstiyn0+Qcp8OosAdpTqt1xprluU1ahWZBAhK3bTFcUhWD4Y/
	 zBkUPLaGW9yeHqMRujRGmJJ4d6TTj/uW5Xsm4XcxLcEli5AGChvGCdJO0dFWaAhG5B
	 shoxThkaHcLkw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3434D380CFEB;
	Wed,  5 Mar 2025 00:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/3] Fixes for IPA v4.7
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174113463200.345304.7962244845761048963.git-patchwork-notify@kernel.org>
Date: Wed, 05 Mar 2025 00:30:32 +0000
References: <20250227-ipa-v4-7-fixes-v1-0-a88dd8249d8a@fairphone.com>
In-Reply-To: <20250227-ipa-v4-7-fixes-v1-0-a88dd8249d8a@fairphone.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 27 Feb 2025 11:33:39 +0100 you wrote:
> During bringup of IPA v4.7 unfortunately some bits were missed, and it
> couldn't be tested much back then due to missing features in tqftpserv
> which caused the modem to not enable correctly.
> 
> Especially the last commit is important since it makes mobile data
> actually functional on SoCs with IPA v4.7 like SM6350 - used on the
> Fairphone 4. Before that, you'd get an IP address on the interface but
> then e.g. ping never got any response back.
> 
> [...]

Here is the summary with links:
  - [1/3] net: ipa: Fix v4.7 resource group names
    https://git.kernel.org/netdev/net/c/5eb3dc1396aa
  - [2/3] net: ipa: Fix QSB data for v4.7
    https://git.kernel.org/netdev/net/c/6a2843aaf551
  - [3/3] net: ipa: Enable checksum for IPA_ENDPOINT_AP_MODEM_{RX,TX} for v4.7
    https://git.kernel.org/netdev/net/c/934e69669e32

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



