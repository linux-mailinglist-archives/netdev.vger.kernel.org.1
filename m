Return-Path: <netdev+bounces-213537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 592B8B25878
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 02:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 679465A3339
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 00:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E75B189906;
	Thu, 14 Aug 2025 00:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FBYScG0I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005E51459EA;
	Thu, 14 Aug 2025 00:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755132005; cv=none; b=Fg2t5V9HuSKZno5dKOvihlqg/KTn44Zh7y9ln0hVzLoL21cuNwpzGLU/rs0AcFu0pRTHolceYJBDC4hU5Jf7d2jk5cnClP5ENljpvjIQytNWhaI3hKZf/m6q7SkzbbNDd7JKrPMHIWpWjL3Tfnd5+DKRrPwg3b2lQeCIntN875w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755132005; c=relaxed/simple;
	bh=nLMkPPo4ZFDBU7rUwHDIQlXdUyxgc9cY3+lk5Y8ZfB8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Pd5Zdk/cKyyxTlpxeFzTJ2v3M0o6+hK5vd/d1NMpNxkW56cfPsxKsBng/UAlpQ+sLs6SmE9zxUKq3saENwgB1zoz8ImKoi9zz9Pcov8TY4A+BNRSWC6KwO9EBvbl0OYcPZjc9JL0E3V1NA5BKGWOPQm0L+QqlrGtmne4eCyzihY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FBYScG0I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4920C4CEF6;
	Thu, 14 Aug 2025 00:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755132004;
	bh=nLMkPPo4ZFDBU7rUwHDIQlXdUyxgc9cY3+lk5Y8ZfB8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FBYScG0IxxdO6hUZj8JoJ9bh1ykysA4pn8hk7W/wU8YLeIfDeMwZOrD7m+GEU1VWe
	 Gr7YAx0NroRWBmdurGEmFmpI7CzzbSR/mhoOJhq57/9EIl+OT0b7ZqKQF10Sm9BgDK
	 Qo6bthnlkIMWXl+gk+aR1vmQqhDnC9yy+ixkk8Sn1EHPNMfIu7aJy99VogIt6sQ+AI
	 7zTextaqih+gwSVT7pLGgzWtceKJvkPeHPoflV70AuM8007eGgsUTk3/1+B9PlnWCP
	 pdQR4YAOgnBUmLCPwbLJ3fEPcggKyt7UfI4GwLureHW3gAYxiczytc3TOf55KIARre
	 YKpFdslPnsCgQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD8C39D0C37;
	Thu, 14 Aug 2025 00:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND net-next v2] net: enetc: Remove error print for
 devm_add_action_or_reset()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175513201624.3832372.12289248453495855139.git-patchwork-notify@kernel.org>
Date: Thu, 14 Aug 2025 00:40:16 +0000
References: <pnd1ppghh4p.a.out@axis.com>
In-Reply-To: <pnd1ppghh4p.a.out@axis.com>
To: Waqar Hameed <waqar.hameed@axis.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, wei.fang@nxp.com,
 xiaoning.wang@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, kernel@axis.com,
 imx@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 12 Aug 2025 14:13:58 +0200 you wrote:
> When `devm_add_action_or_reset()` fails, it is due to a failed memory
> allocation and will thus return `-ENOMEM`. `dev_err_probe()` doesn't do
> anything when error is `-ENOMEM`. Therefore, remove the useless call to
> `dev_err_probe()` when `devm_add_action_or_reset()` fails, and just
> return the value instead.
> 
> Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
> 
> [...]

Here is the summary with links:
  - [RESEND,net-next,v2] net: enetc: Remove error print for devm_add_action_or_reset()
    https://git.kernel.org/netdev/net-next/c/3051f49b0e03

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



