Return-Path: <netdev+bounces-211118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86317B16A1A
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 03:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 968FB3A7D31
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 01:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D71D189F5C;
	Thu, 31 Jul 2025 01:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLo0aw2c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0119117CA17;
	Thu, 31 Jul 2025 01:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753924796; cv=none; b=BgotmrrWYPolzEu5sXZc4ptUga3pS6lsYMdDTjnYnESjUMgnxkvkNUMZtdH9kR+IpNnwbRYMlUbpnPpWkzEAkOwdzKz6UJKIRHNOTwDAuk9k9QVYk5/ljoWayVLwlND483qGvNTckfSfdndRKlC8MyQDToKEZM3Gt/T7MJy0RWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753924796; c=relaxed/simple;
	bh=5i9mMcyM/3ms0TJF8vEVTMnppesLDAjG8FPBLBlw7CE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rmgbbWfc5V3laGwgbl7KfDj0wOJdrZNb0JXq5KM1X/LQZcgVG/E3cZUvwlE63lzEwjrW003Y1//smRcVv38z17ff0Vd8xmoOJtJPmzlerDAEREwEpVUwLbYPwGXfLrcPDTwW/m+QNvadw9WcfzFcx0tjkjLATp2DRpu6FV59nJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLo0aw2c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 901E9C4CEE7;
	Thu, 31 Jul 2025 01:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753924795;
	bh=5i9mMcyM/3ms0TJF8vEVTMnppesLDAjG8FPBLBlw7CE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NLo0aw2cjrQGEdqZQPPoIY0EUGWuziEzXlYREUvkvHfbQVBlnfKqQqpBamJKL5Q+z
	 Qza+eu1w8BZlL50XeGwHluANvVWo03fnZiShafhTA5W9ShBGpVChUVMnQleMy9Z8xR
	 Q9kl50OZL5jneP6pzoYUyTP+k6okvcjFMhfBYRsJwhIEUDOVAUp8z36BlFn9URNT7s
	 xZTC8JN27/dV+Boc6t1qPdtqCzs221eD4LJSABqAg+IJhrfzNkProXgoBy0qHzdQgz
	 hZDWs2K5ZbANXubjLCDpIp3r5tTGRWdsyh2Ia8dvi6Q1sTI6MAT2jjyLV1HfJOammI
	 WyigSOcxiW3rA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADB79383BF5F;
	Thu, 31 Jul 2025 01:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: ipa: add IPA v5.1 and v5.5 to ipa_version_string()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175392481149.2568749.3681377728383732917.git-patchwork-notify@kernel.org>
Date: Thu, 31 Jul 2025 01:20:11 +0000
References: 
 <20250728-ipa-5-1-5-5-version_string-v1-1-d7a5623d7ece@fairphone.com>
In-Reply-To: 
 <20250728-ipa-5-1-5-5-version_string-v1-1-d7a5623d7ece@fairphone.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 28 Jul 2025 10:35:24 +0200 you wrote:
> Handle the case for v5.1 and v5.5 instead of returning "0.0".
> 
> Also reword the comment below since I don't see any evidence of such a
> check happening, and - since 5.5 has been missing - can happen.
> 
> Fixes: 3aac8ec1c028 ("net: ipa: add some new IPA versions")
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> 
> [...]

Here is the summary with links:
  - net: ipa: add IPA v5.1 and v5.5 to ipa_version_string()
    https://git.kernel.org/netdev/net/c/f2aa00e4f65e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



