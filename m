Return-Path: <netdev+bounces-187410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4804AAA700C
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 12:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3FDD7A9D0E
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 10:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896B923BCE3;
	Fri,  2 May 2025 10:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WpdjQKv0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F6C79D2
	for <netdev@vger.kernel.org>; Fri,  2 May 2025 10:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746183004; cv=none; b=AMh7P8dgsIbdCwXRygEbaY6cGUNzoA5z31VcaUce440s+u6Qgy82CGA8ahzGTyho9/sz5PbA77rJYi1grC73iPm+btoBCs7amn/sd5WMAXjukgQHcXw/ToRH9z4Sp8aUeiQrzufHD9nOPlJeK5jDyzkyyxyCIwKqzoeYYV8z6Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746183004; c=relaxed/simple;
	bh=XqxvwkczJLwMWdzTgjLSJtIt5i54UJ8RB8+j78ynTSk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CK1oOmihRfYk3gZ5dJouk0ozFKzUH0UrwRLjO6vDMX95zY9o4ki7MxtOUT1cuwkrWgcsdlMceDg2l3Yxe9wLs/Qi6GbVzr11ZNUNlbMliLaIJd2XUL0NW2ZkwY2+thm4X2hKnApW6kyktf5uTvfB6CiYLBzu8vgLpR1pFMJbWsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WpdjQKv0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6650C4CEE4;
	Fri,  2 May 2025 10:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746183003;
	bh=XqxvwkczJLwMWdzTgjLSJtIt5i54UJ8RB8+j78ynTSk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WpdjQKv0RB5Je8cWwh1RDdz2VQB+oFoIlHwMD7FWpTq12qyk5t8RZB7CdrA28v0qP
	 XI4jQEHp8aFBIT7F4scJwDZsnTKdJqJX1dJLUhKVENlri/5B1H6QENcWMxGTUh5NGZ
	 3ry0+yn+t3aBX4WideWVaNzI85NwpFwfWiiFht2z6GdloZGit1+aQt5kJw7ufjWpcP
	 3j2pGJTf68Uv173lvVhWWRkBolK7q3DusjZKoQJBi1S9/k0iqaie+J5p/Hd/lSGCyh
	 tmKSIgFIwVNH6lXQZ8ryTumQ+dqVUHkgYGWKGeKXpkLYsvbXHjl7tJpziBogTZKovz
	 jeU6MByZlqx4g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BC63822D61;
	Fri,  2 May 2025 10:50:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 00/12] tools: ynl-gen: additional C types and
 classic netlink handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174618304300.3576625.13148490893846898306.git-patchwork-notify@kernel.org>
Date: Fri, 02 May 2025 10:50:43 +0000
References: <20250429154704.2613851-1-kuba@kernel.org>
In-Reply-To: <20250429154704.2613851-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, jacob.e.keller@intel.com, sdf@fomichev.me,
 jdamato@fastly.com, nicolas.dichtel@6wind.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 29 Apr 2025 08:46:52 -0700 you wrote:
> This series is a bit of a random grab bag adding things we need
> to generate code for rt-link.
> 
> First two patches are pretty random code cleanups.
> 
> Patch 3 adds default values if the spec is missing them.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,01/12] tools: ynl-gen: fix comment about nested struct dict
    https://git.kernel.org/netdev/net-next/c/a6471da7745a
  - [net-next,v3,02/12] tools: ynl-gen: factor out free_needs_iter for a struct
    https://git.kernel.org/netdev/net-next/c/2286905f1b33
  - [net-next,v3,03/12] tools: ynl-gen: fill in missing empty attr lists
    https://git.kernel.org/netdev/net-next/c/d12a7be02524
  - [net-next,v3,04/12] tools: ynl: let classic netlink requests specify extra nlflags
    https://git.kernel.org/netdev/net-next/c/fe7d57e040f7
  - [net-next,v3,05/12] tools: ynl-gen: support using dump types for ntf
    https://git.kernel.org/netdev/net-next/c/bbfb3c557c66
  - [net-next,v3,06/12] tools: ynl-gen: support CRUD-like notifications for classic Netlink
    https://git.kernel.org/netdev/net-next/c/49398830a4aa
  - [net-next,v3,07/12] tools: ynl-gen: multi-attr: type gen for string
    https://git.kernel.org/netdev/net-next/c/0ea8cf56cc20
  - [net-next,v3,08/12] tools: ynl-gen: mutli-attr: support binary types with struct
    https://git.kernel.org/netdev/net-next/c/3456084d6361
  - [net-next,v3,09/12] tools: ynl-gen: array-nest: support put for scalar
    https://git.kernel.org/netdev/net-next/c/18b1886447d6
  - [net-next,v3,10/12] tools: ynl-gen: array-nest: support binary array with exact-len
    https://git.kernel.org/netdev/net-next/c/5f7804dd8326
  - [net-next,v3,11/12] tools: ynl-gen: don't init enum checks for classic netlink
    https://git.kernel.org/netdev/net-next/c/18d574c8dd3e
  - [net-next,v3,12/12] tools: ynl: allow fixed-header to be specified per op
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



