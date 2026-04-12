Return-Path: <netdev+bounces-277857-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDIrJerd22lMHgkAu9opvQ
	(envelope-from <netdev+bounces-277857-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 20:01:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E4E3E54E4
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 20:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B1233014972
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 18:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E993630B0;
	Sun, 12 Apr 2026 18:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWNweUuc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EFB363098;
	Sun, 12 Apr 2026 18:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776016853; cv=none; b=g7HDn+tW4cgjrqGwbqbCyYsK/PJOh+x6jTPMAP5yPRga5LNg9L9mdeWDuIqqNrxbfwkxaXsMj5G/MwSFv3UhFLrU3hN+2z/tubfjd9uYCbi2evZ913ebs8EElN9aYfroJoT2L+y9nixnj8+meJtbjAu1r+37ApZpHeGAFC1hto0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776016853; c=relaxed/simple;
	bh=FwdVfbbOGsqKSJ2PuYf5oEgTP0rXLNLZGxQ71dARoyk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GlKRye3oDozK4SZkQYJ/LAdTcWG/zyWQBZdV4nkHH54kuWBjMbnj+ofbsMdfHZZPJiP6cYNnw+4Ik4q58UYP7E6ETJjG0vHAB+rPCrUMhg2i2YIcRCl+szhs5Bsrkg8r+VAx2dQSoituqFD21F8MaonnxiwgJ9tiNbBP57nUynE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWNweUuc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2818C19425;
	Sun, 12 Apr 2026 18:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776016852;
	bh=FwdVfbbOGsqKSJ2PuYf5oEgTP0rXLNLZGxQ71dARoyk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mWNweUucs0t1RVbrYMRjin9dyaYvvfUW90YmC6kHh9IPagi4MM/+T2Fu2iG0CmWsO
	 CBv8eyhQAISXs8cJ2now8rfRKWsnH2r7cYdsGSqLT/PTFdQG2D4K0kiIPxNS8Fs12j
	 Ay951sfawkSUlAkafeoL4xurkaL06rtQQWrjH0qipCt12q2lMbJwZRhKgNAIwpnSaf
	 WntCIDk0jBPFhIIQgYqdVx//pag8aH6RwRXIC+KnaFEE66fAFZE6IeA+D8QLhbZXmB
	 mlOiTd+R5/hOFKFwpLdgwiYF5KM21xwqETCo0IilrNoeHgOj6xAbfgjIRfIn+/qUTG
	 L8JfBpbWsvqaA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CC793809A8C;
	Sun, 12 Apr 2026 18:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] netkit: Don't emit scrub attribute for single
 device
 mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177601682504.3359939.2160598201131721875.git-patchwork-notify@kernel.org>
Date: Sun, 12 Apr 2026 18:00:25 +0000
References: <20260410072334.548232-1-daniel@iogearbox.net>
In-Reply-To: <20260410072334.548232-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
 dw@davidwei.uk, pabeni@redhat.com, razor@blackwall.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-277857-lists,netdev=lfdr.de,netdevbpf];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 34E4E3E54E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 10 Apr 2026 09:23:34 +0200 you wrote:
> When userspace reads a single mode netkit device via RTM_GETLINK,
> it receives IFLA_NETKIT_SCRUB=NETKIT_SCRUB_DEFAULT attribute from
> netkit_fill_info(). If that attribute is echoed back to recreate
> the device, the seen_scrub presence check in netkit_new_link()
> causes creation to fail with -EOPNOTSUPP. Since it has no meaning
> for single devices at this point, just don't dump it.
> 
> [...]

Here is the summary with links:
  - [net-next] netkit: Don't emit scrub attribute for single device mode
    https://git.kernel.org/netdev/net-next/c/e530b484b705

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



