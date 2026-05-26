Return-Path: <netdev+bounces-291744-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKKHE9e8FWrKYQcAu9opvQ
	(envelope-from <netdev+bounces-291744-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 17:31:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B2A5D8C2C
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 17:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1484A305888F
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 15:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B1B2AD3F;
	Tue, 26 May 2026 15:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5WXT32s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469831A6800
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 15:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779808809; cv=none; b=cVFPs0uA8APX9tiF1SDXXRRV4WhvC46FRLqahIzdWZlNnCO6R89We14Ma/3x2IzcxMji8HXAIJep5xecAff7WbwjGvL7yTYF9nMwm2akmapg4e64GilxKIf+KNg4LzIt4WQo4t7qECiepkVQIgdfIijkGTO9t9CqVoYLZy9BhYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779808809; c=relaxed/simple;
	bh=BztrCdrzXRsWn9xKn13btk7l6VPxfkV/msdy4m0gkuc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=doYeJ8yob63FzRbuFY/sx4a93HLQRCMP69AMMN7G69mP1sAEjomykbmkhFIslV+YlFOUNxj/bt0V/nszc/pITbGbYjPuE6XvjMF3PbTpsQgaxkEG9tkGsmrI4T/lQJMjr1TZWNHFcbifxgtZc7cgusikcT3AHVoKuz/EwugzSfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5WXT32s; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D402C1F00A3E;
	Tue, 26 May 2026 15:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779808807;
	bh=BItmfaZmJpHt3vzz+XolnRJY+eEPLSPusiQwfC9kx/0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=l5WXT32s8xHb+b3zHIl9WaQX/TmOBuPYQadj+FRJ7Q1+aQaQBrP5RfrepinuGE/O6
	 mtvBLcNvzJl15ULnh5bwd+AdqYKwFHTMT6ciRgKjE4zIilwdCRoXO9/sIohf6cn8bN
	 0CQ1uzrKSMPLU8fvyRrinrgs6EMmSnTxQmfHorTBG/IMGyBOY88Ln4dPPSVU2xFohG
	 GTFNWG5lOHo0VaWoZ1GrPyZzVEPhLpIj+EyyV8R0RyuxjeGIJs/4BasAkBSOkrzsPu
	 TXOAL2H2wZhif3GGGK6EK1QzG8w70299n7eazYvru2rebWBxZp6Jl2SjMZnZtek301
	 Dw8NC0NEfwv0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198A8380CEDF;
	Tue, 26 May 2026 15:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/6] ethtool: rss: fix a handful of small bugs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177980881389.3857575.39639233486399399.git-patchwork-notify@kernel.org>
Date: Tue, 26 May 2026 15:20:13 +0000
References: <20260522230647.1705600-1-kuba@kernel.org>
In-Reply-To: <20260522230647.1705600-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, gal@nvidia.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291744-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E3B2A5D8C2C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 22 May 2026 16:06:41 -0700 you wrote:
> Fix a handful of small bugs in the ethtool Netlink RSS code.
> 
> Jakub Kicinski (6):
>   ethtool: rss: avoid modifying the RSS context response
>   ethtool: rss: add missing errno on RSS context delete
>   ethtool: rss: fix falsely ignoring indir table updates
>   ethtool: rss: fix indir_table and hkey leak on get_rxfh failure
>   ethtool: rss: fix hkey leak when indir_size is 0
>   ethtool: rss: avoid device context leak on reply-build failure
> 
> [...]

Here is the summary with links:
  - [net,1/6] ethtool: rss: avoid modifying the RSS context response
    https://git.kernel.org/netdev/net/c/c75b6f6eaacd
  - [net,2/6] ethtool: rss: add missing errno on RSS context delete
    https://git.kernel.org/netdev/net/c/3e6c6e9782ff
  - [net,3/6] ethtool: rss: fix falsely ignoring indir table updates
    https://git.kernel.org/netdev/net/c/8d60141a3287
  - [net,4/6] ethtool: rss: fix indir_table and hkey leak on get_rxfh failure
    https://git.kernel.org/netdev/net/c/266297692f97
  - [net,5/6] ethtool: rss: fix hkey leak when indir_size is 0
    https://git.kernel.org/netdev/net/c/78ccf1a70c63
  - [net,6/6] ethtool: rss: avoid device context leak on reply-build failure
    https://git.kernel.org/netdev/net/c/32a9ecde6273

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



