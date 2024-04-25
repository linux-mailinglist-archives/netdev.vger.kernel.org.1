Return-Path: <netdev+bounces-91171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E38A8B192E
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 05:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E78592858CF
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 03:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0189C17999;
	Thu, 25 Apr 2024 03:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/C3FbjG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15DE111AA
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 03:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714014628; cv=none; b=KBgUJJjgB8nQdPrINmbcF5272pWr7MHjZTf1BdYcJu2dCjbfFMAahB+X/0EGYf/C5ivdVcg8te4lIRgc1ZUBOzCjipZkV5k1DbadWRAsNetHw5TADjVfdGo4C/9S9Q08yFctE1RYR5Ka3kE536E+dZBe2RwS7McevrjVTQhc8OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714014628; c=relaxed/simple;
	bh=7wZDcemc98vJxrvvHyHoRU9k8w+k6alJcqxT+KclUKQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=V3OPn2xa74IbKbrKPMVToI7DaPF4zHNff39vAzxCHfkWPkz41ptrqkZbuKrtIcjILe6b+jyfRb3ZTymXwyQfQfSDSjqksUVXBQbEK4xRuMZiHlfPa+e5sM+Abg3JMQdEVajR6CxZZAZpzw3i8PhpiJHOlRpm5lyVxVkRKRQEAfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/C3FbjG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 61C75C2BD10;
	Thu, 25 Apr 2024 03:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714014628;
	bh=7wZDcemc98vJxrvvHyHoRU9k8w+k6alJcqxT+KclUKQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=U/C3FbjGn3kk+dqbTh0dPgbwux1dKnviQgKu/vnE3I96H/6awOXzDTWvCfQgbV82D
	 qQHPhFUk+FTcZrPFTuZo74mdVTbHlr70rFQH09zBCPzHpjslcUJ+W3evVcqO8+tIFc
	 41C9GNsHY0QO2xUZsG/BMtizn/bjKbL6z4oZbFx6uRz2V2DEfxR170I+71XS7ORcj+
	 HSTknwQtBZ3yEa4aQ4edYoUIuCvUzBHWKaHahXcnOvA2S9nkko4qYRkJwnnfHKe4Qc
	 Mul0b0cbKfZQZa9X2H6qmoOk3QBtJa7xrYp5a25CbYpJVLf37YhayT5NLFFD1Y+vVo
	 QwATIJ8IlbnPg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 51896C595D2;
	Thu, 25 Apr 2024 03:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/6][pull request] ice: Support 5 layer Tx scheduler
 topology
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171401462833.4490.1421617944754978587.git-patchwork-notify@kernel.org>
Date: Thu, 25 Apr 2024 03:10:28 +0000
References: <20240422203913.225151-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240422203913.225151-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, mateusz.polchlopek@intel.com

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Mon, 22 Apr 2024 13:39:05 -0700 you wrote:
> Mateusz Polchlopek says:
> 
> For performance reasons there is a need to have support for selectable
> Tx scheduler topology. Currently firmware supports only the default
> 9-layer and 5-layer topology. This patch series enables switch from
> default to 5-layer topology, if user decides to opt-in.
> 
> [...]

Here is the summary with links:
  - [net-next,1/6] devlink: extend devlink_param *set pointer
    https://git.kernel.org/netdev/net-next/c/5625ca5640ca
  - [net-next,2/6] ice: Support 5 layer topology
    https://git.kernel.org/netdev/net-next/c/91427e6d9030
  - [net-next,3/6] ice: Adjust the VSI/Aggregator layers
    https://git.kernel.org/netdev/net-next/c/927127cda11a
  - [net-next,4/6] ice: Enable switching default Tx scheduler topology
    https://git.kernel.org/netdev/net-next/c/cc5776fe1832
  - [net-next,5/6] ice: Add tx_scheduling_layers devlink param
    https://git.kernel.org/netdev/net-next/c/109eb2917284
  - [net-next,6/6] ice: Document tx_scheduling_layers parameter
    https://git.kernel.org/netdev/net-next/c/9afff0de30db

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



