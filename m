Return-Path: <netdev+bounces-83095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A789C890BA9
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 21:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D91B01C2A5CD
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 20:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D05513BC13;
	Thu, 28 Mar 2024 20:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZlOpwlp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A5613BC11
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 20:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711658432; cv=none; b=pd+QMoSbxWES3yf2jUgfm3mayr7nuq+aKmnquiWc85iQDospJj07KAnFs7qhhlBSNUrAmySCxDzwmwrqQQFsKOfc35+ucllIMKYgYwPYtxPdDBQl7YnJRCpWpBXBuWdhoAIPsdI3PIswk14sCbMhQkJq+ZhVq41YyBwu6CTEB/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711658432; c=relaxed/simple;
	bh=S1lh7Vxb/c5vVnR08C64jz/z1rosTYcySMFM4PKjYwI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XFzHCWbiuxQmiFUFtt/lBzmfmjWxLCo5IB1iNL1x2z6atFvABal1auWeINqosKhovnf5GsInyGivP6k3xzUBw+oNNY73/Jv1Bq9Iy4X7yhpwJ2Lz0Tz5b5hZ0VyFwu+44ZEJCu3EILMR/H5aisOXz03bIbf7qFXLavTpDS3JoAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZlOpwlp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C2365C43394;
	Thu, 28 Mar 2024 20:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711658431;
	bh=S1lh7Vxb/c5vVnR08C64jz/z1rosTYcySMFM4PKjYwI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JZlOpwlpEDwj2m15hdKH51TW1koptW4LhLlXiLAHqwwVsSJPCtQptsMI7gMBgr427
	 jJDtP3evXhFqQrpVzwf1d06bQJZhr8/7Fg9L/+h5d+4rkYowcIwXpBjMkFvl4vdW3T
	 czJT1lqcG0dIxDU9d+3SATYLEsMmkxXX7zUtTuCtL936aaKcv6qInRWl4pTQF0/oxs
	 PWQBSlkT5FNZJGHz1LVdW+6Kk1VE3Yy/yCOjdHyGZvtfTaKcXdQ0ma6IdNQwHLlBgK
	 0UjKYea+xQ6gIwJTtooaoGgLcAoiArEUcGf/2d8WYXSmErCXDnhslJ6y9708t8Dp3Y
	 3ZLFWziLyl75g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A508FD2D0EB;
	Thu, 28 Mar 2024 20:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next v3] arpd: create /var/lib/arpd on first use
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171165843167.18759.4507315679247342362.git-patchwork-notify@kernel.org>
Date: Thu, 28 Mar 2024 20:40:31 +0000
References: <20240318155038.29080-1-mg@max.gautier.name>
In-Reply-To: <20240318155038.29080-1-mg@max.gautier.name>
To: Max Gautier <mg@max.gautier.name>
Cc: netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Mon, 18 Mar 2024 16:49:13 +0100 you wrote:
> The motivation is to build distributions packages without /var to go
> towards stateless systems, see link below (TL;DR: provisionning anything
> outside of /usr on boot).
> 
> We only try do create the database directory when it's in the default
> location, and assume its parent (/var/lib in the usual case) exists.
> 
> [...]

Here is the summary with links:
  - [iproute2-next,v3] arpd: create /var/lib/arpd on first use
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=f740f5a165eb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



