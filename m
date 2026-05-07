Return-Path: <netdev+bounces-285483-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHlENV7y/GlmVgAAu9opvQ
	(envelope-from <netdev+bounces-285483-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 22:13:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4155E4EE479
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 22:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF9A930297B0
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 20:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB3A36EAAE;
	Thu,  7 May 2026 20:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/g/ge06"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DF135B644
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 20:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778184762; cv=none; b=b8NA2Vv81B5a61ohJQDo1TVMKboS1sAzUtm0EXiju+d8Yu53AMU9HIl5HuyhiJyoqwRqBHFfGHGZPabr/8Lc/rgjY3ReapTv1xdDFQd9nM8ex6/+WKbZ9h/Ybfa83GGKpbfLVz+iW2lxbzd48P9rVISiXNWJ+WPYZASGz99+VeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778184762; c=relaxed/simple;
	bh=YiA1eEseDRCOb+C4MPisetZeRtex0Ar8vxo2COhJHQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2IsjUgm9oBlMIF0RISeq04T05fjcAZaKqnwn/aJ03dv4yGBdWHtCgvlbgXZmmcBoM0zhaMoh80pxl8PL9MTFtfHXuAgmBAnvZbDf2X57d2OmA74c5KAtHQr2YfwqvCGFry2u9qRlV5dHBZUeMJD4GcWlv2B7yFLKhw12G1F9P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/g/ge06; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8ec37d52c0dso178716685a.0
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 13:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778184760; x=1778789560; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CufiyOMzWgsZjfa0uu9olo/GL0CEznYyMUEZlGLNhMU=;
        b=T/g/ge061pRx5t3ffnUhKYtUO1RKS8vcp/2PZ57Ge6G/H/wCYga5KeuVfgq4E/8WZj
         mqTxGJPqx0Vg9m/Q/tcgRtOMaca503DSeo1ZGJAZjrstg9VYO6MuHTyFdyQjw3ByD+XA
         P9Muo/iBBht1PhJdjiUfJABtnlwNlONhVlNNnVlNWnnUSjQKQSNA8S5kKGTKbeGwACBd
         QcmBXc1xlKiyJsDe1EG4sfjPcsTxbSAIOWXNtB3L7v/2AO2c4Wmnrs6xByPM0mFpBlAL
         rM9HL3Y0ubuZw1ZmmGLpodyBmSVbaNBlANnOXopMMh6NThpaktkZTSSOkoByIJYJ3GjM
         S9Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778184760; x=1778789560;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CufiyOMzWgsZjfa0uu9olo/GL0CEznYyMUEZlGLNhMU=;
        b=hXANrwRvcr3VPYrKUgnTCug+hfw4KT5MVRW7huLMTeQsm6xlH3/+pTlzWZBWJAmOLQ
         piNDhfwVpmo8pPNMB7ijSolIQUXyFF+lBxUOtx4XD85OXDKiP67Ib6w5BTYYG0MHkohR
         ssRa7t1fBp9ZWWGFUgK0hpeZdMI/uozgbe+eIok4nXnahruae4YV93a6IutH+VCgS7Z+
         n68TK7VS7OXgPe6QOI0uVW1BnCNETzDvMzbMFyp1mNBlgYvxnwszULfSMLHeRtpasGjo
         tCQNsEaqb9mrSCnWb9J2x9FEwqomoUF4hO92abgAPzQZlVw1qo3Y9EHda7c9Jm8cYiMh
         9n0w==
X-Forwarded-Encrypted: i=1; AFNElJ+5J+j2Ab8iZa2v6K8P2AkcFvx0tffHiuw9R1+1kFdFCGnvD3NEYwxdwY1v/uLkL7YIheKlfNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBbzd5KN7Mx3KXRSAxRbqcRMey9IMwKciuDXYosTvIfHbpsQLg
	PYgo846aonl5C6KQkQrVtzCd4MytnQFHwXG3wIKJ26Di3GNAWLm69JpE
X-Gm-Gg: AeBDieuXNQmEvC2ah32tlRDdzyLRe7XMiUZpYlI2O0SNdiQU1lWF0gC3YFEYUtcixyK
	kcfUEeudc37PR9bJpKGjxbSFxByYomeMSz7aTWrUb6b9MtuX6HTMt0aS8YczJNW/yrEHNn9oBlL
	u6vrasv7urSnD+E2qy689rjupu81G1Tu0jf/FiqR/cxE4j1vRzyeEAtkxdeNppnqcNI2QV1JMsb
	WV/jRa3uuZiyrNmlaya/AVoeRLZuI/IugCQUZMqnqx/OrNO1jUJGrkqEd51w0PrpbkrKA78QFEw
	rSXp4Zit9Vpu45tsYIk45OWYJEQYaKG/Ueo6Z0gzNAZsvrRUBZfI8j0Mp+CMvZbOH6piDOnQXbh
	cfMYMkPCFGZoaGLFCOCg6KIWpTZ528KDYeqydrqw5FrM1NUgAZp63KSPwc/eDXeELVoa8UraWO+
	W+WIRso2A2PA+kKKscfqWVBGU+7Gcppu1LK4q+ss8bm/v1s2E=
X-Received: by 2002:a05:620a:258e:b0:8ee:3715:2127 with SMTP id af79cd13be357-904d63e7a0amr1428892785a.38.1778184760010;
        Thu, 07 May 2026 13:12:40 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:f800:31::])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c91cd89sm2059382385a.35.2026.05.07.13.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 13:12:39 -0700 (PDT)
