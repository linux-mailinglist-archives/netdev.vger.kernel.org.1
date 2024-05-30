Return-Path: <netdev+bounces-99245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DB68D433A
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 04:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34C331C22FF9
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 02:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA298175AA;
	Thu, 30 May 2024 02:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTrxBreE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59E928E8
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 02:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717034432; cv=none; b=UOpvb7LlJfx/5JluQ9VXwLkPZAhGbCxaE3Is7S3zXexJHbhbKhncxynaW8qgi29MySmskYVXYNrHTETU+zcB9GZolKXlfIhKiPt1pJq0cBUhGfr+vqETH3FD9lnVUe2ECQA/W3I/htuc9cLfx9NGeWFb2wAeHgLQ9quj9w95UvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717034432; c=relaxed/simple;
	bh=iPp/HulNL8ukpi1ckrLviOp0s9fbhNMkYuDp7qErsVU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Z80kT/S6vmUbm2BO+u2chKrkazQ0EXVsTBeCrqTRg1cRnmqZXV6iu9ztweFM9jK9z5yWm5Dhq8L+S5N5pELwCJLgROAlBVnXXgd0f/mBLb6ECE1uIO4hMKuuKPCk20pBw3TFdp+XjJp9ugp4rzRIQxwInhtht+YXmp8ski9/3v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTrxBreE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4EFBBC32789;
	Thu, 30 May 2024 02:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717034432;
	bh=iPp/HulNL8ukpi1ckrLviOp0s9fbhNMkYuDp7qErsVU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NTrxBreEqj9Em38eTNHaENTVS7/xSi1HGmZcQ1Luf66OCgRH3NbM7+OG/sVpMhyUM
	 qtN/UapnbHfseR7Op5pOOdmCEWFXyF5wxSRriqpeININ4u1u8I5p7+EPVO0d3mNfdZ
	 tKBv8cMyNEMlmyWVLeKdsnfQvl0G4oTCCWKvMHSX7Wn8DA317VH3Lxd5d7IwYd72Sz
	 TbJJoyMbEdCAuuE0m6fpBvdtqYLYhP53/pM6dZVHKmSt81DfCOpqSgN6tuq1zgF81q
	 LkcXdJsBa6p480/70zeqfm7zXoN593Oc11bNV45rkWZbEDu5RzcdgvlKXF3eHb76CT
	 l/muVVd8exCMw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3A16ACF21E0;
	Thu, 30 May 2024 02:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/8] Intel Wired LAN Driver Updates 2024-05-28 (e1000e,
 i40e, ice)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171703443223.3291.12445701745355637351.git-patchwork-notify@kernel.org>
Date: Thu, 30 May 2024 02:00:32 +0000
References: <20240528-net-2024-05-28-intel-net-fixes-v1-0-dc8593d2bbc6@intel.com>
In-Reply-To: <20240528-net-2024-05-28-intel-net-fixes-v1-0-dc8593d2bbc6@intel.com>
To: Keller@codeaurora.org, Jacob E <jacob.e.keller@intel.com>
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 hui.wang@canonical.com, vitaly.lifshits@intel.com,
 naamax.meir@linux.intel.com, horms@kernel.org, pmenzel@molgen.mpg.de,
 anthony.l.nguyen@intel.com, rui.zhang@intel.com, thinhtr@linux.ibm.com,
 rob.thomas@ibm.com, himasekharx.reddy.pucha@intel.com,
 michal.kubiak@intel.com, wojciech.drewek@intel.com,
 george.kuruvinakunnel@intel.com, maciej.fijalkowski@intel.com,
 paul.greenwalt@intel.com, michal.swiatkowski@linux.intel.com,
 brett.creeley@amd.com, przemyslaw.kitszel@intel.com,
 david.m.ertman@intel.com, lukasz.czapnik@intel.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 May 2024 15:06:03 -0700 you wrote:
> This series includes a variety of fixes that have been accumulating on the
> Intel Wired LAN dev-queue.
> 
> Hui Wang provides a fix for suspend/resume on e1000e due to failure
> to correctly setup the SMBUS in enable_ulp().
> 
> Thinh Tran provides a fix for EEH I/O suspend/resume on i40e to
> ensure that I/O operations can continue after a resume. To avoid duplicate
> code, the common logic is factored out of i40e_suspend and i40e_resume.
> 
> [...]

Here is the summary with links:
  - [net,1/8] e1000e: move force SMBUS near the end of enable_ulp function
    https://git.kernel.org/netdev/net/c/bfd546a552e1
  - [net,2/8] i40e: factoring out i40e_suspend/i40e_resume
    https://git.kernel.org/netdev/net/c/218ed820d364
  - [net,3/8] i40e: Fully suspend and resume IO operations in EEH case
    https://git.kernel.org/netdev/net/c/c80b6538d35a
  - [net,4/8] i40e: Fix XDP program unloading while removing the driver
    (no matching commit)
  - [net,5/8] ice: fix 200G PHY types to link speed mapping
    https://git.kernel.org/netdev/net/c/2a6d8f2de222
  - [net,6/8] ice: implement AQ download pkg retry
    (no matching commit)
  - [net,7/8] ice: fix reads from NVM Shadow RAM on E830 and E825-C devices
    (no matching commit)
  - [net,8/8] ice: check for unregistering correct number of devlink params
    https://git.kernel.org/netdev/net/c/a51c9b1c9ab2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



