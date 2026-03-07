Return-Path: <netdev+bounces-265010-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBggHwiFq2n/dgEAu9opvQ
	(envelope-from <netdev+bounces-265010-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 02:53:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F39E0229843
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 02:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 381BC3090EA5
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 01:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F773128CA;
	Sat,  7 Mar 2026 01:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rebDNblq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609B733290F;
	Sat,  7 Mar 2026 01:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772848211; cv=none; b=cdJDf1EI44fuqgkyPrRJ6rP8gRL6/f30quU5VuIAQfF6uWOaNsGARmygPVTxjWGkQhLnDnpV9yH/FijRZvIj82JRr06SjqkhvSEj2bV9ZPHJ2GQ9ewxkPpBbB5+w0uiAv/0kuYHBoS40ofzRBVh03YBFb6t4YpamH7ou7v3EqiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772848211; c=relaxed/simple;
	bh=q+dkVaegM7HQrWVqo1Eiye5rYBXeYQR7vy8Zkngxqkg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cxabbncAbq769IczK0qLPpER7UKoMghnuRmnBbJYELL0CniotADZ6yy26v73ZKHqE+2h7no46Of78nyO3MadPl/VOevSrhqKwXv87si7R70zCQR/RNcRn6drXTsj0dm1QWgE3Fv0ra74xxNBEPEshSP7gOaiI4zz0CS4Pqz7738=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rebDNblq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2941C4CEF7;
	Sat,  7 Mar 2026 01:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772848210;
	bh=q+dkVaegM7HQrWVqo1Eiye5rYBXeYQR7vy8Zkngxqkg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rebDNblqkSpmDqaJrvO/VjQ7jWujgkmK9Jt5O3sQgpctyMpVSUGwkSAJS64x8pyu4
	 Kr9f1NUGrRobNEenzjpC9wTrIRgu+D1UtW2V5I1Rtmw0tS/e01wqMBHbS1/eQ3Pr5N
	 ntzXpJbEKJrl20tpzXrvBqeV5W76ngB8FqbnY9YvmwI7qumIjMJD9HQPZ+4f3arr/7
	 vke9JyIYb3e9xlSaDXC5cPsE1CW5+5Q+vUgbm9nMxFNwRXPC5WfaYIx/R0sz66yoZ8
	 3L5576ewgCOC/lI/N26Yf+DrCIbDbnoqDupe2sub19kdbkIl4I7oRz/Si/c36PTevJ
	 FnqOnakoRYzHw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02CD03808200;
	Sat,  7 Mar 2026 01:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] virtio-net: xsk: Support wakeup on RX side
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177284820957.121768.10885517697110084054.git-patchwork-notify@kernel.org>
Date: Sat, 07 Mar 2026 01:50:09 +0000
References: <20260304154317.7506-1-minhquangbui99@gmail.com>
In-Reply-To: <20260304154317.7506-1-minhquangbui99@gmail.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, eperezma@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 kerneljasonxing@gmail.com
X-Rspamd-Queue-Id: F39E0229843
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265010-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,linux.alibaba.com,lunn.ch,davemloft.net,google.com,kernel.org,lists.linux.dev,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 Mar 2026 22:43:17 +0700 you wrote:
> When XDP_USE_NEED_WAKEUP is used and the fill ring is empty so no buffer
> is allocated on RX side, allow RX NAPI to be descheduled. This avoids
> wasting CPU cycles on polling. Users will be notified and they need to
> make a wakeup call after refilling the ring.
> 
> Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v3] virtio-net: xsk: Support wakeup on RX side
    https://git.kernel.org/netdev/net-next/c/e3f8800aa243

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



