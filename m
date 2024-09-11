Return-Path: <netdev+bounces-127184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD1B97480E
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 04:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C5F7287A0D
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 02:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9B1282EE;
	Wed, 11 Sep 2024 02:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJhxmXY5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A6425745;
	Wed, 11 Sep 2024 02:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726020633; cv=none; b=I1xjFN8pieypynNNEXE/foWGT2jPkcchafIex2GyZ7riNZrcSiTVn890qbihi3kwkBXKM1H2Q4AEsWM7yIhoRXECMgrfwaurXdpqGKziv4IGDquni4AOw+YpsT0Pi4wk0oAP7bf7C98z2Fe7m2N2FL3ueBsLpFpkPPrEMoYa6sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726020633; c=relaxed/simple;
	bh=Ukvdmk6V9AkDsXn18d1wcBFwVU2wInYSavYgNP9N5v4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kGZbjas9jd6sq0eGZgVs2qIBmy7JTA1S94BA4tORvxf02ZxmzIgbLO/Y0F2foAzBwKmJ7MH7YhETkm+rk7RY5NJklzEZGn8HOR2027352npuLmeE6zL7BN9ebPwzHXUUxtk+p3eMq7Fp0KEIyg4RyogQ/nCRNiokXCGw8CkQ75c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJhxmXY5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF6CFC4CEC4;
	Wed, 11 Sep 2024 02:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726020632;
	bh=Ukvdmk6V9AkDsXn18d1wcBFwVU2wInYSavYgNP9N5v4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MJhxmXY5ACfTu9lK2dO6lJ12cvkv49jnbviNSg4Y/wPAJxz0MT9j7dHnp8KY4p0D1
	 wsJtvXAeupdL21TRCMVgaIPiKQQ72pMuw5b0vklKdaALjcVnskZveAbmp0+P9QVcMk
	 eYgyNOXFknJr02WbWl0RzEYwlaTWe5gJAoKqjfhlZofNMaQ/N5Bkedg2igpqnCvtvW
	 PFt7KNjONwxKHWl2iSybhQ5GQBmgns/GoNp6oKgKesTdN9YZUfVYiGGVh9jeCDY0ow
	 UzSt8tdLxIToQcPrgaAKFjFvMCFTb0lSgdw/dfdS1TqXhiDlS7fe+RysJmBgky9IPH
	 d5oy4avdJNCTg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBB5A3822FA4;
	Wed, 11 Sep 2024 02:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: amlogic,meson-dwmac: Fix "amlogic,tx-delay-ns"
 schema
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172602063377.461532.17295023219958087443.git-patchwork-notify@kernel.org>
Date: Wed, 11 Sep 2024 02:10:33 +0000
References: <20240909172342.487675-2-robh@kernel.org>
In-Reply-To: <20240909172342.487675-2-robh@kernel.org>
To: Rob Herring (Arm) <robh@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, krzk+dt@kernel.org, conor+dt@kernel.org,
 neil.armstrong@linaro.org, khilman@baylibre.com, jbrunet@baylibre.com,
 martin.blumenstingl@googlemail.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  9 Sep 2024 12:23:42 -0500 you wrote:
> The "amlogic,tx-delay-ns" property schema has unnecessary type reference
> as it's a standard unit suffix, and the constraints are in freeform
> text rather than schema.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../bindings/net/amlogic,meson-dwmac.yaml     | 22 +++++++++----------
>  1 file changed, 11 insertions(+), 11 deletions(-)

Here is the summary with links:
  - [net-next] net: amlogic,meson-dwmac: Fix "amlogic,tx-delay-ns" schema
    https://git.kernel.org/netdev/net-next/c/955f5b150862

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



