Return-Path: <netdev+bounces-256542-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJzfEKW/gmljZwMAu9opvQ
	(envelope-from <netdev+bounces-256542-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 04:40:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9516CE1532
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 04:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BB1130602C3
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 03:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2A22C027B;
	Wed,  4 Feb 2026 03:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2mpXzza"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26970285CA8;
	Wed,  4 Feb 2026 03:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770176417; cv=none; b=ZHD0RqYVI2PcPzfIZ5aWZfvkzz4CGLbf9u4XGh+/TRzN0xxmsiOE5nbKa8kIB7TyyHANQilv0bI9YNtaY5NhnrSUojCmr7hjihnK/GwpdpRSgzDYSwlkSNgVW+DqdqJsOLSUsqeUaPcgNV3Q3Xr9uqDdpZeNARqzEhIgzE1MBp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770176417; c=relaxed/simple;
	bh=xuzQ7yeJHibCEn7xA4UUhhyO8zG1Diwl4cCpImKyb2M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pnxf/GOEYRR4BkP9roaVv+j74+LkWUPyRs5vutsn9FwSh7zwL26jg+UYjB1tZf7QanPioLFTnyxMT39Rj2HN+zuRiiP8qo1R9Cc+Ec7lihnI7OjOcLXPg52NSj9mm85T+ZusGhQcSg+gYbdK5i8VmNal8VTFeCxDaw7rAqzBqns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2mpXzza; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2894C4CEF7;
	Wed,  4 Feb 2026 03:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770176416;
	bh=xuzQ7yeJHibCEn7xA4UUhhyO8zG1Diwl4cCpImKyb2M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=R2mpXzzaMTXFsmemif8Pwpw1bWGLGpoM5B7/2qiUCCxHMVlqv1sVzm4qgfwohn1VG
	 mU1S4pqpKNoljckUQdnX5BGwesZGVKaGOeSil1tVHpgRcTYZgWf8Zb/mLMH6eD1A8x
	 LeorkrHph0HFUGZCdSfW47giSHVZkSuyNuXNpuU9fRwpBmxoGrEI3H6di5ypnwCXuM
	 dPkPrBwvnFOOP43EDtNqjSJhwLxewhG1uIbHj9In9kFUQuu5zy1E1HVx2GJK1VoSuL
	 tX3s0IeXk9EqYC3Y0YBTs76+puyhNSQ98h7e/O3Cv8PNel7ZPT7Vx1WdxF0hOfliFJ
	 4YvowdgJPTn0Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 16DA73808200;
	Wed,  4 Feb 2026 03:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] gve: Stats reporting fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177017641288.2168983.8087893883904523587.git-patchwork-notify@kernel.org>
Date: Wed, 04 Feb 2026 03:40:12 +0000
References: <20260202193925.3106272-1-hramamurthy@google.com>
In-Reply-To: <20260202193925.3106272-1-hramamurthy@google.com>
To: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: netdev@vger.kernel.org, joshwash@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 willemb@google.com, ziweixiao@google.com, jordanrhee@google.com,
 nktgrg@google.com, kuozhao@google.com, yangchun@google.com,
 awogbemila@google.com, maolson@google.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.com, maxyuan@google.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256542-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9516CE1532
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  2 Feb 2026 19:39:23 +0000 you wrote:
> From: Max Yuan <maxyuan@google.com>
> 
> This series addresses two issues related to statistics in the gve driver.
> 
> The first patch fixes a memory corruption issue that occurs when resizing
> the stats region during queue count changes. By allocating the maximum
> possible size upfront and aligning offset calculations with the NIC,
> we ensure stability and accuracy across reconfigurations.
> 
> [...]

Here is the summary with links:
  - [net,1/2] gve: Fix stats report corruption on queue count change
    https://git.kernel.org/netdev/net/c/7b9ebcce0296
  - [net,2/2] gve: Correct ethtool rx_dropped calculation
    https://git.kernel.org/netdev/net/c/c7db85d579a1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



