Return-Path: <netdev+bounces-287421-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHU1Onb1A2rKBAIAu9opvQ
	(envelope-from <netdev+bounces-287421-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 05:52:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FAE52D045
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 05:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C8A93104936
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 03:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400ED3955C0;
	Wed, 13 May 2026 03:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZSpw54q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC5A39479F
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 03:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778643997; cv=none; b=ZcPla3CFMCsA27n3gGkWXTDtZvhdZGkjwRYxu+Kmfnm2+FoudtA0sDpenNkUNLycVuyHQKVUWgbkwxWICQ4mUfpsmh2ocy5s2ZXkWxIzPjsSDlqraBElxUw9M229JzXjruNywVFl0hrc9Lml4DLOTTEA8pinPeY/jaQHRk5RydQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778643997; c=relaxed/simple;
	bh=PQ4G4I+tAmlxe9Urywnw6GIa7eN369v+thHoRFwId7Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rnDN8k9QpfndF4NkYUT62bRz6kRSVkO/yRcfIgOnT7CdUcGw5rR82M60ZxXGWNbxnF4LGhnbaDklet1TQ2XFlU28zZuMDh2o3To9H24P+cJ4XxEiN7r/ec+8sP5KHSqyw6RFtqUdEmCmfYvpbJjGouY3HeSraYOMvjNTOC89cWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZSpw54q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E8AC2BCFA;
	Wed, 13 May 2026 03:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778643997;
	bh=PQ4G4I+tAmlxe9Urywnw6GIa7eN369v+thHoRFwId7Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PZSpw54qOUet5gf6ghUcJcnwIG9JLp/JFRjU/Cgtq7YAi+t1HSEAo7DcklUAYAsHs
	 VL0CutUYv8wNrVqHNfQh76K9emvotmBpalXFhmdSjE+zMIm4jhOYCRpX1Ull0arKHy
	 ODLglUtBs/HzmGsUztcz+PexOpJCu0j3KtFsIAFzOckKqRmSd8O7RmBNgIS7ZavlHU
	 tzpBUw0+8yaBQLpPbSuGcKqyt5kkYbfR4zxSGoondOrRYCVyk3M3uoqnEaWNdsK29Z
	 9XiGYIWDZFJpV4p+YcTzcIzinRs1DFKTx3LToS53N9u3IhP1hM+TsG7kTQXj+lpZbv
	 Ld8iVcak+8a1g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D003822D60;
	Wed, 13 May 2026 03:45:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] net: dsa: realtek: rtl8365mb: add support for
 RTL8367SB
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177864394254.3173643.17180851118744393461.git-patchwork-notify@kernel.org>
Date: Wed, 13 May 2026 03:45:42 +0000
References: <3c6d822b-0e85-4173-86ba-2badb140bbf1@yahoo.com>
In-Reply-To: <3c6d822b-0e85-4173-86ba-2badb140bbf1@yahoo.com>
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 alsi@bang-olufsen.dk, yury.norov@gmail.com, linux@rasmusvillemoes.dk,
 linux@armlinux.org.uk, netdev@vger.kernel.org, luizluca@gmail.com
X-Rspamd-Queue-Id: 56FAE52D045
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
	TAGGED_FROM(0.00)[bounces-287421-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[yahoo.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 9 May 2026 14:10:29 +0200 you wrote:
> Add chip info entry for the Realtek RTL8367SB switch. This device has
> chip ID 0x6367 and version 0x0010. It exposes two external interfaces:
> port 6 supports MII, TMII, RMII, RGMII, SGMII and HSGMII, while port 7
> supports MII, TMII, RMII and RGMII. Use the existing 8365MB-VC jam table
> for initialization.
> 
> Reviewed-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
> 
> [...]

Here is the summary with links:
  - [v4] net: dsa: realtek: rtl8365mb: add support for RTL8367SB
    https://git.kernel.org/netdev/net-next/c/28702a215c96

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



