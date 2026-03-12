Return-Path: <netdev+bounces-266849-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJ0DKvEismnlIwAAu9opvQ
	(envelope-from <netdev+bounces-266849-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 03:20:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A439F26C29C
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 03:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 51EB53014904
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 02:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61634346E7A;
	Thu, 12 Mar 2026 02:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KK0zQIeY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3E7345CAE
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 02:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773282026; cv=none; b=Ufinkefbm5agY2LsdkXM7CDGpK2UlzI5lGCTNIBKNdy43JvsxjkxDscptetyehQZTTVR+nkw1txTp1KhCtBDG/iRGilQ9M8/GbNzYGyqcyFor5+Xj+TthrwCec2Q/gBTUEu76azrZHdFe03NVaGjTNKPiZWoOoUmys2N0z39Czk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773282026; c=relaxed/simple;
	bh=keXmw9uly/4mYwu7iT2FK8vGVYkRt/4fG/tF2JHef4c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IJcT9Rz8F7tEs4tFCobvNpQZUlBBcuzXd/5onTLmNHymHTehYe5I6V4pXSF295//NDXDqbcqbhoxTRMRNqsPFoMVMxCznktFZT1IbgG4i4ephu4Ns+8Pj7hyFPJ+fmcpwGoZ56dfjj722iqzLdXUXJu86/fm5izBoaG03zlzTOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KK0zQIeY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFB5DC19425;
	Thu, 12 Mar 2026 02:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773282025;
	bh=keXmw9uly/4mYwu7iT2FK8vGVYkRt/4fG/tF2JHef4c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KK0zQIeYDdqKX4tjvfRhh9Ze69JM9nwetATIcSIuaWxgBjpFVqsjYB+/8C703Z95p
	 K10XfUnwmxc41evE35UAPp66damzRRnx5HVT1Z1AkDWBFNQd8thFAGba0+03ePDlgX
	 YvgWfaPIK3i54zLv8zSmzDnMKCpuUiWlNzEXG0W1RN+KW6SfIDaqUgFFQro4hFLnL2
	 AWuzVRnGyVrLmFe1spsA4e4waeUHr0jXqj7uBWxp3Rd64QBoVwyYMUCBQOIGYrS9ph
	 UuFjiAmxOAqmsWF8hxoB3NSUU7ifd3eswkpAwgFXy+7tT5lj5Wevd0JF3MRSJxKKTX
	 U+AxYV2R/tEfQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02EA73808200;
	Thu, 12 Mar 2026 02:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/5][pull request] Intel Wired LAN Driver Updates
 2026-03-10 (ice, iavf, i40e, e1000e, e1000)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177328202154.3908053.9940727876356544405.git-patchwork-notify@kernel.org>
Date: Thu, 12 Mar 2026 02:20:21 +0000
References: <20260310205654.4109072-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20260310205654.4109072-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266849-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: A439F26C29C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Tue, 10 Mar 2026 13:56:48 -0700 you wrote:
> Nikolay Aleksandrov changes return code of RDMA related ice devlink get
> parameters when irdma is not enabled to -EOPNOTSUPP as current return
> of -ENODEV causes issues with devlink output.
> 
> Petr Oros resolves a couple of issues in iavf; freeing PTP resources
> before reset and disable. Fixing contention issues with the netdev lock
> between reset and some ethtool operations.
> 
> [...]

Here is the summary with links:
  - [net,1/5] drivers: net: ice: fix devlink parameters get without irdma
    https://git.kernel.org/netdev/net/c/bd98c6204d11
  - [net,2/5] iavf: fix PTP use-after-free during reset
    https://git.kernel.org/netdev/net/c/efc54fb13d79
  - [net,3/5] iavf: fix incorrect reset handling in callbacks
    https://git.kernel.org/netdev/net/c/fdadbf6e84c4
  - [net,4/5] i40e: fix src IP mask checks and memcpy argument names in cloud filter
    https://git.kernel.org/netdev/net/c/e809085f4928
  - [net,5/5] e1000/e1000e: Fix leak in DMA error cleanup
    https://git.kernel.org/netdev/net/c/e94eaef11142

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



