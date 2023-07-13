Return-Path: <netdev+bounces-17724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9363F752D4A
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 01:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45F5B281E99
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 23:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4616C63A0;
	Thu, 13 Jul 2023 23:00:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CAF611E
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 23:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55AEBC433C9;
	Thu, 13 Jul 2023 23:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689289222;
	bh=YYP/VT4dbpBKiH1kPUHWNgzkz0yjrhI7mLD3RPOQhnk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=B1AFgabdG41ijBlz1jZq7/QUC6zdSrCSIZf3U3CFbYWRq0L2EuqGOeVKEQKi42ezb
	 +iJXgVt/OqfmCJ4JBZ12fXCuObduZci5zJjEUnCEfq2TS1Mw1Ug0B5KJFD3yWRHANg
	 qSVLmdSM1bJM5ahJBjh+A0y3tkGB3b4eyYhHchylkxwffhT9pf+Lur8BKWEecF2cV9
	 jBIpfwHS5oeTEM9tD2v30uvXpmnXT/phGaLB6QIfQp55c82Zq73vIv/GAOEB3ahcxj
	 fhfK5deFOtJa6fOeazE2JYSlR7kNkBgz01OE+XI9ZiF7vmlASmzFHNyl3aJAWhLQyJ
	 e7sqOz/AwKB2w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 301F8E4508F;
	Thu, 13 Jul 2023 23:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2] f_flower: Treat port 0 as valid
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168928922219.18367.5523035450216957511.git-patchwork-notify@kernel.org>
Date: Thu, 13 Jul 2023 23:00:22 +0000
References: <20230711065903.3671956-1-idosch@nvidia.com>
In-Reply-To: <20230711065903.3671956-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org, dsahern@gmail.com,
 petrm@nvidia.com, lukasz.czapnik@intel.com

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Tue, 11 Jul 2023 09:59:03 +0300 you wrote:
> It is not currently possible to add a filter matching on port 0 despite
> it being a valid port number. This is caused by cited commit which
> treats a value of 0 as an indication that the port was not specified.
> 
> Instead of inferring that a port range was specified by checking that both
> the minimum and the maximum ports are non-zero, simply add a boolean
> argument to parse_range() and set it after parsing a port range.
> 
> [...]

Here is the summary with links:
  - [iproute2] f_flower: Treat port 0 as valid
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=61695c493ec1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



