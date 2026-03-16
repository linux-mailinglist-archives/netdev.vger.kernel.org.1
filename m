Return-Path: <netdev+bounces-268264-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CnlOoZduGnXcgEAu9opvQ
	(envelope-from <netdev+bounces-268264-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 20:44:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9CA29FE24
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 20:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6390307E267
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 19:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8415C3ED5AA;
	Mon, 16 Mar 2026 19:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3HhHyZ5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7303ED135;
	Mon, 16 Mar 2026 19:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773690180; cv=none; b=tBiTZSPQorlJ37EO1FmaTEybyAg2G2h5xrkwwRx7BaNiPJx1wZTvOY2PwOPkcBsluczTTYFPbiHKL9xa+HWGnVhXtZXsvb9SRwyoK9K2RIYzhRwxPy+a2UhiBAMXAXrlFORBJnJc45W2vYm2d2oGbwsdBMhJ5XY8FTwuBNCy3hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773690180; c=relaxed/simple;
	bh=Jj6BbcYzraXFOQXQwjXzFEHRPAjsRRQvZZ0ky/jjEPQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OJoaRbE9Tj5VbEHFb3VuYD/OeLQDMfVZXMsDgcDfJLOtc0tvpKmL/u2gkc32Ql1CNjRD81Z8AnvOegm3bIHf/zJX+woJqHe103mnxNPuuWCxzQk0kdmLgounqAl9bLf4RHxj9onXQUFTS7YbByKc7apMJER4ALK8a5fTKylNNdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3HhHyZ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC1DEC2BCB0;
	Mon, 16 Mar 2026 19:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773690179;
	bh=Jj6BbcYzraXFOQXQwjXzFEHRPAjsRRQvZZ0ky/jjEPQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=C3HhHyZ54egvtz8+FJBDghgxje6T76yCcWpZHD6G+GktO7Oi7hlX2jZlW/iq13AMM
	 CT+929EtO+r78lV3oA/zWNrHCqHitEBSTZ6hJvN5hIHM/FF5rU1Pnj5LUgoIw0RDlY
	 1gYtRSq68tyHSkf9W/PU2YzAOueJ9IacrFdIiZQHbBmKN55mFk20QbDKaqehoW0BUq
	 PgbZfNWA0qd3QwifvsLNX4D8A9m7A5KDaWJeXZCy360NntjSyYNXHeV5qz6j2+6eI7
	 WVYw1J3qsj9EbtPn+K2a3NQ4QkOOHbSj0kjF/66rwEqD7dkE9OyHZ0bPOTvnuOCMb5
	 0IuNmv6+QqzSA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02F8A3808200;
	Mon, 16 Mar 2026 19:42:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2026-02-23
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177369017279.3255020.15622951635181819157.git-patchwork-notify@kernel.org>
Date: Mon, 16 Mar 2026 19:42:52 +0000
References: <20260223211634.3800315-1-luiz.dentz@gmail.com>
In-Reply-To: <20260223211634.3800315-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-268264-lists,netdev=lfdr.de,bluetooth];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
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
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6D9CA29FE24
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This pull request was applied to bluetooth/bluetooth-next.git (master)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 23 Feb 2026 16:16:34 -0500 you wrote:
> The following changes since commit d4f687fbbce45b5e88438e89b5e26c0c15847992:
> 
>   ovpn: tcp - fix packet extraction from stream (2026-02-21 07:04:08 +0000)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-02-23
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2026-02-23
    https://git.kernel.org/bluetooth/bluetooth-next/c/1348659dc92e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



