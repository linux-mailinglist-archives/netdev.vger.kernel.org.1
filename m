Return-Path: <netdev+bounces-203135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C47AF0905
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 05:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAA774A6936
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 03:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819DA1D6DA9;
	Wed,  2 Jul 2025 03:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="linSDgWE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566322F42;
	Wed,  2 Jul 2025 03:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751425787; cv=none; b=mqguWyFqkW1rE5+KcOPulPgZR+VdnXT6z3XNmph+U+7b9INoPtpIUZxOvmsSXIUtKfBQAMSbYOVouxVwjpjXIJ3OIsq47V8yizOBC7nDeVeZLlm6ZSv7o3rLK6a0Xcj4O8wjScT9G8qqGIcTC4q+0FMmrpW8HjDA/tbBXfXQA/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751425787; c=relaxed/simple;
	bh=Ib30eocfGm/ZOiXzbeA6ufins3bNQOa0UCMyduR9q90=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bDNJdQHqfCMahyI+zFcsotpDvW9iTkGSYOFDFwmy94zoRUYQcmRxTahZWh560HM1cGSUmraHnxad533DoZJ4Q3eOZWrMkSMRnPyj6Aropi90wgNiyIJN5n6mYxysAw3TVM/fD8ZYbUmUeBejV8WzKOILp+BB2V6j2N/y07qtjqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=linSDgWE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E4FC4CEEB;
	Wed,  2 Jul 2025 03:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751425785;
	bh=Ib30eocfGm/ZOiXzbeA6ufins3bNQOa0UCMyduR9q90=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=linSDgWEA0o/Sen8nNiSxt78945Jb14fg7v6Rrq4mgrT1m/7QY/LzAgQg10aE744+
	 Ylg1ih5vN1guwMpA2v9utNtOhAvTL0Of1WjT3vXrb+ctxsSNQAZX7KCm+zdNpmL3mx
	 4ZkDVOBFTzET1Z9rn61OU8XgN/6zd+LkZW9LkQsA6tlPyzx4QvaZyI55bHvPhfw7ew
	 kcIJHiHEqPiAEG3rAPT8UHUpk/8uK9qW6XlH0xr2WLwzae0PcxwMb6sB0kx8X7DYI8
	 9cNtSys33ZwQRXwk/JTrLWRd/GM/jxo+/JplzjMsFMUOG1cy764uDIhCAKAG1bHch6
	 jsrUXz5YYkBdQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC6A383BA06;
	Wed,  2 Jul 2025 03:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next PATCH 1/1] net: phy: air_en8811h: Introduce
 resume/suspend and clk_restore_context to ensure correct CKO settings after
 network interface reinitialization.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175142581025.190284.6203366910161312521.git-patchwork-notify@kernel.org>
Date: Wed, 02 Jul 2025 03:10:10 +0000
References: <20250630154147.80388-1-lucienzx159@gmail.com>
In-Reply-To: <20250630154147.80388-1-lucienzx159@gmail.com>
To: Lucien.Jheng <lucienzx159@gmail.com>
Cc: linux-clk@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, daniel@makrotopia.org,
 ericwouds@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 joseph.lin@airoha.com, wenshin.chung@airoha.com, lucien.jheng@airoha.com,
 albert-al.lee@airoha.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 30 Jun 2025 23:41:47 +0800 you wrote:
> If the user reinitializes the network interface, the PHY will reinitialize,
> and the CKO settings will revert to their initial configuration(be enabled).
> To prevent CKO from being re-enabled,
> en8811h_clk_restore_context and en8811h_resume were added
> to ensure the CKO settings remain correct.
> 
> Signed-off-by: Lucien.Jheng <lucienzx159@gmail.com>
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/1] net: phy: air_en8811h: Introduce resume/suspend and clk_restore_context to ensure correct CKO settings after network interface reinitialization.
    https://git.kernel.org/netdev/net-next/c/6b9c9def95cb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



