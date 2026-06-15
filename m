Return-Path: <netdev+bounces-299665-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4DlnJrKNMGp2UQUAu9opvQ
	(envelope-from <netdev+bounces-299665-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 01:41:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA9368A9E9
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 01:41:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=S997qUK6;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299665-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299665-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEE5E3075437
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 23:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DFF346E66;
	Mon, 15 Jun 2026 23:40:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C6127FD51;
	Mon, 15 Jun 2026 23:40:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781566832; cv=none; b=NbLAClD03u7W7xWCBXO7bEMFjrOaQ7yG1ymk+S2pLxVYs4nvSJ8MgRVHi4lbB9zlrLXXbpkc+boLUMyHGU/io1hy7hGITZmygI6d8iuYIAM2ngwPuQrCy9fY/eZvzJd7UfnMuuR6eG8BcIb6vvkE382n8MqXc13TPWWvOKYQMrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781566832; c=relaxed/simple;
	bh=YWFhuLh47LIuayAiYIm3986IlaylnHH07h8VfodK68U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IVuzs4veS94TyAEsX9JZdzXwkf3NTUGbHmcjH0rkYy3yybJtyq21M+Gr09kWpbY/PiE3Gj2Mp7lb5+z1GrkrACJAAv8Pg5dy3OK1y9S50Yf6BuoPLbPuIrEPiLHXNLc0klLB7yeCP+ZtNyGLegZWtlTbpvQw7TIk2QqjnRC4h+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S997qUK6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F9E11F000E9;
	Mon, 15 Jun 2026 23:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781566830;
	bh=0HG/R2bpOUkgG08uopBzx3JjVKz2/3HN1JP1LTvWEOc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=S997qUK6RKKv1he7OdNjuWK4MJQAH2p6y4j2o86GRE4k6ZN/RDa70tfvb7JnuSBYF
	 cV/pS9yhDC/7PhpnY4cSNKCAW4s2ohMxsM3LGaQpZ3NGuShpUvcZSpyDHlmeO9f1AR
	 l3B5pRqKl/mvmbUfJQulY/M12AQPQKu/w8ID9GK8OJ2XnxH7uFDppVGnadNGZiF36L
	 oWBva62MzGekwdZvx2g2JvsPXKwbBAkrL35Y6AJNGRoVma1mqx9n+q6uAPugTSqDbg
	 J07xTrmLlbloW/EPBFOhM39NjHHs/iI/TYaLilez1AziFuN3JiGZGpkgBCYZyT4Qmu
	 6xPaI4ucSV1Zw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568963839A08;
	Mon, 15 Jun 2026 23:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v14] selftests: net: add local ECMP rehash test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178156682488.339383.9205404821532401957.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jun 2026 23:40:24 +0000
References: <20260615042158.1600746-3-ntspring@meta.com>
In-Reply-To: <20260615042158.1600746-3-ntspring@meta.com>
To: Neil Spring <ntspring@meta.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, ncardwell@google.com,
 kuniyu@google.com, davem@davemloft.net, kuba@kernel.org, dsahern@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, bpf@vger.kernel.org, martin.lau@linux.dev,
 daniel@iogearbox.net
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299665-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_RECIPIENTS(0.00)[m:ntspring@meta.com,m:netdev@vger.kernel.org,m:edumazet@google.com,m:ncardwell@google.com,m:kuniyu@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:dsahern@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:linux-kselftest@vger.kernel.org,m:bpf@vger.kernel.org,m:martin.lau@linux.dev,m:daniel@iogearbox.net,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2DA9368A9E9

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 14 Jun 2026 21:21:58 -0700 you wrote:
> Add ecmp_rehash.sh with nine scenarios verifying that TCP rehash
> selects a different local ECMP path for IPv6:
> 
>   - SYN retransmission (forward path blocked during setup)
>   - SYN/ACK retransmission (reverse path blocked during setup)
>   - Midstream RTO (forward path blocked on established connection)
>   - Midstream ACK rehash (reverse path blocked on established connection)
>   - PLB rehash (ECN-driven congestion on established connection)
>   - Hash policy 1 negative test (rehash attempted but path unchanged)
>   - No flowlabel leak (client mp_hash does not alter on-wire flowlabel)
>   - Dst rebuild consistency (dst invalidation does not change path)
>   - Syncookie server path consistency (SYN-ACK and post-cookie ACKs
>     use the same ECMP path)
> 
> [...]

Here is the summary with links:
  - [v14] selftests: net: add local ECMP rehash test
    https://git.kernel.org/netdev/net-next/c/ae57a5533243

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



