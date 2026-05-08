Return-Path: <netdev+bounces-285961-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id pvJQO+wy/mmHnwAAu9opvQ
	(envelope-from <netdev+bounces-285961-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 21:01:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8174FAD0E
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 21:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D52D73015736
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 19:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D39377ED7;
	Fri,  8 May 2026 19:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LqLZyNzz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42285375F7B;
	Fri,  8 May 2026 19:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778266857; cv=none; b=stL5YNwH11AHz0ou+U43Xgi6V0iMqXpPAqdqJ/39SreMgRb6ArI8yUvcFZqrS2vqBuG5DUm+uVX/FHUcq0JPeyfQwOz7T1Ij99VjDoSFpln9whTWyWe/kPzYASzprtxVnrXdS5P4Enx8XwY5ZQL0V01+eBoXJ/xmo7eRHmKIgZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778266857; c=relaxed/simple;
	bh=7s642tMqiyWXhfKHgVpSsbGdfbOsyP68cMDRBDMd5Po=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FJ7+IiTE7SnK4w5NXeyVvJRy10zvwoQte9O7vu0npV6tiWBjvCBYzgFICqD4f0yHS+kNphjimH2B+0mOf/flZ6TurlbAGdZFOjVxAiBlu8dHE22+wox40N99nzO7GbTH+dEUstNgYxmPNQsR9ex9lbxI2LpcDHi7rQSKoLtma6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LqLZyNzz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B2BC2BCF6;
	Fri,  8 May 2026 19:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778266856;
	bh=7s642tMqiyWXhfKHgVpSsbGdfbOsyP68cMDRBDMd5Po=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LqLZyNzzpY8bvIdKyylgj97nBUbny232Xb4z+N3NhlbWKPGc4biJclQgqp7dyeYL7
	 vJp1xP/i1aNS7hZb/CylEw5xaMEdD375MEi8BwFKmLG2KNmFTS+Ofa5jzs9uF9fea9
	 kuhiXqLYNNdyrlfZPAky3eFo+DFg86KgXLPbuT0tc+vtRwpG0yp3qVZQH3u21OzQu5
	 Ia7I3eb5GyzLYYT1jnxHypBMsRkdomgkyRU508vJAGgQyWTQ9L8E35IDav9LfNFaXY
	 dlgNDSRIbJUxwsHoLfJO0E06Jy/+j6ANVSL/Z8qQchMyYg7tpD0sSgmsPtLaeK9MWm
	 TQ9KbkLHStXHw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CDA4381197C;
	Fri,  8 May 2026 19:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] Bluetooth: serialize accept_q access
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177826680530.808173.13571641785763854234.git-patchwork-notify@kernel.org>
Date: Fri, 08 May 2026 19:00:05 +0000
References: <20260506114338.2873496-1-n05ec@lzu.edu.cn>
In-Reply-To: <20260506114338.2873496-1-n05ec@lzu.edu.cn>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 marcel@holtmann.org, luiz.dentz@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jannh@google.com, yuantan098@gmail.com, yifanwucs@gmail.com,
 tomapufckgml@gmail.com, bird@lzu.edu.cn, wangjiexun2025@gmail.com
X-Rspamd-Queue-Id: 8D8174FAD0E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285961-lists,netdev=lfdr.de,bluetooth];
	FREEMAIL_CC(0.00)[vger.kernel.org,holtmann.org,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,lzu.edu.cn];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  6 May 2026 19:43:30 +0800 you wrote:
> From: Jiexun Wang <wangjiexun2025@gmail.com>
> 
> bt_sock_poll() walks the accept queue without synchronization, while
> child teardown can unlink the same socket and drop its last reference.
> The unsynchronized accept queue walk has existed since the initial
> Bluetooth import.
> 
> [...]

Here is the summary with links:
  - [v4] Bluetooth: serialize accept_q access
    https://git.kernel.org/bluetooth/bluetooth-next/c/303bd23ee2e9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



