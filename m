Return-Path: <netdev+bounces-297002-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tYRYGc/jJ2qR4AIAu9opvQ
	(envelope-from <netdev+bounces-297002-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 11:58:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C010F65EA2B
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 11:58:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=rulkc.org header.s=dkim header.b=KzdqJ7zE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297002-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297002-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=rulkc.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C5CE315C65C
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 09:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354463EFFDF;
	Tue,  9 Jun 2026 09:48:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.rulkc.org (mail.rulkc.org [155.212.184.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4988C3EBF19;
	Tue,  9 Jun 2026 09:48:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780998530; cv=none; b=C/xfT1WrPAg0qAIHi4tfV1oUFfPNKSNWR3P0f7TeYwdaOttw8uPYx4uKr47+iN9zcqZ2kRR15vR9vJ1MwSsle1+59wn6GpnccNEU7nvdt8xZ7C9cTgBw1n6Va/d5DHM3VbeYM8pLm2t8Rv8goLXe6hgoTzsJRl3ebbDNJSJpq0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780998530; c=relaxed/simple;
	bh=QdtnFTqoS1oY2E32jFZfL4GrvAxiwbAg8YbssX9PAPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tPGGql+jI2WxdlPplpdBVo2WLQzKg1HRJpPdx9wDYUgcoBayCuSl6A1bbHtxsRFYn4DC+x1Eg3ZUrSTBZYuPaQbq4hQU4+HbC1RKjxJj8bsBicI7MsjCetJIbyo9S2cXxFQJddrYuQPowqItSz9doh9vfFY/wW9UT21wGKyOdeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rulkc.org; spf=pass smtp.mailfrom=rulkc.org; dkim=pass (2048-bit key) header.d=rulkc.org header.i=@rulkc.org header.b=KzdqJ7zE; arc=none smtp.client-ip=155.212.184.193
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BE8081000E6;
	Tue,  9 Jun 2026 12:48:27 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rulkc.org; s=dkim;
	t=1780998518; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=++Cs2JBZqXYs4iI+cjVHpwGDyqJVzN4jXYl2vkWqga0=;
	b=KzdqJ7zEUO8/inpTW/TPejhvka7GGxtLYV52bori/ctOfyl56y18WgFqJxEBW4qZbGcJdZ
	MQLkWkb5JClzlmGmUf8P5R3Ft2hBmv5i7fiZtiKGffozOoWGndQaF+oaYrwR9VLrFR0hou
	mzqGi2OQk/lUHvRMekJAaVi8fxim/cua4gn5UOVtqt+uQr+rkIElcIcIZEUhuj8++KQVM6
	hfhH5XR81kcJUbxD8VwqRa3bMLtu1NyRvfOuYrsYsbbuUcd7SubPHW2aDoKXVYEA03XAOU
	+xR8PraxG7+fQc1K1ZOiKmSxYkHrYtK/eoPSpJMsXLvsyMUfy2c/WgmSGmhzZA==
Message-ID: <76d3872f-8bd6-4b90-b84d-77e638e50cf6@rulkc.org>
Date: Tue, 9 Jun 2026 12:48:19 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] vsock/virtio: rework MSG_ZEROCOPY flag handling
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Simon Horman <horms@kernel.org>, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, oxffffaa@gmail.com, rulkc@linuxtesting.org
References: <20260605115314.552321-1-avkrasnov@rulkc.org>
 <20260608190820.71785304@kernel.org>
Content-Language: ru
From: Arseniy Krasnov <avkrasnov@rulkc.org>
In-Reply-To: <20260608190820.71785304@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rulkc.org,reject];
	R_DKIM_ALLOW(-0.20)[rulkc.org:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:stefanha@redhat.com,m:sgarzare@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:mst@redhat.com,m:jasowang@redhat.com,m:bobby.eshleman@bytedance.com,m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:horms@kernel.org,m:kvm@vger.kernel.org,m:virtualization@lists.linux-foundation.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:oxffffaa@gmail.com,m:rulkc@linuxtesting.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-297002-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[avkrasnov@rulkc.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,davemloft.net,google.com,bytedance.com,linux.alibaba.com,kernel.org,vger.kernel.org,lists.linux-foundation.org,gmail.com,linuxtesting.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avkrasnov@rulkc.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[rulkc.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,rulkc.org:dkim,rulkc.org:mid,rulkc.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C010F65EA2B

Hi, I'll rebase it on latest net-next

Thanks

On 09/06/2026 05:08, Jakub Kicinski wrote:
> On Fri,  5 Jun 2026 14:53:14 +0300 Arseniy Krasnov wrote:
>> Logically it was based on TCP implementation, so to make further
>> support easier, rewrite it in the TCP way.
> Does not apply:
>
> $ git pw series apply 1106582
> Failed to apply patch:
> Applying: vsock/virtio: rework MSG_ZEROCOPY flag handling
> error: sha1 information is lacking or useless (net/vmw_vsock/virtio_transport_common.c).
> error: could not build fake ancestor
> hint: Use 'git am --show-current-patch=diff' to see the failed patch
> hint: When you have resolved this problem, run "git am --continue".
> hint: If you prefer to skip this patch, run "git am --skip" instead.
> hint: To restore the original branch and stop patching, run "git am --abort".
> hint: Disable this message with "git config set advice.mergeConflict false"
> Patch failed at 0001 vsock/virtio: rework MSG_ZEROCOPY flag handling

