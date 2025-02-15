Return-Path: <netdev+bounces-166636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1322BA36AC6
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 02:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C84023B1231
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 01:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2728C13AD1C;
	Sat, 15 Feb 2025 01:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1AdGvvf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA8913959D;
	Sat, 15 Feb 2025 01:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739582408; cv=none; b=fq2eJ41oBnZ52wS+jUs3322xHowd68sAY1VlNI2KRgB+QkBfXVYyJlCiFFiyBzjcp3f3xBacHxVER6ryG4I/Bmfz8UpHbveb7i4rg5yQmb0Q2k9k26oYn65fVXWQuNCP8USj079O03YY6//y0h607VN+SUU6QnE8frdBPu9PyXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739582408; c=relaxed/simple;
	bh=GBO4Qlpl/qCJ3d9C8ehLYRwmdLQPD/TuveUZYo8Yez4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GwYRa28dzTC6qiGQ38m1aauGp7hlVBCgcTlCELPD3krNHYg84H4orjZgCNJaRJfyhiITE74Si+ENbc9KLj/pUV1lHJEefZiCnWwnU+EJZB6ncymVZaLpzZuVrrbVeiqr644SAAmFbpED+NQN8p2oC57Cmos8FJy6nFu2JTzl9oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1AdGvvf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 770BEC4CED1;
	Sat, 15 Feb 2025 01:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739582407;
	bh=GBO4Qlpl/qCJ3d9C8ehLYRwmdLQPD/TuveUZYo8Yez4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=B1AdGvvf7yX10EOMM5PBVSdsX3PGgaPQCP75Sprm/lJpYNEVii9iN07CLoxWB4x6H
	 tvIUeeTo4r1OiljgJwjRzFJ3TPXzVQOCY5xxuSDdL/amVZI4IGTC6mRvRaZGu1+XnN
	 My11aTnT2GoOlX0h6Rr69xjx1MC3GFdjKgxRVEnLHOK6tOiD0cUUaMFStsBeCKP7dE
	 CONrIvUSih+/ZD/lvKZ6bXqY4gt7BZIlA70v0PAae7Ky5UemkOQududE0SsnfM3f71
	 62X4O3j7PZWqLfZ+V/rDkAhnFu97uVdzoPF9N4o6T1gCLUNpmgDpQ3BzE+OtLfjBCy
	 SPt+Zf1mEONvw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34020380CEE8;
	Sat, 15 Feb 2025 01:20:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] documentation: networking: Add NAPI config
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173958243677.2159741.17512963394003722673.git-patchwork-notify@kernel.org>
Date: Sat, 15 Feb 2025 01:20:36 +0000
References: <20250213191535.38792-1-jdamato@fastly.com>
In-Reply-To: <20250213191535.38792-1-jdamato@fastly.com>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, bagasdotme@gmail.com,
 pabeni@redhat.com, rdunlap@infradead.org, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, corbet@lwn.net,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 13 Feb 2025 19:15:34 +0000 you wrote:
> Document the existence of persistent per-NAPI configuration space and
> the API that drivers can opt into.
> 
> Update stale documentation which suggested that NAPI IDs cannot be
> queried from userspace.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> Acked-by: Jakub Kicinski <kuba@kernel.org>
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v3] documentation: networking: Add NAPI config
    https://git.kernel.org/netdev/net-next/c/bf1b8e0abc39

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



