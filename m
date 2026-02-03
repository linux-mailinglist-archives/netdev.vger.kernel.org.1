Return-Path: <netdev+bounces-256057-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SF5BDv5KgWkPFgMAu9opvQ
	(envelope-from <netdev+bounces-256057-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 02:10:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DA311D33E8
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 02:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D30AC30058D6
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 01:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2D31DB125;
	Tue,  3 Feb 2026 01:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGf+Kffq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EB8184540;
	Tue,  3 Feb 2026 01:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770081017; cv=none; b=bz01vx5XhNmv5ScXwHdgnC4w3GUf1qZM696oSSl0+FD8nBHpn7eZSkovkAVstfgPQpNPJLV0XDt60i4Nuve0UVW1R8179ORbgKlVgybWjFU7CZcCMGQMU9SMnkxqT+BfhT4UC8HJk1FEFA9ZE3abdDmu8g46E6Kg5fe8kdzJ0Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770081017; c=relaxed/simple;
	bh=dt4XgmTIWYtuSum+iuBndpeELxjzBJMwcHWarTAIyW8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cgtPv6S6A2qhfD7m5UAbjij88DDMcJO8rh7L3oCz592r+KnVKAyyxU1kM+Yxl1pL3xoTrKxgOV1yV9PAWSLwBPXh/qwVSn5xmpxZjvaBoahekRYd72Lte+GfUdHnG/qpdmABnzAegbjzivSTwftBMsgCK7lvm+lwHbI8dhpnBZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGf+Kffq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FD33C116C6;
	Tue,  3 Feb 2026 01:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770081017;
	bh=dt4XgmTIWYtuSum+iuBndpeELxjzBJMwcHWarTAIyW8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PGf+KffqhhBDsGvT4M9aqOSclhL5j0jhcZlTzVBUReA/iMgZsigmvfBnbHX2p7BRu
	 1GUDCZybI2V8RClICf3xXPwXWUJrBfDafzoWHCuO7GnLIjGjm2nkEzF13SxaCSxlT5
	 diu0N2/xy6bMBbulkcIjov+DRCkszzw3gkkQkkIxd+jWvp60uMTZya5/o2d3VN7i+Z
	 4X4HIxWupzt3yH3XVrV8eNVfJOJqYLs82wru2HZLpMt14aFkEVSLiDZFmqXXNR5RqJ
	 pwYqeH+zB3LofHlKoDV3FOj22Z90PpCkSEbGwJuODJFiunvADCd1SoZjezgp7R0bVq
	 TXFasnOdJMjSA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 90ECA3808200;
	Tue,  3 Feb 2026 01:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] bnxt_en: Allow ntuple filters for drops
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177008101412.1258089.14386114395488956755.git-patchwork-notify@kernel.org>
Date: Tue, 03 Feb 2026 01:10:14 +0000
References: <20260131003042.2570434-1-joe@dama.to>
In-Reply-To: <20260131003042.2570434-1-joe@dama.to>
To: Joe Damato <joe@dama.to>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 shruti.parab@broadcom.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256057-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DA311D33E8
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 30 Jan 2026 16:30:41 -0800 you wrote:
> It appears that in commit 7efd79c0e689 ("bnxt_en: Add drop action
> support for ntuple"), bnxt gained support for ntuple filters for packet
> drops.
> 
> However, support for this does not seem to work in recent kernels or
> against net-next:
> 
> [...]

Here is the summary with links:
  - [net-next,v3] bnxt_en: Allow ntuple filters for drops
    https://git.kernel.org/netdev/net-next/c/61cef6454cfb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



