Return-Path: <netdev+bounces-66076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1029B83D27B
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 03:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2076285BC3
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 02:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382408C01;
	Fri, 26 Jan 2024 02:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="suxbKIO4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132728BF3
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 02:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706235625; cv=none; b=LnEcQ5mc7T94alC4YE6DGaSvH0WxlsFHthYRhr7DJEqo0XNcaGxS0N2mngXmoTbKoJha6PPMmGUnyhwqjuCU/yRdRgkM6tMYb1+e/T6wNEeIAKYzjoO4PzsgqnmVKXkWVP0GDRvM0x3eumoUgdgIVxmAUAdBM375myJBrwLhS5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706235625; c=relaxed/simple;
	bh=eP+p/DmWAnVbSOV+4kVrZm+VluXUVkbb9XtJQZz4biA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u0nGdXDE1kbXraADIqpTKT/gEuWP9rqsflKhPnc19pOEXqitHghx0S0K44cjZ+wPduvbgSW8nRuopef0qE7Veex4z7YmnTZ06l9vAzEbGpErYMvv5kDT4VA0+PJruKV4cGv34eOr8/DII1iExRnmhbPkzY6VoS9xsaEY5ubxXQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=suxbKIO4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B819C433B2;
	Fri, 26 Jan 2024 02:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706235624;
	bh=eP+p/DmWAnVbSOV+4kVrZm+VluXUVkbb9XtJQZz4biA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=suxbKIO49y5QS9aHE1kcYRXzR0XZ2nl/CHR/HMbvWCz7qH/dx/atT6YZfyJfm7ugT
	 K4mGxWd1yB5k/3dZrR3gz/Nw0tYLFh84tB/su+SP0lDQvmwsfhA+TdQeQVASvpVk3n
	 YPFQWIkRYCyj/Nl/ppcc7FH3ErQTLPqoCHX1oUzb0UFKCcEo8x0K3aj5NTtwIDN9lB
	 k3GGeI4bFH63wNjrozwTzmuf6InwN7gxuxppjUDNxcsF26D8YNEipOnHT/sq/X/PyH
	 FLncky4I3yBixnN7JA/nYNVfc5HLm/rkjrO1ys43qJJov+qza200GQ0niJAtl15oTR
	 /YfrjQ4UQAuWA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 78277DFF765;
	Fri, 26 Jan 2024 02:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tsnep: Add link down PHY loopback support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170623562448.30678.17765943047613405864.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jan 2024 02:20:24 +0000
References: <20240123200151.60848-1-gerhard@engleder-embedded.com>
In-Reply-To: <20240123200151.60848-1-gerhard@engleder-embedded.com>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 23 Jan 2024 21:01:51 +0100 you wrote:
> PHY loopback turns off link state change signalling. Therefore, the
> loopback only works if the link is already up before the PHY loopback is
> activated.
> 
> Ensure that PHY loopback works even if the link is not already up during
> activation by calling netif_carrier_on() explicitly.
> 
> [...]

Here is the summary with links:
  - [net-next] tsnep: Add link down PHY loopback support
    https://git.kernel.org/netdev/net-next/c/5f76499fb541

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



