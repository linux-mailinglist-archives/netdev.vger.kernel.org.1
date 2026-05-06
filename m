Return-Path: <netdev+bounces-284925-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGI7OERh+2kuaQMAu9opvQ
	(envelope-from <netdev+bounces-284925-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 17:41:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 491FD4DD732
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 17:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0CB6A305BEA1
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 15:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B605481223;
	Wed,  6 May 2026 15:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NG8S3duw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZLwXuurX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D99D3FADE2
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 15:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778081877; cv=none; b=X4WTqZT/wNIvEpjdFVemvpxESf5gxSGFJWvDwW/waDwsUkrXeUHfuiGl5iqs1Kjl+D0n/vyUvSksNDuiwEaPl+0yNXku8hV67gH4uOTNg5poShiZjcWOPsBN/E9ZWbtdwdxY2sHYX8j4h5RwR7SRtHMKSMYhvvqGzON2lia7HNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778081877; c=relaxed/simple;
	bh=YJyiH7vsjN9wJDdrOLzg7WAgRAisr5GaMsdx9zFAeac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZukqK4iKJxoNu7tNALNSpcrc4iaOzs5Fg0EXjp0vGXFQ/firakQSDgwtqfHeS0yz2V5ymAxjeauluZvM4uZux8mVUwA3ZKnw+iYquot9PEdiwDQC4qzDFECpoWFi2njwlIQBoJAn7dpL9qRXU7bNUFhGDhaIf3puh631Qbr/B6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NG8S3duw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZLwXuurX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778081873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J4Q8PvkIMQ5a5m63+buAC7DaLgwo1MQIWybr1f7ZYKw=;
	b=NG8S3duw4pH4CooKSbvJr53YMJtQBxjoirdGOgfk9xanbXoqE0NxyeW3GrnbKj4vMBZ1w3
	OKKgYlWAlA+5Zop0CxiNXQ3q3xeJ7zIIU6z2T29OtnhFPl1gfuPdj9+6UNfwAZ+RNGV/Rb
	ztsoB1AJO5sp9P/CXYdx/jKiuVo2c6M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-YU2rrDkcMGGraboSQm7WUA-1; Wed, 06 May 2026 11:37:51 -0400
X-MC-Unique: YU2rrDkcMGGraboSQm7WUA-1
X-Mimecast-MFC-AGG-ID: YU2rrDkcMGGraboSQm7WUA_1778081870
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-44a71109b94so4273541f8f.3
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 08:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778081870; x=1778686670; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J4Q8PvkIMQ5a5m63+buAC7DaLgwo1MQIWybr1f7ZYKw=;
        b=ZLwXuurXYWQ6Y1VGE98BAWXzHWnsJ5jrkEq825f0t/n/my5KGcLPA+6FeRPKoxiHpy
         uq99CdvVFeeqy1phNn0xX49Q6avAp+OPFepYISyPKouhVTQwAV4Fu9iq6hw07dp6PtI9
         oZ/He44+Kj6yBJoxJcDgz9+bB4M4QCzZFjM2r5RMbbBVbjE11klzzUfQWGW//FAD4fda
         tlLYL+5XWjUN1HA2Leqp9al5rBu+EVfE4ycfMIF1FDkJJ8SkZPBnvCnK71WgsJaPYtBN
         kenSDvuksfKbPJzmY0fjDLBTKucDeZyJwaehrB1x32XSX2qHYGkhOEaeWVBqGSTKPnpI
         4bEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778081870; x=1778686670;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J4Q8PvkIMQ5a5m63+buAC7DaLgwo1MQIWybr1f7ZYKw=;
        b=gX6vGwgEyLkSEK/Fvi59Gwijt/lo6oXO7qwisnq+IXTZa0OzT93JEQHE8vF+Mfzg2V
         FusVRT6OaM7SZvDKkF7Futjk9kwcnMMAs81va7x0CPKssPR39BVnsh/eSmFHlaPSJu/Z
         lnop+v63sGVoC9Vx41Q7QF3hTU9pxAmp0xCm7X1sVYqAoAAFqzDbdQA4AwQnCUhz05qf
         t15Y/0ywhxPm4LI1y3Dsdum8Naye81xx2rxa7wlidEDUVqvpJcfsa8mQH08JsjuWgJDb
         nz6EK5F9o8kvFiVyWnN3EdlUxgYMkZg95JZ2MAYjQSDKT7aBvvekOma9nTtJ2sAl55xP
         Z7ug==
X-Forwarded-Encrypted: i=1; AFNElJ/kI3of8V2+bwcbKAnG+8o6JFEC7kknu63iE9lCzXY2Xt8vV2St1MsTm/IHMAGa7ovArHCztMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YysI3qlsyrkmzFbAtBOd9Jqm68K3/D4ElwD6OP/V1oxQGy9okKR
	HP/lMDuMmdqnlH+Vs8OlYdNt4fy84zryrXdrPsdG9TzBw0a+HQFHaHZfRtQpv0dY0+U2KGkrht6
	LotBoNwX5nFcV44n9WF/f3srJmfyOnYpaj8PbamKbW2JfIVFEpcYBdLG35EsypdJiYw==
X-Gm-Gg: AeBDieuH5OtKm29fWPhqMJnKkc3qqyIybO3TAP+iDtqYWIDxPbMnodOdpHrRIR9noQR
	GYPbMOekQxoKVQ/4kYNOTMwVlhSvTLTWLBF7pJXa8FhBdCTU+Jwco5yo9jOUP0gHGCYOJJZUGvw
	WEFqEDrBhUOWpaRLhSek2h5qe9CqUftlg0JpCgtwvR8V50WcG+zsrWiWX2DenZvHkVhH02DWiRK
	ra531KN0quMWiSijmUHfZKrLMurWT/DgYOkmfM8JtnLphQx11Ym7dgrn2RohKGnlS8RhTF+83YK
	2a61RuO3fknXggPfQUpNwRk8OteHyTYSUQ6VZX1TaPR4zYcZWPIjcNkBEDuZnYPZjY4hBNUx7Lw
	G+2w4SUfgBjLrDp0Y1loqHv6DD/vQoMNLupREHTruW9e9Csjky0M=
X-Received: by 2002:a05:6000:4312:b0:43d:7d24:b4ff with SMTP id ffacd0b85a97d-4515da967a5mr7045461f8f.40.1778081869603;
        Wed, 06 May 2026 08:37:49 -0700 (PDT)
X-Received: by 2002:a05:6000:4312:b0:43d:7d24:b4ff with SMTP id ffacd0b85a97d-4515da967a5mr7045381f8f.40.1778081868998;
        Wed, 06 May 2026 08:37:48 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055d36dacsm13194806f8f.32.2026.05.06.08.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 08:37:48 -0700 (PDT)
Date: Wed, 6 May 2026 11:37:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH net] vsock/virtio: fix potential unbounded skb queue
Message-ID: <20260506113554-mutt-send-email-mst@kernel.org>
References: <20260430122653.554058-1-edumazet@google.com>
 <afn0ZdvZWswBuDMm@sgarzare-redhat>
 <CANn89iLs8DOWJwDpf_ARoMrV+6b2tbhEJ=VVzeC8gCm5dRGaig@mail.gmail.com>
 <afoF_cHfl6ygcupM@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afoF_cHfl6ygcupM@sgarzare-redhat>
