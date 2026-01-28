Return-Path: <netdev+bounces-254055-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKdbOT5peWmPwwEAu9opvQ
	(envelope-from <netdev+bounces-254055-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 02:41:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 565629BF98
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 02:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A82BB3029AC3
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 01:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE05E255E43;
	Wed, 28 Jan 2026 01:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPj8xMIT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB923247295;
	Wed, 28 Jan 2026 01:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769564433; cv=none; b=mDXzI0UimwTA3WKfLtZwS+vzACwFv8sjOZdcOgxogrOYfISLlwS9+l9DYkuKp1ARcheukRg42rR+JNNsUOj8e61dTkQI45aunb/YHNAzcYjDgDvUixz01XXyTqapVwFRobWl498f5w+gwW8k04WJldg/+7OVlI53FMXdEzYjvsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769564433; c=relaxed/simple;
	bh=Isi02QkLNuLA91whrYEh56Fh0DHxmARwyPKd6xf/06Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nHq561SR2EAEKucNr1ZXPAqOk/QvrGjlJHwOeTzU+wDbv35CkB5DjWBVsy6hm80lcgjYzE0Cc482VoTd165Zpn0LEphqWdOhneU8PtsAD9t+nn6gpg7LNb0cq/Eo0Ddz0NkFj0vQsuhvfv/MZyecA7XtjNXFOzwh4t/3kcznqX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UPj8xMIT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A5E7C116D0;
	Wed, 28 Jan 2026 01:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769564433;
	bh=Isi02QkLNuLA91whrYEh56Fh0DHxmARwyPKd6xf/06Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UPj8xMITEN5aY4Zqvm1SQnznrxDxZAeltyPU7GtYu+t3ZqVC3PwhGbSH2SdDkvPKz
	 2p4sCALC5EXt1bnBqkI17hM2pSzlB+apU9tSluWrkdC0WHE2R0AcyJyQORNI/fKzOM
	 HR0Jtc8ZkKnjkLYh/qjIzyKwNNdA6go2A0hFSYxVaTwdWQIrJjpUINWJsDtV8rz1QM
	 ML6yZmUyRkHDhHNLvz+IZcsdilgGXVTUP1JSDdwtzjFc3rj0+msyD/MnoTJ84RTA8q
	 2L2GhNdIzeq7KSxmp72bRv1SJT9llZyb8gMPnBJX689Zxv+iznkFZAHToZ744hsz2c
	 IzuM51GI9mxIw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4EB89380AA76;
	Wed, 28 Jan 2026 01:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ethtool: remove ETHTOOL_GRXRINGS fallback
 through
 get_rxnfc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176956442710.1470424.821314611119050668.git-patchwork-notify@kernel.org>
Date: Wed, 28 Jan 2026 01:40:27 +0000
References: <20260126-grxring_final-v1-1-0981cb24512e@debian.org>
In-Reply-To: <20260126-grxring_final-v1-1-0981cb24512e@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: andrew@lunn.ch, kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254055-lists,netdev=lfdr.de,netdevbpf];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 565629BF98
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 26 Jan 2026 02:00:15 -0800 you wrote:
> All drivers that need to report the RX ring count now implement the
> get_rx_ring_count callback directly. Remove the legacy fallback path
> that obtained this information by calling get_rxnfc with ETHTOOL_GRXRINGS.
> 
> This simplifies the code and makes get_rx_ring_count the only way
> to retrieve the RX ring count.
> 
> [...]

Here is the summary with links:
  - [net-next] ethtool: remove ETHTOOL_GRXRINGS fallback through get_rxnfc
    https://git.kernel.org/netdev/net-next/c/1f6b527baf6f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



