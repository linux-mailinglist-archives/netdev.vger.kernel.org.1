Return-Path: <netdev+bounces-276327-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aA2kNkAE1mnbAQgAu9opvQ
	(envelope-from <netdev+bounces-276327-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 09:31:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B1E3B8397
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 09:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BDE2300B609
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 07:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E33352C5B;
	Wed,  8 Apr 2026 07:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nA3V4Y+7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E826717A300
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 07:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775633466; cv=pass; b=k2cDmFTyzIWYY0zgD2/RWdTXegx0nPf/R0eSX+MBJJQL3ABn8E4dDfB5me5WwJW5ZJp17w8Qt99ahigKMXV2ZmbyQlhjZeGg0BPRwI0NRjkryxNfvXNCOeL6eBMERac+PD4VM/ZuMzlLrio7HEwyQETPGunirFQnTMHJy5Wg/os=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775633466; c=relaxed/simple;
	bh=CeA6uYKOa9sqRJ+MQyCP23Joz9YR2D1UWj7MkNiwvrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AVU8mEBd7PYrJ2ho/OMdlBqSeTKZ3HdbZMz9+PtvjMsmh/U1Qd6EggryaK6+29tiOUOV+tcS0Cc96ooMzu2JVaA0hsQhAQk2uneiDJUzHFgN6i8OZmht/c82WiC1ryZacPIKJagNg7fhXWWCRaD2mY7oe1bD16evBvonH3I+nBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nA3V4Y+7; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a283c44478so6690537e87.3
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 00:31:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775633463; cv=none;
        d=google.com; s=arc-20240605;
        b=S+aONT2k4SxBLgYgZc+YKEf0MP0mlidSNS3EW53RT9vd/RB8V0kGySECFurc95woRP
         K2h87zeHBRVl1FVhT8/O3EqAyH5gwnq1p2cx3PPy4SDG2F92wwIqg+AVcj8qGTUBPYTd
         64mbqjs6Z5KbyrIZ+MAcO7hpNaOjuQ3HObFKqhs3csdsVFb+0FIanX53pwrZV6fNRrny
         p0NwkA+6MSCLqVCmq04tzcKhoq7qu46TLBDq2dyO58IEZ3VmsCHhUnjacC9j54pQwgVF
         CzX6FFx+w4VAW62QmlLkA9lfAN0728HngGq2+NgPECyQ0h95aOnZQS7M26wvoX8JlZPH
         /WMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QHN/+v66yc0A89NHJH+2Y3ZhjzBVXfkm+kEWhWOJlLw=;
        fh=OiWpZE0hr7Sp88qk4Wv4vjk5De32iyhIlKoPOs0gDPo=;
        b=SKMpU8nFJvYXdkm93KBneKrgDzUIaf/CrhRnBZ+a06xI2fJ7743WRl6fku8r7yejMG
         KJ7keoAaHr3Mzah8DlgJTx7T9NBDrRKfN9Ce+XXV/qpvxHYV+abpl07IGgkPZaFrvEG6
         f8WgYeJffRmH4GU/l+MISpjGAu1PKERhxW0EyvlWlA3egUVq5Tkt2dPp4jCSkAuMbhcA
         AJCnFiElzQAPjYPrhO0/Mj3ytMse7WlnBNhScDTSmeW4Doi7sYEpnlGQ41NSAEPKI5lD
         1LzZiPb69wpwN3PdyGPrxLNrS3+jxG4ayUDdPNtD5lthRtnswGqeljQxGd/XSl3hOMrH
         CF/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775633463; x=1776238263; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QHN/+v66yc0A89NHJH+2Y3ZhjzBVXfkm+kEWhWOJlLw=;
        b=nA3V4Y+7NhmNK/hsfXPp/WrVVMuQEIIPJ9N3LQ5p8xUf5VFRqSvJ7ZTxT3uMJqkOxg
         lFWkEE63E9VoAV/SbYZxb/IR3CscNrSCoFcqGetAWsndi7cFfNIQhfROj0gzVVVyB1ow
         oGB+Bu4OSN6d8FnciSP+fa5tw2LWntsPRUZOBP7Z6LpRSNzHJUWl6m+JwthW8KDAHlwW
         sxJEWMcL2BAFnhOAipzVY2gt7I9izxPaXl2o+0xzgVzyuUgQysuQEvm0IEDOnvYfjLt6
         p0a9sGnpLbWi8mCTErZ30sLJnLXitc9jJ8UKs6wKT5eLkvovUfr98e34U9yxuwr4/HrY
         jGNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775633463; x=1776238263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QHN/+v66yc0A89NHJH+2Y3ZhjzBVXfkm+kEWhWOJlLw=;
        b=dWhbnZ0n7R3kqaQM+Z/pLVXwo0YTiD8eBT2HJL3M4oQnoGh54SHyrEtV6IO3Oenk3p
         7YmkT3n3ZXNeXNQEN7rUpA6tvunoUpvbjp9a7RuE5c45/FKRYIUiDilM5AIDLGyeOtHz
         oIUFTkERQh3TfogLLEpmC7Am9+/dm1OozWKpsFRMp8I3V0jkm7yR+L0s5yxQ+7joXBKo
         AOHRvL5n2IE0L3KIgVzVdy+w6Ex3a+y0MC3VyKAJju016M8A07aOe8LDzcyv2dt1Vdpf
         CG53gqOLgdeG4VWXmNGGGZ/Y6kLxlutxP7tvhEPOIwOBGZRjbjpJhK+dDNoBtpJbAKhF
         9Jxg==
X-Forwarded-Encrypted: i=1; AJvYcCV2/sLfb7fJ+TIDKqZzWmll84Zylyfe2O1hcBXmXXRxVyqHbJQW+CS2beXEaP1BDtXH2TenAD8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4Jc1hP/JrsCOGBNvyYXqm+tYhahvIOoqSc6BiZ0cEOKpC8RDB
	meP6dn0W9lBEiIPukxlP+uaRinp4mLheQkmUfhI42rSy0vs4BPffvNnhbnqaFUcLFygc+x3vZMS
	1JmULqUOqRDm+w6c8gAkpJv/LeL1c9oU=
X-Gm-Gg: AeBDievS6lsH7NupuKpTajAyn2OPMV0+3nzADcBZw/Vs44P07hgz20siRmERRr7LZzm
	5HBFRMn58tCmu0r5j/84q3Fo+iqJLC4yVa6jCbTDKTNpqjtwByWUzWYMkOSZUZdodYklJK7/WnZ
	7sN1NnyEv2xhLAkIlPQGJAL1SHNHZt4n4pM0sQOSpFjvNTq+qbIgbsw35UCpeOoSoSSfZ0k5uhp
	mMsvuzIml60q0UX5IXyw3unxQmlmO1P2aYfyqk+z2GH+/RCvAWZbkNzAq2O9z7mUBubYlPy2g+y
	Qx9cim93
X-Received: by 2002:a05:6512:2251:b0:5a2:c406:a74a with SMTP id
 2adb3069b0e04-5a33758d965mr5354978e87.35.1775633462669; Wed, 08 Apr 2026
 00:31:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260404150452.83904-1-kerneljasonxing@gmail.com>
 <20260404150452.83904-4-kerneljasonxing@gmail.com> <willemdebruijn.kernel.2ff565d2f9e7f@gmail.com>
 <CAL+tcoB94=ptFB-acU3nAK_MqW74DV0MQUVvvV3nbQ7Zc6zSZw@mail.gmail.com>
 <willemdebruijn.kernel.27ec47b22b23c@gmail.com> <CAL+tcoAvVBN7juJEBt5-FYQ4eGTe7dYrFbR3CMOwguw=_X=btA@mail.gmail.com>
 <CAL+tcoCctfs=d9zz5ei1S999S94HmUDSToriZ8NJiLT8MmpQTA@mail.gmail.com>
 <willemdebruijn.kernel.1b49845d3acc7@gmail.com> <CAL+tcoBt1A5GYFvimkcRFUtmy298y13AiF-XFF8b8E8Y6fg8Xw@mail.gmail.com>
In-Reply-To: <CAL+tcoBt1A5GYFvimkcRFUtmy298y13AiF-XFF8b8E8Y6fg8Xw@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 8 Apr 2026 15:30:24 +0800
X-Gm-Features: AQROBzCA_HI1mJ5iXTGiSj9KFSmyl8xFzPMd49B8ysVtzC6MO0xGXC6MCb7Q39U
Message-ID: <CAL+tcoAa4FqSik8sGAzj6t8s_TpqBUDp95KkucCVDWBOQAkRiA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/4] bpf-timestamp: keep track of the skb when
 wait_for_space occurs
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, willemb@google.com, 
	martin.lau@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, Yushan Zhou <katrinzhou@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276327-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 56B1E3B8397
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 8, 2026 at 8:35=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> On Wed, Apr 8, 2026 at 5:17=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jason Xing wrote:
> > > On Tue, Apr 7, 2026 at 11:33=E2=80=AFAM Jason Xing <kerneljasonxing@g=
mail.com> wrote:
> > > >
> > > > On Mon, Apr 6, 2026 at 10:37=E2=80=AFPM Willem de Bruijn
> > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > >
> > > > > Jason Xing wrote:
> > > > > > On Mon, Apr 6, 2026 at 10:28=E2=80=AFAM Willem de Bruijn
> > > > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > > > >
> > > > > > > Jason Xing wrote:
> > > > > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > > > > >
> > > > > > > > The patch is the 1/2 part of push-level granularity feature=
.
> > > > > > > >
> > > > > > > > Tag the skb in tcp_sendmsg_locked() when wait_for_space occ=
urs even
> > > > > > > > though it might not carry the last byte of the sendmsg.
> > > > > > > >
> > > > > > > > Prior to the patch, BPF timestamping cannot cover this case=
:
> > > > > > > > The following steps reproduce this:
> > > > > > > > 1) skb A is the current last skb before entering wait_for_s=
pace process
> > > > > > > > 2) tcp_push() pushes A without any tag
> > > > > > > > 3) A is transmitted from TCP to driver without putting any =
skb carrying
> > > > > > > >    timestamps in the error queue, like SCHED, DRV/HARDWARE.
> > > > > > > > 4) sk_stream_wait_memory() sleeps for a while and then retu=
rns with an
> > > > > > > >    error code. Note that the socket lock is released.
> > > > > > > > 5) skb A finally gets acked and removed from the rtx queue.
> > > > > > > > 6) continue with the rest of tcp_sendmsg_locked(): it will =
jump to(goto)
> > > > > > > >    'do_error' label and then 'out' label.
> > > > > > > > 7) at this moment, skb A turns out to be the last one in th=
is send
> > > > > > > >    syscall, and miss the following tcp_bpf_tx_timestamp() o=
pportunity
> > > > > > > >    before the final tcp_push()
> > > > > > > > 8) BPF script fails to see any timestamps this time
> > > > > > > >
> > > > > > > > Signed-off-by: Yushan Zhou <katrinzhou@tencent.com>
> > > > > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > > > > > ---
> > > > > > > >  net/ipv4/tcp.c | 4 +++-
> > > > > > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > > > > >
> > > > > > > > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > > > > > > > index c603b90057f6..7d030a11d004 100644
> > > > > > > > --- a/net/ipv4/tcp.c
> > > > > > > > +++ b/net/ipv4/tcp.c
> > > > > > > > @@ -1400,9 +1400,11 @@ int tcp_sendmsg_locked(struct sock *=
sk, struct msghdr *msg, size_t size)
> > > > > > > >  wait_for_space:
> > > > > > > >               set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
> > > > > > > >               tcp_remove_empty_skb(sk);
> > > > > > > > -             if (copied)
> > > > > > > > +             if (copied) {
> > > > > > > > +                     tcp_bpf_tx_timestamp(sk);
> > > > > > > >                       tcp_push(sk, flags & ~MSG_MORE, mss_n=
ow,
> > > > > > > >                                TCP_NAGLE_PUSH, size_goal);
> > > > > > >
> > > > > > > Now the number of skbs that will be tracked will be unpredict=
able,
> > > > > > > varying based on memory pressure.
> > > > > >
> > > > > > Right, I put some effort into writing a selftests to check how =
many
> > > > > > push functions get called at one time and failed to do so.
> > > > > >
> > > > > > >
> > > > > > > That sounds hard to use to me. Especially if these extra push=
es
> > > > > > > cannot be identified as such.
> > > > > > >
> > > > > > > Perhaps if all skbs from the same sendmsg call can be identif=
ied,
> > > > > > > that would help explain pattern in data resulting from these
> > > > > > > uncommon extra data points.
> > > > > >
> > > > > > You meant move tcp_bpf_tx_timestamp before tcp_skb_entail()? Th=
at is
> > > > > > close to packet basis without considering fragmentation of skb =
:)
> > > > >
> > > > > No, I meant somehow in the notification having a way to identify =
all
> > > > > the skbs belonging to the same sendmsg call, to allow filtering o=
n
> > > > > that. But I also don't immediately see how to do that (without ad=
ding
> > > > > yet another counter say).
> > > >
> > > > If we don't build the relationship between skb and sendmsg (just li=
ke
> > > > the SENDMSG sock option), we will have no clue on how to calculate.=
 If
