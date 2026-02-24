Return-Path: <netdev+bounces-260498-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aO/YLmmXnWnwQgQAu9opvQ
	(envelope-from <netdev+bounces-260498-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 13:19:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7D8186D45
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 13:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBAE830610C1
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 12:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3733538B7D8;
	Tue, 24 Feb 2026 12:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jrkk4E3z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1417D37D113;
	Tue, 24 Feb 2026 12:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771935576; cv=none; b=TyD68nNCI5W4q6vhTPriJRO7ubjIPFkf3Vbmp3hFXY1suA+ltXQBCKjJtckS28/Rb5amUds7OHCBhqz85j/a1NXxDIshe4lsrFkhB/pTaY7IloZaHqjqyFaL6sq2QxmyuXVpIklEUJYg/AOfmfX9hT435litnwaDcCEZaBVGPho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771935576; c=relaxed/simple;
	bh=rO2ijZUEWBIWFL42tkWnORwqkF7SBT9UzUk4XDvOKEY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XVYgYqTPEA0VuRN/tut4dYHxg11zPjWLcWr1Pe873ATVaeiN0AGy6g+5V68pWJHQQgW6KgDfczEpzHwwyjjNZHLGYknO9Uj9AoPjckr8FSafv8ju+qPD2vHh5JuPpw3llt9okt3h6NnOC4mJtti9kAd73A4/dHslM5n/r82DCLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jrkk4E3z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2F1EC116D0;
	Tue, 24 Feb 2026 12:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771935575;
	bh=rO2ijZUEWBIWFL42tkWnORwqkF7SBT9UzUk4XDvOKEY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Jrkk4E3z/9ZAB8gL3Z1ySVzEktT2BZEjhA9ctGSaMGO70W5eEXaK3l50wX+gf0UiM
	 KUZgDvyjF9oRK/rFjFTCBKFWoeMeiGeLU3tGzuv38EETPzqL3W6nwxQesbAW8nUvoe
	 pwu1I0On4JlXoCnJo3BoH8HKmdm/vZgMocoOeKJlyNpffI7eYlnyK2CV9nwdqoKrry
	 s11fZaXEejjcYgBrl2U55syzQb1Lh/dK9pmuGY6Tt2rfAhhmkpImZI0yyob1+/zONO
	 drP1SswlNym1toH3kTAzqBdTQPmKMrkYf8CGQ72ZWk/pDP2NFs3+jkOsg5WtqNOdlk
	 jLtonnjMjSrYA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA03C3808200;
	Tue, 24 Feb 2026 12:19:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests: tc-testing: preserve list order when removing
 duplicates
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177193558128.3453706.14204419588651644730.git-patchwork-notify@kernel.org>
Date: Tue, 24 Feb 2026 12:19:41 +0000
References: <20260222095536.17371-1-mr.navi8680@gmail.com>
In-Reply-To: <20260222095536.17371-1-mr.navi8680@gmail.com>
To: None <mr.navi8680@gmail.com>
Cc: jhs@mojatatu.com, jiri@resnulli.us, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260498-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3C7D8186D45
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 22 Feb 2026 15:25:36 +0530 you wrote:
> From: Naveen Anandhan <mr.navi8680@gmail.com>
> 
> Using set() removes duplicates but breaks ordering.
> Test output should be deterministic, so replace with dict.fromkeys().
> 
> Signed-off-by: Naveen Anandhan <mr.navi8680@gmail.com>
> 
> [...]

Here is the summary with links:
  - selftests: tc-testing: preserve list order when removing duplicates
    https://git.kernel.org/netdev/net-next/c/8ac768bb198c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



