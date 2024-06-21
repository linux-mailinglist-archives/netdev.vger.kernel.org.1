Return-Path: <netdev+bounces-105649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D63B91226C
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 12:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD62528B00F
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 10:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DCA16D33A;
	Fri, 21 Jun 2024 10:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tq9zlb70"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A3584D13
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 10:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718965828; cv=none; b=Lg6VgV/M53kT+tYUDAIt+XqzkVfYFdi0XnM0hgzSGSS71CFlQb3bkNDqg00M4Bfw8ekwwOLHc+fDm94xPW5pGNSX2BUeeRoYGAheDzy1SQROtw5qH/Ewm+ZJDeUhByKwz+jDJm4omn3wxHwdKFzvzG/p+aPLetQSgCSQF6ZqhXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718965828; c=relaxed/simple;
	bh=94DF1Uo/iFQmJT5Vw5Vh6AQdSIGaEe0edd7weQoN6rU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=szzrRjzzDPMuSIWkuS8onxn/LgxkkOnYq3+pDVeZiDBOccJOQtFhSUPXyDp1+6nlZd71yMMHxtL5+WlDhivCuyRjo2IWspJkKbq6tHGhSmK8IRM8aES7ohsh8DIL5LWuFUkz2ak9tZClG1gyORFa29+blC9uGue0ZGAazVp3grk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tq9zlb70; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C51E0C4AF08;
	Fri, 21 Jun 2024 10:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718965827;
	bh=94DF1Uo/iFQmJT5Vw5Vh6AQdSIGaEe0edd7weQoN6rU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tq9zlb70mri7TEA6/OpOaODCJyQsfFpCILZLUItvbkP+zbB9OtumsBu3Z+DCwWKeg
	 fGj+xJfOZTALfuca+GcPynUrYmQdBIBg+o8JnMd+ZcxR7wzSV8rke3S97EYmVJjNsJ
	 E6tVgg9z9fJZBIKLpsPjRE1awepyLFlOP9XqktE36T0Hi9CSdxQYUVx9GlQ5CHtfIB
	 HMEO9yehI2WbS7XLj/kE4CB37pmr3eyE7EUjvhFn0TswqaPhAC/fU0wgVIQgyoCA2Y
	 Xyt7om8GEPMaayWl44RxY7RWUpuqsTUuh0dgCzZz2fTWMku7rN14nIaboFOWkW3k5o
	 IK9eF815UuuNg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B90DECF3B97;
	Fri, 21 Jun 2024 10:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bonding: fix incorrect software timestamping report
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171896582775.421.1864825475109128104.git-patchwork-notify@kernel.org>
Date: Fri, 21 Jun 2024 10:30:27 +0000
References: <20240620085626.1123399-1-liuhangbin@gmail.com>
In-Reply-To: <20240620085626.1123399-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, j.vosburgh@gmail.com, andy@greyhouse.net,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, kory.maincent@bootlin.com,
 florian.fainelli@broadcom.com, liali@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 20 Jun 2024 16:56:26 +0800 you wrote:
> The __ethtool_get_ts_info function returns directly if the device has a
> get_ts_info() method. For bonding with an active slave, this works correctly
> as we simply return the real device's timestamping information. However,
> when there is no active slave, we only check the slave's TX software
> timestamp information. We still need to set the phc index and RX timestamp
> information manually. Otherwise, the result will be look like:
> 
> [...]

Here is the summary with links:
  - [net] bonding: fix incorrect software timestamping report
    https://git.kernel.org/netdev/net/c/a95b031c6796

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



