Return-Path: <netdev+bounces-291689-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHIdKvKWFWqNWgcAu9opvQ
	(envelope-from <netdev+bounces-291689-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 14:49:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE3D5D5C70
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 14:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 155A4301AA42
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 12:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2112222A9;
	Tue, 26 May 2026 12:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="h+VY/csc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622032147E6
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 12:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779799751; cv=pass; b=eJpB3AgufVQIGopBLoq8z7nManJCv9g53q782NQ14cw9rjpAJbt0WKBpo3QWgOij1Y5b/Xjp5TdkWkzw5Q8u1eQWU2Bka93dU88Yd2Wiuba5bDYRbbQfpyNV2VuWLwPU+ISEJt2kV0z60GIStAhEQkraX8vrRskuT44Z6t43M4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779799751; c=relaxed/simple;
	bh=SLdBmx1eMEfSaot+QjB3ZmnGjLWEuZjhyNSfogtVO5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T+/bvzoCe6ycZdyTUd3GxxIVKaigttQEP28/0wYsL3oc5/drQeTU+TOGyHOJCjwywMpygEfNz9CbYbB6JEY/BoY4RN0DaJbAzJsg2ZrEISXCBrk4fput1baiX9hmEK9bkMVAE8b3YppdLOw5ThtmYqJWHzuBL6npHl9I07Pjsyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=h+VY/csc; arc=pass smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8419ab3a297so772044b3a.2
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 05:49:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779799749; cv=none;
        d=google.com; s=arc-20240605;
        b=hB/5MlsdFCN8jPtyqUX43Xhsp2+yB6BtgVsrS6hbSeelHSHUOEut0yIdmuTYIEyTEy
         IvnXzcVq8gEqQ/LPoahTSOAOAoWNFuCb7dQUn2xdW/F40ppAak3mQLSPAjlRObh3U3tP
         tU1nil7BJS4Udg2S6MkEHvZbyP0LtGd1ttrX05T2Csw/CsPeAj4JAp1BzJXpz+HZ0hq4
         oSc/iN9ZwI7OJLEVrNmZ8BecSKAhB+3YKxfm3ruQZGn+fbOOKiAHwwcvUxpKAOXlD6C5
         59BcLyH0TfrREwkwrqKXPNlQ7vkofGrSFfmDjfp3pdU9zbHlmbSoKhCZTLxk/I56+Cs3
         Q6Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h1HJnFcMou5Y9uGRojwanjw1zsfJIKlp7N6WRxIORaw=;
        fh=JYS0g64lb5XlKruiyGduzYXA62seB+Mqdlrof2tnfxs=;
        b=kA82CJ+8dvGTCg6jnaLbTozlSEo92RjTHOTCkn3ZpaZCXSR9kPhQKtb9RoauIrziCf
         V7I6yfwSHqHYfJGn9Zbv/iHv5sCwXYGyuwBsr9pvY/U9GeyGkKhlVMsL8vLN+flhA6S2
         0qN4fIY9NBMA1SUqq2CmJAtK4i1MLwi+MhRbA4odzE1jOksL4DazTL/lxnBACC4zwvLr
         1Fb4nJsPcPKMaDJwYZR95qL068zNzvvpv5I1LlTBBFw2N0eXSZlf15KKp4yJg9IxTHqI
         +Q6KhbVxV6d4RULOIF05ha/1m6FzcB+YirX6aPU8rdDkVqcNtj1fqe2sj2W/WH7pvJ1r
         YOMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1779799749; x=1780404549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h1HJnFcMou5Y9uGRojwanjw1zsfJIKlp7N6WRxIORaw=;
        b=h+VY/cscLjIWdIYN1nENzRlN5PNwT083ArM2yAqpS9fD6nWXCkSG9GhE1p6ICXOLsg
         GiEnuxzE3OJroiFNAS8W/X/V2tnp+LbzPZOjwbEaa60Q6SwGqGEwUikHAdOppJ/LmcMQ
         O/FL3PVLvNESJyF6uhVC7Xc3oroBFGnDBBSU+CWwh0JAPShFhcS1WCuJogHVuVhfE/xp
         lhphO+jWrf+UBXDJmGGukqoCiJojDsHXRKjcuq9chmZ9zMmGXU2RjNnG6Q+d03QMH9Vc
         U2OIBkx3FmmBpCzCB93jV/2em4PP3NKYtzIQs5SNCYY0sGn5pC97Br9QXhBVKhP+oAtG
         j/AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779799749; x=1780404549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h1HJnFcMou5Y9uGRojwanjw1zsfJIKlp7N6WRxIORaw=;
        b=LBUoqHlu4u/inlQHXNm/1XNrI3BT1EiCyx16KePSVQ/5Qv1B5Yqo3AoKML9uBfs06N
         XK91X1VO0y/b+1195WCOEFF0crMgvbPuG+lW+BsPeAuMyoKjI5dnOug1MyxeZVhqV9t0
         nmILbZYx08u4fkUyoA8GIRGujw90x5Wk4hEjX7VRi3JPvj3jYUgijpiCHZhb+I4D850P
         N/7VD5ThpGhtThvPsraJylYYSbATWtvEF/AAOLu2/fFm42gfxW5JLi29oCXYUz+8e8vt
         Cc9QvVrd90jwOAuw+W34ff+ZYWWZ9ba6BKArLgD9XRymAhdCrw/apVWqt8AlJj1GI2tE
         OM3A==
X-Forwarded-Encrypted: i=1; AFNElJ8J+6F8j+FEV6Nh6QAyeZfdPAvZrptQKQdfZ8fhnIHCtdWMArGjrLMGniYOnZp+wiFjUKj699M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwjsfUXen3iebBk4fh49hTR/hMSyGEaKfr1u9wnWapxM+m3k1x
	VFEb3gJ584TJVquT1noJfMTQIqLTFpai/BonbFTHQ1H9lBQihzT/4H7I4/sLHeRUegXpWFpQ+Tw
	9BIYiVSNEJttVsO191EUIJoilhHwxa9hQEgVJddWj
X-Gm-Gg: Acq92OHyRgYfiMOiyPPbKL7r0zM5lvibuXS4YXElBCZY0yir3gRJlLN5DP+ceiQXAuu
	KcxjFtJwYPXuWTAlhuGUyTqu69w1NQ7Y7gzcREf0BNfipsEVkwvhDjTE16xf0OCOGaGLbxH5UEC
	9kiem1xHTOUMpOPwdvefRAShRKIZHe3mcVm81eJg6U3Xyjtzl8G4pQnGpAjOxCO9Cz9KQbvKlSl
	e5qndx0HjK6gstmRNKrwxwW6p7+bXWaC4IFf8pwHzwYXO6Wc2EZeYklBFRIYmFdVnOQeiyP6dYG
	CNcbHcTHyczN+vPb8t8=
X-Received: by 2002:a05:6a00:418e:b0:835:4291:6978 with SMTP id
 d2e1a72fcca58-8415f37db23mr17897971b3a.41.1779799748599; Tue, 26 May 2026
 05:49:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM0EoMkUPYSXKr2=+mR8YMq2a0TFdYPdzwPGob-UyU1fUWP9Ww@mail.gmail.com>
 <20260519033950.2037-1-rajat.gupta@oss.qualcomm.com> <20260526105306.48a2bee7@pumpkin>
 <CAM0EoMmNnPj-UO_7PN2Z3vaWKSqo4M6PzcSnn80Kzm_H1JTptA@mail.gmail.com> <20260526134715.49d0f4a3@pumpkin>
In-Reply-To: <20260526134715.49d0f4a3@pumpkin>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 26 May 2026 08:48:57 -0400
X-Gm-Features: AVHnY4KGpw7y69l22EeljjTg03Lq1hBpuf9QiEzSgZWPlyk49QTUbaMsnLAktb8
Message-ID: <CAM0EoM=+-5b6gbtqBi6cA_jrCoyQey=8KeUgW+4YhO1Bq9HSKA@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: fix pedit partial COW leading to page
 cache corruption
To: David Laight <david.laight.linux@gmail.com>
Cc: Rajat Gupta <rajat.gupta@oss.qualcomm.com>, netdev@vger.kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, jiri@resnulli.us, yimingqian591@gmail.com, 
	keenanat2000@gmail.com, 2045gemini@gmail.com, rollkingzzc@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-291689-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,gmail.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 4CE3D5D5C70
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 8:47=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Tue, 26 May 2026 08:01:08 -0400
> Jamal Hadi Salim <jhs@mojatatu.com> wrote:
>
> > On Tue, May 26, 2026 at 5:53=E2=80=AFAM David Laight
> > <david.laight.linux@gmail.com> wrote:
> > >
> > > On Mon, 18 May 2026 20:39:50 -0700
> > > Rajat Gupta <rajat.gupta@oss.qualcomm.com> wrote:
> > >
> > > > tcf_pedit_act() computes the COW range for skb_ensure_writable()
> > > > once before the key loop using tcfp_off_max_hint, but the hint does
> > > > not account for the runtime header offset added by typed keys. This
> > > > can leave part of the write region un-COW'd.
> > > >
> > > > Fix by moving skb_ensure_writable() inside the per-key loop where
> > > > the actual write offset is known, and add overflow checking on the
> > > > offset arithmetic. For negative offsets (e.g. Ethernet header edits
> > > > at ingress), use skb_cow() to COW the headroom instead. Guard
> > > > offset_valid() against INT_MIN, where negation is undefined.
> > > >
> > > > Additionally, linearize skbs with shared frags upfront to prevent
> > > > silent data corruption when pedit operates on zero-copy pages
> > > > (e.g. from sendfile).
> > > >
> > > > Fixes: 8b796475fd78 ("net/sched: act_pedit: really ensure the skb i=
s writable")
> > > > Reported-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
> > > > Reported-by: Yiming Qian <yimingqian591@gmail.com>
> > > > Reported-by: Keenan Dong <keenanat2000@gmail.com>
> > > > Reported-by: Han Guidong <2045gemini@gmail.com>
> > > > Reported-by: Zhang Cen <rollkingzzc@gmail.com>
> > > > Tested-by: Han Guidong <2045gemini@gmail.com>
> > > > Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > > > Signed-off-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
> > > > ---
> > > >  net/sched/act_pedit.c | 54 ++++++++++++++++++++++++++++++++-------=
----
> > > >  1 file changed, 41 insertions(+), 13 deletions(-)
> > > >
> > > > diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
> > > > index bc20f08a2..79921b8d8 100644
> > > > --- a/net/sched/act_pedit.c
> > > > +++ b/net/sched/act_pedit.c
> > > > @@ -16,6 +16,7 @@
> > > >  #include <linux/ip.h>
> > > >  #include <linux/ipv6.h>
> > > >  #include <linux/slab.h>
> > > > +#include <linux/overflow.h>
> > > >  #include <net/ipv6.h>
> > > >  #include <net/netlink.h>
> > > >  #include <net/pkt_sched.h>
> > > > @@ -323,8 +324,10 @@ static bool offset_valid(struct sk_buff *skb, =
int offset)
> > > >       if (offset > 0 && offset > skb->len)
> > > >               return false;
> > > >
> > > > -     if  (offset < 0 && -offset > skb_headroom(skb))
> > > > -             return false;
> > > > +     if (offset < 0) {
> > > > +             if (offset =3D=3D INT_MIN || -offset > skb_headroom(s=
kb))
> > > > +                     return false;
> > > > +     }
> > >
> > > Can't you negate skb_headroom() instead - that cannot be INT_MIN.
> > > So:
> > >         if (offset < 0 && offset < -skb_headroom(skb))
> > >
> >
> > You mean something like this? if (offset < 0 && offset <
> > -(int)skb_headroom(skb))
> >  That does feel cleaner, yes.
>
> yes - it does need the cast...


Ok, I'll update with that change.

cheers,
jamal

