Return-Path: <netdev+bounces-117226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 841BD94D284
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 16:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D7AD281620
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 14:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD32C1957FC;
	Fri,  9 Aug 2024 14:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u9PjMn7r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A12F13FFC;
	Fri,  9 Aug 2024 14:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723215032; cv=none; b=uMSkCfSiBhVM+CG2vVO+X3IGR2THl4E7JzB3lzNMI8Xk00QG+qzQjRKSlYDZovRZuAuI9/39zcglkrlZqR2AX/xoVvEfRQWnVGJbNq8YACpPxF0aNclOXy5JbxtBBTtAGwgKJ793h4I7fWynX15JVElXJ6ObeSXSZ8FapMf61R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723215032; c=relaxed/simple;
	bh=o2boHsvugOoSfnRryclCz3yN8ZygMbaTL2M4TClf0ho=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fkwC0RXEdqwLgnsVk07uL+/xJ2BqcuMI2iIOxPL2MsJmC8s+EPvgTTCKZDTn9AeJcCqyt3XnRM8vpZs9V6DPsBUXmSXQxPOQ39xF1+1/5GMtIYYenPg3saS81L0XBJt2mdffA5ICo3ah3ZfBqiw6RIjamTKpMGTGJLQU8h5doDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u9PjMn7r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB2CAC32782;
	Fri,  9 Aug 2024 14:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723215030;
	bh=o2boHsvugOoSfnRryclCz3yN8ZygMbaTL2M4TClf0ho=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=u9PjMn7rRm/BVqGZVoTXCghvzLq1t+ClKm564TRMywPtaeTIB6+74i5T8cQiss5XS
	 fcu7Z9W3kAcLFcfwX9i2MxCkoprfn6C5uBw7LWJGYEtAcZ66cguckB08J08aQRwWoq
	 5Ry3C0RnhI2H7Pyo3sAR9dJym4ulLDbFDNHMf44WhIyTqieERQqDLnW+jOIbXQDpy2
	 id+mCpL6CQEiToKcY9aIFV7ViJrE+uV6NjbfXiFpOzdroMTZtbngf8R+TExCBtK+si
	 59hctD/uUghz/QCVO3dDg6+0WQQuXn2dIlREFsiQ8mMfQ8nw9b2Y20Y2/KadEi/eCp
	 /j8j7b+CaaSxw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEB6382333D;
	Fri,  9 Aug 2024 14:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/3] Add support for Amlogic HCI UART
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172321502977.3810378.15779692366071680309.git-patchwork-notify@kernel.org>
Date: Fri, 09 Aug 2024 14:50:29 +0000
References: <20240809-btaml-v4-0-376b284405a7@amlogic.com>
In-Reply-To: <20240809-btaml-v4-0-376b284405a7@amlogic.com>
To: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, catalin.marinas@arm.com,
 will@kernel.org, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, yang.li@amlogic.com,
 krzysztof.kozlowski@linaro.org, ye.he@amlogic.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 09 Aug 2024 13:42:23 +0800 you wrote:
> Add support for Amlogic HCI UART, including dt-binding,
> and Amlogic Bluetooth driver.
> 
> Signed-off-by: Yang Li <yang.li@amlogic.com>
> ---
> Changes in v4:
> - Modified the compatible list in the DT binding.
> - Reduced the boot delay from 350ms to 60ms.
> - Minor fixes.
> - Link to v3: https://lore.kernel.org/r/20240802-btaml-v3-0-d8110bf9963f@amlogic.com
> 
> [...]

Here is the summary with links:
  - [v4,1/3] dt-bindings: net: bluetooth: Add support for Amlogic Bluetooth
    https://git.kernel.org/bluetooth/bluetooth-next/c/8802f81065c3
  - [v4,2/3] Bluetooth: hci_uart: Add support for Amlogic HCI UART
    https://git.kernel.org/bluetooth/bluetooth-next/c/58803465ec1a
  - [v4,3/3] MAINTAINERS: Add an entry for Amlogic HCI UART (M: Yang Li)
    https://git.kernel.org/bluetooth/bluetooth-next/c/f173b220f9dc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



