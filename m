Return-Path: <netdev+bounces-292458-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yRaKEMpkF2rEDggAu9opvQ
	(envelope-from <netdev+bounces-292458-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 23:40:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6BC5EA730
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 23:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EC6230892DC
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 21:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BEB3B19D9;
	Wed, 27 May 2026 21:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XmzRABlB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7CE39891E
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 21:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779918005; cv=none; b=aXeTAXT1Ea6sAflRkMMONeqmYCBJqrD0IfZbYKy5wjfdgf2xBwiagiQI/byHW6RPXVjspad5LLLJISi82G0cUwknw/3miYu9RbE90JxguN/tybQhhexpHCp5pO89KSGTfdkJzKBDyHV5/nD8L2ksFo49uWsYbHpfPyuisk5qFIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779918005; c=relaxed/simple;
	bh=OqNKIgMaqoDsfOS6t0hs3yjJeXqFqWg9ZcTZaDYcOcE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nie7i6JL1WM31pPUvgRCDw5RgTrrgb4xEuyc24O77l4DO6wFFBfkn3HOmPN6yZSpl33kW8PELq0SgJkHVjML+s+RAD7SPVFnIKgnIH03Z7cwf/KV6r+Kp1MFlOhfP0zp/LrDiTS6Xc/oXI0Uz3K/+8lWQuqpjmdGVSKSXvcKLCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XmzRABlB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C48531F000E9;
	Wed, 27 May 2026 21:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779918003;
	bh=QrmlHndvedmjoZSmWvnrWh0Yq9vMJ3ZJjUF2eb18O88=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XmzRABlBVTHfxSfTnjY8JFWVQC08zloYkE9IIHlUhoU8ukj4KoAfF1aDqEpaGq+a6
	 bKbGiaZz4Pxceu+ggFJIusJ0UmQa3Zg+vplHytBAbbv82ym3+lEob9WzFqSJGUnX76
	 sFf8wxyNsoJwChIuxSektZQVrnEuTsSgdBHXnBiMALHJ3vEaddMnveobxV8jdi88nn
	 sExJcNMjw6aK1gNGy3LuIzAN2+L0wu1mXNJT4rREzovaQuGBudZ+hPAJB2CWfMEhqm
	 ATMQYX8dW8RafVASW34IozwvU2g/k6fYBw//wbjqKoECB8SKhpt4yQLsFZvkMkns3I
	 EBHrs1BhQShkQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19B4F380CFDE;
	Wed, 27 May 2026 21:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next] dpll: man: restore Frequency monitor status
 in
 device show output
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177991800864.659484.11817884221302902113.git-patchwork-notify@kernel.org>
Date: Wed, 27 May 2026 21:40:08 +0000
References: <20260526115309.64850-1-poros@redhat.com>
In-Reply-To: <20260526115309.64850-1-poros@redhat.com>
To: Petr Oros <poros@redhat.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, stephen@networkplumber.org,
 ivecera@redhat.com, vgrinber@redhat.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292458-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9B6BC5EA730
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Tue, 26 May 2026 13:53:09 +0200 you wrote:
> The dpll(8) merge of main into next (commit 62d1e70fa85a37 ("Merge
> remote-tracking branch 'main/main' into next")) resolved the conflict
> in the "dpll device show" output bullet list by keeping main's three
> new entries (Supported modes, Phase offset monitor status, Phase
> offset averaging factor) but inadvertently dropped the
> "Frequency monitor status (enable/disable)" entry that was
> introduced on next by commit 12954bc7d2c3 ("dpll: add frequency
> monitoring support").
> 
> [...]

Here is the summary with links:
  - [iproute2-next] dpll: man: restore Frequency monitor status in device show output
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=28352e7c0d6e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



