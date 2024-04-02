Return-Path: <netdev+bounces-83885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D808894AB4
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 07:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B96391C20B5B
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 05:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7EB18021;
	Tue,  2 Apr 2024 05:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="utkm+IiU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7932917C95
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 05:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712034029; cv=none; b=OxFGojFY0VOTN4N+h40T1VLe1fa65aJlg6zk8mWbJFSu/I85NHfOuhK1fU7zTMpVbB6tZ8GdEifURWpU773atJ5wEbrCa+RHHGdF6n0X6soGj5w53g2LYB405/gZSugs3pFSCXgAFa8Oij98aMibARif2dTLze/hpMn8cdgUtDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712034029; c=relaxed/simple;
	bh=z8Wm4nD9UBhggqzm+pchERDRiBBMHHYVSulMCkIeuSE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u/54xAPWExXt1b5tOO72TOk3bJ1aAXa4LmPBS4mkI4T9MaO+McY8ZQGLrgYwrYpP6v0O4mTwdVLDxhNAIm820vffN5lJBKMjv51KnG9tSMQF83+YBTfKKf+jIrCB2R9UDtDHY2tTd8BcqW3KlghIYr0yEXLWWarCWqjY67nElkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=utkm+IiU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43DE1C433C7;
	Tue,  2 Apr 2024 05:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712034029;
	bh=z8Wm4nD9UBhggqzm+pchERDRiBBMHHYVSulMCkIeuSE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=utkm+IiUT6RlMkr3gCXeR+WWjDzGiuPW94ndLmrVSeP8flvQq1cICV6fdUXO3dmdr
	 qToeqLD8E0Vr2OwW+j1F7tCqLj43Lip2ew/PTkw56CqJFyri4J8jP8fvMbCd2Q8Qym
	 UUdD6Gz3KGMoHBY1DYF8mQ0/fVcGRJ8jbP33irduEFCeOFP105SRK8Mn/mhoYrdVO2
	 kuhSG61AgxacNvG2Z1vm4/prMu24RDCed1WhOJjTzPrWgh2X9RO943BM3A1MluvXHy
	 2iaC85vJHUd6kta3fjca+vr8ktbXbSZCnvyethAtSqoxT5gJ4HCUoB6T2xFJ+4O2Zw
	 QrFuM7W7UMedg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 34D5ED8BD16;
	Tue,  2 Apr 2024 05:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/3] genetlink: remove linux/genetlink.h
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171203402921.17077.13638062733619928977.git-patchwork-notify@kernel.org>
Date: Tue, 02 Apr 2024 05:00:29 +0000
References: <20240329175710.291749-1-kuba@kernel.org>
In-Reply-To: <20240329175710.291749-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, dw@davidwei.uk, jiri@resnulli.us,
 andriy.shevchenko@linux.intel.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 29 Mar 2024 10:57:07 -0700 you wrote:
> There are two genetlink headers net/genetlink.h and linux/genetlink.h
> This is similar to netlink.h, but for netlink.h both contain good
> amount of code. For genetlink.h the linux/ version is leftover
> from before uAPI headers were split out, it has 10 lines of code.
> Move those 10 lines into other appropriate headers and delete
> linux/genetlink.h.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/3] netlink: create a new header for internal genetlink symbols
    https://git.kernel.org/netdev/net-next/c/5bc63d3a6f46
  - [net-next,v3,2/3] net: openvswitch: remove unnecessary linux/genetlink.h include
    https://git.kernel.org/netdev/net-next/c/f97c9b533a1d
  - [net-next,v3,3/3] genetlink: remove linux/genetlink.h
    https://git.kernel.org/netdev/net-next/c/cd7209628cdb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



