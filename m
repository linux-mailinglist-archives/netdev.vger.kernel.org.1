Return-Path: <netdev+bounces-179473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E73A7CF0D
	for <lists+netdev@lfdr.de>; Sun,  6 Apr 2025 18:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F2E53AE7DC
	for <lists+netdev@lfdr.de>; Sun,  6 Apr 2025 16:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6237617A306;
	Sun,  6 Apr 2025 16:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hhTHdUpV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAB6176FB0
	for <netdev@vger.kernel.org>; Sun,  6 Apr 2025 16:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743958794; cv=none; b=jjD83TSlOzm7+CmWuoRzT2v4+jctXCFRvgLGfO5dnkjJu7qLyZUobRP8niPD3eFla+2lhod7sw0dWVc7XLTXHnK8azVm4DKVHkDEqfvVlP5hLEPq5oc6ipwOCaIohumW37XUYX2QlgOfutG+nB2+xBD0sCycdjfa9aL+6TGJlYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743958794; c=relaxed/simple;
	bh=fwMJo1JaVAg4SOBEsVO+85c4CzzU8RXvxSLqTOeyKME=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WdLvTQ4u1d00cWXPsIwzXo7xR3dHASbrzHb56WAYlSrv+ZUEogK+Ni9450cWaG+lAe14BvAf15Eitq5YOdL4flhmpIKEA23kc6mDwZ0HMErLVLxPkgN6qwYAz03R1LwVPOLkzzat//ML/HPnmadnjuMB540Ku0fMkmGvYXNff1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hhTHdUpV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACB4DC4CEE3;
	Sun,  6 Apr 2025 16:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743958793;
	bh=fwMJo1JaVAg4SOBEsVO+85c4CzzU8RXvxSLqTOeyKME=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hhTHdUpVWqYmsUp+FAP7wAADlBc3u/3Utqd94aCwE5hyzEaM3EIIcgjxAaZib+fBR
	 uXvpHSWzI/rpPEcUvRclfFAEujAURi679grw91nHjzCnzs6zYsKz4y/TNScp53LLmv
	 8T6Tfc9GWUvXJ216Raij5kwVAkEKNoijIRzhBSlethamHva4h/LdHr/nPNpW4PFv/P
	 VAgl0rWqL4+6+4WSdy51QvVjOhCnldwA3y9ZyuipokyGM6HRF523MgG+HEVhle0JK5
	 FcyTrjC6lOGprpYKYmnQvadBfEa/jSvbRcShVwttIbCWenDPMIsZfdWdNoOaY8Xo/R
	 eVroXZPYGv6Gw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D26380AAF5;
	Sun,  6 Apr 2025 17:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2 0/2] Improve coloured text readability
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174395883101.3915601.12663175368150870282.git-patchwork-notify@kernel.org>
Date: Sun, 06 Apr 2025 17:00:31 +0000
References: <Z-QKNa7_nHKoh9Gl@decadent.org.uk>
In-Reply-To: <Z-QKNa7_nHKoh9Gl@decadent.org.uk>
To: Ben Hutchings <benh@debian.org>
Cc: netdev@vger.kernel.org, 1088739@bugs.debian.org

Hello:

This series was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Wed, 26 Mar 2025 15:07:49 +0100 you wrote:
> Currently coloured text output isn't very readable in GNOME Terminal
> or xterm with a dark background:
> 
> - These terminals don't set $COLORFGBG, so we end up using the
>   light-background palette.
> 
> - The standard (dark) blue is also too close to black in their default
>   dark palettes.
> 
> [...]

Here is the summary with links:
  - [iproute2,1/2] color: Assume background is dark if unknown
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=cc0f1109d286
  - [iproute2,2/2] color: Do not use dark blue in dark-background palette
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=46a4659313c2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



