Return-Path: <netdev+bounces-40586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B3E7C7BAF
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 04:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B60DD2825B3
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 02:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDAB365;
	Fri, 13 Oct 2023 02:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZuprr37"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0E1A57
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 02:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 593B9C433C9;
	Fri, 13 Oct 2023 02:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697164823;
	bh=/A4ub9BKY22rIJcA0EZMLKRgPQDTZ3VfoEdlgCvyhpY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lZuprr37YR7/ME2b8CGtosHM3k3g95Z8IA/OCthW1BnZ61U8wSX7AFBGGoFUTfh54
	 g2nkYICcdQ0AY72YgpoIL5//qZixGAGvwJYyvUAZd8d/cla3ViWpKYgEP01xpBl3q+
	 jJ0EoSohL4MYdDkDKLZIztY8k+PqtQvrtqGq2g5DUNiCarm4YVhudyQZzmlCwThi8g
	 fr1LghNop/z8lde1O5pYziGDNmU+dV65PhS6sdMs9oKbCnJx0cDXX5jc+DsC2xiJRx
	 3mEIiJAwse4fAlCpKMd0jjfMA9XUv5wkGUr16GGcMq8l/UBkukidJDUnprNuQqWCj5
	 DnGPU6+0T8FbQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3F013E11F41;
	Fri, 13 Oct 2023 02:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2] bridge: fdb: add an error print for unknown command
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169716482325.8025.6745747640034207795.git-patchwork-notify@kernel.org>
Date: Fri, 13 Oct 2023 02:40:23 +0000
References: <20231010095750.2975206-1-amcohen@nvidia.com>
In-Reply-To: <20231010095750.2975206-1-amcohen@nvidia.com>
To: Amit Cohen <amcohen@nvidia.com>
Cc: netdev@vger.kernel.org, mlxsw@nvidia.com, dsahern@gmail.com,
 stephen@networkplumber.org, razor@blackwall.org, roopa@nvidia.com

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Tue, 10 Oct 2023 12:57:50 +0300 you wrote:
> Commit 6e1ca489c5a2 ("bridge: fdb: add new flush command") added support
> for "bridge fdb flush" command. This commit did not handle unsupported
> keywords, they are just ignored.
> 
> Add an error print to notify the user when a keyword which is not supported
> is used. The kernel will be extended to support flush with VXLAN device,
> so new attributes will be supported (e.g., vni, port). When iproute-2 does
> not warn for unsupported keyword, user might think that the flush command
> works, although the iproute-2 version is too old and it does not send VXLAN
> attributes to the kernel.
> 
> [...]

Here is the summary with links:
  - [iproute2] bridge: fdb: add an error print for unknown command
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=f1160a0f6bb3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



