Return-Path: <netdev+bounces-256080-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULsXLS5XgWkFFwMAu9opvQ
	(envelope-from <netdev+bounces-256080-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 03:02:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E21D3977
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 03:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E8DE9300D61B
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 02:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3D81C5D57;
	Tue,  3 Feb 2026 02:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pJssIDU2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4DE2F0C5B
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 02:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770084008; cv=none; b=MLX3tW3FQnic39DkgpZEEFlgOAQK8MG4vrLyAAuiigjEtETv2RqU31CKfo6b2e7c9R2J1bCxZ76TN57E4RHRGDSnTbbT/ZOLgv2q/rLZhkzKoDh2mdefgRKJSvK0tGk+wvlbwIjmqxocTj2TdxdO93fPkOVCV1us8N53tzrCxKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770084008; c=relaxed/simple;
	bh=VBBbJLbfXcu0yzjWHWMplaUuI1eF0C1P+i6/P4m3seo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YLO8Id5/KQ++ozFs/ECzoKH9twW8Yx4834bflJJDFNmHuYg7YKuOeVn07Lp1kToNo7dtuShT1T69a/fU1iPvs3tH8aiq0moiicscasJHZJPRZCVpJ/7hDpeErwcgg79lC0yebJjj1Qy92q3/9OFmzMAvlbmvqZUGEqB8y7zjSOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pJssIDU2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA90C116C6;
	Tue,  3 Feb 2026 02:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770084007;
	bh=VBBbJLbfXcu0yzjWHWMplaUuI1eF0C1P+i6/P4m3seo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pJssIDU2IeUaFK4lBIe+WxIA3WdAYPDIRz73M0z8jbhUzbgsmghBF2VnMiYD/Cyi4
	 zdDTE3eHxH5pEGLMyjeak7U18R+M+RW0DEC1Ewu22zRRhNdlq6INMQshc1H/kT5sTc
	 eTrW4hHsPbt3sZn5RbPCewj386YGd0UKMklhUmaNxrzwbHD7FVyIDAYW8r0lu4lTro
	 hP9nICGYf7bzsy0QdAbalBZHl5YZEgqnuEphGFH7edmUgripsQLZcnsBpceBpPPj8z
	 MXDLg88Hp5f9fYIPXzOJAMZIic52qss7FKtqSH4ZhRwyf9wvJwg8c5bthaMx5cX0Jw
	 ZY0za7JQjCB7w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id CDF683808200;
	Tue,  3 Feb 2026 02:00:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND] tipc: use kfree_sensitive() for session key
 material
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177008400463.1271965.16783467877403840640.git-patchwork-notify@kernel.org>
Date: Tue, 03 Feb 2026 02:00:04 +0000
References: <20260131180114.2121438-1-hodgesd@meta.com>
In-Reply-To: <20260131180114.2121438-1-hodgesd@meta.com>
To: Daniel Hodges <hodgesd@meta.com>
Cc: jmaloy@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 tuong.t.lien@dektech.com.au, netdev@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-256080-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 32E21D3977
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 31 Jan 2026 10:01:14 -0800 you wrote:
> The rx->skey field contains a struct tipc_aead_key with GCM-AES
> encryption keys used for TIPC cluster communication. Using plain
> kfree() leaves this sensitive key material in freed memory pages
> where it could potentially be recovered.
> 
> Switch to kfree_sensitive() to ensure the key material is zeroed
> before the memory is freed.
> 
> [...]

Here is the summary with links:
  - [RESEND] tipc: use kfree_sensitive() for session key material
    https://git.kernel.org/netdev/net/c/74d9391e8849

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



