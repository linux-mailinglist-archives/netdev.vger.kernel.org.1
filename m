Return-Path: <netdev+bounces-209157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7847B0E815
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 03:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A6C01C88589
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 01:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD6D19CC29;
	Wed, 23 Jul 2025 01:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyDU0mZf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A911A5BAE
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 01:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753234195; cv=none; b=DfTRR3mYHxcVNYzOgWs3VmLGeB5xYI0ZHBSJKc4fy9keK5DBSzbOxIaAn179l+qQBmE1GD9jjijMebLmW0FuyaHXln7hbLMbZwqx0vXhkD6rQWbF7cm+2dp2j5cwKi9X+hQATtRBfhdNmwpmtp16eA+XhVyr7+XlAZ0fKItz9qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753234195; c=relaxed/simple;
	bh=ZJ4o4zOvgVH+xjq304mGOhhr+zGRmm4CPF3hEi+ykYA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NRGJaDFMWupD1LOX8+N/0i7t7tczdRsG8vjbFatnhCQ7BDXpbPVEDm5mKPHRakKQCZ1WL+RPPmOZ4wG4MjHCc+4mhzq6bWHUBLlq7wYV3CnJ3l8EOhLTCe2fbgVtijtJwgpLhpWWuHMIYmxpVNJcMDNTDUxxPmSkUD2vS57+3Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyDU0mZf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 185B6C4CEF1;
	Wed, 23 Jul 2025 01:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753234195;
	bh=ZJ4o4zOvgVH+xjq304mGOhhr+zGRmm4CPF3hEi+ykYA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hyDU0mZfGs+vR8uVhENQswlVfmiMguryPC0I5jY5q3tCzDG8Geu3DauhqecEv2sms
	 TUavdgB9ayNRlDpnVoSfGuvJI0dyIZaoO6wrt5/MHmFIaXYb47PD4cccBuhHb78WPe
	 r+7/itRMnmi5bNwrkVBJOq1ONCuhR9H5SmFc2XBMJwsmjioKpqUesyCDDAPXS1OHy9
	 bRCNkzK8L3wObfd/2630I74AN9/d5Hbdte4Y125hVyiX7MVoxmCGoajy0kMfKCjqpc
	 WH6woy6ezxso04TxpptTO8Bu9OAydeenKS2j499JAeXKAyO1gvQ+THnuci2y7hsMF+
	 /P4lEfwOaqUuw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC17383BF5D;
	Wed, 23 Jul 2025 01:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/5][pull request] Intel Wired LAN Driver Updates
 2025-07-21 (i40e, ice, e1000e)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175323421349.1016544.2573519707976944136.git-patchwork-notify@kernel.org>
Date: Wed, 23 Jul 2025 01:30:13 +0000
References: <20250721173733.2248057-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20250721173733.2248057-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Mon, 21 Jul 2025 10:37:21 -0700 you wrote:
> For i40e:
> Dennis Chen adjusts reporting of VF Tx dropped to a more appropriate
> field.
> 
> Jamie Bainbridge fixes a check which can cause a PF set VF MAC address
> to be lost.
> 
> [...]

Here is the summary with links:
  - [net,1/5] i40e: report VF tx_dropped with tx_errors instead of tx_discards
    https://git.kernel.org/netdev/net/c/50b2af451597
  - [net,2/5] i40e: When removing VF MAC filters, only check PF-set MAC
    https://git.kernel.org/netdev/net/c/5a0df02999db
  - [net,3/5] ice: Fix a null pointer dereference in ice_copy_and_init_pkg()
    https://git.kernel.org/netdev/net/c/4ff12d82dac1
  - [net,4/5] e1000e: disregard NVM checksum on tgp when valid checksum bit is not set
    https://git.kernel.org/netdev/net/c/536fd741c7ac
  - [net,5/5] e1000e: ignore uninitialized checksum word on tgp
    https://git.kernel.org/netdev/net/c/61114910a5f6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



