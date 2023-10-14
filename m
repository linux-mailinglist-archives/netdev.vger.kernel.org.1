Return-Path: <netdev+bounces-40917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 322D47C91C7
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 02:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E13AD282F1C
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 00:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52DF627;
	Sat, 14 Oct 2023 00:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldC8qNB0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D2910F2;
	Sat, 14 Oct 2023 00:30:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F1387C433CD;
	Sat, 14 Oct 2023 00:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697243427;
	bh=QLh7oSokX/rC9zSWUn+z4oaePbGDrDJFlc+FBj6TeBo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ldC8qNB0BNr4Gjt2IQwyMx42j7bHFZM9nUZVNIyMKQxWpykqFzQj9pn0WxeShJNKw
	 TGYGdyawne0rLosZBNystcJZZY8XW5koWRO8vPM+E+HBpMfFVAFNEFzHpX9TuC3Stu
	 2JG/ibjl+WuvD1HNDbQyyVTQY40iIOCpO4gJIOnTu5wUzq16k99B++a/lk0Op0Hz2e
	 oVxn/L+/3v1CFuk5gHkOxpHInasNgv0jLf3JCALfiWz4/8tSrsIGK1+pwSmP0S41Q7
	 mA17OZGun3yp6gU5G4upNCI4tmbdL3ULH8+z9E8aIsF1gviDwVNRUX2WgCNPMuWlzZ
	 jNgiVduL1kKug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D9B52C691EF;
	Sat, 14 Oct 2023 00:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: sparx5: replace deprecated strncpy with ethtool_sprintf
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169724342688.24435.6284977405562328203.git-patchwork-notify@kernel.org>
Date: Sat, 14 Oct 2023 00:30:26 +0000
References: <20231011-strncpy-drivers-net-ethernet-microchip-sparx5-sparx5_ethtool-c-v1-1-410953d07f42@google.com>
In-Reply-To: <20231011-strncpy-drivers-net-ethernet-microchip-sparx5-sparx5_ethtool-c-v1-1-410953d07f42@google.com>
To: Justin Stitt <justinstitt@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, lars.povlsen@microchip.com, Steen.Hegelund@microchip.com,
 daniel.machon@microchip.com, UNGLinuxDriver@microchip.com,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Oct 2023 21:37:18 +0000 you wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> ethtool_sprintf() is designed specifically for get_strings() usage.
> Let's replace strncpy() in favor of this more robust and easier to
> understand interface.
> 
> [...]

Here is the summary with links:
  - net: sparx5: replace deprecated strncpy with ethtool_sprintf
    https://git.kernel.org/netdev/net-next/c/e343023e03d2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



