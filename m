Return-Path: <netdev+bounces-33902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7BB7A0976
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 17:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0CC4B20E3A
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 15:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C099C18E28;
	Thu, 14 Sep 2023 15:30:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FCFD53F
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 15:30:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CCA83C433C9;
	Thu, 14 Sep 2023 15:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694705426;
	bh=Q3w4ykEz2lEoSofN+SUjn3Lth1qicuxOdvzXmwjElDc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=V7ZpHgLH0+pP0LQ20nb4Po9U5jDnLjpSoKh6Lz9Q+aE5oVg6Vu1mIJfsaS9u6S4SD
	 wy0WFNXZQ23HUUZ+VXyPosavhhRxlzBUs5kVtLFBbqScHWC93u4puDUQ0uSVfIdtxG
	 4vp/1WhIcStzgokacvADnZxW6NA35CC74Ik7aSFB4Y8ZO67fMOnypWjMv86T2YhQ/J
	 gBfJy8P63xcosxGKx08L3h5GTaBZGiJRWV7oH9Qi0D1r4XMsWgw/bJfA2EkYEkNNOB
	 KX/vRGhYYA0zjMtYrn6fbYbE7a6OYbxFOVJu1hfzAetJAwVHvJfTLql0hHaNVCGLch
	 a+1G1xEFHiTgg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B0A25E1C28E;
	Thu, 14 Sep 2023 15:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next 0/2] configure: add support for color
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169470542671.22890.15589088948266236796.git-patchwork-notify@kernel.org>
Date: Thu, 14 Sep 2023 15:30:26 +0000
References: <cover.1694625043.git.aclaudi@redhat.com>
In-Reply-To: <cover.1694625043.git.aclaudi@redhat.com>
To: Andrea Claudi <aclaudi@redhat.com>
Cc: netdev@vger.kernel.org, roopa@nvidia.com, razor@blackwall.org,
 bridge@lists.linux-foundation.org, stephen@networkplumber.org,
 dsahern@gmail.com

Hello:

This series was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Wed, 13 Sep 2023 19:58:24 +0200 you wrote:
> This series add support for the color parameter in iproute2 configure
> script. The idea is to make it possible for iproute2 users and packagers
> to set a default value for the color option different from the current
> one, COLOR_OPT_NEVER, while maintaining the current default behaviour.
> 
> Patch 1 add the color option to the configure script. Users can set
> three different values, never, auto and always, with the same meanings
> they have for the -c / -color ip option. Default value is 'never', which
> results in ip, tc and bridge to maintain their current output behaviour
> (i.e. colorless output).
> 
> [...]

Here is the summary with links:
  - [iproute2-next,1/2] configure: add the --color option
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=5e704f4b5ba2
  - [iproute2-next,2/2] treewide: use configured value as the default color output
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=b5d0273fdbab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



