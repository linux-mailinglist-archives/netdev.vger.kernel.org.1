Return-Path: <netdev+bounces-291677-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6P1pLY+MFWrUWQcAu9opvQ
	(envelope-from <netdev+bounces-291677-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 14:05:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B865D545E
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 14:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A86C3001870
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 11:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B863E1234;
	Tue, 26 May 2026 11:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="vg142CJn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDED3F7A87
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 11:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779796647; cv=pass; b=qPrt2gJL5KXmDSYtYhwXviWs3/PrZ3f81Lj7EDOLUYR0F/X5FjcLbI8Np49jCd3kEuIPeiSSnzq6rXZjeNCFWYD4OuzR/ATShSO/ZLdu90hQyVOqUb8yzZEyRZ+ZvEVPnF9KJTr4M1AL8GhV90UKJRlJjooEPKiuA7LSwJy5lsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779796647; c=relaxed/simple;
	bh=uatvV/dkhWjP4nwpgP4CLRQENKow60PiWwGbtNvBS5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e0eHHvPOC3xCna1G6SqZCgJiBG6ZjRBr/bya0Q15jO5N7XQX7sdgaP+tok87S4kgVCONWLXEybt61hwaybycadX6M+c+Usx5kTezo124FvVNPAWad3AjUdsinMrp1VG4uVZzykWfTC8zxMIgb+zP7wFonk5cOvguWbvQYcWEHsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=vg142CJn; arc=pass smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-83d31ac4017so5202302b3a.3
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 04:57:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779796641; cv=none;
        d=google.com; s=arc-20240605;
        b=aQbICRCV63SId7VbdSkHMzHYR/HjiKnGnwzMkFYU70VF+z+of1UUOJhl+AoebC9Yhc
         LJTlzyc83bcAK9na6ZgmXavAUhv6qntOogekmq9X0m9JngJZDG86RMiiHcObN+SQnE24
         0n5vNOoQstqUtySmE9v5RMn2h6Q5stmQj272XMubgdabK3U3gwDUqxB0rlWrB3qW710h
         jjdL0zNwPUrFlDsRoKUUlFhZh8+ZQvFqrji607RO+JvuTZyQhu6UxjswmhhOlPCErOX+
         gutl6ozudboGLUDA4ni8fLJCdmUCWuGaiIg0v9BUqyTvtSkS57RQWqQdBqvheBBuqm2R
         LMTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fqExi90iI5/1xDquQimXuRN3cHs7UqsgQi3sQqbJ+7A=;
        fh=dxbsO0TEblRGru4LriNJe0p2BciSjlQkBGR7p4yXizs=;
        b=AkDyAZJgWnw873AT81B7Xw2tjtGKelC6O52L06d3sdHM+E1gqMWUNOROeJN1XTtP6M
         vdM9CXvWlcdJnwdwz072o+BzKs8emGXIsz+1fGktj5GhI0Yt7+G7cMeYnCe8hQG95F4z
         T9/yHqn8iIEuLg207nd/d2ZqkcERbgniGNs9LTzzrGYXDpI5JLw17obHwCgmgcEica9/
         RiumMiZbPk9GgvHcnSQsUeCvpupEjsReJdzKJ2bWRX+jkLeL2KpuWaEwhp/2apY6IDQf
         UW5yKbhgikIe3WupenKh/x17x/oN8GLBXgPhO4gm6boyXBQKUAm3/tcQVNzKl8sFu4IO
         fbfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1779796641; x=1780401441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fqExi90iI5/1xDquQimXuRN3cHs7UqsgQi3sQqbJ+7A=;
        b=vg142CJnAPX3CFFule8ljB5gSG4AeSEY8K9fFezfW1j0n90YNerZ1iUqo17Qa0kso4
         S/9Xa023TfTQgri6ScLaVjxlsDqkrH+XX2Wen/0/wM9+H6uSsfY3wysD1ARYdkCuuYhm
         c0KMk9act/41MK1DhXJNY7zZAJ8PXA8mJd5/NZglv/Fm+tTRhsBAtGapyp4fktleZaG+
         0s3VgIlG4M/Rp1ZanIXmjica7tYuswlREsnQ4va2yLmqJhO8u0w5H6IKfel802RCtfOQ
         ddKczPzv16/XvraF3WIuZoIxCHerRQoFt0fYnbnB6Kdp5r3yMpPPogUsz8nIFYIhMErb
         bFJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779796641; x=1780401441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fqExi90iI5/1xDquQimXuRN3cHs7UqsgQi3sQqbJ+7A=;
        b=flAE2j8voE3HJ0Pv1jZ7oD+pTQZNM0knyBKMGymSQcftaKA5i0hL0mzwOjEApNmdMK
         8sQcgnMAF0x+bw5FLmMhsCfjQgSSRRgMAciV8Zx0Fj9u/MNHnVs5LDotnF0YjWmNBZil
         iccJRq/704bI4sE7GvKvXII2/TFkekp3ZVlykA/DygUQNnk/a9qE6yxYFHd8c6NcOpvi
         oXQw0e9eMDRySWMOj71vXltGQtEFiUfywppWrS5XyY1qSxu00oiBZl+Ixz22YEKas75j
         heILr7VTD9J13gtwBqavLn0wJf6Tet/EshlhXhlAmHMgYOxno1Xy9cBCI5X73YR7iPBF
         cCww==
X-Forwarded-Encrypted: i=1; AFNElJ93e5SldBZoFeqB/1W9nz6gNgZp1Bauf50kxUO2tqpAhuHAC9C+gTliB+Qd6JPGZ4zKS1VAC3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDS+xDA3mCgjj8Ycl3qjDQ5WiehMfv03vCEJbXnDbqjk0a0IIF
	Ll6bHE+dbcAPmgUWbk/vCS/Iyp5797sY8eRu6eVHPiJzobPtnBKyloGAUedSS8rWJ1sfTUSS3a3
	FLkOw2Gz34tCzwUGfvdH8Ve68KQIsIizI7JGFeh4Z
X-Gm-Gg: Acq92OHSCpoRYsry7r7m+EshkCkhjBiEax7aWvpUboRwwrTGz91wCyCM1ojotkqeagm
	5MOFed5NvqL8pipx1b6NO72WjJoaQeE4e39q3hGVw2eDwDisfdiha6Qs/zkokMfCBK9ivQxW8d6
	v3k5Cn88nntEU8Qisobpp0R2SDqG23d4UqWFEcanNsA48DDknuFbZjTThxuPuV3XOqprHVY6QBY
	O7y8uf9VsdBR3GgMZzxSn5ZmS3KQ9Oy/fnawZWbFC45ZQQoX3wuRZZ0rPKGdh3ZTZ0v3OVLsMM2
	ZDAMNB8cBb5ZpSUmdzI=
X-Received: by 2002:a05:6a00:8d0:b0:838:29b3:9ed1 with SMTP id
 d2e1a72fcca58-8415f6b185amr17255143b3a.41.1779796640613; Tue, 26 May 2026
 04:57:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM0EoMkUPYSXKr2=+mR8YMq2a0TFdYPdzwPGob-UyU1fUWP9Ww@mail.gmail.com>
 <CAM0EoMkDwdmP94yeoX7W-DOY3Emcq84jGcPf73vtRTpDf1N3-w@mail.gmail.com>
 <CAM0EoMn-O7KU1R=b8jzb=DmMtRCuoEVmAH9hEsKehrdbmODAjA@mail.gmail.com>
 <CAM0EoM=sCnT69uPzB+HjOdRP9eQXVA+AcvPsBA80=dtQHi5sLQ@mail.gmail.com>
 <20260521073526.793d30c3@kernel.org> <CAM0EoMnvrAxGC=bty=ZUXG6XDN_hTNZiy9LSZhNicEdbe8DghQ@mail.gmail.com>
 <20260521084640.683c1ee6@kernel.org> <CAM0EoMmNWYzryfc5=4R0SkW+wfVhBxO3tAH+KeoMP3sPr6yrFA@mail.gmail.com>
 <20260522084611.390fd0a6@kernel.org> <CAM0EoMmKQc3oqDDiz5jGmwc8D3eTWd2wgst0MWEvXpPZHn-C7A@mail.gmail.com>
 <CAM0EoM=Db_AD1tqcG5w18pJKh8ysbUUHyzgP4c3thHTmeXLVyw@mail.gmail.com>
 <20260522175507.02b4fe83@kernel.org> <CAM0EoMkh3CF4EpNQDHUogxJLyqdw8gMFfvXQFOE+N4dLZY6gJQ@mail.gmail.com>
 <CAM0EoMnDjLJ=_+p+2xuHrbWFhtNCdQhONu21z_S7eZK+OFMibw@mail.gmail.com>
 <20260523094641.2bef6580@kernel.org> <CAM0EoMmOeqdwZnxAf0LNJSVVnJwJg=G5Ao3zqvC12J72WQeMtw@mail.gmail.com>
 <20260526104821.6eedb8ac@pumpkin>
In-Reply-To: <20260526104821.6eedb8ac@pumpkin>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 26 May 2026 07:57:08 -0400
X-Gm-Features: AVHnY4IbCXZTSjhbufLHzKWDbB1NBOmw1THg8PkPtvH-ReB58S7odm_O-VFVwMU
Message-ID: <CAM0EoMmF-f1ofy9rgktKC+fvuyT8=2Q5sWpYLktfkWxwm=9Mng@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: fix pedit partial COW leading to page
 cache corruption
To: David Laight <david.laight.linux@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Rajat Gupta <rajat.gupta@oss.qualcomm.com>, 
	netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us, 
	yimingqian591@gmail.com, keenanat2000@gmail.com, 2045gemini@gmail.com, 
	rollkingzzc@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-291677-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,vger.kernel.org,davemloft.net,google.com,redhat.com,resnulli.us,gmail.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 17B865D545E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 5:48=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Sat, 23 May 2026 12:57:08 -0400
> Jamal Hadi Salim <jhs@mojatatu.com> wrote:
>
> > On Sat, May 23, 2026 at 12:46=E2=80=AFPM Jakub Kicinski <kuba@kernel.or=
g> wrote:
> > >
> > > On Sat, 23 May 2026 08:13:21 -0400 Jamal Hadi Salim wrote:
> > > > > > @@ -474,8 +473,6 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct =
sk_buff *skb,
> > > > > >                 }
> > > > > >
> > > > > >                 *ptr =3D ((*ptr & tkey->mask) ^ val);
> > > > > > -               if (ptr =3D=3D &hdata)
> > > > > > -                       skb_store_bits(skb, hoffset + offset, p=
tr, 4);
> > > > > >         }
> > > > > >
> > > > > >         goto done;
> > > > >
> > > > > I see you are trying to get rid of the skb_header_pointer() /
> > > > > skb_store_bits() piece. Sure looks cleaner if we must linearize.
> > > >
> > > > The other thing (i may be over thinking) with pskb_may_pull is: if =
the
> > > > data is already linear (in a clone), wouldn't we corrupt the shared
> > > > linear data of the clone?
> > >
> > > I said
> > >
> > >   for the portion of the problem that's "we are writing to frags"
> > >
> > > IOW not replacing the rest of the patch (assuming we care).
> >
> > So as an alternative to the piece i posted? i.e this:
> >
> > diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
> > index 79921b8d89ba..8f0f84b50c85 100644
> > --- a/net/sched/act_pedit.c
> > +++ b/net/sched/act_pedit.c
> > @@ -474,6 +474,12 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff=
 *skb,
> >                 if (write_offset < 0) {
> >                         if (skb_cow(skb, -write_offset))
> >                                 goto bad;
> > +                       if (write_offset + (int)sizeof(hdata) > 0) {
> > +                               if (skb_ensure_writable(skb,
> > +                                               min_t(int, skb->len,
> > +                                                     write_offset +
> > (int)sizeof(hdata))))
>
> I don't think that needs to be min_t(), a plain min() will do.
> (Possibly with the (int) cast removed from the sizeof.)
>

what is the benefit? would min() allow a mixed type (eg skb_len not being i=
nt)?

cheers,
jamal

> -- David
>
> > +                                       goto bad;
> > +                       }
> >                 } else {
> >                         if (unlikely(check_add_overflow(write_offset,
> >                                                         (int)sizeof(hda=
ta),
> >
> > cheers,
> > jamal
> >
>

