Return-Path: <netdev+bounces-28196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 808C977EA3B
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 22:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B16E51C211B0
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 20:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA5E17AC6;
	Wed, 16 Aug 2023 20:00:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B1817737
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 20:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 143C9C433C8;
	Wed, 16 Aug 2023 20:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692216022;
	bh=FqhxkuPdgVbJETSXDsWvg4mXVhYdn8SeQrY8c+xWq78=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=riEM3m7lIRonoMiBMuDX96KWnMnZ3fbs0J1JuZenDRx3CQ73U2CTT2VjIknevpnoR
	 nO7YTuKKyyqBPZrE7brSIShfw0RJdniaL2w08VfTRrR8Eo+YjxvhZVrGU47iT3e9JX
	 aanczv4Su2UTNPFM9HoAFrws9+wWuH9UnFPrno7OC/ZgY1k1IWdp4jeOPAxhPk9cxg
	 6pokkr7KKg7fGFXjSHSrRXqMMHdHIVfZv129b+sz2zCk3OMELAv6h9iD6PWBsgIN+e
	 ckJT6Skr+rRV+Q6CfnVZNYkHoixt0X+3p8BnJGWZ55mGTAL8wABQtKEXCMxflDvtuA
	 Y5SzwKJ8WvgbQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EA150C395C5;
	Wed, 16 Aug 2023 20:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/3] Bluetooth: qca: enable WCN7850 support
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <169221602195.24089.4864640872066685763.git-patchwork-notify@kernel.org>
Date: Wed, 16 Aug 2023 20:00:21 +0000
References: <20230816-topic-sm8550-upstream-bt-v4-0-2ea2212719f6@linaro.org>
In-Reply-To: <20230816-topic-sm8550-upstream-bt-v4-0-2ea2212719f6@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: luiz.dentz@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, marcel@holtmann.org,
 johan.hedberg@gmail.com, agross@kernel.org, andersson@kernel.org,
 konrad.dybcio@linaro.org, quic_bgodavar@quicinc.com, quic_rjliao@quicinc.com,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, robh@kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 16 Aug 2023 10:06:45 +0200 you wrote:
> This serie enables WCN7850 on the Qualcomm SM8550 QRD
> reference platform.
> 
> The WCN7850 is close to the WCN6855 but uses different
> firmware names.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> 
> [...]

Here is the summary with links:
  - [v4,1/3] dt-bindings: net: bluetooth: qualcomm: document WCN7850 chipset
    https://git.kernel.org/bluetooth/bluetooth-next/c/f38a5adcbd53
  - [v4,2/3] Bluetooth: qca: use switch case for soc type behavior
    https://git.kernel.org/bluetooth/bluetooth-next/c/08292727a9fc
  - [v4,3/3] Bluetooth: qca: add support for WCN7850
    https://git.kernel.org/bluetooth/bluetooth-next/c/ef6d9b23aa58

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



