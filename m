Return-Path: <netdev+bounces-75950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 353D086BC55
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 00:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B74B1C21B9D
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 23:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E4672939;
	Wed, 28 Feb 2024 23:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G52XFLk+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9E472936
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 23:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709164232; cv=none; b=IJAPQRVif/vLG0WehVqCY+pbeOMA+lGQNpsPwpNY/Jx+40WwHaQ/w1Burt3m7xggBqfbRBZdeLaeu2CtMwjVgmWDvJre8CowokTBwgWqFw6ZHQ15IRmcCf0Gtfr2Wc4FumcHyPoMV2ruHtV0W6Qm4ANxhiCZbJY7nsiZVyTVr5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709164232; c=relaxed/simple;
	bh=32q3t22EwdEppRZ0P4/vBZUM8Y7HZi4BWKkQ9mbr/ao=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dCv6R0K7Z93A2HmgoLNXC99P4jFqe9Smaa++Vxx1cRzUWQUpsM3jLPhvqDZkffrGUs257HKb8y+JaH5ywLVsNhvMfPBXeoXGvTVlIqhFtTIWU9N0NggeAO1rgyPoZ3aSKl+oxHm5TkApyu39lMjpGKz1N81qTdpOp7nJINHEjIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G52XFLk+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54B71C433A6;
	Wed, 28 Feb 2024 23:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709164232;
	bh=32q3t22EwdEppRZ0P4/vBZUM8Y7HZi4BWKkQ9mbr/ao=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=G52XFLk+TNm2lvjAkQRfPzEhRimjlgBKS7RSFLy5YicgVQuWkfe7i9/of8COE/Ok7
	 NfTamDNFpTagNVHwB+rFDBZQL1mv9AOy7FzlTAzqlsoXialXOO8leflCCerRJ4i2y+
	 s7D+/iyr+Td9gqUv4MHMzTo8MvKhOtkfD80H4agzDA7I9dj43yydwgT96p7CXi3w5e
	 mAatFBZHhHwE/2RWQ/qROyUVOZcRwA9imLI/Ax2RQWGW4RKj9ZqPiKSaE18bbrYRIS
	 g2cU+0RbKH6NROdIKFDlNc8K/qy09r+1QtsnrpLCYZe6Z2zXd2jnMOdX3/rkQKZN/a
	 gheVyAUq/eIyQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3658FD84BBA;
	Wed, 28 Feb 2024 23:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tools: ynl: protect from old OvS headers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170916423221.30546.10196817109950723585.git-patchwork-notify@kernel.org>
Date: Wed, 28 Feb 2024 23:50:32 +0000
References: <20240226225806.1301152-1-kuba@kernel.org>
In-Reply-To: <20240226225806.1301152-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, jiri@resnulli.us

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 26 Feb 2024 14:58:06 -0800 you wrote:
> Since commit 7c59c9c8f202 ("tools: ynl: generate code for ovs families")
> we need relatively recent OvS headers to get YNL to compile.
> Add the direct include workaround to fix compilation on less
> up-to-date OSes like CentOS 9.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] tools: ynl: protect from old OvS headers
    https://git.kernel.org/netdev/net-next/c/3bfe90527d63

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



