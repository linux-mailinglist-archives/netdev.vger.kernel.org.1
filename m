Return-Path: <netdev+bounces-302232-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yFfsLTupPmp6JwkAu9opvQ
	(envelope-from <netdev+bounces-302232-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 18:30:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 568A56CF15E
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 18:30:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Q9U2onHz;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302232-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302232-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D240630522CD
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 16:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FE03FD125;
	Fri, 26 Jun 2026 16:30:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B763FBEC3
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 16:30:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782491409; cv=none; b=VA7bCSyWtNDdNnTmicNV3y6jh0o0aOGl6juKps52PQpgdc+qJwNk87qqDVLitUNwm1iMprfYvf7cVSL45w/OdiOmeCTolT+Tm5ODlFdtJULGI3/0OhpWgNkj41WjrPvr1bwsIkLXRjWtMRHgn+zPLrzClI1X+BOAxVcwL1dQHmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782491409; c=relaxed/simple;
	bh=cHsycw6Dx/PvvgcoSTksoIIit6mKz6/9Xv9YLA3RYEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S90/h7R05gH8aWr9phh4BNvOp/uG06wsfnbYrFCUhBeNujwIZbvA8BU7zv652xKSzJITtO4MpOyvLw0mAmnMydJZpvmDBtpb68ObpzsHWvx9oNV1KoLMO0mB1YvMVbvlHDAfXSR47VwmxdzmPWKG7JPwwRONd97N66KxFXisTOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q9U2onHz; arc=none smtp.client-ip=74.125.227.132
Received: by mail-pj2-f4.google.com with SMTP id 98e67ed59e1d1-37d4eeb6d43so114587a91.1
        for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 09:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782491406; x=1783096206; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SmvSZXf/ou0b678tcR/y6c76H9T2F/pNhOOOVYqn/aA=;
        b=Q9U2onHzSeDdr6/4Omm0icT039ESYXQe+d/7jidC5cmyeKXFf4XB+X6zvaNDm9/wJJ
         9LiVVLx+5iGUNZEVo0XDynsch9EBo0ktpR/6xhSkDciirQXGw/KYTN5tGuqlbwvhXnQB
         TZNuAxFk6PNVQaGt/XCns3o0SROoGxucAaexuGNjI/XJaFuHJX3YCDPk/KT5opZPasBN
         Q8RqLA4p5RfOGej+3t067xZ/+R2QVI/8aztkFQuNUaQOagzmN1K0QQCHL2tHzpGIccYa
         xCGIj4bFZUYZCalOsdTpY9/pHh+cnZoc4BMzqWMgjc+7Gd5jok9H24TLAtdPgR/vo4M6
         2+yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782491406; x=1783096206;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SmvSZXf/ou0b678tcR/y6c76H9T2F/pNhOOOVYqn/aA=;
        b=CUq3VQ+nWLHzZ3RKgzk4ymYW2Na58waeHId5UtdbD6HB3NOURCPW9DSts5h4NA+H1S
         bDWZMldquKJkLMOR1B+ei4Q45A80fja/fFTuo8DqpESKs5zOYTVIIvwJYX3VWKoq25pP
         /nOWtFbGwyS3ENb7MU/6RdD5S8cg5o6Ts67wjE+X9+J3hSf+wETmcp4dWwrobZiWeGDM
         dPuXaycRgNUWogP7/kGc86zNqy1YiZSixV1mwuBNu203LbAXW4+ThOAE6xcXvr2e5Grr
         o6pm8YkhcWe6OG1f/Dd6XPkGI14HSg17iZnNv2yYedLRmceogg/x8vCfdgCO0ZEoJv9u
         q9WA==
X-Forwarded-Encrypted: i=1; AHgh+Ro2N1kYzc8r68oLIhjXGiFsM9BNO5MAnpUyDa4v82Kal5RKkjrXcmymHP1ay3focgd7JpugHm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIqEt9PPWmeSsYANPWR2Los00ghQifsNRf/UPcOcDzrxFF9vat
	hMfV5g2CV8ENRA/Ruo9CtVGUzpGMQgQfTfC1mJZOl7mAQqI4NBP8LG9m
X-Gm-Gg: AfdE7cn5HcYxY3sh4czqcdnO8aF/VyzYKdyV55DTxfVqq0FIWf7D+sEwyZvWV95kIh8
	uhLVcnr/2QHo+div7QDEol7E0nsJJ9pBrUO5YLyoLiCMw8x7f9kD2Nd3Pl7czrBzHIa0hRtKoO0
	BJPeCtfhY1n+qy/QLFQ7bIpvuJ2qv9O2/RGE3zvu/JOnuFsLrveWWCQPfqf/DqDzVgfb0jWSxCp
	3xKMvDCdO1ePtV4QNsRPZSj7hICC3cmKGziJ1QuOWoBikBtoouf+0k6xlU5ivc4PxDz0713f1eI
	YkweteJNvvf+qeEJqWuJv4/lLNCSVQ+Z95YPA49qx6fLtEKXPgaOKLYRPgOKEcWL0OEO0ZEGXhs
	FDTAb0LxZ1q5eKIAjkLAwdbeSz6cGBOjGcqw5iH08cd+eixaVnN2jHsZ/pymc7q8lbIg2Hqqs5D
	sxd3/meg==
X-Received: by 2002:a17:90b:388a:b0:37e:a09:2640 with SMTP id 98e67ed59e1d1-37f7a5578e1mr953048a91.7.1782491406246;
        Fri, 26 Jun 2026 09:30:06 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:44::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37e132ac1dbsm1496221a91.5.2026.06.26.09.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 09:30:05 -0700 (PDT)
Date: Fri, 26 Jun 2026 09:30:00 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Jason Xing <kerneljasonxing@gmail.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, magnus.karlsson@intel.com, stfomichev@gmail.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, bjorn@kernel.org
Subject: Re: [PATCH net 0/7] xsk: fix AF_XDP multi-buffer Tx descriptor
 reclaim
Message-ID: <aj6n48QAqDP85_-Q@devvm7509.cco0.facebook.com>
References: <20260623133240.1048434-1-maciej.fijalkowski@intel.com>
 <ajv23_r4M3FGrFNN@devvm7509.cco0.facebook.com>
 <ajwHuCp82SazSwKv@boxer>
 <CAL+tcoC789GrOXvvYVOfxhL4iLCdFEAZQ+WCENsMjbLrJnfiYw@mail.gmail.com>
 <aj1O4vKzCuodwgYL@devvm7509.cco0.facebook.com>
 <aj4tUMqAXmQskO6r@boxer>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aj4tUMqAXmQskO6r@boxer>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302232-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,intel.com,kernel.org,redhat.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:maciej.fijalkowski@intel.com,m:kerneljasonxing@gmail.com,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:magnus.karlsson@intel.com,m:stfomichev@gmail.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:bjorn@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:email,vger.kernel.org:from_smtp,devvm7509.cco0.facebook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 568A56CF15E

On 06/26, Maciej Fijalkowski wrote:
> On Thu, Jun 25, 2026 at 09:05:28AM -0700, Stanislav Fomichev wrote:
> > On 06/25, Jason Xing wrote:
> > > On Thu, Jun 25, 2026 at 12:37 AM Maciej Fijalkowski
> > > <maciej.fijalkowski@intel.com> wrote:
> > > >
> > > > On Wed, Jun 24, 2026 at 08:38:20AM -0700, Stanislav Fomichev wrote:
> > > > > On 06/23, Maciej Fijalkowski wrote:
> > > > > > Hi,
> > > > > >
> > > > > > This series fixes several AF_XDP multi-buffer Tx paths where descriptors
> > > > > > consumed from the Tx ring are not consistently returned to userspace
> > > > > > through the completion ring when the packet is later dropped as invalid.
> > > > > >
> > > > > > The affected cases are invalid or oversized multi-buffer Tx packets in
> > > > > > both the generic and zero-copy paths. In these cases, the kernel can
> > > > > > consume one or more Tx descriptors while building or validating a
> > > > > > multi-buffer packet, then drop the packet before it reaches the device.
> > > > > > Userspace still owns the UMEM buffers only after the corresponding
> > > > > > addresses are returned through the CQ. Missing completions therefore
> > > > > > make userspace lose track of those buffers.
> > > > > >
> > > > > > The generic path fixes cover three related cases:
> > > > > > * partially built multi-buffer skbs dropped by xsk_drop_skb();
> > > > > >   continuation descriptors left in the Tx ring after xsk_build_skb()
> > > > > >   reports overflow;
> > > > > > * invalid descriptors encountered in the middle of a multi-buffer
> > > > > >   packet, including the offending invalid descriptor itself.
> > > > > >
> > > > > > The zero-copy path is handled separately. The batched Tx parser now
> > > > > > distinguishes descriptors that can be passed to the driver from
> > > > > > descriptors that are consumed only because they belong to an invalid
> > > > > > multi-buffer packet. Reclaim-only descriptors are written to the CQ
> > > > > > address area and published in completion order, after any earlier
> > > > > > driver-visible Tx descriptors.
> > > > > >
> > > > > > The ZC batching path can also retain drain state when userspace has not
> > > > > > yet provided the end of an invalid multi-buffer packet. To keep this
> > > > > > state local to the singular batched path, the series prevents a second
> > > > > > Tx socket from joining the same pool while such drain state exists.
> > > > > > During the singular-to-shared transition, Tx batching is gated,
> > > > > > pre-existing readers are waited out, and bind fails with -EAGAIN if the
> > > > > > existing socket still has pending drain state. This avoids adding
> > > > > > multi-buffer drain handling to the shared-UMEM fallback path.
> > > > > >
> > > > > > The last two patches update xskxceiver so the tests account invalid
> > > > > > multi-buffer Tx packets as descriptors that must be reclaimed, while
> > > > > > still not expecting those invalid packets on the Rx side.
> > > > > >
> > > > > > This is a follow-up to Jason's changes [0] which were addressing generic
> > > > > > xmit only and this set allows me to pass full xskxceiver test suite run
> > > > > > against ice driver.
> > > > >
> > > > > There is a fair amount of feedback from sashiko already :-( So the meta
> > > > > question from me is: is it time to scrap our current approach where
> > > > > we parse descriptor by descriptor? (and maintain half-baked skb and
> > > > > half-consumed descriptor queues)
> > > > >
> > > > > Should we:
> > > > >
> > > > > 1. do desc[MAX_SKB_FRAGS] and xskq_cons_peek_desc until we exhaust
> > > > > PKT_CONT (if the last packet has PKT_CONT, return EOVERFLOW to userspace
> > > > > and do a full stop here)
> > > > > 2. now that we really know the number of valid descriptors -> reserve
> > > > > the cq space (if not -> EAGAIN)
> > > > > 3. pre-allocate everything here (if at any point we have ENOMEM -> cleanup
> > > > > locally, don't ever create semi-initialized skb)
> > > > > 4. construct the skb
> > > > > 5. xmit
> > > >
> > > > Yeah generic xmit became utterly horrible, haven't gone through sashiko
> > > > reviews yet, but bare in mind this set also aligns zc side to what was
> > > > previously being addressed by Jason.
> > > >
> > > > I believe planned logistics were to get these fixes onto net and then
> > > > Jason had an implementation of batching on generic xmit, directed towards
> > > > -next and that's where we could address current flow.
> > > 
> > > Agreed. That's what I'm hoping for. There would be much more
> > > discussion on how to do batch xmit in an elegant way, I believe.
> > 
> > This doesn't have to depend on the batch rewrite, we should be able to rewrite
> > this non-zc in net, this is still technically fixes, not feature work..
> > 
> > There was already a couple of revisions with this drain_cont approach
> > and every time I look at it feels like the cure is worse than the
> > decease :-( Obviously not gonna stop you from going with the current approach,
> > but these fixes feel a bit of a wasted effort to me (since the bugs keep
> > coming and we are piling more complexity).
> 
> Well this is my fault as I took Jason's patches as-is and did not realize
> Sashiko had issues with it. I *think* I got ZC side almost right so I'd
> like to have at least one last round with trying to make the generic side
> right...

You can have my ack on the series since I already did a few revisions
on the original series from Jason, but it is still a very low confidence
ack:

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

