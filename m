Return-Path: <netdev+bounces-52354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9C57FE7EC
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 05:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B565F281AC1
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 04:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90C014011;
	Thu, 30 Nov 2023 04:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="em3/5+qL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EE0101E3
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 04:00:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 23565C433CA;
	Thu, 30 Nov 2023 04:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701316827;
	bh=1YNIU9NUDHdrij86+X/Ij8bthjnivZOemjrDYZovlEg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=em3/5+qL/118oeSMnB+1po4xRB8vJVVo72dsAJq9TPVeAi3EjhdTnoqBEe4u5hzFr
	 7T0PwYeMM45Ybj3DvbXK9mkj4Y5X6A2bF5T5us1yiKTUQ640M5V1lRln+jNIicu3+N
	 xSfbMbYJpZlq9Scf6U3IK2YAliyOUK/wUhVx0PZniaqaCBE9Xz2z6Ne+foz6drsuLu
	 MPio5FGAljnvCyYTKTeEPDoKpL4i9OnzpLqW/r611N0BBxQw/RObqVPinBL1dqi73T
	 D/U7gs/RZ3Ul7huEMQekU6X5MVFefQ6E+duncJVoXCWBKdnARuDAJ+EF2Tc4TR5CE2
	 fyD1WsnpM3CMg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 023F0E00092;
	Thu, 30 Nov 2023 04:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] ice: Fix VF Reset paths when interface in a failed
 over aggregate
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170131682700.19383.14993915988901084002.git-patchwork-notify@kernel.org>
Date: Thu, 30 Nov 2023 04:00:27 +0000
References: <20231127212340.1137657-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20231127212340.1137657-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, david.m.ertman@intel.com,
 carolyn.wyborny@intel.com, daniel.machon@microchip.com,
 maciej.fijalkowski@intel.com, jay.vosburgh@canonical.com,
 sujai.buvaneswaran@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 27 Nov 2023 13:23:38 -0800 you wrote:
> From: Dave Ertman <david.m.ertman@intel.com>
> 
> There is an error when an interface has the following conditions:
> - PF is in an aggregate (bond)
> - PF has VFs created on it
> - bond is in a state where it is failed-over to the secondary interface
> - A VF reset is issued on one or more of those VFs
> 
> [...]

Here is the summary with links:
  - [net,v2] ice: Fix VF Reset paths when interface in a failed over aggregate
    https://git.kernel.org/netdev/net/c/9f74a3dfcf83

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



