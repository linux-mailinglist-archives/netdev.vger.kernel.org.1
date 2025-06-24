Return-Path: <netdev+bounces-200546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D245AE604F
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 11:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 761FE3A4900
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 09:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DEE25DB13;
	Tue, 24 Jun 2025 09:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UWHGNamx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BEA1F4C87;
	Tue, 24 Jun 2025 09:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750756183; cv=none; b=J/OZ5uNtZApnzkCy6P16XhC9KGwT4tuNAlyIsePb81aX8R0tEcJtk6ZBKmtHR4jxwUk0o7eCPnzk21NxbZkMogvI9IMZAri8g38DZwotf1b6BT7QIFdqYmTKouSn3EnpB81g9IxTEIZAmGj82Gd9Bpquc9vZIAerk3pIZvv+q3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750756183; c=relaxed/simple;
	bh=kUUEg/dc1C0N7OzuDwlVPne5kfMH80qMuZXAZy4i0GI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=avT+N0EFLULGYskq56qbwvTw1TvCSrlT26+6jC6HB14eFs+VMGDpMG/7iIocSayY7fZUFYCnUwXzxQYuwoXkSPWL06DwdqvmFztCdMGIwYhxv5sWKqxuksV3OVCLhTc4Se2UlFxbKIlPwyD7cGXL/coiKcgBFJv73qxfQapeMcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UWHGNamx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12508C4CEEF;
	Tue, 24 Jun 2025 09:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750756183;
	bh=kUUEg/dc1C0N7OzuDwlVPne5kfMH80qMuZXAZy4i0GI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UWHGNamxfa/TVPN7KKRLdAV12RBKm57TmROV9koR0Fsqvs7IKqDOoxn1w7mwH28d0
	 MyRNve9Z79gUX/gRfASZReg9r9URH0RvPktxvGe6Lr/lJf26nkbqRK9vl8D4tjoasP
	 kPEK6v5kwDRlxWkOJHSEakejwHERu7DlfR9ds0F8KLP1rOR/h7Qx1SajJvD5DTbSIn
	 KaH4Yq7EEzAFG1z8VaeRnZwVbOWjIzCt6OhAdNR5DPxL/DmvWpzOPwBbgrp8NBAbYU
	 sypoxWn5+rlEN7f/phhPxsnBu6n4cpKOqHZn5Ffiiauokj1gIHqHzb0tL4nIEiX0YY
	 FebXP2ZqNpQHQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CF838111DD;
	Tue, 24 Jun 2025 09:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] PSE: Improve documentation clarity
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175075621015.3463713.6658210960670653659.git-patchwork-notify@kernel.org>
Date: Tue, 24 Jun 2025 09:10:10 +0000
References: <20250620-poe_doc_improve-v1-0-96357bb95d52@bootlin.com>
In-Reply-To: <20250620-poe_doc_improve-v1-0-96357bb95d52@bootlin.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: o.rempel@pengutronix.de, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, thomas.petazzoni@bootlin.com,
 piotr.kubik@adtran.com, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 20 Jun 2025 12:02:38 +0200 you wrote:
> Thanks to new PSE driver being proposed on the mailinglist figured out
> there was some unclear documentation, which lead the developer on the
> wrong path. Clarify these documentation.
> 
> The changes focus on clarifying the setup_pi_matrix callback behavior
> and improving device tree binding descriptions, particularly around
> channel-to-PI mapping relationships that are critical for proper PSE
> controller integration.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] dt-bindings: pse: tps23881: Clarify channels property description
    https://git.kernel.org/netdev/net-next/c/42fa8f17e453
  - [net-next,2/2] net: pse-pd: tps23881: Clarify setup_pi_matrix callback documentation
    https://git.kernel.org/netdev/net-next/c/dad51ea09040

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



