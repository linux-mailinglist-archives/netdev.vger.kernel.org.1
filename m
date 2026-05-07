Return-Path: <netdev+bounces-285440-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gK9/AH/J/GlhTwAAu9opvQ
	(envelope-from <netdev+bounces-285440-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 19:18:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBAA4ECCB6
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 19:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 71EAB30531E4
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 17:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5543C5546;
	Thu,  7 May 2026 17:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tTpGQN2S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BC63C0600;
	Thu,  7 May 2026 17:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778174287; cv=none; b=hZRn/tfLSDeYzW58hHsvPKqES1Nwrr1Ci27qsha831gbeIZTcfWEzSGfoLbSbrK7q1+YQ2D7hfHp73PJngSZEO0Lib9gXgqH1+6gQoJEdycyEFd0cT6QA0uNzuyJ2wJHVIU9RYhdRV8cmPdG0OPzqEgTbGQ537H3sBqS/lcDmaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778174287; c=relaxed/simple;
	bh=B/zuLQ1q9E+1AEh0XFDunDFSi/JVCLzoPkUlnaScRtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rhab7OiVauZQ1RrL4drOFhP8JdDG2HbO7U5mTJVFMTMok0B2biDq7a8q0WPb/ta8NfOpsb5Mj/75nlxeUmiiGzQx7rXByfQJoqArqiQpLFLpNJZcB5X3q3fe1RWYuDaT82Qt0hHSEB6un6n9hVlrRFckh4UMMyoVsKb89xD95/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tTpGQN2S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2546C2BCB2;
	Thu,  7 May 2026 17:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778174287;
	bh=B/zuLQ1q9E+1AEh0XFDunDFSi/JVCLzoPkUlnaScRtQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tTpGQN2SjTmSXYvMjq5Z/SD5evubObIFIeDnvB5yg8lRUUt/5LjtcZ0xlBqk/hdoy
	 05Nzr25++LZHD1Xp8CtFb4B+GO2SmOjd2ENPnXMS5nhz9aPEg/fR4ZyWzonYG3zXWb
	 lkOmh2M9pedjcbPgmQz346AgfqY288grbJvKKn6jZslBEKUgx8Jc5uZ3V+hX9I4wDJ
	 RB6/oxAsXv+TFZsPag77beQKH046T2D34cymoLkAoDUWWMIHxVASnoe9q6naPjNbDv
	 VWXB0fgIAhFYxHm13lAHkD2AEJgKF8cs1bILp8lf1lUYX95BLG5kSS/nSFLAQ9v9iP
	 3d0tMMkxJAimQ==
Date: Thu, 7 May 2026 10:18:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Arseniy Krasnov <avkrasnov@salutedevices.com>, Bobby
 Eshleman <bobbyeshleman@meta.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, Arseniy Krasnov <AVKrasnov@sberdevices.ru>, Jason
 Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio
 =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, kvm@vger.kernel.org,
 virtualization@lists.linux.dev
Subject: Re: [PATCH net] vsock/virtio: fix potential unbounded skb queue
Message-ID: <20260507101805.6c3335d0@kernel.org>
In-Reply-To: <CANn89iJ+qOFPSUACvda7djOVKGM8t+FfwdA5Ymjxe+g_tJtmnA@mail.gmail.com>
References: <20260430122653.554058-1-edumazet@google.com>
	<afn0ZdvZWswBuDMm@sgarzare-redhat>
	<CANn89iLs8DOWJwDpf_ARoMrV+6b2tbhEJ=VVzeC8gCm5dRGaig@mail.gmail.com>
	<afoF_cHfl6ygcupM@sgarzare-redhat>
	<20260506113554-mutt-send-email-mst@kernel.org>
	<afxVH2So9BbZ3Gta@sgarzare-redhat>
	<20260507074113-mutt-send-email-mst@kernel.org>
	<afyMCyBvZpzWrLtO@sgarzare-redhat>
	<20260507073340.0604667d@kernel.org>
	<afyy9CeniTBF3o2I@sgarzare-redhat>
	<CANn89iJ+qOFPSUACvda7djOVKGM8t+FfwdA5Ymjxe+g_tJtmnA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 7FBAA4ECCB6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285440-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,salutedevices.com,meta.com,davemloft.net,kernel.org,vger.kernel.org,gmail.com,sberdevices.ru,linux.alibaba.com,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, 7 May 2026 09:32:24 -0700 Eric Dumazet wrote:
> On Thu, May 7, 2026 at 9:05=E2=80=AFAM Stefano Garzarella <sgarzare@redha=
t.com> wrote:
> > On Thu, May 07, 2026 at 07:33:40AM -0700, Jakub Kicinski wrote: =20
> > >We can revert if you think that the risk of regression is high..
> > >Please LMK soon, we can do it before patch reaches Linus.
> >
> > Some tests in tools/testing/vsock/vsock_test.c are failing with this
> > patch applied.
> >
> > Test 18 are failing sometime in this way (I guess because we are
> > dropping packets):
> >
> > 18 - SOCK_STREAM MSG_ZEROCOPY...hash mismatch
> >
> > Test 22 is failing 100% in this way:
> >
> > 22 - SOCK_STREAM virtio credit update + SO_RCVLOWAT...send failed:
> > Resource temporarily unavailable
> >
> >
> > With my followup patch adding also advertisement to the other peer
> > (still draft locally, waiting for Michael proposal) I saw 22 failing,
> > because tests expects that can use the entire buf_alloc, but now we are
> > reducing it.  So IMO we should do like in `__sock_set_rcvbuf()` and
> > double the buffer size, or at least digest an overhead equal to the
> > buffer size set by the user via SO_VM_SOCKETS_BUFFER_SIZE (yeah,
> > AF_VSOCK has it owns sockopt since the beginning :-().
> >
> > With that approach tests are passing, but I'd like to stress a bit more
> > that patch. I'll send it tomorrow as fixup of this patch, or if you
> > prefer to revert, I'll send as standalone.
>=20
> A plain revert is a big issue, now users now how to crash hypervisors.
>=20
> This vulnerability allows a compromised guest (controlling
> virtio_vsock_hdr fields)
> to continuously flood the host's vsock receive queue without
> triggering any memory
>  accounting limits or reader wakeups, resulting in unbounded host
> kernel memory consumption (Host DoS via OOM).
>=20
> A vulnerability where a KVM guest can crash or deadlock its host is
> classified as a KVM DoS.
>=20
> Am I missing something?

Alright, let's leave it.

