Return-Path: <netdev+bounces-292505-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PGhMqWTF2p1JwgAu9opvQ
	(envelope-from <netdev+bounces-292505-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 03:00:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D607C5EB748
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 03:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4C3F03007A7F
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 01:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815B1199EAD;
	Thu, 28 May 2026 01:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWVCS1wr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C447175A62
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 01:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779930015; cv=none; b=ck2vLpBuPtf2K8clyGb1aZirToq1wo2EisQtvU+Sw4q7JtbihF0eH2lA97McZqoYYqOHAX+tWtaSdvpnUVxsi1h3psoNhofTYDKzJBkl1rsnMIKmneC3k2HewKqPSUVU3IQ+1KX/M+OiLPRo/l/RNbJ+8ngDG1CXvxGf8yB7EfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779930015; c=relaxed/simple;
	bh=EOaiJZUgtypYK6WB5ZfVWDruGEYRAKaOYeTOE+h12G4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bSgPMR7vEmEPqzEfmroqcXOGlpeVq4JDwaWtJmN0eOShQDM2VbXcrC4O6L9qOS/vR4q7kSbz/wYIaL0Qujeh9jEeNg867aQegrT9GMZqzLuzgV7BuXdOwUBvwnWsfv8iOitaUpDKM8o0areNg6sart4OR6/M5nhO5YKFziUZLkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWVCS1wr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E09441F000E9;
	Thu, 28 May 2026 01:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779930013;
	bh=N8opnr6RGzgukPxeK509tMIjI7J/7N1gdwiwtn1z7WU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lWVCS1wrOaFA/W7Xw/nPdnA6vwjw8iDiUsi1tFDGIoHCETp87ylpKg5HK32Nua0Qn
	 5+8FKKKur5D0WpkywdR3AwIum4uNVFosXA6ZsqG5Cs3W9T41OPecBOXI5W34k2KpEe
	 5BDbKgngMJoSrMSXtzc1sUtSDmQz8TymeAgDMZUHoU2x8hctCRalPbJDHq6eao8N1Y
	 Ln++KcLMkyBOEjyQgTLdvTL8CGW8CDPmp6oGkV4wEdfNm1C0DkC5lWZ6FEqSi2C2p8
	 BOgRrsz0YIWTbkfxtJInnIc1KGn9UZWinwl9vYUSTklTXd0rm5h/7nAiWsasLAx4vZ
	 jziHni8cwzGEw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19AF9380CFDE;
	Thu, 28 May 2026 01:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 00/10] ethtool: more bug fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177993001864.702981.4237097981895381273.git-patchwork-notify@kernel.org>
Date: Thu, 28 May 2026 01:00:18 +0000
References: <20260526153533.2779187-1-kuba@kernel.org>
In-Reply-To: <20260526153533.2779187-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 o.rempel@pengutronix.de, kory.maincent@bootlin.com,
 maxime.chevallier@bootlin.com, haiyangz@microsoft.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-292505-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D607C5EB748
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 26 May 2026 08:35:23 -0700 you wrote:
> Last week I sent two patch sets - one fixing bugs in RSS handling,
> and one fixing CMIS / module handling. This set contains the remaining
> fixes. There's a concentration of fixes around PHY and timestamp config
> handling but not enough to break those out as separate sets.
> 
> Jakub Kicinski (10):
>   ethtool: coalesce: cap profile updates at NET_DIM_PARAMS_NUM_PROFILES
>   ethtool: tsconfig: fix reply error handling
>   ethtool: linkstate: fix unbalanced ethnl_ops_complete() on PHY lookup
>     error
>   ethtool: pse-pd: fix missing ethnl_ops_complete()
>   ethtool: tsconfig: fix missing ethnl_ops_complete()
>   ethtool: tsinfo: fix uninitialized stats on the by-PHC path
>   ethtool: tsinfo: don't pass ERR_PTR to genlmsg_cancel on prepare
>     failure
>   ethtool: strset: fix header attribute index in ethnl_req_get_phydev()
>   ethtool: eeprom: add missing ethnl_ops_begin() / _complete() during
>     fallback
>   ethtool: eeprom: add more safeties to EEPROM Netlink fallback
> 
> [...]

Here is the summary with links:
  - [net,01/10] ethtool: coalesce: cap profile updates at NET_DIM_PARAMS_NUM_PROFILES
    https://git.kernel.org/netdev/net/c/7281b096b072
  - [net,02/10] ethtool: tsconfig: fix reply error handling
    https://git.kernel.org/netdev/net/c/a888bbd43940
  - [net,03/10] ethtool: linkstate: fix unbalanced ethnl_ops_complete() on PHY lookup error
    https://git.kernel.org/netdev/net/c/596c51ed9e12
  - [net,04/10] ethtool: pse-pd: fix missing ethnl_ops_complete()
    https://git.kernel.org/netdev/net/c/ab5bf428fb6b
  - [net,05/10] ethtool: tsconfig: fix missing ethnl_ops_complete()
    https://git.kernel.org/netdev/net/c/6386bd772de6
  - [net,06/10] ethtool: tsinfo: fix uninitialized stats on the by-PHC path
    https://git.kernel.org/netdev/net/c/1de405699c62
  - [net,07/10] ethtool: tsinfo: don't pass ERR_PTR to genlmsg_cancel on prepare failure
    https://git.kernel.org/netdev/net/c/c3fc9976f686
  - [net,08/10] ethtool: strset: fix header attribute index in ethnl_req_get_phydev()
    https://git.kernel.org/netdev/net/c/a8d8bef6b45b
  - [net,09/10] ethtool: eeprom: add missing ethnl_ops_begin() / _complete() during fallback
    https://git.kernel.org/netdev/net/c/2376586f85f9
  - [net,10/10] ethtool: eeprom: add more safeties to EEPROM Netlink fallback
    https://git.kernel.org/netdev/net/c/67cfdd9210b9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



