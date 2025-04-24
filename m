Return-Path: <netdev+bounces-185360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FBEA99E8C
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 03:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 160FC445A3D
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 02:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FC11E1E1C;
	Thu, 24 Apr 2025 01:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qbj6izcx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3212701C3;
	Thu, 24 Apr 2025 01:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745459994; cv=none; b=FDbfiHKk/5JqGyVu/935FRsg/W8CtjNkkOnTjX+w2iPzyXDuTVATsNl4EL485kTOB6RbnQmanAwBOxy3iKIS4oryAQ7BELEJsmcpBRwjucopXUyZmWQO1mNnhwDo+IQFJ1TJ9FCqQ3AmYDH/1K/S694NtpULrHj1ZQ7IwPv0w0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745459994; c=relaxed/simple;
	bh=1W1Jj2+d2pbm+Myl9tfHiRl0IkewTco9yYLRqmZx87g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XC7lKprmEw+KobUT2f1jWHNshnXoerJ3KcChVIjDAWQFYI8OgFSnXspUh0p4oJmB2Xherf4mkBBeuYRiXv2vGJDgtiN9VKnWM7bSoxQEcKnNVow5kbC6JTUWrOfXxKJ9NvR+Uws6L3YUjyf7dbGnnur/VdUPMPdxvykIUf2+vTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qbj6izcx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E25D5C4CEE3;
	Thu, 24 Apr 2025 01:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745459993;
	bh=1W1Jj2+d2pbm+Myl9tfHiRl0IkewTco9yYLRqmZx87g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qbj6izcxEl3JIEU0CbFijWO+HVq+8WNdLpWHh/FkuTCwdFtODR4MppjWzgrMzAa14
	 N7PMLWERTaaOmYXgmpK83aoNfOscZ3CWVc9VjPl14YMCwa1kOvY9X/6lStpW1CVoed
	 neHOTddLSWzGuxl5elC/F8tU9c02oovHpNN+g/cX5wMn3jeLdWtfIB97wPxV6ZB/El
	 yvQfHH9pYzTE5Nx+4J9mptBUjS4FUSWyHtndkL9sblMzZCoWHZCSIU6b3aMIQDYWRa
	 egwFF5tiw8X/MqRG2od8q2gCEG0LL0EXgzU7Z37+nz/oZH89n9XbMMN9p7Z/HtxrUL
	 qO0on91h5UEUg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD21380CED9;
	Thu, 24 Apr 2025 02:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 net 0/4] pds_core: updates and fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174546003250.2831734.13519422006158210514.git-patchwork-notify@kernel.org>
Date: Thu, 24 Apr 2025 02:00:32 +0000
References: <20250421174606.3892-1-shannon.nelson@amd.com>
In-Reply-To: <20250421174606.3892-1-shannon.nelson@amd.com>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: andrew+netdev@lunn.ch, brett.creeley@amd.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 michal.swiatkowski@linux.intel.com, horms@kernel.org,
 jacob.e.keller@intel.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 21 Apr 2025 10:46:02 -0700 you wrote:
> This patchset has fixes for issues seen in recent internal testing
> of error conditions and stress handling.
> 
> Note that the first patch in this series is a leftover from an
> earlier patchset that was abandoned:
> Link: https://lore.kernel.org/netdev/20250129004337.36898-2-shannon.nelson@amd.com/
> 
> [...]

Here is the summary with links:
  - [v4,net,1/4] pds_core: Prevent possible adminq overflow/stuck condition
    https://git.kernel.org/netdev/net/c/d9e2f070d8af
  - [v4,net,2/4] pds_core: handle unsupported PDS_CORE_CMD_FW_CONTROL result
    https://git.kernel.org/netdev/net/c/2567daad69cd
  - [v4,net,3/4] pds_core: Remove unnecessary check in pds_client_adminq_cmd()
    https://git.kernel.org/netdev/net/c/f9559d818205
  - [v4,net,4/4] pds_core: make wait_context part of q_info
    https://git.kernel.org/netdev/net/c/3f77c3dfffc7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



