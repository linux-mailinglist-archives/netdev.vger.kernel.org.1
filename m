Return-Path: <netdev+bounces-83135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B6E891028
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 02:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E03301F282BB
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 01:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2502512B83;
	Fri, 29 Mar 2024 01:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="isaHxLrb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0122E11720
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 01:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711674711; cv=none; b=r/9ded+Dje3rrnjopTtVvApl2Ci4ljjN7mnyV6ZROgNY+Tyu6jCIH21gi676zwrml1rKZURmiTxt2nDf42c72FNxxhhQSdQJr1YKGrSgynl4JDOGgRAygjQT4qYP/5Qsa1Cr5YZg8j5/hWUzAOyL5UuoWpgxtpnm9GVvQDllu9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711674711; c=relaxed/simple;
	bh=eNot05C6SBw9+CZh/rzn/KwYPL9cnerMuPg3a/1QOJo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eGsCQB53SWP8HDihvgxWBjT7Z6KHN9Y8U6q2ofDfwEYAG9JX/xfjGhaXdV3Vqg+JbbLkuE9c5UkK/n7q4WAklwbI2MDUckn4CbTTlpO7eySR5ibmgVwhtrhsnesAM/k0YlGFgV0ZcaL2q32fNb/iRfK/Gkt7nDK2Lr3uhaP7ges=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=isaHxLrb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8EF82C43394;
	Fri, 29 Mar 2024 01:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711674710;
	bh=eNot05C6SBw9+CZh/rzn/KwYPL9cnerMuPg3a/1QOJo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=isaHxLrbvEQ81ufM+aubh5bvjM2C/EBdYiQT6HXC02a/26AYuyHFAvkTpYOqnqp3O
	 DbmtOV/fTUWG74LYZMyhGrJpEjimO1PXYmqkbOYmWppY8FvYi2qcTfUeP2bGBFxrAx
	 jfYAuCFlILFYdUk0xxztXQYoxcIdmfnE6AOYcDGCx3jW/J/wVHWA4V1QaYt7/IOnTg
	 eusDibMlzcuzdHqVG3V3A2JqHHT9KUIP6vPmAoemY6kaN+itlZVlSKHH8zKLD1+Hll
	 /Gu9Ruf1RpRjaOfLLgzs35FrNwOHwJOHTldeHRMbWaZnhI/TRLpqtHlpkpqe6+QQh+
	 ZE0jjM/hsCyIw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7F4B2D95054;
	Fri, 29 Mar 2024 01:11:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv3 net-next 0/2] doc/netlink/specs: Add vlan support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171167471051.20385.16149210851709967859.git-patchwork-notify@kernel.org>
Date: Fri, 29 Mar 2024 01:11:50 +0000
References: <20240327123130.1322921-1-liuhangbin@gmail.com>
In-Reply-To: <20240327123130.1322921-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, donald.hunter@gmail.com,
 jiri@resnulli.us, jacob.e.keller@intel.com, sdf@google.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 27 Mar 2024 20:31:27 +0800 you wrote:
> Add vlan support in rt_link spec.
> 
> Hangbin Liu (2):
>   ynl: support hex display_hint for integer
>   doc/netlink/specs: Add vlan attr in rt_link spec
> 
>  Documentation/netlink/specs/rt_link.yaml | 80 +++++++++++++++++++++++-
>  tools/net/ynl/lib/ynl.py                 |  5 +-
>  2 files changed, 82 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [PATCHv3,net-next,1/2] ynl: support hex display_hint for integer
    https://git.kernel.org/netdev/net-next/c/b334f5ed3d91
  - [PATCHv3,net-next,2/2] doc/netlink/specs: Add vlan attr in rt_link spec
    https://git.kernel.org/netdev/net-next/c/782c1084b9fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



