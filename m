Return-Path: <netdev+bounces-43549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE387D3D56
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 19:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B6D11C203B0
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 17:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289651F955;
	Mon, 23 Oct 2023 17:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ueKGSGt/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095C41BDE8
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 17:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9DB21C433CA;
	Mon, 23 Oct 2023 17:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698081623;
	bh=TeskCatNxKCfkaU6i+Pkh6LO+I36nm+j+k8f5MapB+E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ueKGSGt/dH/k2FPoxYQ75+6/lYBjWJtmPG2vjfV8gM3LKtOTmpb1qLYyaLxGEQVlr
	 zpaIU9I2oD3EfswmJvuW7wrI9d0pVBfP3+L4cRHwxJhTswLGb3V5KIWDdHwPyf+Zjv
	 gYlckOD7ULBN2U6HDXlF2CYg1Osi1pakf1rFr7XH5/RBZbULzeTiZM+Ykj6y/yntgh
	 rA3aqUx0LaBufscnYSx8C295aC+wF8+UAUjHtU+AdyJjD3N5fMfKD/I2lAbfDroqY5
	 g0jKMJzaoT6SKzRbmpUkjejyd04Gchjv4IOeL/Oagb9ONi0veecjnGt0Gw9z8C98Rm
	 jegg6CiKP0KBg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 83222E4CC1D;
	Mon, 23 Oct 2023 17:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: mdio: xgene: Fix unused xgene_mdio_of_match warning for
 !CONFIG_OF
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169808162352.28677.7872131827192405405.git-patchwork-notify@kernel.org>
Date: Mon, 23 Oct 2023 17:20:23 +0000
References: <20231019182345.833136-1-robh@kernel.org>
In-Reply-To: <20231019182345.833136-1-robh@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: iyappan@os.amperecomputing.com, keyur@os.amperecomputing.com,
 quan@os.amperecomputing.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, lkp@intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 19 Oct 2023 13:23:45 -0500 you wrote:
> Commit a243ecc323b9 ("net: mdio: xgene: Use device_get_match_data()")
> dropped the unconditional use of xgene_mdio_of_match resulting in this
> warning:
> 
> drivers/net/mdio/mdio-xgene.c:303:34: warning: unused variable 'xgene_mdio_of_match' [-Wunused-const-variable]
> 
> The fix is to drop of_match_ptr() which is not necessary because DT is
> always used for this driver (well, it could in theory support ACPI only,
> but CONFIG_OF is always enabled for arm64).
> 
> [...]

Here is the summary with links:
  - net: mdio: xgene: Fix unused xgene_mdio_of_match warning for !CONFIG_OF
    https://git.kernel.org/netdev/net-next/c/d6e48462e88f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



