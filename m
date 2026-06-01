Return-Path: <netdev+bounces-293612-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id bczlLUlCHWpJXwkAu9opvQ
	(envelope-from <netdev+bounces-293612-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 10:26:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC66A61B711
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 10:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 764D4300F263
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 08:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DDA389DF3;
	Mon,  1 Jun 2026 08:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="jQsUFuAE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE53638887D
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 08:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780302399; cv=pass; b=Wb7gmfq9oUdR5up7Ql1nSU62ykkdCOMWFCNXNZjam0ws9jmexuhkd8Wwfd8KoeZrr3mCjWpCM78pmAnA5/37ztZbU1rG/LnwKcXrmj9kr5H2i4vtSOSaX2jMh5/5xL2LFEkWQpGob22PTjxVS5TSVvE0FiqRe1VsZ5L5TkmUFLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780302399; c=relaxed/simple;
	bh=rTpz9XB4u7oVrgD+xlX9MxcizZpCPXWTIaEPl24OhKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Easjo85W8n2e4ZEUEB81k2MTU/cHWsgO8/4iAjloz3hK010IwY7+rr8hZeB/It0PDzcnbDbmc3xLbtRyCAt6In1nzOOi/mG4eMU4JrFpW1KUnD7OnOdETf7qMoieYwPPVPNtrAFAZAD05+S0SxGyVLrclvKQ6+tM7GzCOEdfQd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=jQsUFuAE; arc=pass smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8419ab3a297so3007914b3a.2
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 01:26:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780302396; cv=none;
        d=google.com; s=arc-20240605;
        b=gEW1NmK7Co30zND35OxhJuepjvv30/oyT/l75jGuA+NYMumcy3LJHyb2RhuFUFCp18
         tmgzQU3ra4kdlxce0ZtlLpe1NaYlI2tfUiB+9YXigUWRdYHGevSuRoQqKC7sfK8OlA0r
         nIBvfQQuzkCPYg91A639Jgxg5wRpm20lvXZHn7lpy+1/zz6rM5tuQOVUkMqTUv4LUnJt
         89uG5r3LPrQmWJlQSI3lk1s5awQ0ZPhO9L2+z8kYtHcuxWVnyQULhTstASqu4wthbelJ
         qc5Ek0Df1YUenY81HozD7e/sV9br9u1mh04l3Tw6OkK0ZlKmkaweila6dXejMeiTXHbv
         47Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8kXinw/e+owotkd2EPS20C4MJ1Z0/naQ3L5ySeyJKio=;
        fh=lHH5UxlI6QpuRMa2e0O4FidJXT2wDgkl1d+ppxyp5IA=;
        b=GiHqJ6cXKjz7rbfxOEiFojzyXzOWX67hkwYOg8vX+XeT7S1qv2e17fV460p7ppknUo
         0cnAPFe0QXR9NAAuD6i0Hl0I28wnrX+85tipA2RjLph8S1s5ZA/b1xqKzrDwZXG7j2kf
         930p6ZzTUV16dp7JT7pLUoc5sC5keIYp5fN7EW4Jkzf5Zipnz/KJHPsdqk4dB6JUQVrQ
         obEb9uOuOFG8xveJDkyEefhwaiMdhJ1nwVV9sqBVEf+KfdX9xgYCGAjme+StJqorCKUG
         LQUaDrAcnVao6uuL9tUrk/MyP0OQ/RxWYFZD9TxlhKLjYwkUarLmGVGCacRhy051Sl84
         oWJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1780302396; x=1780907196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8kXinw/e+owotkd2EPS20C4MJ1Z0/naQ3L5ySeyJKio=;
        b=jQsUFuAEdpr2nACAlTavbgC3pV9jONXj9U2dyXGnj72aNd9sFmoSxOvoavYtYiBxyh
         FQvyDhMb0ct5EdR/vU17J08c1enSPoSuq0B0GMZgZiOMShmzJysmysft3NaYSMRmpnTH
         z2vZRr1/W584EuYZs6+f7F59rGVsaGILU0+io=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780302396; x=1780907196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8kXinw/e+owotkd2EPS20C4MJ1Z0/naQ3L5ySeyJKio=;
        b=fIRdzZCvXSBvzgIy2UEdhkz+CEoBuM4K9hbIyR+WIMstJYHDD7BISOUmrgjFyEYCAb
         CeCx9x8LlGw6VqbNWnpPzA4E5t14n3I6FpIvNJ9xR6tD11PWOYqQIId4zETnM5LfKK5V
         E1kN2NVJiHG0Jt+yLJxBMEz8/uSR2++dqXFmMh0E1DjoXhyc+QPqwmITs1r9r35SxD9i
         drD6N2y/wuf4bx0Fpgd2Zi56WIcG3La/fbUJ4tfOCPN7rwq4XTg2psdBwdIHAPVao5Md
         6KchsGyYDPsa6fZrm2oFrTsQIkcC4Q5Xi5QbddeHVDMWSNJRkDOYvlYeA1L9onXAvIF3
         yatg==
X-Gm-Message-State: AOJu0YzRxaBrGe/ZsfTj+LOgXeeqKkW+kID0pxgeJoAzE+29BwqFCtCf
	T46uX2b7rz1AXgMvoppR5mkYxbu29cYUc7MyLo23TQqb/VLzsskL+bCnJEv0XmFrwHHDWpFpQ7U
	SbsERlHHKaJURSH202jyU2haw1fn5Sk8PEuCqPk+j
X-Gm-Gg: Acq92OGwRJn3NzG6orZPt1v/EWTrVLbxK5RqVjPB7igIJ6mTDZTpYJtnClIowhUyKJ9
	+NSQzA3gikwtmpWgbMVPIYbPKJ/NC2Nnfy83zQSK6d2viRkSo3wh8mTZWKkcggZtfdsgsSnMLMh
	e4JxQ0ifFEtLE6D4vj0vwIUN+Wn9MSEJPj5eeE8N2L1CG72mBM7Tz1Sn2intLm7wc7U5EnLwz1c
	quN2G84v5O6yXpjK+rCJ0k3st63AzVbzHbXxLJR0r6/uXgqKaBQhJ3/YbtHarx1M87kS0AHcMiq
	AfYKkHj58DtIRAgSyQw=
X-Received: by 2002:a05:6a00:1745:b0:842:57e8:1bda with SMTP id
 d2e1a72fcca58-84257e83a0emr2259511b3a.19.1780302396146; Mon, 01 Jun 2026
 01:26:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531123221.48732-1-jhs@mojatatu.com> <20260531171534.6aae381a@pumpkin>
 <CAM0EoMnKxEuexh43U7v8s3UwNfr5B=jXUQxw_fCw_tB-Li39cA@mail.gmail.com>
 <20260531194241.7d5d7e6e@pumpkin> <20260531195218.5fe29990@pumpkin>
In-Reply-To: <20260531195218.5fe29990@pumpkin>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 1 Jun 2026 04:26:24 -0400
X-Gm-Features: AVHnY4J30oTNnQBTk-TRm92SP1-NWzFgvjnDB_8_SGtTmRHGng6_DsqxN8mrPC8
Message-ID: <CAM0EoMk6kKVMrbr0dywSEMoAohtKzYv3DcLQ3Bk9zdBitn5JHQ@mail.gmail.com>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[mojatatu.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293612-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,mojatatu.com,gmail.com,oss.qualcomm.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: AC66A61B711
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 31, 2026 at 2:52=E2=80=AFPM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Sun, 31 May 2026 19:42:41 +0100
> David Laight <david.laight.linux@gmail.com> wrote:
>
> > On Sun, 31 May 2026 13:25:36 -0400
> > Jamal Hadi Salim <jhs@mojatatu.com> wrote:
> ....
> > > >
> > > > > +                             goto bad;
> > > > > +                     if (skb_ensure_writable(skb, min_t(int, skb=
->len,
> > > > > +                                                        write_le=
n)))
> >
> > You've completely missed that the above has to include the write_offset=
.
>
> And I've missed that write_len isn't the length you are going to write :-=
(
>
> This version is unreadable....
>
> A few one line comments can make all the difference.
> I put these two in for a reason.
> It took some effort to find out exactly what they did.

Double check this so i didnt miss anything you said.

--------
diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
index bd3b1da3cd63..1607aaff3ed6 100644
--- a/net/sched/act_pedit.c
+++ b/net/sched/act_pedit.c
@@ -394,7 +394,7 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *skb=
,
        tkey_ex =3D parms->tcfp_keys_ex;

        for (i =3D parms->tcfp_nkeys; i > 0; i--, tkey++) {
-               int write_offset, write_len;
+               int write_offset;
                int offset =3D tkey->off;
                int hoffset =3D 0;
                u32 cur_val, val;
@@ -447,23 +447,16 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *s=
kb,
                        goto bad;
                }

-               if (write_offset < 0) {
-                       if (skb_cow(skb, -write_offset))
-                               goto bad;
-                       if (write_offset + (int)sizeof(*ptr) > 0) {
-                               if (skb_ensure_writable(skb,
-                                                       min_t(int, skb->len=
,
-
write_offset + (int)sizeof(*ptr))))
-                                       goto bad;
-                       }
-               } else {
-                       if (check_add_overflow(write_offset, (int)sizeof(*p=
tr),
-                                              &write_len))
-                               goto bad;
-                       if (skb_ensure_writable(skb, min_t(int, skb->len,
-                                                          write_len)))
-                               goto bad;
-               }
+               /* Check that any needed headroom is writeable */
+               if (write_offset < 0 && skb_cow(skb, -write_offset))
+                       goto bad;
+
+               /* Ensure the skb is writeable upto to the end of the area =
to be
+                * written. Note: that data is pulled into the skb header
+                */
+               if ((write_offset >=3D 0 || write_offset +
(int)sizeof(*ptr) > 0) &&
+                   skb_ensure_writable(skb, write_offset + (int)sizeof(*pt=
r)))
+                       goto bad;

                ptr =3D (u32 *)(skb->data + write_offset);
                cur_val =3D get_unaligned(ptr);
--------------

And please _no more_ changes after this. I will only make these
changes if the bots complain about something meaningful.

cheers,
jamal
> > >         /* Ensure any needed headroom is writeable */
> > >         if (hoffset < 0 && skb_cow(skb, -hoffset)
> > >                 goto bad;
> > >         /* Ensure the skb is writeable to the end of the area to be w=
ritten.
> > >          * The data is pulled into the skb header. */
>
> -- David

