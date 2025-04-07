Return-Path: <netdev+bounces-179840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24934A7EB89
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 20:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1C92188A7DA
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 18:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7182B2580F2;
	Mon,  7 Apr 2025 18:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Is4OfOcI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1C12580EE
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 18:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049995; cv=none; b=lUdLUxGg3gwc8PpnuFrkOOCKdGr9nBR6voHCjFH4EIT90xtPs6bjdCSABqhlJb8vQd7drESokAJglwTEqL3nRWZKkphqQsQG6dnInQTSVxU1TMTFxkVdAIG3YJznP80R0QIM3KKpnWi9rh+ex9GfIyw/apHHAuNYoV/VK7csnCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049995; c=relaxed/simple;
	bh=nOtUH7kovfwgg06yUNsNxTZGWgaoyv1F+qWWuCFGn7I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EI5LD6QQmGcnReAQ1U5OZGcqvtOHpCpXY9EEp/A6HfG3HrVXCdM75OCSRymJMmEaQbsY8klyYJnXJSO7iZ79rkmUmqIqoxjO0EvV+xH9RZMSmW2CVfJE5PhwaG3cp/xgwSY98kO4+cxfkAC2RimMLEbfe6d9fFlBH7CYU4jcotM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Is4OfOcI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28FF5C4CEE7;
	Mon,  7 Apr 2025 18:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049995;
	bh=nOtUH7kovfwgg06yUNsNxTZGWgaoyv1F+qWWuCFGn7I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Is4OfOcIGMN14wQAx05bbgxRJP3KLRYsY+eO5NPhZNfFT68/M4D9UG1ZKClg4dHxG
	 eZlusOSp9LhQGIY7qFK2Qz3/7Wknh7Y4ZQAhtIDWExoZkIbt435bDO06+bexFlpvy1
	 n0f5/5cwKfCrJduky/oDafoRj8aeGvQLdxzbX8Nih+M4zEux8g0u2KG4lN1DvRQ+Op
	 C7XPdaK6smloAap9RxJZonr5FIcSyu9e0YfaxPvA1mzxIPHVDgrGLFcsBDjJD1Klx/
	 k2XiskZODsEtxTqBALoqRBvC0H6o5Ni3R4WrvHm5brXbfjwo7KWbPS+yrPKm2PJ87V
	 UD/+AmxdBHLYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE073380CEEF;
	Mon,  7 Apr 2025 18:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2] MAINTAINERS: update bridge entry
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174405003250.1220282.3145051055620556802.git-patchwork-notify@kernel.org>
Date: Mon, 07 Apr 2025 18:20:32 +0000
References: <20250405102504.219970-1-razor@blackwall.org>
In-Reply-To: <20250405102504.219970-1-razor@blackwall.org>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org,
 roopa@nvidia.com, idosch@nvidia.com, stephen@networkplumber.org,
 dsahern@kernel.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Sat,  5 Apr 2025 13:25:04 +0300 you wrote:
> Sync with the kernel and update the bridge entry with the current bridge
> maintainers. Roopa decided to withdraw and Ido has agreed to step in.
> 
> Link: https://lore.kernel.org/netdev/20250314100631.40999-1-razor@blackwall.org/
> CC: Roopa Prabhu <roopa@nvidia.com>
> CC: Ido Schimmel <idosch@nvidia.com>
> CC: Stephen Hemminger <stephen@networkplumber.org>
> CC: David Ahern <dsahern@kernel.org>
> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
> 
> [...]

Here is the summary with links:
  - [iproute2] MAINTAINERS: update bridge entry
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=c498efe79ba9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



