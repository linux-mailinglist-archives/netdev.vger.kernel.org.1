Return-Path: <netdev+bounces-257304-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGb3HvwEhWlW7gMAu9opvQ
	(envelope-from <netdev+bounces-257304-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 22:00:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A516CF758D
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 22:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1159A300BE0A
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 21:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F024A330670;
	Thu,  5 Feb 2026 21:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yg+oXlq1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1A2330317;
	Thu,  5 Feb 2026 21:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770325213; cv=none; b=BE37eRhVP8kGL8yvMMxLX/jtKB1Yld2BRNMX5QU3HbImMwX5VcvrZ2JPBdRrP2oRIsOFS0qo74tf05uPtmMRT46l6KVgIKYtJjBhGgo4e9SAgfgx32K4XRq4WwL0z8EEew8TV+LyAgdg5xKz1PBqOZ8EJFhY2SPjk0j1QFvPj64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770325213; c=relaxed/simple;
	bh=TKHbdYGuSQkIiVhuqI+naQ+8kKJ9zj4HOsJLTzunoyo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=F9+rIpqOiOB/RAfVDUBDcKte09jxZh7w8DP9g3n5PTlavy1Nz1olEf85yRYAAITPDTWuWxK2ZpM95V6/KQgrUDUCoSrceYaM0u24b/3ODCNnSW0eCzb/QInODRBZeZp3Nqw5p61MZXf4nsgFDp29XaLUnjMF6MWH0g+rB1V808I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yg+oXlq1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63834C4CEF7;
	Thu,  5 Feb 2026 21:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770325213;
	bh=TKHbdYGuSQkIiVhuqI+naQ+8kKJ9zj4HOsJLTzunoyo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Yg+oXlq1jfq7f9zZgGTGRL85afjjKP8ar4ucvNc+vxmxCwqI+9S4+jb0EJ5NiT3JS
	 cmemI7f4B92CbJDOeBmbsTH39wuqf1AqTS3r0/QqzBhh+amMlxLpG4PvlKvyjDh//6
	 3uZLuMO0q123s+5Zv70h/iZYWPNyKdtADM2vfbGB4HE3aB3T+/pN5a5ylBeznkd4eM
	 rTIK70rP3Ge7wEDJJMIa1pj14GjCkTvC+viaghBiUrraZDzwNJ8tregflJJT8OVLii
	 ipXHlqwbaIHejAo0LW/Y3GLCTaUZ4ARH2OQ0NPhqhkBPQKK2l3c9YrxhFLbHCGFRII
	 SUAH1CQyK1ghg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 483BD3808200;
	Thu,  5 Feb 2026 21:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] bonding: only set speed/duplex to unknown,
 if getting speed failed
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177032521082.564062.8269132270477838033.git-patchwork-notify@kernel.org>
Date: Thu, 05 Feb 2026 21:00:10 +0000
References: <20260203141153.51581-1-tbogendoerfer@suse.de>
In-Reply-To: <20260203141153.51581-1-tbogendoerfer@suse.de>
To: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc: jv@jvosburgh.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, wpan@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257304-lists,netdev=lfdr.de,netdevbpf];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A516CF758D
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  3 Feb 2026 15:11:52 +0100 you wrote:
> bond_update_speed_duplex() first set speed/duplex to unknown and
> then asks slave driver for current speed/duplex. Since getting
> speed/duplex might take longer there is a race, where this false state
> is visible by /proc/net/bonding. With commit 691b2bf14946 ("bonding:
>  update port speed when getting bond speed") this race gets more visible,
> if user space is calling ethtool on a regular base.
> 
> [...]

Here is the summary with links:
  - [v2,net] bonding: only set speed/duplex to unknown, if getting speed failed
    https://git.kernel.org/netdev/net/c/48dec8d88af9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



