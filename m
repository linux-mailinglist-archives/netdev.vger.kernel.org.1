Return-Path: <netdev+bounces-304782-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2yJWBi5kSmpKCQEAu9opvQ
	(envelope-from <netdev+bounces-304782-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 16:03:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0206670A37A
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 16:03:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=KLTy1hjq;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304782-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-304782-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 291683001F96
	for <lists+netdev@lfdr.de>; Sun,  5 Jul 2026 14:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BC637FF41;
	Sun,  5 Jul 2026 14:03:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BD62C15A5
	for <netdev@vger.kernel.org>; Sun,  5 Jul 2026 14:03:18 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783260199; cv=pass; b=Vw4836cwFLY6Kq4DcTgcBMT2MZVoOXiq/8AP1wtjskhTlANZS5OYOMs1dCgS79P8cdPqjRLpVhbAVGtLYafErVV624B4ZFp6BsfZznqAMHfzb27xhxeGkPIFb8jjjDgMIPm6YSRSEkRctQLxYnm3BTQPcUfi0/G8Onn7MnLDj7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783260199; c=relaxed/simple;
	bh=diqe9Avvur9N/DM2kSzVxP0A2qWg8/9ixiPtDABq7EQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S1A2XFPkd984RzJQSZp9jV1AVFafajJ+qHDtJX2EY2FIs3pa88DRT166n1GhZ068m/WD+nsuQFDbvQOnLCQpSpQJC6ZWMj+QfU1T0LfSLYe0Jbm2Cg142L089ZyFtwFr5IB7bT2nUb5OJ7lsWfLG5+uhuPI0Gay0Gmb33p8jWfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KLTy1hjq; arc=pass smtp.client-ip=209.85.160.171
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51bf2479349so13863411cf.2
        for <netdev@vger.kernel.org>; Sun, 05 Jul 2026 07:03:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783260197; cv=none;
        d=google.com; s=arc-20260327;
        b=C17VS+i8gmMrUV6Lt+mqooHOZWdINGwhd40xe6HBlt8NCQfVFKVO8T/71pBoEqpW5E
         26Fg/iqtykGlV8FmfhlEtFqjkTD0qm0OMGgd/N/5B2umTjB3xBY13L0DTccCs4Sm8x14
         heh7joCWvbU2Ymi1e0+NcPD27Nmr0SZh6Is1Cz9XhJtKMwRbUT8Vqa1pfjtp9DWmDvnO
         t0lQIQ/fIbuj0y+nKjOis6fJfL+gT+OIe0E+pxjWRbnlUES8jfwLYiD7l5+6VEljwoSv
         nXSQT9hxRGq30eRMS1rv6BiDz3aehy6VqcMIpCu+Mj9z+LQRqeI+mIq1Ce/CO2ypzItu
         BKbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XMxAOv+cHX5HuLWoUHEgZ090v3TmQsFuS27NMzuDBWs=;
        fh=6CXm+SX1fJI5ulvIik9Nq4HvLdEFurEEpDf8ki4pb0s=;
        b=lk4W/navfWYEoe/M4FnspLKjogZp8hFvA1NojfgF7wG5kG5cCGyCVBulrTie2lwaFs
         +VD5XfKyVYf+XhE9YQKl4xZnvSc99++lMVKCdZ2aJNzms8J9ewzuX1ZTsYYshU+uUGNL
         4jOJWya1fieY2K1Xlego8cLkw0PgNAI9FCgZBrDC5eBT2qRnxFYmLQRtjSHGv0DsgFLp
         wOFnbfW++e9CkJnDHL5pAy8yCm9LaV1f3NYS/UiXjGD1gVyG6QpzyplJ9XVOyfScLRZK
         voOZSNtb7gtbOK3VbX6ip1HLChTOxWH7nD7rhzgVkgdpqUy0MQfSnDdv2OkQ8HFTmY28
         B0Eg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783260197; x=1783864997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XMxAOv+cHX5HuLWoUHEgZ090v3TmQsFuS27NMzuDBWs=;
        b=KLTy1hjqF6Ly8IVcEc/ZbFD23PoPy+P9ZKxE4UbWBZBIv/ylxxg2J03q3hofG4edQ/
         NuNbgzlVJ3TSk7rX1pZ5T0okEK6ihJQAvzlDCnb1sQn6Ff3fAtXZ0Lv+8R1jft0Pq6UD
         Obo1eFhHXIR5Cizh5ncIF82qsevJPbbCx4IAowFGFARU4SeHGB2qj8e2NxOed6qVYS/t
         A5vz73EnJuj3TsRxlzC8sChkhGiI8qSTiGfYwTsZvEQb2x+4HY/j0vEVhWfpOZ/0mtHr
         Eud2dqA3ngdUOm9GVVWjFnYPiR7jrwJh1H057j4BeWt3QSA+DAOQt3WUHoXV2rh5pxdc
         GoLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783260197; x=1783864997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XMxAOv+cHX5HuLWoUHEgZ090v3TmQsFuS27NMzuDBWs=;
        b=nwW30218HptvYQfk7tGtyDdBtiM+Ttpjj9aP7QlhGvr+crHPoXJvE9MVxcTMKaBO12
         0+9/niyDpsT1ldycVNq3n21kq9PRfEtQOkfmNYPrdQaJL93QTwKB4lj7IGyRMeXOBJly
         l8aXtgVM+zMF3Ad+Sxit1c28cNxV6UwPYkAV5c3U/3jsKd7f48sKrDzQoUeYynK9KLbj
         hkWWdEOM67V3CzZpq3V4VXBdvAjccJUcK8G3BIyn6ATURABHei6JZ4HezZ32BIsvS3Id
         zHiB1XTDHP+ztRl8lx6/PfnqOfYdC6o3ikMAzb9/cTKVunCH2MbrCizAf5fORMvaOU4Z
         0/HA==
X-Forwarded-Encrypted: i=1; AFNElJ9V4PXBbStvBh4HmM69Mk+8ifbApjFI3gJy0yT+t6dDb5zdPWsgZmL1Z1T68ARit9jGaJIfINY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYkvRh+vPZ5wJsotR97EdYBxLJX9Lwl7AvsNg3aDeC872LvraC
	zypJ/Qf9xLrN+ClAgmM3fyx/xo20YUjrBRtuMLZnLYXBMgzfVUAmSRY5dvBLBa3yu9xxf8pigmk
	LEBEdgTjpJlWu2vbrxw9/2XOeajbCOWC+62XYQ4Na
X-Gm-Gg: AfdE7cmTf783ttQts0zqzBovvk1iFg28gAo/IvIDlDryryx8FQrJq+ZbnjpNRvpQ9om
	yIheqdWcFztrAI5MLhqgWlBR4sEHF5NmJg1ePj9eqhcvKdJdk3Uvs43gcwhdFsCCVDQMrwsARHf
	YDqfO6GC3iHowfXoMhZbIlmTC7etAP0aWZekOm1+XYszadMiQDijv/iSLOVxMteS6yLQ+pca5jn
	tr3sEHkNcieUj4Z6VysV1BFhvHApJfktzQp/SamIN0qpt5w6Nrc3DFd9w7gpBMVF5kluoq1ZDGG
	wDpMQnQ5McdsvXa5fLDanrQ0RHE6CkbHImd6oCi3lQyGRTKesMTjIcXZDPQ6Kc8dSioyHojeQuN
	fRzLPO9dshrqLYm0plA==
X-Received: by 2002:ac8:5cc5:0:b0:51c:61a:50e6 with SMTP id
 d75a77b69052e-51c4c1e4c08mr83533951cf.3.1783260192871; Sun, 05 Jul 2026
 07:03:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260704194346.4065071-1-edumazet@google.com> <20260704194346.4065071-4-edumazet@google.com>
 <20260705115839.GB194488@shredder>
In-Reply-To: <20260705115839.GB194488@shredder>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 5 Jul 2026 07:03:01 -0700
X-Gm-Features: AVVi8CdsjGpcVAbXLjSbvZ89UvXBGqeA_Dwbkyb3Zj77Bw3RPpYByuEcmbemrJE
Message-ID: <CANn89i+X8E8+jQwN8L3OFRd5NRBDAqkSVDT6ukBZCOM+2Apt2w@mail.gmail.com>
Subject: Re: [PATCH net 3/3] ipv4: igmp: Fix potential memory leak in igmp_mod_timer()
To: Ido Schimmel <idosch@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304782-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:idosch@nvidia.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:dsahern@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,nvidia.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0206670A37A

On Sun, Jul 5, 2026 at 4:58=E2=80=AFAM Ido Schimmel <idosch@nvidia.com> wro=
te:
>
> On Sat, Jul 04, 2026 at 07:43:46PM +0000, Eric Dumazet wrote:
> > When a timer is deleted and not re-armed in igmp_mod_timer(), the code
> > currently decrements the reference counter of the multicast list entry
> > @im using refcount_dec(&im->refcnt).
> >
> > However, igmp_mod_timer() can be called from the RCU reader path (e.g.,=
 in
> > igmp_heard_query() via for_each_pmc_rcu()). If the group im was
> > concurrently removed from the list by ip_mc_dec_group(), its reference =
count
> > might have already been decremented to 1.
> >
> > In this case, timer_delete() succeeds, and refcount_dec() decrements
> > the refcount from 1 to 0. Since refcount_dec() does not free the object
> > when it hits 0 (unlike ip_ma_put()), the im structure is leaked.
> >
> > Fix this by using ip_ma_put(im) instead of refcount_dec(&im->refcnt).
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  net/ipv4/igmp.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
> > index f5f9763895641bf86bfcf9fd7fd7b06012fa4ece..2170b33ba147ce4990e3ee7=
1ba4868e8696b00cb 100644
> > --- a/net/ipv4/igmp.c
> > +++ b/net/ipv4/igmp.c
> > @@ -266,6 +266,8 @@ static void igmp_ifc_start_timer(struct in_device *=
in_dev, int delay)
> >
> >  static void igmp_mod_timer(struct ip_mc_list *im, int max_delay)
> >  {
> > +     bool put =3D false;
> > +
> >       spin_lock_bh(&im->lock);
> >       im->unsolicit_count =3D 0;
> >       if (timer_delete(&im->timer)) {
> > @@ -275,10 +277,13 @@ static void igmp_mod_timer(struct ip_mc_list *im,=
 int max_delay)
> >                       spin_unlock_bh(&im->lock);
> >                       return;
> >               }
> > -             refcount_dec(&im->refcnt);
> > +             put =3D true;
> >       }
> >       igmp_start_timer(im, max_delay);
> >       spin_unlock_bh(&im->lock);
> > +
> > +     if (put)
> > +             ip_ma_put(im);
> >  }
>
> Don't we also need something similar in igmp_stop_timer() [1]? It can
> also be called from an RCU reader (i.e., igmp_rcv() ->
> igmp_heard_report() -> igmp_stop_timer()).

Hmm, again you are right, thanks!

