Return-Path: <netdev+bounces-255306-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGRHGJ1dfWnaRgIAu9opvQ
	(envelope-from <netdev+bounces-255306-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 02:40:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C278FC00CA
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 02:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83406301B739
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 01:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD38326936;
	Sat, 31 Jan 2026 01:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XdNTUPMh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930AD31985B;
	Sat, 31 Jan 2026 01:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769823623; cv=none; b=NM40Bgbbjy0hDeFZ6JWL5x7M/G5hzKEe87snsgPQ/ugLsLGm4T/eNj8eC2HGeTaBpE35tfR6fOEVAevEyw9Uc1GQmWeBW0Pb/elYpA+eNjTrTpVFvTWbu5R0BUM0V9I31afqRaaJ3O+Bsd0TmOQatSGoGM1fBusvAdjd1pE/xRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769823623; c=relaxed/simple;
	bh=Zw+Uf+dUGh90ku/Ume8HTay7r4+I3Nl00AdlbZt8oq8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fyMKcXK4RRoKihbvYdF1vhFNFiX9pqcruoxBG4xGzZW9r8DJNZd5kZc5u78M35UL7Osa/hmoy3hd9pcm6rpyhnXeZPZdKy9myjgtG9w3EqeDVkfvveOovCumbyMDtcEDZ+7k9VyTJkLpjBGY81InG40JPvXoHWFxAeFvuCnsL5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XdNTUPMh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27FA4C4CEF7;
	Sat, 31 Jan 2026 01:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769823623;
	bh=Zw+Uf+dUGh90ku/Ume8HTay7r4+I3Nl00AdlbZt8oq8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XdNTUPMhtUYEhA3vh+FS90utnmzz/FSNUqMgRXibo0SXtMrcvF3dvaz82qnUqJgRU
	 os+YdhMmOy02AQzwLvHPIcVnzMwsxZGwiGTwkFMjApSz5Asqem73EKhrqVr38xOXMz
	 QxFCF5hgWjdV9vjEJFGZsmNhXaeO80zdvFK2CLiuBfSGqS3olPoBzfY/RbF+eMESPl
	 KVHMj9Bk1P16LuvULJ2NaheTgqF8x7tzpHPVGwLT4yAgXaCmugj7QZjvJPnQlFflZ7
	 Mvh7lkC6wd7zPIl6DkJ1navs1lRCnj4FS3PEya74blwCDwjtoCJE5Oy9A93q3qpbZ5
	 Fh9b0XEmkoM8g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BCB1380CFFB;
	Sat, 31 Jan 2026 01:40:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] udp: add drop count for packets in
 udp_prod_queue
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176982361535.3959411.16989370422446083918.git-patchwork-notify@kernel.org>
Date: Sat, 31 Jan 2026 01:40:15 +0000
References: <20260129083806.204752-1-mahdifrmx@gmail.com>
In-Reply-To: <20260129083806.204752-1-mahdifrmx@gmail.com>
To: Mahdi Faramarzpour <mahdifrmx@gmail.com>
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org, kshitiz.bartariya@zohomail.in
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,kernel.org,google.com,redhat.com,zohomail.in];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255306-lists,netdev=lfdr.de,netdevbpf];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C278FC00CA
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 29 Jan 2026 12:08:06 +0330 you wrote:
> This commit adds SNMP drop count increment for the packets in
> per NUMA queues which were introduced in commit b650bf0977d3
> ("udp: remove busylock and add per NUMA queues"). note that SNMP
> counters are incremented currently by the caller for skb. And
> that these skbs on the intermediate queue cannot be counted
> there so need similar logic in their error path.
> 
> [...]

Here is the summary with links:
  - [net-next] udp: add drop count for packets in udp_prod_queue
    https://git.kernel.org/netdev/net-next/c/820990d66577

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



