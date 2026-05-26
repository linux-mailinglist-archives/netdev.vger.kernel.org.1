Return-Path: <netdev+bounces-291722-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFIfK/OuFWpkXwcAu9opvQ
	(envelope-from <netdev+bounces-291722-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 16:32:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 119775D79B2
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 16:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C34D30421FB
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 14:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CA4401A3C;
	Tue, 26 May 2026 14:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="yCq+mB8W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF31B3FF8A9
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 14:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779805356; cv=pass; b=MeMckkbICRJn87CvWf7pvf3ueER8+lD55hF7YzirfUwzWt6d6ik2X9kmrehBGp0eaxEOKmR4giHckNw1zHKM8gIuiPCdhauTM5fhFvAPELr3wee/k6CiiR5yXSH6x1hF2OsTYReax66Kb2KfLEyND6R9/xJrstUtC9YKjxcoIFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779805356; c=relaxed/simple;
	bh=8uvNGrjg6IJjrRbxYeaRAjT4F6EI/rCBizESSHUU1Yg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lncGcvEtv6wrJioq03jhCDqkAkNcdosik33k8NOQgF4WXYwBb5ni3TALy4t1TTZYa+3e3vEeCNtb/VLSV7+CLCoz6hzhkSXJGy4FxBvRhO9c04xinos8advNU3IK1Z9BxMepQidOutc1ZJDb2E56B88GH0Hro+I6MiRTyKSwEWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=yCq+mB8W; arc=pass smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c8532ba6c95so836614a12.0
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 07:22:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779805354; cv=none;
        d=google.com; s=arc-20240605;
        b=K/GgK/u3m+eK8mpFvhwf60+0GLCnBDpAiME4cXz3slrXWeVnxeNaqBzH9n/mu6pt2l
         4CEcpyUZehP/1ySngIOXb2jKHV+JJ28+kykDIQMAMJ22bQotglyVEJQLxv8RCrInTmNB
         WTMUIyKGfhTYQ54q6xv99OQFzregr50yoTK0S/QQBhflxeklzM4bDTwToPQcLAWcWe5u
         cu3GsljxNRDIp9KXr0g57M5O4+IMcrG4i+IrBMoIxO/llhn/JmXsDyH62M4z9M+voTjV
         sLt4ysZPTJSYeX99Wqrk+eDi8v7UpSbnhsJAvyTmIayQDTTObbCQgcR/oRDzwOoPSF5T
         tA+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OEHFz3cEwtfVE8XMTOoGKejoe7bNnocDK/MceuEC4NA=;
        fh=LKiJTJkVYm/ybIJds/SREy6q/4+LqmTxeep2fg5PuZI=;
        b=bmXb+UMrA+vlT/4FnE7LHVPjyIQPk3RcoEq1oRPf3JJ+90led5Z2NhVRpW3fxMB7hP
         nzqkgPfM2GZgqk76jy3/dWrolGiSDxa5Po/p1KjZp45gcTwSQcl3OMqxqLx0jSK6ne68
         lg0kWCEvM7H8vGU4tS6MmRw/hqtwXnBtEy9+DK6Vt7o8QEg+vUMhtkvGm+hfMUzDx62l
         KGCQKflzVqdtrKQa0Q4PnQnepmMopm8mEG2xjtB8edUZ+7lsFLwu7143PMbWVC8yfjrK
         J6l/RKdFzdjpCb/QWHjsHoLe7my9F+ZO43FyRYG+VVFwlP10Vw8t6YHQxHOmS3T3a6OG
         sT4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1779805354; x=1780410154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OEHFz3cEwtfVE8XMTOoGKejoe7bNnocDK/MceuEC4NA=;
        b=yCq+mB8WvmFIdXTUxNusob0eBZfkIVg4J6i4YZYULuEjwPUd7DdcALTTMziCFsvdkR
         GKVs9o97+DNT2O+jrnhOwrdliYm9lP44T1Ioom01eTXzTBSKQy+S9SnNOtm/27ftks2k
         3G/3vBIJCXo9wL5Ltxb2DF/wYPOtD33WUCDyc/YaWQbksOHVYxYhRe8vMsIEnC4q1hv2
         +AZL0gtgc2zeWIJsIIELCNlSNQrgZ7W3HsFyR32PeQP5A9vd4HTU6nmukoQP5C6LTk3/
         JoLV2KiMteFSAaDECFzIUNkMs6+ykdJCxqwUE9cR2LRA0Sym04+N0nxRTB8O5fZeqZ/b
         kltA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779805354; x=1780410154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OEHFz3cEwtfVE8XMTOoGKejoe7bNnocDK/MceuEC4NA=;
        b=oeCt4pw2VItz3TXhAQl7lR54n0YPYbZQyxIQkDjHYGlbDsACki0Fo8WSl1V0Kc+2PX
         ra588ucP4340qaaZ/lB6GTxhyh1yhHKBntvH4Jjatl3EYp6qTv9WYID4Sl3rjo3eBzVW
         13yvSjo0xSpnDjgSJ6ympIi3WCEAnZxAezKVQZCvoONqNF8e5dq3QvtlROCcgYPe/Qyl
         +XurQ7jYpfmE9GD1G2s5tbRrsq/1CiCuznrGSu1p8UYKueCdcWkXPWB7ClNuA/h4qYXM
         EYF4UI3LuwNViGszm0eEpE/+ERlBxeco43H8G4GPFOIth0WrRseRzb2dbn1d2aKZ4WB3
         Woow==
X-Forwarded-Encrypted: i=1; AFNElJ8VFj+9qMnR65Jfpq6D9dXKitI+DhFlQBj3fdgg1q0wg4/j8ZhmP7AcpsF6D5h6ZPsAm2W/YUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YysCKZrYLZsWwSOrjHLUOlkKxSLTmQQ25dnxhBExsu/v4jLCao9
	TKGpNyCWkPYlqR/6yoQ590aFNGcgilVp5aycIW7hMHqiYoG5muPkccVCmWD9AS7UmMbgvJu8BIg
	aEtTAyjYkJJ8Ny9c5h274htofzFWVqnEaL5AE+TJ0IlUKzs8jmTSdLOmC
X-Gm-Gg: Acq92OFSKkRiWB2cfqfrE4UbOFysjwgCMTh3yhDSMvRFHJPn+rHWhha6qyj1JwlGxDJ
	wL2UpRBPl5nLd51tWJMtBIVRGx1ASd5t08cZcu/fzyEGeIU/o6Gcsw/+xxJFc9B1BF1WjrrBq0R
	PPcMXRP147luBaRunFLAKcEVkdcCXphs6VTCGZfx1VSFkwg7Tnp+7crpvA+qauK89LlRi3N6lBt
	4nq4YBQPhyvixTqfsKLzK15gga8TMDE+TDY+P/4AAU+/DShlS/E8pcJmw0bLKLES0Uh/M7GBuvW
	xX1DNi8nmzlOFBOSSUY=
X-Received: by 2002:a05:6a20:9396:b0:3a0:b781:4c80 with SMTP id
 adf61e73a8af0-3b328cababdmr20093724637.4.1779805354036; Tue, 26 May 2026
 07:22:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM0EoMkUPYSXKr2=+mR8YMq2a0TFdYPdzwPGob-UyU1fUWP9Ww@mail.gmail.com>
 <CAM0EoM=sCnT69uPzB+HjOdRP9eQXVA+AcvPsBA80=dtQHi5sLQ@mail.gmail.com>
 <20260521073526.793d30c3@kernel.org> <CAM0EoMnvrAxGC=bty=ZUXG6XDN_hTNZiy9LSZhNicEdbe8DghQ@mail.gmail.com>
 <20260521084640.683c1ee6@kernel.org> <CAM0EoMmNWYzryfc5=4R0SkW+wfVhBxO3tAH+KeoMP3sPr6yrFA@mail.gmail.com>
 <20260522084611.390fd0a6@kernel.org> <CAM0EoMmKQc3oqDDiz5jGmwc8D3eTWd2wgst0MWEvXpPZHn-C7A@mail.gmail.com>
 <CAM0EoM=Db_AD1tqcG5w18pJKh8ysbUUHyzgP4c3thHTmeXLVyw@mail.gmail.com>
 <20260522175507.02b4fe83@kernel.org> <CAM0EoMkh3CF4EpNQDHUogxJLyqdw8gMFfvXQFOE+N4dLZY6gJQ@mail.gmail.com>
 <CAM0EoMnDjLJ=_+p+2xuHrbWFhtNCdQhONu21z_S7eZK+OFMibw@mail.gmail.com>
 <20260523094641.2bef6580@kernel.org> <CAM0EoMmOeqdwZnxAf0LNJSVVnJwJg=G5Ao3zqvC12J72WQeMtw@mail.gmail.com>
 <20260526104821.6eedb8ac@pumpkin> <CAM0EoMmF-f1ofy9rgktKC+fvuyT8=2Q5sWpYLktfkWxwm=9Mng@mail.gmail.com>
 <20260526140810.0219955b@pumpkin>
In-Reply-To: <20260526140810.0219955b@pumpkin>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 26 May 2026 10:22:21 -0400
X-Gm-Features: AVHnY4K_kbXfsCJ0OGrJQ4gRmceh84HJ6UhWkC_lRxgMeJDVthdCNl_M3NGhhW4
Message-ID: <CAM0EoMm5pE7pQ6GsZxDd7zzApcr+EoeadCa_PgJw70SA73hpjQ@mail.gmail.com>
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
	DMARC_NA(0.00)[mojatatu.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291722-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,vger.kernel.org,davemloft.net,google.com,redhat.com,resnulli.us,gmail.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,mojatatu-com.20251104.gappssmtp.com:dkim,mojatatu.com:email]
X-Rspamd-Queue-Id: 119775D79B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 9:08=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Tue, 26 May 2026 07:57:08 -0400
> Jamal Hadi Salim <jhs@mojatatu.com> wrote:
>
> > On Tue, May 26, 2026 at 5:48=E2=80=AFAM David Laight
> > <david.laight.linux@gmail.com> wrote:
> > >
> > > On Sat, 23 May 2026 12:57:08 -0400
> > > Jamal Hadi Salim <jhs@mojatatu.com> wrote:
> > >
> > > > On Sat, May 23, 2026 at 12:46=E2=80=AFPM Jakub Kicinski <kuba@kerne=
l.org> wrote:
> > > > >
> > > > > On Sat, 23 May 2026 08:13:21 -0400 Jamal Hadi Salim wrote:
> > > > > > > > @@ -474,8 +473,6 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(str=
uct sk_buff *skb,
> > > > > > > >                 }
> > > > > > > >
> > > > > > > >                 *ptr =3D ((*ptr & tkey->mask) ^ val);
> > > > > > > > -               if (ptr =3D=3D &hdata)
> > > > > > > > -                       skb_store_bits(skb, hoffset + offse=
t, ptr, 4);
> > > > > > > >         }
> > > > > > > >
> > > > > > > >         goto done;
> > > > > > >
> > > > > > > I see you are trying to get rid of the skb_header_pointer() /
> > > > > > > skb_store_bits() piece. Sure looks cleaner if we must lineari=
ze.
> > > > > >
> > > > > > The other thing (i may be over thinking) with pskb_may_pull is:=
 if the
