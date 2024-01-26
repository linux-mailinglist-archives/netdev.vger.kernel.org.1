Return-Path: <netdev+bounces-66062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C69EE83D1FA
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 02:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 353DDB260B2
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 01:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65A0EC3;
	Fri, 26 Jan 2024 01:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r64hxKWq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932C94430
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 01:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706232027; cv=none; b=jPSdYPs2mfQQqJ1KMqeBm1N26ClOoDbft3u80IZTWjO7iz1DFsp9i51IPp77LOLeEq1IdAfuHVVf582QFjNnv6lktpUlrvEDGxTaBa8QuPGqnc7FmK/+OZKgABcT+qxCl2s/+d31KMUkI5I/5GeUEfV/dGgjLiJ8tqk8pHpPxcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706232027; c=relaxed/simple;
	bh=TsNfnW+nCkKOSG/MWTFa/UaZcAj73mhR/ME8Pw0lERY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tugIrEBPgNwawak9QO9JwuD2Z8asYjZTLN3cwxgnc8r/5IT0k69JydqwtRxdlKekugheI2YLZdbsDPbWCJyEktV1GcigHK4xM+FsLj7ufIMkt7VXd0MCq92ple5eb4odV+oH/bNbm+0HBMDBmv7oBAaF7ql8UKvFRRBvNO9bL0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r64hxKWq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1B545C433A6;
	Fri, 26 Jan 2024 01:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706232027;
	bh=TsNfnW+nCkKOSG/MWTFa/UaZcAj73mhR/ME8Pw0lERY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=r64hxKWqEkIiFd4//Y43ya0hERmSy3PVDW9iPStUvf7RKadmGVFKHkliF2qLqFjHk
	 Qz0DCAZB3pId99Mu9vUvNheGD5GXZtrp9Uk0vPV9XG7TNTYyP67uM2zAnrGhX9e414
	 C9+0wWOQzxjbvgseYXX4x9r8x7F22jVmZHq70dogNbbS5HYrR5VbfF/ppmtfOY30EH
	 2NRbk57e5kgvApwcSaN9rtIXERAI9Un8myQHDuGQlvK68sj/llG2g/QKykfkE4ZY/4
	 q6v11o7MowJ17GKXEZXvAuM0SZ78y17ppLY2Zo6mtxi8xmryj6XJB8PmKkRWQHxHHz
	 kauGYJjsfhLrw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 06DBBDFF767;
	Fri, 26 Jan 2024 01:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] selftests: Updates to fcnal-test for autoamted
 environment
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170623202702.2360.14065316965878551084.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jan 2024 01:20:27 +0000
References: <20240124214117.24687-1-dsahern@kernel.org>
In-Reply-To: <20240124214117.24687-1-dsahern@kernel.org>
To: David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, kuba@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Jan 2024 14:41:14 -0700 you wrote:
> The first patch updates the PATH for fcnal-test.sh to find the nettest
> binary when invoked at the top-level directory via
>    make -C tools/testing/selftests TARGETS=net run_tests
> 
> Second patch fixes a bug setting the ping_group; it has a compound value
> and that value is not traversing the various helper functions in tact.
> Fix by creating a helper specific to setting it.
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] selftest: Update PATH for nettest in fcnal-test
    https://git.kernel.org/netdev/net-next/c/ad9b701aed48
  - [net-next,2/3] selftest: Fix set of ping_group_range in fcnal-test
    https://git.kernel.org/netdev/net-next/c/79bf0d4a07d4
  - [net-next,3/3] selftest: Show expected and actual return codes for test failures in fcnal-test
    https://git.kernel.org/netdev/net-next/c/70863c902d76

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



