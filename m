Return-Path: <netdev+bounces-55384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DD980AAFC
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 18:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 519E9B20B05
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 17:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1C53B2B6;
	Fri,  8 Dec 2023 17:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p1I5aU7j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AF83B2AC
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 17:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13C71C433C8;
	Fri,  8 Dec 2023 17:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702057224;
	bh=d0vxU4erDsg0DUqSnM1UblqFAs6gKRWrsCKFyLBnTrQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p1I5aU7jSXvuAoNcTYf0RyQpaUK8b96CqVwRZpMrhCT4XxfXm+Fqy+rGGIf7daSbc
	 3EXyoL56QKtiWt0eEc7XNhiSbywc71PpswGtknzMLIzifngSOendCxoWm+tVL/YsAR
	 TMl1cXU4ttdgt7J4+lfqbuMm4VKtDg52qdyaRKslWC8kOIIb+nz+9qdT/KZT46tCjI
	 Oh9Ag0ik7qIv6L9PT+b6P8w+4FcOjbHW2G5qrU1eRN6uxkbyZEh5TgnU7COaB/v3IT
	 uOHzcIKyppyKAle+vVJA7DdndJ4P8gZpVSDXEiP6KoaxAISfKto2O2h1H39txSu4Xi
	 /C6/ToouKFsDQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F3054C04DD9;
	Fri,  8 Dec 2023 17:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [patch iproute2] mnl_utils: sanitize incoming netlink payload size in
 callbacks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170205722399.30055.11742878911600548646.git-patchwork-notify@kernel.org>
Date: Fri, 08 Dec 2023 17:40:23 +0000
References: <20231207125351.965767-1-jiri@resnulli.us>
In-Reply-To: <20231207125351.965767-1-jiri@resnulli.us>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org, dsahern@gmail.com,
 moche@nvidia.com

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Thu,  7 Dec 2023 13:53:51 +0100 you wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Don't trust the kernel to send payload of certain size. Sanitize that by
> checking the payload length in mnlu_cb_stop() and mnlu_cb_error() and
> only access the payload if it is of required size.
> 
> Note that for mnlu_cb_stop(), this is happening already for example
> with devlink resource. Kernel sends NLMSG_DONE with zero size payload.
> 
> [...]

Here is the summary with links:
  - [iproute2] mnl_utils: sanitize incoming netlink payload size in callbacks
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=1a68525f4613

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



