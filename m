Return-Path: <netdev+bounces-209396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A14D0B0F7AD
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 17:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8344C9666AB
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 15:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2169E2046A9;
	Wed, 23 Jul 2025 15:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZJqP+PJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6F8202F83;
	Wed, 23 Jul 2025 15:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753286351; cv=none; b=u/BrO9qxDM93ha2H0jMH63Q5PftA5pGTEqb1hIOCJsTFS7pSHVZ9EKYXOxwHR+zfRSdmsnA9d0N/1tsKYYPHKKKjeWq9rdoPklWQ3aOxLbc5MqjJH7Kae0F1ew2IxIa2YdD83g0o341hG1+l2+j/DEpa4n1665/t1mFovJetN50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753286351; c=relaxed/simple;
	bh=ejbm9mWu22R5VgHoI4nxzVmCJLNVPY6e0QSVHPT0Alw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YsmynE3wQ7Zn68vNVERx3COgWmAj4rINMwe0pRGCLUfn1bxIg5BuUQetPY251e75nChTTUo3krg+nXP1c0/mZbnYmNbETIc1oOBc+NNNSyoYazxfxUC8XMIdCPJ4niFVLYLc0SnsDmh1qwIH5cfoBuceW85ocsmtk8hDW9xMzvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZJqP+PJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B54C4CEEF;
	Wed, 23 Jul 2025 15:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753286350;
	bh=ejbm9mWu22R5VgHoI4nxzVmCJLNVPY6e0QSVHPT0Alw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IZJqP+PJlFoMJVlYHWJfmBxECV3vUDHTuBJG5XneSY4cGa/oe7Z0FgCv0wyX9FkOz
	 +NkWoytOBevnu+VcmvC7pvqfV42cQr3myuSnS+fJzA28Kvf8h6LXQtVX9Lqn1tKC7b
	 BnlVCE3uRoaoQxU2M7vTcAdbVOnT6jnSIzAqTroMGLNrUSr0bDdWU0hYSuU+bmoude
	 tMRHxObvNPVUnfe/+MMtBFSPs87VqiDkHnFfYgsXxuANpOVDHBKdu6p/AJAJesHu1o
	 h/LmGAiMxerYZffkVRIU+sNFZ4baJAf5vsWnJrANqX/l+Tg4wz9OTAiVVgMXqTCh6F
	 ryd6TUnRAEqtA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD87383BF4E;
	Wed, 23 Jul 2025 15:59:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2025-07-17
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175328636849.1599213.8131125889548150258.git-patchwork-notify@kernel.org>
Date: Wed, 23 Jul 2025 15:59:28 +0000
References: <20250717142849.537425-1-luiz.dentz@gmail.com>
In-Reply-To: <20250717142849.537425-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to bluetooth/bluetooth-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 17 Jul 2025 10:28:49 -0400 you wrote:
> The following changes since commit dae7f9cbd1909de2b0bccc30afef95c23f93e477:
> 
>   Merge branch 'mptcp-fix-fallback-related-races' (2025-07-15 17:31:30 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-07-17
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2025-07-17
    https://git.kernel.org/bluetooth/bluetooth-next/c/a2bbaff6816a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



