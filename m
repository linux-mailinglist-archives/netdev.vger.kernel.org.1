Return-Path: <netdev+bounces-287623-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGmHA22XBGpiLwIAu9opvQ
	(envelope-from <netdev+bounces-287623-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 17:23:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5644B536026
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 17:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE5213174016
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 14:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0007441323A;
	Wed, 13 May 2026 14:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RoZKp0Jt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0791437C937
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 14:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778682158; cv=pass; b=PBlfOE60M+wn/kCQ1/ta6va+dAZNNDFybgCMRx8x32jsGJn8bb0rUzDgA9EzQ8tI73e6LQ23BXAvK2nvnXrKAmezKJVNDjsJIvflwDAaXRfZaqtD4d/2XL89h+0H2+yLaRcytFfLRDz2LoncYDd8tmVW6A8+O7EU2iAyjrfAE7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778682158; c=relaxed/simple;
	bh=9oAvbmkZKYIomDiaD1TObEK2e0CJ69Ld6tGN1kWMXEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rum48Df0i5F2pBqNoXLb7d20OmCGbgf9V+c8/uBYnD10i3K6mKDLGju1CfOJtsaZEZywDN0Q//3OXzya30tf9qYuoOa9HgJDJVjIplSghlkM4TFHWaU6Yr4QCQ+h78OJoYGCVURqsHw6Ccuo/sgyMrZdbtEuaWLUppufLXszBCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RoZKp0Jt; arc=pass smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-39393ec4ed0so59205941fa.0
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 07:22:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778682154; cv=none;
        d=google.com; s=arc-20240605;
        b=ETlaLZ99h67uD6tdCRT1+3dK0iYIXo6q1qJv3S31jAmznhXjvuuR/6RuKN35hMP9Gv
         3fgll72tMiHSH2SNkR3jAlT1Y/3W7uAh903kfF/JRngpz/j0ma1d8OsfEoBoU1hvxgtp
         sMjSC0ww//lDcIoWDC8oukHKdfcfCFIRCbfo3ELzBkSVDG5Nr6TOuZPjUq3RDGLzwwFF
         xBQ3uhOnnkKaWlxF9Gmrz0HSWPI+T+5wro8yzWtnS8dRjHCxgCFa3h9dssC5m2f12Zad
         a7UYlGuZ6jTlh65OamrJPwzHaNLvbsxUFKAH5/MAyZ0Zqr29WzGsQ19GdyAMAdVctFjx
         00iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/SY+5SsAhGChwgUWInPuI1u1aUmX1Vik5Ht/pl+52U0=;
        fh=3mDufpZAiqBOAQU1+FyFNEe4IJOzjrdO1c/P+APo9to=;
        b=FW0/MY+p0dAG4emuaVo81SNeS92vj/WWKtrzEj1zL16TqZhOLL/SZNH3ySKy0LNaF5
         dRqpcaBz4F/rcb1Mv1NmVZ/28C6/95c2VG7tazKzehf6eBmT7SwU2jNuVOTEmCpOnT7y
         +wXRUthMvdp8TvJQfq/g8nVAFFfsIKZm9e7lGKMPQoK2yXJWAnAKaCMbXcSPyCncAVi2
         GKTrQNdIwuJ0FXfTOzIwpwo1DN84mNQ/LYcGQRbkN2L7chxTpfXLG2j7dXCicN9JfO5I
         DO/IO5oRoCQ0Uk1+TPkaDfqOeyv3FiTsTO9RKAtcsRb2+VOboznXfgNZjVoygrIAasR2
         vALw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778682154; x=1779286954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/SY+5SsAhGChwgUWInPuI1u1aUmX1Vik5Ht/pl+52U0=;
        b=RoZKp0Jto5wNOsJ83U3hECgx19CQ5Adb0DW/4N8iAxqjGw4yN6yjqakPJO/9sALVYq
         ZAvVpGsZD50GpfYl5ZhTXaT//lXCq0PxBoz2PAsedAiQEefF0QUZfCSNtkAZ7fSfO3yX
         a1gAPdJEED5gi4r0jt0ridBQ+wr1pFjeuEUcaCdQONbdnYp+yPGmF0A1PNPOkgvDNb94
         h+J47e+10itNqt83Qh/NUYUcwFlng7cG4hxxBI7GOIJ7DXK9ulJ32+RfJH9zaLvXUDXn
         4o2hreBc5MZgobOxfAtVpGzQiqFni0aPYo9GI1ob2L9WvWcsR6hm5GTdb7D8r2VyjrZ0
         gyiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778682154; x=1779286954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/SY+5SsAhGChwgUWInPuI1u1aUmX1Vik5Ht/pl+52U0=;
        b=STMH/1ihVhnNnU2XLx34W/FB0T6iJ+Xav0qiRP5F6dClJB43sFLsUTXKD51Q/Lre6Y
         CKwyVGbEE/zy0sJ9ayDwieUFZXgZE5p+gGRMMeDnxXfnQrKS+Hp0VlYKm3izYpmvdZUK
         9zW6C4l710eWvbeJRn7AX03JE1jC7DqHZi4GwQ8HH62U9m9w7D1HOjxZyOFP/yzDEBtj
         BoivV32QyYVRBWecNWQL/I/V715dhClpcQgap63meaFgc3r8CTY90EwbUSDlhZlS6MSA
         6FfbyfUMqYIUV/M0zxFcLw0cDKNKKE/zMk6vNfZM91uWNOczRMlJBjgZkXuADWMqVxpD
         rtyg==
X-Forwarded-Encrypted: i=1; AFNElJ/eyuSfPBziSyvJnoLI55ygU4yTv6hadJ5GudstDLjmA4c3i90midsRRvLusq5uk7XVZa7yB5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYXJBVgIAqiQPy5rsx8HH+sVWWc/bfUazfZJxXEyFcWxvrmM/2
	My5x/SiBhGsqqHJdp5EBuXAUflsx2Gdy3KTjXgej30BLx/IwjKS6w3hWzPvBUl6lh/nCt5y77Xx
	bjQgJhp7v0bIZpeyA12pwlMmSPekEk+8=
X-Gm-Gg: Acq92OE7M1mMkPYfnqS/KU2vmZr6r8vAiMJuP4HGu9t4QOmTqz0Szg8nysAfMOu6E7q
	5w1hSDAk1iraFdKAqcwWpAQAUZuwhL1CK/4csd26NMvLlSFDmUm6LavlZd3cyKvdbkZXozA23Bl
	i2tjNI8Nh8X+Vb6qFrx1xbYHs+VTwuhtS5s8OHeRDWUKiMmwWq95NPrB8AnvUPhpQOHrW0BGOid
	HdGSjgRUoZIOHk9rf68zAyfcBHCwngfV6fdFqwDJi9VmLMdTvjSY+mNXMZUxJa+iT2QXOM3DfOe
	AQ8UGDSp35CniajJxwt37ETfkku/TUKALV+OVWc=
X-Received: by 2002:a05:6512:3d07:b0:5a3:f25f:cc30 with SMTP id
 2adb3069b0e04-5a8ef99a4fcmr1198885e87.32.1778682153873; Wed, 13 May 2026
 07:22:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260510012310.88570-1-kerneljasonxing@gmail.com>
 <20260510012310.88570-2-kerneljasonxing@gmail.com> <agHurBlnAgjVNq-u@devvm7509.cco0.facebook.com>
 <CAL+tcoDrjJ8iHzSGz_Orf7iH-1WJ2H_LZd6BMKTnDS3MVN8daA@mail.gmail.com> <agOozH29XU6KQUTy@devvm7509.cco0.facebook.com>
In-Reply-To: <agOozH29XU6KQUTy@devvm7509.cco0.facebook.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 13 May 2026 22:21:56 +0800
X-Gm-Features: AVHnY4LFjy8smvgA5gfVpYV3feknTwoegdWnsJllj82k8og6Ki_PDkhRRWeveHA
Message-ID: <CAL+tcoDqtEAqX65-8crUkUko5T_0nq=LSxAbMg+5jCAHa_uC=A@mail.gmail.com>
Subject: Re: [PATCH net 1/4] xsk: cache csum_start/csum_offset to fix TOCTOU
 in xsk_skb_metadata()
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, horms@kernel.org, andrew+netdev@lunn.ch, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 5644B536026
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287623-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,lunn.ch,vger.kernel.org,tencent.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tencent.com:email]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 6:34=E2=80=AFAM Stanislav Fomichev <sdf.kernel@gmai=
l.com> wrote:
>
> On 05/12, Jason Xing wrote:
> > On Mon, May 11, 2026 at 11:03=E2=80=AFPM Stanislav Fomichev
> > <sdf.kernel@gmail.com> wrote:
> > >
> > > On 05/10, Jason Xing wrote:
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > The TX metadata area resides in the UMEM buffer which is memory-map=
ped
> > > > and concurrently writable by userspace. In xsk_skb_metadata(),
> > > > csum_start and csum_offset are read from shared memory for bounds
> > > > validation, then read again for skb assignment. A malicious userspa=
ce
> > > > application can race to overwrite these values between the two read=
s,
> > > > bypassing the bounds check and causing out-of-bounds memory access
> > > > during checksum computation in the transmit path.
> > > >
> > > > Fix this by reading csum_start and csum_offset into local variables
> > > > once, then using the local copies for both validation and assignmen=
t.
> > > >
> > > > Note that other metadata fields (flags, launch_time) and the cached
> > > > csum fields may be mutually inconsistent due to concurrent userspac=
e
> > > > writes, but this is benign: the only security-critical invariant is
> > > > that each field's validated value is the same one used, which local
> > > > caching guarantees.
> > > >
> > > > Closes: https://lore.kernel.org/all/20260503200927.73EA1C2BCB4@smtp=
.kernel.org/
> > > > Fixes: 48eb03dd2630 ("xsk: Add TX timestamp and TX checksum offload=
 support")
> > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > ---
> > > >  net/xdp/xsk.c | 11 +++++++----
> > > >  1 file changed, 7 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > > index 6bcd77068e52..cd039e397018 100644
> > > > --- a/net/xdp/xsk.c
> > > > +++ b/net/xdp/xsk.c
> > > > @@ -722,6 +722,7 @@ static int xsk_skb_metadata(struct sk_buff *skb=
, void *buffer,
> > > >                           u32 hr)
> > > >  {
> > > >       struct xsk_tx_metadata *meta =3D NULL;
> > > > +     u16 csum_start, csum_offset;
> > > >
> > > >       if (unlikely(pool->tx_metadata_len =3D=3D 0))
> > > >               return -EINVAL;
> > > > @@ -731,13 +732,15 @@ static int xsk_skb_metadata(struct sk_buff *s=
kb, void *buffer,
> > > >               return -EINVAL;
> > > >
> > > >       if (meta->flags & XDP_TXMD_FLAGS_CHECKSUM) {
> > > > -             if (unlikely(meta->request.csum_start +
> > > > -                          meta->request.csum_offset +
> > > > +             csum_start =3D meta->request.csum_start;
> > > > +             csum_offset =3D meta->request.csum_offset;
> > >
> > > Wondering if it's better to READ_ONCE(x) these?
> >
> > I still chose not to use it after reading the suggestion from local
> > AI. The reason is there is no WRITE_ONCE pair to make sure everything
> > is no data-race. I also checked some existing implementations around
> > the shared buffer (between userspace and kernel) and didn't manage to
> > see the usage of XXXX_ONCE(). Does it make any sense to you :) ?
>
> Without READ_ONCE your patch relies on the compiler honoring exactly the
> loads and stores as written. Which I don't think it does (hence that
> whole WRITE_ONCE/READ_ONCE mess). IOW, it can pretty much generate
> the same code (and read csum_start twice) even with your patch applied. H=
appy
> to argue with your local AI if you give me the output :-D
>
> I grepped io_uring/ and I see similar pattern for reading user supplied
> entries (via READ_ONCE).

I roughly understand what your meaning is here. My thought is the
data-race condition in this case still happens even with the
READ_ONCE() protection (because no such corresponding operation is
performed on the writer side).

Actually the local AI said use READ_ONCE instead.

I can change this as you suggested for sure. Maybe related fields can
be protected in the same way in another patch.

Thanks,
Jason

