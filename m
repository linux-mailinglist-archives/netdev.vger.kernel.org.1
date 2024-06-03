Return-Path: <netdev+bounces-100222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D05018D8345
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 15:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D7001C245C5
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 13:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D836F130A46;
	Mon,  3 Jun 2024 13:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3ClA1DC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFAC1304B0;
	Mon,  3 Jun 2024 13:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717419630; cv=none; b=bn2J3jKOcOxN6NQ5BXxqKCZz+EyFyla8lPhkwLlKpiXaxN9FGyDjglqYqt9JrSRqZp7nH0sXIlQ6v7wZEXGisYr14GyDJ57sVOsa0kfCtseJMVor4w/u6rfHA5ddeHk2cLsJlSYHnI81TLQX6w0TqmVJfKp2/WD0Sl6bJnkFOB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717419630; c=relaxed/simple;
	bh=Q72Tv4sMGNv7GdLHS+0Z8Gj75xba7+6TdHAU/WbXGv0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XihazXCvWHWhvpXbyyIyB0wpCW43irEACnfBLJloRqHaXya7CIuHGc8d37TomHppTeiRAzzijb1urtxdufpXCVTKOqxfxlSpTIeK5R4/0lcMz5EPvULH2kxT1TP//uSNcfqPTSxVLb2ssRucx1RQIbnXmMhamkcYMzQ7fdqO3gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3ClA1DC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3D635C4AF0D;
	Mon,  3 Jun 2024 13:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717419630;
	bh=Q72Tv4sMGNv7GdLHS+0Z8Gj75xba7+6TdHAU/WbXGv0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=M3ClA1DCUwD/Ezv4Q06mEushpDezB61obknyzvuAS8ALyV1Fs4dE0B+Ku3seRqT8w
	 Ar77fYgWcvwtiqax5Ro/9Bbqd9TRWJYlzqw5UcqBicbCMed1cXfHuYPZdS4HyuywBR
	 W8wC6fVK92tEzniCe/ZgoS8699cCmPc1B8IgG/VyuE90q/HTfZOeKeRiZkescqnksx
	 WIq1GbJyOHbHNl+52kTvq11vizXJaBqtD9acV1ys2JcRxE1h696LiAbNK25wTdwR2x
	 6N/K25thMumMVfm7zQrVK9UP9SDDPv1J60XmbgmlcwJOXMwaQanFPLrotsf9DFfFOX
	 3tJoK0wWv3vZQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2B295C43617;
	Mon,  3 Jun 2024 13:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] Bluetooth: Add vendor-specific packet classification for
 ISO data
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171741963017.17349.14932650657966489507.git-patchwork-notify@kernel.org>
Date: Mon, 03 Jun 2024 13:00:30 +0000
References: <20240529080123.2146946-1-yinghsu@chromium.org>
In-Reply-To: <20240529080123.2146946-1-yinghsu@chromium.org>
To: Ying Hsu <yinghsu@chromium.org>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 pmenzel@molgen.mpg.de, horms@kernel.org,
 chromeos-bluetooth-upstreaming@chromium.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, johan.hedberg@gmail.com,
 marcel@holtmann.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 29 May 2024 08:00:00 +0000 you wrote:
> When HCI raw sockets are opened, the Bluetooth kernel module doesn't
> track CIS/BIS connections. User-space applications have to identify
> ISO data by maintaining connection information and look up the mapping
> for each ACL data packet received. Besides, btsnoop log captured in
> kernel couldn't tell ISO data from ACL data in this case.
> 
> To avoid additional lookups, this patch introduces vendor-specific
> packet classification for Intel BT controllers to distinguish
> ISO data packets from ACL data packets.
> 
> [...]

Here is the summary with links:
  - [v4] Bluetooth: Add vendor-specific packet classification for ISO data
    https://git.kernel.org/bluetooth/bluetooth-next/c/d33224ba26e5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



