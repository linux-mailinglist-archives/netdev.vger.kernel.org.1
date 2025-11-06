Return-Path: <netdev+bounces-236130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C366AC38BCC
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 02:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AC4D1881A44
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 01:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FBE1EDA2C;
	Thu,  6 Nov 2025 01:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFRsp9Uk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C68B1C3BF7
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 01:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762393837; cv=none; b=npi68t/kakstZCVseHwxmy+L48AupdGQem4BaX+PCb7DjwZu2mZXBWvGz9ElchBkMrlL0D5w/GhL6OY8Msq/5GPAg8btiVVDqVlYAeKnROFsEhm3eU/iF6Dia1vjj+fuNELg3MARq7Sh7JiHFnM9PSVQGYSu/QAjG15JJ+B6FA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762393837; c=relaxed/simple;
	bh=wGy4wxbUQN1YaW0iCAIn0riEXTI+ZBdSIFYYqdtLvHc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=txFSblusxkT3z6qQSSx9fmePf1RrREYVDVOMk5QMxHIj0i7sdeTRZASsAmY4EiF4aNndmOGnBiHZ6BGwEra1BaD4UW7OyFTC3eRyHDf4M4eGzKm0H6UT6M6oTUHtP9lYUi1vrdVbLmPDkFwlQmpKlLKTGqX7J3OynfKVHJe187E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFRsp9Uk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E70C4CEF5;
	Thu,  6 Nov 2025 01:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762393836;
	bh=wGy4wxbUQN1YaW0iCAIn0riEXTI+ZBdSIFYYqdtLvHc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lFRsp9UkqrdmqrKtKxkjKkkRNrKjm3ZHHYC5SLYz9T06ERAk6YYI2DBY/NecytMRd
	 pqirhM+/pwSIMtTs+GeLCyGuac2zLyXtA5HXRPTotlcvgfGqoNz5Bw52qAdir2+FVh
	 t6S4no7iyYLfWcKYi3QxCCguCYD8hgwI5jQLsQLb6WDNwCfRiY+BR4Jw+zds0qXOWN
	 sEl89gwDO6Iz7cdjgdbba0vg3W4gPIAeA3oAAznTYza3FmJKRyaFEAT2JawzW55sLK
	 95v14xwFmQQqDUwC8Q7fpihNsJa4iw8YZEKf4Pr/8NxG6QH+CQgx0BiwXtRkluPlNY
	 AqyiYu5UCLoBg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B69380AAF5;
	Thu,  6 Nov 2025 01:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] libie: depend on DEBUG_FS when building LIBIE_FWLOG
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176239381000.3828781.16751641669430714565.git-patchwork-notify@kernel.org>
Date: Thu, 06 Nov 2025 01:50:10 +0000
References: <20251104172333.752445-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20251104172333.752445-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 michal.swiatkowski@linux.intel.com, aleksander.lobakin@intel.com,
 jacob.e.keller@intel.com, horms@kernel.org, linux@roeck-us.net,
 aleksandr.loktionov@intel.com, sx.rinitha@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  4 Nov 2025 09:23:31 -0800 you wrote:
> From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> 
> LIBIE_FWLOG is unusable without DEBUG_FS. Mark it in Kconfig.
> 
> Fix build error on ixgbe when DEBUG_FS is not set. To not add another
> layer of #if IS_ENABLED(LIBIE_FWLOG) in ixgbe fwlog code define debugfs
> dentry even when DEBUG_FS isn't enabled. In this case the dummy
> functions of LIBIE_FWLOG will be used, so not initialized dentry isn't a
> problem.
> 
> [...]

Here is the summary with links:
  - [net] libie: depend on DEBUG_FS when building LIBIE_FWLOG
    https://git.kernel.org/netdev/net/c/b1d16f7c0063

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



