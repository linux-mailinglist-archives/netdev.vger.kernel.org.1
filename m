Return-Path: <netdev+bounces-284514-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAb2J80c+mkJJgMAu9opvQ
	(envelope-from <netdev+bounces-284514-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 18:37:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F734D16DB
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 18:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 01359300C00A
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 16:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47778481FAE;
	Tue,  5 May 2026 16:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UnwjTQNv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B023D48C8BB
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 16:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777999050; cv=none; b=b7ssX1xs2EDvSv91fg6ZF/Ah7biS4yp1we/IzLBw9r6df0ThfoMGS2/xkZSQ33puTKWv/SP1bYQPxJdMPpReFpum8w6VmmN90A8I1DK8OM5N9fEa6ViCWMUwy7I2r1fwpmCPIaVDa2ND1IF5w3F4Wz/u+/zqDoog13gdsKe+3z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777999050; c=relaxed/simple;
	bh=2vNM4P2xnGuAG3lTftkwlu0d8ky0Pc81tFLomdyLZA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qHg22ovZu2qnaI1TYFWDiZJtEr15nrxw9nceRZ/rKC4cIeUMb/Lx+vBCFuL17xo4HCcvlpTds5/tFR9m4QZrib/w7nLjxJkQ8p+8oLK5alUNZW/o8dmHajsk2A9e7IlWml6nAsWlaEDZqasKgsVoqRysBoSX7MUYiXXPt7cd9Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UnwjTQNv; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7b23713eac9so59669147b3.2
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 09:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777999047; x=1778603847; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PMfEZkH6rxvYX9869GT2iOu8sbvJpC6I3W7itO6JEjI=;
        b=UnwjTQNvq/r4beqLgkxxKUEWpEqcq3/5/5P9HzTdLDbUdvdM6TqcZ9a2FCgt9EP8Vh
         tpSAmdxVfuciSI0T5myAKGxtHcVxrocZoG6cz/cyVRGzj2d2uiFbDAEOoOs6kYShvjyY
         BBlbVoHGzjfLyg5uNMdeBNpMeiwkDXgPInA3t5PeHP7c17rOVOnwbgYSvvoHTm5WtkRD
         CDqemvSe6xheG+0qw8+mevVQnDuccrHfuA1xizPVrAiYqF0s2aAXc14NkhWeczP+R274
         Gt15ZKWwDWZ5BBng/gsbIhG2cPkT/5MxKJqyc67BkHJ/h8bAyrHvBFUhPs97cYo7E0dl
         3I+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777999047; x=1778603847;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PMfEZkH6rxvYX9869GT2iOu8sbvJpC6I3W7itO6JEjI=;
        b=a1AbJHT26H7JJ9xrtCvAUG6WY/03XS1oQnx5YrzvGAnrxPVtvviGi9V3lJBbMIkyYb
         pu1ukBU9BsEXOzBzSUbt3v9RF958lwyMVrNB3NlyMxH87LXFhFoS/NU8QLtjgqt4rZoC
         XP2hHqvxVoSImjnsndv4XIXINjYZKLqNzzdWPD2n0QRGUBScgwUwJadTsRM8uPyUCyQT
         yhg2OUUEWF0SSUT/SNheFkO5xNMMD6Z9gH+ckEUtm2pM5v8Lbs1CII3Jzlj+8Ujjoi4M
         U7IddFBnlu2AuF/oUlIZ3RRVq/kA0ZrhACtiP6E0pmjY/Stx7F13LPlTNoiAoluO7mg9
         b/Dw==
X-Forwarded-Encrypted: i=1; AFNElJ82D/ok4+e+zepJbgDa/d8ZP2rH/xRm0fCM6LlXkvK4y2ydVVgnPCn8OH3n8EQYuvaBBmgI6tM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw96cvNuUgkRLfLfZu+8W65zGqBkPXr7i5Oumno9OCfAsdONpWr
	v5Y42KdqAOW5UEseGFj2GTI/J0SoWFntKBIg8QiaHBx3MJc/Aj82n4eJ
X-Gm-Gg: AeBDiescuPGGGxdiAulbHgzVfG2BCa4t8LU84vaOm34IF6Fft8rmz0fazR+uMeejaOq
	AVEAgm5DpwbuzOr8wT1WwSlTe4cSdW/3FW2gET0pHVCCrjDHIJQFTmgtyaLVUM/s3EFKuxBy/Y8
	kY145VhsJ1O4d0AQY/BcLQ8lzPJiTnz50f31Wdk0qgDq1zo4q50CD+6hOliGOEHgcwA9BEG4mMM
	qltiLn1yBPoVIXEq126vkSkdvg7VugC856D0pMKBb0G5iSqYEH/2kLBKZhxSyDyg4cKFzVgTCzB
	u1+UF5gurcB69L0W3y1Y8W/GuPk3Ls6vfmJgu+F83EVxnNzWhrBtU7+O2N+lM4yOV92kCdju87+
	Okk9ceJI6HpPrSYkJO8Xiy7AGKOeACRDa6VLnMyAoeEPACl6YJQiNT6BMJsoBt09iLK+sBdi5ok
	TNXT5HJykOngfuCI8K6nAPth0sLggsCER7ke6nlLPvSr628QfYH4ibzU8=
X-Received: by 2002:a05:690c:a018:b0:7b3:6c50:2e8f with SMTP id 00721157ae682-7bd77109d77mr140515237b3.41.1777999047308;
        Tue, 05 May 2026 09:37:27 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:70::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd66525651sm66719897b3.3.2026.05.05.09.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 09:37:26 -0700 (PDT)
Date: Tue, 5 May 2026 09:37:22 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH net] vsock/virtio: fix potential unbounded skb queue
Message-ID: <afocwkfBHJ5u10rx@devvm29614.prn0.facebook.com>
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
X-Rspamd-Queue-Id: 26F734D16DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284514-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,salutedevices.com,meta.com,redhat.com,davemloft.net,kernel.org,vger.kernel.org,gmail.com,sberdevices.ru,linux.alibaba.com,lists.linux.dev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oasis-open.org:url,alibaba.com:email,linux.dev:email,sberdevices.ru:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,devvm29614.prn0.facebook.com:mid]

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
> 
> 

Indeed the old pre-fix skb code would have the same issue.

I can't think of any way around this without extending the spec.

Best,
Bobby

