Return-Path: <netdev+bounces-190282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8894AB5FF3
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 01:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BB9A4A5592
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 23:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25F820C461;
	Tue, 13 May 2025 23:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwW/bSKv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5691F1534
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 23:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747179593; cv=none; b=IT2lgSm/ANl2sSApt0h3ohcUDCYDmZrbXOuL1KJDN4J//oFLZA4nJcEnIkRjE006XaeVc15c5W7zcTkJ3SKV3LBXmvk9vzjKEJs5HrbRgqK8q7v4jpxAewQwFXtBZOs87+UuRiXmQ1Oq6c6pnDK2vXSCKHtsL74ViIRJfOde5VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747179593; c=relaxed/simple;
	bh=mmDau0aiXPAAGx27F7aCoKCtjy9KtFwDCOjNynOybBo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YuKlyqDHO0jB+xEW1SfsMbRBC3ok5X4AncrhhhzHdvgLjPCuci0gqC8cILIm3umFwYcBI3lY3w+uB0/oHQq19CIo67DA0UNOr67Ymujlso6b9SLG56Pxf9Mt3OiWM/1MV8Q/iiHxCUH1NppK03mMmr9rpl1CyZ/3J+R48aFCt4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qwW/bSKv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E9E3C4CEE4;
	Tue, 13 May 2025 23:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747179592;
	bh=mmDau0aiXPAAGx27F7aCoKCtjy9KtFwDCOjNynOybBo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qwW/bSKvGhRy+etoz+tKn5wSL+Yx7YmSQCt7JqbuzqmXHGXjYs4L/8lRvevgx0ZdU
	 540/LPo+PBpXx7wPDTMDRaSX0C8HnQ0f/jtPpocpHDmIKeF16WgTnPtBC+DOwbESgf
	 PzDW9w+vo7aoBemshoyYBBlWt4Xw843OSG7s5RkFFunPeIaTLgIJy1+LnopGjSREol
	 e0wm//HT1fjmKpYrfvfvI/ReMXeZLFVbDRRjkz4ynajsbxcjA0wsD5jN/jO/70L4I9
	 rpBWGvVeL263sUoikCBZEK3DNWj0kPGadUtXrC465WfPACTCzUjrKwVfXOS8xoNh/a
	 hY4Zdtfnj+RKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE0D380DBE8;
	Tue, 13 May 2025 23:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: mlxsw: convert to ndo_hwtstamp_get() and
 ndo_hwtstamp_set()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174717962975.1824320.13748474037361626469.git-patchwork-notify@kernel.org>
Date: Tue, 13 May 2025 23:40:29 +0000
References: <20250512154411.848614-1-vladimir.oltean@nxp.com>
In-Reply-To: <20250512154411.848614-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, idosch@nvidia.com, petrm@nvidia.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 vadim.fedorenko@linux.dev, richardcochran@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 12 May 2025 18:44:11 +0300 you wrote:
> New timestamping API was introduced in commit 66f7223039c0 ("net: add
> NDOs for configuring hardware timestamping") from kernel v6.6. It is
> time to convert the mlxsw driver to the new API, so that the
> ndo_eth_ioctl() path can be removed completely.
> 
> The UAPI is still ioctl-only, but it's best to remove the "ioctl"
> mentions from the driver in case a netlink variant appears.
> 
> [...]

Here is the summary with links:
  - [net-next] net: mlxsw: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
    https://git.kernel.org/netdev/net-next/c/ae605349e1fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



