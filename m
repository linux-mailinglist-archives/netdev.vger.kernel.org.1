Return-Path: <netdev+bounces-135942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9AA99FDA5
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 03:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18A301F2627C
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 01:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523911714D7;
	Wed, 16 Oct 2024 01:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJdvKH4W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D281170A31
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 01:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729040425; cv=none; b=UdeQXA8SPPw6aGIp4lNWNAQ1Glodq3ZPD+JiXmm2fqgFmRWIefw9o4bvvateFcf8DBv48BScgsgdJk432qZK6IN+0q6WTjj38XtsnbWG9ou+VdH/e5Kww2n/8jngj2iiapNNsg8Qb57wRAdqTHUT0OEkjUzYs/ESTQL0UZtmpds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729040425; c=relaxed/simple;
	bh=rTRzcMCkTQsXpplOuTNDTiij0rnHUYqJx0ao1Ol4rg8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QP2zG0tQC7N+4gwccRl6qjqipzNWjm2JDY/XdzlJqCzwEmsUpD4Rc85EhyiyH047Gq3RTQjJpF+90UaUrp0k8klOj5SxvK3KAXoO3rnQZwaGKJVnWkpeYyisjYVMi7b7LgElAGHUcqMKYNcHPPBAsCALV/pUUC6q7boss9+9SE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJdvKH4W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC768C4CECD;
	Wed, 16 Oct 2024 01:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729040424;
	bh=rTRzcMCkTQsXpplOuTNDTiij0rnHUYqJx0ao1Ol4rg8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mJdvKH4WSZ0UsCAHJcWebnORkoPIwo/+KHdMD0dQY3IUWeJAAjZW8kXxr0a7IhcgN
	 hIZw2mSAOkFcwErUaCoWhciCrepYaGAN97tnj7d1Axo2nyFU4xLr5gzDswxocr5q5Q
	 n0ExqsrU/+h4OVpNJzZjkm//O0Urux/vPAul/FgUhrS7tCkpjh1VO2FpGGHGiFilWR
	 RezjQywrpHZL229Ho9o3+vqz3HSMBh3M5eG76La4vwgb7ph9GJgQKBmNoIIkI/2+9z
	 pnwnpSMbGyIm3ZNXJa2oyUdzh0/sOcHrcr/fCaTR2cOVoWmxKd1qMzApfzP2a1skZe
	 2NbD5l3ykki7Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C593809A8A;
	Wed, 16 Oct 2024 01:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] net: dsa: mv88e6xxx: Fix the max_vid definition for
 the MV88E6361
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172904042999.1343417.3919784497463626646.git-patchwork-notify@kernel.org>
Date: Wed, 16 Oct 2024 01:00:29 +0000
References: <20241014204342.5852-1-peter@rashleigh.ca>
In-Reply-To: <20241014204342.5852-1-peter@rashleigh.ca>
To: Peter Rashleigh <peter@rashleigh.ca>
Cc: andrew@lunn.ch, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 14 Oct 2024 13:43:42 -0700 you wrote:
> According to the Marvell datasheet the 88E6361 has two VTU pages
> (4k VIDs per page) so the max_vid should be 8191, not 4095.
> 
> In the current implementation mv88e6xxx_vtu_walk() gives unexpected
> results because of this error. I verified that mv88e6xxx_vtu_walk()
> works correctly on the MV88E6361 with this patch in place.
> 
> [...]

Here is the summary with links:
  - [v2,net] net: dsa: mv88e6xxx: Fix the max_vid definition for the MV88E6361
    https://git.kernel.org/netdev/net/c/1833d8a26f05

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



