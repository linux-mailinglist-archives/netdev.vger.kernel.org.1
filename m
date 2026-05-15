Return-Path: <netdev+bounces-288126-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IChYI3tnBmrOjQIAu9opvQ
	(envelope-from <netdev+bounces-288126-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 02:23:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5236E547FB4
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 02:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F1E52307CC58
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 00:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C0B23EAA4;
	Fri, 15 May 2026 00:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VBq5E5oi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1044822538F;
	Fri, 15 May 2026 00:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778804483; cv=none; b=reec+XZksRDXql2vdedOxQrOFc8fpN7tQgGbo2uoKvgs0PRTRSSxmttMbuKIa0WPYu4UNCwf/zUkY2DeGnOYn8Rjo/NgUGispEre6kBvvhmpDjO4UOmWuXjojMvSdLckxPp+JgK07Io41x/ED7/J18hq8lLimX8rmVcYGFMfaKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778804483; c=relaxed/simple;
	bh=ChzpCrAmmOBJXgrCXxGb5lPCP+Tcqf7AasgRhZENBvY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=d2IpMOyrcRRRiceWQ7i6VvxabxP494a3qHVRUv3A1n8lOuQHmrmh9JXje67l+v3mNleWGJd6RJ46tWEs7jtvK1p3LniVxu1L3wxLoHomKIgmFXaiC1UitJIguaurxJCCgC6QTGcmuCiy735wxWvO93Iu2UqVZi4SfDhZc7VYYJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VBq5E5oi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30F2EC2BCB3;
	Fri, 15 May 2026 00:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778804482;
	bh=ChzpCrAmmOBJXgrCXxGb5lPCP+Tcqf7AasgRhZENBvY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VBq5E5oiElsaFmTxEyeMf6HiUjh/dutVa/fJePAkRUZaOsqveGpvY14LjXVE62xk8
	 /s/0BsMeIzUwJ+3yVNr5tqQhxpqOltn/zdAwxGuL8g2Vm6b3JiTitvmycEOMIseHF/
	 P5be/FwZde/hLhqrwbUiiDSf4ZRdcyaGcRnuKd2lN1S+JKnsCMl44O25Q68XZjchoz
	 QYJAxnvD+t9IzaA7FyEXXUvdMRp4N5pPw+RILDopG8mEj6RjpW9plBiZ5ZMBlIb9Tx
	 hM+spI+F9xbwHcB4eXm49Ix0DnmY/hN6rz1tbE5JBP/NuZmXmvZXdjw4Y0HVz6TDgv
	 +RRcAh9wj1KTA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02C3D39E4DB3;
	Fri, 15 May 2026 00:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] Documentation: networking: devlink: stmmac: fix
 typo
 in phc_coarse_adj
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177880442654.134878.10940283000511867784.git-patchwork-notify@kernel.org>
Date: Fri, 15 May 2026 00:20:26 +0000
References: <20260512133214.1773502-1-avinash.duduskar@gmail.com>
In-Reply-To: <20260512133214.1773502-1-avinash.duduskar@gmail.com>
To: Avinash Duduskar <avinash.duduskar@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, horms@kernel.org, corbet@lwn.net,
 jiri@resnulli.us, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 linux-doc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Rspamd-Queue-Id: 5236E547FB4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288126-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,redhat.com,google.com,lwn.net,resnulli.us,gmail.com,foss.st.com,st-md-mailman.stormreply.com,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 12 May 2026 19:02:14 +0530 you wrote:
> "Functionnal" should be "Functional".
> 
> Signed-off-by: Avinash Duduskar <avinash.duduskar@gmail.com>
> ---
>  Documentation/networking/devlink/stmmac.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] Documentation: networking: devlink: stmmac: fix typo in phc_coarse_adj
    https://git.kernel.org/netdev/net-next/c/e54fe8200a1c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



