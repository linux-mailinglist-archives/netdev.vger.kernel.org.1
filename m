Return-Path: <netdev+bounces-190223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60791AB5BFE
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 20:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E4831B4766E
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 18:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7061D2BEC2F;
	Tue, 13 May 2025 18:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQIFiGac"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1769D2BF964
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 18:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747159202; cv=none; b=RUGJZMr3ZvbBtYfmynvQHK9cjoWv5U0bTwZM/dpv4P2eDjPgLpqPlkwSqCNFkBSzWOKox7pSaHTOBneYZ/eU9vPsffNIMFN754H7dFYoFzqtAAG+mnvHnRpTpF7+bMKlQ7I4fy6eQp1qCxeNNL/otb4Pi+qQeCtrURWeut8rNPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747159202; c=relaxed/simple;
	bh=VnjmCEpWrTnFyrZZ35gQOc+TmeLHPm7iaxQ34Iibp60=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ML1kXd5pl01QqKnGgBuKbmiY4U+8CPSu36TvADM6X6Dl26qU2lDtCm/0m41oMyo6DaGVfTuv6bMKEDNcY9wLAWW/LlaZ9xEWRUz7u8LrIvbf9bwMNtMz4lp0atEo5sKecp2MwWxc8raehWgLsrrNusA2luVigeJikDPXJbgsL+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQIFiGac; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 449D4C4CEE4;
	Tue, 13 May 2025 18:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747159201;
	bh=VnjmCEpWrTnFyrZZ35gQOc+TmeLHPm7iaxQ34Iibp60=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TQIFiGacDmLG/SGLaTXwXzrSdewh+j9Zospv0Mmjrwsko0+1VflGPnmf67YL1iIIC
	 2n+A1ukEPGTuj2OHUycV4PoY6vOB0MXT0HTwVjpTI+qq+F/n/Am6hsorB9UC3GoZpe
	 WnGSWUsacBBu59TCJT+ectEVb2iGBeY6sUAmcrfT9TeqaYCqNrI3/eK7wclFybJfVO
	 wQuxRIZgUXTuQsFHQI8yY0eDldTxWcCkapNEom3haAnCYlSOrELdapZMbBgPDu44xJ
	 RZqV+4gEcD+/rhPQJm3W0yYiAqvbosf0IDRrDCPxE3AY76oW7kxIANNeHZB7qt0HAg
	 vU5DQ6XEv9qXA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ED18239D6540;
	Tue, 13 May 2025 18:00:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next] ip ntable: Add support for "mcast_reprobes"
 parameter
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174715923776.1748654.17847576553235256725.git-patchwork-notify@kernel.org>
Date: Tue, 13 May 2025 18:00:37 +0000
References: <20250508111301.544391-1-idosch@nvidia.com>
In-Reply-To: <20250508111301.544391-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, dsahern@gmail.com, stephen@networkplumber.org,
 petrm@nvidia.com

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Thu, 8 May 2025 14:13:01 +0300 you wrote:
> Kernel commit 8da86466b837 ("net: neighbour: Add mcast_resolicit to
> configure the number of multicast resolicitations in PROBE state.")
> added the "NDTPA_MCAST_REPROBES" netlink attribute that allows user
> space to set / get the number of multicast probes that are sent by the
> kernel in PROBE state after unicast probes did not solicit a response.
> 
> Add support for this parameter in iproute2.
> 
> [...]

Here is the summary with links:
  - [iproute2-next] ip ntable: Add support for "mcast_reprobes" parameter
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=f98940cce003

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