> > > > we only take care of the skb from the view of the syscall layer, it=
's
> > > > fine by moving tcp_bpf_tx_timestamp() before tcp_skb_entail(). But =
in
> > > > terms of per skb even generated beneath TCP due to gso/tso, there i=
s
> > > > only one way to correlate: adding an additional member in the skb
> > > > structure to store its sendmsg time. This discussion is only suitab=
le
> > > > for use cases like net_timestamping.
> > > >
> > > > Well, my key point is that, I have to admit, the above (including
> > > > existing bpf script net_timestamping) is a less effective way which
> > > > definitely harms the performance because of the extremely frequent
> > > > look-up process. It's not suitable for 7x24 observability in
> > > > production. What we've done internally is make the kernel layer as
> > > > lightweight/easy as possible and let the timestamping feature throw
> > > > each record into a ring buffer that the application can read, sort =
and
> > > > calculate. This arch survives the performance. But that's simply wh=
at
> > > > the design of the kernel module is, given the fast deployment in
> > > > production. I suppose in the future we could build a userspace tool
> > > > like blktrace to monitor efficiently instead of the selftest sample=
.
> > > > Honestly I don't like look-up action.
> > > >
> > > > Since we're modifying the kernel, how about adding a new member to
> > > > record sendmsg time which bpf script is able to read. The whole
> > > > scenario looks like this:
> > > > 1) in tcp_sendmsg_locked(), record the sendmsg time for each skb
> > > > 2) in either tso_fragment() or tcp_gso_tstamp(), each new skb will =
get
> > > > a copy of its original skb
> > > > 3) in each stage, bpf script reads the skb's sendmsg time and the
> > > > current time, and then effortlessly do the math.
> > > >
> > > > At this point, what I had in mind is we have two options:
> > > > 1) only handle the skb from the view of the send syscall layer, whi=
ch
> > > > is, for sure, very simple but not thorough.
> > > > 2) stick to a pure authentic packet basis, then adding a new member
> > > > seems inevitable. so the question would be where to add? The space =
of
> > > > the skb structure is very precious :(
> > >
> > > Finding a suitable place to put this timestamp is really hard. IIRC,
> > > we can't expand the size of struct skb_shared_info so easily since
> > > it's a global effect.
> > >
> > > I'm wondering if we can turn the per-packet mode into a non-compatibl=
e
> > > feature by reusing 'u32 tskey' to store a microsecond timestamp of
> > > sendmsg.
> >
> > Agreed that an extra field is hard. We should avoid that.
>
> Avoiding adding a new one makes the whole work extremely hard. I'm
> wondering since we have hwtstamp in shared info, why not add a
> software one for timestamping use? Then, we would support more
> different protocols in more different stages in a finer grain, which
> is a big coarse picture in my mind.
>
> Adding a software bit will completely reduce the whole complexity and
> be very easy to use. Would you expect to see a draft by adding such a
> bit first?
>
> Or just like I mentioned, repurposing tskey seems an alternative,
> which, however, makes the new feature incompatible.
>
> >
> > If the purpose is to group skbs by sendmsg call (e.g., to filter out
> > all but the last one), it is probably also unnecessary.
> >
> > From a process PoV, since the process knows the sendmsg len and each
> > skb has a tskey in byte offset, it can correlate the skb with a given
> > sendmsg buffer.
> >
> > The BPF program is under control of a third-party admin. So that does
> > not follow directly. But it can be passed additional metadata.
> >
> > I thought about passing the offset of the skb from the start of the
> > sendmsg buffer to identify all consecutive skbs for a sendmsg call,
> > as each new buffer will start with an skb with offset 0 ..
> >
> > .. but that won't work as there is no guarantee that a sendmsg call
> > will not append to an existing outstanding skb.
>
> Right. TCP is way too complex and we indeed see some tough issues when
> trying to deploy the feature. So my humble take is to make the design
> as simple as possible.
>
> >
> > Anyway, the general idea is to pass to the BPF program through
> > bpf_skops_tx_timestamping some relevant signal , without having to
> > expand either skb or sk itself.
> >
> > I hear you on that measuring every skb is too frequent. But is calling
> > the BPF program and letting it decide whether to measure too? BPF
> > program invocation itself should be cheap.
>
> Oh, I was clear enough. Sorry. I meant tracing per skb is definitely
> an awesome way to go. My ultimate goal is to do so. Instead of letting
> people implement various fine grained bpf progs, we can provide a very
> easy/understandable/efficient approach with more samples. It should be
> very beneficial.
>
> >
> > If per-push is preferable, with a filter ability like the above, it
> > seems more useful to me already.
>
> Push-level is a compromise plan. Packet-level is what I always pursue :)
>
> The current series has this ability: the bpf prog noticed it's a
> SENDMSG sock option and will selectively call
> bpf_sock_ops_enable_tx_tstamp() to do so. Only by calling
> bpf_sock_ops_enable_tx_tstamp() could the skb be tracked.

FYI, bpf prog could call bpf_sock_ops_enable_tx_tstamp() to enable the
skb track selectively.

Thanks,
Jason

