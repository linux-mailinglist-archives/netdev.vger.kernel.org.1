Return-Path: <netdev+bounces-267864-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QN7nK8jDtWkV4wAAu9opvQ
	(envelope-from <netdev+bounces-267864-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 21:23:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD6728EE1B
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 21:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 049413038AC8
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 20:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C542D38551C;
	Sat, 14 Mar 2026 20:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/EMnnHM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622E434D4D2
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 20:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773519634; cv=none; b=Rrm7HV5EFdH8aAkSPAh1/WJ8y4QqL1VOPsTLtL95DXPw3Yd9UF8ELU1b1wvLZNMDGhyqUVLV3RdHYl+uSMGHeY7R8J/UGdrz84qYpjr1U5R480PfkfPR1++ea0KrG2s/BrV/g8h/SjEt2V6NfOXzhVpeLXLQ+1ufxtld07pbiGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773519634; c=relaxed/simple;
	bh=PdXvtCi1mWlsnVZ6h3XwOInhyqFxO+WytF83Yq93Wbs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LIYtfCS7DGwAjWcO8YGzMeyRBg46a00d1vQW/gsSdXE0PQxbe8S0JnruPaIXg4MDErOivLEsvkWl2sLApDZ/dXxfL6lwPN0+OoEeOC7bnk+BQmQcMehbm7LCRo/F8D1E+w0zcVF8cbiol8F2icqS6rJc6KcvnsGPGgzV5urjTXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/EMnnHM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB492C116C6;
	Sat, 14 Mar 2026 20:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773519633;
	bh=PdXvtCi1mWlsnVZ6h3XwOInhyqFxO+WytF83Yq93Wbs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=h/EMnnHMUFddhY4zhfagBQLiAPyWcP740FQjhLey4qg9IDU49sjFgpoRdEa2TXr/Z
	 Z8MRwiroyfWCmpMHMwTpHOgKL2iv/cHwOPPZ+XwfmGAnjoAcjltGwHCdaaUyUMhicB
	 6eJ20sHbS4d4HUKNfKZxjLe4cf2l65K8GsLcIQ+WIIohye7RmLodkhbzH705Ri7ohU
	 BIIve0Rp4LnS8vJREHXTt81HIrvJz4C+m3PsKukR60V9Bu4o4zaTZE3odO5KJpbLey
	 FoUra2cYTYBJQDEK2Vs3JMH8ly9AEYJyseUL3wB/EbadcTUeNV/7GWKJd1EcwtiSlD
	 3OzrY67VgdltA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02B8F3808200;
	Sat, 14 Mar 2026 20:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests/net: packetdrill: add
 tcp_disorder_fin_in_FIN_WAIT.pkt
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177351962754.1773477.16399888355989521710.git-patchwork-notify@kernel.org>
Date: Sat, 14 Mar 2026 20:20:27 +0000
References: <20260313115429.3365751-1-edumazet@google.com>
In-Reply-To: <20260313115429.3365751-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, menglong8.dong@gmail.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-267864-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0FD6728EE1B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 13 Mar 2026 11:54:29 +0000 you wrote:
> Commit 795a7dfbc3d9 ("net: tcp: accept old ack during closing")
> was fixing an old bug, add a test to make sure we won't break
> this case in future kernels.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Menglong Dong <menglong8.dong@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] selftests/net: packetdrill: add tcp_disorder_fin_in_FIN_WAIT.pkt
    https://git.kernel.org/netdev/net-next/c/4686679a14d2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



