Return-Path: <netdev+bounces-69936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBD384D152
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 19:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ECBC1C20E12
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 18:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDD041C91;
	Wed,  7 Feb 2024 18:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAdutPn+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B7983CC1;
	Wed,  7 Feb 2024 18:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707331233; cv=none; b=j5Qt6PbWvee77HhBnJJnajZyuokzCyjHNNqQlS36gpBVBKKXZnSVKuyCUbdneo5xbIo2OXCbcvZrTIZJX1xOO0AfmMcd3QAzG4TUOsO6ivtZc9C4/JT5WfwfbGWY+pxkMSeCRUM1IQSlI5eeP7sfJF+LvSjRL/EHCkmgS3eXoZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707331233; c=relaxed/simple;
	bh=z8a4Ls29S/rSHVCmTqo32Le5LWs9M/zkuvJ4ILb3smY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WIBCOcqJt8FK1sYlynyXfJ+yBD+gznirzMG9vkE9/ay1Bca+TK3oWHhE7a5Wdpgj0FiaYLttrTtD7Nw1BoW3Aoryga0FOog9sn8bBJb7EpQhzushax9P/ptRraHBGLyG0/R7OvO9ayP+0FBiGGaMS1nALferNqrTSEySuUDvUFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAdutPn+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 20273C433C7;
	Wed,  7 Feb 2024 18:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707331233;
	bh=z8a4Ls29S/rSHVCmTqo32Le5LWs9M/zkuvJ4ILb3smY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hAdutPn+0+1vBnCdwqnPJHyb7pa6O6oc05Y1LJrXyp1WJeyxDmCbj/2y4VOb4eV5b
	 rI3MM77ceQklp0IaYew+4ayoLsezZVjKfxxXWAMoAZaYjVO/L25oDv21XmZFCQnG+f
	 u6pIAgvJRrBEPTex1/SnyEDino9sWTGtxSUBJ+vNlvGNX6vviRq6hDRQl1VOrNoYTx
	 FCvMPsxPctgOATU/tiUUzGhwaCIbKTXY7dInbhzl0l/tqvsTko/e1Ahf9yLuo4jKI1
	 m2MuLXthcxZcjVaS8PeZmX12eB66J+5XPPbJKOInEskOtIhytFadeWOTzjD0Qfmpx/
	 oJin1VxKFet8Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EEE20D8C976;
	Wed,  7 Feb 2024 18:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-2024-02-06
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170733123297.1949.5137395590781704085.git-patchwork-notify@kernel.org>
Date: Wed, 07 Feb 2024 18:40:32 +0000
References: <20240206095722.CD9D2C433F1@smtp.kernel.org>
In-Reply-To: <20240206095722.CD9D2C433F1@smtp.kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  6 Feb 2024 09:57:22 +0000 (UTC) you wrote:
> Hi,
> 
> here's a pull request to net tree, more info below. Please let me know if there
> are any problems.
> 
> Kalle
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-2024-02-06
    https://git.kernel.org/netdev/net/c/335bac1daae3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



