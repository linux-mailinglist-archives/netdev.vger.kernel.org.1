Return-Path: <netdev+bounces-38525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 410DD7BB4E7
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 12:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95D7D2821C4
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 10:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1D114F8C;
	Fri,  6 Oct 2023 10:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OWOuNoYe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11FA14F86
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 10:10:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3CAA7C433BD;
	Fri,  6 Oct 2023 10:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696587028;
	bh=WR/PgFkNFK9PQRdVL+XsgCw6AazGO6RJ3xBu3K4EZUU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OWOuNoYeisUlLXu1l0bQj6FCPXXo6p0fG/3eDTzUmhRGGM/7EcNOCJoTrRSyWv9DU
	 kvfrjNPRS9sdFxjRkiA7F4qwHGEu0u1ylDFiRklPKzWxF6E9nl2Zbd0B5dwEZXw4bB
	 Ynala4MPJ9VpJ1lpLoNwbCcLrWGFbjGHyVG6YWapqBvKyCDd87G79JxA1b8lGsCAeB
	 lgR+LIQnoXJwykhRDpNMXmxCIe5vrq5zIuFovr8eJb+qZ6xUuFJRN4o2LyH/lOzsbW
	 Z0qUPa2ZFpBZjTBLKliOkJ4Hp0u5m13WhtV8FIQJSeKYGROyA1Z463HdYjeoEPdm7H
	 5SvSL4z0Ny/tw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 24100E22AE3;
	Fri,  6 Oct 2023 10:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] mlxsw: Control the order of blocks in ACL region
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169658702814.26383.16353008934884886778.git-patchwork-notify@kernel.org>
Date: Fri, 06 Oct 2023 10:10:28 +0000
References: <cover.1696330098.git.petrm@nvidia.com>
In-Reply-To: <cover.1696330098.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, idosch@nvidia.com,
 amcohen@nvidia.com, mlxsw@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 3 Oct 2023 13:25:25 +0200 you wrote:
> Amit Cohen writes:
> 
> For 12 key blocks in the A-TCAM, rules are split into two records, which
> constitute two lookups. The two records are linked using a
> "large entry key ID".
> 
> Due to a Spectrum-4 hardware issue, KVD entries that correspond to key
> blocks 0 to 5 of 12 key blocks will be placed in the same KVD pipe if they
> only differ in their "large entry key ID", as it is ignored. This results
> in a reduced scale, we can insert less than 20k filters and get an error:
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] mlxsw: Mark high entropy key blocks
    https://git.kernel.org/netdev/net-next/c/cad6431b8675
  - [net-next,2/5] mlxsw: core_acl_flex_keys: Add a bitmap to save which blocks are chosen
    https://git.kernel.org/netdev/net-next/c/0a67b7a0ec36
  - [net-next,3/5] mlxsw: core_acl_flex_keys: Save chosen elements per block
    https://git.kernel.org/netdev/net-next/c/545535fd30dc
  - [net-next,4/5] mlxsw: core_acl_flex_keys: Save chosen elements in all blocks per search
    https://git.kernel.org/netdev/net-next/c/900f4285bbc2
  - [net-next,5/5] mlxsw: core_acl_flex_keys: Fill blocks with high entropy first
    https://git.kernel.org/netdev/net-next/c/c01e24936d16

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



