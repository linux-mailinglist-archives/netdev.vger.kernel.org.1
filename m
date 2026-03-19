Return-Path: <netdev+bounces-269430-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIReJDHnu2njpQIAu9opvQ
	(envelope-from <netdev+bounces-269430-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 13:08:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7082CAEC7
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 13:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4257332D2A84
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 12:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF953CCA12;
	Thu, 19 Mar 2026 12:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKdn79Fk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CE5330339;
	Thu, 19 Mar 2026 12:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773921640; cv=none; b=LexWHI3IEYZbCGrFlex3lmIOM2TXWLSL2/LLyF2HPSwL2Mcfr8EdZgCg9NSBDCWo6DT+HuCshC2+/hpJVfwoBa0Ao7eNVMWBX5fxhEeFt/AV35HkIke2zuDy/rFp2OjrlLbMeGK1p9/LrnwkI2OpcV7MUDnq3ijYlwmMX0PFnMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773921640; c=relaxed/simple;
	bh=6kPiVBMbrswtX7kAApBVdhcOnIQuEfdaNyVqVoTMy8o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JIwi7uCgNFIbl6cECpBgRO0BLGr150fJAqAFqwWlFLddpU/gUtilo4Qrlnnzp6aO4DZwcqeD1VEwTJBhvUC7SNyAnn28UDwEsztryWPXc+CmsicZFmlHiZ4ro1eT2pkHQZAABDiqWDDXFOg5FvSyFvkTNb+0sr9coxKuEqZHiDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKdn79Fk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DA66C19424;
	Thu, 19 Mar 2026 12:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773921640;
	bh=6kPiVBMbrswtX7kAApBVdhcOnIQuEfdaNyVqVoTMy8o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LKdn79FkYxU1seDcwnt+HsEqnLzE6bJ3rKAWHxQwHEw6jOgPCtxHcJd0qCiFjBm6b
	 V1zn/y6rBrwuMRg9uaUDN9Ne3BYkUydSoLPrHUMO2wecpASpjuZTijNI25EvKaRsL1
	 jNCbQfQcu+YsV4pVtpH0KahNAZ0dCb9JXvzLuuInuT3QtiY12fYoUdWNq2rK5Pa9Wd
	 NfuY+CG7Uk90SVt4A5yi7R/6wsTmC3rMQn45j4My0/LZftnauCr3gtM8cKO54gW3pX
	 uoTrxCu0fDSnYtlBmKyeM0DD8+raoQPUq9HnGRJBsNclyDSqveGMKxPHUemfFkYBo/
	 LoFzBOfZyUlKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D0103808203;
	Thu, 19 Mar 2026 12:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/9] selftests: ovpn: allow compiling ovpn-cli.c
 with
 mbedtls3
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177392163129.1169162.6141659842877580861.git-patchwork-notify@kernel.org>
Date: Thu, 19 Mar 2026 12:00:31 +0000
References: <20260317104023.192548-2-antonio@openvpn.net>
In-Reply-To: <20260317104023.192548-2-antonio@openvpn.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, ralf@mandelbit.com, sd@queasysnail.net,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, horms@kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269430-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.986];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ED7082CAEC7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Antonio Quartulli <antonio@openvpn.net>:

On Tue, 17 Mar 2026 11:40:15 +0100 you wrote:
> mbedtls 3 installs headers and calls the shared object
> differently than version 2, therefore we must now rely
> on pkgconfig to fill the right C/LDFLAGS.
> 
> Moreover the mbedtls3 library expects any base64 file to
> have their content on one line.
> Since this change does no break older versions,
> let's change the sample key file format and make mbedtls3
> happy.
> 
> [...]

Here is the summary with links:
  - [net-next,1/9] selftests: ovpn: allow compiling ovpn-cli.c with mbedtls3
    https://git.kernel.org/netdev/net-next/c/a8e136b49625
  - [net-next,2/9] ovpn: use correct array size to parse nested attributes in ovpn_nl_key_swap_doit
    https://git.kernel.org/netdev/net-next/c/7e7ca01d9126
  - [net-next,3/9] ovpn: pktid: use bitops.h API
    https://git.kernel.org/netdev/net-next/c/4a6480599ce1
  - [net-next,4/9] ovpn: notify userspace on client float event
    https://git.kernel.org/netdev/net-next/c/c841b676da98
  - [net-next,5/9] selftests: ovpn: add notification parsing and matching
    https://git.kernel.org/netdev/net-next/c/77de28cd7cf1
  - [net-next,6/9] ovpn: add support for asymmetric peer IDs
    https://git.kernel.org/netdev/net-next/c/2e570a514088
  - [net-next,7/9] selftests: ovpn: check asymmetric peer-id
    https://git.kernel.org/netdev/net-next/c/367f4b163a8c
  - [net-next,8/9] selftests: ovpn: add test for the FW mark feature
    https://git.kernel.org/netdev/net-next/c/7b80d8a33500
  - [net-next,9/9] ovpn: consolidate crypto allocations in one chunk
    https://git.kernel.org/netdev/net-next/c/d3244af9c4c2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



