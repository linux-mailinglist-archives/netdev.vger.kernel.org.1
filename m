Return-Path: <netdev+bounces-134735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CE699AF1B
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 01:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 401111F21E18
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 23:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44BA1E203A;
	Fri, 11 Oct 2024 23:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRHS/pN4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CC61EBA19
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 23:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728688245; cv=none; b=a5jkZE/KpNolq1+TzL9GYQcm+Gx7DzLaBuB/I5pdiVHSC7ACNotm/2X7FKOI5fUB2h1wtbF/EFTypZSGIdppls0OEjm3heVLVzoPPyX4Hwt11tco7f82gxfSz6PjHqdt/lYYasWV7IrxcAyO5h1JbR6ANi+92noFOBkD3b2aLTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728688245; c=relaxed/simple;
	bh=kWiRdjYlf6NZWenRENn98xXzKIXf8Jr6JERuiC4B/3k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Va/eP0N750Krm+gFpVplvCrhVt9J1ju1bA+2ehykzWftJfRY3Icez2AVUg1BPUEt0tqyZvELtLON+alS8T5U9tiOGPMKnUoS/IMmIpNYsgs8zBSpAvjQ6MMBvNRMxDrT17yqSPUBixWWpPfUkQhl9aquc3JXJKXC1Fh+wFVHCj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PRHS/pN4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E29C4CECC;
	Fri, 11 Oct 2024 23:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728688245;
	bh=kWiRdjYlf6NZWenRENn98xXzKIXf8Jr6JERuiC4B/3k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PRHS/pN4bN4eSptFgV4YGyNTPFc1ID1ggJKfVFrABBzf03peqWGTe8BYP8ORlGMkm
	 IwNqNpqkBu/e4HFBH93HKnulyX6Sv/1wbIt/uiDOtB8Iih3v6YRgGIlZBXvylwTt+4
	 h2oLaQvIGEp+lt7XiZ9lFLBADDeAQ0W/4VmO0cPyMG5EF8IlOwF2HTsxQoYux3PL4z
	 PDVXoz7AIOg2vjHxzSd62Jawh6F2yU8Oclp+Jr1fb0DrpFTbOkloSIo8zo14cpKhRT
	 k4Kk6T+WxzPMi/tpZ7xmQ/TygyBINo81VjR3w8MmCn1qEkc+s9DKTsPUuRSKf5kr1/
	 BeDmIIg0Wa8GQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E6938363CB;
	Fri, 11 Oct 2024 23:10:51 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: broadcom: remove select MII from brcmstb
 Ethernet drivers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172868824974.3022673.14064722793171663750.git-patchwork-notify@kernel.org>
Date: Fri, 11 Oct 2024 23:10:49 +0000
References: <20241010191332.1074642-1-justin.chen@broadcom.com>
In-Reply-To: <20241010191332.1074642-1-justin.chen@broadcom.com>
To: Justin Chen <justin.chen@broadcom.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net,
 bcm-kernel-feedback-list@broadcom.com, florian.fainelli@broadcom.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 10 Oct 2024 12:13:32 -0700 you wrote:
> The MII driver isn't used by brcmstb Ethernet drivers. Remove it
> from the BCMASP, GENET, and SYSTEMPORT drivers.
> 
> Signed-off-by: Justin Chen <justin.chen@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/Kconfig | 3 ---
>  1 file changed, 3 deletions(-)

Here is the summary with links:
  - [net-next] net: broadcom: remove select MII from brcmstb Ethernet drivers
    https://git.kernel.org/netdev/net-next/c/ea22f8eabb56

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



