Return-Path: <netdev+bounces-68501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C77468470A5
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 13:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66C3A1F2790A
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 12:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8434F185B;
	Fri,  2 Feb 2024 12:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b9qM9A9B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C7646A1
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 12:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706878231; cv=none; b=lA9Qpv/w+Nb0SlcRYHfP9AXgo0RLEVRipC+P329RLwkwcMq8DuDVW4qIXlSO4StdSWwGTxBhAf972y77Tt8eaJXzIU9cffYHFdhr8z+tp8WAjtABToN3QZgsbxdSj2Rs/MqWdkbG/Jvoji1zWtnLk3KA/g09fWuVN40+vmQ5vnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706878231; c=relaxed/simple;
	bh=u7RiM0Pypl3EzOdBZ9FDy9MqeXVePrrJicNCJaQwZQk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aFjJbWwX2mMs4a6E52whyd9U0wiYUvpQ9z9kjo8QPZNUrrdpW3FuwUDAEJVfp+VBMfm8ohWnvN2X9rny8V1ASL3IyTAZEBjiHnU46lQcaMRtmkpE5mRB6aNLewZMyWgmhGC4TWLeBG+iW9UNofgOREv04S9KLaEvdTBiV4FXGB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b9qM9A9B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F2DAC43390;
	Fri,  2 Feb 2024 12:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706878230;
	bh=u7RiM0Pypl3EzOdBZ9FDy9MqeXVePrrJicNCJaQwZQk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=b9qM9A9B2633n+z/MewQtlUyxEvEOFb8gGRGCNYGPRmrrO2vK2WJJD4ZaTmjFp3kD
	 bbfgeta/3menT2K0HkH8/IX+jAykOeMWzDqaJnh1w16IjIBK2Dfmqr01n7CWHfD1p/
	 QSqhgtm0pyS4AnFDCOaQSD+ruykx9U+7K9wewRoUzvnBKGUCDqugqibpCR7lxfG53V
	 kwc9GzklH5gRdHpYlMMdI+Ig3w2vduO62XsNechgrPhd0UNp4LHTfspdviAux5Fl7N
	 5vnNvssdXAHyEEYCegVoSf02IHLHwnOszy5c0PeLR10H4ThRVE0OI+oaqC95mHNZQM
	 yk+hUeGem70xg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7AADEC04E27;
	Fri,  2 Feb 2024 12:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/4] batman-adv: Start new development cycle
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170687823049.13015.12274931129811487024.git-patchwork-notify@kernel.org>
Date: Fri, 02 Feb 2024 12:50:30 +0000
References: <20240201110756.29728-2-sw@simonwunderlich.de>
In-Reply-To: <20240201110756.29728-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org

Hello:

This series was applied to netdev/net-next.git (main)
by Simon Wunderlich <sw@simonwunderlich.de>:

On Thu,  1 Feb 2024 12:07:53 +0100 you wrote:
> This version will contain all the (major or even only minor) changes for
> Linux 6.9.
> 
> The version number isn't a semantic version number with major and minor
> information. It is just encoding the year of the expected publishing as
> Linux -rc1 and the number of published versions this year (starting at 0).
> 
> [...]

Here is the summary with links:
  - [1/4] batman-adv: Start new development cycle
    https://git.kernel.org/netdev/net-next/c/df3fc228dead
  - [2/4] batman-adv: Return directly after a failed batadv_dat_select_candidates() in batadv_dat_forward_data()
    https://git.kernel.org/netdev/net-next/c/ffc15626c861
  - [3/4] batman-adv: Improve exception handling in batadv_throw_uevent()
    https://git.kernel.org/netdev/net-next/c/5593e9abf1cf
  - [4/4] batman-adv: Drop usage of export.h
    https://git.kernel.org/netdev/net-next/c/db60ad8b21ce

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



