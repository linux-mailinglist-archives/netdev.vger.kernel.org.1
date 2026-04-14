Return-Path: <netdev+bounces-278566-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YA9EGtiO3mkrFwAAu9opvQ
	(envelope-from <netdev+bounces-278566-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 21:00:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 741093FDE3D
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 21:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B2B1302802F
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 19:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36656283FEF;
	Tue, 14 Apr 2026 19:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gzr0VTzr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146771C01;
	Tue, 14 Apr 2026 19:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776193235; cv=none; b=S7V4mQZ2bvz+oaCD/Eqg5jDFlp34ki0pswJnUFAXBtZDm3C8bnp6tJ7dMG3zJcdfFvadtAE25HUtLOtJen4gP+rm3xIC87K36J4ZA210rTUNhA8fTrot4abxfaLL9Dt0inkCkB8T+aDyzrMAT7L7KXSSIJPK66BpFxNqLAtToEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776193235; c=relaxed/simple;
	bh=Mykm9hRueAPJfr/VtpfghEozZR53LF/nt5+TltxdRgE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kxa+m5K2S+aApBM2AT7Piw/raJSUXN/SoqtlpeOeZkACwwdMmGeXR8KOMtuJWQD8HvdU8wf6AAO54NWF3AQWt9nOj/7zvhlQssAxSRGg4mtNKm4Pb7iw5VZcG1IWvWD41ZQ+t3y1848KoZwDOLOYc97Lp4XVIfBDPGK+ubc988Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gzr0VTzr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE46C2BCB5;
	Tue, 14 Apr 2026 19:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776193234;
	bh=Mykm9hRueAPJfr/VtpfghEozZR53LF/nt5+TltxdRgE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Gzr0VTzrFIKfsD8q6rp//bbEEXh671jeLHbIaR/gnn2YYq3wmwJUW+Ba21cAzXVE+
	 Vi1f4BO4ej1sY29Z6AhBdDVzr8s87cTk3P/eMDhnrpgYWwxH8HOHWo536gtJ23n+6b
	 9g6817G/Sj4X67SDc1QsypbCkIAmN5EHhIGvUpfcckh2SqBNRHoi3Dt08bUj9xt6WH
	 s34is0UrKsZz24EyQo4B7+0Nn7dVei0If4WjqcJ/U2QSBkyi9eLUrUmFKa4JRI+yab
	 MDP6CNwybvHtXJYScUiu2LkAUNMOAS9lsSUCVkaohKkbJd4a3GVjRet8f6sLNRVytg
	 KvAcrWK1GhEQQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4026C3809A0A;
	Tue, 14 Apr 2026 19:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: pse-pd: fix kernel-doc function name for
 pse_control_find_by_id()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177619320505.1427904.14006521896472811073.git-patchwork-notify@kernel.org>
Date: Tue, 14 Apr 2026 19:00:05 +0000
References: <20260414150948.744618-1-kory.maincent@bootlin.com>
In-Reply-To: <20260414150948.744618-1-kory.maincent@bootlin.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: kuba@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, o.rempel@pengutronix.de, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278566-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:email]
X-Rspamd-Queue-Id: 741093FDE3D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 14 Apr 2026 17:09:47 +0200 you wrote:
> The kernel-doc comment header incorrectly referenced the function
> name pse_control_find_net_by_id() instead of the actual function name
> pse_control_find_by_id(). Correct the function name in the documentation
> to match the implementation.
> 
> Fixes: fc0e6db30941a ("net: pse-pd: Add support for reporting events")
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> 
> [...]

Here is the summary with links:
  - [net] net: pse-pd: fix kernel-doc function name for pse_control_find_by_id()
    https://git.kernel.org/netdev/net-next/c/6bb6bafa88b4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



