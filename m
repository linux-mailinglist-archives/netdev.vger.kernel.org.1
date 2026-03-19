Return-Path: <netdev+bounces-269225-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODdwG09Hu2kliQIAu9opvQ
	(envelope-from <netdev+bounces-269225-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 01:46:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C01E72C42A6
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 01:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65ACA3057E9F
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 00:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E9D23536B;
	Thu, 19 Mar 2026 00:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="av43R+sX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1BF22AE65
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 00:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773881064; cv=none; b=ThdLmc8Oycd1OfW9/OL0mTEA0X+5ByS8bHDCjABFrqZ9OgclATZAwknI5Zit7z7LWN6NCEaHrB1G2xzPD/+q1JU1a7FwzHe2vpb/nKDYcHmu7nH2y/cumIvtcqUg2WVYzCLvqw7QtJhEDkOoO27q5Qm5KVpC1QlXoL0maz9DjtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773881064; c=relaxed/simple;
	bh=I2uG6lTR0u92FbBHtGwDQvq3CTjq2WTWyg2Br2qQTWY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KxUEi0e8ULdHPvjUBLgFFubxAsScTCz0Gjp3GDqUVzIP7+UYWd4rVQof5mvxP50Dzw+9DLi65w/HG8HIQNUtsEY/vyVSgWmD2HgnD+QmwCoweaFgG1J2fJMAE82R2RdookHAHWn+qLbSUXSBjPuMjErkOCYBwKI6LzX/0hfqkQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=av43R+sX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E3A9C19421;
	Thu, 19 Mar 2026 00:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773881064;
	bh=I2uG6lTR0u92FbBHtGwDQvq3CTjq2WTWyg2Br2qQTWY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=av43R+sXBR1le4fWLgxLBRCiotn8FzH5Yfd0uFnZ76C9CVCbSIofJJBrPLs7bfqFF
	 1CJfes1H55lSO0xEYCnu/yRLowuF06MwSZze5cflwUHcvs8vqkS6wEFqRkDKT8mUCS
	 O43ZV1iqbIzrpE0Ds+sdxvMq7TJeyqf0uyxLH37ywKo0kAmIxSjkCdi+jLgb9Z4jEx
	 Y0eOz/8HO2h3ZXjGk0Ay9StMIOunnn32PVNI1nZTk8gjZ/GyV/v3Fk1AxLPeij6HDZ
	 kMyHLn/iZ17Eouf76jI9sANDGuyeZ5Rzs0+0+EB/6zoXqwov0h/0Nyp77Jt7tufPG2
	 O21Y7it4lFjpA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FF253808200;
	Thu, 19 Mar 2026 00:44:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4][pull request] Intel Wired LAN Driver Updates
 2026-03-17 (igc, iavf, libie)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177388105578.935482.379989549950382241.git-patchwork-notify@kernel.org>
Date: Thu, 19 Mar 2026 00:44:15 +0000
References: <20260317211906.115505-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20260317211906.115505-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269225-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.981];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C01E72C42A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Tue, 17 Mar 2026 14:19:01 -0700 you wrote:
> Kohei Enju adds use of helper function to add missing update of
> skb->tail when padding is needed for igc.
> 
> Zdenek Bouska clears stale XSK timestamps when taking down Tx rings on
> igc.
> 
> Petr Oros changes handling of iavf VLAN filter handling when an added
> VLAN is also on the delete list to which can race and cause the VLAN
> filter to not be added.
> 
> [...]

Here is the summary with links:
  - [net,1/4] igc: fix missing update of skb->tail in igc_xmit_frame()
    https://git.kernel.org/netdev/net/c/0ffba246652f
  - [net,2/4] igc: fix page fault in XDP TX timestamps handling
    https://git.kernel.org/netdev/net/c/45b33e805bd3
  - [net,3/4] iavf: fix VLAN filter lost on add/delete race
    https://git.kernel.org/netdev/net/c/fc9c69be5947
  - [net,4/4] libie: prevent memleak in fwlog code
    https://git.kernel.org/netdev/net/c/6850deb61118

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



