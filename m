Return-Path: <netdev+bounces-103489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 349EB908494
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 09:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C877A1F27544
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 07:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB67F152504;
	Fri, 14 Jun 2024 07:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A325mebd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B5014C5AA;
	Fri, 14 Jun 2024 07:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718349629; cv=none; b=tjKgUMLr8bhTlZDrCga4feTS/uTCu8g6ulHFWfuHrL0a9k+yy8fPri++OBxFYPITZKdFGYG+HqbtP1iBD3CdHAdCn3kscSOm/FQn4MRIPEZh2stc+y/3YaM7PCttZkRNtdhu+R34Dgg6Xqf1iUJJPUv1CkVlCeRUb5T6XCFL7fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718349629; c=relaxed/simple;
	bh=hRxqWcCgi9JZtDRPGn928JjQaj3mLuhJoMunGrc/QKg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MSlYgSa/DEGBZj9SaHqmqawrb4KsQT96+ji8SW7dp6cx2YR5PQ/7u6NmbQsg69LzO7NIk6cYi2xJNCDIvc3XLkXoQb/O/QMxV1NblAy5SDB0kiiTbD2ZRmLgOinEytvYNiOCYoq315w531DmmyunQLYmCtGWwFLvaXUFqEfuURM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A325mebd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 084EEC4AF1C;
	Fri, 14 Jun 2024 07:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718349629;
	bh=hRxqWcCgi9JZtDRPGn928JjQaj3mLuhJoMunGrc/QKg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=A325mebdCom/N5YSXMa2qk7voJOmAzLBJrEwPVNlWmkoGUGmCIfZ6goeV40qeKsTL
	 KornJMfmE25dWKB9t+SILn8jR2XeaD/MaICKBhQEh0dlogj8/CqirVEGFckWubVZXR
	 tVzHgXwy8C4486RZEccfkCDj4VJGgebdaQ2jB3bb4rc9AnoO8X+1LbJcUUsXIWUWAi
	 tKryi7aGK+PAlFxp9YOYwHbO8NNg5aJnjFN4rKH3DeukKsda3Somsy5HJzZ9Ev5u5X
	 Hr0fknvRDTEZ0AVMcfYuE0WFPtc7N6kjR+S5B1H+5QpyWkOVloa5O2K4ejbdWUhvTw
	 PUXXMLmdaXLOQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EAB20C43616;
	Fri, 14 Jun 2024 07:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/2] cipso: make cipso_v4_skbuff_delattr() fully remove the
 CIPSO options
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171834962895.31068.8051988032320283876.git-patchwork-notify@kernel.org>
Date: Fri, 14 Jun 2024 07:20:28 +0000
References: <20240607160753.1787105-1-omosnace@redhat.com>
In-Reply-To: <20240607160753.1787105-1-omosnace@redhat.com>
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: paul@paul-moore.com, netdev@vger.kernel.org,
 linux-security-module@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  7 Jun 2024 18:07:51 +0200 you wrote:
> This series aims to improve cipso_v4_skbuff_delattr() to fully
> remove the CIPSO options instead of just clearing them with NOPs.
> That is implemented in the second patch, while the first patch is
> a bugfix for cipso_v4_delopt() that the second patch depends on.
> 
> Tested using selinux-testsuite a TMT/Beakerlib test from this PR:
> https://src.fedoraproject.org/tests/selinux/pull-request/488
> 
> [...]

Here is the summary with links:
  - [v2,1/2] cipso: fix total option length computation
    https://git.kernel.org/netdev/net/c/9f3616991233
  - [v2,2/2] cipso: make cipso_v4_skbuff_delattr() fully remove the CIPSO options
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



