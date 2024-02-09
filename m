Return-Path: <netdev+bounces-70670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 693E084FF25
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 22:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A0F51F23405
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 21:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9745121101;
	Fri,  9 Feb 2024 21:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GacwUwni"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7116F20DE3
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 21:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707515429; cv=none; b=b6fcqSkTIf/4MFgchBk1Uz7X/n13sKYuab8DJhGNDlgCquqV5osX/ANV6Fvx3YQV4g6xbt9T3NuXhh0k064JCcRbiuqWl8HjpnkBmYgvfx2YXWXlXGcPb6b4Qy882Be3Q7Jqk9ZhhuHwrtJKHexOgbdI6TLNassjmHYck8mEBe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707515429; c=relaxed/simple;
	bh=XZgvtwUHcrFB1uZMrTnYMzYUfhLV/D0qqhpBSVsti18=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u8oBRkBCPlN3XsuXY8HExUxjmVrjF4OoEVToUPQedck0HVBOImvzjxyxhcFFIrvtpTD8qh5rxp2gE9ELE4mowN6PKqUhC9if0pOP3paHYp7ML2LozlFoZslCXFCxswbN8Ar0QOOY96up7GneRX2G0o5Ehl0dAA6y1ictv/A9gnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GacwUwni; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D659AC43399;
	Fri,  9 Feb 2024 21:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707515428;
	bh=XZgvtwUHcrFB1uZMrTnYMzYUfhLV/D0qqhpBSVsti18=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GacwUwniP/V2e4HINgWrxExjkvq1U+PIa7WFeiYRUm8wPrL+N1TzT0ZnEqm8IG8fA
	 gTVbIu39AEYVJCV5wJ1qIUD6PW1gj5a4dZ1b/Upxwe+M1lro9US8PQCXooKEWsy3g1
	 WHBua3+J2xoPv9R8NsDO/4n4IOk3bYIpgifzHdI0/lpYUNuVYLr1OgMpd1NIt1zaXl
	 YlkFNcvy/r2kQw6tqlG/u6nJAzurlcETj6ye2JGaptWPdS5FW9R6NwhxGxxIwTlSYL
	 zaZAkix9bi72JDnvFVh8SX28fuOv+EGOws8ECOXvnyGc2wOjiHBAhacp6h11Hi4szb
	 99ZmXoxmDtdKA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B1AF3D8C9A0;
	Fri,  9 Feb 2024 21:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3][pull request] igc: ethtool: Flex filter cleanup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170751542872.4610.818900689161612395.git-patchwork-notify@kernel.org>
Date: Fri, 09 Feb 2024 21:50:28 +0000
References: <20240207191656.1250777-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240207191656.1250777-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, sasha.neftin@intel.com

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Wed,  7 Feb 2024 11:16:51 -0800 you wrote:
> Kurt Kanzenbach says:
> 
> This series contains some cosmetics for the flex filter code. The fixes have
> been merged separately via -net already.
> 
> The following are changes since commit ddb2d2a8e81474f61f2c6f0b9b3b4fb0d90677d0:
>   Merge branch 'net-eee-network-driver-cleanups'
> and are available in the git repository at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 1GbE
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] igc: Use reverse xmas tree
    https://git.kernel.org/netdev/net-next/c/50534a55774c
  - [net-next,2/3] igc: Use netdev printing functions for flex filters
    https://git.kernel.org/netdev/net-next/c/5edcf51d0b5e
  - [net-next,3/3] igc: Unify filtering rule fields
    https://git.kernel.org/netdev/net-next/c/b7471025942d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



