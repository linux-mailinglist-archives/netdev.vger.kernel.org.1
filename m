Return-Path: <netdev+bounces-134434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 342499997EC
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 02:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6273B244B8
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 00:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2674B198A35;
	Fri, 11 Oct 2024 00:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uXgpHmEm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A50175AB
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 00:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728606624; cv=none; b=Ja9GvX2FfkS/78x+VGMiFajWnhPkq5mxf8jXLD/gPL/62sjPKhbtblPygnu7YacSCnDRZ5kW5z1jw6vYq1uI63uOFK3iNd3QS6QYXD98uWgo1sJl/VYt+0NeAFemL5WS46irVAHga1QMCOYG6zUnZsntVLVHVhHUmMVdTECNT7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728606624; c=relaxed/simple;
	bh=brQeJzBD++WJvMb64OfYRoRsCxvuM6Qw8E5RGWKZAms=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NA+hgvzcx+u7k95GDO9+jso2LwSxFpTmNVdDpy0DqRI4Tn6j0lys5jPjODOLG0uSxZJoCXGnFgFCEm68M/5GoRAVA6SLwokLlPrWbRJR/wa/DKNvdsfOElbMwlzbQIBvQzFi8j+TKoLnrZgqNohLkRI50pNkmlUeCat6edrHqYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uXgpHmEm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 857B4C4CEC5;
	Fri, 11 Oct 2024 00:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728606623;
	bh=brQeJzBD++WJvMb64OfYRoRsCxvuM6Qw8E5RGWKZAms=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uXgpHmEmKLSs8buaVEJ2nlhvQy3FFDX7AU2YrP5m7axInOxruMgA5w4xxstEh6XGi
	 ACadWkAOhtpXmG/LBWBnmt7A6H2U/Ik7WcEQtcLHRe3/yUtP8h029k3pOQnVj2eDmV
	 +e6MYCc9qsJrSft3XLFIBcxhMJ1hqgA0b730N+4Q0h2hzuK+aUwJiLu+/Qy1jNu78z
	 aTwBkyt8QMrnOL66/XuKuaLkaY/p9p0i+ury9ASNzc5EV7SXOlm4I8bFXLFnZTBtle
	 triAPxkiSbjWjK26v3EFw4KIyPtfJKoYbe2mZtRfyaklf0h+F6ApmqJaxY9HLAiP0z
	 Go5wpMbccCaCw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C783803263;
	Fri, 11 Oct 2024 00:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next 0/2] iprule: Add DSCP support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172860662802.2221191.16278388821170752825.git-patchwork-notify@kernel.org>
Date: Fri, 11 Oct 2024 00:30:28 +0000
References: <20241009062054.526485-1-idosch@nvidia.com>
In-Reply-To: <20241009062054.526485-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, dsahern@gmail.com, stephen@networkplumber.org,
 gnault@redhat.com, petrm@nvidia.com

Hello:

This series was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Wed, 9 Oct 2024 09:20:52 +0300 you wrote:
> Add DSCP selector support to ip-rule following kernel support that was
> added in kernel commit 7bb50f30c123 ("Merge branch
> 'net-fib_rules-add-dscp-selector-support'").
> 
> Patch #1 adds ip-rule(8) as generation target so that we could use
> variable substitutions there in a similar fashion to other man pages.
> 
> [...]

Here is the summary with links:
  - [iproute2-next,1/2] man: Add ip-rule(8) as generation target
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=8ef80bcbbd21
  - [iproute2-next,2/2] iprule: Add DSCP support
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=75e760026c4d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



