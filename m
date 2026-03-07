Return-Path: <netdev+bounces-265011-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAf1La2Gq2n/dgEAu9opvQ
	(envelope-from <netdev+bounces-265011-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 03:00:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C86F2298CC
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 03:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C9DA5300D681
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 02:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD902C031E;
	Sat,  7 Mar 2026 02:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3y7va+v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B23217723
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 02:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772848811; cv=none; b=e0Z3dFBLZzlucCJmTUGxxf+Um8oII+j3oXaLYzArZGitQmF19N7yQ8The0wSfpbUjNPfT6UVMn4Zqo1orPok0cbJO4EI7LYcg0rz68jLfEvQcsOR/ue54VOUyMGow+9EOqTBDLRMomtZ+NWhiLUQ4FndLTBsX73uY3hYALfq84I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772848811; c=relaxed/simple;
	bh=Q6fKxYeCVlrVBat5UFnra6aUzWBCHUjijrrqyQYJVJk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rVEisfrFwEomYkMgwSAg19SDn9JZ5w/Q8DksgoIEy5AFRKg8or7ySHrc0yMdMzdv1mBQFN4ASYjqi0JLLenXVHLW774IptQ9wFSlWvbiXCgDBZ3+4CfdyEBd+UxfABQGi+xtkuk/tCTQklSGnoVBsWoALV990XBS0epPHX0QVPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3y7va+v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7E53C4CEF7;
	Sat,  7 Mar 2026 02:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772848810;
	bh=Q6fKxYeCVlrVBat5UFnra6aUzWBCHUjijrrqyQYJVJk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=b3y7va+vqtaClVFUy5sLtXEgAivbNfaK7lIN85DE5sCrPdSs+2y6r4Mjiy9RRx3wU
	 9HAR+/Aq5oWDBq/GQ0e6TBEg/FL7D+Vmj+AkdwS5eA+TPO2TSm43lkCkl68m7JwI6v
	 qgAfCrzWInkTTZo7JtPs3kavggNOAir1OtR6O1OLDHwm97DIix5wPK9LPZLfabwA9D
	 k9uDV4tMH3IPrZw5e584zAnx9mBH/KfHbj8lE99eUaO2p+vSPhK30MyS5sDehHYRpG
	 7RORCsU3ZrlDHvl6CMgWHZJccAcep1Gl5UUilBKaSrIZkovS0k5bUPGeDZm26lnPdP
	 DYasOTkNkd16w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02CD13808200;
	Sat,  7 Mar 2026 02:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] Further SJA1105 phylink link replay fixups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177284880980.123899.682744620861454371.git-patchwork-notify@kernel.org>
Date: Sat, 07 Mar 2026 02:00:09 +0000
References: <20260304220900.3865120-1-vladimir.oltean@nxp.com>
In-Reply-To: <20260304220900.3865120-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk
X-Rspamd-Queue-Id: 2C86F2298CC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-265011-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.946];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  5 Mar 2026 00:08:58 +0200 you wrote:
> While I was playing around with the subsystem knowledge in Chris Mason's
> review-prompts to see what LLMs would have needed to catch the bug
> behind commit bfd264fbbbca ("net: dsa: sja1105: protect link replay
> helpers against NULL phylink instance"), it flagged another issue
> instead, which IMO is valid. This is being fixed in patch 2/2.
> Patch 1/2 is preparatory reordering for that.
> 
> [...]

Here is the summary with links:
  - [net,1/2] net: dsa: sja1105: reorder sja1105_reload_cbs() and phylink_replay_link_end()
    https://git.kernel.org/netdev/net/c/976703cae737
  - [net,2/2] net: dsa: sja1105: ensure phylink_replay_link_end() will not be missed
    https://git.kernel.org/netdev/net/c/ce2da643f00a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



