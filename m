Return-Path: <netdev+bounces-261675-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKzWD9X7oGlXogQAu9opvQ
	(envelope-from <netdev+bounces-261675-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 03:05:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 824D91B1CEC
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 03:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 183D930A08BA
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 02:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DA02BEFE5;
	Fri, 27 Feb 2026 02:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqPi9M8Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB7B2BE7CD;
	Fri, 27 Feb 2026 02:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772157603; cv=none; b=P+SO84APpZC7LSg1BV8htvBqFxZ2PY/VXUUuI+CC5Qps9vCeAU5f7nGcys6hL1/P+NsrPAxmSEJjIMV13PlcGIU5xOKLhY2bsE/c0zx8I5DKQvykStl/SmakVj53gnibz7OqZTw74hYgWzxxu7MVDDDIOxFoyevyjVnjSEpMME0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772157603; c=relaxed/simple;
	bh=UHAF2gmtDR1L7FPa6REfzDD7Dw29dpU0AIu6ZdwhBA4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GQxY9176GzqJuzpRS8s5pVM5Au17U5FSms7PZ3XaXalTOhxCZbpQdjkXS5KyPCo9jZbMdjxLlmX0RyajkamWJ2flRw4rKqFOSzbq24e/ocQubSTz6fhp7ohom3x2QFXjFOlUlvrUjIfvwGMi8TD/LBxqZ6r/N1RmyHguI+tSEVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqPi9M8Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B83C19423;
	Fri, 27 Feb 2026 02:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772157603;
	bh=UHAF2gmtDR1L7FPa6REfzDD7Dw29dpU0AIu6ZdwhBA4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nqPi9M8ZLy1nBO/IqUUdCfJqy01UmfmSr26CGaPEuYsN29dZJxDklVCbn1LBbpRap
	 kyJdkZwT6DGcgRw28tXI6hLO16LcP9xPXDQMTpB/IH2+Shyfg59xaaqao8UxqDlZad
	 Ghzlowxagshm8dF53Z2y74sogaMld23/L34StfOycSdckq4dKupPd+qClwsvbV282q
	 aWRzaBddeHvlYzztsQnPwGOufzQ9BCiZWwNs/66zW+I4t8+BI6WWrzdd5auDLLoQ+C
	 Hx3FVX/JDLUbJaLZkghr+D3GUuxqhNBaZ2f3732uQZHd05YxeTMZNROvIXa57NZaA1
	 YITmBt/Zqqbfg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02F5D393109E;
	Fri, 27 Feb 2026 02:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] octeontx2-af: CGX: replace kfree() with
 rvu_free_bitmap()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177215760655.1939634.6913383144394197055.git-patchwork-notify@kernel.org>
Date: Fri, 27 Feb 2026 02:00:06 +0000
References: <20260225082348.2519131-1-bo@mboxify.com>
In-Reply-To: <20260225082348.2519131-1-bo@mboxify.com>
To: Bo Sun <bo@mboxify.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, vadim.fedorenko@linux.dev,
 pabeni@redhat.com, jerinj@marvell.com, lcherian@marvell.com,
 sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 hkelam@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, linux-kernel@vger.kernel.org
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
	TAGGED_FROM(0.00)[bounces-261675-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mboxify.com:email,linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 824D91B1CEC
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 25 Feb 2026 16:23:48 +0800 you wrote:
> mac_to_index_bmap is allocated with rvu_alloc_bitmap(), so free it
> with rvu_free_bitmap() instead of open-coding kfree(.bmap) to keep
> the alloc/free API pairing consistent.
> 
> Signed-off-by: Bo Sun <bo@mboxify.com>
> Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> 
> [...]

Here is the summary with links:
  - [net-next] octeontx2-af: CGX: replace kfree() with rvu_free_bitmap()
    https://git.kernel.org/netdev/net-next/c/f22b4e6fbba5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



