Return-Path: <netdev+bounces-134174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B790699844C
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 13:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4AAB1C221C9
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 11:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3364D1BF322;
	Thu, 10 Oct 2024 11:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q6Aq8CwD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDE01BD50A
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 11:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728558030; cv=none; b=qH8TKc4Kg7nqePSl1zW+Ke1aFQDD3oUGpMeu0kDmdbqAvyK2KX6lLrQgwEeL3kMYqrxQ5p/nznXUIA1xEtXnxeUWGxkaSivIQqC5/saDYs6zev3ZSeaUVQaCW2WmmTl6BAkIT3X5RHomq2bUbVjiC6/giX8ItS9YFtgEuG8+c6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728558030; c=relaxed/simple;
	bh=lPeD6pu6EH0Ub6IGT+1Jp9wPMIGega7wty/w3peViQE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZbLZ50huLkbkheo/WpmS+f/VNRBzZMzJmvVzEA49OQBmwoi208P89o2hiZ4pX4rCrH76F8g7zEZveMHgYmq7BuD4trho41y+P0RFtvXP2Ge3ulfFErFdKol3g64G9nntXzktK2y95lojOMD92syx6/DcOHw5Ux2ivWFDJUK/rWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q6Aq8CwD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F771C4CEC5;
	Thu, 10 Oct 2024 11:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728558029;
	bh=lPeD6pu6EH0Ub6IGT+1Jp9wPMIGega7wty/w3peViQE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q6Aq8CwD8s8UaTxUC8q7bqolA14uL1YqDrj2MxcePp2IDH5rCTrEu6ksQQUb4Up9W
	 leXMJc8zDJdRcTcOdLq0Ip5eFQoPi+uDkqInX3lGw9gzvaf/yqlxOaDLzvMFrvhaA2
	 txkXXRHyTqlX7NOKd3OrNEeM5DWz7oGObzt/qxiWsVN0lXvlUVum9mr/JwriTHbxZR
	 Qy1NR0Ea8nHvgW+0Ggr1tGwtS5Fv4cctSQx3ZVx62f5NYgCT8K3MJn92eQa0AdXtgJ
	 ELph32ir5m6BfDeGCbOJmiXgw4MPy1BEtCsQ1z9QyQwO2EVk5ETO+CvwE89xC5v/nT
	 Xqhce/pPedQxQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C823803263;
	Thu, 10 Oct 2024 11:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/5] eth: fbnic: add timestamping support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172855803404.1977777.10629332064232545504.git-patchwork-notify@kernel.org>
Date: Thu, 10 Oct 2024 11:00:34 +0000
References: <20241008181436.4120604-1-vadfed@meta.com>
In-Reply-To: <20241008181436.4120604-1-vadfed@meta.com>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: vadim.fedorenko@linux.dev, kuba@kernel.org, dsahern@kernel.org,
 pabeni@redhat.com, davem@davemloft.net, alexanderduyck@fb.com,
 netdev@vger.kernel.org, richardcochran@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 8 Oct 2024 11:14:31 -0700 you wrote:
> The series is to add timestamping support for Meta's NIC driver.
> 
> Changelog:
> v3 -> v4:
> - use adjust_by_scaled_ppm() instead of open coding it
> - adjust cached value of high bits of timestamp to be sure it
>   is older then incoming timestamps
> v2 -> v3:
> - rebase on top of net-next
> - add doc to describe retur value of fbnic_ts40_to_ns()
> v1 -> v2:
> - adjust comment about using u64 stats locking primitive
> - fix typo in the first patch
> - Cc Richard
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/5] eth: fbnic: add software TX timestamping support
    https://git.kernel.org/netdev/net-next/c/be65bfc957eb
  - [net-next,v4,2/5] eth: fbnic: add initial PHC support
    https://git.kernel.org/netdev/net-next/c/ad8e66a4d963
  - [net-next,v4,3/5] eth: fbnic: add RX packets timestamping support
    https://git.kernel.org/netdev/net-next/c/6a2b3ede9543
  - [net-next,v4,4/5] eth: fbnic: add TX packets timestamping support
    https://git.kernel.org/netdev/net-next/c/ad3d9f8bc66c
  - [net-next,v4,5/5] eth: fbnic: add ethtool timestamping statistics
    https://git.kernel.org/netdev/net-next/c/96f358f75d1a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



