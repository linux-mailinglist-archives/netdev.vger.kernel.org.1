Return-Path: <netdev+bounces-127611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6B8975DD2
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 02:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55FC31F2323E
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 00:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464E8632;
	Thu, 12 Sep 2024 00:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/GsMvBy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC20370;
	Thu, 12 Sep 2024 00:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726099830; cv=none; b=i6BfP5Sze0LCf7Gkc5BTdwJ8dCz7FjcqB8LYFpnVW3NjDIEe6KcUZA7OCVsxDMbF4ImN/ySS7W8Ngs5H0/OF9bCgg2A8OUv9daXUOUXbsfBSl3p/3BcdIJQmYxhTS4ciURYNS/3mQKoRhiAwwAST4v74Xb1MSAjfjLMTaP9Qym0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726099830; c=relaxed/simple;
	bh=rP3n2Z81E+GHipTuYvkjjLRamE9/nTaunYCwiTU76f0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XzK4THBseaYvKhRDWiUV6rxdrR5FwS+DfugpX3c0/sbIUY7ffUqKJJk3+xPT5GRFafrFI6PH+0niN7tjzFMQnTNNUoh1SJnojQXL/TB/xhHMSzAkCEi/XL2N7Eq+BeEVzrEn5qqSyrwUkPyigEaQsMUlVaNeaxpWe7N77Dm3cII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/GsMvBy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97B72C4CEC0;
	Thu, 12 Sep 2024 00:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726099829;
	bh=rP3n2Z81E+GHipTuYvkjjLRamE9/nTaunYCwiTU76f0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=V/GsMvByWGG4B+ji1lFQJN9ynd7iDwan9/0j0AOo4MbLSQsOVKfi2UCQIkejPmfkw
	 QU+sPm/JRrWJ+65kt3gCw9Zu0obegkbEzwt1yBJfiHUoGnbn/FApi3A1iqXkPRM/TF
	 mJXXcZ5N0h3dQuWoft5AA8WNgjeOONtGnRQY4ZdRUq+VVMxppb9e9O6FlmLnd06if6
	 HRSV5r+F8cXvVccZkdsLQ4NgfEE7r74M0sbnXZgDQ+g3fT7LtOPUeTdve9rI/zS34r
	 9BtdZz76H9o7g94hOyDP6idB5PLfqN237RQSZeMsdlVaE9cfRfMpS7jXjDrpHS9VQN
	 JI4nt8cnMrcjQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB3093806656;
	Thu, 12 Sep 2024 00:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ethtool: phy: Check the req_info.pdn field for
 GET commands
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172609983077.1114191.12993526225003591845.git-patchwork-notify@kernel.org>
Date: Thu, 12 Sep 2024 00:10:30 +0000
References: <20240910174636.857352-1-maxime.chevallier@bootlin.com>
In-Reply-To: <20240910174636.857352-1-maxime.chevallier@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, andrew@lunn.ch, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, linux@armlinux.org.uk,
 linux-arm-kernel@lists.infradead.org, christophe.leroy@csgroup.eu,
 herve.codina@bootlin.com, f.fainelli@gmail.com, hkallweit1@gmail.com,
 vladimir.oltean@nxp.com, kory.maincent@bootlin.com,
 jesse.brandeburg@intel.com, kabel@kernel.org, piergiorgio.beruto@gmail.com,
 o.rempel@pengutronix.de, nicveronese@gmail.com, horms@kernel.org,
 mwojtas@chromium.org, nathan@kernel.org, atenart@kernel.org,
 mkl@pengutronix.de, dan.carpenter@linaro.org, romain.gantois@bootlin.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Sep 2024 19:46:35 +0200 you wrote:
> When processing the netlink GET requests to get PHY info, the req_info.pdn
> pointer is NULL when no PHY matches the requested parameters, such as when
> the phy_index is invalid, or there's simply no PHY attached to the
> interface.
> 
> Therefore, check the req_info.pdn pointer for NULL instead of
> dereferencing it.
> 
> [...]

Here is the summary with links:
  - [net-next] net: ethtool: phy: Check the req_info.pdn field for GET commands
    https://git.kernel.org/netdev/net-next/c/fce1e9f86af1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



