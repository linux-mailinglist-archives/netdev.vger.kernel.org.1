Return-Path: <netdev+bounces-264990-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHqxCFJ9q2lUdgEAu9opvQ
	(envelope-from <netdev+bounces-264990-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 02:20:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA9F22953C
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 02:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ABF66300D755
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 01:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA7A29D277;
	Sat,  7 Mar 2026 01:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XkBGBWcl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5DB28C87D
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 01:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772846414; cv=none; b=srIJzkhmjf6nh/8VCfVvhC2QUB36Svq+2Sv54bFpEBbfo2Q0fm74h3C8QEIgNBjOG1pMnpwU+kA5vHC+fcW5ihwuSn7U1pqXF/l69jXcbFb96V9+h6cuqrJ5IlBeXZZE3VSp2j9h/mtBlKFwgwsgw97Nkp71DQgJc+fpCwi6qSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772846414; c=relaxed/simple;
	bh=wIlgkj03eF4XLF7xndddSK4qfp7teXvnpnai8+VqeWU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gR33+toKtr5VqNNzRcSmQ2r1dUIhkue3s1yYRLJ8+0NNg90OG2HSWESurTeC72+6+7dRobnJ11ZkNHROlf1Wcl98+YC6IcvRamwXi3iXxOFSI8+SvGSV/oxNBLtZR2/mZeE43o/AwqvTzZCz8U3CaG/0m4/rdbM80VPHUaShPLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XkBGBWcl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC8EC4CEF7;
	Sat,  7 Mar 2026 01:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772846413;
	bh=wIlgkj03eF4XLF7xndddSK4qfp7teXvnpnai8+VqeWU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XkBGBWclR06xKDiA4dUKqiQtNHT403qoLzJAMaXBSoUFp2fln/nTkg++dKNMkA8e7
	 DUlbQymHG2tVwKrYscFmhvQydADGRPLMo6V7nf3YNQcyQqRvCAurmBOLkn+vaoTq7m
	 Vmymfnj4XC33Xajhs3V5Anpl3zjJbM8wy/2MIuZADdJRo6GynyGG52Jj0aQ2sAX6yg
	 0fBlIAhNWUvkPDCXyZU6iMP16BZ79WP/IWUvvEGT/vorRWbe2NjDw2GlIrpzwBp2p2
	 hl7ngI3yA+bmushJkxrQ5LhCcBFY/0bAsHuF/xim/JwZIpaf254drJRn9y5pBJSPwZ
	 3MFcBpZhR0NdQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E873808200;
	Sat,  7 Mar 2026 01:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2 v2 0/3] Add JSON output support to the remaining
 qdiscs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177284641280.115442.1510536699484746021.git-patchwork-notify@kernel.org>
Date: Sat, 07 Mar 2026 01:20:12 +0000
References: <20260303130733.540278-1-victor@mojatatu.com>
In-Reply-To: <20260303130733.540278-1-victor@mojatatu.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: stephen@networkplumber.org, dsahern@kernel.org, jhs@mojatatu.com,
 deren.teo@outlook.com, andrew@lunn.ch, netdev@vger.kernel.org
X-Rspamd-Queue-Id: BAA9F22953C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[networkplumber.org,kernel.org,mojatatu.com,outlook.com,lunn.ch,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264990-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.978];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This series was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Tue,  3 Mar 2026 10:07:30 -0300 you wrote:
> Since qdisc core already assumes all qdiscs are able to output JSON,
> add JSON output support to the remaning qdiscs (HFSC, QFQ, muiltiq)
> so that a JSON qdisc dump outputs valid JSON.
> 
> v1 -> v2:
> - Fix bug on line printing "level" field in HFSC (Pointed out by Stephen)
> - Emit HFSC d (delay) as a raw numeric microseconds
>   value (Suggested by Stephen)
> - Use nested JSON objects instead of flat names with spaces when
>   necessary in HFSC (Suggested by Stephen)
> - Output bands and max_bands as separate JSON fields for
>   multiq (Suggested by Stephen)
> 
> [...]

Here is the summary with links:
  - [iproute2,v2,1/3] tc: Add JSON output support to HFSC
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=3ebe6ec196b6
  - [iproute2,v2,2/3] tc: Add JSON output support to QFQ
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=935b2aea0641
  - [iproute2,v2,3/3] tc: Add JSON output support to multiq
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=4ac8d234f736

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



