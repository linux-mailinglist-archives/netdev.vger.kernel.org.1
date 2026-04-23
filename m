Return-Path: <netdev+bounces-280839-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8P1TLAxq6mkHzAIAu9opvQ
	(envelope-from <netdev+bounces-280839-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 20:50:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 28968456399
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 20:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CC0E23010BB5
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 18:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A015338CFE5;
	Thu, 23 Apr 2026 18:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3p5NYr8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA36175A92;
	Thu, 23 Apr 2026 18:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776970249; cv=none; b=A0W2yfDRJIUYzeQu7BPejsyTbP2fKe6OIkCRN6270ATt/Oo+bWoJtFzG0xCFygN3Ab6DCYiTWUwqVcLl8Kz1KsBVfciA10mDdH7xu0u9YLpd2Xe1CqJJFRbbaoUvWdxNZfTJv2qxWmEbcZ1n1Abgfo+6slfzSg7YGbBRL/yg/wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776970249; c=relaxed/simple;
	bh=kWDjwQlBj4v1pkAPxjWyhoeDS4gp+4fQfqYuYQX5Bqg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TQrJRFipchiiLt6qnI1f8izOdXP3G+5cpuyN4NYd8ba6VAaHRYA56a4ZabPOO0vMjQtoaAUR+q93YMbroJ8wMKrMZId7Cs/Xnd4fFyWR/hTEfHaiTEG0leUhKsm9C0VDFIgGJCpHw+bPMvAe/g2ijpFL1TXfR4H4/jUUXmVA+Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3p5NYr8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 286E6C2BCAF;
	Thu, 23 Apr 2026 18:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776970249;
	bh=kWDjwQlBj4v1pkAPxjWyhoeDS4gp+4fQfqYuYQX5Bqg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=U3p5NYr8X29gwxS6PN++wJoFR+ajfxFV30Oi/IsM1tiPrsNfNUaGDaOnJZ1+HoXje
	 5lQgqGfdRMbOQgX6+bVGPCZvnGqYl2v+IreNW8MRasjqA8upDMdY9arHScG7W0LDx8
	 068HD5L/Rk2fJQtvBAI8/BzyQmmyoseLdT94dXCkOciYj8qZx3XIwluES9LLN9KKh6
	 pMsTFQpabOyQcJG+sAB/0Xi3dFweWv4fpy90OJZQ0ILmuokXzleNfKoqrME5a4SEFn
	 0zlwiHzdLj4ZPAm5iCJD2r639YZglAFCXaSVBawtuLJjEBtJdJC0dAJgzdHHQAUDSZ
	 Qee3JUQYqKYZA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E4B3809A90;
	Thu, 23 Apr 2026 18:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/2] tcp: symmetric challenge ACK for SEG.ACK >
 SND.NXT
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177697021030.714464.4327737324079505525.git-patchwork-notify@kernel.org>
Date: Thu, 23 Apr 2026 18:50:10 +0000
References: <20260422123605.320000-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260422123605.320000-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, edumazet@google.com, ncardwell@google.com,
 kuniyu@google.com, davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280839-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[13];
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
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 28968456399
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 22 Apr 2026 20:35:37 +0800 you wrote:
> Commit 354e4aa391ed ("tcp: RFC 5961 5.2 Blind Data Injection Attack
> Mitigation") quotes RFC 5961 Section 5.2 in full, which requires
> that any incoming segment whose ACK value falls outside
> [SND.UNA - MAX.SND.WND, SND.NXT] MUST be discarded and an ACK sent
> back.  Linux currently sends that challenge ACK only on the lower
> edge (SEG.ACK < SND.UNA - MAX.SND.WND); on the symmetric upper edge
> (SEG.ACK > SND.NXT) the segment is silently dropped with
> SKB_DROP_REASON_TCP_ACK_UNSENT_DATA.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/2] tcp: send a challenge ACK on SEG.ACK > SND.NXT
    https://git.kernel.org/netdev/net/c/42726ec644cb
  - [net,v3,2/2] selftests/net: packetdrill: cover RFC 5961 5.2 challenge ACK on both edges
    https://git.kernel.org/netdev/net/c/cf94b3c0f052

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



