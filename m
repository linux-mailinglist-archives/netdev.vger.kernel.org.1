Return-Path: <netdev+bounces-106977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BAF918515
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 17:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A16C289EC2
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 15:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFC5188CAF;
	Wed, 26 Jun 2024 15:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqLKHSfU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA185C8FA
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 15:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719414032; cv=none; b=Q2/RMOro+dPBUd/eqsqCvCqXOGkjsxNUs3LP5pBiwkcEEohA4IgMFt5kqG4qd4dxHIW90ewDbgZaGZMjq6OQ+B0MZwLRLUpAxxW8qjp9GUfpKclqgdlAad9QlIBAuRpQWVzKoLWxcsV3ZnSbbfXzhcdtGdZg0YYxLr6SkEfVdp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719414032; c=relaxed/simple;
	bh=riY/MQH1Iwa/XDCvZAA8ML19s2d29ecj28wsyzjn7us=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eYpyeXvmXVeDXXBkdy3FZrrsk+JnqWcu5afCDhR8Ri0G61/HBbVgdhryI8p9PKymJPloZDbHYUp6Iugc0JxOipwyt2OChVOG3dDV8qAJJpMVUDZmQkxmGHMjU/2z1sQ0OyD/YLYRjivBKKpi8IBVnxsHi0ffUtRnQXXZVJMuxj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqLKHSfU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 868C9C116B1;
	Wed, 26 Jun 2024 15:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719414031;
	bh=riY/MQH1Iwa/XDCvZAA8ML19s2d29ecj28wsyzjn7us=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IqLKHSfUXThA+kENO31JH3uPpOhgbZQsM6F24bBGThSJVP2MZ//FvNt8gvxQHf46a
	 MZqp6c5SsHIeqZV1Fym++QbXVmBu8zZFN54Tq7Nus2EFEprsXzSIjKm+PxFp1XknYc
	 PL5NydmieZONF4Kl+TRii0Ce1maIMYVSKByUH+ZnIewFOVDKlCrf46RnooDRD2xux5
	 jGQqO0wgxVdjTU+y8XvJ1Zd1JfXRgUl9eSLqKGS2iYlUOLKsor24bkUSrmaKktUoH8
	 TOWxInE66Jj2PtUeLgzQNuP/UrVHvr7AYpUhWMtzNTvxNHKZo4oyz6t/tm4YHCyPD9
	 79uyh6B6XkRqA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7BF58DE8DF4;
	Wed, 26 Jun 2024 15:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] mlxsw: Reduce memory footprint of mlxsw driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171941403150.22170.7803503160784112086.git-patchwork-notify@kernel.org>
Date: Wed, 26 Jun 2024 15:00:31 +0000
References: <cover.1719321422.git.petrm@nvidia.com>
In-Reply-To: <cover.1719321422.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, idosch@nvidia.com,
 amcohen@nvidia.com, mlxsw@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 25 Jun 2024 15:47:33 +0200 you wrote:
> Amit Cohen writes:
> 
> A previous patch-set used page pool to allocate buffers, to simplify the
> change, we first used one continuous buffer, which was allocated with
> order > 0. This set improves page pool usage to allocate the exact number
> of pages which are required for packet.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] mlxsw: pci: Store number of scatter/gather entries for maximum packet size
    https://git.kernel.org/netdev/net-next/c/8f8cea8f3ddb
  - [net-next,2/2] mlxsw: pci: Use fragmented buffers
    https://git.kernel.org/netdev/net-next/c/36437f469d7e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



