Return-Path: <netdev+bounces-78688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7B0876245
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 11:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9964EB20D13
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 10:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2489321106;
	Fri,  8 Mar 2024 10:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eeA1qsD4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005CCDF5B
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 10:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709894433; cv=none; b=igtc0zhHC/q3H7JYFtRMfGxi8JjqIShLVcG+wzdO1IKcB0h8Ri8TvhuEYM2cNkqbADZ9yhxfLEGrqpJWCkHNXXHckUSStu10/jsbV09oIcLgpOP2gAgZvl6nI+55rQCqqL8FGTMFMJalzxnLCX+qOV/2eK3oiXr89373VXR2DAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709894433; c=relaxed/simple;
	bh=CyktlwD6TQZxTz73Uyl6CtWKRIwoK8xfLb810xbZrjI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BbYRheW9z+ONuQcsKpxfKQBO8dIs+m7Gdd1fg0iR+4iFXumw9muk2wmCclQNJ7FJIe9cpe7lHCsZN9XND20zqS0AV8Vz7GqgR3ZywlIkqNr1S/H9HgCaBbAhRfFH+su6QpholJE3kxGgbH9CR3gmtsE4340Bh7m98xkzyoGrnSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eeA1qsD4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8DCA6C433F1;
	Fri,  8 Mar 2024 10:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709894432;
	bh=CyktlwD6TQZxTz73Uyl6CtWKRIwoK8xfLb810xbZrjI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eeA1qsD4cUsMgsqfIOc/UwnYguDHEcxfecIzDNZXpJg+XDqq4oUv6JmGWvn46I0DZ
	 UUfte/H+iB/724RgVRmeLoNMU9VUvi029qMpsUsQtGYQszMppETukqx8dQFUbHD+ul
	 qmCAcpfk4RtZJucIuqguLpTYBhLdcawrTK+YWZofpQ3A+TEU+ZbgYoQLBvEsgt/AHM
	 Bf9xBsRZ3Uil82fjgnJ6UNyu2hDwrx8LUHtiWS2yEj4TF+YCy+c0eMb+9bdBktnHHu
	 tH9ch84aOvUhAERMpIMUBOU+yoV7E7jlUR+SaZDhTE/arN+2FPZ7WXsGRbOf+bYGJ6
	 3qSBDcOZuQzeA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 726B2D84BB7;
	Fri,  8 Mar 2024 10:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/7] Support for nexthop group statistics
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170989443245.19391.9620032948431105004.git-patchwork-notify@kernel.org>
Date: Fri, 08 Mar 2024 10:40:32 +0000
References: <cover.1709727981.git.petrm@nvidia.com>
In-Reply-To: <cover.1709727981.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, idosch@nvidia.com,
 dsahern@kernel.org, horms@kernel.org, mlxsw@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 6 Mar 2024 13:49:14 +0100 you wrote:
> ECMP is a fundamental component in L3 designs. However, it's fragile. Many
> factors influence whether an ECMP group will operate as intended: hash
> policy (i.e. the set of fields that contribute to ECMP hash calculation),
> neighbor validity, hash seed (which might lead to polarization) or the type
> of ECMP group used (hash-threshold or resilient).
> 
> At the same time, collection of statistics that would help an operator
> determine that the group performs as desired, is difficult.
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/7] net: nexthop: Adjust netlink policy parsing for a new attribute
    https://git.kernel.org/netdev/net-next/c/2118f9390d83
  - [net-next,v4,2/7] net: nexthop: Add NHA_OP_FLAGS
    https://git.kernel.org/netdev/net-next/c/a207eab1039b
  - [net-next,v4,3/7] net: nexthop: Add nexthop group entry stats
    https://git.kernel.org/netdev/net-next/c/f4676ea74b85
  - [net-next,v4,4/7] net: nexthop: Expose nexthop group stats to user space
    https://git.kernel.org/netdev/net-next/c/95fedd768591
  - [net-next,v4,5/7] net: nexthop: Add hardware statistics notifications
    https://git.kernel.org/netdev/net-next/c/5877786fcf52
  - [net-next,v4,6/7] net: nexthop: Add ability to enable / disable hardware statistics
    https://git.kernel.org/netdev/net-next/c/746c19a52ec5
  - [net-next,v4,7/7] net: nexthop: Expose nexthop group HW stats to user space
    https://git.kernel.org/netdev/net-next/c/5072ae00aea4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