X-Rspamd-Queue-Id: 491FD4DD732
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284925-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[google.com,salutedevices.com,meta.com,redhat.com,davemloft.net,kernel.org,vger.kernel.org,gmail.com,sberdevices.ru,linux.alibaba.com,lists.linux.dev];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,alibaba.com:email,oasis-open.org:url]

On Tue, May 05, 2026 at 06:11:13PM +0200, Stefano Garzarella wrote:
> On Tue, May 05, 2026 at 07:14:36AM -0700, Eric Dumazet wrote:
> > On Tue, May 5, 2026 at 6:52 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
> > > 
> > > On Thu, Apr 30, 2026 at 12:26:52PM +0000, Eric Dumazet wrote:
> > > >virtio_transport_inc_rx_pkt() checks vvs->rx_bytes + len > vvs->buf_alloc.
> > > >
> > > >virtio_transport_recv_enqueue() skips coalescing for packets
> > > >with VIRTIO_VSOCK_SEQ_EOM.
> > > >
> > > >If fed with packets with len == 0 and VIRTIO_VSOCK_SEQ_EOM,
> > > >a very large number of packets can be queued
> > > >because vvs->rx_bytes stays at 0.
> > > >
> > > >Fix this by estimating the skb metadata size:
> > > >
> > > >       (Number of skbs in the queue) * SKB_TRUESIZE(0)
> > > >
> > > >Fixes: 077706165717 ("virtio/vsock: don't use skbuff state to account credit")
> > > >Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > >Cc: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> > > >Cc: Stefan Hajnoczi <stefanha@redhat.com>
> > > >Cc: Stefano Garzarella <sgarzare@redhat.com>
> > > >Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > > >Cc: Jason Wang <jasowang@redhat.com>
> > > >Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > >Cc: "Eugenio Pérez" <eperezma@redhat.com>
> > > >Cc: kvm@vger.kernel.org
> > > >Cc: virtualization@lists.linux.dev
> > > >---
> > > > net/vmw_vsock/virtio_transport_common.c | 4 +++-
> > > > 1 file changed, 3 insertions(+), 1 deletion(-)
> > > >
> > > >diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > > >index 416d533f493d7b07e9c77c43f741d28cfcd0953e..9b8014516f4fb1130ae184635fbba4dfee58bd64 100644
> > > >--- a/net/vmw_vsock/virtio_transport_common.c
> > > >+++ b/net/vmw_vsock/virtio_transport_common.c
> > > >@@ -447,7 +447,9 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> > > > static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
> > > >                                       u32 len)
> > > > {
> > > >-      if (vvs->buf_used + len > vvs->buf_alloc)
> > > >+      u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
> > > >+
> > > >+      if (skb_overhead + vvs->buf_used + len > vvs->buf_alloc)
> > > >               return false;
> > > 
> > > I'm not sure about this fix, I mean that maybe this is incomplete.
> > > In virtio-vsock, there is a credit mechanism between the two peers:
> > > https://docs.oasis-open.org/virtio/virtio/v1.3/csd01/virtio-v1.3-csd01.html#x1-4850003
> > > 
> > > This takes only the payload into account, so it’s true that this problem
> > > exists; however, perhaps we should also inform the other peer of a lower
> > > credit balance, otherwise the other peer will believe it has much more
> > > credit than it actually does, send a large payload, and then the packet
> > > will be discarded and the data lost (there are no retransmissions,
> > > etc.).
> > 
> > I dunno, perhaps revert 077706165717 ("virtio/vsock: don't use skbuff
> > state to account credit")
> > and find a better fix then?
> 
> IIRC the same issue was there before the commit fixed by that one (commit
> 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")), so
> not sure about reverting it TBH.
> 
> CCing Arseniy and Bobby.
> 
> > 
> > There is always a discrepancy between skb->len and skb->truesize.
> > You will not be able to announce a 1MB window, and accept one milliion
> > skb of 1-byte each.
> > 
> > This kind of contract is broken.
> > 
> 
> Yep, I agree, but before we start discarding data (and losing it), IMHO we
> should at least inform the other peer that we're out of space.
> 
> @Stefan, @Michael, do you think we can do something in the spec to avoid
> this issue and in some way take into account also the metadata in the
> credit. I mean to avoid the 1-byte packets flooding.
> 
> Thanks,
> Stefano

Why do we need the metadata? Just don't keep it around if you begin
running low on memory.

-- 
MST


