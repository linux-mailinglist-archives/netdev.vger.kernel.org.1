Return-Path: <netdev+bounces-225446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A746EB93AAA
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 02:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AECC91892267
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 00:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6509224F6;
	Tue, 23 Sep 2025 00:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rkNPbgh4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18FC1DFFD
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 00:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758586222; cv=none; b=i+gpHv5knW6/FUd1FJR725P4hOwPEdMEtvX0qmiBy8WWpyW05u04JKYTsFXSbhlacRmIedTI6ZRNZiHt5CFz9b1AbHexstBazPXKMiIHxaBQbgPYdA68K3IFX7ODtAdY5jgN+Qm6+XveUuqoX+pps01C2j1Rcxw3OFrK0UllIJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758586222; c=relaxed/simple;
	bh=2wfn4VnpHMKyOPQmKaXddYoe5WwmcptruDUjGUfNUqk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Y+FeddqQ7P/pbrV5yDnBx0EBjJ97pn7MV37LwIXRApqNAtsZRQRkeQZ/m7iLftZcmFyn6atUoUIMEGkO5s6oie9nuORnaTN8mkRq3RbS55yu3fZhSr5jRMbFeiG4QE3qtnA28g3uMEgOK5blrGM3ugv6Y6TxV/NtIGR1u2ZcwLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rkNPbgh4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4344CC4CEF0;
	Tue, 23 Sep 2025 00:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758586221;
	bh=2wfn4VnpHMKyOPQmKaXddYoe5WwmcptruDUjGUfNUqk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rkNPbgh4CgU0bAnubfD4TPBHsOOTfTvi9UGVlt2VT24TbOupp5b+HsmaCBNR+1pdg
	 g9TroTt9LGzSXI8wYO/NK012tdjSisKEuZVHRWMp9Ei1tNKbEqoTotK5xj+sv3e176
	 +3J4krUFrf/DhMgztZM0iKNuyXmzxs/h9VdvWO2xJTZRRNDawErIcPnJoBbsdUbiqh
	 r3/PMnXF4rn6SIqYaGP4D/TzNE6ea3x38VDVaCNYcPIYFuzpBGY4VFSwm40E1rQCAK
	 CDMzgSkOWcqUeF+tTHO23BsH4IinjSyqjVdGY9OvOjWtoA9Gn9Wkggg5xKETJpkDJA
	 yGUAtvlVD041g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE2D39D0C20;
	Tue, 23 Sep 2025 00:10:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/7][pull request] Intel Wired LAN Driver Updates
 2025-09-19 (ice, idpf, iavf, ixgbevf, fm10k)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175858621873.1201993.11577712160345178300.git-patchwork-notify@kernel.org>
Date: Tue, 23 Sep 2025 00:10:18 +0000
References: <20250919175412.653707-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20250919175412.653707-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Fri, 19 Sep 2025 10:54:03 -0700 you wrote:
> Paul adds support for Earliest TxTime First (ETF) hardware offload
> for E830 devices on ice. ETF is configured per-queue using tc-etf Qdisc;
> a new Tx flow mechanism utilizes a dedicated timestamp ring alongside
> the standard Tx ring. The timestamp ring contains descriptors that
> specify when hardware should transmit packets; up to 2048 Tx queues can
> be supported.
> 
> [...]

Here is the summary with links:
  - [net-next,1/7] ice: move ice_qp_[ena|dis] for reuse
    https://git.kernel.org/netdev/net-next/c/3b8606193d43
  - [net-next,2/7] ice: add E830 Earliest TxTime First Offload support
    https://git.kernel.org/netdev/net-next/c/ccde82e90946
  - [net-next,3/7] ice: Remove deprecated ice_lag_move_new_vf_nodes() call
    https://git.kernel.org/netdev/net-next/c/34138ea02a60
  - [net-next,4/7] idpf: add HW timestamping statistics
    https://git.kernel.org/netdev/net-next/c/7a5a03869801
  - [net-next,5/7] iavf: fix proper type for error code in iavf_resume()
    https://git.kernel.org/netdev/net-next/c/c4f7a6672f90
  - [net-next,6/7] ixgbevf: fix proper type for error code in ixgbevf_resume()
    https://git.kernel.org/netdev/net-next/c/a460f96709bb
  - [net-next,7/7] net: intel: fm10k: Fix parameter idx set but not used
    https://git.kernel.org/netdev/net-next/c/99e9c5ffbbee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



