Return-Path: <netdev+bounces-195895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B943CAD29A8
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 00:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CB4416540F
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 22:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD8222539F;
	Mon,  9 Jun 2025 22:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HlOqbS4F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B7A224B0C;
	Mon,  9 Jun 2025 22:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749509404; cv=none; b=gAcVI2JxnaCuG+5CQyLp9sSEdvLJ3HbYOYCH4QsmlkvF3j3G1ccom5qQju706vVLFEERB5Pehv1A3ZInP53LzdrDAFbmldFzt/o+oQI7AZQ0IWKQ5P7NqYePMmHRVFylVUweYPD7VcRFF+jniKXpA7BIMbiA8Ie2OJdCdh1Jrcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749509404; c=relaxed/simple;
	bh=BjP7zxYjux8jWtu6bccOpRNEeatbVMBE0nYLeGDS3Jc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XuGGSXnQCs26QCceyieIuL+hKET9ZI99j9A1o6Nusg/WOjG66lGJj5iF8p61Fbzl4dioVnTvw4Je+4Ddqq8PXPGGZGjLqF/c/qh8LmcF87+e2ZW8y2b+05UxncrGZUyQuKNyg3XITkG59Byqcxi038g6KLrWzHx8oPcJL9/MTT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HlOqbS4F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05EB8C4CEEB;
	Mon,  9 Jun 2025 22:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749509404;
	bh=BjP7zxYjux8jWtu6bccOpRNEeatbVMBE0nYLeGDS3Jc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HlOqbS4FM23lgacn4g7T9j9o+/AFASriMGM/G4HHX/f48efM8/dsE+G2GFU/aEq+x
	 WAwdXJWJDuW+rrU7RWFzWBvQCXOx0iVxf0j5vQAjtnhP0Slc26OYG66m/K12KZAncG
	 sl/COUUElOGrswEFVqAkP0JGQ+KK+twju9W5K8cE5OWUpwOUY2QuXlnrJK7ojVTgUi
	 tKaHsQQrHXXdmD1fF7n2OGaKnigtP0iSdSP4KL2kL6X4CilxPi8Bm0ow0x5oqoPkWS
	 nQQylJLwHK5h+6P2j3esq/WdjcojNydm3Get62XuDbx7YsXReJIoMxACYV9RYndGOK
	 elpkVwdReURGw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADB73822D49;
	Mon,  9 Jun 2025 22:50:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2025-06-05
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174950943474.1577535.7070708450090771554.git-patchwork-notify@kernel.org>
Date: Mon, 09 Jun 2025 22:50:34 +0000
References: <20250605191136.904411-1-luiz.dentz@gmail.com>
In-Reply-To: <20250605191136.904411-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  5 Jun 2025 15:11:36 -0400 you wrote:
> The following changes since commit 3cae906e1a6184cdc9e4d260e4dbdf9a118d94ad:
> 
>   calipso: unlock rcu before returning -EAFNOSUPPORT (2025-06-05 08:03:38 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-06-05
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2025-06-05
    https://git.kernel.org/netdev/net/c/fdd9ebccfc32

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



