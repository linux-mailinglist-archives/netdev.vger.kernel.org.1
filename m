Return-Path: <netdev+bounces-183589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF30A9117E
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 04:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 976CD5A314C
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 02:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5ED61BEF97;
	Thu, 17 Apr 2025 02:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQ9o21z9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6481B4F0A;
	Thu, 17 Apr 2025 02:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744855796; cv=none; b=C1qAiGm4N0CnpLOmuudYk6dekBun9OzPYxQ2o3mYebklLCFn812YR+rXrCzYQYwfXq+r26bao9R0qqnPgeZ9Fj/hG8FIZvpEXheDwKjJ2772ug2EYyoRdPuCL/BCFLJUqOIvXov0MenbJahr+N0S5BVNJyGEorKUCbvHaknTRAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744855796; c=relaxed/simple;
	bh=wHr76QDxAEhZIgg5qTMRJYLiwzN19Xu4Le/+lGtj+4g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fGkk3+RWf/WDJoXX99/4j3/00vD/aaByKXGOSrC+38PM4AG2vj7JTVgQeJikVkNlVQWxuBNxTUvAtXl6STzjxV9hLvEJLH11mn43zH1ukUiLe/4/zKRm8nhi+T1UhSYVbgghutKDwB+7feAOfipgD+yTbbzLFxuRadYo3zhda4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQ9o21z9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 002A0C4CEE2;
	Thu, 17 Apr 2025 02:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744855796;
	bh=wHr76QDxAEhZIgg5qTMRJYLiwzN19Xu4Le/+lGtj+4g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iQ9o21z9HOmDHCvnLSa358y5knRsR0tpZLYmmYayPG0gy+FLk7xLkOrG75Xn3VnpS
	 y9rhJmMRJUbaUet5aYzUmpwTnY6s5qta0hVdwSTicrrtZOo6UsVlxsWzVlG2kG0hDl
	 yr1SfrVSJumRSDO7bpzYjKOkdhzh7JNE57NRu/fEQF7rV8vLA+nnTI8sAqPN/gP3+c
	 tbhW616lyKZtk7//PJSoTmSvTD+kzLUkm7U8TAFV7HW85ei6YHmD7awKWnFsINi7My
	 nfOz9vBMjZ+JcNCxSu6EnyMRS75BVWPM1217o31eCCpW8JJL6gJuWKrhSCflqxIdmG
	 yEHDC5B8LoZJQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D333822D5A;
	Thu, 17 Apr 2025 02:10:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 00/15][pull request] ixgbe: Add basic devlink
 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174485583401.3565086.14830971497597731589.git-patchwork-notify@kernel.org>
Date: Thu, 17 Apr 2025 02:10:34 +0000
References: <20250415221301.1633933-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20250415221301.1633933-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 jedrzej.jagielski@intel.com, przemyslaw.kitszel@intel.com, jiri@resnulli.us,
 horms@kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Tue, 15 Apr 2025 15:12:43 -0700 you wrote:
> Jedrzej Jagielski says:
> 
> Create devlink specific directory for more convenient future feature
> development.
> 
> Flashing and reloading are supported only by E610 devices.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,01/15] devlink: add value check to devlink_info_version_put()
    https://git.kernel.org/netdev/net-next/c/8982fc03fd63
  - [net-next,v2,02/15] ixgbe: wrap netdev_priv() usage
    https://git.kernel.org/netdev/net-next/c/fd5ef5203ce6
  - [net-next,v2,03/15] ixgbe: add initial devlink support
    https://git.kernel.org/netdev/net-next/c/a0285236ab93
  - [net-next,v2,04/15] ixgbe: add handler for devlink .info_get()
    https://git.kernel.org/netdev/net-next/c/f6b588af3d57
  - [net-next,v2,05/15] ixgbe: add E610 functions for acquiring flash data
    https://git.kernel.org/netdev/net-next/c/5f214150c76d
  - [net-next,v2,06/15] ixgbe: read the OROM version information
    https://git.kernel.org/netdev/net-next/c/70db0788a262
  - [net-next,v2,07/15] ixgbe: read the netlist version information
    https://git.kernel.org/netdev/net-next/c/904c2b4c0b48
  - [net-next,v2,08/15] ixgbe: add .info_get extension specific for E610 devices
    https://git.kernel.org/netdev/net-next/c/8210ff738077
  - [net-next,v2,09/15] ixgbe: add E610 functions getting PBA and FW ver info
    https://git.kernel.org/netdev/net-next/c/4654ec6194b2
  - [net-next,v2,10/15] ixgbe: extend .info_get() with stored versions
    https://git.kernel.org/netdev/net-next/c/6eae2aeb60b6
  - [net-next,v2,11/15] ixgbe: add device flash update via devlink
    https://git.kernel.org/netdev/net-next/c/a0f45672d5e1
  - [net-next,v2,12/15] ixgbe: add support for devlink reload
    https://git.kernel.org/netdev/net-next/c/c9e563cae19e
  - [net-next,v2,13/15] ixgbe: add FW API version check
    https://git.kernel.org/netdev/net-next/c/b5aae90b6b36
  - [net-next,v2,14/15] ixgbe: add E610 implementation of FW recovery mode
    https://git.kernel.org/netdev/net-next/c/29cb3b8d95c7
  - [net-next,v2,15/15] ixgbe: add support for FW rollback mode
    https://git.kernel.org/netdev/net-next/c/4811b0c220f2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



