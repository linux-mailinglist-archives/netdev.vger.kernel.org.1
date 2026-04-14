Return-Path: <netdev+bounces-278526-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Ls/Lx5j3mlqDgAAu9opvQ
	(envelope-from <netdev+bounces-278526-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 17:54:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA6E3FC2E3
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 17:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B466730A2FD5
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 15:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7603ED118;
	Tue, 14 Apr 2026 15:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fr+pSyAe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E9B3ED122
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 15:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776181841; cv=none; b=q9HcWJaP8/k+65rus9cj1X19TrUtfYUWcBYIU2vR5Zzky7zgon43V6PYkj3t5QzRMAYrdCzCCubBaplhui2eKgqTxjdvKhvCaoZOyR2KIIyf0YGsNyBERXADNRUuQSVorLwcbljeGMR5TSeSnWvpTllrY3rZldIV5KOhERkuRF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776181841; c=relaxed/simple;
	bh=QKq2D4EQvGV0OppeuqUnua4cvMdJZlTophGLQAqCBIs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VrrlIRrgYHo+Yrrtn7aVIZoBKwzTD9NRxy+TcSKL+J25F78jEcUwtWCIh+8pqZBj5/y1D3JiqSw7oxDH5qdOo66cpdmzdPdE/UrYyhb+2tr8cEVIg2eRKWOoCcEqgmcpnVQXDdCG8ScbmAxmMoGSGZmI4imTYntxhCN3gvEK8II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fr+pSyAe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81663C19425;
	Tue, 14 Apr 2026 15:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776181841;
	bh=QKq2D4EQvGV0OppeuqUnua4cvMdJZlTophGLQAqCBIs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Fr+pSyAe1X6MvQ9TNaf6+AteX4C+Lw2yWhLG9dhCGVK84xy1cu+iB6TDw3Is02YZN
	 o9O58nG2otGLZXJeGM2Ahvn3Efzdb4JbHCrIYLhIWqRcNdzBNi9klz34qehEbDePKS
	 Q3a9042dNMN2yJz3u4daKgwu+BBaMf3qturCjP2pmJhTqVWBUz74C+wGj00gqzHKK+
	 TkF1R62529rgPVdPXsA9ruhWCxvuikbfFHTH+36hk2NHKcuvtiKtUAqA444vD8lZVK
	 EBapVyMgMprykxMApCPDWWSYuI/SuAMREItdp/ovRjt5RzCWRkYq9DHToLbDM21JhU
	 3JLc4LfAAmsuQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FBD33809A06;
	Tue, 14 Apr 2026 15:50:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] Follow-ups to nk_qlease net selftests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177618181179.1350742.16013704371768827082.git-patchwork-notify@kernel.org>
Date: Tue, 14 Apr 2026 15:50:11 +0000
References: <20260413220809.604592-1-daniel@iogearbox.net>
In-Reply-To: <20260413220809.604592-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, dw@davidwei.uk,
 pabeni@redhat.com, razor@blackwall.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278526-lists,netdev=lfdr.de,netdevbpf];
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
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nk_qlease.py:url]
X-Rspamd-Queue-Id: 3AA6E3FC2E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 14 Apr 2026 00:08:03 +0200 you wrote:
> This is a set of follow-ups addressing [0]:
> 
> - Split netdevsim tests from HW tests in nk_qlease and move the SW
>   tests under selftests/net/
> - Remove multiple ksft_run()s to fix the recently enforced hard-fail
> - Move all the setup inside the test cases for the ones under
>   selftests/net/ (I'll defer the HW ones to David)
> - Add more test coverage related to queue leasing behavior and corner
>   cases, so now we have 45 tests in nk_qlease.py with netdevsim
>   which does not need special HW
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] tools/ynl: Make YnlFamily closeable as a context manager
    https://git.kernel.org/netdev/net-next/c/4a6fe5fe6004
  - [net-next,v2,2/3] selftests/net: Split netdevsim tests from HW tests in nk_qlease
    https://git.kernel.org/netdev/net-next/c/e254ffb9502c
  - [net-next,v2,3/3] selftests/net: Add additional test coverage in nk_qlease
    https://git.kernel.org/netdev/net-next/c/1e822171ba9b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



