Return-Path: <netdev+bounces-282181-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAnADHBf8WmogQEAu9opvQ
	(envelope-from <netdev+bounces-282181-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 03:31:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3EC448DF98
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 03:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4132D3019394
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 01:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5B625333F;
	Wed, 29 Apr 2026 01:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErUVJC05"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97710246782
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 01:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777426281; cv=none; b=n+lLgWLTtgGV0+cxZrXavQNJc96/f5Z8ROdBTyjWKpupaDlY2H9/cJ6bnpxwQ0ADvB0ehlJ5xE3GhHc5dBXIdAEzDoAw+9984xZruvsAs+7/WnYDkzYAI20GcPU459kNm0dqeq95VcnEBYRCd5hLGLZQqod4LibN1Z2QJXfTgak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777426281; c=relaxed/simple;
	bh=xyYHKRzAdzvLaIazBBkg3+ovKla9DR+TQVyt3RFqgQI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g0j60WGz9RfGHZIy5unjkftDLigE4f1UToLmlk+2JXtW8dfXbRgnZmb3aaU5WayHTpY8b5M1VYjOel+8S6yrsEMUjuF3RngMyjFNLh6wQylWbj3zX++xUD6iB3AQavl6rdIHp08ntaUA1Y3H7+tGMMS7IoFxs3Dj3SUv1znIhrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ErUVJC05; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B37C2BCB7;
	Wed, 29 Apr 2026 01:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777426281;
	bh=xyYHKRzAdzvLaIazBBkg3+ovKla9DR+TQVyt3RFqgQI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ErUVJC05ASdAQyOk6Ysa5lcuYKHRiONgU2JXVh6GRaAaE7GkI3W3SIoqaPxOSx2Fm
	 85KMisHqDhOh3n7oTYohW6UIP6f1I3Y6efS+t8kFpFZHnbyBoaD+xZhBWF8VL3swuB
	 daGPmp1XhVgTqjEYzB41Ub3mkzIMP3GZawl+3+kBDe35VUAHuiMBTZ5ilQB2vVSd6v
	 +zzHmg9KIPa1y9pLawViw8aTGhTQBtPiFXsMSJSR3KWx+12LR2ni0Qsy8DfUr5pK5X
	 ndeaxzUxUVemsDmcC48Dk/fY+SUdU5S8gnlICshgPfnJIi7wnGGw0X3eLruzsODwhH
	 TZbNTJXQj8qkQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E3D39302C2;
	Wed, 29 Apr 2026 01:30:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: psp: check for device unregister when
 creating
 assoc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177742623754.1288483.8965921178031693819.git-patchwork-notify@kernel.org>
Date: Wed, 29 Apr 2026 01:30:37 +0000
References: <20260427190606.366101-1-kuba@kernel.org>
In-Reply-To: <20260427190606.366101-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 yimingqian591@gmail.com, willemb@google.com, daniel.zahka@gmail.com,
 willemdebruijn.kernel@gmail.com
X-Rspamd-Queue-Id: C3EC448DF98
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-282181-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 27 Apr 2026 12:06:06 -0700 you wrote:
> psp_assoc_device_get_locked() obtains a psp_dev reference via
> psp_dev_get_for_sock() (which uses psp_dev_tryget() under RCU);
> it then acquires psd->lock and drops the reference. Before
> the lock is taken, psp_dev_unregister() can run to completion:
> take psd->lock, clear out state, unlock, drop the registration
> reference.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: psp: check for device unregister when creating assoc
    https://git.kernel.org/netdev/net/c/b89769f936a8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



