Return-Path: <netdev+bounces-299189-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NUcEM85+LmoMxwQAu9opvQ
	(envelope-from <netdev+bounces-299189-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 12:13:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C4E680D27
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 12:13:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=keN1i+Xz;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299189-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299189-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8D46300C5BC
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 10:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BACC32BF52;
	Sun, 14 Jun 2026 10:13:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB73732C8B
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 10:13:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781432011; cv=none; b=XxZMT0eGRcso/2OcYWG8DFLQD9KmEu3ad2F7AkxdN14kBNywziUTZfPGwaNJ24AVuX02Er6FAgeBWG4WqWQmHJokogUs2kEOhAmp1qkvHFjNb17kFcZFtusX8dDcbiZnhI5x1EaGprKTxofv+zRggpWOcnX2KXKDq1B63StTt+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781432011; c=relaxed/simple;
	bh=V8ILNRycnctlx/yOK6n8nBlj8d32lWGWZ4pfWzD5iFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XBIaf5UHgwaY02hkQPLAdrlh39qQB5VwW22PTp/SJg3RFlSN/wWv8kgSCmstIoTdapq4fxt7GlZC4pkNFkvsNjedxqfqvtdez17vuZvAIeYhYFO11Krxe5cl/tkiGzXSiC6xgU1dT1mH3r9k9etIlBQ833lrqnb0Ey0PfENOKSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=keN1i+Xz; arc=none smtp.client-ip=95.215.58.171
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781431997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JqdQnygkXzMaJ6mt2m2i9i/0wK8Xf9zkeWFs7G9YnSw=;
	b=keN1i+XzPhw3q+UVIxflyveBC6Pq8TVXYfrfwfsMc9rSNLicLDzplzy2EbhwdIX6vCvsTl
	rUEhj2+St3Wbsw7jDNB8QUWWLLp5MdCOcjxzaF5nvALqzXQHeiJbO1MgTdXUWTYma6qEIr
	/fQJ2Y1zXfi9D3wI1RxEfpveL4EN+mY=
From: Menglong Dong <menglong.dong@linux.dev>
To: menglong8.dong@gmail.com, Jakub Kicinski <kuba@kernel.org>
Cc: jasowang@redhat.com, mst@redhat.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com, sdf@fomichev.me, horms@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, bjorn@kernel.org, kerneljasonxing@gmail.com,
 netdev@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] net: busy-poll: introduce sk_tx_busy_loop()
Date: Sun, 14 Jun 2026 18:12:46 +0800
Message-ID: <TYn10tJ2SIGF1pAhF26DRQ@linux.dev>
In-Reply-To: <20260613112113.55d9313f@kernel.org>
References:
 <20260611071242.2485058-1-dongml2@chinatelecom.cn>
 <20260611071242.2485058-2-dongml2@chinatelecom.cn>
 <20260613112113.55d9313f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTE_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299189-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FORGED_SENDER(0.00)[menglong.dong@linux.dev,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_RECIPIENTS(0.00)[m:menglong8.dong@gmail.com,m:kuba@kernel.org,m:jasowang@redhat.com,m:mst@redhat.com,m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:magnus.karlsson@intel.com,m:maciej.fijalkowski@intel.com,m:sdf@fomichev.me,m:horms@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:bjorn@kernel.org,m:kerneljasonxing@gmail.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:menglong8dong@gmail.com,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[menglong.dong@linux.dev,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[redhat.com,linux.alibaba.com,lunn.ch,davemloft.net,google.com,intel.com,fomichev.me,kernel.org,iogearbox.net,gmail.com,vger.kernel.org,lists.linux.dev];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,linux.dev:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 22C4E680D27

On 2026/6/14 02:21, Jakub Kicinski wrote:
> On Thu, 11 Jun 2026 15:12:40 +0800 menglong8.dong@gmail.com wrote:
> > For now, we use sk_busy_loop() for both rx and tx path. The sk_busy_loop()
> > will call napi_busy_loop() for the specified napi_id. However, some
> > nic drivers have tx napi, such as virtio-net. In this case, sk_busy_loop()
> > doesn't work, as it can only schedule the NAPI for the rx queue.
> > 
> > Therefore, introduce sk_tx_busy_loop() for the nic drivers that support tx
> > napi, which will schedule the tx napi if available.
> 
> First, I thought the only difference with Tx NAPI is that it can't be
> busy polled. So if you want to poll an instance don't register it as 
> a Tx one instead of adding all this "tx polling" stuff in the core?

I see. Register the tx NAPI with netif_napi_add_config() allow us
busy poll it. But we still have two NAPI instance: rx NAPI and tx NAPI.
sk_busy_loop() can only busy poll on one of them.

Before AF_XDP, we don't have the need to send packet via tx NAPI, which
means that we don't need to busy poll it.

I analyst some nic drivers on the implement of AF_XDP. Some of them
will check xsk tx ring of current queue and send the data in it in the
rx NAPI, such as mlx5. Some of them will allocate a extra "rxtx" NAPI
for the AF_XDP zero-copy queue, which will poll both the data receiving
and sending.

In the case about, they will do the data sending and receiving for the
AF_XDP in a single NAPI instance.

However, some driver receiving the data in rx NAPI and send data in
tx NAPI for AF_XDP. In this case, we can't use sk_busy_loop() for both
rx path and tx path, as we need to wake different NAPI instance.

> 
> Second, can this problem happen for any other NIC or is it purely 
> an artifact of virtio's delayed Tx completion handling?

According to my analysis, only virtio-net and ICSSG driver have
split NAPI for AF_XDP. I don't have a ICSSG nic, but the codex tell
me that it does have the same problem.

I'm not sure if it is a good idea to introduce the sk_tx_busy_loop().
Maybe we can modify the driver instead by using the same NAPI
for both data sending and receiving, just like others do. The
advantage of introduce sk_tx_busy_loop() is that we can split the
data sending and receiving, which maybe more efficient.

> 
> Third, this series does not apply.

Ah, I'll rebase this series if a V2 is acceptable.

Thanks!
Menglong Dong

> 
> 





