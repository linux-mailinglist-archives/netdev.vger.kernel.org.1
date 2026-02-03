Return-Path: <netdev+bounces-256078-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLaGAmpUgWngFgMAu9opvQ
	(envelope-from <netdev+bounces-256078-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 02:50:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA86D37B2
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 02:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F3C63039317
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 01:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820E72D592E;
	Tue,  3 Feb 2026 01:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qVejd7oL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600D3283FCF
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 01:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770083413; cv=none; b=WUuzag7jehOqHrbR866LQ95aIXMJEoRdz/CprMONU84U7EZJWrta/BIiYAQkrMlXT4SN/dN678bTKzhOdrhxUg3tkJ2ldY2s5c7AfVrK+h4GtKFazxUDd48FISNhMKhm/+8/m7FuXMRL4yNIdv6CutPcs3P638EgIZ+hofHL28U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770083413; c=relaxed/simple;
	bh=2R+9kPizBjIa2bpttLit6yQjjNZkj2hBkBE6gFyEs6A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UWzkH7Z6+RMJvD9PXqab0VX1UXI1EEbumLY2cYUQ5/FPwxaWOKqrLAqOJ5Xe/Fe6xvO2zaQMACjbTJVgVOJGWphKAPkBTeSqO72/tcbtK09tfw8qud0DzuWt8UClZ1dP9mlFpfcQCA6qf7kYZifkGpkp8Z1rS+et8YynFHCAeP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qVejd7oL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 205ECC2BC86;
	Tue,  3 Feb 2026 01:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770083413;
	bh=2R+9kPizBjIa2bpttLit6yQjjNZkj2hBkBE6gFyEs6A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qVejd7oLxR2xUORizoVmoQ3745CKVdGEl+md1ofu527I1RwKS18TkFuS3P/8VeORy
	 P94f+N+P+8NpbDNgka3rMOFw5Yy7T5TjNGyL5uuteSzlck6eZZTuKonOmDGPFbIq9+
	 MfHZzFnUk87bFnTP9wAOsDr2TGR9Z5Lcl7HnVKjIAooDp3pSMfKbVrrxAKvVF/RBvd
	 2F9Uly9DdoUfYAzYPLu96ZFK47Bo1FzphEuwYQx0OaDGfw0hc+LAyY0PLqPom9yPzQ
	 poXFWgrNaFPx2T5VuknODCwBfMJNKK7FgF6ZplH0Ad5KyeJlpjJnEHfpiyfoaPOHwy
	 kxxoUMVQfGYCg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 16C783808200;
	Tue,  3 Feb 2026 01:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ethernet: use module_pci_driver;
 remove useless driver versions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177008340987.1270041.17858879678714254991.git-patchwork-notify@kernel.org>
Date: Tue, 03 Feb 2026 01:50:09 +0000
References: <20260131022441.56274-1-enelsonmoore@gmail.com>
In-Reply-To: <20260131022441.56274-1-enelsonmoore@gmail.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, romieu@fr.zoreil.com, horms@kernel.org,
 saikrishnag@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, venza@brownhat.org,
 mingo@kernel.org, tglx@kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-256078-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,marvell.com:email]
X-Rspamd-Queue-Id: 6EA86D37B2
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 30 Jan 2026 18:24:30 -0800 you wrote:
> The module version is useless, and the only thing these drivers' init
> routines did besides pci_register_driver was to print the driver name
> and/or version.
> 
> Acked-by: Francois Romieu <romieu@fr.zoreil.com> (epic100)
> Reviewed-by: Simon Horman <horms@kernel.org> (epic100, sis900)
> Reviewed-by: Sai Krishna <saikrishnag@marvell.com> (epic100)
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: ethernet: use module_pci_driver; remove useless driver versions
    https://git.kernel.org/netdev/net-next/c/14e6cf8474e1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



