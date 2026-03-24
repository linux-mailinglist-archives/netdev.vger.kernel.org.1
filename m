Return-Path: <netdev+bounces-270978-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBhYFQJpwmlScwQAu9opvQ
	(envelope-from <netdev+bounces-270978-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 11:35:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4ED4306802
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 11:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6E773021E76
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 10:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C8B3E3DB7;
	Tue, 24 Mar 2026 10:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+UDi8bw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A4B3DCD90;
	Tue, 24 Mar 2026 10:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774348220; cv=none; b=WDQ2XnHtEY2WviUkGyPoxrpHaX0clcvURxJhbR75p0AEJ6jgrCgxCs1Bzezo6uyj91XxLTcVFYBXmaHpnSbsIq/n/djCfDPOxiQMKX24r2GIOWeZFGaKCk1jWPgGzqQ+IwS4Y1fDfG4JbduZcnqPtHhSZZWUmaBJnqoG2mJQAWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774348220; c=relaxed/simple;
	bh=LNff/5gU1PcyAnEzd6VAqImqQIt84855LfF1mf7IpNc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jgwxkiGsRevfGucVvHJrheqnktEvQLrESz+9nM9+oX9ZirUFjVoL4sOxn8SXpE5YWHd3BM66tbnsTURlrX1MWNku7S1YYPi1Kx1JiPhXuKC6vyfzL4xXaoUqqbEer5pN3C4hSETI9Fs0PG0WWnLhshHWZFFt5VKHesnWHnMjv4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+UDi8bw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9437C19424;
	Tue, 24 Mar 2026 10:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774348219;
	bh=LNff/5gU1PcyAnEzd6VAqImqQIt84855LfF1mf7IpNc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q+UDi8bwckMdT5EWPEU+QkJMoSBz2oYWpoNcQrK5hXqhqyvi6Qxmb/ml+UUOUfY2v
	 e1Pb+TsUM2RpoOnEdtbOvmcOipuO14Pq4hx6YHAzty5fQ9cJc6tMmJyEIurWtwnGrA
	 bV71lc3uJNKqZvipXNjmUN85lwMkJp3/DEnRUeJD1FxaAAaFlz3789bcgOpvDxkyEC
	 tclZy2PJI5k9+TFmjMknQ9z9FQwBulV38cN9E/Z+h5fwhi8ds8OXc4WTwqARWl1xhw
	 E09BVWTkrdieZmjuplNFCQCYwl9dIZw3pCBWW7PjF7VDYeFVZDwF8rky24Yum2abh0
	 XIfkMZ0tm3ACg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02F533808200;
	Tue, 24 Mar 2026 10:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v11 0/2] virtio-net: fix for VIRTIO_NET_F_GUEST_HDRLEN
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177434820779.609364.1964955018523380063.git-patchwork-notify@kernel.org>
Date: Tue, 24 Mar 2026 10:30:07 +0000
References: <20260320021818.111741-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20260320021818.111741-1-xuanzhuo@linux.alibaba.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 jasowang@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mst@redhat.com,
 eperezma@redhat.com, jiri@resnulli.us, alvaro.karsz@solid-run.com,
 virtualization@lists.linux.dev
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270978-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,redhat.com,lunn.ch,davemloft.net,google.com,kernel.org,resnulli.us,solid-run.com,lists.linux.dev];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
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
X-Rspamd-Queue-Id: A4ED4306802
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 20 Mar 2026 10:18:16 +0800 you wrote:
> v11:
>   1. rename virtio_net_set_hdrlen() to __virtio_net_set_hdrlen(),
>   virtio_net_set_tnl_hdrlen() to __virtio_net_set_tnl_hdrlen(), and add
>   explicitly mention in a comment that such functions must be invoked only after
>   virtio_net_hdr_from_skb()
> 
> v10:
>   1. fix http://lore.kernel.org/all/202603122214.8Anoxrmq-lkp@intel.com
> 
> [...]

Here is the summary with links:
  - [net,v11,1/2] virtio-net: correct hdr_len handling for VIRTIO_NET_F_GUEST_HDRLEN
    https://git.kernel.org/netdev/net/c/38ec410b99a5
  - [net,v11,2/2] virtio-net: correct hdr_len handling for tunnel gso
    https://git.kernel.org/netdev/net/c/6c860dc02a8e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



