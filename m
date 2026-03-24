Return-Path: <netdev+bounces-270847-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJ7wNyTzwWlzYQQAu9opvQ
	(envelope-from <netdev+bounces-270847-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 03:12:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F37230102C
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 03:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2CDE23031186
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 02:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F3A38237A;
	Tue, 24 Mar 2026 02:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ei1rOfJh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47963845DA;
	Tue, 24 Mar 2026 02:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774318216; cv=none; b=I+b62ewcUYb9TrqhtNE0Uua/7Oh4tEh04SebAbFeg405N0EswKCjHzCc1KPv3Nq/zZIU5XwNnZiFiAzKkPqTtk/FZhHXLuTq0SnIU/mbourn9z2pTDjOU169tR7R9gqdce2LkIOty/Z615Lm2HEQwzz2Vb0NCwYFX9eeEvu3eFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774318216; c=relaxed/simple;
	bh=2717sMQiIIX/+UcL7y+P75c+Ta2GTI2dfXTnXCmd0d0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gLI62Gsh80cmobIr82/5nDPPSjV8RKIJJWODJmCJJ+UXuozfyfoAtElvqMACqW9Xi5l5sDzXDMo+SUNCPUJtNc72oYV1BUTYytsNUCaBvrI0l4EVdrdJ2r+Xc1gzeJR+3p+LpdbkT+EdPdjrfM2NmCRvu0C1hnuaUq5ATg9siKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ei1rOfJh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5828EC4CEF7;
	Tue, 24 Mar 2026 02:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774318216;
	bh=2717sMQiIIX/+UcL7y+P75c+Ta2GTI2dfXTnXCmd0d0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ei1rOfJheAF1NhgV1VBV6EUvqF193lnLCegLJPRbBZqcFsIJ1feoBCGNrlZq7mqan
	 Z6WiFvvdwP3ONAKVcsOnkmVA0/Ct3tzFMewpWEcAiVNZTN4vmbdFdirvQTIjeXZdA+
	 /IdV/wkYtLCoeYVd4vqvU/dTSPlcj+FgpO9eqIRhJZMN3ItwsSfswifuXHpw1mSH0Y
	 ssjHW/x8vY4Bk5VMSe100pEgl7sX5lvnFAxo2O7pYkl/HoRL0dF2KeKRoTlVAjlM9F
	 hmliZWlGTUjY3VLAzg/dKp7f3iMNpeJg4p2OZYkNZffDKhBMzEB8rq8cDTtOjbt7dk
	 DLa31owo/tpow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E613808200;
	Tue, 24 Mar 2026 02:10:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests: forwarding: local_termination: fix PTP UDP
 cksums
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177431820454.421116.9447534610359306782.git-patchwork-notify@kernel.org>
Date: Tue, 24 Mar 2026 02:10:04 +0000
References: 
 <651c3decb80023e4395ec149fd81110afa3869a1.1774067006.git.daniel@makrotopia.org>
In-Reply-To: 
 <651c3decb80023e4395ec149fd81110afa3869a1.1774067006.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 vladimir.oltean@nxp.com, alexander.sverdlin@gmail.com,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270847-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,nxp.com,gmail.com,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
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
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7F37230102C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 21 Mar 2026 04:26:11 +0000 you wrote:
> All six PTP-over-IP test frames (3x IPv4 + 3x IPv6) contain incorrect
> UDP checksums. The stored values are the ones-complement sums of just
> the pseudo-headers, not the complete UDP checksums over pseudo-header +
> UDP header + payload. This is characteristic of frames captured on the
> sender before TX checksum offload completion.
> 
> For example, the IPv4 Sync and Follow-Up frames both store checksum
> 0xa3c8 despite having different UDP payloads and port numbers - 0xa3c8
> is their shared pseudo-header sum (same src/dst IP, same protocol and
> UDP length).
> 
> [...]

Here is the summary with links:
  - [net] selftests: forwarding: local_termination: fix PTP UDP cksums
    https://git.kernel.org/netdev/net-next/c/db3bd9e55c3c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



