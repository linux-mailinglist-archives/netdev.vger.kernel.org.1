Return-Path: <netdev+bounces-255511-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0C9RIhFyfmltZAIAu9opvQ
	(envelope-from <netdev+bounces-255511-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 22:20:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B3AC3FC9
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 22:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C4CF300CC05
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 21:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A45378806;
	Sat, 31 Jan 2026 21:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WoKnJ7p0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AFC369222;
	Sat, 31 Jan 2026 21:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769894413; cv=none; b=mYOc1MQK/o6HFJoSEj7Epd7mRp2q4zt8QBya+qZIhNQHEHbnh/GGaj8oY/ehdgL/4qYAv4ZzTB1CweXYv4w4SWCd3DBNvqnJcczq6XlR3Fu+D3kKOYfEKuLPgmUGpXyzlvy14BXa5tGpWnhD0KaMcR8/8alEPeYTLhSydem2GK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769894413; c=relaxed/simple;
	bh=hKIy/Qo0E1EplOkbfKz8dOatftmvrL+i51wk4H040tI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=C7y5JG2UZx6RP8xC8HF7z5VVlYBV8BS01QP/a22QKdJ280WBi7gZQryYSkWRIIPAvXehWtqcZIsBej0ZMZzf0kfTAjeKM1tC881jLLRtiiNG7o3wn2bp1nWBONsxfR9znM47qLvljG+I1sfXvGCjngXszGJkwYLW4qCLlopqgSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WoKnJ7p0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 053A7C4CEF1;
	Sat, 31 Jan 2026 21:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769894413;
	bh=hKIy/Qo0E1EplOkbfKz8dOatftmvrL+i51wk4H040tI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WoKnJ7p0lakGwcjeOO9tUoalAdDum0305sUT29jFiG/tRNAg80FMv1jINGkhDJFPo
	 gzcWC6+AlmTneQrGmI7gsGFfuZd+IUSmefExwPzbvKSwm9SDYKAkmyoR97QXv0AB7f
	 OR6DsjdE4tuTgvML1k4xUQH/oe9sTHaHSkdCPnvOeF3ISWbYPwW4eliEs/GNXS/0yu
	 OBm2JIyuoetiAHbrGh48sdiw7aTFsh5UZa3lBNTaBmydCMsjG9p1880NgAmZNK77/p
	 UglUYvYZKqaSksuaWxd6aIkiGg/ZDY1iZ43+/Mw+x43iZWEAMXeOkeg6uZ8BGjX2Cw
	 MxEMRAcFSuBKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 118E5380DBD4;
	Sat, 31 Jan 2026 21:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: don't touch dev->stats in BPF redirect paths
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176989440486.4193461.10700024811655891037.git-patchwork-notify@kernel.org>
Date: Sat, 31 Jan 2026 21:20:04 +0000
References: <20260130033827.698841-1-kuba@kernel.org>
In-Reply-To: <20260130033827.698841-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 martin.lau@kernel.org, daniel@iogearbox.net, gal@nvidia.com, ast@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, dsahern@gmail.com, bpf@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255511-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,iogearbox.net,nvidia.com,gmail.com,linux.dev,fomichev.me];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D9B3AC3FC9
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 29 Jan 2026 19:38:27 -0800 you wrote:
> Gal reports that BPF redirect increments dev->stats.tx_errors
> on failure. This is not correct, most modern drivers completely
> ignore dev->stats so these drops will be invisible to the user.
> Core code should use the dedicated core stats which are folded
> into device stats in dev_get_stats().
> 
> Note that we're switching from tx_errors to tx_dropped.
> Core only has tx_dropped, hence presumably users already expect
> that counter to increment for "stack" Tx issues.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: don't touch dev->stats in BPF redirect paths
    https://git.kernel.org/netdev/net/c/fdf3f6800be3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



