Return-Path: <netdev+bounces-276217-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFTkOAqj1Wkj8QcAu9opvQ
	(envelope-from <netdev+bounces-276217-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 02:36:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBA13B5B8D
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 02:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0ACC330157BA
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 00:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB442C3271;
	Wed,  8 Apr 2026 00:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+JUawZu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8586922B8C5
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 00:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775608580; cv=pass; b=RO+ZyXIesFApHCX6zwRPUHVEAM54Azh/HSQBfimhuvWM8HewHyJDKWSK4JH0q3E71z8isWJ9RQBIVEOBJssrG7t1LHqcOME/feindSwXqkT/mDD7SlJLnfxasyVKRl8jAwyLBp1LO7b1+pIXMdZXeygvlqBm86a6zlxjAQiZvKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775608580; c=relaxed/simple;
	bh=yc04CXDJZIssiibVZiuD663knKh8kMXknZH9b823FCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n22znO0+c9BczfVNF7hV9YhQ0wqKdZSkfRxrBoKzSK4T3EZdps2/oJndjeW3C3fKgqjhDkaKLW6+Bluj53RY7PwbJcD77L4WT88WHy8QMUuGmKhDBMyI+lvdQjJ89Of8OsKWLPk7k0UWO+8tga1f6VTG7tqZ9ZGqBZpsJ53IIdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+JUawZu; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a3d2824e4bso4685300e87.3
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 17:36:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775608577; cv=none;
        d=google.com; s=arc-20240605;
        b=iME2wBT4qzfKLtzUi8McmAeWV5fwvEXBZioNjp9NWt6yJr1txZR/rJTDnizuxfGU+A
         dgT1nVz739y+wCY8QdLb5dGUXMdjnGuRp8TslaQzOze45ehWFvxamwTa6F8JMsRHB76l
         r4mM9TK81QwQ9KWTHUElKMy43IE7vtiPbJ3LSGINeALjv5Z/xUWiXzB+YmCkiOgHdDKa
         DymQqG0ml7xVA0097kzYnsnUF2zuAWjpHsPsQOdqPQYjwiU10xfTkobdfinACqzXUFKj
         EDOw2lSwhSnOybZ8uKGcJAZmnmQ2JOZlVt+3NKJ5YntaELnFCVFADr6kic+fxVu16xmS
         LuXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6n/7HQyrtMfTJW06twOyVYb1ZogrEoRjRGf+zORS6bw=;
        fh=bwZICOvv+9mPAHQxdk9SBcNeYVVR3IKKUn4/QUMHxtc=;
        b=D36k/V2LRRQ2y4GurJK2pUzzHUtrdCrrsbSsQB1g3+5YwyLorCeNWTnuJFjSl1EKnB
         QZUCu4r+Pu2GTYgEcToueN6OrTY81RaulUpPQMImOUcD/tib+m/ia5gQdqoplsdNAfRV
         7npC6L4Sv2ubDUs6vBfds58BNJOKxewgsq6QPnZPrFTt2u8dLy1oermnTF56vBtb48H9
         W3kXj/FSEFjp8ieD0yjk6w4ICvrXupbUPYkJSc7CGLcXfkQLHOlVJZfvV6TNkU4cVJNU
         ayNkQMFW/QBgp2kVPgVQHSQjohwDqGhRRUIuQc14hqsWVsMb1p9e9Wb9KeMZgWII2SYB
         RXRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775608577; x=1776213377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6n/7HQyrtMfTJW06twOyVYb1ZogrEoRjRGf+zORS6bw=;
        b=C+JUawZuGpJ+S/JC3+NwIKuvjzqT0kP5t1tTzp6xss1ly7PtsnDa5T6+TFVz3Ulka0
         HkEfXFZPKxDaaEvfdSjmSUeSCQ7p/9qc604rPQJse8iot6ypAto4/2P0BfFS9haL/Rpf
         HVbCCPXBq5jVHdXozjhK8ZC+/Kr2cf+pTOYZW8s2iFdr5TU15g1UyHz3i9mUgNYK7HTG
         kiL803MtiEScAeIYh47lLganqZgJQfC6Z8JdDA3G5ShuwMMFy4x6L9dA5I4peoRhmX/9
         gNexUL+qN2gHuRdLNiItEeou7XiL3cQ9entBn3HEbXXCn2QakJAzFEypLkaLmCCu38zD
         mTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775608577; x=1776213377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6n/7HQyrtMfTJW06twOyVYb1ZogrEoRjRGf+zORS6bw=;
        b=Mogc/h02QDjs4roP+i9QVkAEXx1LzcNF6c868b4gvtVqZHAALAk/hu0GJ36cMkoLMT
         L/1Ynlvpqm6LSfE+y4r64ot4rtGlrI/hpb1p4YC6moOogroTFtuQo+rbp4PohNsFOo6F
         XZ6sNNoDz8TYT9M8f8rL5WC1txOA5XoIOQsEAYXcUIAJpR/9X0h2BcS934VEwfbwChJB
         FY8eLMfNhM84cUIfLZ2wpy0Xm1Dgd3laGwA4OLYAL/EIVXzLj/yNYK1ZnBuZkrt6ciE7
         XC3BuNtWgCkKXOO1qDqZj5CXuVLK8pyZdQU1gUNK7C0QDbSdaREvwfgtknH0iIG/gydU
         ZZBg==
X-Forwarded-Encrypted: i=1; AJvYcCUUG0xuG7TXt1raOk3qcKYzCxqPX4zk0PYmQQfNls5tjNX9cWSOO3uRDGCCSV4la+rRdUSunwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJvTzA3KMLt7ruI/3p3fPgM0oq3Nmy7h/u0LDYo6P4yHc3GJnk
	TTXjztM2HkKpai7GcFLTL3VxPcI1qYIy7XRl2YjvBHxAvJuIz51/k0kb+QQbI/6TDwq+Nbsnof0
	r98QwUoTlbY5WFxFM1kugXMJNs9LNMTc=
X-Gm-Gg: AeBDietUPQEOxJ4TFKWjyvY3V59/J/N3aPGkyVdxUUOVC1cNlfFU7YknQU2Emf9/nDj
	vkO18JGmv61iWn9Uxb0w9HBfrtJsSqltLanvZc0+VzIepzcxJKjzvIJKzETKAU9aAR/6U2gkwPr
	Trqnmy0VZfIsg5/XBYMgmdkrrL3/rp4T65Wxy29ziVm6Dr+bofwYcR9WYUCmy9+NfOkV+OR7HBi
	MluwyG3AVMDDCOA8OvPGvBsZIOmFRfO7OKzI8soc7vtUo+bSAfj1QEnLRYXPxBTL/xsNxG/0dUu
	c8NHYj8=
X-Received: by 2002:a05:6512:3b12:b0:5a1:1daf:f7b2 with SMTP id
 2adb3069b0e04-5a337514f67mr5768921e87.0.1775608576338; Tue, 07 Apr 2026
 17:36:16 -0700 (PDT)
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
 <CAL+tcoCctfs=d9zz5ei1S999S94HmUDSToriZ8NJiLT8MmpQTA@mail.gmail.com> <willemdebruijn.kernel.1b49845d3acc7@gmail.com>
In-Reply-To: <willemdebruijn.kernel.1b49845d3acc7@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 8 Apr 2026 08:35:37 +0800
X-Gm-Features: AQROBzCRTd0x9BrsJHcoQc-2sCYrx--jI_bQa6YUl2OGCkGbIENnd0UvF44LYi8
Message-ID: <CAL+tcoBt1A5GYFvimkcRFUtmy298y13AiF-XFF8b8E8Y6fg8Xw@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276217-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 5CBA13B5B8D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 8, 2026 at 5:17=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > On Tue, Apr 7, 2026 at 11:33=E2=80=AFAM Jason Xing <kerneljasonxing@gma=
il.com> wrote:
> > >
> > > On Mon, Apr 6, 2026 at 10:37=E2=80=AFPM Willem de Bruijn
> > > <willemdebruijn.kernel@gmail.com> wrote:
> > > >
> > > > Jason Xing wrote:
> > > > > On Mon, Apr 6, 2026 at 10:28=E2=80=AFAM Willem de Bruijn
> > > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > > >
> > > > > > Jason Xing wrote:
> > > > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > > > >
> > > > > > > The patch is the 1/2 part of push-level granularity feature.
> > > > > > >
> > > > > > > Tag the skb in tcp_sendmsg_locked() when wait_for_space occur=
s even
> > > > > > > though it might not carry the last byte of the sendmsg.
> > > > > > >
> > > > > > > Prior to the patch, BPF timestamping cannot cover this case:
> > > > > > > The following steps reproduce this:
> > > > > > > 1) skb A is the current last skb before entering wait_for_spa=
ce process
> > > > > > > 2) tcp_push() pushes A without any tag
> > > > > > > 3) A is transmitted from TCP to driver without putting any sk=
b carrying
> > > > > > >    timestamps in the error queue, like SCHED, DRV/HARDWARE.
> > > > > > > 4) sk_stream_wait_memory() sleeps for a while and then return=
s with an
> > > > > > >    error code. Note that the socket lock is released.
> > > > > > > 5) skb A finally gets acked and removed from the rtx queue.
> > > > > > > 6) continue with the rest of tcp_sendmsg_locked(): it will ju=
mp to(goto)
> > > > > > >    'do_error' label and then 'out' label.
> > > > > > > 7) at this moment, skb A turns out to be the last one in this=
 send
