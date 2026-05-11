Return-Path: <netdev+bounces-286648-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MC4MOyfYAWpMlQEAu9opvQ
	(envelope-from <netdev+bounces-286648-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 15:22:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB3F50ECC3
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 15:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC4DF30393A1
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 13:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DA93E5EEB;
	Mon, 11 May 2026 13:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LMbRv0Vu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nSCVlJZt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3991B87C0
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 13:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778505504; cv=pass; b=hxSO779k0U/yZUL2dzu+U10jX94089VICMILt72Cb7V61swOsgRMkVR5d8lrWqFHBV11elqPp1rwv5Tf7P/tj3kwmLegh6Bt2qSEIRA0i5Ujo9j/ycpuvrelPdjxVYhOENQ3LyPCH/h4Fco62k7PdI2mtwwnDZMoUl3xYalkVrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778505504; c=relaxed/simple;
	bh=8m538UYatqrcDeaeCf1K8yM2CBjU8sYXskeMrAupKZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qOHl3RXrgo+rx7rvNQpMAMGhCG9mZoq0yfCffJD812ssE47RKa9wF1WLc+0Qa5S3mnOZkcedxWS7knTmfjgg6LXEwoPfjVX+YcnaPoeKVVKp3Xzl2jMooAkZSPySU7zuzj5RFkpkJBU8C7f5LHww8xLbRwKBa/o3e2WDENf82hM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LMbRv0Vu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nSCVlJZt; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778505500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z9aUfmwXvJYQvAjJ0YUWxDX2V92YHrSUgYNpiAIF5Vg=;
	b=LMbRv0VulaH+BuHRs2BCKMU2AQ8low3+cVeBrgO8DRQlHDRIxyKoCnock6HBW3pO5x5qUZ
	AwuRoN9FfLTgkMyWODNrnJaIVeM7QlvVp52sz0t+avb7pvNkZKtbU39nEbkjKTujfLTFZb
	HtKGukM6KMxCtTt4eBqh0BhWb9vlg6Q=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-pH2tuLhmM5ONgPl1l8N1VQ-1; Mon, 11 May 2026 09:18:13 -0400
X-MC-Unique: pH2tuLhmM5ONgPl1l8N1VQ-1
X-Mimecast-MFC-AGG-ID: pH2tuLhmM5ONgPl1l8N1VQ_1778505491
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-7bdf99ee592so96519227b3.0
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 06:18:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778505491; cv=none;
        d=google.com; s=arc-20240605;
        b=iaZvAWhc22u4j3U5BdQaZP7tzbX7BwASwpl9KldRjcbosdKd564UYFUudnN/Lnlo5R
         HbGYqo2gCfRntQd4Q//XAo2phBPfyiPzjsPiGLrh1jmjcqNLH+VXZxuLOe8Hqmgt4H0O
         AK7s4gPVU0+vpbW3szLIz6I1ZW/fLlzpArYcEEnS7X1oa/wM8l+vLniKn2Jo4H61vAPN
         u/uVJgMvNFiGgdCqF1g7BWJMOjszhm+5goJ9DoJdRNEXt/SEnhK4tg64YGOrStgMYITW
         e9ipgFNDtVJZ27AHMud/s6YGk/cmUWGMrpgfdV2DBrxFLyAp5Jc2IfNSpFmPLfIY5Cdb
         IK+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=z9aUfmwXvJYQvAjJ0YUWxDX2V92YHrSUgYNpiAIF5Vg=;
        fh=u95pctiq8HRjCiTEKMbYMHMb1wm0gGVTvkc293D0Muk=;
        b=GSSNEm3vCsQtXCATa0NAn53t47eUkHS7FZUyHVB5u+4drs+YbDj/848KPsCmX8jtLe
         3LQEtU6JbWtr9QknA8+UCydTpTNyUCz1HgVp839/Ef/qpmdwMGJwQwW+5IM1wc8wC3uY
         9APc8RX5OIqYYHCr/OSok6qe2vQkVRIFPF6r31mtvVpQNFDKxWKBjc/72zzy8DaFFH+U
         lQl/la6Rd+1F8WkPqONIh1wMoLyYhVF5O5upKbJo7KUxP/IUrXLII9Oqvw/X/6DdQHFm
         E33d/r4PdMF9E04IqUAmuNwEdPLlSvGd4brbHUpSkA8kNRHtUBANxhKxR/qIysQSnaJK
         fybA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778505491; x=1779110291; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z9aUfmwXvJYQvAjJ0YUWxDX2V92YHrSUgYNpiAIF5Vg=;
        b=nSCVlJZtLnl3MK07OMC8YwPpdBxtJ+2vQ16MyCVkKia/GqoOGOh86HzYdWYPWI2d7c
         +kIFHnm4bYMdNYSVRZWEIY/Z5K5uFXXsFVm92YBSv5rocZPzkZ5DtsPdsjZ8psjNgUkS
         kEfOACVg67FkPlQjjt0m8k9u+qgV05cpb12mc6yWXY7txgFF/e/U8321PV4ODJ9suU7C
         pNrs12sK93si1ne8WFtk2Ovdj7T6iVPQ3wEIAo0ccFDRPk2Cz5GOvNJv5maXDPZQASSz
         nznQ6Ujbyc1l2aEbC0jWJJ3ssV73YZ5XFzVTDLUqigNvhpVNKHsS4d0q0fynM6lVp9Nn
         K+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778505491; x=1779110291;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9aUfmwXvJYQvAjJ0YUWxDX2V92YHrSUgYNpiAIF5Vg=;
        b=JkYdrlYBRq/83Dsd74W8JgxDZ1+Xw5D+zWmAsW2U5tO0PygDz2I6PQKWE+7d+QzTKG
         oCD0gv7sZf/eTpUExSHhhrPOEI7RCCmzSrczpmmObtjkNp1r+A6W15zxQhSY8teUGNHQ
         Nym6qr1cLfP18p+NjHVDwAXgu65EeibOBrMUUVO09Orz81FdS5KWteBUw2ZC+VSHQ3nU
         wWizULnWrqJfQmLkK1V4t3vH6eaxYC6wMzqFY0/jgzfHim0MgfA8UQLWJz21irlNSG3d
         4aNxXP2hAPUusUMHPqsKnPBw9K0dYpY5IJ3a7RG5+QoFr96pqvbA0Kcmcm+I60nOeFnp
         UlBg==
X-Gm-Message-State: AOJu0YwO//qx/R32i2vTM6pm7uTNnS3oF3PaP2ZKzN5CtikS/9jsPOAG
	WyHnsX4A7nm7CHBUzQnJzAmQcVnR3LsUFh1KT1+N6KM3pWl0jZO/pZPxL+gyP8HCKJSbEle7xGZ
	cVGmcV9ceo4E6gmZ/8Cki6dlkJjfxWFU5FIO+aQl3pyOXjLxsEqDInB/PBCWzOUU3v5H1GMWl6D
	Q802+ncy8L5Cua1KZ7M4ub5+wHGgod5J7W
X-Gm-Gg: Acq92OGIv2FVBR+luxPN3GDIL5IzX05V3lblX6ALVYqSrR4C6lyQyjrJxKYpgjm8J/d
	UzkaVzfg8Dwmedn2CiQU3qekItNoDC5xSqQr0Z5lGxyVG0HAoso2X9VzA0OMOhm7K9EEEG2k/Tg
	Usegb30vZ6Dt5jbOz3pXkYe94TwdH6V8yFcMmMRk/fc5NzP0QkXHfBCb3gtwaqDkwG1U9AwxGGq
	nr1j+7Bfn0/3Qnl
X-Received: by 2002:a05:690c:d95:b0:7ba:f0ed:c5a6 with SMTP id 00721157ae682-7bdf5e02b03mr239670637b3.15.1778505490910;
        Mon, 11 May 2026 06:18:10 -0700 (PDT)
X-Received: by 2002:a05:690c:d95:b0:7ba:f0ed:c5a6 with SMTP id
 00721157ae682-7bdf5e02b03mr239670197b3.15.1778505490349; Mon, 11 May 2026
 06:18:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508092330.69690-1-sgarzare@redhat.com> <20260508055125-mutt-send-email-mst@kernel.org>
 <af2y2Fyp7H-om-ur@sgarzare-redhat> <20260508063104-mutt-send-email-mst@kernel.org>
 <af28MAV0LF4qHVmB@sgarzare-redhat> <CAGxU2F65pw0P1uKOOJpBc4p6KjCz8iePEh9aPybUyECBm1=otg@mail.gmail.com>
 <20260511084551-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260511084551-mutt-send-email-mst@kernel.org>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Mon, 11 May 2026 15:17:56 +0200
X-Gm-Features: AVHnY4L6LnZli-Ox_nOVNet2zhzvaOzPcipKZYQZqFtNKms-_nGPKvzOHkJ7hsQ
Message-ID: <CAGxU2F6TPfRxZ7SX20vXiqDM4_sY3yUQBUSfEM=Nr+TKXwT9mA@mail.gmail.com>
Subject: Re: [PATCH net] vsock/virtio: fix skb overhead accounting to preserve
 full buf_alloc
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, 
	"David S. Miller" <davem@davemloft.net>, Jason Wang <jasowang@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, kvm@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 5BB3F50ECC3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286648-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, 11 May 2026 at 14:46, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, May 11, 2026 at 12:54:44PM +0200, Stefano Garzarella wrote:
> > On Fri, 8 May 2026 at 12:38, Stefano Garzarella <sgarzare@redhat.com>
> > wrote:
> > >
> > > On Fri, May 08, 2026 at 06:33:13AM -0400, Michael S. Tsirkin wrote:
> > > >On Fri, May 08, 2026 at 12:01:50PM +0200, Stefano Garzarella wrote:
> > > >> On Fri, May 08, 2026 at 05:53:07AM -0400, Michael S. Tsirkin wrote:
> > > >> > On Fri, May 08, 2026 at 11:23:30AM +0200, Stefano Garzarella wrote:
> > > >> > > From: Stefano Garzarella <sgarzare@redhat.com>
> > > >> > >
> > > >> > > After commit 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb
> > > >> > > queue"), virtio_transport_inc_rx_pkt() subtracts per-skb overhead from
> > > >> > > buf_alloc when checking whether a new packet fits. This reduces the
> > > >> > > effective receive buffer below what the user configured via
> > > >> > > SO_VM_SOCKETS_BUFFER_SIZE, causing legitimate data packets to be
> > > >> > > silently dropped and applications that rely on the full buffer size
> > > >> > > to deadlock.
> > > >> > >
> > > >> > > Also, the reduced space is not communicated to the remote peer, so
> > > >> > > its credit calculation accounts more credit than the receiver will
> > > >> > > actually accept, causing data loss (there is no retransmission).
> > > >> > >
> > > >> > > This also causes failures in tools/testing/vsock/vsock_test.c.
> > > >> > > Test 18 sometimes fails, while test 22 always fails in this way:
> > > >> > >     18 - SOCK_STREAM MSG_ZEROCOPY...hash mismatch
> > > >> > >
> > > >> > >     22 - SOCK_STREAM virtio credit update + SO_RCVLOWAT...send failed:
> > > >> > >     Resource temporarily unavailable
> > > >> > >
> > > >> > > Fix this by introducing virtio_transport_rx_buf_size() to calculate the
> > > >> > > size of the RX buffer based on the overhead. Using it in the acceptance
> > > >> > > check, the advertised buf_alloc, and the credit update decision.
> > > >> > > Use buf_alloc * 2 as total budget (payload + overhead), similar to how
> > > >> > > SO_RCVBUF is doubled to reserve space for sk_buff metadata.
> > > >> > > The function returns buf_alloc as long as overhead fits within the
> > > >> > > reservation, then gradually reduces toward 0 as overhead exceeds
> > > >> > > buf_alloc (e.g. under small-packet flooding), informing the peer to
> > > >> > > slow down.
> > > >> > >
> > > >> > > Fixes: 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue")
> > > >> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > >> >
> > > >> >
> > > >> > unfortunately, this is a bit of a spec violation and there is no guarantee
> > > >> > it helps.
> > > >>
> > > >> Loosing data like we are doing in 059b7dbd20a6 is even worse IMHO.
> > > >>
> > > >> >
> > > >> > a spec violation because the spec says:
> > > >> > Only payload bytes are counted and header bytes are not
> > > >> > included
> > > >> >
> > > >> > and the implication is that a side can not reduce its own buf_alloc.
> > > >> >
> > > >> > no guarantee because the other side is not required to process your
> > > >> > packets, so it might not see your buf alloc reduction.
> > > >> >
> > > >> > as designed in the current spec, you can only increase your buf alloc,
> > > >> > not decrease it.
> > > >>
> > > >> We never enforced this, currently an user can reduce it by
> > > >> SO_VM_SOCKETS_BUFFER_SIZE and we haven't blocked it since virtio-vsock was
> > > >> introduced, should we update the spec?
> > > >
> > > >
> > > >it's not that we need to enforce it, it's that all synchronization
> > > >assumes this. as in, anyone can use an old copy until they run out
> > > >of credits.
> > > >
> > > >
> > > >> >
> > > >> > what can be done:
> > > >> > - more efficient storage for small packets (poc i posted)
> > > >> > - reduce buf alloc ahead of the time
> > > >>
> > > >> That's basically what I'm doing here: I'm using twice the size of
> > > >> `buf_alloc` (just like `SO_RCVBUF` does for other socket types) and telling
> > > >> the other peer just `buf_alloc`.
> > > >>
> > > >> But then, somehow, we have to let the other person know that we're running
> > > >> out of space. With this patch that only happens when the other peer isn't
> > > >> behaving properly, sending so many small packets that the overhead exceeds
> > > >> `buf_alloc`.
> > > >>
> > > >> Stefano
> > > >
> > > >what is "not proper" here, it is up to the application what to send.
> > >
> > > Sure, but here we're just slowing down the application by telling it we
> > > don't have any more space.
> > >
> > > Again, without this patch we are just dropping data, which IMO is even
> > > worse.
> > >
> > > So I think we should merge this for now, while we handle better the EOM.
> > > If you prefer, I can drop the part where we reduce the buf_alloc
> > > advertised to the other peer, but at least we should drop data after
> > > `buf_alloc * 2` IMO.
> >
> > Okay, I thought it over over the weekend, and I agree that this patch
> > still doesn't solve the problem and would still result in packet loss.
> > So, until we resolve the issue permanently, and since 059b7dbd20a6 is
> > coming to stable, I'd like to rework this patch so that we only start
> > dropping packets when the overhead plus the queued bytes exceeds
> > `buf_alloc * 2`.
> > Removing the other changes to reduce the buf_alloc advertised, but
> > terminating the connection so that both peers are aware that something
> > went wrong.
> >
> > Any objections?
> >
> > Stefano
>
> Let's try to first fix it upstream properly please. Discuss backporting
> later.

Commit 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb
queue") is already in Linus tree and will land soon on stable. Which
issue do you see on having a patch on top of that to close the
connection instead of losing data and breaking our test suite?

IMO we need that change in any case, because the previous code also
discarded packets without any notification, whereas breaking the
connection would be better in that case.

Stefano


