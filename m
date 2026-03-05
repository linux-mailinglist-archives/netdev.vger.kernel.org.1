Return-Path: <netdev+bounces-264112-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GK5YHfLXqGlmxwAAu9opvQ
	(envelope-from <netdev+bounces-264112-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 02:10:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDF4209B3A
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 02:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 372773018C24
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 01:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491B223B612;
	Thu,  5 Mar 2026 01:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSMpMrk+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2217E1A6826;
	Thu,  5 Mar 2026 01:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772673007; cv=none; b=qQKve3bAdYDddHeaSd3wDFhEI7ICWTkOIsT01MDpwnJxjXn6P031ANf7Oy1T3F60wWBqtAzaDiK8IiwnEY6WxfMYMcodfiU7NBYWPyh3TlPeRYln7HpMqehuHVds4OvT9KPuQnYS/s4ZGu6OTl1cnDZzwHaZjHIYQZOkEJq3HiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772673007; c=relaxed/simple;
	bh=4Qo7jvBU5fJ3BLp86Ae77NL3X3nvsbZjZ+yAMfjk7Eg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oPL3zPb5hX8drv6oUNCNwbqofo0I0WkFo0jlxgcxRJFRxaHRMPy5QDoZOEiF1sFdcthyMIWGGELNl7gSt8jHaYbbfsknxJPZoORSbfSVPKXMGcVSADrxlnt1mZmHIos3lULvZQlMlzw2xgE6Xpxf/GLbtng/1kyeM0qrXzVF/1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSMpMrk+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A336AC4CEF7;
	Thu,  5 Mar 2026 01:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772673006;
	bh=4Qo7jvBU5fJ3BLp86Ae77NL3X3nvsbZjZ+yAMfjk7Eg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OSMpMrk+IegZGQYfjaxyOnMjTpd3+yhM3KwZQ9nKw0RWAuOfyXVQuRKP87QKJePI2
	 vmeulQmG4pEhcah2Z0nWUbQiuNytuliXRcVN8FCR2geLxzmoU1sr6l5jPfNv32fk+h
	 NoAmDh6Gyl6otcWLb3tqC2upPZtB6saN6g3E3z3NvUnmxzIiPRghC/jqNtyD9Kz1mJ
	 Hpf5PsRghs9gA6zzaOXhOaDXDpX7dIRfMhuB3XJynhbORksb8KGfUYJkLkflXi9oMZ
	 L2KH8G4CXPxvGyaNz1BFRnnqDp72IHxipsToTs84LVrDrebqPsoWaFr+64N94yHXWw
	 sQjsmN0spS8Ew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FEAD3808200;
	Thu,  5 Mar 2026 01:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v10 bpf-next 0/2] Fix the null pointer dereference issue
 in
 bpf_lwt_xmit_push_encap
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177267300705.2465987.7557394320965019773.git-patchwork-notify@kernel.org>
Date: Thu, 05 Mar 2026 01:10:07 +0000
References: <20260304094429.168521-1-yangfeng59949@163.com>
In-Reply-To: <20260304094429.168521-1-yangfeng59949@163.com>
To: Feng Yang <yangfeng59949@163.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, posk@google.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Rspamd-Queue-Id: DFDF4209B3A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,linux.dev,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-264112-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[163.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Wed,  4 Mar 2026 17:44:27 +0800 you wrote:
> From: Feng Yang <yangfeng@kylinos.cn>
> 
> Fix the null pointer dereference issue in bpf_lwt_xmit_push_encap
> 
> Changes in v10:
> - Optimization patch. Thanks, Martin KaFai Lau.
> - Link to v9: https://lore.kernel.org/all/20260303074423.172680-1-yangfeng59949@163.com/
> Changes in v9:
> - Use dst_hold() and skb_dst_set().
>   !skb_dst skip.
>   Move all changes into the IS_ENABLED(CONFIG_IPV6).
>   Use #if IS_ENABLED(CONFIG_IPV6); otherwise, a compilation error will occur when ipv6 is not enabled.
>   Thanks, Martin KaFai Lau.
> - Link to v8: https://lore.kernel.org/all/20260227082133.96951-1-yangfeng59949@163.com/
> Changes in v8:
> - set ret to an error code before goto out.
> - Link to v7: https://lore.kernel.org/all/20260226095156.117996-1-yangfeng59949@163.com/
> Changes in v7:
> - Use ip6_null_entry to avoid. Thanks, Martin KaFai Lau.
> Changes in v6:
> - Modify the bpf_lwt_xmit_push_encap function and add selftests for it.
>   Thanks, Martin KaFai Lau.
> - Link to v5: https://lore.kernel.org/all/20260210090657.86977-1-yangfeng59949@163.com/
> Changes in v5:
> - Refer to the bpf_lwt_xmit_reroute function to configure the dst parameter.
> - Link to v4: https://lore.kernel.org/all/20260209015111.28144-1-yangfeng59949@163.com/
> Changes in v4:
> - add rcu lock
> - Link to v3: https://lore.kernel.org/all/20260206055113.63476-1-yangfeng59949@163.com/
> Changes in v3:
> - use dst_init
> - Link to v2: https://lore.kernel.org/all/20260205092227.126665-1-yangfeng59949@163.com/
> Changes in v2:
> - Link to v1: https://lore.kernel.org/all/20260127084520.13890-1-luyun_611@163.com/
> 
> [...]

Here is the summary with links:
  - [v10,bpf-next,1/2] bpf: test_run: Fix the null pointer dereference issue in bpf_lwt_xmit_push_encap
    https://git.kernel.org/bpf/bpf-next/c/972787479ee7
  - [v10,bpf-next,2/2] selftests/bpf: Add selftests for the invocation of bpf_lwt_xmit_push_encap
    https://git.kernel.org/bpf/bpf-next/c/e8ae16d65ac6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



