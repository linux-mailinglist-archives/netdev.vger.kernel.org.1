Return-Path: <netdev+bounces-14954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD237448E0
	for <lists+netdev@lfdr.de>; Sat,  1 Jul 2023 14:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AC4E281197
	for <lists+netdev@lfdr.de>; Sat,  1 Jul 2023 12:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14385BE61;
	Sat,  1 Jul 2023 12:20:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B89C5CA1
	for <netdev@vger.kernel.org>; Sat,  1 Jul 2023 12:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A983DC433CA;
	Sat,  1 Jul 2023 12:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688214022;
	bh=80qZ2OoLhTkgmsH8csyzGV5MLoKizYyCcM53np1bR1Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fewzkHW2pSC11zrKRLJVHuvAnyykZ8OQv4VtTpMiQiy1AP4fAdat9HWQ/T3l4i2Rg
	 IfoPebxT8OC5SJN6M1w+Ux3ztYi1bRqL0OZS858SCE2Z4A7AL568rb9YwHTgl8eiyv
	 xVBy4sCSrO17ni+bz0JhrQv2q/YHZKMUhVcOJnXKYigl3F2uUnc9P6snlv53HtDCx1
	 GtXZJw2Rtk52sc6ks0scG7w9KuhpO7hvMowSnLMXP38/R6SlZlBjvhQQogA3vJ+G4S
	 tvruGLGLTM1WX90/dnsQLlBjbjFOsWxZAlXh4On0uU3ImA1Dcg3/hBQmGO9Svvv2Nx
	 C2enkverHXXfg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8BC64C691F0;
	Sat,  1 Jul 2023 12:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: usb: cdc_ether: add u-blox 0x1313 composition.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168821402256.27463.17009519930792690898.git-patchwork-notify@kernel.org>
Date: Sat, 01 Jul 2023 12:20:22 +0000
References: <20230629103736.23861-1-davide.tronchin.94@gmail.com>
In-Reply-To: <20230629103736.23861-1-davide.tronchin.94@gmail.com>
To: Davide Tronchin <davide.tronchin.94@gmail.com>
Cc: oliver@neukum.org, netdev@vger.kernel.org, pabeni@redhat.com,
 marco.demarco@posteo.net, linux-usb@vger.kernel.org, kuba@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 29 Jun 2023 12:37:36 +0200 you wrote:
> Add CDC-ECM support for LARA-R6 01B.
> 
> The new LARA-R6 product variant identified by the "01B" string can be
> configured (by AT interface) in three different USB modes:
> * Default mode (Vendor ID: 0x1546 Product ID: 0x1311) with 4 serial
> interfaces
> * RmNet mode (Vendor ID: 0x1546 Product ID: 0x1312) with 4 serial
> interfaces and 1 RmNet virtual network interface
> * CDC-ECM mode (Vendor ID: 0x1546 Product ID: 0x1313) with 4 serial
> interface and 1 CDC-ECM virtual network interface
> The first 4 interfaces of all the 3 configurations (default, RmNet, ECM)
> are the same.
> 
> [...]

Here is the summary with links:
  - net: usb: cdc_ether: add u-blox 0x1313 composition.
    https://git.kernel.org/netdev/net/c/1b0fce8c8e69

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



