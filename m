Return-Path: <netdev+bounces-94764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 505868C0983
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 04:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B97F2832D0
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 02:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D056513C91B;
	Thu,  9 May 2024 02:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eed7ld8h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A148E13BC0A;
	Thu,  9 May 2024 02:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715220029; cv=none; b=i6fP/dTchmZjsI/dD5VirR/kuPtV7wi36+JrDv2g+jtUpG4qjkDi5hKO7F/fqN97NFrUKSyKeA3QvK9nUUyeJFlAtZYArW01P0BfW+qCrLHV188Gjzn1o8o1HdrCRzlMdRtzWrX40/TrQw/BKe0BNSH4IA8XOzo5WLzdIoQqSUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715220029; c=relaxed/simple;
	bh=5uUBO7EpVJSHQ9Pq0QpAYzMRCljyCpo7HxEVbl3AQe4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gW1/AverQR954QC8K9NYehn4GT2HR3DLXQkl3qVPWotl7mpA6N5uMlReV7fEvXTzV8fxsuK0smnRfHxlm0acuz2y1LVhIfS/S+S8AaiaqMQDw+2OnllORrnLlvL2MkTLNlLY/RIjIkxren+7lyymXxSR0bjcvDBsjVcotPynGJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eed7ld8h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3DDE7C3277B;
	Thu,  9 May 2024 02:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715220029;
	bh=5uUBO7EpVJSHQ9Pq0QpAYzMRCljyCpo7HxEVbl3AQe4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Eed7ld8hwrxI+x/T/ZpvQ1aapIhxqzGTSeKKGvSfAPD+r6j88dZTRsbrxoYXgS8W9
	 aOGFFQjx4+xC3v868EtWoPa8uE/Y7qH8nowYVfmaTrIqFpTO5eLeMAvjzCMNpJI9LD
	 f71OkBU55l4JgTETe9VTZhQI8rbfgZGDbjFBgDLgInFgr6wp+LaSSxiHUXQ3gJVPKN
	 HUTI8pbJx42b13hquh50QmxVKehNY79s62PmZIZlcJsB8VWUOfS5z7MTqxviWXx2Fp
	 ii+QXDq4pAKgGc4tYbG3LIO3YGIbAJZjwJwl4JOfeUyZMG4f5CukaGRBguY3E/Hq8J
	 XH8P+koiZwd6A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2B8E3C43335;
	Thu,  9 May 2024 02:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] dt-bindings: net: mediatek: remove wrongly added clocks
 and SerDes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171522002917.32544.14758011676552549517.git-patchwork-notify@kernel.org>
Date: Thu, 09 May 2024 02:00:29 +0000
References: <1569290b21cc787a424469ed74456a7e976b102d.1715084326.git.daniel@makrotopia.org>
In-Reply-To: <1569290b21cc787a424469ed74456a7e976b102d.1715084326.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 lorenzo@kernel.org, nbd@nbd.name, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 7 May 2024 13:20:43 +0100 you wrote:
> Several clocks as well as both sgmiisys phandles were added by mistake
> to the Ethernet bindings for MT7988. Also, the total number of clocks
> didn't match with the actual number of items listed.
> 
> This happened because the vendor driver which served as a reference uses
> a high number of syscon phandles to access various parts of the SoC
> which wasn't acceptable upstream. Hence several parts which have never
> previously been supported (such SerDes PHY and USXGMII PCS) are going to
> be implemented by separate drivers. As a result the device tree will
> look much more sane.
> 
> [...]

Here is the summary with links:
  - [v2] dt-bindings: net: mediatek: remove wrongly added clocks and SerDes
    https://git.kernel.org/netdev/net/c/cc349b0771dc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



