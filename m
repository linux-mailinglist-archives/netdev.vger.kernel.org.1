Return-Path: <netdev+bounces-25591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13344774DE1
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 00:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 446451C20FB0
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 22:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84A31805B;
	Tue,  8 Aug 2023 22:00:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5948A174E1
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 22:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9F24C433C9;
	Tue,  8 Aug 2023 22:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691532021;
	bh=0CjdeW56CS2059Vkt0DNasnDqdrqZiTUPNvFROKH9Ko=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZFemw6DCXpLlNx2M8biWQnKG3G228tzyxO2dijgeS5BR8kYOhiNBGzBKha5+8d+b2
	 H+k1cuGzP7aOdznQujTvJWUvn2gbn5el8wfXv0ckwsOco5A349k4qSpCkdR2l2rDPJ
	 /VjtO3ISJJnBU0HNKQG//Cco7C9TWwu0woPCTD18X8jWuxJSRRV+RzWBejgo/u9tTd
	 jbq3m4HVzjWmd4F3Pa9xDXTAf89j+F2oyLPA4YKE2BKJwajq/nn22fqOOwpOLhVdS4
	 2UaIpasp0qBxfi2P/3Ciw85m047r/IcMGcuaKbF08+sZx2IlAYJIflQoRUIWKIs9l1
	 iIzTLi4REA3dA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B9192C395C5;
	Tue,  8 Aug 2023 22:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] MAINTAINERS: update Claudiu Beznea's email address
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169153202174.6931.11202742037860925480.git-patchwork-notify@kernel.org>
Date: Tue, 08 Aug 2023 22:00:21 +0000
References: <20230804050007.235799-1-claudiu.beznea@tuxon.dev>
In-Reply-To: <20230804050007.235799-1-claudiu.beznea@tuxon.dev>
To: claudiu beznea <claudiu.beznea@tuxon.dev>
Cc: nicolas.ferre@microchip.com, conor.dooley@microchip.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 maz@kernel.org, srinivas.kandagatla@linaro.org, thierry.reding@gmail.com,
 u.kleine-koenig@pengutronix.de, sre@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
 linux-pwm@vger.kernel.org, alsa-devel@alsa-project.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  4 Aug 2023 08:00:07 +0300 you wrote:
> Update MAINTAINERS entries with a valid email address as the Microchip
> one is no longer valid.
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> 
> [...]

Here is the summary with links:
  - MAINTAINERS: update Claudiu Beznea's email address
    https://git.kernel.org/netdev/net/c/fa40ea27ede3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



