Return-Path: <netdev+bounces-49673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 461447F30C0
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 15:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F18B1282E2A
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 14:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C35495D8;
	Tue, 21 Nov 2023 14:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGf/eIUy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5AF55C0E
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 14:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81F93C433CB;
	Tue, 21 Nov 2023 14:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700577023;
	bh=y3EgkpzVhAJbfOnHX3NX+wjTSHiThYWcTql7eFMRclI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WGf/eIUy60U4PhHwjaAOchWc8+zivHa+x3l+kmKc1wb88IuWpug/FC5iPcmbOCS0n
	 oAM+LQ2qaL0KF7HorTs+naRKxLiIC7HJ4NqUHsVp+YEzkZoVBj2jj92PYqy/7fP7YJ
	 kpSOuxvOkClCbsxCgJ2uTGkVeBogVchOZyYGF1/86QqOdgBhtct4Svw1gZmw7snh/q
	 lXQuOL4JobujoAJ7PL2q3g2M60CJYl4kRf/KlVzPrYEOO7zlJ58SgK1Hr8ayhsz1Qe
	 8LQI+08C2ZH6wjD6qM2Yguw2EFqy12ZdilvMYkwychwvRnXFJMAoNW0+PWkr55m1+B
	 ICk3Q8o/0iMOg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 652D7C595D0;
	Tue, 21 Nov 2023 14:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] MAINTAINERS: Add indirect_call_wrapper.h to
 NETWORKING [GENERAL]
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170057702340.30045.5020855051539791666.git-patchwork-notify@kernel.org>
Date: Tue, 21 Nov 2023 14:30:23 +0000
References: <20231120-indirect_call_wrapper-maintainer-v1-1-0a6bb1f7363e@kernel.org>
In-Reply-To: <20231120-indirect_call_wrapper-maintainer-v1-1-0a6bb1f7363e@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 20 Nov 2023 08:28:40 +0000 you wrote:
> indirect_call_wrapper.h  is not, strictly speaking, networking specific.
> However, it's git history indicates that in practice changes go through
> netdev and thus the netdev maintainers have effectively been taking
> responsibility for it.
> 
> Formalise this by adding it to the NETWORKING [GENERAL] section in the
> MAINTAINERS file.
> 
> [...]

Here is the summary with links:
  - [net-next] MAINTAINERS: Add indirect_call_wrapper.h to NETWORKING [GENERAL]
    https://git.kernel.org/netdev/net/c/9c6dc13106f2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



