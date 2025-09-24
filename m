Return-Path: <netdev+bounces-225740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BD0B97D8A
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 02:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2C82B4E0131
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 00:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA46F15D1;
	Wed, 24 Sep 2025 00:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+obHWTQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856034C6C
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 00:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758672612; cv=none; b=eLiZE9buPnxoHXmgDcPrQeUcU0ZtNpEtzJwAtCWvaV+LmMAgIS4WXVyp/URnHDwuMBQgaBsnGPVnAaoOywpwbdTj7EyApft4ri0mFRLj/gd2NnGjwu+8sUIVwhbz9G2Hu6IzdkjtY0ET9JCAL4UoqkbBQHrrarsaonYBfWB6O/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758672612; c=relaxed/simple;
	bh=/o0FGhrUAZ+oxYrfk+E3PYUzIRtYM7ymasxWSjBlMUg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=o68tN18byJ1+Z9uCcuhbDiai6Or9ehiC7K+Cxds1eVjP23+ZRsIaDa4uO1izEKkG1/CDArYaYT5JyqERm8rg5VfKLxT/CvPex3Za/SvL086VI2WvBzRK+ZFqPHyeMrwMAXp9z/DrY4z6QrBt9IxjlFrOkUHdOOOuUvGAPJHylF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+obHWTQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E3AC4CEF5;
	Wed, 24 Sep 2025 00:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758672612;
	bh=/o0FGhrUAZ+oxYrfk+E3PYUzIRtYM7ymasxWSjBlMUg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m+obHWTQiUx2QDXeW8XujAyjG7lWyZNW28EbIZOJzYWJjkAIavpJJtVNUt31p4Zwg
	 kGI630PMqK5LOyEU0IPuJHYSxW1eyr+gd9QOp47T97b95CFnpVhgARj5bl/s9Z9jkR
	 RwxPkVVxD28gAfY8xOmY2mLWKV3ynR02aDyiG7fv3F2PvWPWLMSjCdW4EWY3XzQ3Hg
	 4RWU0XuOhcBkusYuKaA2RjndowWGaFHlc+KUn9XkHtWHBFvtH6qR8QuQxCiBx8zqIG
	 NOkSYKYzUWqS06HOU0ksc5hyU4jBfNMIAnmEb5/c4cko0xNYEACBznBXxwta/07jPk
	 zwYNUN/fGoZYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DBA39D0C20;
	Wed, 24 Sep 2025 00:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] net: phy: stop exporting phy_driver_register
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175867260900.1969801.17701597899099018236.git-patchwork-notify@kernel.org>
Date: Wed, 24 Sep 2025 00:10:09 +0000
References: <b86c2ecc-41f6-4f7f-85db-b7fa684d1fb7@gmail.com>
In-Reply-To: <b86c2ecc-41f6-4f7f-85db-b7fa684d1fb7@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: andrew@lunn.ch, andrew+netdev@lunn.ch, linux@armlinux.org.uk,
 edumazet@google.com, pabeni@redhat.com, kuba@kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 20 Sep 2025 23:31:23 +0200 you wrote:
> Once the last user of a clock in dp83640 has been removed, the clock should
> be removed. So far orphaned clocks are cleaned up in dp83640_free_clocks()
> only. Add the logic to remove orphaned clocks in dp83640_remove().
> This allows to simplify the code, and use standard macro
> module_phy_driver(). dp83640 was the last external user of
> phy_driver_register(), so we can stop exporting this function afterwards.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: phy: dp83640: improve phydev and driver removal handling
    https://git.kernel.org/netdev/net-next/c/42e2a9e11a1d
  - [net-next,2/2] net: phy: stop exporting phy_driver_register
    https://git.kernel.org/netdev/net-next/c/092263a03105

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



