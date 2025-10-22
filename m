Return-Path: <netdev+bounces-231498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DF245BF9A62
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 03:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AA9484F762A
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 01:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8896521FF25;
	Wed, 22 Oct 2025 01:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZUDp9PU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603D81F3B9E
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 01:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761097839; cv=none; b=CzyYRFoQ/p7sQetp+c+gnRD3CzXWeIiG8thzRuMD9OT7QvaVdZOH6RYi8rKAV900F1kyzl1rutQ9DLyQJdL9hlrdX3dVNacN6AF4mLgXj4p262rL9OPP4KlVtiq5bi5gMsD2xJGNmwmW6n+Fkl69lHB+8xJALtyjVBy0+8BAfLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761097839; c=relaxed/simple;
	bh=yQtVLbl15606I5At/kcW3mrQMZ/Rnfkp3YtLzhw55hE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LlyBiJvX2AMuTCcZ00el1snnl/5Flqa/WQTndb7RNYih2RYJn1td2Ihu4DkyJTHTSM12dBPolFkXzyK7Dj7NXBWarBuJgVvqsH2kXQelc2+ZUKhTFZ3qvlL/OwNua3O4g3bBntYyjSGU326cfdBeaTHRMwO43fy7R/F1YGtgHtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZUDp9PU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3DB0C4CEFD;
	Wed, 22 Oct 2025 01:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761097838;
	bh=yQtVLbl15606I5At/kcW3mrQMZ/Rnfkp3YtLzhw55hE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UZUDp9PU8HP1s9tuD/ZA1lIQEoGlTHVw2OU09rTQBnDDo97oY4OYLOA3myWwDA4/C
	 pVRhkH9adxDYkM1kIhdbAFll7nmDIlm4njCV7PNltRbbSjDg+Hfr2m0LWM+G8311RR
	 1mmj+YbbTDKicKLbYzrp4Qp1orAXFPoW2kVB+/++shqzt9m/iT8B6Xr14U442LZh9w
	 DVqE+8SuBVLMwvIAG3f3A+NIkvzqs8LmsHMSzqSisne9qdx/tcyLpkXe0WSnV5tp1c
	 f8g+Ccg/ZSEK08lZfgDGghLjd/WTWjkYQAfUpBQiJgDfxWJi7lvaQxv9fil3V4owgc
	 VkynXZq7tdWKw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DCD3A55FAA;
	Wed, 22 Oct 2025 01:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] bnxt_en: support PPS in/out on all pins
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176109782000.1305042.8679933696490326176.git-patchwork-notify@kernel.org>
Date: Wed, 22 Oct 2025 01:50:20 +0000
References: <20251019225720.898550-1-vadim.fedorenko@linux.dev>
In-Reply-To: <20251019225720.898550-1-vadim.fedorenko@linux.dev>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com, kuba@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, richardcochran@gmail.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 19 Oct 2025 22:57:20 +0000 you wrote:
> Add supported_extts_flags and supported_perout_flags configuration to make
> the driver complaint with the latest API.
> 
> Initialize channel information to 0 to avoid confusing users, because HW
> doesn't actually care about channels.
> 
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] bnxt_en: support PPS in/out on all pins
    https://git.kernel.org/netdev/net-next/c/91f76771dba0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



