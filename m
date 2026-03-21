Return-Path: <netdev+bounces-270163-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yANLG64OvmlQFwMAu9opvQ
	(envelope-from <netdev+bounces-270163-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 04:21:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C18682E318B
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 04:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FA2C304046C
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 03:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3E03101A7;
	Sat, 21 Mar 2026 03:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYQWOft0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B2B2741B6
	for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 03:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774063242; cv=none; b=M7uiy3QL2JkJGTaCxxc2GWLM3ZlA4YAqwgykajb1B0QlGGIBCygj/naNWHk+B5U2J7eIJDUMeDs8Tz2fBPeBlEc5TbQxyN/zdM13lwup6cVyRZD0nu+9yFcUYomRIg8WwOSCp4A8cSB0Y/jOh5b5mLH7k1pQQHD9iC0EPjrREJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774063242; c=relaxed/simple;
	bh=heH8dL6BjVGE1tRX6acgAg7F3CEdZqEt0ZZg1U2t3sQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mtutZyvNZw1hJqBDwOmTUaqIxj1GsRiBivzPRbihMuUcRzDUw2nfh0zY+l5mxwX023skhwZkONlXxFqPjDXWf/ma7wy+DvNkxsVrVPkd9KjbEfvXup5ZbRLje5bEToyZhmKvzxl0qBPxvOeb4+OkcjuBVC5JuEVjd2XzIKRW4/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYQWOft0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0584EC4CEF7;
	Sat, 21 Mar 2026 03:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774063242;
	bh=heH8dL6BjVGE1tRX6acgAg7F3CEdZqEt0ZZg1U2t3sQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iYQWOft00R+YKeliuCrv/J5rCHvXXDRzrOIfFDKDsj1Y4Av7qlcVvdce8oqyktrLE
	 keVVrCztO6aU8B3n1/lmFq5utxC76QB7X+vtfX01EnHtz3/H1LqMtLm4mF5MPfWzuo
	 HVUxUMmqlGbHVbGQR1EKIZ9sijKANQrNVTfYWdAtFDieg5pV3Y4Vu/A8I73/5j0RPZ
	 RkGfKF0gm06Iah2uamKWHpd8qKYBEa8Ot3kHR2o+LsgYELNyaqWgab01FY+hXdEmQO
	 ZDGAke3kgeY+on9PiGBleq2t2jTixzIZ12DmNyRg4aHNtxgR0V5wEaLZ71AuScksO7
	 Tj9bPWfGhjMJQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE423808200;
	Sat, 21 Mar 2026 03:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/3] netdevsim: support ETS offload
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177406323203.2737822.1727843516019475591.git-patchwork-notify@kernel.org>
Date: Sat, 21 Mar 2026 03:20:32 +0000
References: <cover.1773945414.git.dcaratti@redhat.com>
In-Reply-To: <cover.1773945414.git.dcaratti@redhat.com>
To: Davide Caratti <dcaratti@redhat.com>
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, jhs@mojatatu.com,
 victor@mojatatu.com, jiri@resnulli.us, netdev@vger.kernel.org
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
	TAGGED_FROM(0.00)[bounces-270163-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tdc_config.py:url]
X-Rspamd-Queue-Id: C18682E318B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 19 Mar 2026 19:40:53 +0100 you wrote:
> - patch 1 moves netdevsim tc offloads to a dedicated file
>  - patch 2 enables ETS offload on netdevsim
>  - patch 3 is a tdc test for ets offload on netdevsim
> 
> v2: don't use x-macro (Jakub Kicinski)
> v3: move function declaration from the bottom of netdevsim.h (Jakub Kicinski)
> v4: explicit path for ethtool in tdc_config.py (Victor Nogueira)
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/3] netdevsim: move TC offload code to a dedicated file
    https://git.kernel.org/netdev/net-next/c/544921efd4e4
  - [net-next,v4,2/3] netdevsim: support tc-ets offload
    https://git.kernel.org/netdev/net-next/c/abdf5133bfa1
  - [net-next,v4,3/3] tc-testing: add a test case for ETS offload
    https://git.kernel.org/netdev/net-next/c/5754a1c9f9b6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