Date: Thu, 7 May 2026 13:12:35 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Paolo Abeni <pabeni@redhat.com>,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>, stefanha@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, horms@kernel.org, Yiqi Sun <sunyiqixm@gmail.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH] vsock/virtio: fix vsockmon info leak in non-linear tap
 copy
Message-ID: <afzyM6fTTAl0Hnvm@devvm29614.prn0.facebook.com>
References: <20260430071110.380509-1-sunyiqixm@gmail.com>
 <f4e52dcd-59ba-4c2e-9936-49cf27528b21@redhat.com>
 <afnXIGtswspSEk8x@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afnXIGtswspSEk8x@sgarzare-redhat>
X-Rspamd-Queue-Id: 4155E4EE479
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,salutedevices.com,meta.com,vger.kernel.org,linux.alibaba.com,davemloft.net,google.com,kernel.org,gmail.com,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-285483-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, May 05, 2026 at 02:44:16PM +0200, Stefano Garzarella wrote:
> CCing Arseniy and Bobby.
> 
> On Tue, May 05, 2026 at 12:26:21PM +0200, Paolo Abeni wrote:
> > On 4/30/26 9:11 AM, Yiqi Sun wrote:
> > > vsockmon mirrors packets through virtio_transport_build_skb(), which
> > > builds a new skb and copies the payload into it. For non-linear skbs,
> > > this goes through virtio_transport_copy_nonlinear_skb().
> > > 
> > > Helper manually initializes a iov_iter, but leaves iov_iter.count unset.
> > > As a result, skb_copy_datagram_iter() sees zero writable bytes
> > > in the destination iterator and copies no payload data.
> > > 
> > > This becomes an info leak because virtio_transport_build_skb() has
> > > already reserved payload_len bytes in the new skb with skb_put(). The
> > > skb is then returned to the tap path with that payload area still
> > > uninitialized, so userspace reading from a vsockmon device can observe
> > > heap contents and potentially kernel address.
> > > 
> > > Fix it by initializing iov_iter.count to the number of bytes to copy.
> > > 
> > > Fixes: 4b0bf10eb077 ("vsock/virtio: non-linear skb handling for tap")
> > > Signed-off-by: Yiqi Sun <sunyiqixm@gmail.com>
> > > ---
> > >  net/vmw_vsock/virtio_transport_common.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > > index 416d533f493d..6b26ee57ccab 100644
> > > --- a/net/vmw_vsock/virtio_transport_common.c
> > > +++ b/net/vmw_vsock/virtio_transport_common.c
> > > @@ -152,7 +152,7 @@ static void virtio_transport_copy_nonlinear_skb(const struct sk_buff *skb,
> > >  	iov_iter.nr_segs = 1;
> > > 
> > >  	to_copy = min_t(size_t, len, skb->len);
> > > -
> > > +	iov_iter.count = to_copy;
> > >  	skb_copy_datagram_iter(skb, VIRTIO_VSOCK_SKB_CB(skb)->offset,
> > >  			       &iov_iter, to_copy);
> > 
> > @Stefano, @Stefan, the patch LGTM, but sashiko pointed out to a
> > pre-existing issue you should probably want to address:
> > 
> > >  	to_copy = min_t(size_t, len, skb->len);
> > Does this length calculation account for the offset when a packet is
> > split across multiple transmissions?
> > If a packet is requeued, VIRTIO_VSOCK_SKB_CB(skb)->offset is increased,
> > but to_copy still evaluates to the full length of the skb.
> 
> Yep, I just checked and vhost-vsock is the only place where we call
> virtio_transport_deliver_tap_pkt() wiht an offset != 0, but I agree that we
> should also fix it.
> 
> Looking better in net/vmw_vsock/virtio_transport_common.c I think this is a
> regression, indeed we have this comment in virtio_transport_build_skb():
> 
> 	/* A packet could be split to fit the RX buffer, so we can retrieve
> 	 * the payload length from the header and the buffer pointer taking
> 	 * care of the offset in the original packet.
> 	 */
> 	pkt_hdr = virtio_vsock_hdr(pkt);
> 
> Before commit 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with
> sk_buff") we read the payload lenght from the header that is always set to
> the right value before delivering the packet to the tap.
> 
> From that commit, we don't to consider the offset anymore since we started
> to use `len` from the skb, so IMO we should go back to what we did before
> it, I mean:
> 
> 	payload_len = le32_to_cpu(pkt->hdr.len);
> 
> @Bobby do you remember why we did that change? Or if you see any issue going
> back to what we did initially?

I think this was just one that made it through the cracks. I vaguely
recall a few other instances where I assumed skb->len could stand-in for
hdr.len, but it didn't hold.

Using hdr.len like the original looks correct to me.

Best,
Bobby

