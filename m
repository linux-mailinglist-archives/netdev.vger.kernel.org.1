Return-Path: <netdev+bounces-285069-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFEeGOTF+2lSEgAAu9opvQ
	(envelope-from <netdev+bounces-285069-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 00:51:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3264E162E
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 00:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 56E6A3017538
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 22:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020E53537EB;
	Wed,  6 May 2026 22:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPGvzIOH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D213D33E368;
	Wed,  6 May 2026 22:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778107871; cv=none; b=mOP6+hi/HJxsjj9m4KlPtwnUXGQZ+WrVx5Q40VbzJktFFDQB5IlBVEubBk+6OL9ePXA6KMqb/3rSbREEV2KdPf9vaCZ3laFutw5ABpOMxTttbn53GEsWLfQ+4QUXHi/m0kpVIpVlv1bl7FQqzTJd8A0Ntm65vqX6TRMyhsqtqtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778107871; c=relaxed/simple;
	bh=YNZgcxcpwiX7lYht35LCUTAq4XuT2pfJrlPdXlaF1pg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hg7FTeEq+KnFv2wDrsAGGoWjAcw5F67KktCLrEztMwzSlXLEDsxI9GIKvn6gcKcwR9TPG5c6BscpJGUmoN2HRU3WmjKiOCcWg9Omh9FCjZuK4FIzSk9/9hqUMKxCWTtZIssv2V1szGORCINijDFePTrhHrV6mfcG3IV1sm41Jsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hPGvzIOH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3056EC2BCB0;
	Wed,  6 May 2026 22:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778107871;
	bh=YNZgcxcpwiX7lYht35LCUTAq4XuT2pfJrlPdXlaF1pg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hPGvzIOHbEgFkF4WuUImsaA99RpMttR/MqgwOApGl7cVkvNGBNpS7yWB6XN8fui5N
	 PkxhoDNvAvAs9l4DBBTGlwnqp084nVjbW62HtHEJ+Z5QRoshJJzLPf/ABIo6IXlveO
	 0ks+6ViUqv5ueqvnPYXIwrDgDu02SPD451bjTIJx4SMGh1oI7TzjeXxe3JgDMX6A2K
	 RaSDfdTlOnTif++b1j6jOrORGJCxjhoeWShFu/AvJz6Y6LxdfZhyUxBWX+cCQxtoOu
	 O9WhwXAd3mqVUb0BK7lmRzVVeQ8IWOCmHKkRBFcxZEQp3o5FAtTn2+i6RhxJdLxD2T
	 wraOpHQk5EgAA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02C78393089F;
	Wed,  6 May 2026 22:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2026-05-06
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177810782080.3254192.15839017764164025740.git-patchwork-notify@kernel.org>
Date: Wed, 06 May 2026 22:50:20 +0000
References: <20260506204553.58686-1-luiz.dentz@gmail.com>
In-Reply-To: <20260506204553.58686-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
X-Rspamd-Queue-Id: CC3264E162E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-285069-lists,netdev=lfdr.de,netdevbpf];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  6 May 2026 16:45:53 -0400 you wrote:
> The following changes since commit b89e0100a5f6885f9748bbacc3f4e3bcff654e4c:
> 
>   Merge tag 'wireless-2026-05-06' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless (2026-05-06 07:29:31 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-05-06
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2026-05-06
    https://git.kernel.org/netdev/net/c/bd75e1003d3e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



