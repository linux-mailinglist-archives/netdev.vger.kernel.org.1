Return-Path: <netdev+bounces-134723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BC199AED1
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 00:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 393CC1C21A5B
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 22:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF5D1E5727;
	Fri, 11 Oct 2024 22:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTZhZTfr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8ADE1E503C;
	Fri, 11 Oct 2024 22:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728687036; cv=none; b=cRTrBVyQBPSBUxKAvPsvFP1ZvHYB4QVY6YZQ7xb69b/4Ct84Taapiy9xUYAieDJ8ImMt7abO2JSmYC8xm2o6KycjyQ0jWov8tHiG8HJSP6p2EsKLtXlJcXhyhZz0BrKEDCdn77kCpQsVpm/2giKT3sbxP95nkuoMttpfJYF79hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728687036; c=relaxed/simple;
	bh=H0F+QW0xOpOX+mJYSXhseES7lYCnz1ssykPobdYDPGM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dp+7Rua8MEpFXXzqZeOKvUtS6UjbLT14LkFqlrWbMCYFDl8RIr24k7wjCE85eoiUd6z2k6HCxqEqQ90YjHaSTyPZgxtVfI5WYeRHBYhp7jF2HeWN+0j7q/XQyB04X78n6Xr55qxzklh6Fu3XbnZIJqkDWC69BkTCmifcH9EltRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTZhZTfr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E30EC4CECC;
	Fri, 11 Oct 2024 22:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728687035;
	bh=H0F+QW0xOpOX+mJYSXhseES7lYCnz1ssykPobdYDPGM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gTZhZTfrguVLa82ZycbHjCy61Iqa4o8cidu3zCoRGfEdWlbNIHIzvqasNFpwOj8Qp
	 vGNw+dn827zK/SExQ3d5bKn7jUiBuXXGwrcjjKpUA5Pg+tS2VSXhL5EvOVU0VBnfcO
	 vPXTc63KuQGuruyLjgaLXIoMw/YFA3jacUUPg2K7yDWhec1GbYIrpB4gC1B6wGjC4O
	 g4wBw28k+G2jqHIu8eS41TOi49NDT1vSRHqmeGl9yM8SKvsJE2d8ps5ja15H7TXfpz
	 aEIF4w7A9yiAwLO56Ht+4UIc5ZYUPjVfBW4V7q/0wjsXT/bF4QwNd/oHQx1SZdRAwb
	 Vh6FN8GoQZ21w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CAE38363CB;
	Fri, 11 Oct 2024 22:50:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2 net-next 0/3] netdevsim: better ipsec output format
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172868703973.3018281.2970275743967117794.git-patchwork-notify@kernel.org>
Date: Fri, 11 Oct 2024 22:50:39 +0000
References: <20241010040027.21440-1-liuhangbin@gmail.com>
In-Reply-To: <20241010040027.21440-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, shannon.nelson@amd.com,
 jiri@resnulli.us, stfomichev@gmail.com, horms@kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 10 Oct 2024 04:00:24 +0000 you wrote:
> The first 2 patches improve the netdevsim ipsec debug output with better
> format. The 3rd patch update the selftests.
> 
> v2: update rtnetlink selftest with new output format (Stanislav Fomichev, Jakub Kicinski)
> 
> Hangbin Liu (3):
>   netdevsim: print human readable IP address
>   netdevsim: copy addresses for both in and out paths
>   selftests: rtnetlink: update netdevsim ipsec output format
> 
> [...]

Here is the summary with links:
  - [PATCHv2,net-next,1/3] netdevsim: print human readable IP address
    https://git.kernel.org/netdev/net-next/c/c71bc6da6198
  - [PATCHv2,net-next,2/3] netdevsim: copy addresses for both in and out paths
    https://git.kernel.org/netdev/net-next/c/2cf567f421db
  - [PATCHv2,net-next,3/3] selftests: rtnetlink: update netdevsim ipsec output format
    https://git.kernel.org/netdev/net-next/c/3ec920bb978c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



