Return-Path: <netdev+bounces-284165-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGyJDQtU+WnF7wIAu9opvQ
	(envelope-from <netdev+bounces-284165-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 04:20:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5624C5F3F
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 04:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C1B7301A165
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 02:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D97390CA6;
	Tue,  5 May 2026 02:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBwPcBey"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1808336F43E;
	Tue,  5 May 2026 02:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777947656; cv=none; b=e3SawtHXgL+eC4ylfOIyN0ZpBnx5g+o9fx2m+D/nxkmC3Ax7Xx3gb7nHZn+3lMLAKkXN1fM9J9XXj/69hed8K9vlXmCzQVcmcOM3ky+AZ3DS/9ypKNu3j9iZzadKqLr8blDdFLWwfLA+rPDdOZrgzrURDmxozTNVxx9RDAavTPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777947656; c=relaxed/simple;
	bh=dl8IxoXyqBKSnmIR/5RHeIyxyC3GJ6oPPNEUS2xiSrM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JFHhXPiRpxYSQP3vShRZgMRpZPj8b+xF33+W13t8iAXcFR8K8ZtpUjul1NCQQIsSuPnTQkPyOUcBzE6OqDgYA8A0uo2ONEt1UJaogaPyur+FQLHEfgZR6e0jxENwKLNEBjXSigP+qOkEpHIpk4TOdqmTFB9XKVTAxBBKeqomYik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBwPcBey; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4871C2BCB8;
	Tue,  5 May 2026 02:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777947655;
	bh=dl8IxoXyqBKSnmIR/5RHeIyxyC3GJ6oPPNEUS2xiSrM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YBwPcBeyKguNK4XwK6M3C93C4ZZ/tzDCziJZF6b6Hwd1RiNcbU6PTuv9fdm9MAJZ+
	 +907+nXQ8l42MfVIEtWiee2NnT81LDHaUlIYy86zTdg1gXRYCR+pvXjHrPjChW2Qtn
	 f0Kcfp9UPPyYhpXAtasyRiAWQdpoyd0z+bJJMN8UmsOi5xnSWati4DvgbVBJxlHgOd
	 DYFGb6lrlBbRTMGWwFXZr7aBXZKIP1PvKa1f3tmlgJanCAwdJPjuZWERHGohjgHZJd
	 mYz8xtpgJJuyqGCkNB7vy+kwM84fk7s/JFz97CC3ZyV0qof+OtzjPBUn8Au5WOjIJX
	 Oele1ySggeqFA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E1B39301A2;
	Tue,  5 May 2026 02:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] vsock/virtio: fix potential unbounded skb queue
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177794760655.1391894.17424925613483370509.git-patchwork-notify@kernel.org>
Date: Tue, 05 May 2026 02:20:06 +0000
References: <20260430122653.554058-1-edumazet@google.com>
In-Reply-To: <20260430122653.554058-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, AVKrasnov@sberdevices.ru,
 stefanha@redhat.com, sgarzare@redhat.com, mst@redhat.com,
 jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 kvm@vger.kernel.org, virtualization@lists.linux.dev
X-Rspamd-Queue-Id: AA5624C5F3F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284165-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,sberdevices.ru,linux.alibaba.com,lists.linux.dev];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 30 Apr 2026 12:26:52 +0000 you wrote:
> virtio_transport_inc_rx_pkt() checks vvs->rx_bytes + len > vvs->buf_alloc.
> 
> virtio_transport_recv_enqueue() skips coalescing for packets
> with VIRTIO_VSOCK_SEQ_EOM.
> 
> If fed with packets with len == 0 and VIRTIO_VSOCK_SEQ_EOM,
> a very large number of packets can be queued
> because vvs->rx_bytes stays at 0.
> 
> [...]

Here is the summary with links:
  - [net] vsock/virtio: fix potential unbounded skb queue
    https://git.kernel.org/netdev/net/c/059b7dbd20a6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



