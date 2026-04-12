Return-Path: <netdev+bounces-277933-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJWRCZQf3GnoMwkAu9opvQ
	(envelope-from <netdev+bounces-277933-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 00:41:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9288F3E6505
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 00:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDB7E30191A2
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 22:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF6B33469C;
	Sun, 12 Apr 2026 22:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebDziDiD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA37E32F749;
	Sun, 12 Apr 2026 22:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776033641; cv=none; b=HKdNX0K/DFgtVIMR+j2abuv9mcj0madsnYTJDRZ59BR/kiw/mhY48suc1g+4KBWUoJM6VZvDaKaBPMnvTUIa3v98mqgKw5VEq1qFcogrXCT9d7W252aZa6N0BXeULyXCWEvHWGkEmBoYNNqnhfyt9E6e2u9tzJIMBNsxzXzOSj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776033641; c=relaxed/simple;
	bh=GXdN7jTrrduyQmOFR+m7AesTNuvOtu/a3aJi1iIQzHY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JzeNY7GsSrE0kKqsO3JVZ4yJ9M/HBmAZ2jFS4niYSAuC10mVljpxChQN1A4ErXf7ZTU/CJre2pESEJM0QPlc48CVEjri1KTVVuJC3gzjquCocVSj2y9VtSfCvQnnUOrwogvPJxa+CMIvn512lh2E5htmFn3PYq9IrE38WTMBF8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebDziDiD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42588C19424;
	Sun, 12 Apr 2026 22:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776033641;
	bh=GXdN7jTrrduyQmOFR+m7AesTNuvOtu/a3aJi1iIQzHY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ebDziDiDOi2SDQdtT4fgiNXpKPKpvdGzodLWJ24+z20dD9DKJKg04VNEYUkq3X284
	 fsgJ6BiPXw5Q7zDOSI0VttrfhxzyyUX6Vf/fHDELuwCUrhymY4KgxRNlMl1nJw+v+P
	 +R3jNDdF3cUmBh3SeDgAsrDOjsJ1HfIEB+GFt8lOSWSpayzYe3FZBmeyFnsREcJfW9
	 7JK+hwm03QjaB1xr5HUqvafKofbrZMe5WyOPRFSLsXa3JX7atAqphG3JU3puJZxI9y
	 gqIcwV0fBsWLrzWi34dc4h8Dp3OkElW3nFbNLwa5HAds7TWpn0p61zf92JU4ubZJ/i
	 0yBjSWYPl0bbQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E4B3809A8C;
	Sun, 12 Apr 2026 22:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/2] net: fix skb_ext BUILD_BUG_ON failures with GCOV
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177603361329.3843927.10796670149393156892.git-patchwork-notify@kernel.org>
Date: Sun, 12 Apr 2026 22:40:13 +0000
References: <20260410162150.3105738-1-khorenko@virtuozzo.com>
In-Reply-To: <20260410162150.3105738-1-khorenko@virtuozzo.com>
To: Konstantin Khorenko <khorenko@virtuozzo.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, linux@weissschuh.net, arnd@arndb.de,
 oberpar@linux.ibm.com, zaslonko@linux.ibm.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ptikhomirov@virtuozzo.com,
 vasileios.almpanis@virtuozzo.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277933-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9288F3E6505
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 10 Apr 2026 19:21:48 +0300 you wrote:
> This mini-series fixes build failures in net/core/skbuff.c when the
> kernel is built with CONFIG_GCOV_PROFILE_ALL=y.
> 
> This is part of a larger effort to add -fprofile-update=atomic to
> global CFLAGS_GCOV (posted earlier as a combined series):
>   https://lore.kernel.org/lkml/20260401142020.1434243-1-khorenko@virtuozzo.com/T/#t
> 
> [...]

Here is the summary with links:
  - [v3,1/2] net: fix skb_ext_total_length() BUILD_BUG_ON with CONFIG_GCOV_PROFILE_ALL
    https://git.kernel.org/netdev/net-next/c/c0b4382c86e3
  - [v3,2/2] net: add noinline __init __no_profile to skb_extensions_init() for GCOV compatibility
    https://git.kernel.org/netdev/net-next/c/29b1ee8788c5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



