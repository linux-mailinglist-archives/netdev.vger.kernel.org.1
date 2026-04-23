Return-Path: <netdev+bounces-280724-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAoRHan+6WkHrAIAu9opvQ
	(envelope-from <netdev+bounces-280724-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 13:12:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D83DE451204
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 13:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7945E300F9DB
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 11:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9043E6386;
	Thu, 23 Apr 2026 11:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QMyjkQJz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DE23793BF;
	Thu, 23 Apr 2026 11:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776942644; cv=none; b=Cg/TvswbtyBEv/SxSk0lZdIqGSVxOVSCvDy2NErFNeLoT+aQAk3p/NXxfe8DUhuDiHeEniidCEVkua7I5HmVlhq887I/Vpt65HuGZJy7kszN4p4Ywz3PiM0kgnqX3yY3PPsBD4bq2CpDQKzNx7AMawm1v6vih1uaM62f4ra4ME4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776942644; c=relaxed/simple;
	bh=q/MO0aEEY1J/xinh+nE2w5/ns9zt5bzai2BiTVCHNRk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bl1+JGDqNZR5jP8Nb9DlQsi4q6ukYL90AUEYfEH66L/jszl/3atenvFY7T45ON3xesXkdJsZ+WmQydb22SRLUFjCEUplA9V9v+rZvqP0VzmGLP0dMLLxsezYgfLiSeWTslizLg+c47PK4wLqLa1wtrmRR9cCaWZ4TIg87PgLoFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QMyjkQJz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A90C2BCAF;
	Thu, 23 Apr 2026 11:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776942644;
	bh=q/MO0aEEY1J/xinh+nE2w5/ns9zt5bzai2BiTVCHNRk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QMyjkQJzAVrZt5YYbF9d9VV9ejn7clw4Q1M6EFh+4ywWW42HW5fC1Bz31lLH1jW4T
	 4kHkrtWvkCTUnJ6Q2e6Z/HrYGXGCHw9Xt8YtWCYk2Ff1WtgHCrz5SH7SQ9ahFyAR78
	 +a++W+lRZp6DaP77BmybEbbnhjt1qfG3TG/fxQzDi8iJTokjXcpo1jZRw0LaiGRU8S
	 ebJXeCtf9rzY2S5aCCNdJ3f+dWJbYTd+qddQqH234UudNLI+BQTQaf3dLkQO1+8RAk
	 Az3UbNzvaMdb2S3hijjw7UhD8sXaFqpOOJAlO09l4dStJjyvsQCLmQtfGLwYK9BPgO
	 yDsCU7NrNyw2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FC79380CFFD;
	Thu, 23 Apr 2026 11:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] vsock/virtio: fix MSG_ZEROCOPY pinned-pages
 accounting
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177694260605.114344.12041685261933585177.git-patchwork-notify@kernel.org>
Date: Thu, 23 Apr 2026 11:10:06 +0000
References: <20260420132051.217589-1-sgarzare@redhat.com>
In-Reply-To: <20260420132051.217589-1-sgarzare@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, horms@kernel.org,
 kvm@vger.kernel.org, avkrasnov@salutedevices.com, davem@davemloft.net,
 pabeni@redhat.com, kuba@kernel.org, mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 eperezma@redhat.com, xuanzhuo@linux.alibaba.com, stefanha@redhat.com,
 yimingqian591@gmail.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,kernel.org,salutedevices.com,davemloft.net,redhat.com,lists.linux.dev,linux.alibaba.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-280724-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D83DE451204
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 20 Apr 2026 15:20:51 +0200 you wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> virtio_transport_init_zcopy_skb() uses iter->count as the size argument
> for msg_zerocopy_realloc(), which in turn passes it to
> mm_account_pinned_pages() for RLIMIT_MEMLOCK accounting. However, this
> function is called after virtio_transport_fill_skb() has already consumed
> the iterator via __zerocopy_sg_from_iter(), so on the last skb, iter->count
> will be 0, skipping the RLIMIT_MEMLOCK enforcement.
> 
> [...]

Here is the summary with links:
  - [net] vsock/virtio: fix MSG_ZEROCOPY pinned-pages accounting
    https://git.kernel.org/netdev/net/c/1cb36e252211

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



