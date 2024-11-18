Return-Path: <netdev+bounces-145811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 330E19D104B
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 13:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D93BB233CC
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 12:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C7D192593;
	Mon, 18 Nov 2024 12:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ui5pNo7j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEF513A89A
	for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 12:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731931221; cv=none; b=TOORz586zPGoXO3iQXwPPALsnEFO/reUOBlzMMhV88XkA488Dg16gnaAZMZRsIrWNVOFL2T23M+55G720+I2qmgpum4fyv3D2jkhgC3qP+7xeNoNUrFJ5WLmkp0oXHnpktdTHhseViBq3Dh7XEwOTh6fP04KNidWhfCQQn2s0Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731931221; c=relaxed/simple;
	bh=KqJEFJvhrKrj3G9dMVvMp4LHBx4DU1dUwq2ph+p7Yn8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=InZJkK4LRTDD96FigNQlrIqmSVMBqxufmpBwufKRpYANpIA6pBRfuwwwDqgzViH7Ht8/i6HvWOV8EOhmPyY+BOMMq96gl3WL2bZRk0DsL14vvjI7yqqd9DpVvcpkm6cqwI+opJlgk4OXoZZH72VBriNoUmeZ0MI9Deedi9yPeqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ui5pNo7j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECBE9C4CECC;
	Mon, 18 Nov 2024 12:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731931221;
	bh=KqJEFJvhrKrj3G9dMVvMp4LHBx4DU1dUwq2ph+p7Yn8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ui5pNo7jZeYBBBl7zSbHPIaoKxRlxT7NCou0148b6RZf9C7US/oA7On2Yqg3rWkBL
	 fSHx17G8XcAzlZgv2PTxg1CC7FaeC8L6leBPTmXESaEtnH0xdi0wh5PtDgWkn8xoWj
	 Ph2VMjnELC/buHHeGlkVKB9zci2HKIy4sQ/O3RRsffryRPB0rmcnof1DU1+RF8W1vd
	 gew/H9g+08/lUmU0wkXwoJxcHY73lLs/NFRUWGnn2Wd5Lt0pLJ57g0hn5S9HhXLtCA
	 WefDK0hRHspqoFaEOhzVZ50fuz1WoBEpKX2Rm9NHRPunZbmFj7lcZGPZwNp4YgzE5p
	 eT8jCpWtql2ug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CBF3809A80;
	Mon, 18 Nov 2024 12:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 01/11] xfrm: Add support for per cpu xfrm state handling.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173193123226.4012941.10136395644785112226.git-patchwork-notify@kernel.org>
Date: Mon, 18 Nov 2024 12:00:32 +0000
References: <20241115083343.2340827-2-steffen.klassert@secunet.com>
In-Reply-To: <20241115083343.2340827-2-steffen.klassert@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: davem@davemloft.net, kuba@kernel.org, herbert@gondor.apana.org.au,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Steffen Klassert <steffen.klassert@secunet.com>:

On Fri, 15 Nov 2024 09:33:33 +0100 you wrote:
> Currently all flows for a certain SA must be processed by the same
> cpu to avoid packet reordering and lock contention of the xfrm
> state lock.
> 
> To get rid of this limitation, the IETF standardized per cpu SAs
> in RFC 9611. This patch implements the xfrm part of it.
> 
> [...]

Here is the summary with links:
  - [01/11] xfrm: Add support for per cpu xfrm state handling.
    https://git.kernel.org/netdev/net-next/c/1ddf9916ac09
  - [02/11] xfrm: Cache used outbound xfrm states at the policy.
    https://git.kernel.org/netdev/net-next/c/0045e3d80613
  - [03/11] xfrm: Add an inbound percpu state cache.
    https://git.kernel.org/netdev/net-next/c/81a331a0e72d
  - [04/11] xfrm: Restrict percpu SA attribute to specific netlink message types
    https://git.kernel.org/netdev/net-next/c/83dfce38c49f
  - [05/11] xfrm: Convert xfrm_get_tos() to dscp_t.
    https://git.kernel.org/netdev/net-next/c/766f532089af
  - [06/11] xfrm: Convert xfrm_bundle_create() to dscp_t.
    https://git.kernel.org/netdev/net-next/c/01f61cbfc8b2
  - [07/11] xfrm: Convert xfrm_dst_lookup() to dscp_t.
    https://git.kernel.org/netdev/net-next/c/3021a2a3403d
  - [08/11] xfrm: Convert struct xfrm_dst_lookup_params -> tos to dscp_t.
    https://git.kernel.org/netdev/net-next/c/e57dfaa4b0a7
  - [09/11] xfrm: Add error handling when nla_put_u32() returns an error
    https://git.kernel.org/netdev/net-next/c/9d287e70c51f
  - [10/11] xfrm: replace deprecated strncpy with strscpy_pad
    https://git.kernel.org/netdev/net-next/c/9e1a6db68e3c
  - [11/11] xfrm: Fix acquire state insertion.
    https://git.kernel.org/netdev/net-next/c/a35672819f8d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



