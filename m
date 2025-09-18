Return-Path: <netdev+bounces-224646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4797DB874F5
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 01:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A5611C83BDA
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 23:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E079316193;
	Thu, 18 Sep 2025 23:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kuehvDFc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565673148A4;
	Thu, 18 Sep 2025 23:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758236416; cv=none; b=ZTOomzd6lCbJzN4n9PwuWOjqn7lKp5unvya+egonneEMoQMomUaEbgP8yq0rQFjTGfu3BW9S8jnMBV3TiB8cwn505QKC7ihIpJdvLcdHmlS2SIXGkQ2bwAnSUhbvqejHGGjDJp9NWLyyajpmtlEnBJDXI4MSicBg7IdFP6bzoxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758236416; c=relaxed/simple;
	bh=R+DUhF/KaJOi/fs49UwyB0eqg6I3dUVnwx7V84tfvdc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DL2FNg2ju1p9wDx9k6tApMll0ZjkwUNeYZQkCybehmkvu3QBvnVFW/EjYYxktwVJVPjer991S1+YsKU8pp0b7gOXvzBjlWu11RT5smE1wngv3ho+E9Mjl+ITQOkS4aTcC3dASlEniVmOMZEa4q7XtvGPS2C5pnnY54mEJCqFTmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kuehvDFc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AFA0C4CEF7;
	Thu, 18 Sep 2025 23:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758236414;
	bh=R+DUhF/KaJOi/fs49UwyB0eqg6I3dUVnwx7V84tfvdc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kuehvDFcko+Ca+LH7Hvdl2P8TCwTUJICvJmn2ThVDEpYmxWybc4oR+yC1skDuUIqb
	 19P37a9ynwAPODNCLn/X50xj8pbA6SYz/jPalpr1i/qFyNM0qLmSVcFxioHJdIlLH0
	 nNcUz52kHFMnEVtchBc+iA9tZRSX+tpp+YR6WIzCPH3vMT3padPeyEHmHnKa0KQvuV
	 y9KDGOSd3rYEZTrqPB0/KFfhOxVN1GRBSXUasPuXecg+axU7KFRbcEeIq4uruZD3mV
	 GhgF0qvlrUlUtbWY+3LmHLJ4oSKjmZkPHY23+jFYQsDMhPOjiiCnQl+cqikQ+FxQQv
	 uGfwzwzAIgg0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C9939D0C20;
	Thu, 18 Sep 2025 23:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: sparx5/lan969x: Add support for ethtool
 pause parameters
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175823641399.2980045.14115345753886201972.git-patchwork-notify@kernel.org>
Date: Thu, 18 Sep 2025 23:00:13 +0000
References: <20250917-802-3x-pause-v1-1-3d1565a68a96@microchip.com>
In-Reply-To: <20250917-802-3x-pause-v1-1-3d1565a68a96@microchip.com>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, Steen.Hegelund@microchip.com,
 UNGLinuxDriver@microchip.com, linux@armlinux.org.uk,
 jacob.e.keller@intel.com, robert.marko@sartura.hr, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 17 Sep 2025 13:49:43 +0200 you wrote:
> Implement get_pauseparam() and set_pauseparam() ethtool operations for
> Sparx5 ports.  This allows users to query and configure IEEE 802.3x
> pause frame settings via:
> 
> ethtool -a ethX
> ethtool -A ethX rx on|off tx on|off autoneg on|off
> 
> [...]

Here is the summary with links:
  - [net-next] net: sparx5/lan969x: Add support for ethtool pause parameters
    https://git.kernel.org/netdev/net-next/c/315f423be0d1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



