Return-Path: <netdev+bounces-54532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EEA807654
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 18:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70249282087
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 17:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C7965EC8;
	Wed,  6 Dec 2023 17:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJ3fbUVh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A114861FC4
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 17:17:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33EBDC43395;
	Wed,  6 Dec 2023 17:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701883053;
	bh=4iBwyOzm4+lW4YbkH+lNNusD4beOr9gVF0dZeh3+6oU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NJ3fbUVhaK6hj0BpGFQ1MmgQwTC7yS71nDRS2RuZpuMOoWLNqT9se7nEOy6IvMvbz
	 W3ub/XPBUOEop+qLMn329supf85HXw3e66dTLMlfLveKS6QCBAA11CnMIsfufdv/ag
	 8pA3eaHeAMxtUvX12fGP/501reZbPVihsx6470u8Kazs6R9cC43wt9u8zJc3HkswfD
	 tKMjGW8QnZ1ag+kGQbhW5Bdgr6OI21TL86MNccz2ySzo8da5Z+rwbZfOVPgxg+S5M0
	 yeWb/cxKF1c0nJr3LdidPM+R6b1GHj5UxeI3+zim+CMoajifIUdrW433pPjz/FPfh1
	 kHklJmnFc9svQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1D71CC395DC;
	Wed,  6 Dec 2023 17:17:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2] ip: require RTM_NEWLINK
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170188305311.32642.2704244428398607464.git-patchwork-notify@kernel.org>
Date: Wed, 06 Dec 2023 17:17:33 +0000
References: <20231203182929.9559-1-stephen@networkplumber.org>
In-Reply-To: <20231203182929.9559-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Sun,  3 Dec 2023 10:29:14 -0800 you wrote:
> The kernel support for creating network devices was added back
> in 2007 and iproute2 has been carrying backward compatability
> support since then. After 16 years, it is enough time to
> drop the code.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> 
> [...]

Here is the summary with links:
  - [iproute2] ip: require RTM_NEWLINK
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=6174b7283295

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



