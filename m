Return-Path: <netdev+bounces-139846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CAC9B471A
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 11:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 235CF1C227B0
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 10:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D69A205149;
	Tue, 29 Oct 2024 10:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nsdt7OcO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A33205144;
	Tue, 29 Oct 2024 10:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730198428; cv=none; b=RPHtuWBAzWMfe8/1uCuOv6OJPEw2BMQl0ZxhFfWWGJbc606PLTI9zeJZrxIxLO6Buyz+MGDsMKTlt1XaySg4X9Y6vulFG8mhttOiXQ4G6+GZzymuHLe4kKnvHB+MAmjmzrY/T6s5JeJxI7lPRC81eRoYb8ccc0STlm5Y6Dks1b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730198428; c=relaxed/simple;
	bh=1JvLk+JmMjL4BEVxEEBMpEnuqvbzUhXpMLNDkXAnUWI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hUjO3K8JNr+8pcSmLlTDpO7dAgHP1mZylLnqFPSkWcnxr6kZtEbsXZPWC5skp97DuGuOFGCPxF9h0FBcuSylHf0/PO+XYcXLwe4Lj7ehq70h+wbQrU3yNDGR0+NwfBYxtA1jvd5F7YGk5LC/jFYkyCRcrapXt7zVydF+GZrSzkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nsdt7OcO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A07C4CECD;
	Tue, 29 Oct 2024 10:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730198425;
	bh=1JvLk+JmMjL4BEVxEEBMpEnuqvbzUhXpMLNDkXAnUWI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nsdt7OcOL6peUHPQPHbspMs8n4Unx5gCXhSkbnR2iPBFaDXoubqURHdyLMZRXVIJm
	 ZFcv81eTk6YctjvxfhTgLMw2qGzeVJ78hvu6bUmPpO1WsQV/iBsOL6rSeOMcNijDmF
	 TQr1NqasHcZ1jfnZUwI2iz963K1TOcuUu0V+lhSd8RzfuAT4BLzZv3WQwBvc8ywXI/
	 5JfcC7Y4WInO69Arbld8UFAQye92B1zYAw/bns7SyDGBCIaT8FVkPqDQDem4v+A921
	 CKejzKtOHNGlDtCIAEWJj+9yli7InumZNWnuQ7GyxnlmqJ98L0GW1J/0fuF1UbCufM
	 FPuwWYEjOQKkQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E8C380AC00;
	Tue, 29 Oct 2024 10:40:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: stmmac: dwmac4: Fix high address display by
 updating reg_space[] from register values
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173019843274.651132.6305065686659319919.git-patchwork-notify@kernel.org>
Date: Tue, 29 Oct 2024 10:40:32 +0000
References: <20241021054625.1791965-1-leyfoon.tan@starfivetech.com>
In-Reply-To: <20241021054625.1791965-1-leyfoon.tan@starfivetech.com>
To: Ley Foon Tan <leyfoon.tan@starfivetech.com>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, lftan.linux@gmai.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 21 Oct 2024 13:46:25 +0800 you wrote:
> The high address will display as 0 if the driver does not set the
> reg_space[]. To fix this, read the high address registers and
> update the reg_space[] accordingly.
> 
> Fixes: fbf68229ffe7 ("net: stmmac: unify registers dumps methods")
> Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> 
> [...]

Here is the summary with links:
  - [net,v3] net: stmmac: dwmac4: Fix high address display by updating reg_space[] from register values
    https://git.kernel.org/netdev/net/c/f84ef58e5532

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



