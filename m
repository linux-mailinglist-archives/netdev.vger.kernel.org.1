Return-Path: <netdev+bounces-254997-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJSUCAwdfGmAKgIAu9opvQ
	(envelope-from <netdev+bounces-254997-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 03:53:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF45AB6970
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 03:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 586143024A2D
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 02:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A513502BF;
	Fri, 30 Jan 2026 02:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kB0wdIkF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D729D34FF63
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 02:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769741448; cv=none; b=EiH9Q8BPFZ1jeyHYY2Mu1lRajL46FYBygwn9NKk/JmRxxVOlEUqzVgSeAacsYa7zpJlY3+4/sJoQ6R/NKtocxi+qZGbCaPMcRQwCdB/FClpYGhBtO5U7bU0YG39q4hI4j4ZL9/NCGJJ3cJvEvWHak5vpBSiAQlys6BKD7VffncU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769741448; c=relaxed/simple;
	bh=YnXhxfv/PgSEeYazcWLixzHseoSlG5XpJcXQaxI+Imc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Aj9/4VwvHgSbIxvj8mIakctZAA7E7uToHCATdD1Es/aoftwvQUnLo/3QTAjoZai7YkPr7RhP32Ov8ePGw2gaB512AaZt7WXZ6BS4Ari3wdLqO45U+yz/AWRKStcojG/ni057iAKybx4e9KomMTz9YYmwdBVwKckeree72QbWIYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kB0wdIkF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A5CC4CEF7;
	Fri, 30 Jan 2026 02:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769741448;
	bh=YnXhxfv/PgSEeYazcWLixzHseoSlG5XpJcXQaxI+Imc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kB0wdIkFjFPhwfMk7mjY2gf3zytLxtNfGxwrsr1ZaZO3MlgQDJ5OMUAGDEWtKl0uX
	 9h7BfLJUTpV1BQVd5vl5a9aw0LTzaETreSpBkKazR9UgM8jwUj1EmOyiJfjM4E9O9g
	 ww81WeRevmvXI5+XRCIfxvN7DLaSbqHpqzTnIc9XKGCDcKcbcHMiJ+CNhnXGQSNoFL
	 uYPTAumpC9rM1G3pj+V5LF2QaBaisbf17MVOFqDmb4wtpeTqAdNk8ScpbuZek3X6JE
	 jL++/0Wl+YETV/1iykFkAuTQS3X7ecwKM+Uwi9iPDXGkMMM0oLF7sHAwvbIb1YO9/A
	 BTvM7tgYSTGHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BB5B380CEE0;
	Fri, 30 Jan 2026 02:50:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/2] net: stmmac: thead: avoid conflicts with
 PHY_INTF_* definitions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176974144135.3149010.17418895035388677174.git-patchwork-notify@kernel.org>
Date: Fri, 30 Jan 2026 02:50:41 +0000
References: <E1vl35b-00000006upH-2zt9@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1vl35b-00000006upH-2zt9@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, alexandre.torgue@foss.st.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, fustini@kernel.org, edumazet@google.com,
 wefu@redhat.com, guoren@kernel.org, kuba@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
 pabeni@redhat.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254997-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AF45AB6970
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 28 Jan 2026 10:47:59 +0000 you wrote:
> Avoid conflicts between stmmac PHY_INTF_* and GMAC_INTF_CTRL register
> definitions by replacing the PHY_ prefix with GMAC_.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Here is the summary with links:
  - [net-next,1/2] net: stmmac: thead: avoid conflicts with PHY_INTF_* definitions
    https://git.kernel.org/netdev/net-next/c/88afa0dd655c
  - [net-next,2/2] net: stmmac: report active PHY interface
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



