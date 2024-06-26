Return-Path: <netdev+bounces-106711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89471917557
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 02:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC91A1C2171F
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 00:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780D54C6F;
	Wed, 26 Jun 2024 00:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOs+gR3F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C6E15B7;
	Wed, 26 Jun 2024 00:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719363031; cv=none; b=Pn6csD7mZbVfjRGOYRk3VRa2Td9+k2q3LRo5VQFN2Q9FY69qiqLixZdw66E80VswlUQ0LYWgqIcxtgo+f8S1Gy0omkpm2+W8hTrruZFoD2H4roBwnWUAtC3E+N+ehe+fXZN7HJld1godKupxLMFU2H5lNWCzpsBioFr6TKdFkqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719363031; c=relaxed/simple;
	bh=NMqBdW6cHN2yp/PLmHLJNE+UdpAsHxZYtmRCzGlkuLw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DcyuFW8LU4sNFK5wszssQ/WMzI7GJcKH7JzwYWxLJ40kHOmnA6BGSkePXlJAzJuzlYauuzjvuySsQ2MCYpuJ0iKfxgcThFYJ/tzjWdiF6MhlqoVnbLvG/no3b4GhL/nimJOpaZExqdaL+vabRYu8Z/AARf1Hdj3Kg8S9yCbZCA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOs+gR3F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6FFDC32786;
	Wed, 26 Jun 2024 00:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719363030;
	bh=NMqBdW6cHN2yp/PLmHLJNE+UdpAsHxZYtmRCzGlkuLw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YOs+gR3FU/mMhtz6RVBgnLzHyIi7OG43lvEh4tOW122AiyCt7bY/0oxLTPDqHtpbj
	 QKum6hG8GFs4VnHPPG5x5EIAVdvWlVHOSsz9Wa1bGV40lSGecjoGxET3dy6JNiTpkg
	 3MBeMa1YHxIASwfdvrIu+VhvfaSrAWgY+/l+tOgOtusTmjObP84Ii32I/ML9PMnd0g
	 CcIRTRss5dhjVKh2Vokuv4r0HSYJQPxVAkWw5JJJUxQsiJ56hPjX6PGEIxur3CkKwc
	 qDsX16kHDh1Ip4KuHoTYVDefR78U0zNY4eBL6yJBRXi9R83lv3qCp2sMtTerAQrIUL
	 ALTzTwPgdc/9w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8FAF9DE8DF3;
	Wed, 26 Jun 2024 00:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v15 0/5] ethtool: provide the dim profile fine-tuning
 channel
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171936303058.27591.15292953150310890485.git-patchwork-notify@kernel.org>
Date: Wed, 26 Jun 2024 00:50:30 +0000
References: <20240621101353.107425-1-hengqi@linux.alibaba.com>
In-Reply-To: <20240621101353.107425-1-hengqi@linux.alibaba.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, kuba@kernel.org,
 davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 jasowang@redhat.com, mst@redhat.com, bcreeley@amd.com, rkannoth@marvell.com,
 aleksander.lobakin@intel.com, xuanzhuo@linux.alibaba.com, talgi@nvidia.com,
 corbet@lwn.net, linux-doc@vger.kernel.org, maxime.chevallier@bootlin.com,
 jiri@resnulli.us, paul.greenwalt@intel.com, ahmed.zaki@intel.com,
 vladimir.oltean@nxp.com, kory.maincent@bootlin.com, andrew@lunn.ch,
 justinstitt@google.com, donald.hunter@gmail.com, eperezma@redhat.com,
 akpm@linux-foundation.org, dtatulea@nvidia.com, rrameshbabu@nvidia.com,
 hkallweit1@gmail.com, przemyslaw.kitszel@intel.com, paweldembicki@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 21 Jun 2024 18:13:48 +0800 you wrote:
> The NetDIM library provides excellent acceleration for many modern
> network cards. However, the default profiles of DIM limits its maximum
> capabilities for different NICs, so providing a way which the NIC can
> be custom configured is necessary.
> 
> Currently, the way is based on the commonly used "ethtool -C".
> 
> [...]

Here is the summary with links:
  - [net-next,v15,1/5] linux/dim: move useful macros to .h file
    https://git.kernel.org/netdev/net-next/c/0e942053e4dc
  - [net-next,v15,2/5] dim: make DIMLIB dependent on NET
    https://git.kernel.org/netdev/net-next/c/b65e697a7c9e
  - [net-next,v15,3/5] ethtool: provide customized dim profile management
    https://git.kernel.org/netdev/net-next/c/f750dfe825b9
  - [net-next,v15,4/5] dim: add new interfaces for initialization and getting results
    https://git.kernel.org/netdev/net-next/c/13ba28c5cd04
  - [net-next,v15,5/5] virtio-net: support dim profile fine-tuning
    https://git.kernel.org/netdev/net-next/c/dcb67f6a9ead

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



