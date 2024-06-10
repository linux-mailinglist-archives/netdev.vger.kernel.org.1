Return-Path: <netdev+bounces-102218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9755E901F24
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 12:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3767F1F241CE
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 10:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B22B78297;
	Mon, 10 Jun 2024 10:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JN8nFDEP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771E428EA
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 10:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718014830; cv=none; b=Xipg3pS6krKxM5XvXbzkLlq/iupUAngmRKmWRC1Reh63w6xHkIjjMLlhYn+vcNNs+UtBvvoeu7s6plnEi3zasm7Yl8s5L9cI6OBfel9Hn1cQ/2mncUpeZLRzfiv1lnkM5NaLPJek6/C9O6ZNq0j2EEfGE55+gIdtXyY+QmP2JWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718014830; c=relaxed/simple;
	bh=Wq8/HqlP2x53qPV8K5A9SVAxoDteJ6Zlyp3uQDbz2W0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=El5svdhNzJbkeodBvUK5qrjIoUacyp2vCXh0WjHn3bCyPJos4CE0g2hI33MVkFXeGqMLJvgDBVRYRb6INjrJR/Znczm33n9Hrpka1qyxbyb4Ia5YLyPhPKcu4JF6+P1lCFnNyNeJxecLRI/uQAo2OFPYIKviMVHmmdAjHDxKuqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JN8nFDEP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC407C4AF1D;
	Mon, 10 Jun 2024 10:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718014830;
	bh=Wq8/HqlP2x53qPV8K5A9SVAxoDteJ6Zlyp3uQDbz2W0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JN8nFDEPCBVney1MRnnkN1uWntrK6DPI7CH+j4vSGPjVlWA6y7F0t1+8GkDhmiJng
	 2iyEvDbw43lIhwvDOoShOQU2hmS10GHykpMnSp+MI3IaJ27I2PkVc3nNf/FF1o4awp
	 mIysCmK4Uatxa5JfJ3sbUoY/XaBhqHMFy6fyFZ3lorAlJX5bHjNqwx73aDP/p1VWAT
	 OVM3O+Jvl/xTlnwim3lLsAHgEI4tt7p8kkh7Qp+8ghTdmxfnV7RMScOHL1/OxK9ghT
	 XjMBtubdOiK1vOYK186ILjsIWecQskY00p1Y2vlOWmekhDvL1FaVszVEp2LBJIFHdE
	 Wd+YV9ZhS5tIg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DB33FC595C0;
	Mon, 10 Jun 2024 10:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/6] mlxsw: ACL fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171801482989.31175.7407932740593864967.git-patchwork-notify@kernel.org>
Date: Mon, 10 Jun 2024 10:20:29 +0000
References: <cover.1717684365.git.petrm@nvidia.com>
In-Reply-To: <cover.1717684365.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, amcohen@nvidia.com,
 idosch@nvidia.com, jiri@resnulli.us, green@qrator.net, mlxsw@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 6 Jun 2024 16:49:37 +0200 you wrote:
> Ido Schimmel writes:
> 
> Patches #1-#3 fix various spelling mistakes I noticed while working on
> the code base.
> 
> Patch #4 fixes a general protection fault by bailing out when the error
> occurs and warning.
> 
> [...]

Here is the summary with links:
  - [net,1/6] lib: objagg: Fix spelling
    https://git.kernel.org/netdev/net-next/c/c1e156ae50ee
  - [net,2/6] lib: test_objagg: Fix spelling
    https://git.kernel.org/netdev/net-next/c/2aad28ec4543
  - [net,3/6] mlxsw: spectrum_acl_atcam: Fix wrong comment
    https://git.kernel.org/netdev/net-next/c/06fcdf249406
  - [net,4/6] lib: objagg: Fix general protection fault
    https://git.kernel.org/netdev/net-next/c/b4a3a89fffcd
  - [net,5/6] mlxsw: spectrum_acl_erp: Fix object nesting warning
    https://git.kernel.org/netdev/net-next/c/97d833ceb27d
  - [net,6/6] mlxsw: spectrum_acl: Fix ACL scale regression and firmware errors
    https://git.kernel.org/netdev/net-next/c/75d8d7a63065

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



