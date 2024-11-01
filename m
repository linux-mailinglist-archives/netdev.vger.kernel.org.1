Return-Path: <netdev+bounces-140906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 713369B8943
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 03:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2FF6B22361
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 02:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A9C13B7A1;
	Fri,  1 Nov 2024 02:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5DlriMw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9989513A865;
	Fri,  1 Nov 2024 02:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730427625; cv=none; b=LxHzDQK23A9c6IjaRTorIr/+tsd0NpPsaPVW74nUXIsrmmIBAENcNCyd/vPwJTUBHIKFgkjqspoiPhOiU6KLNDVoFPLfDM2W5Eb736R25xGPc2IqcnYtwvVLuwXRXGGtritJmMa2BgTWMWpm5Fd15TGeAuENi8HmlytuQywDrec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730427625; c=relaxed/simple;
	bh=FtFEokLt5E0nK+5sRxHP7/c9bnPq5dIqxz3jsniozhI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tUYTZTDHCXvsFUjifiyGpiDSIqtv4KPsZ+ddaT+nuS+2aJb3WX8Z409PhGRkWa5un4RZP3lc/mx+8Wc09w9YwB9f0r8NM9GcyiDqRaDHZKxBey0gDuWT71N12sfFDab9hNBJ+pSWhDioy3fPG0vwpMAOMpC5XeiEriUW15Z1dXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5DlriMw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 377FFC4CED9;
	Fri,  1 Nov 2024 02:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730427625;
	bh=FtFEokLt5E0nK+5sRxHP7/c9bnPq5dIqxz3jsniozhI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=R5DlriMwVYc+8LFZrZLbJW5SCrW3R2Ht7kFxgjFD1eZCmS9aqsyh3kVvmZJ9XWzNB
	 VJDMq3zW+HOGcFUZwg/CVjDxyZOEaz9DsUoLKMNVmR6udiiEVXPtvzzqjmTatQ18rz
	 dwZ1P0G8DG5EDrTgliypll7p9jC+P+j2aFZdQKx7nBwH0lVy51TxF7U6G200yAeqjk
	 jl1LPxfhGGmT0hwMenAbsxrtDSOY6yDXlhmvVmc4VlgL0XhH2/sMECAXASrFSSR6r0
	 i5v7zujO0LTCXRUFf5CEjJg8jxJxiy7yC8SW38mqH7I1+t90kiVkpURf2PQoEYssmW
	 krugnp8avdJvg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C46380AC02;
	Fri,  1 Nov 2024 02:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] fsl/fman: Validate cell-index value obtained from
 Device Tree
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173042763300.2156176.4170019581094798127.git-patchwork-notify@kernel.org>
Date: Fri, 01 Nov 2024 02:20:33 +0000
References: <20241028065824.15452-1-amishin@t-argos.ru>
In-Reply-To: <20241028065824.15452-1-amishin@t-argos.ru>
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: igal.liberman@freescale.com, madalin.bucur@nxp.com,
 sean.anderson@seco.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 28 Oct 2024 09:58:24 +0300 you wrote:
> Cell-index value is obtained from Device Tree and then used to calculate
> the index for accessing arrays port_mfl[], mac_mfl[] and intr_mng[].
> In case of broken DT due to any error cell-index can contain any value
> and it is possible to go beyond the array boundaries which can lead
> at least to memory corruption.
> 
> Validate cell-index value obtained from Device Tree.
> 
> [...]

Here is the summary with links:
  - [net,v4] fsl/fman: Validate cell-index value obtained from Device Tree
    https://git.kernel.org/netdev/net-next/c/bd50c4125c98

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



