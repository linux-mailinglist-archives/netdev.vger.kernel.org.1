Return-Path: <netdev+bounces-80096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E266487CFDA
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 16:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ED8F28402B
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 15:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D86B3CF68;
	Fri, 15 Mar 2024 15:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8PyHkEy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7972A3CF63
	for <netdev@vger.kernel.org>; Fri, 15 Mar 2024 15:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710515432; cv=none; b=RxmFRRVKNxYcy51h/wZklLdDhCa44DuOYxMOm4xROmuevF15jg9VS0S7zdLktlzsXRbgzZzfaxmGamsQJnOzZXX6efIhMmy1tMzUFbTE0p0yt7+cvqMjFW6ACBCn/2gsn/1UwEu36vbFhTw7R8bZ0qPwc+El9iqpeskdu8emwdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710515432; c=relaxed/simple;
	bh=vAh/3X05SOmBzsXFznPCYI+kgTt6Vw3IlAImncaYGxc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AnWAJfp+qYxyObyfwZ6wtyffAPdjVRmXRh7T7akU7NMSJmTku3ni3Dr6Ee/kEeqiPh1pbYw5E5U1hqPKVKyOwccrbtn3mIPB85orqxjPAU25OVfS1GdtsB3DSaW2LqTCdH6UnxOadQiLTHT8DMARqFXTWgpSeCUuhMQTxHXH/9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H8PyHkEy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08E15C433C7;
	Fri, 15 Mar 2024 15:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710515431;
	bh=vAh/3X05SOmBzsXFznPCYI+kgTt6Vw3IlAImncaYGxc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=H8PyHkEyXcHnob3iLBBmA+ZLj/GA+G/o85BPrHmQ7En+/7Kiy9K9ppf+hWerbv8Vi
	 DjwlOpt98QKYPhhb4UmZ+F7ZKWwSkRLnf+nBZSklOfwWan4wshNIfuXNF0I0IcRtmx
	 Csaso/4tYbubp/kXrdElzL3pUgW3Gdx/EYqyiMv7sRpCDp4FzF/K6Po0Omdq5QLU1e
	 AW5QVDuJMEz4i5ree1nwZaVlCPnErdCmMDqTc4DdGcCxMZ7llKVWHvyideFhiZFweV
	 8up/UQyf2H3RTTXF5LlNEHxshE0FfIuJ7HV57o8PctTPvvWO6wfVQZBDZk6LZzFFWv
	 PBJMnGqgOXPxA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E66AFD95053;
	Fri, 15 Mar 2024 15:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next v2 0/4] Support for nexthop group statistics
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171051543093.12293.15883216634942315992.git-patchwork-notify@kernel.org>
Date: Fri, 15 Mar 2024 15:10:30 +0000
References: <cover.1710427655.git.petrm@nvidia.com>
In-Reply-To: <cover.1710427655.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: dsahern@kernel.org, stephen@networkplumber.org, netdev@vger.kernel.org,
 idosch@nvidia.com, kuba@kernel.org, mlxsw@nvidia.com

Hello:

This series was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Thu, 14 Mar 2024 15:52:11 +0100 you wrote:
> Next hop group stats allow verification of balancedness of a next hop
> group. The feature was merged in kernel commit 7cf497e5a122 ("Merge branch
> 'nexthop-group-stats'"). This patchset adds to ip the corresponding
> support.
> 
> NH group stats come in two flavors: as statistics for SW and for HW
> datapaths. The former is shown when -s is given to "ip nexthop". The latter
> demands more work from the kernel, and possibly driver and HW, and might
> not be always necessary. Therefore tie it to -s -s, similarly to how ip
> link shows more detailed stats when -s is given twice.
> 
> [...]

Here is the summary with links:
  - [iproute2-next,v2,1/4] libnetlink: Add rta_getattr_uint()
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=95836fbf35d3
  - [iproute2-next,v2,2/4] ip: ipnexthop: Support dumping next hop group stats
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=529ada74c401
  - [iproute2-next,v2,3/4] ip: ipnexthop: Support dumping next hop group HW stats
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=a50655e730ff
  - [iproute2-next,v2,4/4] ip: ipnexthop: Allow toggling collection of nexthop group HW statistics
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=69d1c2c4aae8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



