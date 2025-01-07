Return-Path: <netdev+bounces-155653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF935A03445
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 02:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0D4D3A4AE8
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 01:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F347771750;
	Tue,  7 Jan 2025 01:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBnMBlIa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28292E634;
	Tue,  7 Jan 2025 01:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736211615; cv=none; b=R7K7ngRWnOI1FANIefYM4EvLeZ4fVnfAAhqISKh8sq4Zq6wXZjk0IP0CJRmwHqm99lJb0EwsjhoTrtD8SkVzuYwHhSRw0UKJLLokKb69AN3sENV+6coUp+G/EZb54nT/X+nmETJ+YSBUgWP9LL/VWI9YBrdZ8PsgEaVJB4UTJrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736211615; c=relaxed/simple;
	bh=NXuUHsI/RbQ8Ve/bTmhy5Sy+As+riV2ovAAwXov3foI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oV2lFlxuuiDuyWo1L0/QjERSiKgP/ooVfLLAWegPYJ+gxqYaX1o0kmQEzMoLHP0HRDEc9tk18QHfAGngmFHRebSxq04+3C9g6chL53Cu3dqGhiUzu1vMtwQc1BxD4/rd3Rtsf/WIIVf+fsCtei7qye7hTobhgt6x/rJuUWoafes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBnMBlIa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48640C4CED2;
	Tue,  7 Jan 2025 01:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736211615;
	bh=NXuUHsI/RbQ8Ve/bTmhy5Sy+As+riV2ovAAwXov3foI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jBnMBlIafLLGZGZTzzUXw7T3eWQe5YPtVuZW+fJkiGNNUWSvHUz8czifBLMuM93yW
	 qfCpRw6EfsspQnriJWT7O+mZ8MrU363Ue90aCfOktrYrsiAPxRypunEszAARemii/h
	 WvCRx3BAvd3wgd7VoQglh6udtyINUFfCkfTiLn3gVZ14OeQ6maF+Fq/JLfLDxI0OQe
	 uyq58q5+d2qKX8O7Z+fu1IVpIOc6/zHOxpfxwSXB7K0z/ePcSqSc4qvIFj9m/bnlj7
	 jfwlqZQnGlWSIWyfvryAuoeR148i4yTLyUWZ+fq11Dau1vPEHa2NXZTE+uaWRJKPz8
	 i7X3ntpnTVI5g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEDB380A97E;
	Tue,  7 Jan 2025 01:00:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] octeontx2-pf: mcs: Remove dead code and semi-colon from
 rsrc_name()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173621163648.3665137.6074342929999257204.git-patchwork-notify@kernel.org>
Date: Tue, 07 Jan 2025 01:00:36 +0000
References: <20250104171905.13293-1-niharchaithanya@gmail.com>
In-Reply-To: <20250104171905.13293-1-niharchaithanya@gmail.com>
To: Nihar Chaithanya <niharchaithanya@gmail.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 hkelam@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, sd@queasysnail.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  4 Jan 2025 22:49:15 +0530 you wrote:
> Every case in the switch-block ends with return statement, and the
> default: branch handles the cases where rsrc_type is invalid and
> returns "Unknown", this makes the return statement at the end of the
> function unreachable and redundant.
> The semi-colon is not required after the switch-block's curly braces.
> 
> Remove the semi-colon after the switch-block's curly braces and the
> return statement at the end of the function.
> 
> [...]

Here is the summary with links:
  - [v2] octeontx2-pf: mcs: Remove dead code and semi-colon from rsrc_name()
    https://git.kernel.org/netdev/net-next/c/49afc040f4d7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



