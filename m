Return-Path: <netdev+bounces-155649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC80EA03429
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 01:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3C293A4502
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 00:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D575642A94;
	Tue,  7 Jan 2025 00:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BeIIriaC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17651E87B
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 00:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736211017; cv=none; b=igHKy0wb385qh0y3m9KxCEgsDQGAkyn34eDvqavwjbhA0/nTHaYyaRhWL28z6lLEt3F+D5dSmkUd5KqIvJf18Dr8y4JJRPschXVAiuJunbf2GgTRR++2OVX5W0Fxmwfmc9q6pG5ef6PxieOHjiIOqdpEAi8EH08m5m/1OURgeYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736211017; c=relaxed/simple;
	bh=DZOxcV6UwdFNPXg1JvSwPLr00kN831OemJsz/mr77d0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HdTAuF/EIfxmCJR+v951icfnYJr23ypE+zX02Mo2Er6F1+X9N8TYQlw3Ax/Na9a9dR9LfnB6TUwk9bIy3x+61RQkKnOFkhKwO5LRhFYpTt1nLI5QSUCrV91wl9+i16tYOiTjrss+xcrlamQDebHNGyTA8451LYg+jhkcMdazFew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BeIIriaC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CBD3C4CEDD;
	Tue,  7 Jan 2025 00:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736211017;
	bh=DZOxcV6UwdFNPXg1JvSwPLr00kN831OemJsz/mr77d0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BeIIriaCmHJVUSagTS3MmzCJMsKl7GMiq4IGf6wMJ1QLdcEvjA7QshsMyaz0Deh6k
	 is+COeNASCroW3e4JY/Bxo6TVhR+PK23hLyMzWZ7P7lcj90/PA/jZvm5UliMhJIGP/
	 EindXBVHogCWy3gJQKBP1LMvuJO2Sdt1UfmyrL31MXhFhP9ndI7UhRBKo7KxoucEkS
	 AgavfurjV6DTZPFcflSj9eY8SWedI5fDL59P2ODxJoseNBFWLSVklxVc7gTiHWuyZY
	 L6dhDpoywpfHBoH0HpTi0U/NSDwnW3xsYnYYrOd+xaeOUbHWzswZjZpi2EmwNEE3gl
	 lFVuGu5AG5VEg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE893380A97E;
	Tue,  7 Jan 2025 00:50:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/15] mlx5 Hardware Steering part 2
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173621103849.3663227.12395202026718737005.git-patchwork-notify@kernel.org>
Date: Tue, 07 Jan 2025 00:50:38 +0000
References: <20250102181415.1477316-1-tariqt@nvidia.com>
In-Reply-To: <20250102181415.1477316-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 saeedm@nvidia.com, gal@nvidia.com, leonro@nvidia.com, mbloch@nvidia.com,
 moshe@nvidia.com, kliteyn@nvidia.com, vdogaru@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 2 Jan 2025 20:13:59 +0200 you wrote:
> Hi,
> 
> Happy new year!
> 
> This series contain HWS code cleanups, enhancements, bug fixes, and
> additions. Note that some of these patches are fixing bugs in existing
> code, but we submit them without 'Fixes' tag to avoid the unnecessary
> burden for stable releases, as HWS still couldn't be enabled.
> 
> [...]

Here is the summary with links:
  - [net-next,01/15] net/mlx5: HWS, remove the use of duplicated structs
    https://git.kernel.org/netdev/net-next/c/020ca0abae4c
  - [net-next,02/15] net/mlx5: HWS, remove implementation of unused FW commands
    https://git.kernel.org/netdev/net-next/c/0647f27a5fac
  - [net-next,03/15] net/mlx5: HWS, denote how refcounts are protected
    https://git.kernel.org/netdev/net-next/c/0a1ef807a403
  - [net-next,04/15] net/mlx5: HWS, simplify allocations as we support only FDB
    https://git.kernel.org/netdev/net-next/c/c86963aae5b8
  - [net-next,05/15] net/mlx5: HWS, add error message on failure to move rules
    https://git.kernel.org/netdev/net-next/c/cc611ab6c712
  - [net-next,06/15] net/mlx5: HWS, change error flow on matcher disconnect
    https://git.kernel.org/netdev/net-next/c/1ce840c7a659
  - [net-next,07/15] net/mlx5: HWS, remove wrong deletion of the miss table list
    https://git.kernel.org/netdev/net-next/c/ad4da6cc36ac
  - [net-next,08/15] net/mlx5: HWS, reduce memory consumption of a matcher struct
    https://git.kernel.org/netdev/net-next/c/05e3c287b987
  - [net-next,09/15] net/mlx5: HWS, num_of_rules counter on matcher should be atomic
    https://git.kernel.org/netdev/net-next/c/61fb92701b8a
  - [net-next,10/15] net/mlx5: HWS, separate SQ that HWS uses from the usual traffic SQs
    https://git.kernel.org/netdev/net-next/c/2f851d1702dc
  - [net-next,11/15] net/mlx5: HWS, fix definer's HWS_SET32 macro for negative offset
    https://git.kernel.org/netdev/net-next/c/be482f1d10da
  - [net-next,12/15] net/mlx5: HWS, handle returned error value in pool alloc
    https://git.kernel.org/netdev/net-next/c/a105db854cf2
  - [net-next,13/15] net/mlx5: HWS, use the right size when writing arg data
    https://git.kernel.org/netdev/net-next/c/85ab9ea32548
  - [net-next,14/15] net/mlx5: HWS, support flow sampler destination
    https://git.kernel.org/netdev/net-next/c/663e61225c40
  - [net-next,15/15] net/mlx5: HWS, set timeout on polling for completion
    https://git.kernel.org/netdev/net-next/c/d74ee6e197a2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



