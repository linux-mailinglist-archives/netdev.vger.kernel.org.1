Return-Path: <netdev+bounces-39570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D94347BFD80
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 15:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 913F72819EA
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 13:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228749CA57;
	Tue, 10 Oct 2023 13:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4M/273T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0289347376
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 13:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8637AC433CB;
	Tue, 10 Oct 2023 13:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696944624;
	bh=wigO+3xOgrzmFjR5/UUzlIPFd7xNBIa7HZmujH1Ioc4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=O4M/273TXoT62rX9G5TRoM0IkrAju1zYqw6DggvTPUG+8Eb/+JWhjQ/47MS9EHKlF
	 6bkMIbuwPSgue2ZE/EBaEZns+faJcvKnxOl26UU5x5w6oUjn5uhm3GrmwTK4zdsn5e
	 M0lyV+7RFTq08DQAdYo2/iABp7O8CRshGnCpyIdbeLgnCLoA5DIvKN1XC2oOE02TTm
	 ugBpST1OJGozMjUZD8a3HfUIFJgciY1u9+9BlQFDwJcB+pUAyqLv8Tdfoe9xot/z6o
	 rjZXM7KyEjzneeYXrBJprXC6hFgTMVSlY6JHQx+wUiUyHnvOpB60Edi1R5uMorhrje
	 zG2vZ3BnkEE5A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 66E25C595C4;
	Tue, 10 Oct 2023 13:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net/mlx5e: Again mutually exclude RX-FCS and
 RX-port-timestamp
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169694462441.9717.9210751082790538556.git-patchwork-notify@kernel.org>
Date: Tue, 10 Oct 2023 13:30:24 +0000
References: <20231006053706.514618-1-will@extrahop.com>
In-Reply-To: <20231006053706.514618-1-will@extrahop.com>
To: Will Mortensen <will@extrahop.com>
Cc: netdev@vger.kernel.org, charlotte@extrahop.com, afaris@nvidia.com,
 ayal@nvidia.com, tariqt@nvidia.com, moshe@nvidia.com, saeedm@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu,  5 Oct 2023 22:37:06 -0700 you wrote:
> Commit 1e66220948df8 ("net/mlx5e: Update rx ring hw mtu upon each rx-fcs
> flag change") seems to have accidentally inverted the logic added in
> commit 0bc73ad46a76 ("net/mlx5e: Mutually exclude RX-FCS and
> RX-port-timestamp").
> 
> The impact of this is a little unclear since it seems the FCS scattered
> with RX-FCS is (usually?) correct regardless.
> 
> [...]

Here is the summary with links:
  - net/mlx5e: Again mutually exclude RX-FCS and RX-port-timestamp
    https://git.kernel.org/netdev/net/c/da6192ca72d5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