> > > > > > data is already linear (in a clone), wouldn't we corrupt the sh=
ared
> > > > > > linear data of the clone?
> > > > >
> > > > > I said
> > > > >
> > > > >   for the portion of the problem that's "we are writing to frags"
> > > > >
> > > > > IOW not replacing the rest of the patch (assuming we care).
> > > >
> > > > So as an alternative to the piece i posted? i.e this:
> > > >
> > > > diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
> > > > index 79921b8d89ba..8f0f84b50c85 100644
> > > > --- a/net/sched/act_pedit.c
> > > > +++ b/net/sched/act_pedit.c
> > > > @@ -474,6 +474,12 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_=
buff *skb,
> > > >                 if (write_offset < 0) {
> > > >                         if (skb_cow(skb, -write_offset))
> > > >                                 goto bad;
> > > > +                       if (write_offset + (int)sizeof(hdata) > 0) =
{
> > > > +                               if (skb_ensure_writable(skb,
> > > > +                                               min_t(int, skb->len=
,
> > > > +                                                     write_offset =
+
> > > > (int)sizeof(hdata))))
> > >
> > > I don't think that needs to be min_t(), a plain min() will do.
> > > (Possibly with the (int) cast removed from the sizeof.)
> > >
> >
> > what is the benefit? would min() allow a mixed type (eg skb_len not bei=
ng int)?
>
> min_t() is really a broken idea.
> You wouldn't really write:
>         if ((int)skb->len < (int)(write_offset + (int)sizeof(hdata)))
> which it what it effectively expands to.
> IMHO it was always better to cast the one side that was 'wrong'.
> Then there wouldn't be all the broken/pointless max_t(u8, x, 255).
>
> Here min(skb->len, write_offset + (int)sizeof(hdata)) is actually likely =
to
> be allowed even though they types are unsigned and signed because the
> compiler knows the preceding 'if' stops negative values getting through.
> (Sometimes the KASAN (etc) builds (randomly) error such cases.)
>
> But min(skb->len, write_offset + sizeof(hdata)) will always be fine.

So i am looking at min(a,b) macro
It does a strict type check to ensure that both arguments have the
same _exact_ type.
But i will take your word for it since you seem to be keeping on top
of these things.
I will update this in the next patch. And if the test passes i will post

cheers,
jamal

> Both sides are unsigned, a negative 32bit write_offset is sign extended
> to 64bits before being converted to unsigned (as 2s compliment) and the
> sum is positive.
> But the compiler might not do CSE with the previous condition.
>
> -- David
>
> >
> > cheers,
> > jamal
> >
> > > -- David
> > >
> > > > +                                       goto bad;
> > > > +                       }
> > > >                 } else {
> > > >                         if (unlikely(check_add_overflow(write_offse=
t,
> > > >                                                         (int)sizeof=
(hdata),
> > > >
> > > > cheers,
> > > > jamal
> > > >
> > >
>

