Return-Path: <netdev+bounces-196729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EED4CAD614C
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 23:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F1747A47DF
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 21:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8270A234971;
	Wed, 11 Jun 2025 21:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPpT9nIp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599191DFF7;
	Wed, 11 Jun 2025 21:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749677399; cv=none; b=qw/MtJlf//wLqh4E/ZGT27X2kR+dWWzRPMPTtQsgdEW2YHUM+4/gWDT21Zn7F59iM0Jg4hkxSIS4ZV63VkmBZqYsnRB2c2MmT+PjbcF/eqtCa/Lu6rUdlpI2CWE2AhMhMMMMxPKj/CgCNQcMmc0u3cFVJm+Pp8HR+JeQjIaLccI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749677399; c=relaxed/simple;
	bh=PMlU9LLyEqlcFL6ggXBd+aNIgUGhBQRpYs6zgASZ7Yw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TYhoo1MpFu7VrsJMBl/6F/L0WHpMNoEi5eGOjvydFOphhTOf2+4CXbOyN8ZnVAegkRuv4QA7bVOeNx+H7RaThBoJfqrMw85V/lENf1ITeBWNsS9yISfBUrOmw3TmQ42P2aOPDHG5ICiz0Lor/Q5Gz+o0kb5oqfrTVMsu6mJCMcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPpT9nIp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D487EC4CEE3;
	Wed, 11 Jun 2025 21:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749677398;
	bh=PMlU9LLyEqlcFL6ggXBd+aNIgUGhBQRpYs6zgASZ7Yw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RPpT9nIpvf51BZxucOa6mowC28lp3tWTGf9ftPEESybSFAABfsmizyfy5/BSwnW4p
	 STimnxd6fyxnUadK0zsiWSRTDyzUyjfAY8/nKUKtVCESgLtKyB80uDn2b9wJRHP2EQ
	 +C/lBEFnyxarVHHTGq9kJ9OITjBJNzW9bL2cLOk40/6wQKWIKt9uxvjtxwE1kHJM28
	 uUoOMi/vfce648HAvOmeDfdYFBiIouKNyhhLJbYZlHbut7Pwf5+x+XOWdCQ3+Zq6Bc
	 UU8tKctRKZ1GKl9GTwcbnj2voLdly6OmyoBH2Mc5QtVVhpWNI0wKHr7gVRos6/rFk+
	 30vc4K/bsZQuw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33AFF380DBE9;
	Wed, 11 Jun 2025 21:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] net: usb: lan78xx: make struct fphy_status
 static
 const
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174967742900.3492087.9037933414056575160.git-patchwork-notify@kernel.org>
Date: Wed, 11 Jun 2025 21:30:29 +0000
References: <0890f92e-a03d-4aa7-8bc8-94123d253f22@gmail.com>
In-Reply-To: <0890f92e-a03d-4aa7-8bc8-94123d253f22@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Thangaraj.S@microchip.com, Rengarajan.S@microchip.com,
 UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch, pabeni@redhat.com,
 edumazet@google.com, kuba@kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Jun 2025 22:58:15 +0200 you wrote:
> Constify variable fphy_status and make it static.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> v2:
> - extend commit message
> 
> [...]

Here is the summary with links:
  - [v2,net-next] net: usb: lan78xx: make struct fphy_status static const
    https://git.kernel.org/netdev/net-next/c/ae4e3334dd05

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



