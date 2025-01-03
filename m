Return-Path: <netdev+bounces-154869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 012C0A002AB
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 03:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41A953A2A34
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 02:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFCC19D8BB;
	Fri,  3 Jan 2025 02:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYfwrlfQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71F61A8F71;
	Fri,  3 Jan 2025 02:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735870815; cv=none; b=ub6g1+Xb06mfYeZYA9ywJenvqLsvIyTi+D/Qim4ELmeXXU6OHYshfpGg3l1EAzlk0WG5YFfvfNcyCxZSOQYrqbFIn0tTsb4Fq22pft5wp1iNz0pDzvIqeNuFE+DWQNm2LKEW3DNv4/MVcm1ipZ7XB6mOnRroECehK6uzr0VuUoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735870815; c=relaxed/simple;
	bh=XDkpfgONqQGzNctYF51Adls5Q9jT3Kw2bccLl384cnY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jgWKTpm0KbZQSAYtrv3I7JaFNfNzO1G7cj6fuBaN+3LklaFT5pvDY9y5HMg/NQPdy0Gf94t9qDkmQ0cBnZ1WbAJq3kfltjnt7U1wIyeRc3Wk7F3NyuFxaK5o3j3OwFUmKLJURBt/OHR3uyPkgFeNtJCOwGOq/UsliNQvdK8TSpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYfwrlfQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D630C4CED0;
	Fri,  3 Jan 2025 02:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735870815;
	bh=XDkpfgONqQGzNctYF51Adls5Q9jT3Kw2bccLl384cnY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TYfwrlfQupE3da5cg1hSHmOtm6mLq0wMKZpFkvt6Yuhf41MxzSXHdx4mVMJ8E7c6M
	 OiyCdBuHsq5dsTbXfbp11KBWEcscyKf4eqWF+m6vI935TCyZeNsrH2jSuqOFdLapTf
	 HNuoQmTxE5KfWSi9rpNi4e/Yl4oU5CCVB6Jllkkl/Ym9/6ULn0RnRyHY0bOW3ITTHm
	 ddxfxNG+0kTxa9xYZ7FMKfG3fmML5w1XZP5l8p3vDnv7KiFFaa0Xnd8faNWL1UxSKi
	 Bms7MfM7M4vO40H40z+cL8/CF2Q9sJJ9/RtiH0JEn8tnmpFW+SJ/ZOeiWAsLs08LZR
	 CLqiRWU6g6DNw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADAC380A964;
	Fri,  3 Jan 2025 02:20:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: sfc: Correct key_len for efx_tc_ct_zone_ht_params
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173587083550.2085646.14776562837941838078.git-patchwork-notify@kernel.org>
Date: Fri, 03 Jan 2025 02:20:35 +0000
References: <20241230093709.3226854-1-buaajxlj@163.com>
In-Reply-To: <20241230093709.3226854-1-buaajxlj@163.com>
To: Liang Jie <buaajxlj@163.com>
Cc: kuba@kernel.org, ecree.xilinx@gmail.com, habetsm.xilinx@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, pieter.jansen-van-vuuren@amd.com,
 netdev@vger.kernel.org, linux-net-drivers@amd.com,
 linux-kernel@vger.kernel.org, liangjie@lixiang.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 30 Dec 2024 17:37:09 +0800 you wrote:
> From: Liang Jie <liangjie@lixiang.com>
> 
> In efx_tc_ct_zone_ht_params, the key_len was previously set to
> offsetof(struct efx_tc_ct_zone, linkage). This calculation is incorrect
> because it includes any padding between the zone field and the linkage
> field due to structure alignment, which can vary between systems.
> 
> [...]

Here is the summary with links:
  - [net] net: sfc: Correct key_len for efx_tc_ct_zone_ht_params
    https://git.kernel.org/netdev/net/c/a8620de72e56

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



