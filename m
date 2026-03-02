Return-Path: <netdev+bounces-262463-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBnVFKvdpGmSugUAu9opvQ
	(envelope-from <netdev+bounces-262463-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 01:45:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C111D1D22A6
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 01:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 42A153012CCD
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 00:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4447B221721;
	Mon,  2 Mar 2026 00:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gwkNQ3Fq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ehIn3Uke"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5971DD889
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 00:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772412325; cv=none; b=k2G1N5bkFB8A8z7UA1poKolaQ2MiIPV/aIJoKL4Ixv/cAXssheSi2c3WkVXZDCXvRUsQqeCNB6QigX+hOiAJVBZoHgeBQm3oNTjUsR5CIkkKeffvjytoCjVIlWD+Innlyu19qpoMdBX/v9lm+3eUDWNo2RINUOTARZUaTcZgxEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772412325; c=relaxed/simple;
	bh=4u5xVp5TnwLZTh7dIRHY4bKsceG8AE3TAWJalgr5Ac4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQy0JMNqmpRfUVr1RS5VrYC/BIM/IHIBbNafChsXebT5fKSaYwmHqFsbhNE+WeBvUmO3ynMHk8lJbA2RvleYhV1a9si3rMQMnWu1qZNTuNPh6VFfYYM+dFVjnsJZrENh2n1lidS1mNvnFLPlrvU0g7iO91hahWmn5uUcEFhdrBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gwkNQ3Fq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ehIn3Uke; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772412322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vv0k8lngNVzpQy1IMYA5foV0UbEwsl2jdcB0vqaVFDY=;
	b=gwkNQ3FqcL0Cd5mGxaD9VaCMRPLyVRjVIFmrmOYo8dakHRBJxifiRkKrocM70BxIYnmtIg
	DmF7AmKjA9KQID/b3PnaTVX1cA+jdCdHkeh4y+9apKFGIvnR2U5LNn/mNsPFyl7GQegThu
	H5ATxYXJoBmVUrFE2w7a6bvZn0b44Mo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-zNMvoTdxM66bfosKoeQPNQ-1; Sun, 01 Mar 2026 19:45:19 -0500
X-MC-Unique: zNMvoTdxM66bfosKoeQPNQ-1
X-Mimecast-MFC-AGG-ID: zNMvoTdxM66bfosKoeQPNQ_1772412318
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-439b4e653d2so441598f8f.1
        for <netdev@vger.kernel.org>; Sun, 01 Mar 2026 16:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772412318; x=1773017118; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vv0k8lngNVzpQy1IMYA5foV0UbEwsl2jdcB0vqaVFDY=;
        b=ehIn3Uked6EUx+JwUEzwdVjjTeDKSuWu7QcMsa2CqsjY/O1ol4fxJmzvLfXSqtz9e4
         eKdsGgNE4gGRu4uWkylQFo3OR6IPlInbwMRP0F93HX5ne8HcG4IW5n0EBdJHQmfI+TU1
         cepv+0z/mNKQeEKVo8sbJzF/YDhXrOBfvVaQuXA/0lgRt6ta5N+ekGoM/cMfMY0V6mXk
         BL9zO7G0GPURzyG+PLHjATPwh9h8RhM3tkOXCmqJ4lujBjSMS1TsU5mZGvFUlIW2ETFl
         eKyeb2xUoPd/tsTxb5JWjlpyuZKtbn4FF/8ZDQbo9c3suQDSVIDqV+cPMb3s3fRK6mEu
         0NSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772412318; x=1773017118;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vv0k8lngNVzpQy1IMYA5foV0UbEwsl2jdcB0vqaVFDY=;
        b=oy0zovNRu/UFWSXmm+sCDpk5HS1COT3dtA0xS3IeCt+XxYr3bdqKT6ECOnYoCzEXfj
         Vd1DmQZcRoKqLw5sF1rGMdETfIMQxGrdDqaWsZwloyGZCphp/sZal8KQuXUZ1o5CXkt4
         UF+33okXJFQSMPd+uArAZit6iYyizvy2z7IYaGwpS4MwNPC/x0Bjhe/1kH/PrZbhm2GJ
         TepjVa/XDltSVraCLJbUpEtjXySW3JjXdAa4GCBBoEjOVSI4DshvDgyCVYmRYumSff21
         wU8Fu5uHMtmM6ggSeG/xYn6sTvAa/o9mqfk+CSOI1+o+OyPmisLCGmUsTUzj2LLs6FOV
         02cQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgGqB7YIL02Efc3UQbrMF3CMSw7kDEpgLEPyuZjtMF1ge+OK0UWUyxW7B5CUB/CZf63ing/Po=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb9y1NXElf/c2y/qn3Sy8XDY53RbITSBsc0uMpkQkhaiU7csPt
	lWxHL38o/dwOvUptEWG9wEmkGjb5UO7yK2fK0XvjQYOSY1pAqR61GXr1ZzCc/dB9A2hGNutfBpH
	aTpz/hUlZ+yAXqNeT/K/RlsikO29w2WEHEYICiPtKfyW8J7q4Pd8OJva4+Q==
X-Gm-Gg: ATEYQzzdaQw0Rk7wzsZXObWiLUB5kXQxG7XzTb1l+tC3gIkLHg4eEd6zb/OpNZemg79
	7CDl9lT/ZkuFDEVirWDuhF6vYdLi592UccgpCDOt0wBt1cx2LsiPH6gSFlE37zssG8mhZL/uraJ
	tFNe6xRNRTBD9P1WyYAYIA7BtxCvWu+tTrELhbOqMmFe7S/DkoUsfMSjWdmjDedVEIAAp8yUNKD
	Uq9Qi9ToKrwgOaSr+KP/5sBgDepCaaDptN8ti2DdjobT7L4E1RDLv0vrj2q+38KP7H9Tpwhc5PX
	Xq837zQ7q1dDSD5i4jXPgKYsqa2YWociGOCjvISRd0j8f16CK7FeawuQwKtLVpzEukpj5u8C2du
	BjOWVUpxgTqNAbJaj9WZXBKbFpXKk7NjmFYnsuQhuc9D4ZQ==
X-Received: by 2002:a05:600c:530c:b0:483:afbb:a077 with SMTP id 5b1f17b1804b1-483c9b971a3mr177121105e9.1.1772412318363;
        Sun, 01 Mar 2026 16:45:18 -0800 (PST)
X-Received: by 2002:a05:600c:530c:b0:483:afbb:a077 with SMTP id 5b1f17b1804b1-483c9b971a3mr177120815e9.1.1772412317848;
        Sun, 01 Mar 2026 16:45:17 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd6f2f88sm357274885e9.2.2026.03.01.16.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 16:45:17 -0800 (PST)
Date: Sun, 1 Mar 2026 19:45:15 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: ShuangYu <shuangyu@yunyoo.cc>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [BUG] vhost_net: livelock in handle_rx() when GRO packet exceeds
 virtqueue capacity
Message-ID: <20260301194456-mutt-send-email-mst@kernel.org>
References: <9ac0a071e79e9da8128523ddeba19085f4f8c9aa.decbd9ef.1293.41c3.bf27.48cdc12b9ce6@larksuite.com>
 <20260301190906-mutt-send-email-mst@kernel.org>
 <20260301193655-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260301193655-mutt-send-email-mst@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262463-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C111D1D22A6
X-Rspamd-Action: no action

On Sun, Mar 01, 2026 at 07:39:30PM -0500, Michael S. Tsirkin wrote:
> On Sun, Mar 01, 2026 at 07:10:06PM -0500, Michael S. Tsirkin wrote:
> > On Sun, Mar 01, 2026 at 10:36:39PM +0000, ShuangYu wrote:
> > > Hi,
> > > 
> > > We have hit a severe livelock in vhost_net on 6.18.x. The vhost
> > > kernel thread spins at 100% CPU indefinitely in handle_rx(), and
> > > QEMU becomes unkillable (stuck in D state).
> > > [This is a text/plain messages]
> > > 
> > > Environment
> > > -----------
> > >   Kernel:  6.18.10-1.el8.elrepo.x86_64
> > >   QEMU:    7.2.19
> > >   Virtio:  VIRTIO_F_IN_ORDER is negotiated
> > >   Backend: vhost (kernel)
> > > 
> > > Symptoms
> > > --------
> > >   - vhost-<pid> kernel thread at 100% CPU (R state, never yields)
> > >   - QEMU stuck in D state at vhost_dev_flush() after receiving SIGTERM
> > >   - kill -9 has no effect on the QEMU process
> > >   - libvirt management plane deadlocks ("cannot acquire state change lock")
> > > 
> > > Root Cause
> > > ----------
> > > The livelock is triggered when a GRO-merged packet on the host TAP
> > > interface (e.g., ~60KB) exceeds the remaining free capacity of the
> > > guest's RX virtqueue (e.g., ~40KB of available buffers).
> > > 
> > > The loop in handle_rx() (drivers/vhost/net.c) proceeds as follows:
> > > 
> > >   1. get_rx_bufs() calls vhost_get_vq_desc_n() to fetch descriptors.
> > >     It advances vq->last_avail_idx and vq->next_avail_head as it
> > >     consumes buffers, but runs out before satisfying datalen.
> > > 
> > >   2. get_rx_bufs() jumps to err: and calls
> > >     vhost_discard_vq_desc(vq, headcount, n), which rolls back
> > >     vq->last_avail_idx and vq->next_avail_head.
> > > 
> > >     Critically, vq->avail_idx (the cached copy of the guest's
> > >     avail->idx) is NOT rolled back. This is correct behavior in
> > >     isolation, but creates a persistent mismatch:
> > > 
> > >       vq->avail_idx      = 108  (cached, unchanged)
> > >       vq->last_avail_idx = 104  (rolled back)
> > > 
> > >   3. handle_rx() sees headcount == 0 and calls vhost_enable_notify().
> > >     Inside, vhost_get_avail_idx() finds:
> > > 
> > >       vq->avail_idx (108) != vq->last_avail_idx (104)
> > > 
> > >     It returns 1 (true), indicating "new buffers available."
> > >     But these are the SAME buffers that were just discarded.
> > > 
> > >   4. handle_rx() hits `continue`, restarting the loop.
> > > 
> > >   5. In the next iteration, vhost_get_vq_desc_n() checks:
> > > 
> > >       if (vq->avail_idx == vq->last_avail_idx)
> > > 
> > >     This is FALSE (108 != 104), so it skips re-reading the guest's
> > >     actual avail->idx and directly fetches the same descriptors.
> > > 
> > >   6. The exact same sequence repeats: fetch -> too small -> discard
> > >     -> rollback -> "new buffers!" -> continue. Indefinitely.
> > > 
> > > This appears to be a regression introduced by the VIRTIO_F_IN_ORDER
> > > support, which added vhost_get_vq_desc_n() with the cached avail_idx
> > > short-circuit check, and the two-argument vhost_discard_vq_desc()
> > > with next_avail_head rollback. The mismatch between the rollback
> > > scope (last_avail_idx, next_avail_head) and the check scope
> > > (avail_idx vs last_avail_idx) was not present before this change.
> > > 
> > > bpftrace Evidence
> > > -----------------
> > > During the 100% CPU lockup, we traced:
> > > 
> > >   @get_rx_ret[0]:      4468052   // get_rx_bufs() returns 0 every time
> > >   @peek_ret[60366]:    4385533   // same 60KB packet seen every iteration
> > >   @sock_err[recvmsg]:        0   // tun_recvmsg() is never reached
> > > 
> > > vhost_get_vq_desc_n() was observed iterating over the exact same 11
> > > descriptor addresses millions of times per second.
> > > 
> > > Workaround
> > > ----------
> > > Either of the following avoids the livelock:
> > > 
> > >   - Disable GRO/GSO on the TAP interface:
> > >      ethtool -K <tap> gro off gso off
> > > 
> > >   - Switch from kernel vhost to userspace QEMU backend:
> > >      <driver name='qemu'/> in libvirt XML
> > > 
> > > Bisect
> > > ------
> > > We have not yet completed a full git bisect, but the issue does not
> > > occur on 6.17.x kernels which lack the VIRTIO_F_IN_ORDER vhost
> > > support. We will follow up with a Fixes: tag if we can identify the
> > > exact commit.
> > > 
> > > Suggested Fix Direction
> > > -----------------------
> > > In handle_rx(), when get_rx_bufs() returns 0 (headcount == 0) due to
> > > insufficient buffers (not because the queue is truly empty), the code
> > > should break out of the loop rather than relying on
> > > vhost_enable_notify() to make that determination. For example, when
> > > get_rx_bufs() returns r == 0 with datalen still > 0, this indicates a
> > > "packet too large" condition, not a "queue empty" condition, and
> > > should be handled differently.
> > > 
> > > Thanks,
> > > ShuangYu
> > 
> > Hmm. On a hunch, does the following help? completely untested,
> > it is night here, sorry.
> > 
> > 
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index 2f2c45d20883..aafae15d5156 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -1522,6 +1522,7 @@ static void vhost_dev_unlock_vqs(struct vhost_dev *d)
> >  static inline int vhost_get_avail_idx(struct vhost_virtqueue *vq)
> >  {
> >  	__virtio16 idx;
> > +	u16 avail_idx;
> >  	int r;
> >  
> >  	r = vhost_get_avail(vq, idx, &vq->avail->idx);
> > @@ -1532,17 +1533,19 @@ static inline int vhost_get_avail_idx(struct vhost_virtqueue *vq)
> >  	}
> >  
> >  	/* Check it isn't doing very strange thing with available indexes */
> > -	vq->avail_idx = vhost16_to_cpu(vq, idx);
> > -	if (unlikely((u16)(vq->avail_idx - vq->last_avail_idx) > vq->num)) {
> > +	avail_idx = vhost16_to_cpu(vq, idx);
> > +	if (unlikely((u16)(avail_idx - vq->last_avail_idx) > vq->num)) {
> >  		vq_err(vq, "Invalid available index change from %u to %u",
> >  		       vq->last_avail_idx, vq->avail_idx);
> >  		return -EINVAL;
> >  	}
> >  
> >  	/* We're done if there is nothing new */
> > -	if (vq->avail_idx == vq->last_avail_idx)
> > +	if (avail_idx == vq->avail_idx)
> >  		return 0;
> >  
> > +	vq->avail_idx == avail_idx;
> > +
> 
> meaning 
> 	vq->avail_idx = avail_idx; 
> of course
> 
> >  	/*
> >  	 * We updated vq->avail_idx so we need a memory barrier between
> >  	 * the index read above and the caller reading avail ring entries.


and the change this is fixing was done in d3bb267bbdcba199568f1325743d9d501dea0560

-- 
MST


