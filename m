Return-Path: <netdev+bounces-159861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D57BA17366
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 21:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5790F3A8468
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 20:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06471F03CE;
	Mon, 20 Jan 2025 20:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+W/1Mz0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCE91F03CA
	for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 20:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737403209; cv=none; b=PnRzQeCShPXV/bMdM+8oIqM9U/AebMBPxKlTQCbalQ/s/6Ayxv+YSR44gkLf7DhWrYpKdzId+7k8Qda/6jl8ntqg5bMa4khKFlxjfMGSR7cuRwgDcmhPElCJHulSbnJV9rD1S4a1S5t4tWbS+zj+nLCUVervKbBs5UZ7jMFFIDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737403209; c=relaxed/simple;
	bh=m00OyKxnVusV6K/OVOqfrSXRib5yGNZwm4/DBZY4COw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=E/A9Lf4WpsAC4bhyIkdH94KE3a6FudFKFakKy09YgvpJeo7SsVqSK30/m3ISCz8qJsKqAAioGkTNm6Vh/r1AI+q+PM/khPeOKROYw/qknGMVDqPwuF77dfahSoo7T+ORG/CXotqVopQf5RBsYt2u0A1LvFHJ27apvxesR5P4l+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+W/1Mz0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40348C4CEDD;
	Mon, 20 Jan 2025 20:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737403209;
	bh=m00OyKxnVusV6K/OVOqfrSXRib5yGNZwm4/DBZY4COw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=R+W/1Mz0IKCFBEzp2NkJZSmMLnggbdPagn7oC8Frtt7vTk5pjy6Ejyu7ysua2fBOH
	 fLEF+aXNFCC4SQMdBKC1gZYQVXuFbFgUUZhPuQ+pBkjFG0s0L6tsSU1WodftpFs6YW
	 YxanblCQekZih6GFbxcM2pmNV8SQslKsh81UxZZudAq8IAz4ep9bEtPiRuEdmi7gjg
	 WBtCJ2rk8cBtV3u3H4HS8ypwmWMksXS7inTeg9XwpFtIb8WyA3wsNQJgDietvTf9q5
	 cpF7JiJ/mBaabmup1SOh63r5Q7EzYTVINdkN3jasuwA6vL+kps9Z1lYmbIpgBGrHAe
	 k9abMG+bi6ViQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B4F380AA62;
	Mon, 20 Jan 2025 20:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/7] net: ethtool: fixes for HDS threshold
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173740323326.3636069.11654423441909066483.git-patchwork-notify@kernel.org>
Date: Mon, 20 Jan 2025 20:00:33 +0000
References: <20250119020518.1962249-1-kuba@kernel.org>
In-Reply-To: <20250119020518.1962249-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com, ap420073@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 18 Jan 2025 18:05:10 -0800 you wrote:
> Quick follow up on the HDS threshold work, since the merge window
> is upon us.
> 
> Fix the bnxt implementation to apply the settings right away,
> because we update the parameters _after_ configuring HW user
> needed to reconfig the device twice to get the settings to stick.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/7] net: move HDS config from ethtool state
    (no matching commit)
  - [net-next,v2,2/7] net: ethtool: store netdev in a temp variable in ethnl_default_set_doit()
    https://git.kernel.org/netdev/net-next/c/743dea746ed6
  - [net-next,v2,3/7] net: provide pending ring configuration in net_device
    https://git.kernel.org/netdev/net-next/c/32ad1f7a050d
  - [net-next,v2,4/7] eth: bnxt: apply hds_thrs settings correctly
    https://git.kernel.org/netdev/net-next/c/e58263e91117
  - [net-next,v2,5/7] net: ethtool: populate the default HDS params in the core
    https://git.kernel.org/netdev/net-next/c/928459bbda19
  - [net-next,v2,6/7] eth: bnxt: allocate enough buffer space to meet HDS threshold
    https://git.kernel.org/netdev/net-next/c/bee018052d1b
  - [net-next,v2,7/7] eth: bnxt: update header sizing defaults
    https://git.kernel.org/netdev/net-next/c/99d028c63457

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



