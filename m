Return-Path: <netdev+bounces-287223-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGUMI0FMA2pq3AEAu9opvQ
	(envelope-from <netdev+bounces-287223-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 17:50:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E04752402C
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 17:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7DC483028D38
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272783C4152;
	Tue, 12 May 2026 15:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HaGFRURu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gx8LZy0A"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016513C3797
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 15:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778600400; cv=none; b=fX8JUz5FFFO2kvmx/00uMv39qmzK7rpL7KB4NbBRSQKtoTM7ncIdex5daZrIQNfXb32V9MZ9+J8TuI36qL9wvk9I3S32OQ7pDFmrnsdTdXpscV+7NOdjwJPs5+P8a4Y96pN/B4nqXljOwUxQAgKja6qh2bDvKM28dYaIm7OWiEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778600400; c=relaxed/simple;
	bh=KglCHTuNm3x37ez9MagfZauxo69r9aH1IwV/+zMyGZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RehJQQBQNdzPNG1FodWkwoZoywwK5xY4XnXf+vUBvLU3THa9pUUaNWlYhLZzDh+X5LK2bU0lwMPo37TfDJE6kE+8NOAY3ULCx2DsW8am/tKHpFPaOGZLf9Unf0wv8JjqEXzihAE+PNzzujtCppYW9zFk/BjDIXRtu2i9ID3VCCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HaGFRURu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gx8LZy0A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778600397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LsdZjZ26kSZ8u0NFCo8P+xxqj1x4mfPz9ccyxXizpko=;
	b=HaGFRURu15nLJFMO1lYQHNUQuPLLZ7nPjaZoWohAFsSGxvbKUlOItQq5zHdY/JhxRtzDRr
	0XudZvAwjMjKjGZQqPCRSTB/DdPH3QYrndxswdT8IE37pyZk3yPpIbHLtI2wr5ljNHzNYQ
	jbcV537sr04hsZKgimRsvnOxaIXa8s8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-VI29M3ZPM0ustSnAR4VB2A-1; Tue, 12 May 2026 11:39:55 -0400
X-MC-Unique: VI29M3ZPM0ustSnAR4VB2A-1
X-Mimecast-MFC-AGG-ID: VI29M3ZPM0ustSnAR4VB2A_1778600395
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48e6af7a9cdso29101445e9.3
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 08:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778600394; x=1779205194; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LsdZjZ26kSZ8u0NFCo8P+xxqj1x4mfPz9ccyxXizpko=;
        b=gx8LZy0AQWXtWli29riSYzatxdUFLb69mWrRWWMVgiUbVeMBTMo67jQDV+8wadk0nQ
         G1EA9RLBmI39XYxQ6ltucZ9QyE9/Lh12WqDWqx0bqNvho7C0wVlUuD0djBgXvRywJZQ1
         VbKVqR+Gl0+Ow8bXEIdKwNrIOLajygTg+r6qNGblYv12YG/KPXNnRHHmfRgT5jPel8AI
         brX9n/sElEaD5n//TVqz2bAxdFUZNfIUM6lRgUa8F7uV3jbYlN00nLIj7KtVgZJuAKCK
         Anm0cj0UuSEIyPNqzb9EMbWiUKMS12qiDRnX+l7p4dvXnSUF80BgFBiXlrhUwxmC7tQz
         e3JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778600394; x=1779205194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LsdZjZ26kSZ8u0NFCo8P+xxqj1x4mfPz9ccyxXizpko=;
        b=QbX2ZRTwQEVljnFaflI6x4gpyIxwnvSDJQd1MxZBoP1qUFj9wQtId0JeIa3drZGt0b
         5k6TsvkpWioCiKUYAXuvj2S6fZzK3kKUVr/FbNW3oy5uiZo6d5aCycw0kGvJxoVi4oyt
         415T4Sm2AuM0KSmnQyN3fiMGXpp3tjF15Dfu2+ib7UK2F/ecocqBKnxrTYNOKTqa4/+V
         va7KBLBwuLiId350oZ0rHigz8aRhti1EFl/+/2wCviLkMBWm7ekVB3IOVbnbx6kJF67E
         VVHke6oTZO8TQOnyZzvCzCeWwfMqT/Onn2xWU0/CZFPK0ChMSUmr0RGHllLwfvB7S/bR
         t93A==
X-Forwarded-Encrypted: i=1; AFNElJ+As6xbWF+wF0ofXaVKDN2j8czXBRgNVKgZXAw4JmOUo3YoD4SBby7VQTroqqjOceRoB8L+ANw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwJuTTF4nYwZ4MFYwNhuta2WYPdb7g6cvQHoow328ecNyuRdv/
	yHWaSV8Ag57i25uu3EV1wQZFgathysa8Aa4fQpCxJpTROV8d8J3iazglWbxy2d/y1H7hqlzLR4V
	S3hbCh0O2fTI4qtI9mF2OT6x7+mar4MnPavp1pj1667pdiG01++2JuDM7vg==
X-Gm-Gg: Acq92OET4xQZKv2VQYPASBUUpOWYstTUkZwTyHQGvD0cOVz+i1Ok5WramRxmBhvkx7W
	2IljkWdxsLcouF02cItk1Ee7gAL9miHePcs4Q5dNFJhpIRTfIzSA6iHnI/opzZ87W6vXIkZojKD
	cK1a+Vx6uxfeyUmJRvFI4K7BJluzojkQEEN1GSxwZQPq6EwL6pGZYRE3pfkgeVYplwkOsn6Qdvd
	e/eV9Flkz1VUzWGg2G1sBmXkjDXJ53a+8sLy06VrwBLZ0Nr6/I9ZYFT7bPm4HM0eNNczPcHZzeL
	gtiC+IYjH9fFWjXK9fwBkMm1bxqrPmdTVcgMiMdtEWYJbXYzK+FUy2wlR7AVtvkD5hVq7+t/P/Q
	GXnCICXgpbz64JnzU+pahseLDTiKOLqm+cO1xAmMxehdaehcw5PDwWXB8rM8iOZ7UKi3mVd7eyA
	==
X-Received: by 2002:a05:600c:621a:b0:48d:35e:849d with SMTP id 5b1f17b1804b1-48e8fe4dca6mr55140355e9.6.1778600394437;
        Tue, 12 May 2026 08:39:54 -0700 (PDT)
X-Received: by 2002:a05:600c:621a:b0:48d:35e:849d with SMTP id 5b1f17b1804b1-48e8fe4dca6mr55139695e9.6.1778600393794;
        Tue, 12 May 2026 08:39:53 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f41a8b1sm31709705e9.7.2026.05.12.08.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 08:39:53 -0700 (PDT)
Date: Tue, 12 May 2026 17:39:48 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Polina Vishneva <polina.vishneva@virtuozzo.com>
Cc: "den@openvz.org" <den@openvz.org>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, "stefanha@redhat.com" <stefanha@redhat.com>, 
	"eperezma@redhat.com" <eperezma@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "jasowang@redhat.com" <jasowang@redhat.com>
Subject: Re: [PATCH] vhost/vsock: Refuse the connection immediately when
 guest isn't ready
Message-ID: <agM8cxqUCJNjBDlm@sgarzare-redhat>
References: <20260511145610.413210-1-polina.vishneva@virtuozzo.com>
 <agH3WvJtAsQ_5zx4@sgarzare-redhat>
 <962b26d2d1daa9411fb71efab6af2c75d1c5f0d0.camel@virtuozzo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <962b26d2d1daa9411fb71efab6af2c75d1c5f0d0.camel@virtuozzo.com>
X-Rspamd-Queue-Id: 8E04752402C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287223-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[virtuozzo.com:email,openvz.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 02:32:14PM +0000, Polina Vishneva wrote:
>On Mon, 2026-05-11 at 17:56 +0200, Stefano Garzarella wrote:
>> On Mon, May 11, 2026 at 04:56:10PM +0200, Polina Vishneva wrote:
>> > From: "Denis V. Lunev" <den@openvz.org>
>> >
>> > When the host initiates an AF_VSOCK connect() to a guest that has not
>> > yet loaded the virtio-vsock transport (i.e. still booting), the caller
>> > blocks for VSOCK_DEFAULT_CONNECT_TIMEOUT (2 seconds), because
>> > vhost_transport_do_send_pkt() silently exits when
>> > vhost_vq_get_backend(vq) returns NULL.
>>
>> Can SO_VM_SOCKETS_CONNECT_TIMEOUT helps on this?
>
>It can, but it might be difficult to find a correct timeout.
>
>And, generally, there's no way to distinguish "the guest hasn't yet initialized
>the vq" from "the guest is up and running, but didn't reply to connect() in
>time". That's exactly what this patch is attempting to fix.

Okay, so please mention this in the commit message, I mean why 
SO_VM_SOCKETS_CONNECT_TIMEOUT can't really help.

>
>>
>> >
>> > If the guest doesn't start listening within this timeout, connect()
>> > returns ETIMEDOUT.
>> >
>> > This delay is usually pointless and it doesn't well align with our

I still don't understand why this is pointless. If an application wants 
to wait while sleeping, it can simply increase the timeout long enough 
to wait for the VM to start up and use a single `connect()` call, 
instead of continuing to try and wasting CPU cycles unnecessarily.

Hmm, or maybe not, because the driver will definitely be initialized 
before the application that wants to listen on that port, so it will 
respond that no one is listening, and the `connect()` call will fail 
with an `ECONNRESET` error in any case. Right?

If it is the case, is the following line in the commit description 
correct?

     If the guest doesn't start listening within this timeout, connect()
     returns ETIMEDOUT.

I mean, also if the application starts to listen within the timeout, I 
think the connect() will fail in any case as I pointed out above (this 
should be another point in favour of this change)


BTW, I think we should explain this more clearly both here and briefly 
in the code as well.

>> > behavior at other initialization stages: for example, if a connection is
>> > attempted when the guest driver is already loaded, but when nothing is
>> > listening yet, it returns ECONNRESET immediately without any wait.
>> >
>> > Fix this by checking the RX virtqueue backend in
>> > vhost_transport_send_pkt() before queuing. If the backend is NULL,
>> > return -ECONNREFUSED immediately.
>> >
>> > Signed-off-by: Denis V. Lunev <den@openvz.org>
>> > Co-developed-by: Polina Vishneva <polina.vishneva@virtuozzo.com>
>> > Signed-off-by: Polina Vishneva <polina.vishneva@virtuozzo.com>
>> > ---
>> > drivers/vhost/vsock.c | 10 ++++++++++
>> > 1 file changed, 10 insertions(+)
>> >
>> > diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>> > index 1d8ec6bed53e..a3f218292c3a 100644
>> > --- a/drivers/vhost/vsock.c
>> > +++ b/drivers/vhost/vsock.c
>> > @@ -302,6 +302,16 @@ vhost_transport_send_pkt(struct sk_buff *skb, struct net *net)
>> > 		return -ENODEV;
>> > 	}
>> >
>> > +	/* Fast-fail if the guest hasn't enabled the RX vq yet. Reading
>> > +	 * private_data without vq->mutex is deliberate: even if the backend becomes
>> > +	 * NULL right after that check, do_send_pkt() checks it under the mutex.
>> > +	 */
>> > +	if (!data_race(READ_ONCE(vsock->vqs[VSOCK_VQ_RX].private_data)))
>>
>> Why not using vhost_vq_get_backend() ?
>
>Because it locks the mutex, which is slow and unacceptable in this hot 
>path.

ehm, sorry, which mutex are you talking about?

I see just a comment about the mutex to be acquired by the caller, but I 
don't see any lock there.

>
>>
>> Also is READ_ONCE() okay without WRITE_ONCE() where it is set ?
>
>It's racy, but as described here in the comment and in the commit message,
>any possible race outcome is covered by the subsequent checks.

Okay, so what is the point to call READ_ONCE()?

>
>> > {
>> > +		rcu_read_unlock();
>> > +		kfree_skb(skb);
>> > +		return -ECONNREFUSED;
>>
>> This is a generic send_pkt, is it okay to return ECONNREFUSED in any
>> case?
>
>EHOSTUNREACH would probably be better.
>All the current send_pkt functions only return ENODEV, but it has different
>semantics: they mean that the local device isn't yet ready, while there we're
>dealing with the opposite end not being ready.

In the AF_VSOCK prespective, I see ENODEV like the transport is not 
ready, so I think it can eventually fit here too, but also EHOSTUNREACH 
is fine, for sure better than ECONNREFUSED.

Thanks,
Stefano

>
>Best regards, Polina.
>
>>
>> Thanks,
>> Stefano
>>
>> > +	}
>> > +
>> > 	if (virtio_vsock_skb_reply(skb))
>> > 		atomic_inc(&vsock->queued_replies);
>> >
>> >
>> > base-commit: 8ab992f815d6736b5c7a6f5fd7bfe7bc106bb3dc
>> > --
>> > 2.53.0
>> >


