Return-Path: <netdev+bounces-285357-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LaZL4Cj/Gn2SAAAu9opvQ
	(envelope-from <netdev+bounces-285357-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 16:36:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C17C34EA4CD
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 16:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0B904302B2F6
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 14:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4438402B8B;
	Thu,  7 May 2026 14:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iVeZCQjb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB823FBEDE;
	Thu,  7 May 2026 14:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778164422; cv=none; b=WZuDx9zLJd9/PZpB1WFzxo+ByFd6KTDcSSmbp9aH3wtNDF8deOAsMS3MKQTKrBZ2TDiUpl1S0e7RmAqqGP86pz0LY42M4YxdmvgWWpfLVPmmK1t/TA5Oiue+x1MAvCiW8umKf6ma+zcZ00L7dTXYLD+m4vWaKPmmVFfW9ZffZtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778164422; c=relaxed/simple;
	bh=/t+4zQkWn+b1kcYj0Bb28t9/uAuXIPLVUIWHdyAexWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z2/ubBGFKcMVraImtiC5fo12gMq4bvxBdxIpTe625wBDhER3OhrDBKt8UvFz8axjSdMbPLatArYqReN2LpzWzVXglDcpE1w4gWIjBP5kZdjCMbaQ4KnoHRsUm46W8TLJ0ugXeGXZOYbcHzLttK2sw+1R6wX3EMhPi35Ocsq5cyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iVeZCQjb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC739C2BCB2;
	Thu,  7 May 2026 14:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778164422;
	bh=/t+4zQkWn+b1kcYj0Bb28t9/uAuXIPLVUIWHdyAexWQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iVeZCQjbp4+zTNKDZMoScR+tglVXbaMAq1Hlfhxc1a+Bv67yNMqCbwz8SKT1RhE0q
	 robHo62cHFjzq+l2aivUo5E8e8+ExQI2rh+4+CJMaRTs8pueXvBwI/n6Uv0N91Y5lx
	 cjDGnjTa+IkuvaoNy+ubhjScTMg9sj3MSvZMKBSq2ZDP8yt5jSC/x/wMLclZ1nT3Lh
	 X64USyisalBaO7HMFihJk1R2l5SlUHcPymd9ZqgV9huXl1bUoEJS5+3WLP30KKm9jC
	 Mc097tK8lFoHnrIxwa9JrZ4V5KU6dzp4JwZfxbBlAfDAEKgGNBx05TFwtrNxwk58lh
	 ufOvqmaz1KfoQ==
Date: Thu, 7 May 2026 07:33:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eric Dumazet
 <edumazet@google.com>, Arseniy Krasnov <avkrasnov@salutedevices.com>, Bobby
 Eshleman <bobbyeshleman@meta.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, Arseniy Krasnov <AVKrasnov@sberdevices.ru>, Jason
 Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio
 =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, kvm@vger.kernel.org,
 virtualization@lists.linux.dev
Subject: Re: [PATCH net] vsock/virtio: fix potential unbounded skb queue
Message-ID: <20260507073340.0604667d@kernel.org>
In-Reply-To: <afyMCyBvZpzWrLtO@sgarzare-redhat>
References: <20260430122653.554058-1-edumazet@google.com>
	<afn0ZdvZWswBuDMm@sgarzare-redhat>
	<CANn89iLs8DOWJwDpf_ARoMrV+6b2tbhEJ=VVzeC8gCm5dRGaig@mail.gmail.com>
	<afoF_cHfl6ygcupM@sgarzare-redhat>
	<20260506113554-mutt-send-email-mst@kernel.org>
	<afxVH2So9BbZ3Gta@sgarzare-redhat>
	<20260507074113-mutt-send-email-mst@kernel.org>
	<afyMCyBvZpzWrLtO@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C17C34EA4CD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285357-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,google.com,salutedevices.com,meta.com,davemloft.net,kernel.org,vger.kernel.org,gmail.com,sberdevices.ru,linux.alibaba.com,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, 7 May 2026 14:59:13 +0200 Stefano Garzarella wrote:
> >well if you want to support pathological cases such as 1 byte messages
> >that would mean like 100x reduction no?
> 
> Yep, but since this patch is already merged, IMHO that is better than 
> losing data in those pathological cases.

We can revert if you think that the risk of regression is high..
Please LMK soon, we can do it before patch reaches Linus.

