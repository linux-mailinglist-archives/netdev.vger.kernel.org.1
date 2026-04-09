Return-Path: <netdev+bounces-276775-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPegF2MI12myKggAu9opvQ
	(envelope-from <netdev+bounces-276775-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 04:01:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCDD3C56A7
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 04:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0520301916D
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 02:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E140D355F57;
	Thu,  9 Apr 2026 02:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETsW40Hv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC7C3191A5
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 02:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775700063; cv=none; b=EfnXE87pQbKeuNMaF5+Qz2RU9Vi/q/zhDt+EKX70xMKaTc3tSXDtZl0C5FYov/5+RGgE1dfXY/405SAyT7JD80Tlt6wfEcKooOptGYbsTKwDB5fsVJPEMLdjtYk1PHPN+SjDmWyKid6ABDeNZxtl+GGU21Xg8a5I92hWkKCQyqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775700063; c=relaxed/simple;
	bh=SgLBJyQZ2vOXToPfcGQs6nfeJjKZSG1XSHUF3LHrnjc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=d8L/sxZFwhXdXgzA/KDarR7oDwAAVskXgW5LDHwy0NwCv6HguNWpEWzBspWAI6evz6kBixkaIs6gMzDfLlyGxfC7OWtV+Hcj3s1MhSoc0m1nBQ48OgkudmPeWTCwIVp9Iuq8IiemMnd4j3EbfK2Zhtiwszfy1FfnRLVGDUD+eTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETsW40Hv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F6BFC19421;
	Thu,  9 Apr 2026 02:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775700063;
	bh=SgLBJyQZ2vOXToPfcGQs6nfeJjKZSG1XSHUF3LHrnjc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ETsW40HvN/4f2AMKASloDoz8s+uGAO+FCTSGLy6skH1ARO9BQEBiBaf4G0ladnE8a
	 iPT757gmAJU6jFuTMyJhL+lnp8g+cyLL4FMyoVRANDLFQJfTvWhTTu9Ok2FMbKwwAD
	 KbHWy0pR9iNXRrYEO0AxuV4xJHmV4vuYckcDVdw+c8Ld7GHtlcHrMoyXiS4MxYB6br
	 FUQqQOjv2wHzw+PCkHoIJalpDC+L1NgVvFw9D0t2clim0VmRhFfCJDmxPzigBxQVVA
	 asonq9QJ9p7sRAAnka43plWdD/JzAXuxmLqJdVURpawVa4drKOvMRCwXeaGvUy+sdt
	 AzyqQkoMbLCvw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E263930793;
	Thu,  9 Apr 2026 02:00:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] xfrm: update outdated comment
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177570003932.953143.16846855459954358608.git-patchwork-notify@kernel.org>
Date: Thu, 09 Apr 2026 02:00:39 +0000
References: <20260408094258.148555-2-steffen.klassert@secunet.com>
In-Reply-To: <20260408094258.148555-2-steffen.klassert@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: davem@davemloft.net, kuba@kernel.org, herbert@gondor.apana.org.au,
 netdev@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276775-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,secunet.com:email,nju.edu.cn:email]
X-Rspamd-Queue-Id: CBCDD3C56A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Steffen Klassert <steffen.klassert@secunet.com>:

On Wed, 8 Apr 2026 11:42:40 +0200 you wrote:
> From: kexinsun <kexinsun@smail.nju.edu.cn>
> 
> The function __xfrm4_bundle_create() was refactored into
> xfrm_bundle_create() (among others) by commit 25ee3286dcbc
> ("xfrm: Merge common code into xfrm_bundle_create"). The
> responsibility for setting dst->obsolete to DST_OBSOLETE_FORCE_CHK
> now lives in xfrm_bundle_create(). Update the comment accordingly.
> 
> [...]

Here is the summary with links:
  - [1/2] xfrm: update outdated comment
    https://git.kernel.org/netdev/net-next/c/be14d13625c9
  - [2/2] xfrm: Drop support for HMAC-RIPEMD-160
    https://git.kernel.org/netdev/net-next/c/05d42dc8ab92

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



