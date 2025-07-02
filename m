Return-Path: <netdev+bounces-203396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC016AF5C06
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 17:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AB194A7994
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 15:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AE32D0C6E;
	Wed,  2 Jul 2025 15:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHqy0wjl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C032D0C65
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 15:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751468403; cv=none; b=n8ZxACirl3UO7XmrVelTlqfStGicdvVHdH4JSuwSShbwGnTpBFm76d34Vyda3Tal6IBQXtNO8IGQwUDzJ2f0J8muLUiMXjK3FAg7hbF7+GAxfZSdlfXu1Cw2E10HYGCRwd1q1EFwq99qeDLP9XZQTmE44KnOs0E/yHrP5zekBRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751468403; c=relaxed/simple;
	bh=6g2eecq0ydRb7QyId9Z/QMdDlzEHAch6LZVEgA1ub7A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CgKbLzTfblbV6bqomnU95pOF6DxBUxaTpaOM99S5H0SaQBbdCLUBv7Pxcgxs+5/B/U/X5wl4X1SNQkHdzGaj24LrPMyZAEeM0lnkIwbn1uUaDd6rGouvbwFUisWgaKaERQkv7rBoTT7iHTQEcXL+FiA7zMUnXcPAoIrigHv/5LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AHqy0wjl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 840F6C4CEED;
	Wed,  2 Jul 2025 15:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751468402;
	bh=6g2eecq0ydRb7QyId9Z/QMdDlzEHAch6LZVEgA1ub7A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AHqy0wjlTw6/AHbXKGISVg1p3+jv0p9xVIXMbDfne8KQM2pbXED6Y14XU5LG2xtUK
	 yyqkjomcLp28zrseCu9IN+0Hf/NUVjpxIl8+Sc0lvQdSxwMSNbSAHqC34xv6EsnNuv
	 gWCGDRY3yFrOGl9WmranRzYRKHdZahmB6WefTehUGsCUQ6hw9cCdZg9Wbof+Cuo97b
	 VZxmuLBHSq7NTS13mx3IclXw8kC1huKYtvtWRu89OUGsCSNEV/3oQe8n4/w4RphnB2
	 UcUh4Co731rD+yd3bWLsTaEVpkqrp/JPFpBP4wXLh7edn1iobCWdrKBljF4WvLTS1j
	 +SA5hiepoIL6g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33ECB383B273;
	Wed,  2 Jul 2025 15:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next 0/2] ip neigh: Add support for
 "extern_valid"
 flag
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175146842699.753088.3341392203351627196.git-patchwork-notify@kernel.org>
Date: Wed, 02 Jul 2025 15:00:26 +0000
References: <20250701144216.823867-1-idosch@nvidia.com>
In-Reply-To: <20250701144216.823867-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, dsahern@gmail.com, stephen@networkplumber.org,
 petrm@nvidia.com

Hello:

This series was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Tue, 1 Jul 2025 17:42:14 +0300 you wrote:
> Add support for the new "extern_valid" neighbor flag [1].
> 
> Patch #1 updates the uAPI headers.
> 
> Patch #2 adds support for the new flag. See the commit message for
> example usage and output.
> 
> [...]

Here is the summary with links:
  - [iproute2-next,1/2] Sync uAPI headers
    (no matching commit)
  - [iproute2-next,2/2] ip neigh: Add support for "extern_valid" flag
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=1ac42adcb600

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



