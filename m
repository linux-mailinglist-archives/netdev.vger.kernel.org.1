Return-Path: <netdev+bounces-285757-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOlsHTe9/WmOiQAAu9opvQ
	(envelope-from <netdev+bounces-285757-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 12:38:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F116B4F5184
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 12:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50F8B301BF54
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 10:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FE93CFF70;
	Fri,  8 May 2026 10:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EaaBrRgG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JDgnLGTJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165303C8731
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 10:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778236723; cv=none; b=EvrZv63fPUxJfSIWAPvpDFRwB8p8D930wZFZx50I439PL2CyDhaNqMYWad++4kTGMt1h1VkuTLTV/xZx428pzrdiHrfPIJBVIQjhqDK6C7olH0umC0E7O59VNHv9Sv9ndpp6cgU9x7ym4MlcbY53PBWGargFPFD1NooGQUobo+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778236723; c=relaxed/simple;
	bh=MSTUs5VmMs5E3z7P5tkkJbr9UZZ5t6JPN4eNIlmTVac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RDAw2wbs99XAVpL5mlTo2TaJUCp/1t0eMcj2PxIYsMMBP022jHMxFmqhrWFI8Y80ZLYiZ9hGVqRz8iBALHJrDm5fb7NL/Eh85UjoKDdjQ6oB1oTYzk7wSDOvhKwZjVg2UIeUmg1KdZ2GjHcwEurQBGnCJe2bCwE3C7wwgsxOYD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EaaBrRgG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JDgnLGTJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778236721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K3CQx535Mhn8kkYAr+IKjhOgoYF3I8ZJ28RdhySKLwo=;
	b=EaaBrRgGFkSbLbhyCM0/yfnimkgl3DEecxBUWG99PUsbVi/8RCk0Ye6H6xahjONoyHbIkz
	mxfGH+rkxQ/TxT97VY2kqH8wmi8I6VsF1lrBA5Map4tL3TYDIXos2HO6KvjbPEG8mho4Lj
	EIMNhOYXKzX1RyngILkW+FUHGaq11v8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-5hb_IkcGPMCwsIzDJbUG0A-1; Fri, 08 May 2026 06:38:40 -0400
X-MC-Unique: 5hb_IkcGPMCwsIzDJbUG0A-1
X-Mimecast-MFC-AGG-ID: 5hb_IkcGPMCwsIzDJbUG0A_1778236719
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48e5dfa8ec7so9706225e9.2
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 03:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778236719; x=1778841519; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K3CQx535Mhn8kkYAr+IKjhOgoYF3I8ZJ28RdhySKLwo=;
        b=JDgnLGTJaxCt/gfvRiLK2xY4cTBx/pBgQ9BKpfIO/vn775aQx5E4lw1vLQtASdHoYO
         OuYQX2ppJeP5NIIH32BUdvA9OhbiTHXzcFuqZ/qPjJZVAHhLrBnRk47o6RtBX8zlABAq
         K8l2xcfgoTIIJF5WhqoDSX/WgDcSVBRmdqzZqNc/Ikl+qmOlF7VVxoIcX5FQaN9mMf+e
         urRh77PzQ5Zb3zlRjgMSzMTU7gsBVwfsnqn9mFZ4DGwwD4nW+r6bAtqxfD66Vp6CEuOL
         +9wImHirSQ6wOc0hOrnI9GPTwVwVl7GOKn9vS4K911PCAEJVCxx47K+6UnDcl3oMb9Po
         oG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778236719; x=1778841519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K3CQx535Mhn8kkYAr+IKjhOgoYF3I8ZJ28RdhySKLwo=;
        b=QAVYiy/h8udUByLUbJNG7/Euo2rwnaVlRqnX/TJlhrgfqtKuPfWHyyVE0bVmfHLAsh
         3IndFYbmkmiIRV+d07j7klpMLIuiYlqibJ5/hc0CkaZFxwQqgiKV38OASO/ADyjjXHp6
         tCKvnLXNxxu1pYJOaU5jKW6i6Ptd7u3TroAr9pjTyhi4UeAE7ELIZ9p9op3bMH/q8DLH
         RqfxCE8WCbnyoKGVeJ9X+0QfEuvjUczSZ1+fIuC4w61dlY8qHYMYxeHPCRfe3nRlEGmo
         rQtD7stLp61SLvNyqCS8KcLRizB+tD64fV+GoiBkGYSW0Lw5pyf/S7WB7R9U6rmIggIC
         kwiw==
X-Gm-Message-State: AOJu0YyljW9gsAxWZTX3C+3FU6BhBWmj6qqOUXPDzGHUTX6UHRD3IVXt
	lfooMsSoYM5pe7BtKMl9mRxHpFe+85JCS+tzuhnqyPHc/IaB+yKMd8LVD/P9ScES6wSgvFaHf04
	dcBHsH+vG2h3G2kZdCq68niYyYSZyD6aqIkHUTk5MjSbuvixyxwvkKj7fPg==
X-Gm-Gg: AeBDiesDfjLsS3dFQeJEE+qTzFwfIxV4Ypd4fJWwfauPdlc0RGf80cmpd0sevSgnsoL
	WX/CXxKXu8yPceUbJGFWRKNr0iEa2eJtOhVpPwXUx+4W9V4LKF2FySyHG6QTOMdE8UUVYU4yPzs
	esmyqktSXnh4xNbaVEYLdPYS7ZbQSnQjwL6oCN0NBYxNidtKW0w/A0igW483RaJBdcyaEVBvMAy
	il5UywzbaRUjGV/Z/hNNl2qkgcWL/xxlx71oKqtSN3NXTM7KHQM8vT9+LAHw8BxoFywAje/uEaY
	10ZfU8F+5drgDaVhHGfx3sUq9VdDBrseLfYG7I7wJUUtvEfAj/kBY8o7gB/nwvDFcl+Z0MBZlnz
	x4ra5fT2zpjnSJ6/F9GlPh+5D9T7DTdIq/PlUSNXicIYZCS6uSGdTUCupFYDzP6Y=
X-Received: by 2002:a05:600c:811a:b0:48a:674d:e756 with SMTP id 5b1f17b1804b1-48e51f36569mr193210415e9.20.1778236718669;
        Fri, 08 May 2026 03:38:38 -0700 (PDT)
X-Received: by 2002:a05:600c:811a:b0:48a:674d:e756 with SMTP id 5b1f17b1804b1-48e51f36569mr193209945e9.20.1778236718109;
        Fri, 08 May 2026 03:38:38 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-2.retail.telecomitalia.it. [87.11.6.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e642e2b29sm26082845e9.1.2026.05.08.03.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 03:38:37 -0700 (PDT)
Date: Fri, 8 May 2026 12:38:32 +0200
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
Message-ID: <af28MAV0LF4qHVmB@sgarzare-redhat>
References: <20260508092330.69690-1-sgarzare@redhat.com>
 <20260508055125-mutt-send-email-mst@kernel.org>
 <af2y2Fyp7H-om-ur@sgarzare-redhat>
 <20260508063104-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260508063104-mutt-send-email-mst@kernel.org>
X-Rspamd-Queue-Id: F116B4F5184
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285757-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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

On Fri, May 08, 2026 at 06:33:13AM -0400, Michael S. Tsirkin wrote:
>On Fri, May 08, 2026 at 12:01:50PM +0200, Stefano Garzarella wrote:
>> On Fri, May 08, 2026 at 05:53:07AM -0400, Michael S. Tsirkin wrote:
>> > On Fri, May 08, 2026 at 11:23:30AM +0200, Stefano Garzarella wrote:
>> > > From: Stefano Garzarella <sgarzare@redhat.com>
>> > >
>> > > After commit 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb
>> > > queue"), virtio_transport_inc_rx_pkt() subtracts per-skb overhead from
>> > > buf_alloc when checking whether a new packet fits. This reduces the
>> > > effective receive buffer below what the user configured via
>> > > SO_VM_SOCKETS_BUFFER_SIZE, causing legitimate data packets to be
>> > > silently dropped and applications that rely on the full buffer size
>> > > to deadlock.
>> > >
>> > > Also, the reduced space is not communicated to the remote peer, so
>> > > its credit calculation accounts more credit than the receiver will
>> > > actually accept, causing data loss (there is no retransmission).
>> > >
>> > > This also causes failures in tools/testing/vsock/vsock_test.c.
>> > > Test 18 sometimes fails, while test 22 always fails in this way:
>> > >     18 - SOCK_STREAM MSG_ZEROCOPY...hash mismatch
>> > >
>> > >     22 - SOCK_STREAM virtio credit update + SO_RCVLOWAT...send failed:
>> > >     Resource temporarily unavailable
>> > >
>> > > Fix this by introducing virtio_transport_rx_buf_size() to calculate the
>> > > size of the RX buffer based on the overhead. Using it in the acceptance
>> > > check, the advertised buf_alloc, and the credit update decision.
>> > > Use buf_alloc * 2 as total budget (payload + overhead), similar to how
>> > > SO_RCVBUF is doubled to reserve space for sk_buff metadata.
>> > > The function returns buf_alloc as long as overhead fits within the
>> > > reservation, then gradually reduces toward 0 as overhead exceeds
>> > > buf_alloc (e.g. under small-packet flooding), informing the peer to
>> > > slow down.
>> > >
>> > > Fixes: 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue")
>> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> >
>> >
>> > unfortunately, this is a bit of a spec violation and there is no guarantee
>> > it helps.
>>
>> Loosing data like we are doing in 059b7dbd20a6 is even worse IMHO.
>>
>> >
>> > a spec violation because the spec says:
>> > Only payload bytes are counted and header bytes are not
>> > included
>> >
>> > and the implication is that a side can not reduce its own buf_alloc.
>> >
>> > no guarantee because the other side is not required to process your
>> > packets, so it might not see your buf alloc reduction.
>> >
>> > as designed in the current spec, you can only increase your buf alloc,
>> > not decrease it.
>>
>> We never enforced this, currently an user can reduce it by
>> SO_VM_SOCKETS_BUFFER_SIZE and we haven't blocked it since virtio-vsock was
>> introduced, should we update the spec?
>
>
>it's not that we need to enforce it, it's that all synchronization
>assumes this. as in, anyone can use an old copy until they run out
>of credits.
>
>
>> >
>> > what can be done:
>> > - more efficient storage for small packets (poc i posted)
>> > - reduce buf alloc ahead of the time
>>
>> That's basically what I'm doing here: I'm using twice the size of
>> `buf_alloc` (just like `SO_RCVBUF` does for other socket types) and telling
>> the other peer just `buf_alloc`.
>>
>> But then, somehow, we have to let the other person know that we're running
>> out of space. With this patch that only happens when the other peer isn't
>> behaving properly, sending so many small packets that the overhead exceeds
>> `buf_alloc`.
>>
>> Stefano
>
>what is "not proper" here, it is up to the application what to send.

Sure, but here we're just slowing down the application by telling it we 
don't have any more space.

Again, without this patch we are just dropping data, which IMO is even 
worse.

So I think we should merge this for now, while we handle better the EOM.
If you prefer, I can drop the part where we reduce the buf_alloc 
advertised to the other peer, but at least we should drop data after 
`buf_alloc * 2` IMO.


Stefano


