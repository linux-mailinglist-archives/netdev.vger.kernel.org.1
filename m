Return-Path: <netdev+bounces-53688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 258E18041D9
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 23:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF7B91F21372
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 22:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFAA224FC;
	Mon,  4 Dec 2023 22:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YjX5r9Pl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178291D6A1
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 22:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B5B6C433C9;
	Mon,  4 Dec 2023 22:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701730225;
	bh=QGdCy53dpBoXwpOTn1fzq/6AzIM9jfyODUSlYtXYiPI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YjX5r9PlN3KR6B/WJmYhNEs7cfelQEAJAoeryzTB+YxchIiSjV1t2fh5ajdYM6TXI
	 TR6O9sQ5XX0bVPxRdlp8WGV+pD8cdnEy4DccdDZG1SNaYCVHS5j3oangUtJGNI59nv
	 fjeHbJP4OiWmHPEn1+1iC0Lx644w7SXA0LAmqROifDWNVx8DsIJPwYRF0lyyvVWl6s
	 DL+I1x+0/Fni24zeC8CRxqX2dC7mOZ6G0MHI7oOO0ggYJEeB8+3Z+baxFLY4lOFMlU
	 WoG2tpCebZ/wK1E900G5xZRwLiBXdsdPRPTA41F51dv2GTDEsMixNTejmMJjShczia
	 67rDATB7qmanA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 62725DD4EF0;
	Mon,  4 Dec 2023 22:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [patch net-next v3] docs: netlink: add NLMSG_DONE message format for
 doit actions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170173022539.15217.2090873563216958878.git-patchwork-notify@kernel.org>
Date: Mon, 04 Dec 2023 22:50:25 +0000
References: <20231201180154.864007-1-jiri@resnulli.us>
In-Reply-To: <20231201180154.864007-1-jiri@resnulli.us>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com, corbet@lwn.net

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  1 Dec 2023 19:01:54 +0100 you wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> In case NLMSG_DONE message is sent as a reply to doit action, multiple
> kernel implementation do not send anything else than struct nlmsghdr.
> Add this note to the Netlink intro documentation.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v3] docs: netlink: add NLMSG_DONE message format for doit actions
    https://git.kernel.org/netdev/net-next/c/8ad55b1e73c4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



