Return-Path: <netdev+bounces-13257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D2373AEF2
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 05:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75D1F2818CF
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 03:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261B938C;
	Fri, 23 Jun 2023 03:10:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5547E0
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 03:10:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 07327C433C9;
	Fri, 23 Jun 2023 03:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687489831;
	bh=PkwBaqiiHT4lcVO+pYZX1xYEM0E1dJyturyLfcjo10U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=a4pl5JTRZnD9x0st4z2krM14RM0pMoP3E8TOwkNWW/FSRjyF15pi/O3Jfgx9+jG4J
	 gMPkN7PwL4fU2lMu4VZIzWprgSSOLRY5fTROrLKK7QgAMlhTxR0CxgPmSpFmZChxZA
	 hhTSmnqhdhnONH5WwpohvLn9M+8Gd/3YStbumtIEE68XJf6wdxVqEURFsnBDdsHu5k
	 MdZQPn7/qBQSxzyrksSAIbwySv9qWZm2uq8EmAewglYhUMqZ4hfHztK1j+E/vyAM0g
	 gB5EoWe2JOxn/yGmbk0cqrnTKi63iS89YQTTLUWnkjoqjumUPCWUtKzc3I0R5V99Me
	 97pnXQWo+JdiA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E4D3AC691EE;
	Fri, 23 Jun 2023 03:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 01/33] can: kvaser_usb: Add len8_dlc support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168748983093.10729.10254332605000970682.git-patchwork-notify@kernel.org>
Date: Fri, 23 Jun 2023 03:10:30 +0000
References: <20230622082658.571150-2-mkl@pengutronix.de>
In-Reply-To: <20230622082658.571150-2-mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de,
 carsten.schmidt-achim@t-online.de, extja@kvaser.com

Hello:

This series was applied to netdev/net-next.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Thu, 22 Jun 2023 10:26:26 +0200 you wrote:
> From: Carsten Schmidt <carsten.schmidt-achim@t-online.de>
> 
> Add support for the Classical CAN raw DLC functionality to send and
> receive DLC values from 9 .. 15.
> 
> v1: https://lore.kernel.org/all/20230506105529.4023-1-carsten.schmidt-achim@t-online.de
> 
> [...]

Here is the summary with links:
  - [net-next,01/33] can: kvaser_usb: Add len8_dlc support
    https://git.kernel.org/netdev/net-next/c/843b84640349
  - [net-next,02/33] can: dev: add transceiver capabilities to xilinx_can
    https://git.kernel.org/netdev/net-next/c/d7588f02e8d8
  - [net-next,03/33] can: esd_usb: Make use of existing kernel macros
    https://git.kernel.org/netdev/net-next/c/1ad549cf980c
  - [net-next,04/33] can: esd_usb: Replace initializer macros used for struct can_bittiming_const
    https://git.kernel.org/netdev/net-next/c/5a4dd8796d77
  - [net-next,05/33] can: esd_usb: Use consistent prefixes for macros
    https://git.kernel.org/netdev/net-next/c/9dc3a695da58
  - [net-next,06/33] can: esd_usb: Prefix all structures with the device name
    https://git.kernel.org/netdev/net-next/c/8ef426e1f605
  - [net-next,07/33] can: esd_usb: Replace hardcoded message length given to USB commands
    https://git.kernel.org/netdev/net-next/c/299a557651d7
  - [net-next,08/33] can: esd_usb: Don't bother the user with nonessential log message
    https://git.kernel.org/netdev/net-next/c/1336ca2d4601
  - [net-next,09/33] can: esd_usb: Make use of kernel macros BIT() and GENMASK()
    https://git.kernel.org/netdev/net-next/c/33665fdbd7ff
  - [net-next,10/33] can: esd_usb: Use consistent prefix ESD_USB_ for macros
    https://git.kernel.org/netdev/net-next/c/8a99f2ada0b8
  - [net-next,11/33] can: sja1000: Prepare the use of a threaded handler
    https://git.kernel.org/netdev/net-next/c/af7647a0b4b5
  - [net-next,12/33] can: sja1000: Prevent overrun stalls with a soft reset on Renesas SoCs
    https://git.kernel.org/netdev/net-next/c/717c6ec241b5
  - [net-next,13/33] can: rx-offload: fix coding style
    https://git.kernel.org/netdev/net-next/c/fe6027fe097a
  - [net-next,14/33] can: ti_hecc: fix coding style
    https://git.kernel.org/netdev/net-next/c/8a9d8a3c8a05
  - [net-next,15/33] can: m_can: fix coding style
    https://git.kernel.org/netdev/net-next/c/3d68f116ccdf
  - [net-next,16/33] can: length: fix description of the RRS field
    https://git.kernel.org/netdev/net-next/c/10711b11102b
  - [net-next,17/33] can: length: fix bitstuffing count
    https://git.kernel.org/netdev/net-next/c/9fde4c557f78
  - [net-next,18/33] can: length: refactor frame lengths definition to add size in bits
    (no matching commit)
  - [net-next,19/33] can: kvaser_pciefd: Remove useless write to interrupt register
    https://git.kernel.org/netdev/net-next/c/7c921556c04f
  - [net-next,20/33] can: kvaser_pciefd: Remove handler for unused KVASER_PCIEFD_PACK_TYPE_EFRAME_ACK
    https://git.kernel.org/netdev/net-next/c/76c66ddf7f89
  - [net-next,21/33] can: kvaser_pciefd: Add function to set skb hwtstamps
    https://git.kernel.org/netdev/net-next/c/2d55e9f9b442
  - [net-next,22/33] can: kvaser_pciefd: Set hardware timestamp on transmitted packets
    https://git.kernel.org/netdev/net-next/c/ec681b91befa
  - [net-next,23/33] can: kvaser_pciefd: Define unsigned constants with type suffix 'U'
    https://git.kernel.org/netdev/net-next/c/2c470dbbd32f
  - [net-next,24/33] can: uapi: move CAN_RAW_FILTER_MAX definition to raw.h
    https://git.kernel.org/netdev/net-next/c/735d86a8aaf6
  - [net-next,25/33] can: kvaser_pciefd: Remove SPI flash parameter read functionality
    https://git.kernel.org/netdev/net-next/c/c496adafee68
  - [net-next,26/33] can: kvaser_pciefd: Sort includes in alphabetic order
    https://git.kernel.org/netdev/net-next/c/1b83d0ba1c11
  - [net-next,27/33] can: kvaser_pciefd: Rename device ID defines
    https://git.kernel.org/netdev/net-next/c/488c07b441f9
  - [net-next,28/33] can: kvaser_pciefd: Change return type for kvaser_pciefd_{receive,transmit,set_tx}_irq()
    https://git.kernel.org/netdev/net-next/c/24aecf553701
  - [net-next,29/33] can: kvaser_pciefd: Sort register definitions
    https://git.kernel.org/netdev/net-next/c/69335013c451
  - [net-next,30/33] can: kvaser_pciefd: Use FIELD_{GET,PREP} and GENMASK where appropriate
    https://git.kernel.org/netdev/net-next/c/954fb21268dd
  - [net-next,31/33] can: kvaser_pciefd: Add len8_dlc support
    https://git.kernel.org/netdev/net-next/c/f07008a21364
  - [net-next,32/33] can: kvaser_pciefd: Refactor code
    https://git.kernel.org/netdev/net-next/c/f4845741e422
  - [net-next,33/33] can: kvaser_pciefd: Use TX FIFO size read from CAN controller
    https://git.kernel.org/netdev/net-next/c/6fdcd64ec34d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



