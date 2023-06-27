Return-Path: <netdev+bounces-14337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 805277403B4
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 21:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 190FB2810F3
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 19:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363BC4A24;
	Tue, 27 Jun 2023 19:01:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DBA1FC4
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 19:01:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8609DC433CA;
	Tue, 27 Jun 2023 19:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687892513;
	bh=pd5ltRiIOaj/yKrVyXhVz/cvhptO3VIDm67Rl/G6O3w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hu99a1SWwpcgIUDdVf7+kAjL0QITH77k2W2SSELAO6KDmkUvtU0rnRrwkXISvXaS2
	 1+S9tUbZidslBPc7VO9enIKPIwC4VAuBpvuyZSHlU+JO9gOZsmK5Z5zXnYsBEH8pOA
	 v08UdZMQi+L4/AhGcZKh0yDQ5v45TeLr7Bu/j2IDHqhrBoUZ3GlU8h9e9HpnhFjZAS
	 /VPpaYooNuc5jyqCarUFfsJMOwYMX3IzXx/gJAbAj6jQ1Sufhfa0k+ebb0n6pjnd6u
	 A6mp0Eww6G/vVF08cndZhzK1zYTfPIsALhJWOiHP8b4QW+LnvK6MO3Me0XFsZP5+lF
	 hiKckaMgNmavQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 598EEC64457;
	Tue, 27 Jun 2023 19:01:53 +0000 (UTC)
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
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <168789251335.11348.15831606026121795757.git-patchwork-notify@kernel.org>
Date: Tue, 27 Jun 2023 19:01:53 +0000
References: <20230621060949.5760-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230621060949.5760-1-krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
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
    https://git.kernel.org/bluetooth/bluetooth-next/c/533bbc7ce562

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



