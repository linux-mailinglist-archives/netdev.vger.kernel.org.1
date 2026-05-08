Return-Path: <netdev+bounces-285748-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LmhIf21/WmAhwAAu9opvQ
	(envelope-from <netdev+bounces-285748-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 12:07:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F123E4F4C39
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 12:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2907A30AC217
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 10:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8413D0901;
	Fri,  8 May 2026 10:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BZR1lDTc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="alZeZPqK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3FC21ABBB
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 10:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778234526; cv=none; b=q6tNDkK0VY9CQKDPvwdOUEcDmJHhiCwdCREKYhFP8HgKI5JEx62tzACTvyKpE1bL7xSHSNDREzPqSVPdbjqFaDiYi8jPo8fgviIFV7JIpmsleFk4ZOMD5GybSnlmKlwgS5eAmBZtiWCFxlLlAvf5Jz+b+u1veGud3hnqOwwmtKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778234526; c=relaxed/simple;
	bh=fmD3Ke/CvF5HQCYW6erHAKf4D6r4v6UWQtiVU6LwrNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gvVnXcjYwuxnaDhlykPuTm4HFtB3Rb61DMQa6YxDj6CyWsecHR0aJXOC16r8LH3QlvuwwB6dJA6taesxfWJGbEW1JsDUikb0UB1jWhQm1GX7opcpQDgRsgNWmUjbUV50pH1RCPftQEo84vWVXp0cmBzpPwBQLqHxyLPiXDC20xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BZR1lDTc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=alZeZPqK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778234521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=crvssa469klhyca6q9oUB28wHxBWNy751Rl0wTACG7Q=;
	b=BZR1lDTczsgDTYI3mXdms7CuKQ0hecZjoJAkJZN18KdSrHyAW+v0bdyh8Qp+YWQx9xhxho
	OSCYd3yQFh3UHYqD/VkAkLRr8VvBSvy/bfgO6fORkFNyF/c6PaCe8MjqkW0wvGba/GPOgU
	bPfK6vaXbl1XCbkrz8H3Av3VlUsMdNo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-ylg-beDwMams87KlBQy4RA-1; Fri, 08 May 2026 06:02:00 -0400
X-MC-Unique: ylg-beDwMams87KlBQy4RA-1
X-Mimecast-MFC-AGG-ID: ylg-beDwMams87KlBQy4RA_1778234519
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48e5dfa8ec7so9482795e9.2
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 03:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778234518; x=1778839318; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=crvssa469klhyca6q9oUB28wHxBWNy751Rl0wTACG7Q=;
        b=alZeZPqK7W6vz9EhTDZSxgnw6bPo8wTjCozyuqGStJ+L/nzNAp86CKrVksu/0splpI
         f67g4aQlv/wB6FGCgQ+/xoTWrU1sXNE3A10EbQgzsaLdXRveKucYC1DQ+YMcR+gt2Qzh
         x/RnGhZVkTRHeG9Z0Q7Z3RBgE5zkH1MLIgIIm4wT39RUyDrGffK6RQO+FE/uMu3LjGYV
         f93x2GLIy5lND67xQ9RVefAGrEndtOdFnftGQuPWT6Fi77SjlfuRrX/3F8hUqWlWqBpN
         vkRZGMASANKuZkzsQXwKeCRDqLbJyLFxdxOS8E6qlYgoc/h5q7fsI7Shu8AKQp5S/9KK
         iXcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778234518; x=1778839318;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=crvssa469klhyca6q9oUB28wHxBWNy751Rl0wTACG7Q=;
        b=XDlZrWNXa+Mv3ANw8pVFErErFYvcQ8zZbJhXGciC7iOGXEIbLp6Gn+tjMlXZ7aINuJ
         a7262y9gLHPw0pqibk7RoAe6R5pB+JRxlIS6pYW19n95sM4qiiZCu1L0bS3CrM2ZyTp7
         ZsB2Iwqtksb5y/QT7eDkZoTSYRmYb6L4x7fsmZcaFdrmXA1MV4/2u7zLsdnX2NECuUq4
         ZOwSbdB0LW73kCaGmbfTSngsmSrk5YL5WjGwpeDoIMEzf9EHHcAZVAsu5f7rBA2OJ+c6
         9VzmUPKvftwb4h0wden4g04zH8Gsiifuah5CXbGN956s2soeQmcppW2EX/BeEMnGgYdH
         uy8Q==
X-Gm-Message-State: AOJu0Yy86fDeE/Zhxft8lnHm5HYVlRvZavM1AvpWLa0PJrSrPPOYmVUN
	SLSErAMDXDXJOSJsyyoJqMmulw/YumoXGpRCpnUTElbqvp0ihnHLEso//8n9mMXxZnwWP87mvhQ
	22OWaW93N+yDwtaWE5iURJ13WsJ99B09whXFAW6Yx7+h1lrw94aVOZjvhdz3VngOvjA==
X-Gm-Gg: AeBDievX2ou7mghuBNSgaskmrsy/ifdwgLobIT6N1ULxKtu0yzxLE6SResO1V8avvKD
	UuKP6akgPyX4emNLHZqLpC2SLHMCJQfnqHlbRQSdha46TSG1hT/sbltwU00Tb7lD98CVtsrPy5h
	Wg0o4v8J+/aWuMEbxjHo2L0tfZqdmsmXQ5pdOPeAgv4ubvF19+IxMJ4vh8bbV1j5nWXYLi7Gagu
	tjlMrNsK30b/N0qJ8+Cm1WS3k2PspiPlkJrFN2ELXWHmFIdLuUg7wiCN9hOn0F1zw9A5NO/OzmG
	MMjMtRG/lSZMUOQ3HmkoZnGrb0nZqV+Hzm/gSYVCxZbY7kYmMRFC8HlOsO3/TmIrBXBUp0/CQnv
	HqnNkEBIUv5jX9hWg+a7pDDxIJVgRXwR53CIN3baxtgAii2o+ZbG0ujTGRZHQCBm5jrYOklyrpw
	==
X-Received: by 2002:a05:600c:3548:b0:485:3abe:ab86 with SMTP id 5b1f17b1804b1-48e51e0a6a2mr175787985e9.4.1778234518386;
        Fri, 08 May 2026 03:01:58 -0700 (PDT)
X-Received: by 2002:a05:600c:3548:b0:485:3abe:ab86 with SMTP id 5b1f17b1804b1-48e51e0a6a2mr175787265e9.4.1778234517709;
        Fri, 08 May 2026 03:01:57 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-2.retail.telecomitalia.it. [87.11.6.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6428d72asm16331785e9.0.2026.05.08.03.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 03:01:56 -0700 (PDT)
Date: Fri, 8 May 2026 12:01:50 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, 
	"David S. Miller" <davem@davemloft.net>, Jason Wang <jasowang@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, kvm@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: Re: [PATCH net] vsock/virtio: fix skb overhead accounting to
 preserve full buf_alloc
Message-ID: <af2y2Fyp7H-om-ur@sgarzare-redhat>
References: <20260508092330.69690-1-sgarzare@redhat.com>
 <20260508055125-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260508055125-mutt-send-email-mst@kernel.org>
X-Rspamd-Queue-Id: F123E4F4C39
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285748-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, May 08, 2026 at 05:53:07AM -0400, Michael S. Tsirkin wrote:
>On Fri, May 08, 2026 at 11:23:30AM +0200, Stefano Garzarella wrote:
>> From: Stefano Garzarella <sgarzare@redhat.com>
>>
>> After commit 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb
>> queue"), virtio_transport_inc_rx_pkt() subtracts per-skb overhead from
>> buf_alloc when checking whether a new packet fits. This reduces the
>> effective receive buffer below what the user configured via
>> SO_VM_SOCKETS_BUFFER_SIZE, causing legitimate data packets to be
>> silently dropped and applications that rely on the full buffer size
>> to deadlock.
>>
>> Also, the reduced space is not communicated to the remote peer, so
>> its credit calculation accounts more credit than the receiver will
>> actually accept, causing data loss (there is no retransmission).
>>
>> This also causes failures in tools/testing/vsock/vsock_test.c.
>> Test 18 sometimes fails, while test 22 always fails in this way:
>>     18 - SOCK_STREAM MSG_ZEROCOPY...hash mismatch
>>
>>     22 - SOCK_STREAM virtio credit update + SO_RCVLOWAT...send failed:
>>     Resource temporarily unavailable
>>
>> Fix this by introducing virtio_transport_rx_buf_size() to calculate the
>> size of the RX buffer based on the overhead. Using it in the acceptance
>> check, the advertised buf_alloc, and the credit update decision.
>> Use buf_alloc * 2 as total budget (payload + overhead), similar to how
>> SO_RCVBUF is doubled to reserve space for sk_buff metadata.
>> The function returns buf_alloc as long as overhead fits within the
>> reservation, then gradually reduces toward 0 as overhead exceeds
>> buf_alloc (e.g. under small-packet flooding), informing the peer to
>> slow down.
>>
>> Fixes: 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue")
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>
>
>unfortunately, this is a bit of a spec violation and there is no guarantee
>it helps.

Loosing data like we are doing in 059b7dbd20a6 is even worse IMHO.

>
>a spec violation because the spec says:
>Only payload bytes are counted and header bytes are not
>included
>
>and the implication is that a side can not reduce its own buf_alloc.
>
>no guarantee because the other side is not required to process your
>packets, so it might not see your buf alloc reduction.
>
>as designed in the current spec, you can only increase your buf alloc,
>not decrease it.

We never enforced this, currently an user can reduce it by 
SO_VM_SOCKETS_BUFFER_SIZE and we haven't blocked it since virtio-vsock 
was introduced, should we update the spec?

>
>what can be done:
>- more efficient storage for small packets (poc i posted)
>- reduce buf alloc ahead of the time

That's basically what I'm doing here: I'm using twice the size of 
`buf_alloc` (just like `SO_RCVBUF` does for other socket types) and 
telling the other peer just `buf_alloc`.

But then, somehow, we have to let the other person know that we're 
running out of space. With this patch that only happens when the other 
peer isn't behaving properly, sending so many small packets that the 
overhead exceeds `buf_alloc`.

Stefano

>
>> ---
>>  net/vmw_vsock/virtio_transport_common.c | 31 +++++++++++++++++++++----
>>  1 file changed, 27 insertions(+), 4 deletions(-)
>>
>> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>> index 9b8014516f4f..94a4beb8fd61 100644
>> --- a/net/vmw_vsock/virtio_transport_common.c
>> +++ b/net/vmw_vsock/virtio_transport_common.c
>> @@ -444,12 +444,32 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>>  	return ret;
>>  }
>>
>> +/* vvs->rx_lock held by the caller */
>> +static u32 virtio_transport_rx_buf_size(struct virtio_vsock_sock *vvs)
>> +{
>> +	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
>> +	/* Use buf_alloc * 2 as total budget (payload + overhead), similar to
>> +	 * how SO_RCVBUF is doubled to reserve space for sk_buff metadata.
>> +	 */
>> +	u64 total_budget = (u64)vvs->buf_alloc * 2;
>> +
>> +	/* Overhead within buf_alloc: full buf_alloc available for payload */
>> +	if (skb_overhead < vvs->buf_alloc)
>> +		return vvs->buf_alloc;
>> +
>> +	/* Overhead exceeded buf_alloc: gradually reduce to bound skb queue */
>> +	if (skb_overhead < total_budget)
>> +		return total_budget - skb_overhead;
>> +
>> +	return 0;
>> +}
>> +
>>  static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
>>  					u32 len)
>>  {
>> -	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
>> +	u32 rx_buf_size = virtio_transport_rx_buf_size(vvs);
>>
>> -	if (skb_overhead + vvs->buf_used + len > vvs->buf_alloc)
>> +	if (!rx_buf_size || vvs->buf_used + len > rx_buf_size)
>>  		return false;
>>
>>  	vvs->rx_bytes += len;
>> @@ -472,7 +492,7 @@ void virtio_transport_inc_tx_pkt(struct virtio_vsock_sock *vvs, struct sk_buff *
>>  	spin_lock_bh(&vvs->rx_lock);
>>  	vvs->last_fwd_cnt = vvs->fwd_cnt;
>>  	hdr->fwd_cnt = cpu_to_le32(vvs->fwd_cnt);
>> -	hdr->buf_alloc = cpu_to_le32(vvs->buf_alloc);
>> +	hdr->buf_alloc = cpu_to_le32(virtio_transport_rx_buf_size(vvs));
>>  	spin_unlock_bh(&vvs->rx_lock);
>>  }
>>  EXPORT_SYMBOL_GPL(virtio_transport_inc_tx_pkt);
>> @@ -594,6 +614,7 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
>>  	bool low_rx_bytes;
>>  	int err = -EFAULT;
>>  	size_t total = 0;
>> +	u32 rx_buf_size;
>>  	u32 free_space;
>>
>>  	spin_lock_bh(&vvs->rx_lock);
>> @@ -639,7 +660,9 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
>>  	}
>>
>>  	fwd_cnt_delta = vvs->fwd_cnt - vvs->last_fwd_cnt;
>> -	free_space = vvs->buf_alloc - fwd_cnt_delta;
>> +	rx_buf_size = virtio_transport_rx_buf_size(vvs);
>> +	free_space = rx_buf_size > fwd_cnt_delta ?
>> +		     rx_buf_size - fwd_cnt_delta : 0;
>>  	low_rx_bytes = (vvs->rx_bytes <
>>  			sock_rcvlowat(sk_vsock(vsk), 0, INT_MAX));
>>
>> --
>> 2.54.0
>


