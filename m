Return-Path: <netdev+bounces-26046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5861E776A89
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 22:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E9611C212AF
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 20:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E611CA1C;
	Wed,  9 Aug 2023 20:50:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BF724512
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 20:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5292C433C8;
	Wed,  9 Aug 2023 20:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691614221;
	bh=2bUKqi845VvZw7cNsUs3cPIWt3zpF7qdxoIFvtuaDKg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gjpi0crYjXR92zVQL4VSq/jAXrxEVSo2ApXFa6J7Tr+7Va2Yw6q0ValQvcYNxAeXX
	 yz9tCMES5L81ld9D8A/OwRpYwi15fk1RxXLSxNyrsJIG5RTp/wC0lPQKk3X7iEPZh1
	 +e1YX4kfPQdTQhTR/87P3i0eD8O+pQx+F3hm1zFQZYMWEurBuNy0s8YDM4mMjXz7jG
	 3+T4nPE9JNMRGp9lJWLc+/L7MXoI37x5WGy0vH6TxZiJk4mCbN4uCONdtTMHGj4TaP
	 4MGMlo71Zv7VfvFkBUOwD1HxUyyvxVP7s/z2O06byh5GqgbgjP6S3rTFkZd4h5uu93
	 bisERVgaJ2H3A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CBA74C64459;
	Wed,  9 Aug 2023 20:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 iproute2 1/2] tc/taprio: don't print netlink attributes
 which weren't reported by the kernel
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169161422083.352.17536032995311163536.git-patchwork-notify@kernel.org>
Date: Wed, 09 Aug 2023 20:50:20 +0000
References: <20230807220936.4164355-1-vladimir.oltean@nxp.com>
In-Reply-To: <20230807220936.4164355-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, stephen@networkplumber.org,
 vinicius.gomes@intel.com

Hello:

This series was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Tue,  8 Aug 2023 01:09:35 +0300 you wrote:
> When an admin schedule is pending and hasn't yet become operational, the
> kernel will report only the parameters of the admin schedule in a nested
> TCA_TAPRIO_ATTR_ADMIN_SCHED attribute.
> 
> However, we default to printing zeroes even for the parameters of the
> operational base time, when that doesn't exist.
> 
> [...]

Here is the summary with links:
  - [v2,iproute2,1/2] tc/taprio: don't print netlink attributes which weren't reported by the kernel
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=a5f695cbb130
  - [v2,iproute2,2/2] tc/taprio: fix JSON output when TCA_TAPRIO_ATTR_ADMIN_SCHED is present
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=f848310a7279

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



