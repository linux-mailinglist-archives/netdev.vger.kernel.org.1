Return-Path: <netdev+bounces-253683-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCM2F7szeGlRowEAu9opvQ
	(envelope-from <netdev+bounces-253683-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 04:40:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A94528FACC
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 04:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 04E35300E446
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 03:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1B630DEBB;
	Tue, 27 Jan 2026 03:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2XPz5KU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C340C30C36B;
	Tue, 27 Jan 2026 03:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769485221; cv=none; b=Kxf1DRyXhIAWajrFJpdVwQVQ6JKTeY/gOcHDYPZa3I9wYvsQcwij8FZWjPYGtzY9AiUtog7G7MSa3SqWTZIc2/atykLqUtFXAzkW7CWEMl7i7Ei+oMub3Fy15u7WGTFUKfY5oXAUjNIzd/d260je0VOACzSegGRkMGThjQRUMqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769485221; c=relaxed/simple;
	bh=oYyPoYMb5h8Yw2IlLwjf2IcTt7LrLh0+aqCgEhQ/GTw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=I/DzOAGXb7MDzrCFgIqNED5uOhTnHwM8TEl38gZYm+M4Lftd8iblthCQUvDmejZir6vPkIfGO9K344WPZj+0AzO3gXK74rbVRpsd693E63OCtnV9WTc5lSm7lKyh7syieu64XUxEqTez2T7NtsWDWjSciKamDUzv5hAM/8i7pTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2XPz5KU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22480C116C6;
	Tue, 27 Jan 2026 03:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769485221;
	bh=oYyPoYMb5h8Yw2IlLwjf2IcTt7LrLh0+aqCgEhQ/GTw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=K2XPz5KU+TD0yVkG6vXvE2yr10c9Z1BC00RVpjS7OPKZXpqbeh6mU7RLTFws5BJDA
	 cTAlDFkQ/9cAiK4VwMJM9MU0liIHOG5QZr8B8LeAEnpZx4gW/kuVnKjhxlQZgPGZis
	 0P7nXGVSBWNm6/zDq7AxLNLduW0RJJVrISLHY1FltDl+DNFp0fu1LHvaQJFoi+SmHU
	 8U9Afvp7h21WIICiCq2fJ3E1UFB04qR4DeqE8CAkdp4ef8NBfCOjIPOo0AyJ+jLwN+
	 q8HaBMrCTViHDrqWLBMjy8xfbo+x0mzwputss4y8vlZZpJVGANQvUT/aSnb7yUm2W5
	 BsJb+2IMOT6Yw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BD23380A961;
	Tue, 27 Jan 2026 03:40:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: usb: replace unnecessary get_link functions
 with usbnet_get_link
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176948521535.672496.6577810918389237201.git-patchwork-notify@kernel.org>
Date: Tue, 27 Jan 2026 03:40:15 +0000
References: <20260124082217.82351-1-enelsonmoore@gmail.com>
In-Reply-To: <20260124082217.82351-1-enelsonmoore@gmail.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 peter@korsgaard.com, o.rempel@pengutronix.de, max.schulze@online.de,
 khalasa@piap.pl
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-253683-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A94528FACC
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 24 Jan 2026 00:22:06 -0800 you wrote:
> usbnet_get_link calls mii_link_ok if the device has a MII defined in
> its usbnet struct and no check_connect function defined there. This is
> true of these drivers, so their custom get_link functions which call
> mii_link_ok are useless. Remove them in favor of usbnet_get_link.
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: usb: replace unnecessary get_link functions with usbnet_get_link
    https://git.kernel.org/netdev/net-next/c/bd323fab96fb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



