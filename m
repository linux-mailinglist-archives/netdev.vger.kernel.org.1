Return-Path: <netdev+bounces-275886-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gA+GJre11GmvwgcAu9opvQ
	(envelope-from <netdev+bounces-275886-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 09:43:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 567FD3AAE92
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 09:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D86F3300AB0F
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 07:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1113A254A;
	Tue,  7 Apr 2026 07:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3L7/sM9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C113A2573
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 07:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775547826; cv=pass; b=bV8QuoNHtv3HVeEceRblKx8wurlpFM7KOBb62oPutbK+mvKPfazuEUWrXrgv/MbzVKjAFdOXs9KvlWB22XuWA/Bjsum6pqk06uutd8SH8MaVGA7J77KnMqIy2eUWf1SP7StlN/JDGUc0feGNAuiv6ZTYI9wS29mcOivIcQ4G8Sc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775547826; c=relaxed/simple;
	bh=KqABs7Z6fJms9Jugr+QlGVltcIlIw0JtZB8PES8chgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I7PCJGgYHlGwQMSzCzlBtq89HOdyvp/rgEwdWVUWw9YGjWZh6YjWayLGraWFLAM82hnReAzp7vw0rZea7eLAxY4tfDHYcu+hMqM6YXwCl7o2JE+pHjHgrKNIOBOcl7D9lSMtT3n2Vy09/gh8FkSWKw8StPotUkW5skFwpvWBbQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d3L7/sM9; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a2b636b944so4891021e87.1
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 00:43:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775547823; cv=none;
        d=google.com; s=arc-20240605;
        b=kQULSkOUtaRYi+mvfbKC+uXGuUq6cqI9eLojANi5C3s98fHZy+DsHrHBVVDuaoA1jD
         RWzfNNgILeTpgrofHb2E+Y3wqxjSyBm5NDH4MB8RV1l6UVO/9YC8JkgjxthuSQxXsXwf
         5r5WaywqF03zxkn/fhspXj70Y+Q6CVEYlVTZdY8MQBCOwsurTm3eqXAmWwYR6mkAIg7J
         ehf0sflvEGvB6vJJ0jjR5tiVKBQS+lfOfH4QJL3OGMSb3jw5p30HKdDmYKm4+VeVeJkS
         rGqsA+h+mfJcclTrmCnA/gAoXNFlfS/gYdfn9+PDBn5BfjOQ8H+XN8ivr2k1z7K9jAU2
         lEjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wFx/0pjhy5NqBlYulyKM1FZvRqnlbThaSkwZhZnF+W8=;
        fh=80N5ZfOyJ0G8Vp3oeCd/LUpmegWuY6Ak45z/Yx+972A=;
        b=PGoukUbBOrv9mCtSlw24wlJISlXtRV5Z2eQeIxHIU2vgjsONAPz6y60ODfuHCaicmA
         ICxqTpyXWcrg904nDooEJ/RfAh1jwJFxaTksJVpD72ZAV4aradeL5ap035oYMBhCi2yG
         1mpVDqE4Va/X6GnTR/3zyoGurTjkDiSbTN+r+vKHKBnU3dqyP9dUJq+7ZAY+mkln5Rgv
         a7Olelw1ih6+WRyRsTMKzmUVds1eGiZ+HQ87oReENVAsSf1Qi/q0WI2Ij1+t+Kuk6W6d
         72aZinQzjbjnL+p042RNH14WXKXL8M8xfOadl4k/I4jCkvSsZVz9I+Ta2QDU+duWOnNy
         GtAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775547823; x=1776152623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wFx/0pjhy5NqBlYulyKM1FZvRqnlbThaSkwZhZnF+W8=;
        b=d3L7/sM9pkI7kzNZAMuiSG/xxfFact7FqSnQj1/tJpAEozkPriUsFVV1R05T5v+o07
         lI2lsFPMKjg8u8Nc1r8TBEx2RtDXvZCUYKfQtb5YDKMwAEiHnkvrz7vNqA11XKzCccF+
         SRWfs1iwrZMJY5GpdIi4wWLlPJd8bpYkXCmQ+kNmM+5lO8+Jlnk8ymdTCJY/Tbm/un9u
         J/tethsJwGfGowKmAsSCXfNSfPMJH67WdyBp05p5Azc39YfMaUjYz5lLO/6bNOqDxfL5
         l3knkuS9xhr8g+hZY1/akbZJVHXqZny9cjZ6R2DajkYVSJ9IIU8dxRedFFQEA2OAIT7h
         ep5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775547823; x=1776152623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wFx/0pjhy5NqBlYulyKM1FZvRqnlbThaSkwZhZnF+W8=;
        b=nZIeuxJcqZZikdMLrhdO9PO2embIXL+Q3NSSQcN8+t3fpqX7GSOVmh3cOc+h1EJJRX
         FWrjdP9jtatXhQ//Xt/doWt4KWtXT3y+wwJUF8FPK6oTbotpEH+qX4LEiY7drQHOqbyM
         K8PrJ1oge971vJGDiAGhLxcj/ChFIzQC3E2JSGVfJnSlFQ6MZMWyn0T9OHkvMhtDmMjJ
         nY0p53N5gfuRPDyw1aTF0ksOD9lZQJXWtyKwiTyd2dBCXeYUasqN4dNCnFC06bWbBdC2
         8orAnJGoONTfhXt9/f7gTx1E1qMiJTIwGSqsRfnTAROBYIEnIrdZsxwqkoGCbdSr2F1u
         E5EQ==
X-Forwarded-Encrypted: i=1; AJvYcCWv1jSElO2TQNGH1fhEOuSt829Y+wbPwKAfK7bnnDoHM6j9yOIVTbHSL1cuXYT0u7gvjJvmy08=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHLZS3CBAJ80+T+hlUUoYegMWa2hr8s5SOkOE4yBxRFMxKdo86
	LmOpZlFo0SUS/j8b6WzKLDbtKAqahsyo2+8Zpoor0PNKyyMxqzOk73pSbnsBGg2oAl+ES6Yw1ul
	BRUJbWSig0qdpkWDFXLDpU+JcipZeJ4U=
X-Gm-Gg: AeBDiettH7SOJn1jRf5XVXXVjj8f4fNy/qLkwJq5dr/JgpZvgmU5QTnMyIMndYLNH4u
	3XJDTE6cFmRaie9zePKumFIZPiahszdzQF8ECAwKNSuRIecDKoHLdRd6svUHR3EBuPvIt/3b//R
	mw/GkE1ZdEO7FGTczcrSXTTNrwJW5/KuaJ9FdUpDPq/9oesQRGGquSAeZQmungOauZ4vZ7V6vj8
	HHqWPvQ2jt2BXVpn+PlxrZVb/Vj0Vk/ETnTZD2RpkX6HIKnqxs1EmKqvePcNPQLFIMTUXGkbM28
	uOVgrUZQ
X-Received: by 2002:a05:6512:3d0e:b0:5a2:a5f6:dfce with SMTP id
 2adb3069b0e04-5a337556becmr6028363e87.11.1775547822201; Tue, 07 Apr 2026
 00:43:42 -0700 (PDT)
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
In-Reply-To: <CAL+tcoAvVBN7juJEBt5-FYQ4eGTe7dYrFbR3CMOwguw=_X=btA@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 7 Apr 2026 15:43:04 +0800
X-Gm-Features: AQROBzDvPxkvcwVC5KfAZvN--TaHv5-V1B-Pjsm3w69-IUAhNtf68jhyOZx-lOc
Message-ID: <CAL+tcoCctfs=d9zz5ei1S999S94HmUDSToriZ8NJiLT8MmpQTA@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-275886-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,tencent.com:email]
X-Rspamd-Queue-Id: 567FD3AAE92
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 7, 2026 at 11:33=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Mon, Apr 6, 2026 at 10:37=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jason Xing wrote:
> > > On Mon, Apr 6, 2026 at 10:28=E2=80=AFAM Willem de Bruijn
> > > <willemdebruijn.kernel@gmail.com> wrote:
> > > >
> > > > Jason Xing wrote:
> > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > >
> > > > > The patch is the 1/2 part of push-level granularity feature.
> > > > >
> > > > > Tag the skb in tcp_sendmsg_locked() when wait_for_space occurs ev=
en
> > > > > though it might not carry the last byte of the sendmsg.
> > > > >
> > > > > Prior to the patch, BPF timestamping cannot cover this case:
> > > > > The following steps reproduce this:
> > > > > 1) skb A is the current last skb before entering wait_for_space p=
rocess
> > > > > 2) tcp_push() pushes A without any tag
> > > > > 3) A is transmitted from TCP to driver without putting any skb ca=
rrying
> > > > >    timestamps in the error queue, like SCHED, DRV/HARDWARE.
> > > > > 4) sk_stream_wait_memory() sleeps for a while and then returns wi=
th an
> > > > >    error code. Note that the socket lock is released.
> > > > > 5) skb A finally gets acked and removed from the rtx queue.
> > > > > 6) continue with the rest of tcp_sendmsg_locked(): it will jump t=
o(goto)
> > > > >    'do_error' label and then 'out' label.
> > > > > 7) at this moment, skb A turns out to be the last one in this sen=
d
> > > > >    syscall, and miss the following tcp_bpf_tx_timestamp() opportu=
nity
> > > > >    before the final tcp_push()
> > > > > 8) BPF script fails to see any timestamps this time
> > > > >
> > > > > Signed-off-by: Yushan Zhou <katrinzhou@tencent.com>
> > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > > ---
> > > > >  net/ipv4/tcp.c | 4 +++-
> > > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > > > > index c603b90057f6..7d030a11d004 100644
> > > > > --- a/net/ipv4/tcp.c
> > > > > +++ b/net/ipv4/tcp.c
> > > > > @@ -1400,9 +1400,11 @@ int tcp_sendmsg_locked(struct sock *sk, st=
ruct msghdr *msg, size_t size)
> > > > >  wait_for_space:
> > > > >               set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
> > > > >               tcp_remove_empty_skb(sk);
> > > > > -             if (copied)
> > > > > +             if (copied) {
> > > > > +                     tcp_bpf_tx_timestamp(sk);
> > > > >                       tcp_push(sk, flags & ~MSG_MORE, mss_now,
> > > > >                                TCP_NAGLE_PUSH, size_goal);
> > > >
> > > > Now the number of skbs that will be tracked will be unpredictable,
> > > > varying based on memory pressure.
> > >
> > > Right, I put some effort into writing a selftests to check how many
> > > push functions get called at one time and failed to do so.
> > >
> > > >
> > > > That sounds hard to use to me. Especially if these extra pushes
> > > > cannot be identified as such.
> > > >
> > > > Perhaps if all skbs from the same sendmsg call can be identified,
> > > > that would help explain pattern in data resulting from these
> > > > uncommon extra data points.
> > >
> > > You meant move tcp_bpf_tx_timestamp before tcp_skb_entail()? That is
> > > close to packet basis without considering fragmentation of skb :)
> >
> > No, I meant somehow in the notification having a way to identify all
> > the skbs belonging to the same sendmsg call, to allow filtering on
> > that. But I also don't immediately see how to do that (without adding
> > yet another counter say).
>
> If we don't build the relationship between skb and sendmsg (just like
> the SENDMSG sock option), we will have no clue on how to calculate. If
> we only take care of the skb from the view of the syscall layer, it's
> fine by moving tcp_bpf_tx_timestamp() before tcp_skb_entail(). But in
> terms of per skb even generated beneath TCP due to gso/tso, there is
> only one way to correlate: adding an additional member in the skb
> structure to store its sendmsg time. This discussion is only suitable
> for use cases like net_timestamping.
>
> Well, my key point is that, I have to admit, the above (including
> existing bpf script net_timestamping) is a less effective way which
> definitely harms the performance because of the extremely frequent
> look-up process. It's not suitable for 7x24 observability in
> production. What we've done internally is make the kernel layer as
> lightweight/easy as possible and let the timestamping feature throw
> each record into a ring buffer that the application can read, sort and
> calculate. This arch survives the performance. But that's simply what
> the design of the kernel module is, given the fast deployment in
> production. I suppose in the future we could build a userspace tool
> like blktrace to monitor efficiently instead of the selftest sample.
> Honestly I don't like look-up action.
>
> Since we're modifying the kernel, how about adding a new member to
> record sendmsg time which bpf script is able to read. The whole
> scenario looks like this:
> 1) in tcp_sendmsg_locked(), record the sendmsg time for each skb
> 2) in either tso_fragment() or tcp_gso_tstamp(), each new skb will get
> a copy of its original skb
> 3) in each stage, bpf script reads the skb's sendmsg time and the
> current time, and then effortlessly do the math.
>
> At this point, what I had in mind is we have two options:
> 1) only handle the skb from the view of the send syscall layer, which
> is, for sure, very simple but not thorough.
> 2) stick to a pure authentic packet basis, then adding a new member
> seems inevitable. so the question would be where to add? The space of
> the skb structure is very precious :(

Finding a suitable place to put this timestamp is really hard. IIRC,
we can't expand the size of struct skb_shared_info so easily since
it's a global effect.

I'm wondering if we can turn the per-packet mode into a non-compatible
feature by reusing 'u32 tskey' to store a microsecond timestamp of
sendmsg.

Thanks,
Jason

