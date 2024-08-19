Return-Path: <netdev+bounces-119764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F02956E15
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 17:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5656828791B
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 15:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253C217A5A1;
	Mon, 19 Aug 2024 15:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHmn3zN9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29FE17B4ED;
	Mon, 19 Aug 2024 15:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724079639; cv=none; b=Kv0Sy/uCVJskOseRf40k5uYmBwKY/RIAwQhJY77X3zIfATSyn0LZmt5gXlyQ9LdIbCc1DicOdhllbNPX14ojiVYFyBI51h5Fpvxjy4bc9q5zQVlpDvtiXgt/vW3RrbmwpWhdd3KbXphl4d6P1YmId1Xrv4HbpoXrrvSJTQ135r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724079639; c=relaxed/simple;
	bh=KsAhkAR4g78CU6faLNjOrc39dz5lk0aMMLeFujsvwZE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ibxmy7zvCbbLerKfgQNB0zlLCUDzCUeBj1eWlXVG3VAaTLFTQygoZQly3CU9H/GGSe6+XjOZxyOeC+1vKwS7qcCGveHQWmqg/ZiBvE0SpALX7/VDSm5TpNCkvuoZaZVnfmZG2P+MDCdPHYTHTkkMYHoQPCp41OiKStAL47cQrQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHmn3zN9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B5CC4AF11;
	Mon, 19 Aug 2024 15:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724079638;
	bh=KsAhkAR4g78CU6faLNjOrc39dz5lk0aMMLeFujsvwZE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nHmn3zN9ZKgP1lH4Pyw9dbD/CPu6Cm0PG6hNCDHkw+Irea5Z8gQaodQZ32lKUV1hc
	 WbFEjYJgMA3C0+dfRQ0W7UaDGReIubuWjaPJwtJ+9djNP8sBXC5udUVJldeac5Cf6V
	 WEpph1Lvt2d2ZY25VS5LZzatRWkYOf762mqIVtYFYyR3pyFwvyEFevwrue3ZPlWgr4
	 qEOcpA65RzZrMRMIqs8pF/nlyirYM2zJRB6XH4Bd8MQ0ZMlCd6homMDiDH72/J7loI
	 ZzKqFgunNwL6PdUDNWYRPFmH3QN4kFqybXOqYGH5osnWMy37scMoR69YWXg3/cBKaq
	 sOGP42dTgwGtg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D7C3823097;
	Mon, 19 Aug 2024 15:00:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] dt-bindings: bluetooth: bring the HW description closer to
 reality for wcn6855
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172407963825.558835.17672220206298391503.git-patchwork-notify@kernel.org>
Date: Mon, 19 Aug 2024 15:00:38 +0000
References: <20240819074802.7385-1-brgl@bgdev.pl>
In-Reply-To: <20240819074802.7385-1-brgl@bgdev.pl>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, bartosz.golaszewski@linaro.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 19 Aug 2024 09:48:01 +0200 you wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Describe the inputs from the PMU that the Bluetooth module on wcn6855
> consumes and drop the ones from the host. This breaks the current
> contract but the only two users of wcn6855 upstream - sc8280xp based
> boards - will be updated in DTS patches sent separately while the
> hci_qca driver will remain backwards compatible with older DT sources.
> 
> [...]

Here is the summary with links:
  - [v2] dt-bindings: bluetooth: bring the HW description closer to reality for wcn6855
    https://git.kernel.org/bluetooth/bluetooth-next/c/0553b3a4ef28

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



