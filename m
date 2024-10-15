Return-Path: <netdev+bounces-135395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA18C99DB29
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 03:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DEC31F23EC6
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 01:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97D8158A1F;
	Tue, 15 Oct 2024 01:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ac91n/tQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A665A158866
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 01:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728954635; cv=none; b=rXLKHpLKB81///n5MJF3R7Oa6iPPFAEzXjDITpKxtO6HTM6+Nj+PWZzpmaMLzTjoW7Y7lmOxVvFOKGUu3RhuxGJ+oiyJy74RaG26bOvs6XXR/ApRozJlen8jsPAWpPwPOZal6kEue8fRGjwdbDfo8EqNwZqghn4iZ26CTl1Hf4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728954635; c=relaxed/simple;
	bh=PZDJrDIw2e8jTOfTHQZ5gmtYgRL3V9aibvLqQofhq5A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AKtVKW+V4b+ipvIW4PBP8hUMKMtx/IgwBpCzVt41cXvVvJ4S9Qsm0s7gSbF4tuaa/pShnSnL/Jij81HSfD/U2knp+KmIPtnJFiRfBKGZvvrF6ppHHk7B/xhDoHj+Nzd3SfxavOId+0vsCrsrCB7ve+34kRUz7INZhKPwyAYjQg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ac91n/tQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E969C4CED0;
	Tue, 15 Oct 2024 01:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728954634;
	bh=PZDJrDIw2e8jTOfTHQZ5gmtYgRL3V9aibvLqQofhq5A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ac91n/tQOZXgUIvnWOVJc9rtOxp347Ar4FDWAo2wjavJ8iSQB0nQnZ/UWeEAdVDIQ
	 dREW6wbk2gpMqHnXsk62MMkbEoACObsvBhkOH9jpmold5EjTal5SmVoHCM11VTNwuH
	 ALupISxteKqnrOZmD7bDanxUw1B5nc4Pp+NAtjRHGL/BRufX4fU1asMWu2rCPp+Ed0
	 ysLHD5PO50QDVakJPpMM1WkfWH0CWMpVKNCTZNbyhMjB2pQM/netKyEDKmWjHSjakN
	 ZUKEw/B3Ai6VTBAqbEtvRMpOR0mr+Jo2ArOv/NgSS/5vCArx5yJeMcrlSQOS9c2oz+
	 Jv4XCWGoLty2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BAE3822E4C;
	Tue, 15 Oct 2024 01:10:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 1/2] selftests: net: rebuild YNL if dependencies
 changed
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172895463899.686374.7630398528769381304.git-patchwork-notify@kernel.org>
Date: Tue, 15 Oct 2024 01:10:38 +0000
References: <20241011230311.2529760-1-kuba@kernel.org>
In-Reply-To: <20241011230311.2529760-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, donald.hunter@gmail.com, sdf@fomichev.me

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 11 Oct 2024 16:03:10 -0700 you wrote:
> Try to rebuild YNL if either user added a new family or the specs
> of the families have changed. Stanislav's ncdevmem cause a false
> positive build failure in NIPA because libynl.a isn't rebuilt
> after ethtool is added to YNL_GENS.
> 
> Note that sha1sum is already used in other parts of the build system.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] selftests: net: rebuild YNL if dependencies changed
    https://git.kernel.org/netdev/net-next/c/0cb06dc6c42b
  - [net-next,v2,2/2] selftests: net: move EXTRA_CLEAN of libynl.a into ynl.mk
    https://git.kernel.org/netdev/net-next/c/60b4d49b9621

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



