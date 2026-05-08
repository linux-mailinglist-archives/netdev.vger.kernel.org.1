Return-Path: <netdev+bounces-285744-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDDTOsSz/WkrhwAAu9opvQ
	(envelope-from <netdev+bounces-285744-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 11:58:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9E24F49C2
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 11:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 938AF300D557
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 09:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C347F384228;
	Fri,  8 May 2026 09:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QNNI3P56";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="h1RacA1q"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD0737AA92
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 09:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778234299; cv=none; b=NSt6trX764OXIxQT78Cc/CZ6Niu5fEHH4x/P0yjr30ZLrWYWB6VFF8ZfBskYqdPzDzvAvTaozpwHCpw9slMSjjmHY3MVae0SFcwyXsSt85WkpdQiWOq85OItWupV5U37+Yog58aS+HVOrpU1E6FzOwbZJqrTRq7kxBPPKE0kvaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778234299; c=relaxed/simple;
	bh=x/U9Vj9OeGBiBAoWKCZEkAuhUmY5FG6SfCWRgLrUSec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lGA2XQrdMJzC7OG3w1KZPHXNY3SqizbK0TvdBM3cESN/IybDxAZjf4kq7E+29PDLit1dIZjL6l5zkDsP690Qn0K0Th4gfq4ET5XINkZ61yhkv/z6uVE3byXQOP5pgFQXONo3G4KeE5ThhLi2jLDVsh8/wKIu6lMkeLTbncZ1Sy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QNNI3P56; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=h1RacA1q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778234296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AQbNyzvENCAOnuvyW/imX7fC7QNGBUcn3BPu85EGkJk=;
	b=QNNI3P56xN39h2QzQPTGrRNJ0HzBoGewLCJnhZvv+/uY0BN5skG4zM6ikuQP5K3AAfHwmV
	YlrGnsWWqOdd0GHsrvHFNr0JrRA71BqDBEmNRTvS6ndhSe/9A9G79RVLeRpquyg0oi8vUl
	3SqG7NzRqQ4XqG3hAcQrAsWzeHE71ko=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-1lKKYqXBOeOEwmhngz_pBg-1; Fri, 08 May 2026 05:58:12 -0400
X-MC-Unique: 1lKKYqXBOeOEwmhngz_pBg-1
X-Mimecast-MFC-AGG-ID: 1lKKYqXBOeOEwmhngz_pBg_1778234292
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-488d1b5bca0so9035515e9.2
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 02:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778234292; x=1778839092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AQbNyzvENCAOnuvyW/imX7fC7QNGBUcn3BPu85EGkJk=;
        b=h1RacA1qO4/I282SMCtEzVhLIj+ztb0mxszCe+f2UMRwEPb7b6ayPZ8Z47Yvrof+Xv
         aO6YbmAJsKV4WntDKSce/KxqtOwCc/1BSf3fcs9irspyP9m48LgEXfTzEVBgLHOeuQ0Y
         GmLfM6QnWlX2ijlYvwHxzQvEs7E9YxLnK4tfqiThLJ4Hu4MAAkVufS4nesCLV0YpJSc3
         wB9qTEDPy4Qh04WUlv1fhBcCe9/TiesDnTo0wXe/blFqlTx/VswCr6lMyWS4QrHPwVcF
         FAu0QHAaRZ2IAReSLlmlf4SldzCNJiRrvuHMh8BlQ+2vR5ugbtfEzrB42+316ktt1Pa6
         ijvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778234292; x=1778839092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AQbNyzvENCAOnuvyW/imX7fC7QNGBUcn3BPu85EGkJk=;
        b=M3LBY3Tr9orq2DdabrCTjxfI+KNgP66wLHO6hyRZBpLo1gFZd2EToMepxurSaOATnn
         yuGrLmBXwqnVmmCoAksBwoHdgd6zmxWPR7qSSjoG8y6zQ7NHY7FsCBVWmKm23KPi+jrC
         JWnjm72B4Hk6kqzAmyoYOtjVf315sYM5qnA2DO+p2a812YEALAvi2YHXL85FIhvRYu/D
         cFxCso9amEJqraDwfwn/fCjwxeRafyV7n7sNJ+jEjd8EpMtyUg3U64Uf4CUUFoxCiJIx
         tJOaMEcpSgyQLPD3F753HjdvDc5yYAG5oCYI42BKkZIIj+qAamL8TUyn7tlrFnAA4Rn5
         NOpw==
X-Forwarded-Encrypted: i=1; AFNElJ9c8Mn0sZI/rZWatrObPUb3YCjdXF1yvXDlFtCCDmuNqp2oS7Ci9d3hOiY7wXH2OTEj50tAUVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuSjH3KvZlIPkGwOrlVJhNZ5rY/GFvL1s6q51Frzw2PUara/9E
	blhemEWv0T/V67ZF/sl3R71j/MGCoC2ON4NbkxIe0dAi4VXBO3M5YLkinzXRaUGrSGoL9gLaL72
	kVubTjneWlLhl6tv4J90UNSr5NVZ1V+vmPNa8wJlzO31PxMQ9gnxDF1zv0g==
X-Gm-Gg: AeBDieuMklm6rlp98HyWRTs433ExsLVrEleUUNJEimF5tjOLGLGFmxc/iwkUVvKYyzC
	33ZJ2waiWLHbaX0qwBPyLi7o62l0WCMWtA0DmVMgENTu883RlApYeQbyBcGkQop5I1pop6quQgk
	qHhT5qyErORNSbTPstveaEerjdJa5AFS47SewThvE6NaQuhal+M9ZyWqzVcBNylsfmVHljCAIhi
	DgapVQbVjkydP8riZ+i4YFsvE2K6NsW1YJANdHYCxZbWizTneXdQ0CSrdMFyXzxLkYGJSbCNYsv
	JgQZGK4RfWONzf1ylaIjl0xZMWmLVX8pjD9eOyQAMqsKjbS7cyUHS7yaaC8m/G4uZQnN02+zGzN
	veDXH0CDjhjpDBt+lzhlMDGXmsEKQ/8FwNi5AdZr9
X-Received: by 2002:a05:600c:8594:b0:485:39b2:a47c with SMTP id 5b1f17b1804b1-48e676b65a9mr24046015e9.25.1778234291385;
        Fri, 08 May 2026 02:58:11 -0700 (PDT)
X-Received: by 2002:a05:600c:8594:b0:485:39b2:a47c with SMTP id 5b1f17b1804b1-48e676b65a9mr24045525e9.25.1778234290655;
        Fri, 08 May 2026 02:58:10 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e68eaf237sm33043215e9.6.2026.05.08.02.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 02:58:10 -0700 (PDT)
Date: Fri, 8 May 2026 05:58:06 -0400
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
Message-ID: <20260508055343-mutt-send-email-mst@kernel.org>
References: <20260430122653.554058-1-edumazet@google.com>
 <afn0ZdvZWswBuDMm@sgarzare-redhat>
 <CANn89iLs8DOWJwDpf_ARoMrV+6b2tbhEJ=VVzeC8gCm5dRGaig@mail.gmail.com>
 <afoF_cHfl6ygcupM@sgarzare-redhat>
 <20260506113554-mutt-send-email-mst@kernel.org>
 <afxVH2So9BbZ3Gta@sgarzare-redhat>
 <20260507074113-mutt-send-email-mst@kernel.org>
 <afyMCyBvZpzWrLtO@sgarzare-redhat>
 <20260507163710-mutt-send-email-mst@kernel.org>
 <af2sXvVCBT05XF0D@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af2sXvVCBT05XF0D@sgarzare-redhat>
X-Rspamd-Queue-Id: EE9E24F49C2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285744-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[anthropic.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, May 08, 2026 at 11:41:21AM +0200, Stefano Garzarella wrote:
> On Thu, May 07, 2026 at 06:48:47PM -0400, Michael S. Tsirkin wrote:
> > On Thu, May 07, 2026 at 02:59:13PM +0200, Stefano Garzarella wrote:
> > > On Thu, May 07, 2026 at 07:45:10AM -0400, Michael S. Tsirkin wrote:
> > > > On Thu, May 07, 2026 at 11:09:47AM +0200, Stefano Garzarella wrote:
> 
> [...]
> 
> > > > > For now, we're already doing something:
> > > > > merging the skuffs if they don't have EOM set.
> > > >
> > > >
> > > > Right that's good. You could go further and merge with EOM too
> > > > if you stick the info about message boundaries somewhere else.
> > > 
> > > This adds a lot of complexity IMO, but we can try.
> > > 
> > > Do you have something in mind?
> > 
> > BER is clearly overkill but here's a POC that claude made for me,
> > just to give u an idea. It's clearly has a ton of issues,
> > for example I dislike how GFP_ATOMIC is handled.
> 
> Okay, I somewhat understand, but clearly this isn't net material

I doubt we have many other options given reverting the regression was
ruled out.


> so for now
> I think the best thing to do is to merge the fixup I sent (or something
> similar):
> https://lore.kernel.org/netdev/20260508092330.69690-1-sgarzare@redhat.com/

I reviewed that one, problem is it's a spec violation/change that we'll
have to support forever. 

> This is a major change that should be merged with more caution.
> Could this have too much of an impact on performance?
> 
> Thanks,
> Stefano

It's really a POC, real patch is left as an excersise for the reader :).
The correct approach IMHO is to only start using this
when we wasted a lot of memory on small packets.

For example, if sum(truesize) >= buf size.

then we'll not see a perf impact unless it's already pathological.


> > Yet it seems to work fine in light testing.
> > 
> > -->
> > 
> > 
> > vsock/virtio: use DWARF ULEB128 to record EOM boundaries, enable cross-EOM skb coalescing
> > 
> > virtio_transport_recv_enqueue() currently refuses to coalesce an
> > incoming skb with the previous one when the previous skb carries
> > VIRTIO_VSOCK_SEQ_EOM.  This forces one skb per seqpacket message.
> > For workloads with many small or zero-byte messages the per-skb
> > overhead (~960 bytes) dominates, causing unbounded memory growth.
> > 
> > Decouple message boundary tracking from the skb structure: store
> > boundary offsets in a compact side buffer using DWARF ULEB128
> > encoding with the EOR flag folded into the low bit, then allow
> > the data of multiple complete messages to be coalesced into a single
> > skb.
> > 
> > Cross-EOM coalescing fires only when:
> > - both the tail skb and the incoming packet carry EOM (complete msgs)
> > - the incoming packet fits in the tail skb's tailroom
> > - no BPF psock is attached (read_skb expects one msg per skb)
> > 
> > On allocation failure the code falls back to separate skbs (existing
> > behaviour).  Credit accounting is unchanged; the boundary buffer is
> > capped at PAGE_SIZE.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > Co-Authored-By: Claude Opus 4.6 (1M context) <noreply@anthropic.com>
> > 
> > diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> > index f91704731057..e36b9ab28372 100644
> > --- a/include/linux/virtio_vsock.h
> > +++ b/include/linux/virtio_vsock.h
> > @@ -12,6 +12,7 @@
> > struct virtio_vsock_skb_cb {
> > 	bool reply;
> > 	bool tap_delivered;
> > +	bool has_boundary_entries;
> > 	u32 offset;
> > };
> > 
> > @@ -167,6 +168,12 @@ struct virtio_vsock_sock {
> > 	u32 buf_used;
> > 	struct sk_buff_head rx_queue;
> > 	u32 msg_count;
> > +
> > +	/* ULEB128-encoded seqpacket message boundary buffer */
> > +	u8 *boundary_buf;
> > +	u32 boundary_len;
> > +	u32 boundary_alloc;
> > +	u32 boundary_off;
> > };
> > 
> > struct virtio_vsock_pkt_info {
> > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > index 416d533f493d..81654f70f72c 100644
> > --- a/net/vmw_vsock/virtio_transport_common.c
> > +++ b/net/vmw_vsock/virtio_transport_common.c
> > @@ -11,6 +11,7 @@
> > #include <linux/sched/signal.h>
> > #include <linux/ctype.h>
> > #include <linux/list.h>
> > +#include <linux/skmsg.h>
> > #include <linux/virtio_vsock.h>
> > #include <uapi/linux/vsockmon.h>
> > 
> > @@ -26,6 +27,91 @@
> > /* Threshold for detecting small packets to copy */
> > #define GOOD_COPY_LEN  128
> > 
> > +#define VSOCK_BOUNDARY_BUF_INIT	64
> > +#define VSOCK_BOUNDARY_BUF_MAX	PAGE_SIZE
> > +
> > +/* ULEB128 boundary encoding: value = (msg_len << 1) | eor.
> > + * Each byte carries 7 data bits; bit 7 is set on all but the last byte.
> > + * Max 5 bytes for a u32 msg_len (33 bits with eor shift).
> > + */
> > +static int vsock_uleb_encode_boundary(u8 *buf, u32 msg_len, bool eor)
> > +{
> > +	u64 val = ((u64)msg_len << 1) | eor;
> > +	int n = 0;
> > +
> > +	do {
> > +		buf[n] = val & 0x7f;
> > +		val >>= 7;
> > +		if (val)
> > +			buf[n] |= 0x80;
> > +		n++;
> > +	} while (val);
> > +
> > +	return n;
> > +}
> > +
> > +static int vsock_uleb_decode_boundary(const u8 *buf, u32 avail,
> > +				      u32 *msg_len, bool *eor)
> > +{
> > +	u64 val = 0;
> > +	int shift = 0;
> > +	int n = 0;
> > +
> > +	do {
> > +		if (n >= avail || shift >= 35)
> > +			return -EINVAL;
> > +		val |= (u64)(buf[n] & 0x7f) << shift;
> > +		shift += 7;
> > +	} while (buf[n++] & 0x80);
> > +
> > +	*eor = val & 1;
> > +	*msg_len = val >> 1;
> > +	return n;
> > +}
> > +
> > +static void vsock_boundary_buf_compact(struct virtio_vsock_sock *vvs)
> > +{
> > +	if (vvs->boundary_off == 0)
> > +		return;
> > +
> > +	vvs->boundary_len -= vvs->boundary_off;
> > +	memmove(vvs->boundary_buf, vvs->boundary_buf + vvs->boundary_off,
> > +		vvs->boundary_len);
> > +	vvs->boundary_off = 0;
> > +}
> > +
> > +static int vsock_boundary_buf_ensure(struct virtio_vsock_sock *vvs, u32 needed)
> > +{
> > +	u32 new_alloc;
> > +	u8 *new_buf;
> > +
> > +	if (vvs->boundary_alloc >= needed)
> > +		return 0;
> > +
> > +	/* Reclaim consumed space before growing */
> > +	if (vvs->boundary_off) {
> > +		needed -= vvs->boundary_off;
> > +		vsock_boundary_buf_compact(vvs);
> > +		if (vvs->boundary_alloc >= needed)
> > +			return 0;
> > +	}
> > +
> > +	new_alloc = max(needed, vvs->boundary_alloc ? vvs->boundary_alloc * 2
> > +						    : VSOCK_BOUNDARY_BUF_INIT);
> > +	if (new_alloc > VSOCK_BOUNDARY_BUF_MAX)
> > +		new_alloc = VSOCK_BOUNDARY_BUF_MAX;
> > +	if (new_alloc < needed)
> > +		return -ENOMEM;
> > +
> > +	new_buf = krealloc(vvs->boundary_buf, new_alloc, GFP_ATOMIC);
> > +	if (!new_buf)
> > +		return -ENOMEM;
> > +
> > +	vvs->boundary_buf = new_buf;
> > +	vvs->boundary_alloc = new_alloc;
> > +	return 0;
> > +}
> > +
> > static void virtio_transport_cancel_close_work(struct vsock_sock *vsk,
> > 					       bool cancel_timeout);
> > static s64 virtio_transport_has_space(struct virtio_vsock_sock *vvs);
> > @@ -682,41 +768,74 @@ virtio_transport_seqpacket_do_peek(struct vsock_sock *vsk,
> > 	total = 0;
> > 	len = msg_data_left(msg);
> > 
> > -	skb_queue_walk(&vvs->rx_queue, skb) {
> > -		struct virtio_vsock_hdr *hdr;
> > +	skb = skb_peek(&vvs->rx_queue);
> > +	if (skb && VIRTIO_VSOCK_SKB_CB(skb)->has_boundary_entries) {
> > +		u32 msg_len, offset;
> > +		size_t bytes;
> > +		bool eor;
> > +		int ret;
> > 
> > -		if (total < len) {
> > -			size_t bytes;
> > +		ret = vsock_uleb_decode_boundary(
> > +			vvs->boundary_buf + vvs->boundary_off,
> > +			vvs->boundary_len - vvs->boundary_off,
> > +			&msg_len, &eor);
> > +		if (ret < 0)
> > +			goto unlock;
> > +
> > +		offset = VIRTIO_VSOCK_SKB_CB(skb)->offset;
> > +		bytes = min(len, (size_t)msg_len);
> > +
> > +		if (bytes) {
> > 			int err;
> > 
> > -			bytes = len - total;
> > -			if (bytes > skb->len)
> > -				bytes = skb->len;
> > -
> > 			spin_unlock_bh(&vvs->rx_lock);
> > -
> > -			/* sk_lock is held by caller so no one else can dequeue.
> > -			 * Unlock rx_lock since skb_copy_datagram_iter() may sleep.
> > -			 */
> > -			err = skb_copy_datagram_iter(skb, VIRTIO_VSOCK_SKB_CB(skb)->offset,
> > +			err = skb_copy_datagram_iter(skb, offset,
> > 						     &msg->msg_iter, bytes);
> > 			if (err)
> > 				return err;
> > -
> > 			spin_lock_bh(&vvs->rx_lock);
> > 		}
> > 
> > -		total += skb->len;
> > -		hdr = virtio_vsock_hdr(skb);
> > +		total = msg_len;
> > +		if (eor)
> > +			msg->msg_flags |= MSG_EOR;
> > +	} else {
> > +		skb_queue_walk(&vvs->rx_queue, skb) {
> > +			struct virtio_vsock_hdr *hdr;
> > 
> > -		if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOM) {
> > -			if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOR)
> > -				msg->msg_flags |= MSG_EOR;
> > +			if (total < len) {
> > +				size_t bytes;
> > +				int err;
> > 
> > -			break;
> > +				bytes = len - total;
> > +				if (bytes > skb->len)
> > +					bytes = skb->len;
> > +
> > +				spin_unlock_bh(&vvs->rx_lock);
> > +
> > +				err = skb_copy_datagram_iter(
> > +					skb,
> > +					VIRTIO_VSOCK_SKB_CB(skb)->offset,
> > +					&msg->msg_iter, bytes);
> > +				if (err)
> > +					return err;
> > +
> > +				spin_lock_bh(&vvs->rx_lock);
> > +			}
> > +
> > +			total += skb->len;
> > +			hdr = virtio_vsock_hdr(skb);
> > +
> > +			if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOM) {
> > +				if (le32_to_cpu(hdr->flags) &
> > +				    VIRTIO_VSOCK_SEQ_EOR)
> > +					msg->msg_flags |= MSG_EOR;
> > +				break;
> > +			}
> > 		}
> > 	}
> > 
> > +unlock:
> > 	spin_unlock_bh(&vvs->rx_lock);
> > 
> > 	return total;
> > @@ -740,57 +859,105 @@ static int virtio_transport_seqpacket_do_dequeue(struct vsock_sock *vsk,
> > 	}
> > 
> > 	while (!msg_ready) {
> > -		struct virtio_vsock_hdr *hdr;
> > -		size_t pkt_len;
> > -
> > -		skb = __skb_dequeue(&vvs->rx_queue);
> > +		skb = skb_peek(&vvs->rx_queue);
> > 		if (!skb)
> > 			break;
> > -		hdr = virtio_vsock_hdr(skb);
> > -		pkt_len = (size_t)le32_to_cpu(hdr->len);
> > 
> > -		if (dequeued_len >= 0) {
> > +		if (VIRTIO_VSOCK_SKB_CB(skb)->has_boundary_entries) {
> > 			size_t bytes_to_copy;
> > +			u32 msg_len, offset;
> > +			bool eor;
> > +			int ret;
> > 
> > -			bytes_to_copy = min(user_buf_len, pkt_len);
> > +			ret = vsock_uleb_decode_boundary(
> > +				vvs->boundary_buf + vvs->boundary_off,
> > +				vvs->boundary_len - vvs->boundary_off,
> > +				&msg_len, &eor);
> > +			if (ret < 0)
> > +				break;
> > +			vvs->boundary_off += ret;
> > 
> > -			if (bytes_to_copy) {
> > +			offset = VIRTIO_VSOCK_SKB_CB(skb)->offset;
> > +			bytes_to_copy = min(user_buf_len, (size_t)msg_len);
> > +
> > +			if (bytes_to_copy && dequeued_len >= 0) {
> > 				int err;
> > 
> > -				/* sk_lock is held by caller so no one else can dequeue.
> > -				 * Unlock rx_lock since skb_copy_datagram_iter() may sleep.
> > -				 */
> > 				spin_unlock_bh(&vvs->rx_lock);
> > -
> > -				err = skb_copy_datagram_iter(skb, 0,
> > +				err = skb_copy_datagram_iter(skb, offset,
> > 							     &msg->msg_iter,
> > 							     bytes_to_copy);
> > -				if (err) {
> > -					/* Copy of message failed. Rest of
> > -					 * fragments will be freed without copy.
> > -					 */
> > -					dequeued_len = err;
> > -				} else {
> > -					user_buf_len -= bytes_to_copy;
> > -				}
> > -
> > 				spin_lock_bh(&vvs->rx_lock);
> > +				if (err)
> > +					dequeued_len = err;
> > +				else
> > +					user_buf_len -= bytes_to_copy;
> > 			}
> > 
> > 			if (dequeued_len >= 0)
> > -				dequeued_len += pkt_len;
> > -		}
> > +				dequeued_len += msg_len;
> > 
> > -		if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOM) {
> > +			VIRTIO_VSOCK_SKB_CB(skb)->offset += msg_len;
> > 			msg_ready = true;
> > 			vvs->msg_count--;
> > 
> > -			if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOR)
> > +			if (eor)
> > 				msg->msg_flags |= MSG_EOR;
> > -		}
> > 
> > -		virtio_transport_dec_rx_pkt(vvs, pkt_len, pkt_len);
> > -		kfree_skb(skb);
> > +			virtio_transport_dec_rx_pkt(vvs, msg_len, msg_len);
> > +
> > +			if (VIRTIO_VSOCK_SKB_CB(skb)->offset >= skb->len) {
> > +				__skb_unlink(skb, &vvs->rx_queue);
> > +				kfree_skb(skb);
> > +			}
> > +
> > +			if (vvs->boundary_off >= vvs->boundary_len / 2)
> > +				vsock_boundary_buf_compact(vvs);
> > +		} else {
> > +			struct virtio_vsock_hdr *hdr;
> > +			size_t pkt_len;
> > +
> > +			skb = __skb_dequeue(&vvs->rx_queue);
> > +			if (!skb)
> > +				break;
> > +			hdr = virtio_vsock_hdr(skb);
> > +			pkt_len = (size_t)le32_to_cpu(hdr->len);
> > +
> > +			if (dequeued_len >= 0) {
> > +				size_t bytes_to_copy;
> > +
> > +				bytes_to_copy = min(user_buf_len, pkt_len);
> > +
> > +				if (bytes_to_copy) {
> > +					int err;
> > +
> > +					spin_unlock_bh(&vvs->rx_lock);
> > +					err = skb_copy_datagram_iter(
> > +						skb, 0, &msg->msg_iter,
> > +						bytes_to_copy);
> > +					if (err)
> > +						dequeued_len = err;
> > +					else
> > +						user_buf_len -= bytes_to_copy;
> > +					spin_lock_bh(&vvs->rx_lock);
> > +				}
> > +
> > +				if (dequeued_len >= 0)
> > +					dequeued_len += pkt_len;
> > +			}
> > +
> > +			if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOM) {
> > +				msg_ready = true;
> > +				vvs->msg_count--;
> > +
> > +				if (le32_to_cpu(hdr->flags) &
> > +				    VIRTIO_VSOCK_SEQ_EOR)
> > +					msg->msg_flags |= MSG_EOR;
> > +			}
> > +
> > +			virtio_transport_dec_rx_pkt(vvs, pkt_len, pkt_len);
> > +			kfree_skb(skb);
> > +		}
> > 	}
> > 
> > 	spin_unlock_bh(&vvs->rx_lock);
> > @@ -1132,6 +1299,7 @@ void virtio_transport_destruct(struct vsock_sock *vsk)
> > 
> > 	virtio_transport_cancel_close_work(vsk, true);
> > 
> > +	kfree(vvs->boundary_buf);
> > 	kfree(vvs);
> > 	vsk->trans = NULL;
> > }
> > @@ -1224,6 +1392,11 @@ static void virtio_transport_remove_sock(struct vsock_sock *vsk)
> > 	 * removing it.
> > 	 */
> > 	__skb_queue_purge(&vvs->rx_queue);
> > +	kfree(vvs->boundary_buf);
> > +	vvs->boundary_buf = NULL;
> > +	vvs->boundary_len = 0;
> > +	vvs->boundary_alloc = 0;
> > +	vvs->boundary_off = 0;
> > 	vsock_remove_sock(vsk);
> > }
> > 
> > @@ -1395,23 +1568,62 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
> > 	    !skb_is_nonlinear(skb)) {
> > 		struct virtio_vsock_hdr *last_hdr;
> > 		struct sk_buff *last_skb;
> > +		bool last_has_eom;
> > +		bool has_eom;
> > 
> > 		last_skb = skb_peek_tail(&vvs->rx_queue);
> > 		last_hdr = virtio_vsock_hdr(last_skb);
> > +		last_has_eom = le32_to_cpu(last_hdr->flags) & VIRTIO_VSOCK_SEQ_EOM;
> > +		has_eom = le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOM;
> > 
> > -		/* If there is space in the last packet queued, we copy the
> > -		 * new packet in its buffer. We avoid this if the last packet
> > -		 * queued has VIRTIO_VSOCK_SEQ_EOM set, because this is
> > -		 * delimiter of SEQPACKET message, so 'pkt' is the first packet
> > -		 * of a new message.
> > -		 */
> > -		if (skb->len < skb_tailroom(last_skb) &&
> > -		    !(le32_to_cpu(last_hdr->flags) & VIRTIO_VSOCK_SEQ_EOM)) {
> > -			memcpy(skb_put(last_skb, skb->len), skb->data, skb->len);
> > -			free_pkt = true;
> > -			last_hdr->flags |= hdr->flags;
> > -			le32_add_cpu(&last_hdr->len, len);
> > -			goto out;
> > +		if (skb->len < skb_tailroom(last_skb)) {
> > +			if (!last_has_eom) {
> > +				/* Same-message coalescing (existing path) */
> > +				memcpy(skb_put(last_skb, skb->len),
> > +				       skb->data, skb->len);
> > +				free_pkt = true;
> > +				last_hdr->flags |= hdr->flags;
> > +				le32_add_cpu(&last_hdr->len, len);
> > +				goto out;
> > +			}
> > +
> > +			/* Cross-EOM: coalesce complete messages into one skb,
> > +			 * recording message boundaries in a compact BER buffer.
> > +			 * Only when incoming packet also has EOM (complete msg).
> > +			 */
> > +			if (has_eom && !sk_psock(sk_vsock(vsk))) {
> > +				bool prev_eor, cur_eor;
> > +				u8 tmp[12];
> > +				int n = 0;
> > +
> > +				cur_eor = le32_to_cpu(hdr->flags) &
> > +					  VIRTIO_VSOCK_SEQ_EOR;
> > +
> > +				if (!VIRTIO_VSOCK_SKB_CB(last_skb)->has_boundary_entries) {
> > +					u32 prev_len = le32_to_cpu(last_hdr->len);
> > +
> > +					prev_eor = le32_to_cpu(last_hdr->flags) &
> > +						   VIRTIO_VSOCK_SEQ_EOR;
> > +					n += vsock_uleb_encode_boundary(
> > +						tmp + n, prev_len, prev_eor);
> > +				}
> > +				n += vsock_uleb_encode_boundary(
> > +					tmp + n, len, cur_eor);
> > +
> > +				if (!vsock_boundary_buf_ensure(
> > +					    vvs, vvs->boundary_len + n)) {
> > +					memcpy(vvs->boundary_buf +
> > +					       vvs->boundary_len, tmp, n);
> > +					vvs->boundary_len += n;
> > +					VIRTIO_VSOCK_SKB_CB(last_skb)->has_boundary_entries = true;
> > +					memcpy(skb_put(last_skb, skb->len),
> > +					       skb->data, skb->len);
> > +					free_pkt = true;
> > +					last_hdr->flags |= hdr->flags;
> > +					le32_add_cpu(&last_hdr->len, len);
> > +					goto out;
> > +				}
> > +			}
> > 		}
> > 	}
> > 
> > 


