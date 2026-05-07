Return-Path: <netdev+bounces-285479-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPM1BmTw/GlmVgAAu9opvQ
	(envelope-from <netdev+bounces-285479-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 22:04:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C65F4EE389
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 22:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68B2D30247D8
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 20:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FE535B644;
	Thu,  7 May 2026 20:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="hXTzLo/P"
X-Original-To: netdev@vger.kernel.org
Received: from mx4.sberdevices.ru (mx4.sberdevices.ru [152.89.196.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A63933032B;
	Thu,  7 May 2026 20:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.89.196.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778184261; cv=none; b=KGHU8hYL5yPfj9exk38jQ48jBbpJhZ3ovBOb21jSiO5/AX5+Ep70zJFNAgC3vMLGK8NLwGgt5kt0YyN8j8XliJrNy0R1aVtifVsi3i+dTSfoHeIcqa8uvoqJ/v1SgSqsQaJkkCtnsMaY2aAh3pDdpfLeawaLDRkxcwkR4Q/XqPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778184261; c=relaxed/simple;
	bh=x4vxn5CsbkLp6acVGZz+ODOaft347/jl8nkj0kKF5Vs=;
	h=Message-ID:Date:MIME-Version:In-Reply-To:From:Subject:To:CC:
	 Content-Type; b=YXz0ub0zJii3UnpPvmaNPgHwdsLDEexzPlielpmbCB1EyrZ2F3iaOEhBvJjEBvT7/vtB23NZS1+ILZnZQRv311qNuHRZ5tOBbSmxaBwMRYdYUWKQr7/e0LmxsZ80mO/UV/dD2bgm3mN9RyPT3tMHAFZBS8L2SARrG5kFg5FpKUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=hXTzLo/P; arc=none smtp.client-ip=152.89.196.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-antispam-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx4.sberdevices.ru (Postfix) with ESMTP id B9BC240003;
	Thu,  7 May 2026 23:04:07 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx4.sberdevices.ru B9BC240003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=post; t=1778184247;
	bh=YgPmkTjxoBBbEZCWI8Tkia3A3s5RoljjiPpWZm+RT/g=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type:From;
	b=hXTzLo/Pzoe2bnKFFKGax6yUoWW7R+YHtHBl703p6DNdu6HyJXvJzSjZiPIu4bpbE
	 CbIjnNyRAkB299e7NgWGER6/ckr6PoBv9BTCZHeFSGt69HBYatd/QBwzMmboyAEjDO
	 WmE9aK9+cGQ0+UWJSnZNhbHpsnmh6EJzt1gUjMXhLz7W4S6RGBqlvIpa3avUiy1k5S
	 VdV4GTktAqJz1pYufLoRTSNwr3yAP+Lpz4siIx+rc9rc18lOpPxzTOWW+mQYZMDF1B
	 tNhvhSsj2S6jQYoiKAdCFTIoCWa+pxbSbU90ymKaASnn7R9wron3Bee4xC792sFA3Z
	 8N4l9PZi4dQiw==
Received: from smtp.sberdevices.ru (p-exch-cas-a-m1.sberdevices.ru [172.24.201.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "sberdevices.ru", Issuer "R12" (not verified))
	by mx4.sberdevices.ru (Postfix) with ESMTPS;
	Thu,  7 May 2026 23:04:07 +0300 (MSK)
Message-ID: <a7b95294-3aa6-4bca-9eab-a4bcd0202ae2@salutedevices.com>
Date: Thu, 7 May 2026 23:03:57 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: ru
In-Reply-To: <afnXIGtswspSEk8x@sgarzare-redhat>
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
Subject: Re: [PATCH] vsock/virtio: fix vsockmon info leak in non-linear tap,
 copy
To: Paolo Abeni <pabeni@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Michael S.
 Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, Yiqi Sun <sunyiqixm@gmail.com>,
	<kvm@vger.kernel.org>, <virtualization@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-exch-cas-s-m1.sberdevices.ru (172.16.210.2) To
 p-exch-cas-a-m1.sberdevices.ru (172.24.201.216)
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Info: LuaCore: 104 0.3.104 557b3c2486a74077a103cf2acd83f2ecf4c95118, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;salutedevices.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 202959 [May 07 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.22
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2026/05/07 18:14:00 #28511915
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-KATA-Status: Not Scanned
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 5
X-Rspamd-Queue-Id: 6C65F4EE389
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[salutedevices.com,quarantine];
	R_DKIM_ALLOW(-0.20)[salutedevices.com:s=post];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[salutedevices.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285479-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,linux.alibaba.com,gmail.com,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avkrasnov@salutedevices.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

>CCing Arseniy and Bobby.

Thanks!

>
>On Tue, May 05, 2026 at 12:26:21PM +0200, Paolo Abeni wrote:
>>On 4/30/26 9:11 AM, Yiqi Sun wrote:
>>> vsockmon mirrors packets through virtio_transport_build_skb(), which
>>> builds a new skb and copies the payload into it. For non-linear skbs,
>>> this goes through virtio_transport_copy_nonlinear_skb().
>>>
>>> Helper manually initializes a iov_iter, but leaves iov_iter.count unset.
>>> As a result, skb_copy_datagram_iter() sees zero writable bytes
>>> in the destination iterator and copies no payload data.
>>>
>>> This becomes an info leak because virtio_transport_build_skb() has
>>> already reserved payload_len bytes in the new skb with skb_put(). The
>>> skb is then returned to the tap path with that payload area still
>>> uninitialized, so userspace reading from a vsockmon device can observe
>>> heap contents and potentially kernel address.
>>>
>>> Fix it by initializing iov_iter.count to the number of bytes to copy.
>>>
>>> Fixes: 4b0bf10eb077 ("vsock/virtio: non-linear skb handling for tap")
>>> Signed-off-by: Yiqi Sun <sunyiqixm@gmail.com>
>>> ---
>>>  net/vmw_vsock/virtio_transport_common.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>>> index 416d533f493d..6b26ee57ccab 100644
>>> --- a/net/vmw_vsock/virtio_transport_common.c
>>> +++ b/net/vmw_vsock/virtio_transport_common.c
>>> @@ -152,7 +152,7 @@ static void virtio_transport_copy_nonlinear_skb(const struct sk_buff *skb,
>>>  	iov_iter.nr_segs = 1;
>>>
>>>  	to_copy = min_t(size_t, len, skb->len);
>>> -
>>> +	iov_iter.count = to_copy;
>>>  	skb_copy_datagram_iter(skb, VIRTIO_VSOCK_SKB_CB(skb)->offset,
>>>  			       &iov_iter, to_copy);
>>
>>@Stefano, @Stefan, the patch LGTM, but sashiko pointed out to a
>>pre-existing issue you should probably want to address:
>>
>>>  	to_copy = min_t(size_t, len, skb->len);
>>Does this length calculation account for the offset when a packet is
>>split across multiple transmissions?
>>If a packet is requeued, VIRTIO_VSOCK_SKB_CB(skb)->offset is increased,
>>but to_copy still evaluates to the full length of the skb.
>
>Yep, I just checked and vhost-vsock is the only place where we call 
>virtio_transport_deliver_tap_pkt() wiht an offset != 0, but I agree that 
>we should also fix it.

Yes, looks like the only place where offset could be non zero is 'vhost_transport_do_send_pkt()'.
And we set valid length in header every attempt to send it:

                /* Set the correct length in the header */
                hdr->len = cpu_to_le32(payload_len);

In all other places we call 'virtio_transport_deliver_tap_pkt()' with offset == 0. And thus
skb->len == hdr->len.

So for me looks ok. E.g. len in header is actual data.

>
>Looking better in net/vmw_vsock/virtio_transport_common.c I think this 
>is a regression, indeed we have this comment in 
>virtio_transport_build_skb():
>
>	/* A packet could be split to fit the RX buffer, so we can retrieve
>	 * the payload length from the header and the buffer pointer taking
>	 * care of the offset in the original packet.
>	 */
>	pkt_hdr = virtio_vsock_hdr(pkt);
>
>Before commit 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with 
>sk_buff") we read the payload lenght from the header that is always set 
>to the right value before delivering the packet to the tap.
>
> From that commit, we don't to consider the offset anymore since we 
>started to use `len` from the skb, so IMO we should go back to what we 
>did before it, I mean:
>
>	payload_len = le32_to_cpu(pkt->hdr.len);
>
>@Bobby do you remember why we did that change? Or if you see any issue 
>going back to what we did initially?
>
>
>Also IMO we should avoid to set all the iov_iter fields by hand and 
>start to use iov_iter_kvec(). Plus, we can just use 
>skb_copy_datagram_iter() in any case, like we already do in vhost-vsock, 
>since it already handles linear vs non linear.
>
>At the end I mean something like this:
>
>@@ -171,7 +150,7 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
>  	 * care of the offset in the original packet.
>  	 */
>  	pkt_hdr = virtio_vsock_hdr(pkt);
>-	payload_len = pkt->len;
>+	payload_len = le32_to_cpu(pkt_hdr->len);
>
>  	skb = alloc_skb(sizeof(*hdr) + sizeof(*pkt_hdr) + payload_len,
>  			GFP_ATOMIC);
>@@ -214,13 +193,17 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
>  	skb_put_data(skb, pkt_hdr, sizeof(*pkt_hdr));
>
>  	if (payload_len) {
>-		if (skb_is_nonlinear(pkt)) {
>-			void *data = skb_put(skb, payload_len);
>+		struct iov_iter iov_iter;
>+		struct kvec kvec;
>+		void *data = skb_put(skb, payload_len);
>
>-			virtio_transport_copy_nonlinear_skb(pkt, data, payload_len);
>-		} else {
>-			skb_put_data(skb, pkt->data, payload_len);
>-		}
>+		kvec.iov_base = data;
>+		kvec.iov_len = payload_len;
>+		iov_iter_kvec(&iov_iter, READ, &kvec, 1, payload_len);
>+
>+		skb_copy_datagram_iter(pkt,
>+				       VIRTIO_VSOCK_SKB_CB(pkt)->offset,
>+				       &iov_iter, payload_len);
>  	}
>
>  	return skb;
>
>And removing virtio_transport_copy_nonlinear_skb().

Yes, this looks shorter and better.

>
>If you agree, I can send a proper series with these changes that should 
>fix the issue reported by Yiqi Sun introduced by commit 4b0bf10eb077 
>("vsock/virtio: non-linear skb handling for tap") and the issue 
>introduced by commit 71dc9ec9ac7d ("virtio/vsock: replace 
>virtio_vsock_pkt with sk_buff").
>
>Thanks,
>Stefano

Thanks

