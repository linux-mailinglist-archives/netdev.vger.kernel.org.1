Return-Path: <netdev+bounces-291480-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MxwOoG/FGqfPwcAu9opvQ
	(envelope-from <netdev+bounces-291480-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 23:30:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 50EA35CEE0E
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 23:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F5733029AFF
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 21:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8D43939BF;
	Mon, 25 May 2026 21:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZcA74YIX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA61309EEC;
	Mon, 25 May 2026 21:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779744605; cv=none; b=LqdiTc6yrcEeJNeHvHz3EqRBsf0ygUP6IjK+HCSsr2LQeaniWyTdVbFQ7x5zvHOb9ic3xIX8OlSxiilGlOOw49Di3zzUHEnJtpJrqmKrmkaAcWaJlYYfrvtP46gFMza7T1l4ctBXO+6U30E5RaFUA3zEHBIJ9JOo9QnADwwR8SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779744605; c=relaxed/simple;
	bh=tnkypJmbMYmQpB8+U85PD/9AE7KAnVf03f2iTPE1ZrA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hgylGUXBLIPZLA3yCuqP7h5hXGs6K9bZevsTfvXMe/N4ZDM7mtIyrYsRI/Y6hN4eojLKUMIdLet0rXdYjSaK7Lg3xGLK21eF3PW3bW1Lz2Ti0lvqaSOFPfpNkrzmPrMpbfxNLoLl/AvnC6Sfx6PD56LtynpsntcIJIvVdFCxrM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZcA74YIX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10E341F000E9;
	Mon, 25 May 2026 21:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779744604;
	bh=xa2jCXu5Twi3WtqGDDUKvQ+FlOrNga0EIC+rt6ftZi8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ZcA74YIXDbP+lshD2ob5h+LdODfBH0pcXnkdCKhcZPliUFysgR9VnDF3BnI93Sciv
	 q56HqYpKW84F+zxpFsxSSI1qPYJ7uZJbAtG7cVygiywJRQKEut+7R/uWaPm/+3MSja
	 K0zwb0fjD2cCqej2fdAw7SHRH74gz1/dNflNd7boTAUuO15vVBAGV1P8mME1XjuZmF
	 I8TsjAJebC4fQB6GbV4bTsccYc+xnQORiWKCktuIlVhhYW5R9i0hAnyOikHlT8pc9T
	 lofJAQjezMdYo69e7CrbXpoqkaBj/eb1LVT8V+0LX4ewnk5+0jEp9u4mhH0pXQJgml
	 VVSwFtd98Oc0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0CFF380AA76;
	Mon, 25 May 2026 21:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] eth: dpaa2: constify dpaa2_ethtool_stats and
 dpaa2_ethtool_extras
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177974461039.3120854.11074179020008876568.git-patchwork-notify@kernel.org>
Date: Mon, 25 May 2026 21:30:10 +0000
References: <20260523150737.36988-1-len.bao@gmx.us>
In-Reply-To: <20260523150737.36988-1-len.bao@gmx.us>
To: Len Bao <len.bao@gmx.us>
Cc: ioana.ciornei@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291480-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmx.us];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 50EA35CEE0E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 23 May 2026 15:07:35 +0000 you wrote:
> The 'dpaa2_ethtool_stats' and 'dpaa2_ethtool_extras' structures are
> initialized in their declarations and never changed. So, constify them
> to reduce the attack surface.
> 
> Before the patch (size dpaa2-ethtool.o):
> 
>    text	   data	    bss	    dec	    hex
>   33433	   5992	      0	  39425	   9a01
> 
> [...]

Here is the summary with links:
  - eth: dpaa2: constify dpaa2_ethtool_stats and dpaa2_ethtool_extras
    https://git.kernel.org/netdev/net-next/c/3baa7ba4ab98

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



