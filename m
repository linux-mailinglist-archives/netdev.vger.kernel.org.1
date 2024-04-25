Return-Path: <netdev+bounces-91186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFCC8B199D
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 05:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 433411C2125A
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 03:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22106249F9;
	Thu, 25 Apr 2024 03:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XsK7Z2+H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B4D22F03;
	Thu, 25 Apr 2024 03:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714016428; cv=none; b=ukp9YnMLvcJwQJWP8qlHsRIkTnbF57ppuvXv54nHdnspZZlQTMjnChDK5keKM7U6Ux6ILuHNfA+dtpQFHwIM7/GmLfXe4jeVygL0OclUnFS6J82JL4sMqCQw8HOn12WfppzSv2O7T9mTy3n7bgzbXvSkX+YyAxlkX3GG62b223o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714016428; c=relaxed/simple;
	bh=ZSFOLOiST5Y0zaL1vu85JN8Do97soPJMMZlRjHGfXiM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Jj1wXt5d+qay/2iifRUWUnNG8ZVzwlflLy/FUbXuQen/0LPB4nLovhnYjqj/G3rlGh92lnSiG1SkzrVnXaau0chjgyl8dLDoszUDGSupJEVIlZtbtLWfy06q8O0SidoZ3XXGJtfRai3Uq8MsB9lYGFGunvu7trQ3WTqssTZ3oJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XsK7Z2+H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 972E3C32781;
	Thu, 25 Apr 2024 03:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714016427;
	bh=ZSFOLOiST5Y0zaL1vu85JN8Do97soPJMMZlRjHGfXiM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XsK7Z2+H8dCCy5ZGyXr6MERs8t66RKpsk5iXmxkshTC2zz1xwNjsTssm+yry3fshl
	 No/D2VXDYckP6UWDnroh4oEQCFzGE97Gq88a/d1jLMOIYa6D0a+1pzNw8O+qVA5riT
	 ZNqUYhhKOmGq1OR/qPdfyYGvmO0lJX98zcCxEdaJY8yje0rmTjtxFvXbNJNuEidah9
	 Cni0NglluRaP7b/JWNP9GECr4Fkkivq1CQqtEZVEFd4SPbf2SvYnd3zuqby+CNLgFU
	 9GbwUveuGWBAIc8/m/EcFFa5+k7iwYbWqoRsB2xMoXzZk418hdEJ4DVx/ml0xfaabX
	 wu/QLrHcv8BhA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8A167CF21C0;
	Thu, 25 Apr 2024 03:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull request: bluetooth 2024-04-24
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171401642756.20465.2200280808445199739.git-patchwork-notify@kernel.org>
Date: Thu, 25 Apr 2024 03:40:27 +0000
References: <20240424204102.2319483-1-luiz.dentz@gmail.com>
In-Reply-To: <20240424204102.2319483-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Apr 2024 16:41:02 -0400 you wrote:
> The following changes since commit 5b5f724b05c550e10693a53a81cadca901aefd16:
> 
>   net: phy: mediatek-ge-soc: follow netdev LED trigger semantics (2024-04-24 11:50:49 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-04-24
> 
> [...]

Here is the summary with links:
  - pull request: bluetooth 2024-04-24
    https://git.kernel.org/netdev/net/c/e6b219014fb3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



