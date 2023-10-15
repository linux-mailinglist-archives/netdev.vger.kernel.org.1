Return-Path: <netdev+bounces-41081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7267C992F
	for <lists+netdev@lfdr.de>; Sun, 15 Oct 2023 15:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDE282816FE
	for <lists+netdev@lfdr.de>; Sun, 15 Oct 2023 13:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02446FC8;
	Sun, 15 Oct 2023 13:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="giVEbcTx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCDF6FA6
	for <netdev@vger.kernel.org>; Sun, 15 Oct 2023 13:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3EF85C433CA;
	Sun, 15 Oct 2023 13:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697377223;
	bh=jlQMl8V0cPpM03iOqNyy7WoktBR6yvB2hol+PjBAy4w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=giVEbcTxd/PNeD7rqMjTlOUr3lIw3WjzEMRmz2EDFmg6OD/4zj0JSh4mAt0XYDOXE
	 HmXgKE7HPnFWwcjwGu03RuZTQ1EN/jIl/uDIsgvFtx5Rr+oCnpgJG2s3nZbSHbQK93
	 lTdyRIRw2Fszt28Z3ULbj7oWQm8d1FyYPKoiq3BxVvaL6CumR8qB/2niIt4XifKLfC
	 Pc4EmpYqPzyW3PoBQ3P+h3z+HuB8i8idDCl8+vGtIgi0dlC4WXHfW3F7cPSQ50vjF0
	 3xvJUkgcU/AChHcN2/i06Zys+CjIp0swh9Y5+7dV5B1SONOYyd5jXBexTJ+HhQlZoK
	 4LpFoNxCEgcEA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 264C4C39563;
	Sun, 15 Oct 2023 13:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tg3: Improve PTP TX timestamping logic
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169737722315.30429.4672321534339473993.git-patchwork-notify@kernel.org>
Date: Sun, 15 Oct 2023 13:40:23 +0000
References: <20231013135919.408357-1-pavan.chebbi@broadcom.com>
In-Reply-To: <20231013135919.408357-1-pavan.chebbi@broadcom.com>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 michael.chan@broadcom.com, gospo@broadcom.com, pabeni@redhat.com,
 edumazet@google.com, richardcochran@gmail.com,
 Simon.White@viavisolutions.com, kalesh-anakkur.purayil@broadcom.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 13 Oct 2023 06:59:19 -0700 you wrote:
> When we are trying to timestamp a TX packet, there may be
> occasions when the TX timestamp register is still not
> updated with the latest timestamp even if the timestamp
> packet descriptor is marked as complete.
> This usually happens in cases where the system is under
> stress or flow control is affecting the transmit side.
> 
> [...]

Here is the summary with links:
  - [net-next] tg3: Improve PTP TX timestamping logic
    https://git.kernel.org/netdev/net-next/c/b22f21f7a541

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



