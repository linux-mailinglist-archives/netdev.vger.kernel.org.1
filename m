Return-Path: <netdev+bounces-290549-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCFPKmdBD2rWIQYAu9opvQ
	(envelope-from <netdev+bounces-290549-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 19:31:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C633E5AA48D
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 19:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B8F0130E9D3A
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407E936F8E6;
	Thu, 21 May 2026 15:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="io+aDI+n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B85333B6F6;
	Thu, 21 May 2026 15:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779378608; cv=none; b=NiCzUuJGEO729+ewQzqRxmoLv4g8HULabIdXGvww4yjMkcDxk76zcut5pzYcp18DEs4eypDq8y7o/Yb5HhdQmgGWESiqFJR9Ov0N9OaXd4e6yOCUhrZgpV7WvBZi+1YwMKncA+XUn1tPbw9VcyU2g+cEkrbLIOSpLqIl5er7dw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779378608; c=relaxed/simple;
	bh=yc1/COf6YoWbjzPY1tKoTH/L/64cOAvOxQSmNCrIsBo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=X0Ypg3izlSsmGqRkuno1NOqHGdpLbITBOpMJY2lfhlafUn27EOo2AfiKniHyatm6m6+QN14BnK+SMtG+8lGNLztBljocRzAq1I0tQ/cFP7xog4dyBSGQeRaZtrfHdhHP98gJvfohw2rjX1vf2rfe6GnlF1FmrUjgL+BXtZLY4dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=io+aDI+n; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE76F1F000E9;
	Thu, 21 May 2026 15:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779378606;
	bh=WX/R9NW+WINS2ZE/ZIX1djNTE3fQrYMS8AniTPQQF84=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=io+aDI+nr0utsP7rxumkLhDLNILnHXA1UBGxBNzkbEKBEKlqKU/m5piwVHuvbz3wy
	 seAz+HPIokxrhyz0LffhChGXy33scTPEi/0dcSADm0R8/M3r+BrGcHnEgG/n9RSYB1
	 tDJ/OjSX4Bt+pwPCiw1Hdsuxv7ZcJyR9M39ILutpTAGs2xWMl0dNCX4CoKPYryGRcv
	 sOxD3RjOkoe/ozQdhFmUdgyYyPT21bZ0vTKPw/E6njSV/biIKzFGDuLckA0yU39zPu
	 ZHS+1MSjdM5/DwLsjNxTj2LHUQ6AgJbM0hl1IKWcWodmASVANzlWMZhzdLxF/vyjy/
	 ovrbztRYrssVg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AF33930E08;
	Thu, 21 May 2026 15:50:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/5] ethernet: 3c509: Bring driver back and make some
 fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177937861664.394984.9776175958470833957.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 15:50:16 +0000
References: <alpine.DEB.2.21.2605201115010.1450@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2605201115010.1450@angie.orcam.me.uk>
To: Maciej W. Rozycki <macro@orcam.me.uk>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290549-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C633E5AA48D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 20 May 2026 12:18:44 +0100 (BST) you wrote:
> Hi,
> 
>  As per the previous discussions[1][2] this patch series brings the 3c509
> driver back.  Picking up net rather than net-next as I consider it a fix
> to accidental removal and so that any downstream users do not suffer from
> disruption when using released kernels.
> 
> [...]

Here is the summary with links:
  - [net,1/5] Revert "drivers: net: 3com: 3c509: Remove this driver"
    https://git.kernel.org/netdev/net/c/28db0338db61
  - [net,2/5] ethernet: 3c509: Fix AUI transceiver type selection
    https://git.kernel.org/netdev/net/c/029a6b3a14bf
  - [net,3/5] ethernet: 3c509: Add GPL 2.0 SPDX license identifier
    https://git.kernel.org/netdev/net/c/240117bb51b9
  - [net,4/5] ethernet: 3c509: Update documentation to match MAINTAINERS
    https://git.kernel.org/netdev/net/c/75756cb4b2aa
  - [net,5/5] ethernet: 3c509: Fix most coding style issues
    https://git.kernel.org/netdev/net/c/014767c709a4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