> > > > > > >    syscall, and miss the following tcp_bpf_tx_timestamp() opp=
ortunity
> > > > > > >    before the final tcp_push()
> > > > > > > 8) BPF script fails to see any timestamps this time
> > > > > > >
> > > > > > > Signed-off-by: Yushan Zhou <katrinzhou@tencent.com>
> > > > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > > > > ---
> > > > > > >  net/ipv4/tcp.c | 4 +++-
> > > > > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > > > > > > index c603b90057f6..7d030a11d004 100644
> > > > > > > --- a/net/ipv4/tcp.c
> > > > > > > +++ b/net/ipv4/tcp.c
> > > > > > > @@ -1400,9 +1400,11 @@ int tcp_sendmsg_locked(struct sock *sk=
, struct msghdr *msg, size_t size)
> > > > > > >  wait_for_space:
> > > > > > >               set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
> > > > > > >               tcp_remove_empty_skb(sk);
> > > > > > > -             if (copied)
> > > > > > > +             if (copied) {
> > > > > > > +                     tcp_bpf_tx_timestamp(sk);
> > > > > > >                       tcp_push(sk, flags & ~MSG_MORE, mss_now=
,
> > > > > > >                                TCP_NAGLE_PUSH, size_goal);
> > > > > >
> > > > > > Now the number of skbs that will be tracked will be unpredictab=
le,
> > > > > > varying based on memory pressure.
> > > > >
> > > > > Right, I put some effort into writing a selftests to check how ma=
ny
> > > > > push functions get called at one time and failed to do so.
> > > > >
> > > > > >
> > > > > > That sounds hard to use to me. Especially if these extra pushes
> > > > > > cannot be identified as such.
> > > > > >
> > > > > > Perhaps if all skbs from the same sendmsg call can be identifie=
d,
> > > > > > that would help explain pattern in data resulting from these
> > > > > > uncommon extra data points.
> > > > >
> > > > > You meant move tcp_bpf_tx_timestamp before tcp_skb_entail()? That=
 is
> > > > > close to packet basis without considering fragmentation of skb :)
> > > >
> > > > No, I meant somehow in the notification having a way to identify al=
l
> > > > the skbs belonging to the same sendmsg call, to allow filtering on
> > > > that. But I also don't immediately see how to do that (without addi=
ng
> > > > yet another counter say).
> > >
> > > If we don't build the relationship between skb and sendmsg (just like
> > > the SENDMSG sock option), we will have no clue on how to calculate. I=
f
> > > we only take care of the skb from the view of the syscall layer, it's
> > > fine by moving tcp_bpf_tx_timestamp() before tcp_skb_entail(). But in
> > > terms of per skb even generated beneath TCP due to gso/tso, there is
> > > only one way to correlate: adding an additional member in the skb
> > > structure to store its sendmsg time. This discussion is only suitable
> > > for use cases like net_timestamping.
> > >
> > > Well, my key point is that, I have to admit, the above (including
> > > existing bpf script net_timestamping) is a less effective way which
> > > definitely harms the performance because of the extremely frequent
> > > look-up process. It's not suitable for 7x24 observability in
> > > production. What we've done internally is make the kernel layer as
> > > lightweight/easy as possible and let the timestamping feature throw
> > > each record into a ring buffer that the application can read, sort an=
d
> > > calculate. This arch survives the performance. But that's simply what
> > > the design of the kernel module is, given the fast deployment in
> > > production. I suppose in the future we could build a userspace tool
> > > like blktrace to monitor efficiently instead of the selftest sample.
> > > Honestly I don't like look-up action.
> > >
> > > Since we're modifying the kernel, how about adding a new member to
> > > record sendmsg time which bpf script is able to read. The whole
> > > scenario looks like this:
> > > 1) in tcp_sendmsg_locked(), record the sendmsg time for each skb
> > > 2) in either tso_fragment() or tcp_gso_tstamp(), each new skb will ge=
t
> > > a copy of its original skb
> > > 3) in each stage, bpf script reads the skb's sendmsg time and the
> > > current time, and then effortlessly do the math.
> > >
> > > At this point, what I had in mind is we have two options:
> > > 1) only handle the skb from the view of the send syscall layer, which
> > > is, for sure, very simple but not thorough.
> > > 2) stick to a pure authentic packet basis, then adding a new member
> > > seems inevitable. so the question would be where to add? The space of
> > > the skb structure is very precious :(
> >
> > Finding a suitable place to put this timestamp is really hard. IIRC,
> > we can't expand the size of struct skb_shared_info so easily since
> > it's a global effect.
> >
> > I'm wondering if we can turn the per-packet mode into a non-compatible
> > feature by reusing 'u32 tskey' to store a microsecond timestamp of
> > sendmsg.
>
> Agreed that an extra field is hard. We should avoid that.

Avoiding adding a new one makes the whole work extremely hard. I'm
wondering since we have hwtstamp in shared info, why not add a
software one for timestamping use? Then, we would support more
different protocols in more different stages in a finer grain, which
is a big coarse picture in my mind.

Adding a software bit will completely reduce the whole complexity and
be very easy to use. Would you expect to see a draft by adding such a
bit first?

Or just like I mentioned, repurposing tskey seems an alternative,
which, however, makes the new feature incompatible.

>
> If the purpose is to group skbs by sendmsg call (e.g., to filter out
> all but the last one), it is probably also unnecessary.
>
> From a process PoV, since the process knows the sendmsg len and each
> skb has a tskey in byte offset, it can correlate the skb with a given
> sendmsg buffer.
>
> The BPF program is under control of a third-party admin. So that does
> not follow directly. But it can be passed additional metadata.
>
> I thought about passing the offset of the skb from the start of the
> sendmsg buffer to identify all consecutive skbs for a sendmsg call,
> as each new buffer will start with an skb with offset 0 ..
>
> .. but that won't work as there is no guarantee that a sendmsg call
> will not append to an existing outstanding skb.

Right. TCP is way too complex and we indeed see some tough issues when
trying to deploy the feature. So my humble take is to make the design
as simple as possible.

>
> Anyway, the general idea is to pass to the BPF program through
> bpf_skops_tx_timestamping some relevant signal , without having to
> expand either skb or sk itself.
>
> I hear you on that measuring every skb is too frequent. But is calling
> the BPF program and letting it decide whether to measure too? BPF
> program invocation itself should be cheap.

Oh, I was clear enough. Sorry. I meant tracing per skb is definitely
an awesome way to go. My ultimate goal is to do so. Instead of letting
people implement various fine grained bpf progs, we can provide a very
easy/understandable/efficient approach with more samples. It should be
very beneficial.

>
> If per-push is preferable, with a filter ability like the above, it
> seems more useful to me already.

Push-level is a compromise plan. Packet-level is what I always pursue :)

The current series has this ability: the bpf prog noticed it's a
SENDMSG sock option and will selectively call
bpf_sock_ops_enable_tx_tstamp() to do so. Only by calling
bpf_sock_ops_enable_tx_tstamp() could the skb be tracked.

Thanks,
Jason

