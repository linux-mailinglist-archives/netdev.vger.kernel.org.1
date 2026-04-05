Return-Path: <netdev+bounces-275479-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id M2ZyLG+20mn+ZwcAu9opvQ
	(envelope-from <netdev+bounces-275479-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 21:22:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A736E39F5D5
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 21:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 405EB3001FA6
	for <lists+netdev@lfdr.de>; Sun,  5 Apr 2026 19:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3B62F1FE4;
	Sun,  5 Apr 2026 19:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="oJnZ90iu"
X-Original-To: netdev@vger.kernel.org
Received: from mx5.sberdevices.ru (mx5.sberdevices.ru [95.181.183.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD05B2F069D;
	Sun,  5 Apr 2026 19:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.181.183.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775416937; cv=none; b=Zs/qX2d2nPy/9P5JElvS2wKd3bFcnWR0RvMxjYJV46W6qOAJnjuCSBhwnboqJA5eGdqOnxjmXVjevCSnQnriXC1dOmxuqrdfm/9NGooAymhwCUpMbbr1/otZnTwR+v4DkAmhccvFXuTG2rWkCY9WUWsz8m03uRbHnarfwYHMGMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775416937; c=relaxed/simple;
	bh=4FEK7G9FUJ2+gkgHqqFO4PYkr4bpAFXC7gWGdsYRC00=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hL+qrbaww4EWutY3nuetA3Nbm6f94A6XzG4pDAsfDv0fHG541zHqbCpFfO8lT+zPFNyJfvvt/CCz7pAQ885SVFDzsFubkWyxKZUIVHK4LBFrOkq4YcTjxTaxPOQLNqz/PGxgyNa1V0uJarZN12IuIelWXqGD4XLjJwkPZ6Tb0UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=oJnZ90iu; arc=none smtp.client-ip=95.181.183.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-antispam-ksmg-gc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx5.sberdevices.ru (Postfix) with ESMTP id 1904A24000B;
	Sun,  5 Apr 2026 22:22:10 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx5.sberdevices.ru 1904A24000B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=post; t=1775416930;
	bh=6Sq7O88E3GPsooLdbHDQsH6D2/KBDMjazQjjB7hgd+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=oJnZ90iu6tByApjRTo5oYcdLV99i4TCUbO75XEHSeeZ5NlradpeVikvUdOBw1JyqO
	 xIAgbjEUBBuWZoTIpABOq76RYp/XDPUFp1j50fRiGHM/gLhWeS+/aQDObW6v7l8wpd
	 nogXGgAUqymks0PZL60oFtijQD1xChFHoO842751U8Vy2ClgN9o4kleDq4UzkagRtl
	 /vVHL7Vti3YmgxOg+JYAW5f7aDj7HSvw+7d3Axs5/5UkB5l2VRzMQn6UjxHFHdltJ6
	 rt2BpuMiIBCjvcb1jF1r9kLJtgR6yPHGzL0MqqlW6sMz2Tp64CKs4h8asmQVtuPN7h
	 guxhh/i/Pj9Wg==
Received: from smtp.sberdevices.ru (p-exch-cas-a-m1.sberdevices.ru [172.24.201.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "sberdevices.ru", Issuer "R12" (not verified))
	by mx5.sberdevices.ru (Postfix) with ESMTPS;
	Sun,  5 Apr 2026 22:22:09 +0300 (MSK)
Message-ID: <ac71a69c-e45d-4767-b5c0-806708fff388@salutedevices.com>
Date: Sun, 5 Apr 2026 22:22:08 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] vsock/virtio: fix MSG_PEEK ignoring skb offset
 when calculating bytes to copy
Content-Language: ru
To: Luigi Leonardi <leonardi@redhat.com>, Stefan Hajnoczi
	<stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
	<eperezma@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: <kvm@vger.kernel.org>, <virtualization@lists.linux.dev>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260402-fix_peek-v1-0-ad274fcef77b@redhat.com>
 <20260402-fix_peek-v1-1-ad274fcef77b@redhat.com>
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
In-Reply-To: <20260402-fix_peek-v1-1-ad274fcef77b@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-exch-cas-a-m2.sberdevices.ru (172.24.201.210) To
 p-exch-cas-a-m1.sberdevices.ru (172.24.201.216)
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Info: LuaCore: 96 0.3.96 f0df504111d78c4fb91ce829559989c2d1ddd192, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 201980 [Apr 05 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.22
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2026/04/05 16:38:00 #28374316
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-KATA-Status: Not Scanned
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 5
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[salutedevices.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[salutedevices.com:s=post];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-275479-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[salutedevices.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avkrasnov@salutedevices.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[salutedevices.com:dkim,salutedevices.com:email,salutedevices.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A736E39F5D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



02.04.2026 11:18, Luigi Leonardi wrote:
> `virtio_transport_stream_do_peek()` does not account for the skb offset
> when computing the number of bytes to copy.
> 
> This means that, after a partial recv() that advances the offset, a peek
> requesting more bytes than are available in the sk_buff causes
> `skb_copy_datagram_iter()` to go past the valid payload, resulting in a -EFAULT.
> 
> The dequeue path already handles this correctly.
> Apply the same logic to the peek path.
> 
> Fixes: 0df7cd3c13e4 ("vsock/virtio/vhost: read data from non-linear skb")
> Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
> ---
>  net/vmw_vsock/virtio_transport_common.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 8a9fb23c6e853dfea0a24d3787f7d6eb351dd6c6..4b65bfe5d875111f115e0fc4c6727adb66f34830 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -547,9 +547,8 @@ virtio_transport_stream_do_peek(struct vsock_sock *vsk,
>  	skb_queue_walk(&vvs->rx_queue, skb) {
>  		size_t bytes;
>  
> -		bytes = len - total;
> -		if (bytes > skb->len)
> -			bytes = skb->len;
> +		bytes = min_t(size_t, len - total,
> +			      skb->len - VIRTIO_VSOCK_SKB_CB(skb)->offset);
>  
>  		spin_unlock_bh(&vvs->rx_lock);
>  
> 

Acked-by: Arseniy Krasnov <avkrasnov@salutedevices.com>

