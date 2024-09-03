Return-Path: <netdev+bounces-124754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3C096AC58
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 00:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 961C828293A
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 22:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFB71D58A7;
	Tue,  3 Sep 2024 22:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFi5qmN+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759FE168D0;
	Tue,  3 Sep 2024 22:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725403231; cv=none; b=AtqaGz6kbl8wFBNlRGSaX7cEJwSjkTCbZc0Kz46A8X2SNuW8ksq3Qlw33IbHE++ZQAHm4oDtji5cI64CYvLnL2wyMWoQuZcd3xSH+O1odNDiVrXOUtlJRC2e9h5S/UylM3A/SKucqtNZvyKBObLCTeFkFWrn7sHvd6CrIkSZeJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725403231; c=relaxed/simple;
	bh=fCgVnErX3q/Z4dAf9D6s7jr/WaqrxTgUQu5QDHoYNGk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dCEs5L/s4VZvP51+o0GR7EpFDeHJjmDYutF27quOJWkbbDpE4pUgr7NuehrdbWZwZx9/1QtCgeognXjKhx38DRc/D85QuC0rVhr4wZGn10OV8SNlwJdctNIjCtmNpGfFcBJHCeTIPZ9iYpI3E4cf/F2uT9Skpjt8heM4LVT7TWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VFi5qmN+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0170BC4CEC4;
	Tue,  3 Sep 2024 22:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725403231;
	bh=fCgVnErX3q/Z4dAf9D6s7jr/WaqrxTgUQu5QDHoYNGk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VFi5qmN+ddDWC/nJcl0H894Entmmy91fNuQL6grOZR/HTcGcGDYjllzN68ttJfw5l
	 GZ8LPihqPYoIYwTy8qZUd2tn2slkQIlE6GrZ3Rer0/GJ6FdXpngDB7MSRtmGQ70lZl
	 WvvaH2sct2ujFxnVJxNAmYv3xM8llCarjmLHSfYynlyB4J2cYa0/I852Hlbaq3tX+N
	 kxoeww16taeF63AUEaQAWk8MwxlO/Z8tUmp60yF0LYzb7mnzpDHSfE7ERouSPbkP8I
	 vAJdOXzbpi0doeM/I54VkZHPU0f5Cbaga2Kcb2+P365ZwU/XszXpFrxdpz9QGI2/mq
	 AYvuf0MCSd+FA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEA93806651;
	Tue,  3 Sep 2024 22:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: alacritech: Partially revert "net: alacritech: Switch
 to use dev_err_probe()"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172540323175.471018.14716826059203636030.git-patchwork-notify@kernel.org>
Date: Tue, 03 Sep 2024 22:40:31 +0000
References: <20240902163610.17028-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240902163610.17028-1-krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: LinoSanfilippo@gmx.de, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, 11162571@vivo.com,
 jacob.e.keller@intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  2 Sep 2024 18:36:10 +0200 you wrote:
> This reverts commit bf4d87f884fe8a4b6b61fe4d0e05f293d08df61c because it
> introduced dev_err_probe() in non-probe path, which is not desired.
> 
> In general, calling dev_err_probe() after successful probe in case of
> handling -EPROBE_DEFER error, will set deferred status on the device
> already probed.  This is however not a problem here now, because
> dev_err_probe() in affected places is used for handling errors from
> request_firmware(), which does not return -EPROBE_DEFER.  Still usage of
> dev_err_probe() in such case is not correct, because request_firmware()
> could once return -EPROBE_DEFER.
> 
> [...]

Here is the summary with links:
  - [v2] net: alacritech: Partially revert "net: alacritech: Switch to use dev_err_probe()"
    https://git.kernel.org/netdev/net-next/c/9748229c90dc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



