Return-Path: <netdev+bounces-41630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A437CB7CD
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 03:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB41B1C209A9
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 01:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B622C15CC;
	Tue, 17 Oct 2023 01:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CVTyKhN4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985CE17CB
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 01:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16EABC433C9;
	Tue, 17 Oct 2023 01:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697505024;
	bh=DdeqRcKlBQ/+BhS/2gKujHNhtsc3mNA2gqQ3eKEHjBE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CVTyKhN45x6gD+6WyeV5uv5oF+/XraBRSJJrhbIGjskEoYDcsM+Xsm3/mxcWJRa4P
	 GFk3NY/+oD+A0pw8xT8jZsLq7h5rJTXi2yxikRx43O/6ahqDomEAM+hqT4RJK3LL2x
	 DR2emnqBG9v1fbIvYDNbnPenV/s71+M0alosLi17Sjf6W6B4MgM+9Ql4rbWLyWIUhs
	 J00bmsO2jVrAVM3XHP4Md67qf9nZRqSeGxHDeAPbiWDZCCGMk4FqJYLHcDAn1hMacV
	 dIzSYqx9meIeGEJPwFvnYxMqK0nkKpo40nZPh6xZbdtx7DRLhsow6AMhJUyRZ4uazY
	 eUz9XoZJasLog==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EC16EC4316B;
	Tue, 17 Oct 2023 01:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bluetooth 2023-10-13
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169750502395.8129.10858482508717627477.git-patchwork-notify@kernel.org>
Date: Tue, 17 Oct 2023 01:10:23 +0000
References: <20231014031336.1664558-1-luiz.dentz@gmail.com>
In-Reply-To: <20231014031336.1664558-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 13 Oct 2023 20:13:36 -0700 you wrote:
> The following changes since commit a950a5921db450c74212327f69950ff03419483a:
> 
>   net/smc: Fix pos miscalculation in statistics (2023-10-11 10:36:35 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2023-10-13
> 
> [...]

Here is the summary with links:
  - pull-request: bluetooth 2023-10-13
    https://git.kernel.org/netdev/net/c/2b10740ce74a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



