Return-Path: <netdev+bounces-267391-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ED3vHZXps2l6dAAAu9opvQ
	(envelope-from <netdev+bounces-267391-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 11:40:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B17812819AF
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 11:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4066E30BC5AB
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 10:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B238383C8E;
	Fri, 13 Mar 2026 10:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YMDHa/BB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pNpJjCr3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCC6313E38
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 10:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773398148; cv=none; b=YFa1yoPqu82jNgLfpH7uPWKApn1Jt7AMYg93HYm/xUhcZbOPi3W4rUneBMFVuHaYdNXfACrIdfUPn+j3kzfxHDXNjbALXWbmUJUNJWMvqQGNQO6t9R4ie0wMuRHEH+E63V3BbD1YkUe/LahvXK0F1f4K7LbX2mK+UR1H46N/zt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773398148; c=relaxed/simple;
	bh=7z0hm4a7hoanv0RY2pVTl4DvnYudddqDcFrnhyY4OKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SPPw0ob0hcCr0OgZyGdCZEQlF6mWeo+g88TPTxVovbPfTdV9GS3uCA+sgrO21DZ7HHOHwZujTRHpiE79MJmjI50qNP2q8vV41WKyEkTP9EjOke8t6i16vmaQGz9qjs3xdrpxCDDh80WQHPyHeoTvRTI4ysXwccGzvvKOxbprcjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YMDHa/BB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pNpJjCr3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773398145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UfJ0jyB+2fyankWxKB6Ylq8ejIxryc3Lc5xf0KTbv3o=;
	b=YMDHa/BB983zBP+ugPa2HPr3BIsa74T9AAjTpgG9rV+tEi4nVcl8aXRRfx/Zq8Mv+JHnE9
	CEV86Zan9eKswJEIHjr8HQoMxiFRhBV8XeJ3aFFQbU90vus7++ejddGc/NtiflsbvyVEQx
	ljPiRL+/mnisTGoYW2qXuwdn/zAj2T4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-T0HO6a0aNCyol1qMxxlURw-1; Fri, 13 Mar 2026 06:35:44 -0400
X-MC-Unique: T0HO6a0aNCyol1qMxxlURw-1
X-Mimecast-MFC-AGG-ID: T0HO6a0aNCyol1qMxxlURw_1773398143
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4852fbfc379so24948205e9.0
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 03:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773398143; x=1774002943; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UfJ0jyB+2fyankWxKB6Ylq8ejIxryc3Lc5xf0KTbv3o=;
        b=pNpJjCr3+W8LCBFY1Ew3KfmC5dwdKzOHmHxnUer6bz82VSoaD6E9qa+tpZO7ENdS5S
         K53Km6ZNqljL1Q6uODG9bdWPL4qYK8Kge8JoXgwMJpUIZvLiLr+U/rQHsYJIdzx39U1C
         0Lu8jt5LsUGnRSoGq6OfM2PmuMxuq4UqG1rdcV0unT0hGz634YxKARKl/6Bx0yNZRCPv
         zKobeoZ3DqCGnFDPykcZ51ytoptjiBh32vLImKRlpNyKaklpBDrtmk9mRkRKaRMsNP/r
         Pp9uWWo2Od3NO8WN/4TroH/ntqgy/4AH2bNxOQ351+aIcquHC02ZYhq+S2aycU0Fdcu3
         V0WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773398143; x=1774002943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UfJ0jyB+2fyankWxKB6Ylq8ejIxryc3Lc5xf0KTbv3o=;
        b=hInb2rEVaEzitF97XfcKuHYUkDDyfVowxNtdzv1PY4bYsXhDPLChd20QXD/MIrpjxC
         YPS8atMEvC4jplMwYdUQA2prmKq++DkGWKCd8/IrpwDtBNamle9NAr3V9FeCDik8b1IF
         0LGYzT4bdZveT5DCXdUWW37NrVI8SNpMidClDNGALdRPdLGoeS7kxekQo8prk54VovkT
         nQDNY0ux4mqs4AR8PO8x5oFZH4Rx87JNnsSjFASKzkxFNbu1k7kI+ncYb0DfTLW9pIWV
         yWbgaSSOduGLDhQJK05bGKFzdX9KxC7EF40s3BC9Lgx84qcgAS60MRG4MutsgcnHricS
         QrgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcds3Cs75GlqG7pzodYblqsEdilDcSfwA6jio9Tfe7GraBoGSzkoyrwmqZCvM423TM6BKx83c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjD9G8Y4Dnxwo5Qu3yMszwCF52dPHAVj6zBptnP3AEx4uSFxVR
	jBUflddErmtM8AQoZYdP4vE3WAQ4Up4hiRTXsXo3Ll0CpzmOtZLhLGuVkOuyL9ac8MIALNy6Wiy
	oUpkiYUkpA6BD2iK56RgeVs+PQbvdSpstV9X+8GbirFUDraxjJzgSN6r/1g==
X-Gm-Gg: ATEYQzzbu44S9h+gfvFJrR3N6fbQNv8d06vLYpQpyBNkLHbb923JWkjednzMSoStFRl
	z2XWC+mCPKhiq3Pz6W6TRtJKhaI3wYswzwoYs9GIOciXlA9zQOUwbVBCCaqLBpCekn9QSOL64RK
	oLLdDmCewUVTmuvXy8xrmbrxFuTovIVkGBIwgPm6Ih3RgDzh6EWgtgn9REfe2Z1yMO17cn075we
	5Vsv8Vhr9MHQzB/qUmhDGheU+qQ4aXTl/mNZ3xUJTwyhXhrOVVz79yeDeyfq9VfmmE3tU+IK0JV
	0EeA6O+GQIy96PIB1XvLdKkuDI/ZlTXn/MKuZ7rcD0jNZDIj7jj7DhxbQJRpoq/jZo9cn5wwamF
	zscvVmz/GV/mVoSp9ZQcgiQcaiaDxCt6opf2PgnRpwJj9wA==
X-Received: by 2002:a05:600c:8b45:b0:485:30d4:6b9e with SMTP id 5b1f17b1804b1-48556702853mr41787045e9.21.1773398142899;
        Fri, 13 Mar 2026 03:35:42 -0700 (PDT)
X-Received: by 2002:a05:600c:8b45:b0:485:30d4:6b9e with SMTP id 5b1f17b1804b1-48556702853mr41786485e9.21.1773398142349;
        Fri, 13 Mar 2026 03:35:42 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b5f6c24sm181600925e9.5.2026.03.13.03.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 03:35:41 -0700 (PDT)
Date: Fri, 13 Mar 2026 06:35:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, eperezma@redhat.com,
	leiyang@redhat.com, stephen@networkplumber.org, jon@nutanix.com,
	tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v8 0/4] tun/tap & vhost-net: apply qdisc
 backpressure on full ptr_ring to reduce TX drops
