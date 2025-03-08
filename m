Return-Path: <netdev+bounces-173149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44507A57821
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 04:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62EC63B691B
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 03:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB851A9B29;
	Sat,  8 Mar 2025 03:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="siFu7aDe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E341A0730
	for <netdev@vger.kernel.org>; Sat,  8 Mar 2025 03:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741405816; cv=none; b=ovPn/lsvCL33s5bP+C+nNsvcizr+8pnvvnRXTqpULONeZsvi5GSVc5JxzYI8EssQCvrEVC0D999WUPguY2GA7TFAoCKm7l+f55wpj8ePc3ns/o0uJIMTyRJ11d8ly/cqkV2HA7fD9rHkTCQrjbp+uldp6nw+yF/iCqPpmNQhbgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741405816; c=relaxed/simple;
	bh=pMXitB6C8zu4JDlMBmWSC66hQlNDDV+uyBPKaklR9YA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pL8FxDu0fBm2FQe6ef5EoSePT3YQ5JEO9J8mktI6j3DgkMcIdshEILmyWNEqJbpfaaMsJbkthc6i8d91gfhQR7fyHny/FVUda4MlrVG24xv62ZbxBN5oy8msLpR5kZwyQKDcSuP1SHg20UACTQ2K05if3kfV5x7e2f/yYSgXhv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=siFu7aDe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26140C4CEE0;
	Sat,  8 Mar 2025 03:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741405816;
	bh=pMXitB6C8zu4JDlMBmWSC66hQlNDDV+uyBPKaklR9YA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=siFu7aDebKPF7Ua9okJ/tS3MjvAXcPqW9qM3DNCbKiOCHWKapagnXbRJK1VZEIVmn
	 UrXL1mTnpzealMljtkhYUIFt4TsySheaxrAThWXshudS8QnDm+06V59g8aO3McPF8O
	 T3fgOWnT6bxidlHb8P+Sn50RvMBj8f7vXsLjmOa5WNVDYuJd2jllGSvJxfFexQWSOu
	 ojnKUdSmDoh6BsxdZlpI76X6KyrhgLiqFLbwLY+o5/iho/NKwBaQih27knxWeH7L57
	 vfgzAdJmHB8nSmwyItF33MRtONunstcC0kaF6xAA0WXxboofn++KtIDzz4ZLaUYDLK
	 uhr7PpC0csEnA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD42380CFFB;
	Sat,  8 Mar 2025 03:50:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] eth: fbnic: support ring size configuration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174140584948.2568613.17380577702216675898.git-patchwork-notify@kernel.org>
Date: Sat, 08 Mar 2025 03:50:49 +0000
References: <20250306145150.1757263-1-kuba@kernel.org>
In-Reply-To: <20250306145150.1757263-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 alexanderduyck@fb.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  6 Mar 2025 06:51:47 -0800 you wrote:
> Support ethtool -g / -G and a couple other small tweaks.
> 
> Jakub Kicinski (3):
>   eth: fbnic: link NAPIs to page pools
>   eth: fbnic: fix typo in compile assert
>   eth: fbnic: support ring size configuration
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] eth: fbnic: link NAPIs to page pools
    https://git.kernel.org/netdev/net-next/c/c1aacad30614
  - [net-next,2/3] eth: fbnic: fix typo in compile assert
    https://git.kernel.org/netdev/net-next/c/bfb522f347df
  - [net-next,3/3] eth: fbnic: support ring size configuration
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



