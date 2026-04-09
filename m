Return-Path: <netdev+bounces-276782-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OYeMg4N12npKggAu9opvQ
	(envelope-from <netdev+bounces-276782-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 04:21:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCCF3C57F3
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 04:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74D6F3019BAD
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 02:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0FB368946;
	Thu,  9 Apr 2026 02:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yvard4xZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D72368293
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 02:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775701232; cv=none; b=ZdK8KaksVbKjOU1OC9OBwkq1JP3aa36nKw8mcVUpBDzZZip8qRKLXxV5wxKBvmAO2UVnjFQu978f6TLXthRw6XXzxQ/fmFgpE8wGUsxz3Wj7nv5EYX6RQ0UObpk8mMieWVyMI+tMT1ET86vDOlsne7gb8C6BCne0QoavSYKEvtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775701232; c=relaxed/simple;
	bh=3o7KTKIEcYRhtKue/mJ7//7cbEmrCMkleK45w74r6e0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qPqxZEWxRA3V4M4t2KtokUz0bPVgIObipXRGonVc1XRECIiJo/ItT91u35RSYNlzBQN72BeX3ZOMY1Qna3SZEhds2vwYox68YFSmfPEvIAPcSfvG1WRQccepxVIOnCTs4yrkMCi3/MOn8hnMZ7za5qZiDJSF1P3P1qggHPZVSVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yvard4xZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C14AAC2BCAF;
	Thu,  9 Apr 2026 02:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775701231;
	bh=3o7KTKIEcYRhtKue/mJ7//7cbEmrCMkleK45w74r6e0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Yvard4xZZ+4B3/UyTdNg18Fmn3/WwkcHLEgDjNqp6FGXWsXyWMHN1I4lNs2RqHVGf
	 d81vlna6yx9Qz92uDmwIFoHq4d4MzR7Dummb8qpb2KxbYBqMCQEN3NkFUn1lNFI6+9
	 H7+WjGhTZIc6za6WHu9Tobdmdu060YkyeRp/E5LAo+jSfXLiacs0zZgQ+pyVYcZH8b
	 PWnOnVbdjVlKvwuBs7eiwvYNVQHsQ8rjb3OVV2cRx37MWMb/sPwgmKF7vTuwvJowah
	 vpRbIG6rnQTpUCe0vSDPgGgw0cOstdqFyJb1rmgLISiOflUQqZBk6VDDokaJYVXmki
	 kYmQeEovOKcnA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 403233930793;
	Thu,  9 Apr 2026 02:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ioam6: fix OOB and missing lock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177570120779.959042.1761186273558985346.git-patchwork-notify@kernel.org>
Date: Thu, 09 Apr 2026 02:20:07 +0000
References: <20260404134137.24553-1-justin.iurman@gmail.com>
In-Reply-To: <20260404134137.24553-1-justin.iurman@gmail.com>
To: Justin Iurman <justin.iurman@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276782-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4CCCF3C57F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  4 Apr 2026 15:41:37 +0200 you wrote:
> When trace->type.bit6 is set:
> 
>     if (trace->type.bit6) {
>         ...
>         queue = skb_get_tx_queue(dev, skb);
>         qdisc = rcu_dereference(queue->qdisc);
> 
> [...]

Here is the summary with links:
  - [net] net: ioam6: fix OOB and missing lock
    https://git.kernel.org/netdev/net/c/b30b1675aa2b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



