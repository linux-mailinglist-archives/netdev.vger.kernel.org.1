Return-Path: <netdev+bounces-132156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C17699097F
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 18:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A13B8B213BA
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 16:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340771CACC4;
	Fri,  4 Oct 2024 16:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t/AfnJ2t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA9B1E3798;
	Fri,  4 Oct 2024 16:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728060033; cv=none; b=qu6OXAo84A7Pf34i1VaHBH+9M0ONxyDhvGHLuTKxbFI+/9uaM/tmWT03l4twzfJZv0WcIckEoTNoIdQJLVyjZdvmh98Ah0mT4O/O8/sxWnPUrmoUzXeFMEICeAuPqrZYx/+NXdfX2cP/9RUJKKSEjed8wWaLXigyt8NO4/4ycB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728060033; c=relaxed/simple;
	bh=89c8uJ7qobwnqhIgahiWtibBBubafSb7CFkoalE6ni0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fkt/yjQHRJY3tyFQk4dbsW+TZpaKJxlgClnRWPkTPsH/ene4tQC6PzDg23hwvvpldwtC+KkslzkWuFx+G8w7e8oedA4zXjjjQQf09aGfD0suVOJGozBQa04jPy01J76bakrpU7C7rkdMCn4y9T2KclZOAra1j46PhNwBsk57Nno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t/AfnJ2t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82FC8C4CED3;
	Fri,  4 Oct 2024 16:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728060032;
	bh=89c8uJ7qobwnqhIgahiWtibBBubafSb7CFkoalE6ni0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t/AfnJ2t+cK/GxTDBuNwCwMG4OKZuMPyvnj/l+28T4FpvJwRUnI9VO9mt7By24Auu
	 pqQ/f7y1OaAbGuFw6+l47Mh+qQ5LsrLV8s7rRulkhwZBF4r6OMAzDPrDJGpGp8Pom+
	 eLXtlWsH0/DQxfm+WSpXdqgAbA2UCPi6MOiu4rFxd3dqb6b4xc6oIcpjEOHmeEhBpX
	 dmCetSIj5nn+/SYbqCyuyAvG6jci9wtXtVTuZZDOEYdB0HXuYXbRa9ZDHm5Lmp01Wn
	 r5iubS/x8CdxvannDKURLydegp32wTXgLzADxP6x8FisLpnmJ5M9EU3KsRogCcL05s
	 wo5ejLnbbj5rg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 38FF839F76FF;
	Fri,  4 Oct 2024 16:40:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] net: switch to scoped
 device_for_each_child_node()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172806003601.2655854.2615122625428001113.git-patchwork-notify@kernel.org>
Date: Fri, 04 Oct 2024 16:40:36 +0000
References: <20240930-net-device_for_each_child_node_scoped-v2-0-35f09333c1d7@gmail.com>
In-Reply-To: <20240930-net-device_for_each_child_node_scoped-v2-0-35f09333c1d7@gmail.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 yisen.zhuang@huawei.com, salil.mehta@huawei.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 30 Sep 2024 22:38:24 +0200 you wrote:
> This series switches from the device_for_each_child_node() macro to its
> scoped variant. This makes the code more robust if new early exits are
> added to the loops, because there is no need for explicit calls to
> fwnode_handle_put(), which also simplifies existing code.
> 
> The non-scoped macros to walk over nodes turn error-prone as soon as
> the loop contains early exits (break, goto, return), and patches to
> fix them show up regularly, sometimes due to new error paths in an
> existing loop [1].
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net: mdio: thunder: switch to scoped device_for_each_child_node()
    https://git.kernel.org/netdev/net-next/c/1d39d02a1535
  - [net-next,v2,2/2] net: hns: hisilicon: hns_dsaf_mac: switch to scoped device_for_each_child_node()
    https://git.kernel.org/netdev/net-next/c/e97dccd3e976

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



