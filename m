Return-Path: <netdev+bounces-13237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3765373AEA2
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 04:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBE4C1C20DEF
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 02:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DD719B;
	Fri, 23 Jun 2023 02:30:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E9E17FC
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 02:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6920C433C8;
	Fri, 23 Jun 2023 02:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687487421;
	bh=3ZbCN/ViU53qsdRk8S7Lh80V0DgIwoSkPZYj9zk4rF8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GkPyq1+YJa/y9ww+1Iwh5AqHAzabdFG5FUPo67CpemxpivuxZOSrjth7PvgUIq9kf
	 vqY+fiTBsLv10LGL8J3dvgJW0EnJqBaPaHgnBTYwnXED2fnqERUqnctOWQ75XgLVwS
	 Fykz3QwMvTsHlY6fwXOyqVgRyvdhfsnKSV/OoK4W71PNP78s/ZWwE+VFFSEHhufcUG
	 Uj9Ye7gazHq592Va3EW43f7Fvm5ImHJcp4D4gY9iocGqrArlKcZKHNx7KPxKysXLD3
	 XbZR+amnu3C0oISCFKKrP1+34qu+BzMlgX3Dcrw+SWS/y4PuCNmdeb6JKkcXDJqLj0
	 kN2bSOn303VTw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C0DD3C691EE;
	Fri, 23 Jun 2023 02:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: MAINTAINERS: add Devicetree bindings to Bluetooth
 drivers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168748742078.21061.4290523785212356323.git-patchwork-notify@kernel.org>
Date: Fri, 23 Jun 2023 02:30:20 +0000
References: <20230621060949.5760-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230621060949.5760-1-krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 21 Jun 2023 08:09:49 +0200 you wrote:
> The Devicetree bindings should be picked up by subsystem maintainers,
> but respective pattern for Bluetooth drivers was missing.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - Bluetooth: MAINTAINERS: add Devicetree bindings to Bluetooth drivers
    https://git.kernel.org/netdev/net/c/533bbc7ce562

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



