Return-Path: <netdev+bounces-13349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F45F73B514
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 12:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C10671C2105C
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 10:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8AB610D;
	Fri, 23 Jun 2023 10:20:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBE35694
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 10:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 096ABC433C9;
	Fri, 23 Jun 2023 10:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687515621;
	bh=0G4VLzTwApRcDkGPRDhlojw0Eo5X0jKO6ZzUVDxIObY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m8pI2SWIcB9SbcC3pdSlMHA+8Vff6xrOzA2M7NtUyoJ9JlN4SsU+FiAkqCPUf52FF
	 FiyYZgEV/wuXx6pgQJT+kkG2mKVE0/ZpvK8XEne/M0ko7Xf4viQZnIXDUhlH+hJoQJ
	 aCy/GMvs7XvuwVaANTzvHnULYp0DXa0db4oy15uzEmFtNEWKcxVkabSV/gV2bouXf5
	 5wBwZKyQHJY2PW94Y1+6WWV2zElJ82onnl7fse4V3sNVg3U877RtoKnsB5xD87Plz3
	 LF+9QZbkJPGK34JN06D53l1U/NkCY6wf55e+4VVQMUPvUq/m76h8Yy9AULOpMzWp1t
	 m+fQMXs4bX0Xg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DBD8EC43143;
	Fri, 23 Jun 2023 10:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/4] s390/net: updates 2023-06-10
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168751562089.32220.265545719667206181.git-patchwork-notify@kernel.org>
Date: Fri, 23 Jun 2023 10:20:20 +0000
References: <20230621134921.904217-1-wintera@linux.ibm.com>
In-Reply-To: <20230621134921.904217-1-wintera@linux.ibm.com>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 hca@linux.ibm.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 21 Jun 2023 15:49:17 +0200 you wrote:
> Please apply the following patch series for s390's ctcm and lcs drivers
> to netdev's net-next tree.
> 
> Just maintenance patches, no functional changes.
> 
> Thanks,
> Alexandra
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/4] s390/lcs: Convert sysfs sprintf to sysfs_emit
    https://git.kernel.org/netdev/net-next/c/d3f0c7fa0993
  - [net-next,v2,2/4] s390/lcs: Convert sprintf to scnprintf
    https://git.kernel.org/netdev/net-next/c/1a079f3e9529
  - [net-next,v2,3/4] s390/ctcm: Convert sysfs sprintf to sysfs_emit
    https://git.kernel.org/netdev/net-next/c/d585e4b74806
  - [net-next,v2,4/4] s390/ctcm: Convert sprintf/snprintf to scnprintf
    https://git.kernel.org/netdev/net-next/c/1471d85ffba7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



