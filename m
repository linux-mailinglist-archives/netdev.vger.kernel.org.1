Return-Path: <netdev+bounces-173132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B65A577EC
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 04:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 593DE3B64A9
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 03:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF4315687D;
	Sat,  8 Mar 2025 03:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pUh1QOmc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522F3155A4D;
	Sat,  8 Mar 2025 03:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741405207; cv=none; b=p/WBtzet4AecPHwhM1G5zvaP8xGpSzw+GYepmJGUfscuCjRnw+3oLG85PHL+z17VXVLxk4nl2F54JxaboNMo4fv8R0VGTjE3xGUT5jo6pgSU97ZXh7cNQ1+vRsGbTP+TzgwnU62Gb/G7/qPOtiGtAYWFWYEs5jQ8qxgqm8bTpR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741405207; c=relaxed/simple;
	bh=dVvXK24WBEPj0e29XKe2ikFqgyVizRahrNwFDVA4xG8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BxAiOSntC++GpOPj1XInq+t+Fz/WOqyKGRSH6hz97OTh+s2su+REy5kKJPpAStA8k6SQ7s85P5RBx5QL1sahf4UOIsMAs7VnKviRGu6ycEckjIxnynCI+Cqx7ECqX5Kyc+ZSNZDHgfA8q1Ugn+wIzwtiIUW97jOdkV4eIexOnBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pUh1QOmc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D90C4CED1;
	Sat,  8 Mar 2025 03:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741405207;
	bh=dVvXK24WBEPj0e29XKe2ikFqgyVizRahrNwFDVA4xG8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pUh1QOmcYXwUjKiYd6N1veno6ulCbXLSXt6KkpHPE0vuwsPWtXRZ+kiZypPXb0Ak+
	 ufiRS359i4AyNpPjcD/e2a895mA9NXYmPDjMz3cFF2eTFYxoJGGtbR3OBBBhfqmDPt
	 gGTO//0Cw+VxAjZkeGQ6D0M58WPkISx7harZi31LFkFGyD5JC69jafUF+WfT+RfkZt
	 r8iapfM3Anpab/6ALj+Z4yvmmw28Q51pJBlnszt5I6cB7Lh8u5CpKtcOwIlwUHBMsE
	 fxUgiyMjR8j0RKuX65z4xMXaj+P18c0FDKVdrVpCR4fK+Q2uYX4pca7yXN/ENPvTbv
	 wSmqzcqsQuBEQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB011380CFFB;
	Sat,  8 Mar 2025 03:40:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/14] net: bcmgenet: revise suspend/resume
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174140524073.2565853.13209148913888544727.git-patchwork-notify@kernel.org>
Date: Sat, 08 Mar 2025 03:40:40 +0000
References: <20250306192643.2383632-1-opendmb@gmail.com>
In-Reply-To: <20250306192643.2383632-1-opendmb@gmail.com>
To: Doug Berger <opendmb@gmail.com>
Cc: florian.fainelli@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  6 Mar 2025 11:26:28 -0800 you wrote:
> This commit set updates the GENET driver to reduce the delay to
> resume the ethernet link when the Wake on Lan features are used.
> 
> In addition, the encoding of hardware versioning and features is
> revised to avoid some redundancy and improve readability as well
> as remove a warning that occurred for the BCM7712 device which
> updated the device major version while maintaining compatibility
> with the driver.
> 
> [...]

Here is the summary with links:
  - [net-next,01/14] net: bcmgenet: bcmgenet_hw_params clean up
    https://git.kernel.org/netdev/net-next/c/d2b41068056b
  - [net-next,02/14] net: bcmgenet: add bcmgenet_has_* helpers
    https://git.kernel.org/netdev/net-next/c/07c1a756a50b
  - [net-next,03/14] net: bcmgenet: move feature flags to bcmgenet_priv
    https://git.kernel.org/netdev/net-next/c/a2bdde505f14
  - [net-next,04/14] net: bcmgenet: BCM7712 is GENETv5 compatible
    https://git.kernel.org/netdev/net-next/c/59a97b8184ef
  - [net-next,05/14] net: bcmgenet: extend bcmgenet_hfb_* API
    https://git.kernel.org/netdev/net-next/c/f841f5ef9911
  - [net-next,06/14] net: bcmgenet: move DESC_INDEX flow to ring 0
    https://git.kernel.org/netdev/net-next/c/3b5d4f5a820d
  - [net-next,07/14] net: bcmgenet: add support for RX_CLS_FLOW_DISC
    https://git.kernel.org/netdev/net-next/c/6d31f8fc6c2f
  - [net-next,08/14] net: bcmgenet: remove dma_ctrl argument
    https://git.kernel.org/netdev/net-next/c/8b031d4e9baa
  - [net-next,09/14] net: bcmgenet: consolidate dma initialization
    https://git.kernel.org/netdev/net-next/c/58affb23b667
  - [net-next,10/14] net: bcmgenet: introduce bcmgenet_[r|t]dma_disable
    https://git.kernel.org/netdev/net-next/c/791f349d02f7
  - [net-next,11/14] net: bcmgenet: support reclaiming unsent Tx packets
    https://git.kernel.org/netdev/net-next/c/f1bacae8b655
  - [net-next,12/14] net: bcmgenet: move bcmgenet_power_up into resume_noirq
    https://git.kernel.org/netdev/net-next/c/ffce2bedd361
  - [net-next,13/14] net: bcmgenet: allow return of power up status
    https://git.kernel.org/netdev/net-next/c/2432b9817b7c
  - [net-next,14/14] net: bcmgenet: revise suspend/resume
    https://git.kernel.org/netdev/net-next/c/254f3239dd07

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



