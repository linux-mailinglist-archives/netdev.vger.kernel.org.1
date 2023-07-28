Return-Path: <netdev+bounces-22099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F6C7660E7
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 02:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5C8E282541
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 00:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BF015A7;
	Fri, 28 Jul 2023 00:50:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6DF7C
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 00:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0C926C433C8;
	Fri, 28 Jul 2023 00:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690505422;
	bh=O2Y6YSfR7FXS5zauUb4jQpkQSjoMERIK04J//5qLfmg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qEdsQb0brXocc1tEuQRmBcZINwDKVo6bHmWVUJ9ijzEYPbdapAN5R5nrQll3DWQaI
	 Csn6Tm+9FQtpxfPc7HurAXnr+oCS2ABkveltpddv36DYPpo3uCaM8tYzTf7QfSn/P8
	 ceKDITf/N4H3R7CFMNdmjRfYH0BeQgWHp5Jsb2DmmNLoVvGcUAl2aGyLpiQHb4dJEA
	 1E1cCBJXJeR54uTuRDu1HxsuK+L+Q37IIqBqW2/dpt8STrbMeoc/lQEY9Su0W1BvJs
	 T/URZG6gAunbN2VXYzd6bKSN8j04mWvcdVQVVSi4qwZqTfASMFFwYX2wKhjfDfSQ4j
	 PjKasf1djbj6g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CCE67C4166F;
	Fri, 28 Jul 2023 00:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] MAINTAINERS: stmmac: retire Giuseppe Cavallaro
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169050542183.6763.17482643847107378081.git-patchwork-notify@kernel.org>
Date: Fri, 28 Jul 2023 00:50:21 +0000
References: <20230726151120.1649474-1-kuba@kernel.org>
In-Reply-To: <20230726151120.1649474-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
 joabreu@synopsys.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 26 Jul 2023 08:11:20 -0700 you wrote:
> I tried to get stmmac maintainers to be more active by agreeing with
> them off-list on a review rotation. I pinged Peppe 3 times over 2 weeks
> during his "shift month", no reviews are flowing.
> 
> All the contributions are much appreciated! But stmmac is quite
> active, we need participating maintainers :(
> 
> [...]

Here is the summary with links:
  - [net] MAINTAINERS: stmmac: retire Giuseppe Cavallaro
    https://git.kernel.org/netdev/net/c/fa467226669c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



