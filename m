Return-Path: <netdev+bounces-27436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F9077BFFE
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 20:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40A24281183
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 18:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C7FC8D4;
	Mon, 14 Aug 2023 18:50:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081782917
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 18:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7D208C433C8;
	Mon, 14 Aug 2023 18:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692039023;
	bh=sXGznOK22iMr+x6z6Gpb0XDXXHnSxRxOcm2gO3TfaSA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aYsHJApYPBWKI0xdNhap3D58HNPQONyLd3iolym6nvH/YXpmdrC7JS9rT8dxZ3yBX
	 HtQYdnohrmDXWrmCnGne0jqw11MqaG0+t/T2R5J6rwfnhq4w1xJYtQUFC27G9acIJs
	 UimNr8YuKu7HJSkDZoSS+PAQ82iGlDfo/+iir+hO7QejT/kAhan8rCHyTInJ+dYuJS
	 7I3YpEdKagefHwmRXDLvUuxwYoCUVDnxEhnmOvaOhEueyC1EalDPHQHbXqKdCp8inM
	 gQwsm3sQp3V89vRvai2twbe3alwtPifDXkeJTRowP/RiIsfeI5d673u+ukTQ8Aye4n
	 WyURqQxfWBZpw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6315CC395C5;
	Mon, 14 Aug 2023 18:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [patch net-next v4 00/13] devlink: introduce selective dumps
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169203902340.5305.10179045082215999366.git-patchwork-notify@kernel.org>
Date: Mon, 14 Aug 2023 18:50:23 +0000
References: <20230811155714.1736405-1-jiri@resnulli.us>
In-Reply-To: <20230811155714.1736405-1-jiri@resnulli.us>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com, moshe@nvidia.com,
 saeedm@nvidia.com, idosch@nvidia.com, petrm@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 11 Aug 2023 17:57:01 +0200 you wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Motivation:
> 
> For SFs, one devlink instance per SF is created. There might be
> thousands of these on a single host. When a user needs to know port
> handle for specific SF, he needs to dump all devlink ports on the host
> which does not scale good.
> 
> [...]

Here is the summary with links:
  - [net-next,v4,01/13] devlink: parse linecard attr in doit() callbacks
    https://git.kernel.org/netdev/net-next/c/63618463cb94
  - [net-next,v4,02/13] devlink: parse rate attrs in doit() callbacks
    https://git.kernel.org/netdev/net-next/c/41a1d4d1399a
  - [net-next,v4,03/13] devlink: introduce devlink_nl_pre_doit_port*() helper functions
    https://git.kernel.org/netdev/net-next/c/ee6d78ac28c7
  - [net-next,v4,04/13] devlink: rename doit callbacks for per-instance dump commands
    https://git.kernel.org/netdev/net-next/c/8fa995ad1f7f
  - [net-next,v4,05/13] devlink: introduce dumpit callbacks for split ops
    https://git.kernel.org/netdev/net-next/c/24c8e56d4f98
  - [net-next,v4,06/13] devlink: pass flags as an arg of dump_one() callback
    https://git.kernel.org/netdev/net-next/c/7d3c6fec6135
  - [net-next,v4,07/13] netlink: specs: devlink: add commands that do per-instance dump
    https://git.kernel.org/netdev/net-next/c/7199c86247e9
  - [net-next,v4,08/13] devlink: remove duplicate temporary netlink callback prototypes
    https://git.kernel.org/netdev/net-next/c/ddff283280ba
  - [net-next,v4,09/13] devlink: remove converted commands from small ops
    https://git.kernel.org/netdev/net-next/c/833e479d330c
  - [net-next,v4,10/13] devlink: allow user to narrow per-instance dumps by passing handle attrs
    https://git.kernel.org/netdev/net-next/c/4a1b5aa8b5c7
  - [net-next,v4,11/13] netlink: specs: devlink: extend per-instance dump commands to accept instance attributes
    https://git.kernel.org/netdev/net-next/c/34493336e7d3
  - [net-next,v4,12/13] devlink: extend health reporter dump selector by port index
    https://git.kernel.org/netdev/net-next/c/b03f13cb67a5
  - [net-next,v4,13/13] netlink: specs: devlink: extend health reporter dump attributes by port index
    https://git.kernel.org/netdev/net-next/c/0149bca17262

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



