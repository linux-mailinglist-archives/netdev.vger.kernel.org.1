Return-Path: <netdev+bounces-217573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 295C5B39159
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 04:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 270AB7A4DE5
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 01:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8597F242D7D;
	Thu, 28 Aug 2025 02:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TIeh+3Xq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AC22417FB
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 02:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756346404; cv=none; b=YMp9n8OoghwUQffm6pj3H7id0JH0esqnod2+4DFb7lafgfDCXgy8IyDl92fd2pyxil3of6qrYDERaPWeMs3vkCHm4O/KaPTyY/iaimB6bcrnFfjRoYP9dk2xSgo2kmDnLxPXXhnvISINJBeNrQzyDy4NYkkisF5K5Z/oRLriLJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756346404; c=relaxed/simple;
	bh=eSgcDa8KYaeKkH7Q3cnmkq6tBsPLPvVvOydP/A7esuc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=p4PSRJy+avQh/DsFqTzc6jwu51bJ0VnCoEd2B4Ul6KisoKiZkQ5BT2pbBsC6g0Dikm0nI0jcWkuFcNS3A2vaXngiEbNRGKkONP5dEt5tdSlTNBxpII3ww544/hFOYdnGydYXQpEU5Dxh1XdKRqr6bgX2bE5hV9eNUITPeyBRcdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TIeh+3Xq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3872C4CEEB;
	Thu, 28 Aug 2025 02:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756346404;
	bh=eSgcDa8KYaeKkH7Q3cnmkq6tBsPLPvVvOydP/A7esuc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TIeh+3XqvZTDQLEppx8K9PBZjdf9OrbAH/vVGMRSncxq1G6iPNpW/3UQHyVUCFqa0
	 kRxsaM765mLK6ONCxfD0X5n4swRnPzjMLRwOACQgdadlsJdxx4j4byOAMgEMIXRPME
	 FnTFffMXbnIIwJCitQKcMXoRbwnT7l1hW/1i2WzLmB4qA5FdhYqCeMnDEH5xbvWAWZ
	 Y7VYO+ScuVyq9zFJYQucnCPnGp439lxTByRHcrvI1qqcNk+DBxfTgfwLIgFackh1Mv
	 BECrlP1EPzUnpqaDJ5Q0dXRe+x04fn/oTAmWAz1xwTT/4t0zcni3uhmPYZzWjEUvfR
	 eyUDK+Dan0q3Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 340FD383BF76;
	Thu, 28 Aug 2025 02:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PATCH 0/2] Locking fixes for fbnic driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175634640901.908900.44301486574429233.git-patchwork-notify@kernel.org>
Date: Thu, 28 Aug 2025 02:00:09 +0000
References: 
 <175616242563.1963577.7257712519613275567.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <175616242563.1963577.7257712519613275567.stgit@ahduyck-xeon-server.home.arpa>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: AlexanderDuyck@gmail.com, netdev@vger.kernel.org, kuba@kernel.org,
 kernel-team@meta.com, andrew+netdev@lunn.ch, pabeni@redhat.com,
 davem@davemloft.net

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 25 Aug 2025 15:56:00 -0700 you wrote:
> Address a few locking issues that were reported on the fbnic driver.
> Specifically in one case we were seeing locking leaks due to us not
> releasing the locks in certain exception paths. In another case we were
> using phylink_resume outside of a section in which we held the RTNL mutex
> and as a result we were throwing an assert.
> 
> 
> [...]

Here is the summary with links:
  - [net,1/2] fbnic: Fixup rtnl_lock and devl_lock handling related to mailbox code
    https://git.kernel.org/netdev/net/c/2ddaa562b465
  - [net,2/2] fbnic: Move phylink resume out of service_task and into open/close
    https://git.kernel.org/netdev/net/c/6ede14a2c636

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



