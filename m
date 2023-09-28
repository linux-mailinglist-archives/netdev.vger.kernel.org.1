Return-Path: <netdev+bounces-36833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D007B1F3D
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 16:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id CF9FC281AFC
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 14:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049B42E650;
	Thu, 28 Sep 2023 14:10:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C4D8BFF
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 14:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 52164C433C9;
	Thu, 28 Sep 2023 14:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695910223;
	bh=ot+W6g9nu+I+9KjrXdlfhebhpZ6XR/Na3+FNvDuEvVM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GUnut2cGRtpD+l6MY8hzKgOhML5DluE8DR4HQh6jQLIOLidkEACFZAszNDPIPoSdq
	 NPeV+n8vcdqYY+H8hRu7Cssgbw37KiG/zMhCf3fZyXHwztXsRmDydZWvxcwQHehWi5
	 MeQe2Crr5IrgVicRRJn3KN+o7ah5RiPI+ZDH31BqhiUos9dnkt0mimeMtgnaYRlYl6
	 6ejfdKbv2RX2Kpcc6F1iw9TKVeMlOCQMVE/tFXdvOu65iAQ9Y+aK8/Lzo7aEtOcMjL
	 sHnZt34gIxd34xexgDuJ650jvs93LmewAtT+ohhNXEUVzIjJVR/Q1GIziIsTGRsdXM
	 aHp0jFKABFAOA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 358D6E29B00;
	Thu, 28 Sep 2023 14:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] MAINTAINERS: Add an obsolete entry for LL TEMAC
 driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169591022321.7456.1928532972585403523.git-patchwork-notify@kernel.org>
Date: Thu, 28 Sep 2023 14:10:23 +0000
References: <20230920115047.31345-1-harini.katakam@amd.com>
In-Reply-To: <20230920115047.31345-1-harini.katakam@amd.com>
To: Katakam@codeaurora.org, Harini <harini.katakam@amd.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, esben@geanix.com, jsc@umbraculum.org,
 christophe.jaillet@wanadoo.fr, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 harinikatakamlinux@gmail.com, michal.simek@amd.com,
 radhey.shyam.pandey@amd.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 20 Sep 2023 17:20:47 +0530 you wrote:
> LL TEMAC IP is no longer supported. Hence add an entry marking the
> driver as obsolete.
> 
> Signed-off-by: Harini Katakam <harini.katakam@amd.com>
> ---
> This is an old driver with no bindings doc and hence the maintainers
> entry does not contain a link to documentation.
> 
> [...]

Here is the summary with links:
  - [net-next] MAINTAINERS: Add an obsolete entry for LL TEMAC driver
    https://git.kernel.org/netdev/net-next/c/19f5eef8bf73

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