Message-ID: <20260313063350-mutt-send-email-mst@kernel.org>
References: <20260312130639.138988-1-simon.schippers@tu-dortmund.de>
 <20260312095457-mutt-send-email-mst@kernel.org>
 <a12fd0e3-40e9-4da7-9bdb-ae5d30e118b8@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a12fd0e3-40e9-4da7-9bdb-ae5d30e118b8@tu-dortmund.de>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267391-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,lunn.ch,davemloft.net,google.com,kernel.org,networkplumber.org,nutanix.com,tu-dortmund.de,vger.kernel.org,lists.linux.dev];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tu-dortmund.de:url,stackexchange.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B17812819AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 10:49:53AM +0100, Simon Schippers wrote:
> On 3/12/26 14:55, Michael S. Tsirkin wrote:
> > On Thu, Mar 12, 2026 at 02:06:35PM +0100, Simon Schippers wrote:
> >> This patch series deals with tun/tap & vhost-net which drop incoming
> >> SKBs whenever their internal ptr_ring buffer is full. Instead, with this 
> >> patch series, the associated netdev queue is stopped - but only when a
> >> qdisc is attached. If no qdisc is present the existing behavior is
> >> preserved. This patch series touches tun/tap and vhost-net, as they
> >> share common logic and must be updated together. Modifying only one of
> >> them would break the other.
> >>
> >> By applying proper backpressure, this change allows the connected qdisc to 
> >> operate correctly, as reported in [1], and significantly improves
> >> performance in real-world scenarios, as demonstrated in our paper [2]. For 
> >> example, we observed a 36% TCP throughput improvement for an OpenVPN 
> >> connection between Germany and the USA.
> >>
> >> Synthetic pktgen benchmarks indicate a slight regression.
> >> Pktgen benchmarks are provided per commit, with the final commit showing
> >> the overall performance.
> >>
> >> Thanks!
> > 
> > I posted a minor nit on patch 2.
> > 
> > Otherwise LGTM:
> > 
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > thanks for the work!
> 
> Thanks!
> 
> Should I do a new version for the minor nit?

