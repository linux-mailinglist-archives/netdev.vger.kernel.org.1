Return-Path: <netdev+bounces-71944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEB685596A
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 04:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BC841C21DF7
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 03:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE60523A;
	Thu, 15 Feb 2024 03:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSnDfWyP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A58B6FB8
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 03:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707966631; cv=none; b=gRXAYK+TS7Lqb6T2w/TkIWOE5ugqg1PFJvzqePOkF7nn0BUnrm6SVOYELSmOmMgBfd3uKQakCx1gITNLaGT10EuJbbGKGQWutxVswHatOu3ua9xJElziTc+Wj+oCG7R9urFislmx938sFkeS3Z2Q7/EzIzmL5FUaewtmU45PVp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707966631; c=relaxed/simple;
	bh=1PNHPkUyRJ97SEMaxlYfwLJY4j8Mpbjy+L4WYPDnkaM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ou6pIy4Mmt8d1GUkYEynK35D9WA1qRp9+wpmBS8yjOlci6WzZCvZ3Xh3rlybKmcHW0BPhCduI/o7T8DNQNuJR9qpR0pmCCq8ghH/ZW/iUeU4m5KgmMbRdSy3U1XPbmHzIGPxEJq+DbWHBex1z/MZTNzkc06Q8QUstAs2cikWeYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSnDfWyP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48CD3C43394;
	Thu, 15 Feb 2024 03:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707966631;
	bh=1PNHPkUyRJ97SEMaxlYfwLJY4j8Mpbjy+L4WYPDnkaM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OSnDfWyPADwgTokurvBt+c4CJcfVhTL/LSB37wFzOMKpPOBwrCgaDLFo0Ts8EK/2x
	 lt8J2IFeChFz6nJctI1AaayRn32yqAuv6W++jhQ08+fBh4XVmRm+0gz2ScwzqF3I46
	 v2gQAum2lFhFtYA/06it9TVaOAZ8WHJ4R9jiIhWhYQfMfPxZIdFAERFdxGEXl/W34b
	 /jN7C0R9mmz7sVYhd1tjrEkRNfbKCPr0rpVgIl8T//AwVt3PXb5BDsNrCCCCOVy+OO
	 tSIXALyCjpMyww8cDwurj+4CXnQuhSZY4jhvgcevXyQvt+Xrljzjet7rxmNNOk+a6l
	 dvZJmzcgwoXMA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 266C2C04D3F;
	Thu, 15 Feb 2024 03:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] iproute2: fix type incompatibility in ifstat.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170796663115.31705.16484870056665450467.git-patchwork-notify@kernel.org>
Date: Thu, 15 Feb 2024 03:10:31 +0000
References: <20240206165246.875567-2-sgallagh@redhat.com>
In-Reply-To: <20240206165246.875567-2-sgallagh@redhat.com>
To: Stephen Gallagher <sgallagh@redhat.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org, dsahern@kernel.org,
 aclaudi@redhat.com

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Tue,  6 Feb 2024 11:52:34 -0500 you wrote:
> Throughout ifstat.c, ifstat_ent.val is accessed as a long long unsigned
> type, however it is defined as __u64. This works by coincidence on many
> systems, however on ppc64le, __u64 is a long unsigned.
> 
> This patch makes the type definition consistent with all of the places
> where it is accessed.
> 
> [...]

Here is the summary with links:
  - iproute2: fix type incompatibility in ifstat.c
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=d9b886d745ad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



