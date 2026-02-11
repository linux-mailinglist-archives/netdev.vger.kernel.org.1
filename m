Return-Path: <netdev+bounces-258337-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOcdD7LLjGnJtAAAu9opvQ
	(envelope-from <netdev+bounces-258337-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 19:34:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B431126E15
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 19:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A0473019183
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 18:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC34734575A;
	Wed, 11 Feb 2026 18:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFUZt3Hh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79983101B2;
	Wed, 11 Feb 2026 18:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770834801; cv=none; b=QfCTt21lLkqJHuFRC/ukFiNxRIK4P5EQdL4EwXs7YfWFoYZmBn9bq/d+LMyV0sr6bEEzfD2D01V+bYo3ZqGJFJGe/worMrYNc2DXA+xirnfEY4F/VcWJMVnQFmSi6hvwWn3vOiz9B0r0FG/NgClYE3IzECj62W3GHRSLyrNYO0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770834801; c=relaxed/simple;
	bh=LsceZQ6wjcYltEfuulOtohaXivLnn1uO1ySdlqMaw8k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=InYhCFmnoTb3ygV5KrSf3znBN+mXR2a89TYFmaiVK3YvnvvsQEIgj2lFDq4SywzuFi5q249vFGjUtzOByuiyKArcabDPTvjzY4q52Cr11R9jgWXkcQWUlQe6eDsK0OLiBMdQFgxqOKn0zxNDTlGUhVrWMCv2EIgEEfPQit8hopg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFUZt3Hh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D37DC4CEF7;
	Wed, 11 Feb 2026 18:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770834801;
	bh=LsceZQ6wjcYltEfuulOtohaXivLnn1uO1ySdlqMaw8k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OFUZt3HhTOdLNqwZcy5m39nZIuGu8wnT6HzcPFruzRxRtrelHhBItvjt6468Kleon
	 Z7qBHNkgWuE9XpVv8fpo8oRmkyhPduWwXPb8drd3YkFZvUnH3O/CdArRam+pju2u60
	 iN/CEj/4uqvzjIdo3de411GWPeuRNMrccCAJMfYXa3avW1zmDyApxeyukVK71orjOK
	 0lTbDSmD19ZaoSUZLc/LvvFmGJoI1XtATL4BcHm8yj1kCx2/Rq4YJHHMxBffx34MJ4
	 DI/060tMbXGoaLe4j+h5U8UmGJx4IGb6TPM3ngBVRjFS/L6PoRBoyxIpNga3UzQ08H
	 /BwaUrRqsJgUA==
Date: Wed, 11 Feb 2026 10:33:19 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Vishwanath Seshagiri <vishs@meta.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang
 <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio
 =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, David Wei
 <dw@davidwei.uk>, Matteo Croce <technoboy85@gmail.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, <netdev@vger.kernel.org>,
 <virtualization@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <kernel-team@meta.com>
Subject: Re: [PATCH v7] virtio_net: add page_pool support for buffer
 allocation
Message-ID: <20260211103319.42e23ef6@kernel.org>
In-Reply-To: <20260210014305.3236342-1-vishs@meta.com>
References: <20260210014305.3236342-1-vishs@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258337-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,linux.alibaba.com,lunn.ch,davemloft.net,google.com,davidwei.uk,gmail.com,linaro.org,vger.kernel.org,lists.linux.dev,meta.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9B431126E15
X-Rspamd-Action: no action

On Mon, 9 Feb 2026 17:43:05 -0800 Vishwanath Seshagiri wrote:
> Use page_pool for RX buffer allocation in mergeable and small buffer
> modes to enable page recycling and avoid repeated page allocator calls.
> skb_mark_for_recycle() enables page reuse in the network stack.

## Form letter - net-next-closed

We have already submitted our pull request with net-next material for v7.0,
and therefore net-next is closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after Feb 23rd.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed


