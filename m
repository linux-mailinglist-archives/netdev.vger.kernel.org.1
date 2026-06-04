Return-Path: <netdev+bounces-295154-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uZt5HO9OIWoDDAEAu9opvQ
	(envelope-from <netdev+bounces-295154-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 12:09:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 785FC63ED8F
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 12:09:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mojatatu.com header.s=google header.b=OD49IduL;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295154-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295154-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E10203038F41
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 10:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C753859D9;
	Thu,  4 Jun 2026 10:02:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0D638B131
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 10:02:03 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780567325; cv=pass; b=AAt/vsOXFj1l8Mj8Myd1J+X+V5RGWH09X3Wtjk5STBRGw8sslDC7JpEtEXdKpyHa9c2EDT9uk273RXbAgoJz6ia2gkKS6TLmye4LuwBw2AYymj7mySpwwe77RZ4kLf5BKAstPvHdj43ew1IUzISzUoZV5Q1IuEAhFu8eLUTk7Zk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780567325; c=relaxed/simple;
	bh=ic/+w6cGowS7OJYM/kUIzB4/OBe0hfhciqm2XkWXD8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yezg9LCpLbmb6IVl3Tfvfq04fPgb/5LHqzfhHNdJ5lZAe23VackgPQtZHZLsaNzQBEY5+h765KkF9OTq32eIyU6sK1QB+1nOYu9BFXBBLQFKsS1mEKbKgv0gQPSbhXOTAH4GsKRb8p2GmjUE5enTv8g73fNICWMpg5+xjSOAefo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=OD49IduL; arc=pass smtp.client-ip=209.85.215.171
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c8588f8fef3so190994a12.0
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 03:02:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780567323; cv=none;
        d=google.com; s=arc-20240605;
        b=cyNI6zalDkMsCs6HFoO1uUizTKmzPqS3Ljdd1glBSUZbTjXz3RYEA9ysaej5VjsGyc
         q4S4kQOqr8X8bbwmVfvE9JjUknt880wrUoEXPMNKFRwq9+2WWVcac/cGPWBDRboooEOq
         mAOS6CsbA063f7+v/LtPnZCfmLH23meR3hRZbqnI45e9w3VYnT3Jfc+EvtzG2GUV9q+B
         ruqyp8tMz0G+GbxUT08NOUoFxlgtVemmL+C15QtYXrsNWyGE8t06jFQmooewd1nRl9Z4
         Lo3FYwwSxwiGdNn8C+w3L4Yk5e/PbfLRkyuo7TZvOzTt3F+xwRFUNjKu7ZXNJnAcpvZT
         1cRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NRcxgifGhvHZQZIl+sply2NivzPXDyfDGDIFxkwyRtk=;
        fh=lHH5UxlI6QpuRMa2e0O4FidJXT2wDgkl1d+ppxyp5IA=;
        b=VOZ0IoZYaBzJxBG7ZhkY/UyPMBYC6QHjYkvZDAIN+qmxptULgS3AnAgoiASkHHgUa8
         uVzWedoy4wjAfMSwUoCiDdGy9VuTn1TNWAPcILJn4wBwJK+sd2IrPTwxRmL6eDw5O7Di
         WppzvndYsjXDrXxu8wXyf1dYpfY1whUMh7XzyocYf3Bz0xkJyJA2RxAXCcm5lDGYHxGh
         zlY68xQJsCfZI5JL0KK4RdzV8HjEc0GcZZ/wRc+LjuE2atibDj7WzH8LFqiHu8Qanz07
         8mQtdEJL6DBlOu9GLWNNATOUr01JKutiTzG/y1Mwf7Tvo1s2+Sp3iK5nKpc0HzKL7H8L
         Z45Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1780567323; x=1781172123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NRcxgifGhvHZQZIl+sply2NivzPXDyfDGDIFxkwyRtk=;
        b=OD49IduLdrXHOzOXkjC/GPHGWk64UQfNJI1k6BncfUb5YBM7I/fDnY5/P/+e6mg9zi
         9ZUGy7T781UXKAoPSLNa7nGOrkSi63dBL8TN+XoMo/vXMlSQtrFkYLUENjayNylNOta/
         5l8xegQCg1+LCdG6LGFOLPapl7aTrHZpjuSqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780567323; x=1781172123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NRcxgifGhvHZQZIl+sply2NivzPXDyfDGDIFxkwyRtk=;
        b=NsBtOUlGH9nQaY7qRtEuRUdEstDcZmNtva+avyv8azqpUrRC2KIDEdXXz4uMFaNboX
         llb+dP+pAZMBZvNOzxE2JtcpTuUqu40VVL/MTHda1yWgMD1OHIlNrVnxzIK7poGEYGd3
         ZLoSJhGsXrYA6Uqx1hH8lxodrrgOK1RCUoKbTmoGU8mnJu2VNeyN/+8G8GJYvvlmEKjN
         M+RWdxSHNAfSccOGYnWdhC/mCdVfudS+Bd74SruMpDcNsZlcIKVPCm4gP62YcMjrBpjI
         saLTygkR2aTabSEJISWyEQAD0fuUsf8iX69D87ZViSSE4VLBDUJyZC6Qkqhx7UwhSQvX
         Ne2g==
X-Gm-Message-State: AOJu0Yygx1BAri5JI+Jer6M+woX8pOIVOKqoVLrLA8qgHDvQFtVoIAlb
	1pB5oT5yHlhz3RK35DVTI6gU2miEOCHKg6foLmOvWEkGulsnljbrfcHYN8/ORsi9W8w6TsMAPuG
	u2JN7FibfLe+fiZ+qpFLQzjlITA3ZcceqSlpkJN5C
X-Gm-Gg: Acq92OHRZJ89IOdzXiY7ZUHq4B4zfACv4H8KCW9qeDwOUt1ILbxUvSSEK89ZmCOupr1
	7EjftHmlqjwuMz2eKxERg7PzJK8dVzvzFM4pb1fF7IfyjNBeBUOsBw9MIzJO4ZVSwZdmY3svIoD
	3Ip94KRWxxnc9DKYnosGZLxlC/o4tcvLj/6J4eYexwj1cEcjscVPCgW4oqEHEHeh5zwBVP7Xi+p
	H7j1anRIjY9l2A4biYYQrksNWZTkrtlxUiqvWh5Ie4dmbEMosd4IT5KCsr/iekDIOCWdCUdFvj/
	ncU2DOscLWcBzUdhn5ullwCUz4LKvQ==
X-Received: by 2002:a05:6a20:2d08:b0:3b4:6026:6c5d with SMTP id
 adf61e73a8af0-3b49734fc6emr8197284637.5.1780567323006; Thu, 04 Jun 2026
 03:02:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531123221.48732-1-jhs@mojatatu.com> <20260531171534.6aae381a@pumpkin>
 <CAM0EoMnKxEuexh43U7v8s3UwNfr5B=jXUQxw_fCw_tB-Li39cA@mail.gmail.com>
 <20260531194241.7d5d7e6e@pumpkin> <20260531195218.5fe29990@pumpkin> <CAM0EoMk6kKVMrbr0dywSEMoAohtKzYv3DcLQ3Bk9zdBitn5JHQ@mail.gmail.com>
In-Reply-To: <CAM0EoMk6kKVMrbr0dywSEMoAohtKzYv3DcLQ3Bk9zdBitn5JHQ@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 4 Jun 2026 06:01:49 -0400
X-Gm-Features: AVHnY4I60A9lIAWdg6mITvTSq0M_Rl-Nl1GETKFPLrHwi6HYZZK4EXtvLYN6jkI
Message-ID: <CAM0EoMkuBaLfCJiMZBCEnJ+_ecTW_2fMeZF+1KPzroNtojj0GQ@mail.gmail.com>
Subject: Re: [PATCH net v5 1/1] net/sched: fix pedit partial COW leading to
 page cache corruption
To: David Laight <david.laight.linux@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us, 
	victor@mojatatu.com, yimingqian591@gmail.com, keenanat2000@gmail.com, 
	2045gemini@gmail.com, rollkingzzc@gmail.com, toke@redhat.com, 
	dcaratti@redhat.com, security@kernel.org, linux-kernel@vger.kernel.org, 
	stable@kernel.org, Rajat Gupta <rajat.gupta@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_RECIPIENTS(0.00)[m:david.laight.linux@gmail.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:jiri@resnulli.us,m:victor@mojatatu.com,m:yimingqian591@gmail.com,m:keenanat2000@gmail.com,m:2045gemini@gmail.com,m:rollkingzzc@gmail.com,m:toke@redhat.com,m:dcaratti@redhat.com,m:security@kernel.org,m:linux-kernel@vger.kernel.org,m:stable@kernel.org,m:rajat.gupta@oss.qualcomm.com,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-295154-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,mojatatu.com,gmail.com,oss.qualcomm.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 785FC63ED8F

On Mon, Jun 1, 2026 at 4:26=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com> =
wrote:
>
> On Sun, May 31, 2026 at 2:52=E2=80=AFPM David Laight
> <david.laight.linux@gmail.com> wrote:
> >
> > On Sun, 31 May 2026 19:42:41 +0100
> > David Laight <david.laight.linux@gmail.com> wrote:
> >
> > > On Sun, 31 May 2026 13:25:36 -0400
> > > Jamal Hadi Salim <jhs@mojatatu.com> wrote:
> > ....
> > > > >
> > > > > > +                             goto bad;
> > > > > > +                     if (skb_ensure_writable(skb, min_t(int, s=
kb->len,
> > > > > > +                                                        write_=
len)))
> > >
> > > You've completely missed that the above has to include the write_offs=
et.
> >
> > And I've missed that write_len isn't the length you are going to write =
:-(
> >
> > This version is unreadable....
> >
> > A few one line comments can make all the difference.
> > I put these two in for a reason.
> > It took some effort to find out exactly what they did.
>
> Double check this so i didnt miss anything you said.
>
> --------
> diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
> index bd3b1da3cd63..1607aaff3ed6 100644
> --- a/net/sched/act_pedit.c
> +++ b/net/sched/act_pedit.c
> @@ -394,7 +394,7 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *s=
kb,
>         tkey_ex =3D parms->tcfp_keys_ex;
>
>         for (i =3D parms->tcfp_nkeys; i > 0; i--, tkey++) {
> -               int write_offset, write_len;
> +               int write_offset;
>                 int offset =3D tkey->off;
>                 int hoffset =3D 0;
>                 u32 cur_val, val;
> @@ -447,23 +447,16 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff =
*skb,
>                         goto bad;
>                 }
>
> -               if (write_offset < 0) {
> -                       if (skb_cow(skb, -write_offset))
> -                               goto bad;
> -                       if (write_offset + (int)sizeof(*ptr) > 0) {
> -                               if (skb_ensure_writable(skb,
> -                                                       min_t(int, skb->l=
en,
> -
> write_offset + (int)sizeof(*ptr))))
> -                                       goto bad;
> -                       }
> -               } else {
> -                       if (check_add_overflow(write_offset, (int)sizeof(=
*ptr),
> -                                              &write_len))
> -                               goto bad;
> -                       if (skb_ensure_writable(skb, min_t(int, skb->len,
> -                                                          write_len)))
> -                               goto bad;
> -               }
> +               /* Check that any needed headroom is writeable */
> +               if (write_offset < 0 && skb_cow(skb, -write_offset))
> +                       goto bad;
> +
> +               /* Ensure the skb is writeable upto to the end of the are=
a to be
> +                * written. Note: that data is pulled into the skb header
> +                */
> +               if ((write_offset >=3D 0 || write_offset +
> (int)sizeof(*ptr) > 0) &&
> +                   skb_ensure_writable(skb, write_offset + (int)sizeof(*=
ptr)))
> +                       goto bad;
>
>                 ptr =3D (u32 *)(skb->data + write_offset);
>                 cur_val =3D get_unaligned(ptr);
> --------------
>
> And please _no more_ changes after this. I will only make these
> changes if the bots complain about something meaningful.
>

I note that the patch hasnt been applied yet. Since none of the
sashiko's found an issue I wasnt planning on re-iterating the patch as
i stated above to avoid the review again, test again cycle.
Paolo/Jakub ..

cheers,
jamal

