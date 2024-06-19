Return-Path: <netdev+bounces-104813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D174890E7B6
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 12:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32004B2160E
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 10:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B302824A3;
	Wed, 19 Jun 2024 10:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uubXR1cL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D26082495;
	Wed, 19 Jun 2024 10:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718791233; cv=none; b=rw1r4/CH8JgieDHsmIFAoidyPsFwF7XPg0FfxUXzY21Yt4Qt18H0HTLcL3lLQsO3mQGP0V1SRapWKwmW7AgT8+jNY4BQmqWCBactpYN16uZLXX35tXnudvc6eGIcbhKRkkpmbBid7he3kv9Zzy6FV/h9dXYXO/tpm9H9jlK2HUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718791233; c=relaxed/simple;
	bh=07p1prsox17P+Pjb5cI/WVhoAYPvJ9nMpaaLZD3pszo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u5mNPn9McJlveLLfHP4W6Y/ELVGO0KCk0lUZ6CLqq1hHkwDtV7QvTC2c0V+A222tl+vMAME1qXUDg4q900pW5lQrGTrHtWM08b6xjmtZKsozytUbva2VKrv0zcU5uakbt0cMzFE+Z+tBkUtuVpNRC9D42AaE3Dy0zkb6X0ZkDLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uubXR1cL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BC77CC4AF1C;
	Wed, 19 Jun 2024 10:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718791232;
	bh=07p1prsox17P+Pjb5cI/WVhoAYPvJ9nMpaaLZD3pszo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uubXR1cL+nDsQM1Dbg0oU/m8imv5iJgEhsN3LnpQyU5FfmhzmAEbx1J/FD23xR19L
	 QrUao6mfY5ROABrQ84CSwNe33OJFKqipdueCHGjqD1nrFB/Hc0jLAAWigVP3R4JGEi
	 CrSn+rwXG9enf5wRPDkQ6iA7ICMc3fT4jRL7IwZhEsna/9YtCSpgN7Tl/skgIhBmxF
	 DK5CnZQsiHFmHck0REkEFm7pV/Mgx58ZG3iVT8uARgmv6MJyRD/0aETOOyHHIyImGF
	 CsVctdOpjqX+c+H3to2kfGhHIrnEb6/O1ICUcUw0FUIE1EVXeuibbinmaWSdFi7Av5
	 ZST8odbotaf1Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AE513C4361B;
	Wed, 19 Jun 2024 10:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/5] Enable PTP timestamping/PPS for AM65x
 SR1.0 devices
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171879123271.351.10640387100473429916.git-patchwork-notify@kernel.org>
Date: Wed, 19 Jun 2024 10:00:32 +0000
References: <20240617-iep-v4-0-fa20ff4141a3@siemens.com>
In-Reply-To: <20240617-iep-v4-0-fa20ff4141a3@siemens.com>
To: Diogo Ivo <diogo.ivo@siemens.com>
Cc: danishanwar@ti.com, rogerq@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, nm@ti.com, vigneshr@ti.com, kristo@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 jan.kiszka@siemens.com, jacob.e.keller@intel.com, horms@kernel.org,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 wojciech.drewek@intel.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 17 Jun 2024 16:21:39 +0100 you wrote:
> This patch series enables support for PTP in AM65x SR1.0 devices.
> 
> This feature relies heavily on the Industrial Ethernet Peripheral
> (IEP) hardware module, which implements a hardware counter through
> which time is kept. This hardware block is the basis for exposing
> a PTP hardware clock to userspace and for issuing timestamps for
> incoming/outgoing packets, allowing for time synchronization.
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/5] net: ti: icssg-prueth: Enable PTP timestamping support for SR1.0 devices
    https://git.kernel.org/netdev/net-next/c/5e1e43893be2
  - [net-next,v4,2/5] net: ti: icss-iep: Remove spinlock-based synchronization
    https://git.kernel.org/netdev/net-next/c/5758e03cf604
  - [net-next,v4,3/5] dt-bindings: net: Add IEP interrupt
    https://git.kernel.org/netdev/net-next/c/5056860cf8ea
  - [net-next,v4,4/5] net: ti: icss-iep: Enable compare events
    https://git.kernel.org/netdev/net-next/c/f18ad402cd8b
  - [net-next,v4,5/5] arm64: dts: ti: iot2050: Add IEP interrupts for SR1.0 devices
    https://git.kernel.org/netdev/net-next/c/71be1189c92b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



