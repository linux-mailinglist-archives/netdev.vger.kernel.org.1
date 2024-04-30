Return-Path: <netdev+bounces-92503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F2F8B7960
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 16:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3617E28261D
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 14:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFF8770EC;
	Tue, 30 Apr 2024 14:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jf5vMd9w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EE6770E0;
	Tue, 30 Apr 2024 14:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714486831; cv=none; b=EuAzsGufyc+KJM629DByPTkwwUI81bWXshR9d0B300UdeymNuM6xStvn+1T2fwhQrs6ef4wJzbSR1pBIWP2DyNPhmEmQVP9LAMBE4WOI2UnQekgm0EE6n2KpUFMLahDnA0KswKsLbRdx5g8LtzdRtZGTEg7I8y7a4HnxGi+p4k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714486831; c=relaxed/simple;
	bh=33rST+o+Aup5/KOnLxqpLJYDmZ5AhQI7F5lPxcmCn2A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tqxJNwYNujh4Rm+c2OojHEx6f3PPTHAXS0g2GNVwCIgngDNETXk2TmMUaDJg048aHPa7iMPIarnKlo0GVMHUcSimFqNZ9Qbi6DjApWFOMzWZKCOg3JZsP9Nujt+KYddvwnXR7PIK9NnIR3iBgc6HAzSxRiSRGZ02lgbHaBi0BUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jf5vMd9w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8064FC4AF19;
	Tue, 30 Apr 2024 14:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714486830;
	bh=33rST+o+Aup5/KOnLxqpLJYDmZ5AhQI7F5lPxcmCn2A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jf5vMd9wSd9wfuoKB08ZvJeXpuSdKWiiIxvpss7+//dxyS8PqwJOPOBu7dVZdia4i
	 Vlv5y2kfojArp5fn9BPaeozwXRQBNlBTE/Jr47u4umEG5DmiF+ycos9Yq99GqnUsdu
	 6Mn86TiUDlFXL5vpD6R4fT81Q433pjnabSy1BGE6Yd7lylXW1xSFEc76FhOHh7eCqe
	 hVkgJ2njMZcXKP1OG2gpNaiCVRGwTJ+BGuM4t5Z0sWRwU48D5yO/9x0Gh/PG5und/2
	 pSJnuW9kyAxCsQSnimwyE2lGsRUaTUTfRNnW1NKLmc63tsnirjrfrKJ8BEqASUX5Cy
	 yIgF0rMRlirTw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 696AAC43616;
	Tue, 30 Apr 2024 14:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [bluetooth-next PATCH v3] dt-bindings: net: broadcom-bluetooth: Add
 CYW43439 DT binding
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171448683042.20667.15080644752869073034.git-patchwork-notify@kernel.org>
Date: Tue, 30 Apr 2024 14:20:30 +0000
References: <20240430010914.110179-1-marex@denx.de>
In-Reply-To: <20240430010914.110179-1-marex@denx.de>
To: Marek Vasut <marex@denx.de>
Cc: linux-bluetooth@vger.kernel.org, krzysztof.kozlowski@linaro.org,
 davem@davemloft.net, conor+dt@kernel.org, edumazet@google.com,
 kuba@kernel.org, krzysztof.kozlowski+dt@linaro.org, linus.walleij@linaro.org,
 luiz.dentz@gmail.com, marcel@holtmann.org, pabeni@redhat.com,
 robh@kernel.org, devicetree@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 30 Apr 2024 03:08:42 +0200 you wrote:
> CYW43439 is a Wi-Fi + Bluetooth combo device from Infineon.
> The Bluetooth part is capable of Bluetooth 5.2 BR/EDR/LE .
> This chip is present e.g. on muRata 1YN module.
> 
> Extend the binding with its DT compatible using fallback
> compatible string to "brcm,bcm4329-bt" which seems to be
> the oldest compatible device. This should also prevent the
> growth of compatible string tables in drivers. The existing
> block of compatible strings is retained.
> 
> [...]

Here is the summary with links:
  - [bluetooth-next,v3] dt-bindings: net: broadcom-bluetooth: Add CYW43439 DT binding
    https://git.kernel.org/bluetooth/bluetooth-next/c/25acde2bb2fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



