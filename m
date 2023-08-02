Return-Path: <netdev+bounces-23794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B01B976D8AC
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 22:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72F7228111E
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 20:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7957D51F;
	Wed,  2 Aug 2023 20:30:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF57125B7
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 20:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E347FC433C9;
	Wed,  2 Aug 2023 20:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691008223;
	bh=EmWbaenOMDMD6nYdMzBFCScTkic4CvjgRoEjkBg+bnE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VvEEJn4ZP6H4Q7fIJSQjyMaGQyiLccK7NXIEXRuMbSrVtwDsqvcAejUc2tGH5pae6
	 fMQ7pxeSQBIuhEwYHHI27EyCsNmhk9p7nA8AHCvgfG8Pk4s5A9vAWpy7qjVyLqHQtF
	 R6FoA3B9ngUfgMdE7WBiuKHfMEEq7sv/pZFRiirj/+UK2XWO075tP5HAmzNLoJ58sD
	 F5n6tRD2YRHmhFBwp9qCso2O/92w/PHOhwMmElhigy4x7WBM418XzRFgsas+oP2Gpr
	 O9C6dRL9rgRlmmEbn2vnJW/kWRcdIWyjDNtrbApwfOAoyfxjKDfnM/AS4/65d2Rzil
	 V0Jwvv2I4L/PQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C4843C6445B;
	Wed,  2 Aug 2023 20:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/2] Add WCN3988 Bluetooth support for Fairphone 4
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <169100822279.572.3966556819111433761.git-patchwork-notify@kernel.org>
Date: Wed, 02 Aug 2023 20:30:22 +0000
References: <20230802-fp4-bluetooth-v3-0-7c9e7a6e624b@fairphone.com>
In-Reply-To: <20230802-fp4-bluetooth-v3-0-7c9e7a6e624b@fairphone.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
 conor+dt@kernel.org, quic_bgodavar@quicinc.com, quic_rjliao@quicinc.com,
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, krzysztof.kozlowski@linaro.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 02 Aug 2023 08:56:27 +0200 you wrote:
> Add support in the btqca/hci_qca driver for the WCN3988 and add it to
> the sm7225 Fairphone 4 devicetree.
> 
> Devicetree patches go via Qualcomm tree, the rest via their respective
> trees.
> 
> --
> Previously with the RFC version I've had problems before with Bluetooth
> scanning failing like the following:
> 
> [...]

Here is the summary with links:
  - [v3,1/2] dt-bindings: net: qualcomm: Add WCN3988
    https://git.kernel.org/bluetooth/bluetooth-next/c/d2a31b6f9701
  - [v3,2/2] Bluetooth: btqca: Add WCN3988 support
    https://git.kernel.org/bluetooth/bluetooth-next/c/f2e1dd87c9cd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



