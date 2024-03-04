Return-Path: <netdev+bounces-77185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7222E870705
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 17:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CCC11C21DF0
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 16:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F122562F;
	Mon,  4 Mar 2024 16:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RnIlhmLh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647F71EA99
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 16:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709569828; cv=none; b=rN8Px6jHjwhjlC1TVXbuyAygDHkFbg/d+mkDl08nGYf8xJVuRlFy1WaMPoA9oG5g1WcFPcoiOUBybV5v9xPBtSZ0RDFfVfd5w7hVyu9t71v6nkG3M3DW2lG5wAdho311Jri6fDsF67L5ojGW4WI5iZVdM5Wbn73Ga/lItG+aVpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709569828; c=relaxed/simple;
	bh=DjIEY9IqHAkKo06O3Gue/smcit8+lZ48KrUj1GPX50o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cNREwKqhZ1gAQ5PFahA486T5X27urDfr7EU1Yp+VkjJQooO+h32bGnkwdaMiOO0ya7gnbDYV8SOTT78WtgOynfugvjKJza+jYeuVt4QxlTjazWbPv6RHaEYagABz9Bsj4t7bnobylJMVJ3jGb7v2yhb892VDDiYUn6bk0IvIxpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RnIlhmLh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30BA5C433C7;
	Mon,  4 Mar 2024 16:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709569828;
	bh=DjIEY9IqHAkKo06O3Gue/smcit8+lZ48KrUj1GPX50o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RnIlhmLhDJx7EN34qv80Mpp5jKiLfOD4Yo9oG2Y9MRQCYsv+MD0Lpp8R2Ai1ocsE2
	 2b/wIwFcIY6/2RgrfYBQeBhkpjocidRYtrRX3iLUtKUDHzMEtLbDxTtLq+s4hdEbUY
	 HO7KaLK8Bl+P6/qFk9n344Dfoz50YoSgtCSiT0i0hhYppiuhwVeGOn3wF/Kf7R43s6
	 5pYd0OMhU9gCNpYw9Dd+FY0H3vm+QilYpafj4BuhSU7tyRIxwC12JDos0u7txpcm7c
	 X41DVjBoN6wzgvRty4MmFMWpFo32w+Cd691XVTHXrqp9SrDWl583JtI+ss3dLdc2mH
	 Z1wTJRKUjh3bg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0717CD9A4BB;
	Mon,  4 Mar 2024 16:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] tc: Fix json output for f_u32
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170956982802.9053.17656032389692980233.git-patchwork-notify@kernel.org>
Date: Mon, 04 Mar 2024 16:30:28 +0000
References: <0106018e0957ab86-fb96e2a2-08a2-4e7d-b23c-e2ccff627d0c-000000@ap-northeast-1.amazonses.com>
In-Reply-To: <0106018e0957ab86-fb96e2a2-08a2-4e7d-b23c-e2ccff627d0c-000000@ap-northeast-1.amazonses.com>
To: Takanori Hirano <me@hrntknr.net>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Mon, 4 Mar 2024 12:02:04 +0000 you wrote:
> Signed-off-by: Takanori Hirano <me@hrntknr.net>
> ---
>  tc/f_u32.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - tc: Fix json output for f_u32
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=b8daf861a45d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



