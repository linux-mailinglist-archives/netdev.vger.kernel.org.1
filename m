Return-Path: <netdev+bounces-35039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 060F97A6984
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 19:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B59CB2814A5
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 17:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF953717F;
	Tue, 19 Sep 2023 17:20:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8899E347B2;
	Tue, 19 Sep 2023 17:20:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E75A0C433C9;
	Tue, 19 Sep 2023 17:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695144027;
	bh=R4vqRyHRoQtIzZFJgZHfD0lN9R4xtpTt66srcRemzwk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Dsr9DOH05hMsrKhTamix1dMOYKHukxNIZskrLgSBppCLZymlWg0c6tkhI6u/hIiVI
	 78ZaMUCGZX91kJk8eHmJDFSos2oR7k6GSaModEtgaH6dcjbSfKAqXzHKUZyMoIVBxF
	 1K9T+SZ7CZLCB7xIoc0cEhxc9Dlnt40frst6yKLzBsdcQxBT+mG8AuEYIyRgLseaRj
	 c9t8LOu/eflESPmFltEGm37cMMvxZEjmZ0bpdy9Sjazh1dtL/BsDczuqxMgUlaTLVq
	 4wHJpPpmc+WuyAk/pDHaBb7obKQkeNdm5iGGuBwRXGY6SwTMqTPZPoGf/ULl6YH8Zw
	 AOUXww5usSAog==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C99E8E1F670;
	Tue, 19 Sep 2023 17:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 00/17] Add WED support for MT7988 chipset
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169514402682.28201.16892377425355269294.git-patchwork-notify@kernel.org>
Date: Tue, 19 Sep 2023 17:20:26 +0000
References: <cover.1695032290.git.lorenzo@kernel.org>
In-Reply-To: <cover.1695032290.git.lorenzo@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, lorenzo.bianconi@redhat.com, nbd@nbd.name,
 john@phrozen.org, sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 daniel@makrotopia.org, linux-mediatek@lists.infradead.org,
 sujuan.chen@mediatek.com, horms@kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 18 Sep 2023 12:29:02 +0200 you wrote:
> Similar to MT7622 and MT7986, introduce Wireless Ethernet Dispatcher (WED)
> support for MT7988 chipset in order to offload to the hw packet engine traffic
> received from LAN/WAN device to WLAN nic (MT7996E).
> Add WED RX support in order to offload traffic received by WLAN nic to the
> wired interfaces (LAN/WAN).
> 
> Changes since v1:
> - introduce mtk_wed_soc_data data structure to contain per-SoC definitions
> - get rid of buf pointer in mtk_wed_hwrro_buffer_alloc()
> - rebase on top of net-next
> 
> [...]

Here is the summary with links:
  - [v2,net-next,01/17] dt-bindings: soc: mediatek: mt7986-wo-ccif: add binding for MT7988 SoC
    https://git.kernel.org/netdev/net-next/c/4518b25c63d4
  - [v2,net-next,02/17] dt-bindings: arm: mediatek: mt7622-wed: add WED binding for MT7988 SoC
    https://git.kernel.org/netdev/net-next/c/f881f2732448
  - [v2,net-next,03/17] net: ethernet: mtk_wed: introduce versioning utility routines
    https://git.kernel.org/netdev/net-next/c/d274d523c71c
  - [v2,net-next,04/17] net: ethernet: mtk_wed: do not configure rx offload if not supported
    https://git.kernel.org/netdev/net-next/c/7d5a72733b21
  - [v2,net-next,05/17] net: ethernet: mtk_wed: rename mtk_rxbm_desc in mtk_wed_bm_desc
    https://git.kernel.org/netdev/net-next/c/bafd764a8baa
  - [v2,net-next,06/17] net: ethernet: mtk_wed: introduce mtk_wed_buf structure
    https://git.kernel.org/netdev/net-next/c/ff0ea57fa30e
  - [v2,net-next,07/17] net: ethernet: mtk_wed: move mem_region array out of mtk_wed_mcu_load_firmware
    https://git.kernel.org/netdev/net-next/c/c6d961aeaa77
  - [v2,net-next,08/17] net: ethernet: mtk_wed: make memory region optional
    https://git.kernel.org/netdev/net-next/c/71e2135967f4
  - [v2,net-next,09/17] net: ethernet: mtk_wed: fix EXT_INT_STATUS_RX_FBUF definitions for MT7986 SoC
    https://git.kernel.org/netdev/net-next/c/c80471ba74b7
  - [v2,net-next,10/17] net: ethernet: mtk_wed: add mtk_wed_soc_data structure
    https://git.kernel.org/netdev/net-next/c/9ae7eca9f901
  - [v2,net-next,11/17] net: ethernet: mtk_wed: introduce WED support for MT7988
    https://git.kernel.org/netdev/net-next/c/e2f64db13aa1
  - [v2,net-next,12/17] net: ethernet: mtk_wed: refactor mtk_wed_check_wfdma_rx_fill routine
    https://git.kernel.org/netdev/net-next/c/96ddb4d0bf2e
  - [v2,net-next,13/17] net: ethernet: mtk_wed: introduce partial AMSDU offload support for MT7988
    https://git.kernel.org/netdev/net-next/c/b230812b9dda
  - [v2,net-next,14/17] net: ethernet: mtk_wed: introduce hw_rro support for MT7988
    https://git.kernel.org/netdev/net-next/c/6757d345dd7d
  - [v2,net-next,15/17] net: ethernet: mtk_wed: debugfs: move wed_v2 specific regs out of regs array
    https://git.kernel.org/netdev/net-next/c/4b7e02bb6375
  - [v2,net-next,16/17] net: ethernet: mtk_wed: debugfs: add WED 3.0 debugfs entries
    https://git.kernel.org/netdev/net-next/c/3f3de094e834
  - [v2,net-next,17/17] net: ethernet: mtk_wed: add wed 3.0 reset support
    https://git.kernel.org/netdev/net-next/c/1543b8ff02f0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



