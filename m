Return-Path: <netdev+bounces-190828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E46AB9013
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 21:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 181D81BC7E5F
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 19:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA048297106;
	Thu, 15 May 2025 19:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPp2Vq/N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42E1296FD8
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 19:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747337997; cv=none; b=c/OIsmGTrwiQzDCjPILkw7mgEWVQJziDNwvOMNVW2B9WfvflJ/Fwbm/mB8Q+J8ZBunGF5B/yEpn4SNWk2ynE6TPYZfzEhVcspvhRVZ+IS842JImtDXCup75QDo6LcnFJnq/XCJB3OUmVQ9hITCIXY/LusQ/Mx1EDtMQd0fcQvcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747337997; c=relaxed/simple;
	bh=ZnOOfOZqwQybKUV5Qzz799X/t9k3ND0HMJfrY9A+WVE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jNEE6CvkETusgKt4P0P13EXFUjhjdKJ3adGMh5dsDua57mHgNUxB3tbMfGnvApt3wqF2MxlQWqNRa30FI4oI3iOHT7ZJ2rBLpnKz2jfGneMn+dMK3/3ca99yfrFlvbLgpnVBwX78+xQohKB0F6MFS2bRceyEFxzPSCmRt0ZLvsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPp2Vq/N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B53C4CEE7;
	Thu, 15 May 2025 19:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747337997;
	bh=ZnOOfOZqwQybKUV5Qzz799X/t9k3ND0HMJfrY9A+WVE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bPp2Vq/NIGIU+GA0GTmBKJAtqLZkH30ybjquckR+98F9b0lTvKSqGSB6f+0HctiJ+
	 JucTG73Gulpf4w59kNoLAApdri505MciiZXcruKgcR7GnCeNfTN+w4wt9odMqD5TSQ
	 2yYuitGmt/fVEoGTmcnQTmonvI6b4pICXUP78taCCXXrqefQcqE7DJvaBXqu5SxwPK
	 uUZOtRriqa+1PPvJA+nwti5uI+yBODf8kma8zKV5TfPM784qUy3ZRMl4m63z6X41Lr
	 Pk9ayPQALsXR0FVDNXHj3bId6jcDeod6mcebU7Kp+SKKXK4oXiJw4gPmusY+OCfOyw
	 42aNBtNHEDSSw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 72E063806659;
	Thu, 15 May 2025 19:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: sched: uapi: add more sanely named duplicate
 defines
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174733803426.3226926.4429765858363830717.git-patchwork-notify@kernel.org>
Date: Thu, 15 May 2025 19:40:34 +0000
References: <20250513221752.843102-1-kuba@kernel.org>
In-Reply-To: <20250513221752.843102-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 13 May 2025 15:17:52 -0700 you wrote:
> The TCA_FLOWER_KEY_CFM enum has a UNSPEC and MAX with _OPT
> in the name, but the real attributes don't. Add a MAX that
> more reasonably matches the attrs.
> 
> The PAD in TCA_TAPRIO is the only attr which doesn't have
> _ATTR in it, perhaps signifying that it's not a real attr?
> If so interesting idea in abstract but it makes codegen painful.
> 
> [...]

Here is the summary with links:
  - [net-next] net: sched: uapi: add more sanely named duplicate defines
    https://git.kernel.org/netdev/net-next/c/1119e5519dcd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



