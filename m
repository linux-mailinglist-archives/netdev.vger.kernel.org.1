Return-Path: <netdev+bounces-110948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4237F92F190
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 00:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57DFD1C22D3D
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 22:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF9C1A00E3;
	Thu, 11 Jul 2024 22:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1nT+q/0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898FE149E1A
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 22:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720735233; cv=none; b=mbYsdvmVMTwYt+IlPZf/mSi0R5KRZAComzfTERCIvECvCGHIP+3AkExekBAZzjoqwnR6boUw0Pqv0t4TFllycUPo2hiyFH138pyqb9Y9tQlP7ub2K3lZxT7U2XxdFEcOqAyNBrL4ecX+CMiD0Y0eobGIYEJAcyfUAueBpsgcFe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720735233; c=relaxed/simple;
	bh=RR8gs0/Jh4XAFWQ0rlAYDfSwu2bzUq2gqSJlxkHiZ3g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g0zYFxe0d7SrsqOj2b+GDi8NStgSNwK+wY79d0ydDF4UU2jUnwA8fvcW5xJ2WlwjFl0FJ62id4FYlO51tQUSVRQFlV+n7r4m5VlrgZ4h9nyo7nqcVTRAH+Aray2UlVYweBAMMY5Rg9Kkx9wm95v7ZgzUlh5MDfwRVBt8ibG34kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1nT+q/0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1F22EC4AF09;
	Thu, 11 Jul 2024 22:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720735233;
	bh=RR8gs0/Jh4XAFWQ0rlAYDfSwu2bzUq2gqSJlxkHiZ3g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=n1nT+q/06TGnWPwaox4RBe6PN7Gpk9vOlvcO7NViqwNjr2IvP0NMWqifOxiVD5Yyz
	 hmxlxT+eNFNKu89nMRu6bCiW50MBsdYPH37BxOgiR7wlpXrCttysqOS0EZ8aFpaBAC
	 6la2ilyX1pPwOWyeO3qEXBYl+n8xFPKXgM9J9gP4VgMEW4Yrwco9XAZiLPQJTwfK8R
	 sj+TfAFs6SNCgpSbLc+DxtbiGdWcp7irJMz0eEN6ARysBlxg691GgST0sAvQu1TDHC
	 ahvvbTwCCoJSfaLtde86BTI8CthW5c3pyioKyHRDwO1h2zREGuPD4gI877qaw5PiPL
	 qdp4n+ouHwNhg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0C822C4332C;
	Thu, 11 Jul 2024 22:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] ethtool: use the rss context XArray in ring
 deactivation safety-check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172073523304.18848.1293994898936058912.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jul 2024 22:00:33 +0000
References: <20240710174043.754664-1-kuba@kernel.org>
In-Reply-To: <20240710174043.754664-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, przemyslaw.kitszel@intel.com, ecree.xilinx@gmail.com,
 jacob.e.keller@intel.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 10 Jul 2024 10:40:41 -0700 you wrote:
> Now that we have an XArray storing information about all extra
> RSS contexts - use it to extend checks already performed using
> ethtool_get_max_rxfh_channel().
> 
> Jakub Kicinski (2):
>   ethtool: fail closed if we can't get max channel used in indirection
>     tables
>   ethtool: use the rss context XArray in ring deactivation safety-check
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] ethtool: fail closed if we can't get max channel used in indirection tables
    https://git.kernel.org/netdev/net-next/c/2899d58462ba
  - [net-next,2/2] ethtool: use the rss context XArray in ring deactivation safety-check
    https://git.kernel.org/netdev/net-next/c/24ac7e544081

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



