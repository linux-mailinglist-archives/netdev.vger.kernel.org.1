Return-Path: <netdev+bounces-175894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EFFA67E22
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 21:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E5997A49D3
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 20:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53B32135AD;
	Tue, 18 Mar 2025 20:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGEykTGM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCD42135AC;
	Tue, 18 Mar 2025 20:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742330565; cv=none; b=CfHQl2UruddMiq6B0kDPcuyBBtfAsPeihSB9CSZRlxZMgNR6JuBsfgbu6HiImnz8tRSY5jlDQcklNNkBdLTcxj2OE42OkjFCZybyLwwvhQAKaB9+3q3i6rRhiPWAE2AqYKBGsv1vMPY5rq/ND48ZsPO59Qew2mXQ3pGHn5pknL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742330565; c=relaxed/simple;
	bh=KutkzV80eNMrQzhFl8j8iAQN/TF49RJmMiGKjR7pvlM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JTKvMZWqMzg7KSSVK4+CnvCJ1JTAjyNlOmyLOLyCwdGrki37xENTnRciEeVUJWnjeJS2QSUUxAfMrEcTvS7M7rmNsEthXK72xuPd7YG3IMvCx4hVo0lOzDutZxo4p59Ax5DWfnuXtR89eNATPfbiTO4QXATawMo8sqXntVISBP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGEykTGM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FEE8C4CEDD;
	Tue, 18 Mar 2025 20:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742330565;
	bh=KutkzV80eNMrQzhFl8j8iAQN/TF49RJmMiGKjR7pvlM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VGEykTGMUOLfsysWClKdUha7g35wrPjwaFysO8tWdhdciiv4ahT3KVpuJmc6Ojyer
	 uXVuBiEPcMg+EWHsFWPCv2HuUwJtgB994kOJq220n7fk/fsHydBDl0tsx5vms01R/y
	 rhuAxvNDqpnIljx2ZaZXMOSC2jaoItlPE5cK0JOYaktbrwrbEh+TU8EmisGxnrOLEz
	 rOInOpm4H2h5EAsFOBqXnDzY82XU34jcYkNljfrI0zlxugiKfgYFP5TsNt5/jhqiZB
	 Z63vtNr4yAMPGP0apoFwxi6bVKIO6kA12egBoOL+ciDSft5owamfZK7m51nTTddOuF
	 JY8qRc77ZYG+Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F75380DBE8;
	Tue, 18 Mar 2025 20:43:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2025-02-27
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174233060098.450362.2431870181438055260.git-patchwork-notify@kernel.org>
Date: Tue, 18 Mar 2025 20:43:20 +0000
References: <20250227223802.3299088-1-luiz.dentz@gmail.com>
In-Reply-To: <20250227223802.3299088-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to bluetooth/bluetooth-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 27 Feb 2025 17:38:02 -0500 you wrote:
> The following changes since commit 1e15510b71c99c6e49134d756df91069f7d18141:
> 
>   Merge tag 'net-6.14-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-02-27 09:32:42 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-02-27
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2025-02-27
    https://git.kernel.org/bluetooth/bluetooth-next/c/0fd7b2a43260

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



