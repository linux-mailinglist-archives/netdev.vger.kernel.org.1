Return-Path: <netdev+bounces-29131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F160D781AC4
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 20:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB8A828175A
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 18:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9475419BDC;
	Sat, 19 Aug 2023 18:34:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829901398
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 18:34:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 198BDC43391;
	Sat, 19 Aug 2023 18:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692470065;
	bh=QNGzG98mypKQMaTOsW3NXvimIsGoIlnFy7pPoMxUQYk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=J5OC1sifnh6JCv3eDhf0wI7+aiPNkEynSXlxZq6kVZUwh1FCM+gr5QYt1bDtG8yvP
	 Zla7jxGB6aBoFq7oO77HAJ80mbPO1wSUalPrtVbu8Du7xu3tZZZ9qLjfycPr0oXyIK
	 X/gHMQ+BXgyfig3DOHarvOQafXFTU/kCJre09SwWnPboP6FJS+ydqaFMXfInEdLXKI
	 WjocKwd8nDHe8c4UWlS00iNMM9vevP4HRdEkXQmDi+F9jne4k8kY2QhXPeBnPAwn+q
	 7ZAxhEU1Eh7CilVC7OGetSQuQoCcU2e1dTKORanmR8tfYVybDCX12OZ3012QIhNZ0U
	 QX5sTvL2DaHaw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 022A0E26D35;
	Sat, 19 Aug 2023 18:34:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [patch net-next] tools: ynl-gen: use temporary file for rendering
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169247006500.18695.7127866054495909220.git-patchwork-notify@kernel.org>
Date: Sat, 19 Aug 2023 18:34:25 +0000
References: <20230818111927.2237134-1-jiri@resnulli.us>
In-Reply-To: <20230818111927.2237134-1-jiri@resnulli.us>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 18 Aug 2023 13:19:27 +0200 you wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Currently any error during render leads to output an empty file.
> That is quite annoying when using tools/net/ynl/ynl-regen.sh
> which git greps files with content of "YNL-GEN.." and therefore ignores
> empty files. So once you fail to regen, you have to checkout the file.
> 
> [...]

Here is the summary with links:
  - [net-next] tools: ynl-gen: use temporary file for rendering
    https://git.kernel.org/netdev/net-next/c/f65f305ae008

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



