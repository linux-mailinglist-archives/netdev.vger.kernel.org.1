Return-Path: <netdev+bounces-272585-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEF1FU2PxmlLLwUAu9opvQ
	(envelope-from <netdev+bounces-272585-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 15:08:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE301345C69
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 15:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CE4B30A08B9
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 14:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52352264A7;
	Fri, 27 Mar 2026 14:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="B7CgAbxn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A7E221264
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 14:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774620102; cv=pass; b=rqyYK30b4K6duPl+4y6pA+PyHTyHgBoK41pl/E+cSAs8VWBei8OX8M7zdbtcnV0OtTOi3NdfFbU2H5BvUjyb1Gki4NQa5Njmi19tvoHat0nj66sprm2E6PXFIU3Nm7/TaJ30rx/yrFOCcy4jbea25LeHNcQHQ57lzz9wt70ZR64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774620102; c=relaxed/simple;
	bh=yhIU6ohqPFA78hwbR2qe01CYD73TcGKUCp8noC5N+Sk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QkHVWhprKxsm6yyqUrHcLhRacXeg3Gl43aQ5HDmpJJ9KOVSwVJh/mbdZqskFyKvmQmxwM70NIZHnwV3MIFQYsn4Y0fuNQZYRzObzs/PYPGRW2ITtdzP8LN8Acps22yFHUnLwoBt6DiCHvLXAQ6Af8VhN2oM57Qya2PqXaMjrX+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=B7CgAbxn; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-79a46ebe2beso20859277b3.2
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 07:01:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774620100; cv=none;
        d=google.com; s=arc-20240605;
        b=P+bcIgd35L1SGf+GxALD/fALTYTv7ShadyFDGkICscVQ0M6I2RnP04UQOOlJE56qkF
         sU4J/5dX+vQczAOLjel7vozUuTJHp3wMVqp2jzzyM5Y4dKB6Z6IvZbuhwqUFuFFDx16O
         KKgm1SbcYLxwhq0L2UmyJwHu79Mwre1qqU/GI40+GqrG+nwIvmljyxpODH0zMnZY6JgC
         DmQOG0lfYHTDIjlDOFgrTAcEWXFDf5QIEt4ShPvS4HZTLXbqkaukvy2YYQVc/uaheON4
         spE6T8y20QkOjlizMtJr77IKGl7llk2YPS5k+kO5ISKk7kdv8+N/tHcRv/iykleTQO1T
         bnnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2Mrj2spaSYxEVRO3PScAwVhr9Ih786FqnFHJLtyiUrw=;
        fh=Gji7v8LgRzG6bgEKSWQS7BpHyCjny9xJWuDeNdfBPeA=;
        b=e3aEWYH/eu5Ih01E54dXNouK6/ziVXBjjxJK47bVtvtnHZZ8jYAjDcWHawRPnSSgz9
         GJPNp249XzjnA8my/btpWFEjubtv3o1CiRs8cy/qjo171heUgKT6usSI21w+4HXKqCbn
         RF8CdrrwLAapcQc9lcKie8wOEzIy2CXYVKRo/n4JwEfnWBfDKuMCucLBIhEZASkdvObC
         WRUr4ukZ+5UptJsAIqU1/oLCaBt0WybAnZybld05XQb25snNwTE8qgJlIxMKeeJnX53U
         NVjWFjqBAfp5s/Dtmn97E5Glq2pFDCZ26XKyR2WEXpnUjzaAmX84w2tRQ9RrSkwMCgwB
         eSjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1774620100; x=1775224900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Mrj2spaSYxEVRO3PScAwVhr9Ih786FqnFHJLtyiUrw=;
        b=B7CgAbxn7bQ5lubTxmLrbRcuaDDC9cV71bJY6qV5Ylu6N/cBYx9kKOI9FT0Fr1bxDh
         2o4Z1sqi0R/zes6cmh5uMXPiBQYZeH/N1fvAcGsETlkLch9l7VmM7FUrnv9rgPb/I46Q
         QqlGoMXB5z1SoROebyJumdfPRtOQM6cpgcUUFDWixblogy8rc5nrHO0eRRtfUsfIpDdu
         BsLX/TtDRIbL6nBr/zgI1gqDPf3wOcXFM+5kKHtdWphiKo6QkqCiR400vG06d1m7SnP3
         rqQ23Oy+TES7VhIJpVG6T7qYnzzR6Zan/lSQXDmOTE5bNOzI73C2tAfpmfYEa7+9nukH
         aycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774620100; x=1775224900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2Mrj2spaSYxEVRO3PScAwVhr9Ih786FqnFHJLtyiUrw=;
        b=Z21ZOAxZlwR2721+l6CdF7J4zGwq/9YCLSkvWQ0828eSkgzphvHJ0RXKCmPnxVNy7x
         dVwAIU6BcviIUSvVvbNSC4xOZTrqi+9/uZlr2uXboRYlgvq7m1s3e3xO3uMnoiBB0CpV
         uzGApkphD3J7Q7B3PQJ4Tig7oebGBr+L6eQ+WuCoDBATY0Y8hbNTO7UXkirz8bq/rT+U
         MRM+sUgIQ8B/m20hp7oILk4h3PIqFrqZAo7iwRgvWtlqMsomMR0w4vhCigPpO37VO3sA
         hbN5xaTXEsB0f9Iz1/4TUYNDWeQUbLtzb4GclqsBkkG4PJvi6nzkTTVuVDIlYGfgzuQt
         KUSA==
X-Forwarded-Encrypted: i=1; AJvYcCUiEDo9RjyCdYTAEjMDkKukt2vG0hmFq0FKsOYafWLfp8iZ66TYDenFMt3lJFwayCGuvZtmKbo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6OqGzbBHmpxLjZanBzDkh7/iOcg7m3slUQcnlCxDLtZ3hGr3T
	4ZbTjAYIJ/fhX1WInDCZpT/G89BmJItpoUh6Z0pBJNN+r74Cr7i7EXUzfFe4Hco4NI8Fqf4rHTY
	irIgsUyY3igfh60Eq+NaUIfb+6q+Gq9U8uWX+/IMG
X-Gm-Gg: ATEYQzxJ4Vds/SoVFn8HPEKrlRqXXzB68LMDy4DRi/WH04E8ccyV6tiBe6PHalrIZ3N
	lhcc3GOWLxLaq4NEVhE9g2PYJbPzEejP9ccgOb/OQW0ewR4Z7Op/kNQQZVzW8udlj3jmpmH4ujI
	qGqxvyvSBTh/bkpXSaflV0xyop4SdlGGiGDYN0TNFjAnLOth5vvo71QRXrJcZNpuRN+6mVSIQ/i
	W0qpU6rtFYoDrSU7poS1Ii1twa75CBYHVjdD/YaLvU/Z4beKdenghS+97BG7epg4KQS1BjWGqQY
	JjghgPIdYrDKUGR3uLUGetclgZcOvw==
X-Received: by 2002:a05:690c:15:b0:79a:b0c8:da98 with SMTP id
 00721157ae682-79bddcbb3d3mr22481887b3.8.1774620100129; Fri, 27 Mar 2026
 07:01:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326204310.1549327-1-xmei5@asu.edu>
In-Reply-To: <20260326204310.1549327-1-xmei5@asu.edu>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 27 Mar 2026 10:01:28 -0400
X-Gm-Features: AQROBzCr1Qvc4ZOQayH19ZWAAhgc9YoVU7dsgvbGWpfm1akZtjABNySZ7A4JTYc
Message-ID: <CAM0EoMk_M8nzTSXsjiRCcS3gkujFjRbTT+xPEEHCA6Ye4tAj2Q@mail.gmail.com>
Subject: Re: [PATCH net v3 1/2] net/sched: sch_hfsc: fix divide-by-zero in rtsc_min()
To: Xiang Mei <xmei5@asu.edu>
Cc: security@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	horms@kernel.org, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272585-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[mojatatu.com];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,redhat.com,resnulli.us,davemloft.net,google.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu.com:email,mojatatu-com.20230601.gappssmtp.com:dkim,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,asu.edu:email]
X-Rspamd-Queue-Id: AE301345C69
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 4:43=E2=80=AFPM Xiang Mei <xmei5@asu.edu> wrote:
>
> m2sm() converts a u32 slope to a u64 scaled value.  For large inputs
> (e.g. m1=3D4000000000), the result can reach 2^32.  rtsc_min() stores
> the difference of two such u64 values in a u32 variable `dsm` and
> uses it as a divisor.  When the difference is exactly 2^32 the
> truncation yields zero, causing a divide-by-zero oops in the
> concave-curve intersection path:
>
>   Oops: divide error: 0000
>   RIP: 0010:rtsc_min (net/sched/sch_hfsc.c:601)
>   Call Trace:
>    init_ed (net/sched/sch_hfsc.c:629)
>    hfsc_enqueue (net/sched/sch_hfsc.c:1569)
>    [...]
>
> Widen `dsm` to u64 and replace do_div() with div64_u64() so the full
> difference is preserved.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Signed-off-by: Xiang Mei <xmei5@asu.edu>

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal
> ---
> v2: resend to netdev ML
> v3: append selftest in 2/2
>
>  net/sched/sch_hfsc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
> index b5657ffbbf84..83b2ca2e37fc 100644
> --- a/net/sched/sch_hfsc.c
> +++ b/net/sched/sch_hfsc.c
> @@ -555,7 +555,7 @@ static void
>  rtsc_min(struct runtime_sc *rtsc, struct internal_sc *isc, u64 x, u64 y)
>  {
>         u64 y1, y2, dx, dy;
> -       u32 dsm;
> +       u64 dsm;
>
>         if (isc->sm1 <=3D isc->sm2) {
>                 /* service curve is convex */
> @@ -598,7 +598,7 @@ rtsc_min(struct runtime_sc *rtsc, struct internal_sc =
*isc, u64 x, u64 y)
>          */
>         dx =3D (y1 - y) << SM_SHIFT;
>         dsm =3D isc->sm1 - isc->sm2;
> -       do_div(dx, dsm);
> +       dx =3D div64_u64(dx, dsm);
>         /*
>          * check if (x, y1) belongs to the 1st segment of rtsc.
>          * if so, add the offset.
> --
> 2.43.0
>

