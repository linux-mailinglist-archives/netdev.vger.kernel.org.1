Return-Path: <netdev+bounces-262026-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIUONapAomlz1QQAu9opvQ
	(envelope-from <netdev+bounces-262026-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 02:11:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 561451BFA2B
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 02:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 76A7030B92D8
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 01:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A982D978B;
	Sat, 28 Feb 2026 01:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GYoeLVDk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCDC2D1F7B
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 01:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772241052; cv=none; b=RHo7k19UxOS3qU1xjANd0bfjGSpUBiqjX4+hVHGNkCxakI7JAjaaOETj9cHehTS1sDwH32V43Mb14JnhIbPY0XkQwhOClEcTejWkfL5RTPBXmGmmu5xpnCQYEHDxSESrWr47t8nzYruArurr6pplfWppuhp9XuJN8SrXHXDXQdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772241052; c=relaxed/simple;
	bh=mEA2aLkcvmFyS+dvnigxrmefuWYBs2R22p9JxoMErXA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=P72fZJItzRfncVPjvo6ctkh5GoEhR5W6Gnvqx8o6Zdr5Fso4CNy4bh6g7wX1laZv8oct0/Gd4fzkXbtR5pwI2Ezch5nN945na7FY3Bi2sdR9EbiHtqrvW/cF+4gai1gICJ2UwfyiOmSIqtCL2mfi1SqvLKIWr9mSH/+avfcWbKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GYoeLVDk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 055D5C19422;
	Sat, 28 Feb 2026 01:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772241052;
	bh=mEA2aLkcvmFyS+dvnigxrmefuWYBs2R22p9JxoMErXA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GYoeLVDkvjO8ls8gYIiGkWtQJOKxlWt7QT6QNavSn1sASxDRg/9LvMDvHgTfzuhkZ
	 2r5Tj4ocqJuqNsQR8ARSAiQpNn/MCzxWPC002yp/zKGEmptdE3fXsAxqDGIwhvJFDS
	 3Rr2PShkcz/r/EhPzdqYSCunU1bjn9IyHcb3RWJLs45IZb2hA064dipGPJoGGRfFQk
	 tgGvF3SkaYBLJ7wvDjBKBqFSp3lm0NRnAwjAVY7NHO3mv5cDzHMvsnBWNDbNYDmRy2
	 YQI1GtP4Vx52xFJvH560l8AnAQI6u6FFkUn3NIgU6LTb6JgMN08t8wZ2Jd0T79Kzzg
	 lhu3XBcTXkdDQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F8939EF96A;
	Sat, 28 Feb 2026 01:10:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2] ss: suppress netlink errors for unsupported
 protocols
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177224105528.2825498.12316954571413676187.git-patchwork-notify@kernel.org>
Date: Sat, 28 Feb 2026 01:10:55 +0000
References: <20260225211118.314008-1-stephen@networkplumber.org>
In-Reply-To: <20260225211118.314008-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262026-lists,netdev=lfdr.de,netdevbpf];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 561451BFA2B
X-Rspamd-Action: no action

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Wed, 25 Feb 2026 13:10:25 -0800 you wrote:
> Error messages from sock_diag were only suppressed for extended
> protocols (> 255).  Protocols like SCTP and DCCP also get EINVAL
> when their kernel modules are not loaded.  Remove the conditional
> so all protocols suppress the error.
> 
> This fixes the problem where:
>   $ ss >/dev/null
> RTNETLINK answers: Invalid argument
> 
> [...]

Here is the summary with links:
  - [iproute2] ss: suppress netlink errors for unsupported protocols
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=f08cfd36cdf9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



