Return-Path: <netdev+bounces-202730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D58AEEC52
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 04:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99C3917AA81
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 02:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46584143736;
	Tue,  1 Jul 2025 02:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8U+Twv9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A57729D0D;
	Tue,  1 Jul 2025 02:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751335783; cv=none; b=tvHPbeaAldMXjkQQ1qKjvH6HQQI9LxgCAPFm4kFU8PzwoCLbaIA1rd9rH8156SxN1lqzs1SFxSPbCv4QiYpV6C8B1IOYC3YDYKj6oBVMkh6ZMGueo87qsCMHXrHYpieAhP0426+CiHcMgfb72nFcIIbsXooqZ+xZm5WG2m7gm5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751335783; c=relaxed/simple;
	bh=F0cJyiJJurwaMuhhkWv8vc9TiINslJ6mM2VIQoO7CgM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hs2lM27xhhR1aT6EoHTQnFh6YThiWHQGBjrqZZqohfkfHN/9UXj2hPT0QX4LG9lPT8sCzIAxqm+XLJdT7tG/v7vnXMDmH2Mu/n9xVRCsxgh+P3cSfICBk9uUZthNzWy6zvJI4SO4eTT41XmCkde8946RMJyYmtowJPn3atqIIqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p8U+Twv9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDF88C4CEE3;
	Tue,  1 Jul 2025 02:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751335782;
	bh=F0cJyiJJurwaMuhhkWv8vc9TiINslJ6mM2VIQoO7CgM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p8U+Twv9OEOj1Zh2tFkEJ3nl5f71iWlNBrIySmNZKt3gCWl6d6xwM5SVVi2RqqOvT
	 bTS28WHxvP+62RAEGsSbRJbYPftTzye9xPNhsFe3s/zNC+SVhmsm0V0L0KietPZ8E/
	 jqAP25bX6EyrdIg+z04n3M4ib8d8SsAIMfBVokSfV1i4nCjbpLNeDw2z/DUV3NHPYb
	 zPPg9eKWn0C21LMkaUhXfHoSBpqDSn3C1pCPYuFSwgO8HPELkNSF9Uk2I2yXs52cNj
	 KDJ2bFgNXCTBAv5zrXpn12cmQRG4290+BkuzZXmdAsVw1eBuFDNLl9bGLJcgQaXGSl
	 7+CxHmLUsXt7Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B3038111CE;
	Tue,  1 Jul 2025 02:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2025-06-27
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175133580801.3637861.8242121539111541957.git-patchwork-notify@kernel.org>
Date: Tue, 01 Jul 2025 02:10:08 +0000
References: <20250627181601.520435-1-luiz.dentz@gmail.com>
In-Reply-To: <20250627181601.520435-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 27 Jun 2025 14:16:01 -0400 you wrote:
> The following changes since commit e34a79b96ab9d49ed8b605fee11099cf3efbb428:
> 
>   Merge tag 'net-6.16-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-06-26 09:13:27 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-06-27
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2025-06-27
    https://git.kernel.org/netdev/net/c/72fb83735c71

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



