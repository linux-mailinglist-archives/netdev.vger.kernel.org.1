Return-Path: <netdev+bounces-276806-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAr/NusU12k1KwgAu9opvQ
	(envelope-from <netdev+bounces-276806-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 04:54:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 572053C5C35
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 04:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4358030708A7
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 02:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9481737703A;
	Thu,  9 Apr 2026 02:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sc7KXseE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7B1376BE4;
	Thu,  9 Apr 2026 02:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775703091; cv=none; b=h6cqcmzI45i0SNmfRix/YKD/luVRPGOmscawvxlcI0gdRlLGpE8KaRefYzdm5b7hptBbaEJAcLdikpsw0eyiUjlwmNefDA7wE19Aq+0wpOnJbD2t2w6Hknpz8HhQj2tJuRZo5UHzWVxYm3814Go5NtuukUfMnCFoSzMP/XYFR5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775703091; c=relaxed/simple;
	bh=PbBzdI3qVvg8NGCmO5KQ9RJ+udLRsXOc/boi6AFdsgQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VvyAR6mD4nPzhQHYGltgCgV1CQFkUpg26MdYfQwnviuuf98xbd4Ts5dIUXbV1DhgknZV0OIykz6Zg2ubdtUg19nmkNj+n0IIA8Yh8XuZalfMdqcdXIyGtMJGsxzOXGGaIOdYvMBG59tWCWFG3CBMo5SdaTlcM8478XGONN4ppgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sc7KXseE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5023DC19421;
	Thu,  9 Apr 2026 02:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775703091;
	bh=PbBzdI3qVvg8NGCmO5KQ9RJ+udLRsXOc/boi6AFdsgQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Sc7KXseEdMPIjzjq+JbCSai8GUhdWZcEoY9D5tYoC2gpqwEcICLpKP/iX+43+lATC
	 nXaUh7czRKwVb8racnt0PnI7UOPUdpo6JuyoAe6GuTH/tLsTbVJFt5h/x7O51kCoAN
	 exNWYDlCY2+4lHDExN6Q9a3qk9895/kki7AOH1BPobUl4P7SFBmlqNK15Katn3se0r
	 DZOmr2ImOwotZzBhgDIaymxJ+pHgAbmpoP8PpwQLSfdFkVYCgLdG2n3wBKjZZEyRSS
	 Uyo/MR5tq9bI0/X/dHbH0DxFsuzmkhKVghZfXLAj+TRGzyA/sEem1HLMhNXH4Zjy5L
	 Pd7Vrc3ZPLkPw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA0BA3930793;
	Thu,  9 Apr 2026 02:51:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] selftests/drivers/net: Add an xdp test to
 xdp.py
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177570306754.968772.17543482845016752024.git-patchwork-notify@kernel.org>
Date: Thu, 09 Apr 2026 02:51:07 +0000
References: <20260406072655.368173-1-leon.huangfu@shopee.com>
In-Reply-To: <20260406072655.368173-1-leon.huangfu@shopee.com>
To: Leon Hwang <leon.huangfu@shopee.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, leon.hwang@linux.dev
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276806-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,linux.dev];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,xdp.py:url]
X-Rspamd-Queue-Id: 572053C5C35
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  6 Apr 2026 15:26:54 +0800 you wrote:
> In "bpf: Disallow freplace on XDP with mismatched xdp_has_frags values" [1],
> this XDP test is suggested to add to xdp.py.
> 
> 1. Verify the failure of updating frag-capable prog with non-frag-capable
>    prog, when the frag-capable prog attaches to mtu=9k driver.
> 
> The test has been verified against Mellanox CX6 and Intel 82599ES NICs.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] selftests/drivers/net: Add an xdp test to xdp.py
    https://git.kernel.org/netdev/net-next/c/5ae4ba98d725

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



