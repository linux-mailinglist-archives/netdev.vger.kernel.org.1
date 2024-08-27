Return-Path: <netdev+bounces-122526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD5E961940
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 23:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C96A28524A
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 21:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7906A1D47BA;
	Tue, 27 Aug 2024 21:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERvKuRqt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5320D1D47B4;
	Tue, 27 Aug 2024 21:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724794241; cv=none; b=icL1JIX00GpWqifLC11+pQyrN2lXI7BQkbQJ5SfcLJZKfHAZ4+SfKYO6bhAWBzJrYJ5K8w5E2oXAlnh0MZ5jAhZRTaeSZHNg+EmMfEOyCiMkL0eqRcYydGQYLbV00tvlfib884Ewddk/q+hCwICzP7XkY3yurxv8uJeCpqRj3G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724794241; c=relaxed/simple;
	bh=H2wQoaxqtUjqkFcVVz/DQwwvyjDD5qJEDoV9DMtB/CU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BjJX52KCEQhifQIhIGeGfcSVjio5N+CEiI0oPDlEO1d2hhxlSRQ1eBdWmut9xTruMjWgFqs1GjX1NbaTpcFQONxh1OyVDDnhvtQQWh/jn/0KXCUC3w3ksFLW0nipC0hJy4Vq2xQpePD97NIuyLcLmY43AABDK4E2zqn9YpVVYSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERvKuRqt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 240BFC4AF1B;
	Tue, 27 Aug 2024 21:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724794241;
	bh=H2wQoaxqtUjqkFcVVz/DQwwvyjDD5qJEDoV9DMtB/CU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ERvKuRqt8LdgA1gH3dU68K/KbYr770mwVSgLN+JElKblO97lYCiotHFS3S+hQ8waE
	 qD+ecJ1lthFcl/0mhzZK2EvB8qDifwX01tQBD/P4PoRBnwMXV6xG8nPNhEI7RCRTzW
	 nyh28AVDNlBv/IC4U6AsGYqqrawtbikOMJ5fdXMayl3V+qc4d/sGfFWkoinU5rzudd
	 9d3VmlSBdPBQ4f9LhqREvKg6FwXVnl+8G9z2ZJw4CmsGOxYBn+jnw8GSSxk+67aObb
	 fnZ8rdtUVsGSqhaxnwv2O3uT95P8HU9yLHx9MJdIjvrVr4tNDeWgO5g6OlSEL4oIe4
	 5jBHAkWO2Hokg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CCF3822D6D;
	Tue, 27 Aug 2024 21:30:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: phy: vitesse: implement MDI-X configuration
 in vsc73xx
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172479424099.767553.11079699582642143947.git-patchwork-notify@kernel.org>
Date: Tue, 27 Aug 2024 21:30:40 +0000
References: <20240826093710.511837-1-paweldembicki@gmail.com>
In-Reply-To: <20240826093710.511837-1-paweldembicki@gmail.com>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 26 Aug 2024 11:37:10 +0200 you wrote:
> This commit introduces MDI-X configuration support in vsc73xx phys.
> 
> Vsc73xx supports only auto mode or forced MDI.
> 
> Vsc73xx have auto MDI-X disabled by default in forced speed mode.
> This commit enables it.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: phy: vitesse: implement MDI-X configuration in vsc73xx
    https://git.kernel.org/netdev/net-next/c/cf740e3cc761

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