It's easier if you do, yes.

> And how about the ptr_ring race:
> I see there is a seperate discussion for that now. [1]
> Should I wait for that?

If there's a conflict it will be trivial to resolve, so I'd say no.

> Before sending a potential new version I would of course wait for
> Jason's take.
> 
> [1] Link: https://lore.kernel.org/netdev/CANn89iJLC9p+N=Rqtuj7ZuPRdpSGCATCtZdz1Vi9mbzf3ATekQ@mail.gmail.com/
> 
> > 
> > 
> >> [1] Link: https://unix.stackexchange.com/questions/762935/traffic-shaping-ineffective-on-tun-device
> >> [2] Link: https://cni.etit.tu-dortmund.de/storages/cni-etit/r/Research/Publications/2025/Gebauer_2025_VTCFall/Gebauer_VTCFall2025_AuthorsVersion.pdf
> >> [3] Link: https://lore.kernel.org/r/174549940981.608169.4363875844729313831.stgit@firesoul
> >> [4] Link: https://lore.kernel.org/r/176295323282.307447.14790015927673763094.stgit@firesoul
> >>
> >> ---
> >> Changelog:
> >> V8:
> >> - Drop code changes in drivers/net/tap.c; The code there deals with
> >>   ipvtap/macvtap which are unrelated to the goal of this patch series
> >>   and I did not realize that before
> >> -> Greatly simplified logic, 4 instead of 9 commits
> >> -> No more duplicated logics and distinction in vhost required
> >> - Only wake after the queue stopped and half of the ring was consumed
> >>   as suggested by MST
> >> -> Performance improvements for TAP, but still slightly slower
> >> - Better benchmarking with pinned threads, XDP drop program for
> >>   tap+vhost-net and disabling CPU mitigations (and newer Ryzen 5 5600X
> >>   processor) as suggested by Jason Wang
> >>
> >> V7: https://lore.kernel.org/netdev/20260107210448.37851-1-simon.schippers@tu-dortmund.de/
> >> - Switch to an approach similar to veth [3] (excluding the recently fixed 
> >> variant [4]), as suggested by MST, with minor adjustments discussed in V6
> >> - Rename the cover-letter title
> >> - Add multithreaded pktgen and iperf3 benchmarks, as suggested by Jason 
> >> Wang
> >> - Rework __ptr_ring_consume_created_space() so it can also be used after 
> >> batched consume
> >>
> >> V6: https://lore.kernel.org/netdev/20251120152914.1127975-1-simon.schippers@tu-dortmund.de/
> >> General:
> >> - Major adjustments to the descriptions. Special thanks to Jon Kohler!
> >> - Fix git bisect by moving most logic into dedicated functions and only 
> >> start using them in patch 7.
> >> - Moved the main logic of the coupled producer and consumer into a single 
> >> patch to avoid a chicken-and-egg dependency between commits :-)
> >> - Rebased to 6.18-rc5 and ran benchmarks again that now also include lost 
> >> packets (previously I missed a 0, so all benchmark results were higher by 
> >> factor 10...).
> >> - Also include the benchmark in patch 7.
> >>
> >> Producer:
> >> - Move logic into the new helper tun_ring_produce()
> >> - Added a smp_rmb() paired with the consumer, ensuring freed space of the 
> >> consumer is visible
> >> - Assume that ptr_ring is not full when __ptr_ring_full_next() is called
> >>
> >> Consumer:
> >> - Use an unpaired smp_rmb() instead of barrier() to ensure that the 
> >> netdev_tx_queue_stopped() call completes before discarding
> >> - Also wake the netdev queue if it was stopped before discarding and then 
> >> becomes empty
> >> -> Fixes race with producer as identified by MST in V5
> >> -> Waking the netdev queues upon resize is not required anymore
> >> - Use __ptr_ring_consume_created_space() instead of messing with ptr_ring 
> >> internals
> >> -> Batched consume now just calls 
> >> __tun_ring_consume()/__tap_ring_consume() in a loop
> >> - Added an smp_wmb() before waking the netdev queue which is paired with 
> >> the smp_rmb() discussed above
> >>
> >> V5: https://lore.kernel.org/netdev/20250922221553.47802-1-simon.schippers@tu-dortmund.de/T/#u
> >> - Stop the netdev queue prior to producing the final fitting ptr_ring entry
> >> -> Ensures the consumer has the latest netdev queue state, making it safe 
> >> to wake the queue
> >> -> Resolves an issue in vhost-net where the netdev queue could remain 
> >> stopped despite being empty
> >> -> For TUN/TAP, the netdev queue no longer needs to be woken in the 
> >> blocking loop
> >> -> Introduces new helpers __ptr_ring_full_next and 
> >> __ptr_ring_will_invalidate for this purpose
> >> - vhost-net now uses wrappers of TUN/TAP for ptr_ring consumption rather 
> >> than maintaining its own rx_ring pointer
> >>
> >> V4: https://lore.kernel.org/netdev/20250902080957.47265-1-simon.schippers@tu-dortmund.de/T/#u
> >> - Target net-next instead of net
> >> - Changed to patch series instead of single patch
> >> - Changed to new title from old title
> >> "TUN/TAP: Improving throughput and latency by avoiding SKB drops"
> >> - Wake netdev queue with new helpers wake_netdev_queue when there is any 
> >> spare capacity in the ptr_ring instead of waiting for it to be empty
> >> - Use tun_file instead of tun_struct in tun_ring_recv as a more consistent 
> >> logic
> >> - Use smp_wmb() and smp_rmb() barrier pair, which avoids any packet drops 
> >> that happened rarely before
> >> - Use safer logic for vhost-net using RCU read locks to access TUN/TAP data
> >>
> >> V3: https://lore.kernel.org/netdev/20250825211832.84901-1-simon.schippers@tu-dortmund.de/T/#u
> >> - Added support for TAP and TAP+vhost-net.
> >>
> >> V2: https://lore.kernel.org/netdev/20250811220430.14063-1-simon.schippers@tu-dortmund.de/T/#u
> >> - Removed NETDEV_TX_BUSY return case in tun_net_xmit and removed 
> >> unnecessary netif_tx_wake_queue in tun_ring_recv.
> >>
> >> V1: https://lore.kernel.org/netdev/20250808153721.261334-1-simon.schippers@tu-dortmund.de/T/#u
> >> ---
> >>
> >> Simon Schippers (4):
> >>   tun/tap: add ptr_ring consume helper with netdev queue wakeup
> >>   vhost-net: wake queue of tun/tap after ptr_ring consume
> >>   ptr_ring: move free-space check into separate helper
> >>   tun/tap & vhost-net: avoid ptr_ring tail-drop when a qdisc is present
> >>
> >>  drivers/net/tun.c        | 91 +++++++++++++++++++++++++++++++++++++---
> >>  drivers/vhost/net.c      | 15 +++++--
> >>  include/linux/if_tun.h   |  3 ++
> >>  include/linux/ptr_ring.h | 14 ++++++-
> >>  4 files changed, 111 insertions(+), 12 deletions(-)
> >>
> >> -- 
> >> 2.43.0
> > 


