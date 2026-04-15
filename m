Return-Path: <netdev+bounces-278810-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +P4qAXGj32miXAAAu9opvQ
	(envelope-from <netdev+bounces-278810-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 16:40:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB38C4056BA
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 16:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 009063004D8D
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 14:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BD93BB9EF;
	Wed, 15 Apr 2026 14:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4y7zSfA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2F73AD538
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 14:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776264038; cv=none; b=hRbAYlF6mPGskUqyKVD8WBmSRgHKo9YcEZsjwNXYNyPHb+WR7hC5dS3Wosmrc3j682zFwfaN7SKmyOSIH1BKKF08nQQReO3ZqAiOW/3gxIrEDmlJZVjZXnT1a+kEz9WNBon2jNogOAFvPJZPlYc+9kerMeS1RPk5p+v/UKV+Q3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776264038; c=relaxed/simple;
	bh=Z/W6W2WjNREDxe4Lymrof3Xk3U6rQAeZ/r5H8ojJIuM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=F+01QEbdgdJOBFdcMEViFREEDI1DtWHMrWIcDVz5yH0SDcha0mrKGJQwR6GFEhh6wS01DBF6lowLp5u2OT84CLwixf638Edr4JRpv6dBFk+eVqqaL3XEujzrYs5NPQiXDR1xHyLo6PmDYgjYKgas1yVmu3KYlGXXBDpOGEwKWJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4y7zSfA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF42C19424;
	Wed, 15 Apr 2026 14:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776264038;
	bh=Z/W6W2WjNREDxe4Lymrof3Xk3U6rQAeZ/r5H8ojJIuM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=R4y7zSfAOgc/AUV5P6ABU07qLITy7a4hA519dhrJHoz5D6EFRMDPJc2Hd+vNDi4N+
	 bHd7l937bCbn7Q7k9oAanX6g160NHy6dIG9cevBfnRx7iwn54N9h6wWr8OpXFvXir/
	 BogxfVBk7SOqNixtXFwCxs0Crz8wyBRazqGEuIigm34C8PFqiu9a155Igu/UhheGTg
	 BLWaEDnGtNXUAkVVg1fecTakUvw7DgZp8JyOVe4LX52AqqdPvjbQg0S3Fieu6w9d9P
	 SOU0dgAZdCCOUQrkBwXiZHDtWhcm1TNdWkaUYUi2fbj23+awygrB41XOAQ/WVriqgv
	 QR6RWug9AB7Hw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE05380A960;
	Wed, 15 Apr 2026 14:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2] ss: force a flush in monitor mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177626400804.2265472.8517062303747493721.git-patchwork-notify@kernel.org>
Date: Wed, 15 Apr 2026 14:40:08 +0000
References: <20260415130307.1016393-1-edumazet@google.com>
In-Reply-To: <20260415130307.1016393-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: dsahern@kernel.org, stephen@networkplumber.org, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, kuniyu@google.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,networkplumber.org,davemloft.net,redhat.com,google.com,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-278810-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EB38C4056BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Wed, 15 Apr 2026 13:03:07 +0000 you wrote:
> Call fflush() from generic_show_sock() in order to work
> with pipes and redirects.
> 
> After this patch, "ss -E &>log_file" works as expected.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> 
> [...]

Here is the summary with links:
  - [iproute2] ss: force a flush in monitor mode
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=4d82739fda71

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



