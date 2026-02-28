Return-Path: <netdev+bounces-262229-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cK9nNwpmo2ngCAUAu9opvQ
	(envelope-from <netdev+bounces-262229-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 23:02:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 463951C95D9
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 23:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 952DD301413E
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 21:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE8135F176;
	Sat, 28 Feb 2026 21:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2qoEvnqa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6CB35E937
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 21:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772315968; cv=pass; b=e1NFAvQZYIjd80UgLu5JQnvmPP2g2RmKt0knCmkeqpm+ZGjI5EqyUGm2lyfeibNdwUXg5SpcybhC5hf+9jYcgNzSbYneNbsVTpCwLNfwbRSi4KQ7LoghmyP6BuK8dtMWsZoy5ITT2ns7dTT6lsrf4IldtoXp5Bh9raROMyR+pA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772315968; c=relaxed/simple;
	bh=4RAiiyTpAKR6MMPimA06/fpIIvfblyXE77TESdf4Hlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FRoHYxEUL5dyybFCP0LisKJRU/U1bVfEOu8vhkmyc1JULHc491k7L7utyamM6RG3zr8utBz8Op2sW0+0Le5yxdPraEscQDOa+KEg1MybgqDRsDlLLT4cE6x/LS87/HCcWb56uW5b58+mpoBLUKB5RHjmqNymJVCQgq3bUjK/z7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2qoEvnqa; arc=pass smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2bdfd129c52so369673eec.0
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 13:59:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772315962; cv=none;
        d=google.com; s=arc-20240605;
        b=PpOsDSyKCq0SWCkTz/T32KXY3Nnyo3aSw91Sg+Y8OuztQ8uNaM1BgvX1X3dcgu4qKL
         deA1ZjFDYSxMlFa7Q1AE6RmL1C2uvY0xS1IWNAjhmlXrqwTsNwKwp8VAwcn22gpvbBtz
         6pt1wtYuhnaKFxI+A9WUeGtcAtGN/dA52Ldp5YM94x+ov5SPFQGr0Y2oeCY4rdlLqkpY
         ozfySLGrg7uDmguFywhO+8IALMbEG/22hoiWASF7I06YM+vBgYU26CATIe/9M7dfRJRs
         Jg7rqrwt0wiTW4AHSepDHdh/xxt93DQLBYRTR4kyrNvhQLHiaSCjq0M8nNZyp9ecoLu1
         wLew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YVvtzdyPVy66rJ8CZESNHEGa7bH++tI+snNLqytob6g=;
        fh=xvj6tHAfsTWwGGATne7cq8AvHOnKB2DCJRzFCZ5Obvg=;
        b=TpYWCU+gkQAz4kaFwcZNCPBkkGIY96FfP0nID0ReFs7qiRpivGGGcQDAEnYTjFWQm9
         Fovk61KRjxaTATr4WgS8+8w6gnuDcwG1ezjbBcfRXi2gTi7kRoYAfLgmPo7zXjyhRN0h
         lNNiBLqPvPMqYBFybyzLPyAiiW/n6UIJJ7xtoTRKmRdnfFMQipnwI/gBw7AmUHMALs/2
         cS3Opvoh7AHLU2fEQ1NwGYRrf7wZeWBLKt2Z58pngDq598E9ZYdTxQiBO7RmHWhDhkzJ
         CqgSr5UDz7jGIyIsVB5hzLcNs270FZE/8C9JjPhB0FR0f1cZ5DRhjzm89VMhWuepISbS
         BqWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772315962; x=1772920762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YVvtzdyPVy66rJ8CZESNHEGa7bH++tI+snNLqytob6g=;
        b=2qoEvnqaWZLMlMEnc4hUtRW0Wxs8A4sxisQteRGP/evVKrAVDFvLMfA64sY4R+Mkn/
         eP+xHrKgy+yYkt6Ljico3xHOMxH6J1gfrf/Qta5oeF+l74kVXOB59oA4U8VVreMgOxhO
         NhTNZOga0v6NRcpYNNhngUzQ8AVUS+xaB1TqIkpEDgcrZf+e9A1e5CIZOtGWIgYTX+sQ
         +D6RI78hLhh9IdOAT0oCOTNEq88+NqiFfZMfcm59eRA05tMiyFxG7Ky48t/0bsoZdLr/
         C115N/qS3HbVPX3JN1/KVzkCOfZ5V5U8GUwjuQ+LtRU00c59HucjvljXRHuY0+J4LZNR
         FYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772315962; x=1772920762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YVvtzdyPVy66rJ8CZESNHEGa7bH++tI+snNLqytob6g=;
        b=aIBPQsMYrGFLpSjwCd1U2CMMs2Rh1uCyn0BqtUyY+vglz+RXzLd7CAWVkdqG3ibCvd
         M3qsnNZT7Z/eXvYAyC3G/kC4LTCqDmcKrviXLC9RDdlIWGXrdGmLrvLj9+zwHccUlTQW
         1b+azgSl2tMsP7ctrQIbOsgR4KGH2L45wS9tEz4DaIplKoEstUCm6OHCksqBnQC0q+JQ
         FPGzEjMpcWcYWOVcr2jt6M8lkrtKhnvCehC8Pw9PmlIVO8hDucCIA54MGLa0xnh54uas
         VrGJ+8iaWJMATllrXaj63JprMmx8yYbhJ5JizBwnlQFAarYTpG1dwIgPFd30s9Bqi8sT
         r9GA==
X-Forwarded-Encrypted: i=1; AJvYcCV54WlL5z/6x34NYa2TEalWzpUREouIGW6laknINGV+6D828BbUrK6GQUGTPmb6SxE4EU5ZsWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YypayCKu/Uh4gY4BzGz85tR4xOoJM+eXdcWZC/sM45A+Opmvh5s
	D88XjEMeyxhkj8PeeiQ3GHwG4E+50lqYrrQnh3kkfG8pMjtH55Xe2IHzTKFQAeVwreN3daiTiN7
	JlpoZHBUU9P2//Awpcl0ofgv21VOcRdi2h6dhiCud
X-Gm-Gg: ATEYQzylB9pcrTuEkOaoEgRjrmKzRMYD0bqqNTDUKH/qPq2FZRo5TGMht/kzZ0KaD9w
	GUbCzFcUUifoHAeZRv5f/P5WfCb1jnc1IG01urm30PofWgZN4LBQi+zSlgXeJ/SJYqHAbsECmfO
	nBSjnTDsJiA0gGbYRboIcHVZisJ2b7d2o6bQGM0EDtSqnqxNdQWMjneZyT0gKFksBcXfIYjT76B
	dBrU131vXqfw4y4ORG2p8LOVtO34Xyc0lD2DvdYwntBoeKoRL5WiAifXHOCGBBXUpgUq46x1mOX
	p0XyKgTBhVYqVs2TQL7IVFeYgitivh1TZAaF8Xp+iJJ4pXF4q1nrzNeqHddYNt76Id3nbraV
X-Received: by 2002:a05:7301:2b84:b0:2ba:673b:e32f with SMTP id
 5a478bee46e88-2bde1f86090mr2265869eec.37.1772315961565; Sat, 28 Feb 2026
 13:59:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227033903.3307272-3-kuniyu@google.com> <20260228215446.4094803-1-kuba@kernel.org>
In-Reply-To: <20260228215446.4094803-1-kuba@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 28 Feb 2026 13:59:10 -0800
X-Gm-Features: AaiRm50z0cP9pq1JIOXG-sr_b7MACQIURLRaXSZZp6RLojkHDEq6hEmfWFEsgS8
Message-ID: <CAAVpQUD4D-32X1o4KiYqyFmmc6_EjumWWvVHQ6TbvmW7iyKDPw@mail.gmail.com>
Subject: Re: [v2,net-next,02/15] ipmr: Annotate access to mrt->mroute_do_{pim,assert,wrvifwhole}.
To: Jakub Kicinski <kuba@kernel.org>
Cc: dsahern@kernel.org, pabeni@redhat.com, edumazet@google.com, 
	davem@davemloft.net, horms@kernel.org, kuni1840@gmail.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,google.com,davemloft.net,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-262229-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 463951C95D9
X-Rspamd-Action: no action

On Sat, Feb 28, 2026 at 1:54=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-loca=
l.html
> ---
> ipmr: Annotate access to mrt->mroute_do_{pim,assert,wrvifwhole}.
>
> This commit adds READ_ONCE() and WRITE_ONCE() annotations to protect
> lockless access to three fields in struct mr_table: mroute_do_pim,
> mroute_do_assert, and mroute_do_wrvifwhole.
>
> > diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
> > index 131382c388e9..377b5848f99c 100644
> > --- a/net/ipv4/ipmr.c
> > +++ b/net/ipv4/ipmr.c
>
> [ ... ]
>
> > @@ -2037,7 +2037,7 @@ static void ip_mr_forward(struct net *net, struct=
 mr_table *mrt,
> >
> >               atomic_long_inc(&c->_c.mfc_un.res.wrong_if);
> >
> > -             if (true_vifi >=3D 0 && mrt->mroute_do_assert &&
> > +             if (true_vifi >=3D 0 && READ_ONCE(mrt->mroute_do_assert) =
&&
> >                   /* pimsm uses asserts, when switching from RPT to SPT=
,
> >                    * so that we cannot check that packet arrived on an =
oif.
> >                    * It is bad, but otherwise we would need to move pre=
tty
> > @@ -2050,7 +2050,7 @@ static void ip_mr_forward(struct net *net, struct=
 mr_table *mrt,
> >                              MFC_ASSERT_THRESH)) {
> >                       c->_c.mfc_un.res.last_assert =3D jiffies;
> >                       ipmr_cache_report(mrt, skb, true_vifi, IGMPMSG_WR=
ONGVIF);
> > -                     if (mrt->mroute_do_wrvifwhole)
> > +                     if (READ_ONCE(mrt->mroute_do_wrvifwhole))
> >                               ipmr_cache_report(mrt, skb, true_vifi,
> >                                                 IGMPMSG_WRVIFWHOLE);
> >               }
>
> Should the condition at the start of this block also use READ_ONCE() for
> mrt->mroute_do_pim? The check reads:
>
>                 if (true_vifi >=3D 0 && READ_ONCE(mrt->mroute_do_assert) =
&&
>                     (mrt->mroute_do_pim ||
>                      c->_c.mfc_un.res.ttls[true_vifi] < 255) &&

Oh how I missed it :)
Will add READ_ONCE() to mrt-> mroute_do_pim too.

Thanks !


>
> The patch adds WRITE_ONCE() for mrt->mroute_do_pim on the writer side in
> ip_mroute_setsockopt() and READ_ONCE() for it on the reader side in
> ip_mroute_getsockopt(), but the lockless read of mrt->mroute_do_pim in
> this condition is not annotated.
>
> Since ip_mr_forward() runs under rcu_read_lock() (not RTNL), this read is
> lockless and needs READ_ONCE() to pair with the WRITE_ONCE() added on the
> writer side. The adjacent reads of mrt->mroute_do_assert and
> mrt->mroute_do_wrvifwhole in the same function were correctly annotated
> with READ_ONCE() by this patch, making the omission of mrt->mroute_do_pim
> inconsistent.

