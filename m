Return-Path: <netdev+bounces-282601-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sM3vD7O78mlAtwEAu9opvQ
	(envelope-from <netdev+bounces-282601-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 04:17:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A981149C40D
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 04:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A879301F336
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 02:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A387261B9B;
	Thu, 30 Apr 2026 02:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WphGCQ8T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D866E573
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 02:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777515401; cv=pass; b=MdVu9Zb20m6eCHkDATfUHaSRPjqH/5W7fxnlxmGJYpzhzC58Duah2QEN90/UXQO3cEHBK28J3zROLTFSNLTz2GK0wCflDV956P1DazZfhaDv4YDuE49Yxvi4yY/SXvoyH+ifrNcJZ7Vtw+Zcrlftrw4+MkZSER/6lE7DJ1sNilM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777515401; c=relaxed/simple;
	bh=i0WLn+WQ+O2Aj+M+FnL7FTlcxswa3gE1vfEOOhxNXU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NAk2uarve0P6q0UTKb4vwoIZyyj4OGJhKE4AIEsVyE5H9XuHV+TYKmSd5dRKE3aYqyUwQTyqFG2HeCC2qiSnIQbezNy8ZutkYheKHrdr9bHkHXm+cHO4fFV/1nOqj9W9mb+A8s/03/3Fvf0ZYK3Siofh/hoHU15uQbTPUg5Ds6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WphGCQ8T; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50e614fdb42so2723811cf.3
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 19:16:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777515399; cv=none;
        d=google.com; s=arc-20240605;
        b=FRJdfQwOUxHAuCW6371FbvjQkgzJXMrECh3RAvKlf5FVc5Zv80HAZp5kufQ1iaPZyD
         JJXPaGV17dzeQgRxyYEusOfXH8CoNMt1RAJmpHpQKSkCHGzv0YRZoX/+ZzVW787G3yIo
         b67DPNo4/Xv9tp8VnCIKFOpGpeYtRZaIcqfJNHr2dsp1M0O9q7VuSv8a0OjYmwrEwfH8
         EGMGjThVsQjofZSgrui4zd1BWfVUaA+XL38cXn7+3X/D324T5vJtX6yImlBywuSlrmdA
         Jkp6VdwWd/lPxvq7HfVUhecrU/QhLmZuwAMdhCh58GMmPOf/9JoZmHQFzv1FfXs4l34M
         CglA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uGs6u+7Bh7v0yBTQlsPv6DbfD39HJNXHXoQX3//5j1Q=;
        fh=pOP1m2jATXUhKFIFVmJ+KVkvmZ560DJ7CEf1znTKEw0=;
        b=BTm1+wz3veisnKCh+jqhr/0Z+310CGZMEnWQ+Un4LV8Eihv7UjJaW2jgR+lSkBJbCa
         1FqU9O5BEwvo/A5jaOKnhrvKH2eHXwLxmCM9oWTXhG5hM5WOkQXBauYpWJmxOXQB0tBD
         2TLya1TXso6l0anJ+09Ko8EuTOIIilnSay+O3DgO5waJrEpe6L33jEP+jP9uC7DSU9r/
         J+sIgq29+G/P7ktIRIo1Ei0bGtKPJc4HokJGwsYn0+ENG5eBBWnCb+ByjYlP7xSiBalA
         rkh7aGxB7NPxyV35wF/PqgkNSeF9deXPhFj8Ewl/EwJQ0TYGrU63+RrdhmL2C9uJDIFT
         Spcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777515399; x=1778120199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uGs6u+7Bh7v0yBTQlsPv6DbfD39HJNXHXoQX3//5j1Q=;
        b=WphGCQ8TnBP0xtiCT+mfCDESM4wSVA6nUOOvHTH37O1+43aDaNXdVEWyB7KpExv9ch
         QUQwNruD09tzkklKpmd7b5X3ZvvQz2Sk3vpDIeUwumvR2mZRbjDfZ5BI494CMsACjDgf
         +A4w2EO9JZqUzuc3+RajYpUHSDeI4S4+Z/5/SVdHFM3mg+Az2/36g1Vyo/6pk9BiOlzB
         asqwfZex5un9nj+rsp5xB8Wvs8ZLAHbdaIpkHkx1o7RUjcJAoEoiKRYTU5BaHAx1VbYI
         HvxGcRhI+O6tmiuxVX3D8mBlUr+cZY7bpezcy/8y3L/cvriueXE3fClFmR3mgEqnogy6
         qnnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777515399; x=1778120199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uGs6u+7Bh7v0yBTQlsPv6DbfD39HJNXHXoQX3//5j1Q=;
        b=JyEQVwUCNjYRMtQY2aDjnSA9dBbErP2pNgC9QN5d61VqNqft3zr5mup9VLEr8Em73b
         ego+d+LtcvTK4rUmPR2vGL8a/NqCI0QaTQnLViQiyb1qShqRTiHDAig2Hjvc//SqlHha
         Nqh3wB6NO04sSnQl2IxgDIkHqimae3uNTKZ2sGQuT7Zsfio6h2EDPUsUGLH9X5mcwY6h
         KkYoYkNz4rv/Q5I08sMT6flp4TzJNxmJ84AKm8cKP8LNd6ywkL8RprF7cuq3IF6u+9LX
         xTrEfevQzqGpSOWA66kEy0xaSHQvfI/yRx3Z1O/SJaQCIWh7PVRWtWZDxlDhx9z/+A9s
         Z0Ow==
X-Forwarded-Encrypted: i=1; AFNElJ/Q/Mbe4C0Nu0S86CeGnV/6uxPFp4Ag7gCBXmYMMBvGdlHmuhsiOL1Y6qPYVxTQhYvQmB67IKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjNv5zF9xiQcGQUVQwVtLj4yH8X5XUL3En6h6A2XHzuIkchJWD
	AJvEgCcyMqm1mou2B23QkDP3EZgw+9Li9ZYZSqTs61t6i+nVVp9Pt+PKkUUGpIvuNRjtO/c/uMB
	jXx1zW8NmC9wiziAak5aXHNqN7mFubuYoaxk7kRht
X-Gm-Gg: AeBDievRuSvc5bcWEzbsoio70XHTFXLGAqnU8NiygkHQuS+pI1z7RyNxTFhyXntzl7h
	+bYMS6qt260eDNSGWXxsr79umllTwkH6vPfSZ628Pschhbjfjr7Cn6eHvDXAFVVx0iktRMKRxR+
	ZuSKXk1tGUFIlZXfs1f5vzpHfynJO0sQ2FNFjeei4suZjqrj0W+ArILxpc9qPdL8TJ8UWHcOgnP
	5cANHhSiUHXQDTh1QJQQ2cJQLWKcBL/tty6BmWEs0wzRoiGsu4c8bTYI0jfZULHN4BqhpgUIhZC
	CxiNh3qYxD1bDX4v+J2i/G3bHV/KOYLLfTweCE5lNca8+d/z0anka+G9f8sxKcmv131MFh4BNKa
	U+JqZpT0=
X-Received: by 2002:a05:622a:998:b0:50d:62d1:c3fa with SMTP id
 d75a77b69052e-5102aaec0ffmr15106991cf.2.1777515398637; Wed, 29 Apr 2026
 19:16:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428170414.250566-1-edumazet@google.com> <20260428170414.250566-4-edumazet@google.com>
 <20260429190004.2bb674d4@kernel.org>
In-Reply-To: <20260429190004.2bb674d4@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 29 Apr 2026 19:16:27 -0700
X-Gm-Features: AVHnY4KEsW3kecnDHFpJH0ub9pL48Ib9IDFp0Y82-QcNdjP9I9S_1Wl0lhGekIc
Message-ID: <CANn89iK-FR53c0EkMrfgkg7NiYB4U0SnLV9+Es0kUsJjm3JzVQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 3/4] net/sched: switch tc_dump_qdisc() to for_each_netdev_dump()
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: A981149C40D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-282601-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Wed, Apr 29, 2026 at 7:00=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 28 Apr 2026 17:04:13 +0000 Eric Dumazet wrote:
> >  static int tc_dump_qdisc(struct sk_buff *skb, struct netlink_callback =
*cb)
> >  {
>
> > +     struct {
> > +             unsigned long ifindex;
> > +             int q_idx;
> > +     } *ctx =3D (void *)cb->ctx;
> > +     unsigned long s_ifindex;
> > +     struct net_device *dev;
> > +     int s_q_idx, q_idx;
> >       int err;
> >
> > -     s_idx =3D cb->args[0];
> > -     s_q_idx =3D q_idx =3D cb->args[1];
> > -
> > -     idx =3D 0;
> >       ASSERT_RTNL();
> >
> >       err =3D nlmsg_parse_deprecated(nlh, sizeof(struct tcmsg), tca, TC=
A_MAX,
> > @@ -1896,42 +1896,40 @@ static int tc_dump_qdisc(struct sk_buff *skb, s=
truct netlink_callback *cb)
> >       if (err < 0)
> >               return err;
> >
> > -     for_each_netdev(net, dev) {
> > +     s_ifindex =3D ctx->ifindex;
> > +     s_q_idx =3D ctx->q_idx;
> > +
> > +     for_each_netdev_dump(net, dev, ctx->ifindex) {
>
> compilers point out that s_ifindex is set but not used since we iterate
> directly on ctx->ifindex

Ah right, I need to remember to add W=3D1 to my builds :/

