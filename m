Return-Path: <netdev+bounces-169679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 257D2A453D0
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 04:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04B5A3B1B9F
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 03:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C5222578A;
	Wed, 26 Feb 2025 03:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8l43LiX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EA522576E;
	Wed, 26 Feb 2025 03:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740539409; cv=none; b=R2A1pEnS0pqx2sApzN8WaFrdx0ERr0q6IQsgplwzwSuqWvCs5FO/DhhUdIGJzIrV5TZx3jJLFhlIp4UKy2gCawqCszJUIThijV2KCUh8KUdieQ3m9ZlZ0vV0iOSz/Jvx0bV5gLOMml8H99A7UzKpFRPNFw67La8Lrp2ibpgj2GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740539409; c=relaxed/simple;
	bh=PB6vDI0pNLawaK0/VTKCfZhlobFTvQHOsS7pDJob7v4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DQP/TadZrGgyuw4v3vSTgRG9TfXw/3VxXs6GUd2V322eSm85shBXehhDcN4ftbWoT4+V/1yMTRj8fJewHv1KlcHYPlMpgsd6Hd2lmJStYSxAZ5ziI7Sb65IDUjqZ4nG3B6KQtCtsMD1RZmEHuDkXMYzE5mUKXCzLWNIXN75ey10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8l43LiX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80BE1C4CED6;
	Wed, 26 Feb 2025 03:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740539408;
	bh=PB6vDI0pNLawaK0/VTKCfZhlobFTvQHOsS7pDJob7v4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k8l43LiX7JvyZoXDr0WLRcPJmovITlK6r5tAE0axkXhbAjMgr2Qe+w6LB6SXS+ze9
	 2XTCSR9N3FCweoYIu3/RL4hztxnUakaWTPYTFhzoHY2xo78tTgPTj8AnXTtjamb9yB
	 CGgNOu0udRgv2VwOtKscIgQLH8lzGPmI7+JbqpM0OIIY1AlCx6BVwrKO50/LV2Esov
	 xx4eNwBtf6EPyOP0JaIdT+Lcxa4i1Y6H62w7+Mw0vEH+9oH5srbdcNWOk5sr9Z6yk6
	 PDkcKowtVaqR6nXvNX5DgOhnndffoqdAFg9J7tbnUmlGklrJYFS6Bgq2Ff/N13aHFY
	 8/yDz+UD3Qwqg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E39380CFDD;
	Wed, 26 Feb 2025 03:10:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1 1/1] drivers: net: xgene: Don't use "proxy"
 headers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174053943999.217003.8623321212324575821.git-patchwork-notify@kernel.org>
Date: Wed, 26 Feb 2025 03:10:39 +0000
References: <20250224120037.3801609-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20250224120037.3801609-1-andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 iyappan@os.amperecomputing.com, keyur@os.amperecomputing.com,
 quan@os.amperecomputing.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 24 Feb 2025 14:00:37 +0200 you wrote:
> Update header inclusions to follow IWYU (Include What You Use)
> principle.
> 
> In this case replace *gpio.h, which are subject to remove by the GPIOLIB
> subsystem, with the respective headers that are being used by the driver.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v1,1/1] drivers: net: xgene: Don't use "proxy" headers
    https://git.kernel.org/netdev/net-next/c/ad530283d3c8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



