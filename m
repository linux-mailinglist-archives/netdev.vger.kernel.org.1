Return-Path: <netdev+bounces-282184-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SM0THWti8WnhgQEAu9opvQ
	(envelope-from <netdev+bounces-282184-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 03:44:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DCC48E100
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 03:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2E7413080436
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 01:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB69F25F994;
	Wed, 29 Apr 2026 01:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYsu5qfx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A1025CC79;
	Wed, 29 Apr 2026 01:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777426864; cv=none; b=QK1dhnbCkNenZRSPhAsG7buqNe8NJmuWabZC464tTQOXkYCs0SX/grWPWO1htNo7EqpaeJvQuMAmKoBr9kMTMe1NmSFB8YoTGqXWbZCbRuG4QUG6PHhfWxhX33yQMkdL7q36UIo2YfQpsZxvHbYjRD1TDlFHb0K+B4RcxEcOFps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777426864; c=relaxed/simple;
	bh=b11SGdH0FsTnTNE4pNU/h3ZTWlCwDvtiUgKtozYLqAQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lOZD8adcw1iSfuheTz4k7va2Ypk9oGiTuFoXg2qqVshvPaekVsIhSdAWnbshcbfzG07vI1slMgGgUn60zt7QcGSP7cQUGk9HVKfOO8CSQrG1kUbEhduoOdhGHOyg/iQpYExCE2Wv6E0nfUBfkX8XMDi22rrXwbBpktQYLAmbofE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYsu5qfx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82805C2BCB7;
	Wed, 29 Apr 2026 01:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777426864;
	bh=b11SGdH0FsTnTNE4pNU/h3ZTWlCwDvtiUgKtozYLqAQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dYsu5qfxlbNVzNlvJnWw4lDlFj8hwTFRaV0FUlqhDJrvnkOhXpZ9rEEf0MgWfusn3
	 4LF4Zn43srcD7iHMJOY+fZAaYWZeHW+9A5Gxy26/SQg7cOaDqgX4qEu5FKSY39B+a4
	 IB9WtQ577pIiItpJCL6X5R3Pb+DC24n3Ox13FBRWvyW414nQpQboByEfyF2+4kYVoK
	 dCM4vsSUzfZoKfYcdPoO448aeztqwaJwSDis9+5QyzrHTSsJIHh8ZES1ppmuvDjgVj
	 WhgkATC4NfmZzb8twEDD59PgiR8zhwconLD7KThyZFdKBTNeCYxvzzMPP48KXyQEUm
	 31TOBN4aBqmPw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E0139302C2;
	Wed, 29 Apr 2026 01:40:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/4] netconsole: configfs store callback fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177742682054.1291511.6093516123446754481.git-patchwork-notify@kernel.org>
Date: Wed, 29 Apr 2026 01:40:20 +0000
References: <20260427-netconsole_ai_fixes-v2-0-59965f29d9cc@debian.org>
In-Reply-To: <20260427-netconsole_ai_fixes-v2-0-59965f29d9cc@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, k-keiichi@bx.jp.nec.com,
 satyam@infradead.org, akpm@linux-foundation.org, thepacketgeek@gmail.com,
 asantostc@gmail.com, gustavold@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com, horms@kernel.org
X-Rspamd-Queue-Id: 15DCC48E100
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282184-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bx.jp.nec.com,infradead.org,linux-foundation.org,gmail.com,vger.kernel.org,meta.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 27 Apr 2026 07:30:34 -0700 you wrote:
> V2 for issues in netconsole's configfs store callbacks.
> 
> There are still some changes I want to make, such as, having the dynamic
> lock when reading from configfs (_show() callbacks), wich will solve
> other issues, but I will keep it for later.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> [...]

Here is the summary with links:
  - [net,v2,1/4] netconsole: return count instead of strnlen(buf, count) from store callbacks
    https://git.kernel.org/netdev/net/c/d62c6f2df5c0
  - [net,v2,2/4] netconsole: avoid clobbering userdatum value on truncated write
    https://git.kernel.org/netdev/net/c/e6dd94252b0f
  - [net,v2,3/4] netconsole: propagate device name truncation in dev_name_store()
    https://git.kernel.org/netdev/net/c/92ceb7bff62c
  - [net,v2,4/4] netconsole: restore userdatum value on update_userdata() failure
    https://git.kernel.org/netdev/net/c/869cd6490faf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



