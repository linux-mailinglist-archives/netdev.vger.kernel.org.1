Return-Path: <netdev+bounces-66724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC58B840656
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 14:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A950128A1C7
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 13:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B5C5BAD2;
	Mon, 29 Jan 2024 13:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ow9464dL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0258E62A02
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 13:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706533827; cv=none; b=aE9J9WO9/PiY8eh/P1SHyG3d3FhnFGPY4Cvp8ktW1ff95G19FNO07V3X83mFdt3MBKRMvfZZVPv9Xy1ON9YUV7o/tikOHx99wPSigNOR7yiDGRWQX1NagjQ2UxR7lpKH/mX3nJOQAUWqAKR+kGENxgAJ1c1kBXhRR+dRLQBUaAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706533827; c=relaxed/simple;
	bh=uZ/WPf33GubLfo2XYIw6O8PlYdncTLYyQH5So2uaLvs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hqN/GjcDYyr/dIW6XfcyBPbqTgHJ0KIwqIYLnIhJDp90w+GlN5scVPik+iyQkbDmr3XvjOUTZOJSPk2dhzKsi4Xc23oQSs2KY3gmX25mD4SNYX+OUF3Gq0zbTbje6dP82LrBvv+rMGWtohbIR9J0VfeBJs++yqSuTzr8v74LCos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ow9464dL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 74CC2C433C7;
	Mon, 29 Jan 2024 13:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706533826;
	bh=uZ/WPf33GubLfo2XYIw6O8PlYdncTLYyQH5So2uaLvs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ow9464dL1zDEcRK3K2p+8XCYusewp/hVZduwZNwArr4faD4sXwlUoeTlsOQWmkG+Q
	 xAXAcCjTWCniw1j7TmOz3jz/1h4r8dIsb3mlx4BHeMkBZtq88bNZFpW/cYiqnNdKN2
	 2iv0qr8IxOV45VFe1KrvEALKWZ+m29pneS6VdZt0QXpfHwYK0gf/QM61wo9UtFgsd3
	 PthAubCv1YY+h9ZkB4HpuCQoC3+c9CKVOffpNV8F9ukS1y14u8WsOp94+U/Zpx45Ls
	 fnNLYLfYmR8XG5M6eGOLAdAC5BJVE5I4YhHXdkeJH7Zn09uPTFG2P1w7xXjQuDXWGZ
	 a6lg1HcdP2Yww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4F5ECC561EE;
	Mon, 29 Jan 2024 13:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] dt-bindings: nfc: ti,trf7970a: fix usage example
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170653382631.16154.6112552138889640140.git-patchwork-notify@kernel.org>
Date: Mon, 29 Jan 2024 13:10:26 +0000
References: <20240125201505.1117039-1-t.schramm@manjaro.org>
In-Reply-To: <20240125201505.1117039-1-t.schramm@manjaro.org>
To: Tobias Schramm <t.schramm@manjaro.org>
Cc: netdev@vger.kernel.org, krzysztof.kozlowski@linaro.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 25 Jan 2024 21:15:05 +0100 you wrote:
> The TRF7970A is a SPI device, not I2C.
> 
> Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] dt-bindings: nfc: ti,trf7970a: fix usage example
    https://git.kernel.org/netdev/net-next/c/9e1aa985d61e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



