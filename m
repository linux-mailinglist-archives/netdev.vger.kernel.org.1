Return-Path: <netdev+bounces-88881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8A88A8DFA
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 23:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01BBE1F2133C
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 21:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAD94CB36;
	Wed, 17 Apr 2024 21:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0W3kPhR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0C48F4A
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 21:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713389431; cv=none; b=jNmUnyCSls25lYZ5Wl9hMwGRlpGlwD1xNTe5iGWvM51Zt9vljZDIjGjLS0LAXZLegaw/EJo/SA1NtOF20zVzEM1V/I7jXLojqdXRwUBuuyFpiJBl75GaAGgjkGPGQJ+oRrjxftOR9/9o+y3k+7y9KGs54TKPz/K110tkkSeHN6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713389431; c=relaxed/simple;
	bh=2gjMxle0B3QlrdDeEHV5D1cqmPVD9mrteKzuxei0n5Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TLi7R+oaORAsuPy7afA+7vbwn8H+/v/QWfuYZ+pKQY4pbOODrelJHEB/WNkJf2IZvb8LLQqo9hN9Ytnna0VsYWt+DEyDu9nx4zyB622MT3Ip59wdcTrzxtwnKKuH5PE62XtF9C0pdLkgskRa/fXMF5r+ZkCLFuiMiMu/enJeYis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0W3kPhR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 212B9C116B1;
	Wed, 17 Apr 2024 21:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713389430;
	bh=2gjMxle0B3QlrdDeEHV5D1cqmPVD9mrteKzuxei0n5Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=V0W3kPhRI6yJQX1yVp9B5jYLClweJhknulMJioIa9Pna5ODmxI/ARf8i42dXPJxNU
	 WFN90k43DcDC01V0gWx83HeMQgpoEVRsHwuoxg5DXcquQC/sJc3XjGxQyzr2odv1ih
	 ZldllOOvO1AlgzTigOeaJ6t/i3oFc0fJMTAEosTanAQ3AmEZ+mZiMwVhwrLEkL8jgw
	 xeaGlavIRntzOK2AFTJFvWcx5/Axnmu3rxjROYj6whqZnDyxXCx3lxsZi16mFdg3o9
	 ylA/pE0GAwFsxDPi2mUmZaPmrsFKCY5/tcqFZ7jyoiwaA8H03/Su8Q//D2SXl/YxxD
	 hRCfcuSQ/jdJA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 104D9C43619;
	Wed, 17 Apr 2024 21:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH ethtool-next v2 0/2] Userspace code for ethtool HW TS
 statistics
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171338943006.32225.7031146712000724574.git-patchwork-notify@kernel.org>
Date: Wed, 17 Apr 2024 21:30:30 +0000
References: <20240417203836.113377-1-rrameshbabu@nvidia.com>
In-Reply-To: <20240417203836.113377-1-rrameshbabu@nvidia.com>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev,
 jacob.e.keller@intel.com, pabeni@redhat.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, gal@nvidia.com, tariqt@nvidia.com,
 saeedm@nvidia.com, cjubran@nvidia.com, cratiu@nvidia.com, mkubecek@suse.cz,
 wintera@linux.ibm.com

Hello:

This series was applied to ethtool/ethtool.git (next)
by Michal Kubecek <mkubecek@suse.cz>:

On Wed, 17 Apr 2024 13:38:27 -0700 you wrote:
> Adds support for querying statistics related to tsinfo if the kernel supports
> such statistics.
> 
> Changes:
>   v1->v2:
>     - Updated UAPI header copy to be based on a valid commit in the
>       net-next tree. Thanks Alexandra Winter <wintera@linux.ibm.com> for
>       the catch.
>     - Refactored logic based on a suggestion from Jakub Kicinski
>       <kuba@kernel.org>.
> 
> [...]

Here is the summary with links:
  - [ethtool-next,v2,1/2] update UAPI header copies
    https://git.kernel.org/pub/scm/network/ethtool/ethtool.git/commit/?id=d324940988f3
  - [ethtool-next,v2,2/2] netlink: tsinfo: add statistics support
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



