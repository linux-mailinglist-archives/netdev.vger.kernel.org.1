Return-Path: <netdev+bounces-86821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C58628A060D
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 04:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 075A128893C
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 02:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1438A13B28D;
	Thu, 11 Apr 2024 02:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YjyIevUz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E7113AD2E
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 02:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712803229; cv=none; b=bBttslOOBXSIP7Jdy5+iNGDeWlMqzgzBtyMH8PdtpgFwp1Qx8FNqRgQdja/yi8vrVLwuYw2zzZkS68sRFh4MPEYFCBB9hSDN6i+VVO1GunG/yFtwRtFmqCaOdL3qpbRGhjLsVdlgybRU2COlSe4zE3CCNBJGe/PwzT1PvYnCiPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712803229; c=relaxed/simple;
	bh=htHZobzgQrABzTvQj5oc7mqO/Zo3cwe5LQqXSU7qrIo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MjyTOzzBcJs6ansWF3IundjcxyUlwrCNee//UVU1vbKeYPVy6+Pm6kwmPniJ+kYrTtxFlMCYokA3cFlFJnjfpVk13EznDtwxnwUsP5LdP98Ezj43cXkoUEMDpdB/l5hh2B+r0SXZBmqF/cgnKlezf8+8QL8g5AchknnMlXvotu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YjyIevUz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E844C43390;
	Thu, 11 Apr 2024 02:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712803228;
	bh=htHZobzgQrABzTvQj5oc7mqO/Zo3cwe5LQqXSU7qrIo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YjyIevUzK/62cRqF24SWpSzqwWOaJNpPS6HajHgDSteo8fy18izCAk9wjQ9qbsnnx
	 Kxkb/boLCL9ICz93UCScHekQ6bEX/43bgRbIXsmAiw02IYIaz4swZ18VR7EX1RuZoI
	 QXiOd1fQbVYdRC5BBeTMgqszMUaxSvz7aHJziaQqb5P8y06fDfoqBxMeboJFNiiUp/
	 urSbxfqSY2IGltnWDbL+S0njz5Lv3MJLfEVjtn3QtgzsVcOKr/aMfnrBdH5WbwNQrD
	 h5KiObVIT5Jb/Om1LxkBD3Em9ABZqz4o0cEKmMlpzzEs2kw8IbJeB2gCwEQA2+so6g
	 gsxrCS7Y07niw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5BA7CC395F6;
	Thu, 11 Apr 2024 02:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] doc/netlink/specs: Add bond support to rt_link.yaml
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171280322836.23404.15227352661794271179.git-patchwork-notify@kernel.org>
Date: Thu, 11 Apr 2024 02:40:28 +0000
References: <20240409083504.3900877-1-liuhangbin@gmail.com>
In-Reply-To: <20240409083504.3900877-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, donald.hunter@gmail.com,
 jiri@resnulli.us, jacob.e.keller@intel.com, sdf@google.com,
 jay.vosburgh@canonical.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  9 Apr 2024 16:35:04 +0800 you wrote:
> Add bond support to rt_link.yaml. Here is an example output:
> 
>  $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/rt_link.yaml \
>    --do getlink --json '{"ifname": "bond0"}' --output-json | jq '.linkinfo'
>  {
>    "kind": "bond",
>    "data": {
>      "mode": 4,
>      "miimon": 100,
>      ...
>      "arp-interval": 0,
>      "arp-ip-target": [
>        "192.168.1.1",
>        "192.168.1.2"
>      ],
>      "arp-validate": 0,
>      "arp-all-targets": 0,
>      "ns-ip6-target": [
>        "2001::1",
>        "2001::2"
>      ],
>      "primary-reselect": 0,
>      ...
>      "missed-max": 2,
>      "ad-info": {
>        "aggregator": 1,
>        "num-ports": 1,
>        "actor-key": 0,
>        "partner-key": 1,
>        "partner-mac": "00:00:00:00:00:00"
>      }
>    }
>  }
> 
> [...]

Here is the summary with links:
  - [net-next] doc/netlink/specs: Add bond support to rt_link.yaml
    https://git.kernel.org/netdev/net-next/c/4ede457542a6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



