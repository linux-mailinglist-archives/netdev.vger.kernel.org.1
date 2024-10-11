Return-Path: <netdev+bounces-134725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3A599AED5
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 00:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAC7B1F25182
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 22:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DFB1E7C02;
	Fri, 11 Oct 2024 22:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLp1fJhQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B37C1E7674;
	Fri, 11 Oct 2024 22:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728687038; cv=none; b=XBS2IFI3WPV1h4Jjnti6dF8IWzhrw7l2hhWBW6WUfoc6l1r9lInjebbY09CZe7dbF9EL598Pm9eO6UTu7dh+vKzFOZT96H4oqDqFC78V1/N/ZFfSe7pcA83qh7XGc77GGQaAQRvjDy6QDCyJhqqSbqidFagX/KbtbQDN47D03Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728687038; c=relaxed/simple;
	bh=ZaV6Mue0fosJp0aMOO4BNyLbnIsDW+mgTd9UNqjVpeo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PmwJxcpm8hP2LCMkmQu2/Dm4WbT752YMzII6D4l9grkh5Mpa7dX9amuNWWKtHnUrxtw2Ih+6lwra/f9RnWz8fs0ji4JMQn2Sdy2S9ezaFKkUyKXOmsZsq3MKVJ6v93grUK3gAJ/gIdGWAbA6JssRlIxe+h21MQxd6tJDCnJjnT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLp1fJhQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B052C4CECC;
	Fri, 11 Oct 2024 22:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728687038;
	bh=ZaV6Mue0fosJp0aMOO4BNyLbnIsDW+mgTd9UNqjVpeo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iLp1fJhQm4+vQeHoF31n2d5RFSk01Uymb2Z4GybuP9RNRkqBpVUYCNvDOD6KULSBc
	 lEKxDmLQam+ZYIoRxq7ea3CQdIR+2yQmtzz8TQEpoNlpHrC9qM1qJlGY26D2D0BX/s
	 bj3xElDPqwnnZcnLiv1eWajjvJNCbD0M6lxk2enb5lolzvz0P7Mny+0KeAz+Uwzt6c
	 7JAivwzcZWAJA0Ikcw+qVDmlzSDVuBdR7uSCewtMdbA+1qS5i1t6NGax5+4HEVLmGO
	 cwkCD2eoywA4tYH2E9qiTbwyRB7GRYcnXL0DRocSYYhaRUytPbMTT+s5CTYkIyYRls
	 fK1bo01ecdmVg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F3038363CB;
	Fri, 11 Oct 2024 22:50:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/3] net: xilinx: emaclite: Adopt clock support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172868704274.3018281.6923071577652903660.git-patchwork-notify@kernel.org>
Date: Fri, 11 Oct 2024 22:50:42 +0000
References: <1728491303-1456171-1-git-send-email-radhey.shyam.pandey@amd.com>
In-Reply-To: <1728491303-1456171-1-git-send-email-radhey.shyam.pandey@amd.com>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 michal.simek@amd.com, harini.katakam@amd.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, git@amd.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 9 Oct 2024 21:58:20 +0530 you wrote:
> This patchset adds emaclite clock support. AXI Ethernet Lite IP can also
> be used on SoC platforms like Zynq UltraScale+ MPSoC which combines
> powerful processing system (PS) and user-programmable logic (PL) into
> the same device. On these platforms it is mandatory to explicitly enable
> IP clocks for proper functionality.
> 
> Changes for v3:
> - Add Conor's ack to 1/3 patch.
> - Remove braces around dev_err_probe().
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/3] dt-bindings: net: emaclite: Add clock support
    https://git.kernel.org/netdev/net-next/c/60dbdc6e08d6
  - [net-next,v3,2/3] net: emaclite: Replace alloc_etherdev() with devm_alloc_etherdev()
    https://git.kernel.org/netdev/net-next/c/130fbea551c5
  - [net-next,v3,3/3] net: emaclite: Adopt clock support
    https://git.kernel.org/netdev/net-next/c/76d46d766a45

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



