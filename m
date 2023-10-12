Return-Path: <netdev+bounces-40202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4E17C61B6
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 02:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63F3E2823DD
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 00:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D5DA4A;
	Thu, 12 Oct 2023 00:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OIbMzeaF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA157FC;
	Thu, 12 Oct 2023 00:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A59E3C43397;
	Thu, 12 Oct 2023 00:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697070625;
	bh=51tfv3kMjBGFcDAc9LOdPgHNhgvubjVRO3ku7iHFAX0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OIbMzeaFADSfHFDUuZnm3TXeyFpyzFQa8nPFMovLi6AKX3fexivxBQdA84p8cWRQd
	 58+KAzs7gV/+/w7oq2l9anaxlWcS5cdG1vQOEikVEx76mzKx0LQVzl1nyepk+LH+Mx
	 B0d4pvj/j+6H9gHSSZS5Hn8/AHI+QY/vu2zAtmo+29oaJSZI6VqYcSJOtlOIl4I4KN
	 oL6cKas+G0IIERb2WADGf5vY/Lfgkb9KRf8nruq9od6Iw6CM97u5FGX+GxSxDTTcVT
	 meuFRIPcocSLvfBe6ZqMXf5SJy+H3UievbpkqMT21FbQSHBPFLwdDGdl6QX20dalK4
	 88knMj6OPtzjw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8F904C595C4;
	Thu, 12 Oct 2023 00:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: dsa: mt7530: replace deprecated strncpy with
 ethtool_sprintf
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169707062558.15864.9019771433715033154.git-patchwork-notify@kernel.org>
Date: Thu, 12 Oct 2023 00:30:25 +0000
References: <20231009-strncpy-drivers-net-dsa-mt7530-c-v1-1-ec6677a6436a@google.com>
In-Reply-To: <20231009-strncpy-drivers-net-dsa-mt7530-c-v1-1-ec6677a6436a@google.com>
To: Justin Stitt <justinstitt@google.com>
Cc: arinc.unal@arinc9.com, daniel@makrotopia.org, Landen.Chao@mediatek.com,
 dqfext@gmail.com, sean.wang@mediatek.com, andrew@lunn.ch,
 f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 09 Oct 2023 18:29:19 +0000 you wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> ethtool_sprintf() is designed specifically for get_strings() usage.
> Let's replace strncpy in favor of this more robust and easier to
> understand interface.
> 
> [...]

Here is the summary with links:
  - net: dsa: mt7530: replace deprecated strncpy with ethtool_sprintf
    https://git.kernel.org/netdev/net-next/c/ac49b992578d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



