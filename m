Return-Path: <netdev+bounces-213545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1A6B258DE
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 03:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EE0F1C215BA
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 01:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9E22FF675;
	Thu, 14 Aug 2025 01:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2hTQR0q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267EB163
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 01:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755134396; cv=none; b=uhulcXHuTSnDiiu6yjAXE+JnA0rfHygEZr+QOcT94m0iKSuqrJZyvH9q6SpF+s98iXf3FLS80+BJ8+VllMcKXnj9fnj+Ibu8wvEu+vPl/Mpl02fPuxI7r9I5Bgx2jwGB26Af0owmGodczO8n58Pt9SoieMCxtoNOFbZGesBCfkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755134396; c=relaxed/simple;
	bh=IPjgJXPZUocd7kKC6gACyi6ufz2IiSlMqnSxrws0KnI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Zjc9luS1LmxBQzVVn/bqPdEOnCqIhK6/coZoCuCJ62RtEfDO2ea7/SLecQhI/c18o71P7ENk+dcMRq7RXNzlQRk8jTAe+jpS6FGs3chjIbYVBf3PXKw61k9uLsl6/htPRChXh0EmJulDZZ41MF3cgkeT1m76V/pPB2l6BZw7zGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D2hTQR0q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7199AC4CEEB;
	Thu, 14 Aug 2025 01:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755134395;
	bh=IPjgJXPZUocd7kKC6gACyi6ufz2IiSlMqnSxrws0KnI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=D2hTQR0qoQ3jV9N7HXeF8o45E9LWYkZUjYcs1B/o15Kkpq13SO5D54QmMidLB8faY
	 /C1tK+HejUSoByWrTkgQqeFzHHmv8cTHYJRwPGsZnYGo7LNr/28yeyjgJNgLUdtul6
	 xPFLZ5AzGforgzElapriiqqAfXqByilwEYvAmhHeUvHSsx8WamsvpxF43Xg9mP6nI1
	 2K5LHp2wY4pFXohp452e4RNjVCMQ8ZeRIjEYmY5flWl8si0lWJRk+GBgj/pv23Elia
	 VLu1S+EHpvexS9VX53EO88/aFHQWZlrnSlI8uS0BuQso8dwzF+H5asCJJH170hX/07
	 NMlA5vALlzVsg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D1839D0C37;
	Thu, 14 Aug 2025 01:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/2][pull request] ixgbe: bypass devlink
 phys_port_name
 generation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175513440700.3844441.9959509099775027154.git-patchwork-notify@kernel.org>
Date: Thu, 14 Aug 2025 01:20:07 +0000
References: <20250812205226.1984369-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20250812205226.1984369-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 jedrzej.jagielski@intel.com, przemyslaw.kitszel@intel.com,
 jacob.e.keller@intel.com, jiri@resnulli.us, horms@kernel.org,
 David.Kaplan@amd.com, dhowells@redhat.com

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Tue, 12 Aug 2025 13:52:22 -0700 you wrote:
> Jedrzej adds option to skip phys_port_name generation and opts
> ixgbe into it as some configurations rely on pre-devlink naming
> which could end up broken as a result.
> ---
> v3:
> - return -EOPNOTSUPP when flag set
> - wrap comment to 80 chars
> 
> [...]

Here is the summary with links:
  - [net,v3,1/2] devlink: let driver opt out of automatic phys_port_name generation
    https://git.kernel.org/netdev/net/c/c5ec7f49b480
  - [net,v3,2/2] ixgbe: prevent from unwanted interface name changes
    https://git.kernel.org/netdev/net/c/e67a0bc3ed4f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



