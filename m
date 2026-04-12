Return-Path: <netdev+bounces-277906-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMdKHW0I3GmoLQkAu9opvQ
	(envelope-from <netdev+bounces-277906-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 23:02:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D07123E6008
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 23:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2155530214C8
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 21:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41AD2C0F91;
	Sun, 12 Apr 2026 21:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZC12ux0C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D9225393B
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 21:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776027645; cv=none; b=QFDkBIPqVPaPUDZDNV3GvG2Mu2Od/CCQKvUHyAVQko+XSy/NLfbsvOLX7/YoY8pxNOwAZx54COT1qDmX11+R5UOSwiQwXBbdCDAJnnZM4xjm4zBOgGifG0awtzQepz07NAAPBAemED2UNcALxC8NHsygGh+gbXMokFLph4pg1vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776027645; c=relaxed/simple;
	bh=FF8PIPS556zFptgoykptyvLs0KOYeIFFCQdNAmFi760=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iX54DhAS3IinyWaMy9j0azwYVYVprBDQ7tfLs6TSbwUtMZGdbjfae8t8ZyNIabs3J+wh7D6YZ9hIDY2YFbXQ5drtLp5FhCHla8dmn44uDXd9ioP2QL+oC/9NrdS3FiLlI4QpeOPBseax82z7fpaPDqVNs/SnaFg9XMaCYC92zpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZC12ux0C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A67C19424;
	Sun, 12 Apr 2026 21:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776027645;
	bh=FF8PIPS556zFptgoykptyvLs0KOYeIFFCQdNAmFi760=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZC12ux0CFUMeLIMbHdK5ULk0h3/3dcR8F1UkiDuB7gQA2lQbXO17vNJk/mSrPTvaJ
	 t07+dD3/8crLiepNEq/E69yqqXbPKbzh3k79N1boOjkw5yeQfz/t9BlMdgGMpLnJ5Z
	 w8UUJLppVRXgRC6ENC95Uxvr03jS53tc6wmzNwgaVF+jbKpuhvtLjwCVL3obublZLh
	 3MxRqKk2h5oSlXHXP5wWBDmd5lTEfpPFd6aJzW52KYVfBM/VHhzl/TsjPUVvw/okgY
	 w8g4Xj5DlpoZIEWU++1GjHhuSy0JBQBzziv9V+bNmt/GIUtNLxKnKwQvnk3jQcHfSB
	 AOXnbyLj0ZAXA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 030433809A8C;
	Sun, 12 Apr 2026 21:00:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] octeon_ep: Remove unnecessary semicolons in
 octep_oq_drop_rx()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177602761754.3408407.16126645337868053059.git-patchwork-notify@kernel.org>
Date: Sun, 12 Apr 2026 21:00:17 +0000
References: 
 <1775711291-13938-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
In-Reply-To: 
 <1775711291-13938-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
To: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Cc: vburru@marvell.com, sedara@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-277906-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D07123E6008
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  9 Apr 2026 14:08:11 +0900 you wrote:
> Remove unnecessary semicolons in octep_oq_drop_rx().
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
> ---
>  drivers/net/ethernet/marvell/octeon_ep/octep_rx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - octeon_ep: Remove unnecessary semicolons in octep_oq_drop_rx()
    https://git.kernel.org/netdev/net-next/c/21ad19a99d94

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



