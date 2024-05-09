Return-Path: <netdev+bounces-94753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E0F8C094A
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 03:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DA9C282869
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 01:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A9D13C80F;
	Thu,  9 May 2024 01:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cM4aPhl7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF07313C806
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 01:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715219427; cv=none; b=SZTeVz+vNEC4UFEGL1IJM71Y5I4b7YL2MFsBjofUgZqUCA/psrBEUJU0B26tUMJhopcP4JKAobvGH2oIgS7FDkDl8kUXz5+3XN9FSF6iC0yUtNthmrJ9beoTCGgKXmAXwDmHAEHwGzPv4SilGRctjfHsL4SeoIG4m3x4jyaoDYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715219427; c=relaxed/simple;
	bh=se/WhrfDnCxp3AU0EPe3h6M+4rQK0WtnHxXbRCiX+C4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TsBpEv+nUB5/wFjSAUAIKmWRmRg+EOQPHolYkzXC3Ujei/pYQ9bqGU0+T8vhGRFrrOXQhLtbNqRccS3CYJcQ+s5bOKn3vHsAvVD5bR4+VcRti+d8v5dgjADwxbrzp2LxhHIf9qwoa2NBb1cUZkbon+yKQKQYGrjGAjN7vmoCpEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cM4aPhl7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46D22C2BD10;
	Thu,  9 May 2024 01:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715219427;
	bh=se/WhrfDnCxp3AU0EPe3h6M+4rQK0WtnHxXbRCiX+C4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cM4aPhl7HQ+Y0iQb+VL5BFDjxom+vKWExi6rpx5XIdOjL/CV8mc72DGD103UO91ZM
	 LTUzu8eHot6E+JKaJXk565vUQcKTN20VS+Gf8NnNNy9ayB35c8h4YO7HKA3Z60edQC
	 AD9OusKNxcLwBq293QftZ/o0uEN0p6oGVnO95VmWJcnRlxPKfpaCFiUS9Rhh+leqkn
	 0O53rihQYLobEF10S478Xzp8iAUTyhpujINvdiB/fs9esIcPnLj7ZjRiqvQvodbzCN
	 dlxNFgYZK81S/S1KPJqeN+US1w6ovPWLqOAVsocJI8o3Z5EcjUtsQcytGjym9RLh6N
	 f/rHPlUKscZ3A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3781FC43332;
	Thu,  9 May 2024 01:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1] netlink/specs: Add VF attributes to rt_link spec
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171521942722.27440.17140123550559529904.git-patchwork-notify@kernel.org>
Date: Thu, 09 May 2024 01:50:27 +0000
References: <20240507103603.23017-1-donald.hunter@gmail.com>
In-Reply-To: <20240507103603.23017-1-donald.hunter@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, jiri@resnulli.us,
 jacob.e.keller@intel.com, liuhangbin@gmail.com, donald.hunter@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  7 May 2024 11:36:03 +0100 you wrote:
> Add support for retrieving VFs as part of link info. For example:
> 
> ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/rt_link.yaml \
>   --do getlink --json '{"ifi-index": 38, "ext-mask": ["vf", "skip-stats"]}'
> {'address': 'b6:75:91:f2:64:65',
>  [snip]
>  'vfinfo-list': {'info': [{'broadcast': b'\xff\xff\xff\xff\xff\xff\x00\x00'
>                                         b'\x00\x00\x00\x00\x00\x00\x00\x00'
>                                         b'\x00\x00\x00\x00\x00\x00\x00\x00'
>                                         b'\x00\x00\x00\x00\x00\x00\x00\x00',
>                            'link-state': {'link-state': 'auto', 'vf': 0},
>                            'mac': {'mac': b'\x00\x00\x00\x00\x00\x00\x00\x00'
>                                           b'\x00\x00\x00\x00\x00\x00\x00\x00'
>                                           b'\x00\x00\x00\x00\x00\x00\x00\x00'
>                                           b'\x00\x00\x00\x00\x00\x00\x00\x00',
>                                    'vf': 0},
>                            'rate': {'max-tx-rate': 0,
>                                     'min-tx-rate': 0,
>                                     'vf': 0},
>                            'rss-query-en': {'setting': 0, 'vf': 0},
>                            'spoofchk': {'setting': 0, 'vf': 0},
>                            'trust': {'setting': 0, 'vf': 0},
>                            'tx-rate': {'rate': 0, 'vf': 0},
>                            'vlan': {'qos': 0, 'vf': 0, 'vlan': 0},
>                            'vlan-list': {'info': [{'qos': 0,
>                                                    'vf': 0,
>                                                    'vlan': 0,
>                                                    'vlan-proto': 0}]}},
>                           {'broadcast': b'\xff\xff\xff\xff\xff\xff\x00\x00'
>                                         b'\x00\x00\x00\x00\x00\x00\x00\x00'
>                                         b'\x00\x00\x00\x00\x00\x00\x00\x00'
>                                         b'\x00\x00\x00\x00\x00\x00\x00\x00',
>                            'link-state': {'link-state': 'auto', 'vf': 1},
>                            'mac': {'mac': b'\x00\x00\x00\x00\x00\x00\x00\x00'
>                                           b'\x00\x00\x00\x00\x00\x00\x00\x00'
>                                           b'\x00\x00\x00\x00\x00\x00\x00\x00'
>                                           b'\x00\x00\x00\x00\x00\x00\x00\x00',
>                                    'vf': 1},
>                            'rate': {'max-tx-rate': 0,
>                                     'min-tx-rate': 0,
>                                     'vf': 1},
>                            'rss-query-en': {'setting': 0, 'vf': 1},
>                            'spoofchk': {'setting': 0, 'vf': 1},
>                            'trust': {'setting': 0, 'vf': 1},
>                            'tx-rate': {'rate': 0, 'vf': 1},
>                            'vlan': {'qos': 0, 'vf': 1, 'vlan': 0},
>                            'vlan-list': {'info': [{'qos': 0,
>                                                    'vf': 1,
>                                                    'vlan': 0,
>                                                    'vlan-proto': 0}]}}]},
>  'xdp': {'attached': 0}}
> 
> [...]

Here is the summary with links:
  - [net-next,v1] netlink/specs: Add VF attributes to rt_link spec
    https://git.kernel.org/netdev/net-next/c/e497c3228a4e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



