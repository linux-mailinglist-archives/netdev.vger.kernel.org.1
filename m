Return-Path: <netdev+bounces-257719-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFmGOa29hmkzQgQAu9opvQ
	(envelope-from <netdev+bounces-257719-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 05:21:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C10104E1B
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 05:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AE32D301090B
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 04:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F322DF6E6;
	Sat,  7 Feb 2026 04:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vMgm5fYh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B310D2DEA86
	for <netdev@vger.kernel.org>; Sat,  7 Feb 2026 04:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770438027; cv=none; b=RiZtPe0gwngWvRpkZC56E3GIzb4UldnPpmEx9T6behNfvShjTiCF2mBdKbUZ0ni9StbvG1omcpfymJxW7zzplUH1aoyRThdA5UQSNM5qa8r9GBfKV/nOtnk+VurT6XvFdXtw1MnYvzeaTG3S05otEcdzpo4XTNdIH8wL5CngPVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770438027; c=relaxed/simple;
	bh=XmZbi+Gmc0McjfUH3VzYiZ0tsZud/Gj/VoOAnwwhKDs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HFLUEqOHjFzOAkbva4YRnMVunOHMZtfyZ1cTma0Hx3ElYNr8NzDm1J9JOUKhp7W12627Op1tXwBDCZeDwVGu0BukzlwpDoD4E+NQ57h3pwlYIsB7TpCmzW9QQKlSYBWzyVh4upJqjXbI2eHbz6+MLc/AL8MJZu+WssjdyYypa1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vMgm5fYh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89158C19421;
	Sat,  7 Feb 2026 04:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770438027;
	bh=XmZbi+Gmc0McjfUH3VzYiZ0tsZud/Gj/VoOAnwwhKDs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vMgm5fYhpb2iCYb/ngdGiDJB0CWeMas4cv+ikX3U2IrrvjgTCFJgJCuUl3eA+E+P7
	 I6zar3439gsG0IQRRUbNlby1YQatZj6NmZLbaGGhBnhLv50OGl9fBpAHONqjfgMs9X
	 VDJwAdZTZTKuk0r59vYWu1zVHIq88mO5jCVz0d7L8HABNjt7UvZkCaxHg+f5mnbByj
	 vZC36CjU6+G0fu0lAq+xG3DmqbwK3qk3uCYmZvaTHsd17vXZ08II+fzVa772lA9hTW
	 SBKWKSm51kMtJNbrrwONBiAuCYfDe2RZyPnTdMuRReyAAu1wE8GCoDDIv1k981q797
	 2RHal+PJXJtYA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C22D13809A1A;
	Sat,  7 Feb 2026 04:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] net: marvell: prestera: fix FEC error message
 for
 SFP ports
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177043802432.1183264.5861615136442702273.git-patchwork-notify@kernel.org>
Date: Sat, 07 Feb 2026 04:20:24 +0000
References: <20260205091958.231413-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20260205091958.231413-1-alok.a.tiwari@oracle.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: enachman@marvell.com, tchornyi@marvell.com, vmytnyk@marvell.com,
 vkochan@marvell.com, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 alok.a.tiwarilinux@gmail.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257719-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[marvell.com,redhat.com,kernel.org,google.com,davemloft.net,lunn.ch,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 21C10104E1B
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  5 Feb 2026 01:19:55 -0800 you wrote:
> In prestera_ethtool_set_fecparam(), the error message is opposite of
> the condition checking PRESTERA_PORT_TCVR_SFP. FEC configuration is
> not allowed on SFP ports, but the message says "non-SFP ports", which
> does not match the condition. However, FEC may be required depending on
> the transceiver, cable, or mode, and firmware already validates invalid
> combinations.
> 
> [...]

Here is the summary with links:
  - [v2,net-next] net: marvell: prestera: fix FEC error message for SFP ports
    https://git.kernel.org/netdev/net-next/c/dddb0198c2a8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



