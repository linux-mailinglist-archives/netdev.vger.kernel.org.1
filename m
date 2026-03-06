Return-Path: <netdev+bounces-264944-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AxcGeBQq2nZcAEAu9opvQ
	(envelope-from <netdev+bounces-264944-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 23:10:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A3E228349
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 23:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30734302BDF7
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 22:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320C9494A13;
	Fri,  6 Mar 2026 22:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3iK7R3k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5C83FFAB4
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 22:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772835008; cv=none; b=LmZ4cxeRx2fk19r6uC7so6B7tWj7mJaXC1MG5lJCpxu/fTgP8aobivzuglzdp2C2/rmlERkmNhCDPr+0SBgZzMrGMEbbsR4rUnTfLGXqyqexyOTq2DJ1uEobfDdnuKxeVT2EaI6+1gMIs+x/8N33MuTn97B1xjUGSHtnwRrp0NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772835008; c=relaxed/simple;
	bh=myFCBmCp8rc3NK49fqZqMVKU2I/M+tj2Kbqr8PdeqPo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iXdfX9wZ8RwT2w0eK4bd6iQFy+Ij/fVsdxtZw0PJ2++U7Ivlej1k/qherlz9KFKJ9g61zChSFOeSf2Z3Iv+dzuwXsmacbuLtWhS3/K6jl44cT8XLQFjv7qc56VxMzkwpFqBcWtpswMk7p2OEWQ2FrxIEnLg2p0lZ++KaiFzVZjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3iK7R3k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CD1DC4CEF7;
	Fri,  6 Mar 2026 22:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772835007;
	bh=myFCBmCp8rc3NK49fqZqMVKU2I/M+tj2Kbqr8PdeqPo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=A3iK7R3kpI6szjSIm/xUinGQatMvau/0OIcW+Ry8Ou7gq8UxiMfZwtYP8wdBqS15/
	 EU/VB8SzHjg2TiDu9THcqohASbNUgzu6yhFGRvWn81SPx3wKhfFsCqT4hCqWCwo9UA
	 XlyYMa335eX0lhc9BkYzRDk7fE28hHlI3XtmevHm0XkUOPquOrpx76XhmV23lVBpHd
	 Em4J3kT8cBwjr0zNjIvsGk+jjoH1QFjiV1w+A0EPKtkjKUKiYs4p+Gzudralm7Andg
	 yVwizbgAvrSX8SEXI1yc1xTQviUjLfrB5zPbN49yCCxmJjAh484gTv5FrZLNXkdFvk
	 NyU16NsYjoJlw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E163808200;
	Fri,  6 Mar 2026 22:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2] remove leftover references to /usr/lib/route2
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177283500680.70173.6809575605648805585.git-patchwork-notify@kernel.org>
Date: Fri, 06 Mar 2026 22:10:06 +0000
References: <20260302164026.112728-1-stephen@networkplumber.org>
In-Reply-To: <20260302164026.112728-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, yedaya.ka@gmail.com
X-Rspamd-Queue-Id: D1A3E228349
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-264944-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.982];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,networkplumber.org:email]
X-Rspamd-Action: no action

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Mon,  2 Mar 2026 08:40:07 -0800 you wrote:
> Since commit 962692356a1c ("Makefile: use /usr/share/iproute2 for config
> files") the path was moved to /usr/share in Makefile; but there
> were leftover references.
> 
> Reported-by: Yedaya Katsman <yedaya.ka@gmail.com>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> 
> [...]

Here is the summary with links:
  - [iproute2] remove leftover references to /usr/lib/route2
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=bf0f8e79cd13

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



