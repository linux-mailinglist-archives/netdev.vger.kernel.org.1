Return-Path: <netdev+bounces-299106-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Fa0dFsnvLWornAQAu9opvQ
	(envelope-from <netdev+bounces-299106-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 02:03:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA37468015A
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 02:03:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=OaT4XBjw;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299106-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299106-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=asu.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7D9E3035AAA
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 00:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C8B260566;
	Sun, 14 Jun 2026 00:02:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817392030A
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 00:02:50 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781395373; cv=pass; b=JBJ+ohlBFXe9Khbc1+MH+T4oAkoKjZS1mpHoUa68wIv8Plgjrar00rJTp12x5AongT4iOEpu9ow/6dWP20Wjbl6j/adkCaGGWjjPxWd3N4a/Sq5id0uWMZw6DHtZJml/K+5UWlPEedYNYYH73r6uWYa/Hx+APaVCyqhUUHuBLVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781395373; c=relaxed/simple;
	bh=Ukm3BfaERrDSPyxBsJtONuwV/nuPiFoa5tA3fmX3NXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QQFJ0SaRwxxzC5Nq5ydBlvU6YbDpudioNZJNLr8kpqpUSi4tVQGNTsHf/Md/F1OdI+O55B6mnKmYRFxIAE5tMsIReI1yL5QDjrw5IYUZcj4BNsd2t294/ztJ/d7DqkBBXt5FTh0hGO7hzuHhbq+9Dd7Ly293QSSTOJLGuZx4gCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=OaT4XBjw; arc=pass smtp.client-ip=209.85.210.169
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8423f420455so1041265b3a.3
        for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 17:02:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781395370; cv=none;
        d=google.com; s=arc-20240605;
        b=fi3pC7Nog1zi3OaU8VWCJs/y9nCMADBZqFl0gBSBtlP+qRd5aA/mLErEJfpLqTlsfB
         RfZJX8D7tuxQ0O+FDU1gMLhCjESlcXnXuGzh0IckxOUKUIX6TYEeAoqYNnG9BVd5oV4u
         TGus+s1Vb26dUj2UK6ZaFSp3Q6GEtnNBfDcrphSHrBXNk5y5W/fPkU2v41T7xgJUcJLP
         3+2WUG/Kcd3aMQXzh26I+RQxauwwA0O2vTfk6D27xuBguCFuOrItOj5iS1zluiDGFxAn
         HGBfmBLZ+n5Ni4NYsLwyf0zuQGxwLIgkbNPa/NaPHVydKEdvwe8qtErqw8JaVEYJLC4f
         oVXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dvQ4l5I94FlNUFJY2MklfAXyNUae2L4oXAPNEmtVDo8=;
        fh=ZYxaXIYMvabb9dHeZ2FhzI5l0he1avKb9pG0M/0Xuwc=;
        b=UUN9xdnDUB4fi+UwE2JqcYp2GdCbKAIOd9DQQ0t3Ky50E98bijzHiuzd9J3jd7ZhHW
         GWCGqDX+GXlhnGsToRPmOAiAuvTVL6HrMZtj+DDCI+lmjQDXjHuJwKNBxZTg5vX+V/xn
         8wGb2Z1UrCYRLeg6S+8VOqM1oVLzMeMfPLCKpQHDSTnrfugjoBLc382vciKjdtT/m8k4
         ArQcPeGyIAD2IM+3eIO/0JV6qyxs6DmTXJidSVLwOIHGrPWkpqn+GLxlR5JSSC394v0q
         sNJaXxGzfNkKL97md7eezG9EUd8gqA9NeRyVyeQ56rkKjapucql65wxBXhCV9uTWCOLL
         cBLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1781395370; x=1782000170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dvQ4l5I94FlNUFJY2MklfAXyNUae2L4oXAPNEmtVDo8=;
        b=OaT4XBjww+xtnQv8DC6F6AlChY/5/kUgpaj/GEgW7UlKyxkn5Xx65GN7Q2/tkB9stS
         6mDFBsws9pdedlN6feHigvD/hbyD3jI2JBCgyI2CQQiT2T0phwh3j9A25GJg/mVSQNOq
         Htuc4+p6mJT/sDA+sMaiInMOMUinbwPVVv6hgNaDd4Xj254RskyyERED1vv6vdQqFX5L
         cueOWiusRpEBE8gSe5R/CJEP9KH/+J3hAM46XLlpHaIvhScjCl7Nrye4PY5fg123Y3Fv
         j/NPxXt0VlOEqJtZeAyKr2TOlT0X4KwMaUiX5miB8Aqpqai4WId5K3zICTb2n37wdkQ6
         pZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781395370; x=1782000170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dvQ4l5I94FlNUFJY2MklfAXyNUae2L4oXAPNEmtVDo8=;
        b=V2e4Wdd/UWAegg/gEapwCqEev9UPz4pgb18zhc7Rm4oygAMKTHvM5xn65dT2vZMxRn
         Ur5GFp4kIvoA/g2BpYah6OmmbvykTxYmASWyQH4XvjPTFFc4CeuRh1jkWxVZ0qT4DKfR
         UyFmZF5uSpr8qZkbwsU/v2ZwcxAc70zgkAgrhizsQj8xyHSdkxWstOLQOQTnUrdo3rlk
         cZOpcMav3L4BvJbnzLHMhDz1Rol9NuGz9dJf+sO1jrXPBAb6+KEowX057u2XctUZIY+W
         mm985EBkB8xzV53BNabTqNmn94q0GqSlT2UaEbqAOXnoaBti6O8qoJxIMHv4nHMouxBT
         WMRQ==
X-Gm-Message-State: AOJu0Yzne3GY+EOFSm8ywCbyWG0jZLX7TIDjgZppXDs4JCA8KN/wYu2+
	rxVVACbMVXdrNgQzRFbsGbgzaYTasErG4w1ltQD58KJ2XVs0ZK/hWncQC7vlM+fA0wKerTGg5uu
	Af18PQLcCyHt9nIVtIaRhRRLkDZCxn49n41ROaCzk
X-Gm-Gg: Acq92OEpzk6cLFq7ytS+By/aGXYNaK6rYT7pZC6R3nZmOxHl8kVxNqXSrm2Gs4JyfC3
	Vu7goQhu4n6mxy3qsjagl6Gjn1aNB63NDjr+brxUfSLFgJLjfpVDCX8w3lUraZxr75yv25eI4jt
	I0Y79NLxy9tOH6cBiACxurvxtRKMLtagyi0RN8xvCg8osNcZU7JHENtacVevDnXNyRovixsMD/V
	2Ehm2bJj4by2clPXJdQbSNdK9+eVJmqNfXlqpMznIjhE45h5eL1ife8kfeA5U2FOXrQ2ZUf3Nh+
	4HPQK8kP/nC7OZLD/y+nfE7HtCxF+pTjRQH8fFQ=
X-Received: by 2002:a05:6a00:a254:b0:842:4838:1761 with SMTP id
 d2e1a72fcca58-844e1a2a50fmr5827960b3a.24.1781395369707; Sat, 13 Jun 2026
 17:02:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607031640.2743713-1-xmei5@asu.edu> <20260609183018.1764046d@kernel.org>
 <ohbtwmotp5mvghzjkwpjecz4rglal3ayh5bylw72qkv6fjscii@3ks3kavmycel> <20260613164820.491226a7@kernel.org>
In-Reply-To: <20260613164820.491226a7@kernel.org>
From: Xiang Mei <xmei5@asu.edu>
Date: Sat, 13 Jun 2026 17:02:39 -0700
X-Gm-Features: AVVi8CcLGzvElSBFxJcSs09FfXsZ-DDoF9sdr2R3DwKItyntlCi_Q-S66lqgfUg
Message-ID: <CAPpSM+RuCaNoYFN7JKGDeUScK2-xLjSULA4i8bnChmG05hBaNA@mail.gmail.com>
Subject: Re: [PATCH net] psample: zero the netlink attribute padding in PSAMPLE_ATTR_DATA
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, yotam.gi@gmail.com, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299106-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:yotam.gi@gmail.com,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:bestswngs@gmail.com,m:yotamgi@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,gmail.com,google.com,redhat.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[asu.edu:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,asu.edu:dkim,asu.edu:from_mime,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AA37468015A

On Sat, Jun 13, 2026 at 4:48=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sat, 13 Jun 2026 16:33:44 -0700 Xiang Mei wrote:
> > That looks better. I just found that nla_reserve can memset for us:
> >
> > diff --git a/net/psample/psample.c b/net/psample/psample.c
> > index 7763662036fb..c112e1f0ccac 100644
> > --- a/net/psample/psample.c
> > +++ b/net/psample/psample.c
> > @@ -476,12 +476,11 @@ void psample_sample_packet(struct psample_group *=
group,
> >               goto error;
> >
> >       if (data_len) {
> > -             int nla_len =3D nla_total_size(data_len);
> >               struct nlattr *nla;
> >
> > -             nla =3D skb_put(nl_skb, nla_len);
> > -             nla->nla_type =3D PSAMPLE_ATTR_DATA;
> > -             nla->nla_len =3D nla_attr_size(data_len);
> > +             nla =3D nla_reserve(nl_skb, PSAMPLE_ATTR_DATA, data_len);
> > +             if (!nla)
> > +                     goto error;
> >
> >               if (skb_copy_bits(skb, 0, nla_data(nla), data_len))
> >                       goto error;
> >
> > Let me know if the new patch makes sense.
>
> I assumed the author intentionally was avoiding the memset for
> the memory we will override with data. Otherwise the whole dance
> could be avoided and nla_put() would have been the answer.


The reason nla_put() isn't used here is that the payload source is the
sampled skb, which can be nonlinear, so the data has to be gathered with
skb_copy_bits() rather than a flat memcpy(). There is no nla_put() variant
that takes an skb source, hence the reserve-then-copy.

But that doesn't require open-coding the attribute: nla_reserve() only
memsets the alignment padding (nla_padlen), never the data region, so
nla_reserve() + skb_copy_bits() writes every byte exactly once with no
redundant memset over the payload. The bug was that the open-coded
version dropped that padding-zero step.

Xiang

