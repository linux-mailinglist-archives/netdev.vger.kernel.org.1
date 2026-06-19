Return-Path: <netdev+bounces-300655-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Jr6CE68GNWq0mAYAu9opvQ
	(envelope-from <netdev+bounces-300655-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 11:06:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B29D66A4DA4
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 11:06:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ZJ1N5RJu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300655-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300655-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BBE51301F489
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 09:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BA035C1AE;
	Fri, 19 Jun 2026 09:06:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1353BB48
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 09:06:51 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781860013; cv=pass; b=pCkZsjF5WoXX8y3ZgrpmHJDEJwlcYW8/U2Ey8wpUNc1NREbxIbEKRafAihEvvimDCINB2K4q/IdPkdVzytOIi40930mZmRxaHMhKIURTj5s/wFFPAV1oYJgqBTprAO7inaSP82gxpjfJR54RjLb9WRe+HyBHmBKIviZhfA8LKNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781860013; c=relaxed/simple;
	bh=W3Oj3Xq0sqB1+K+I7OWN/YsDKmlnqCN7ebLffL2tcTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TbNus7P2s/Le7SBC4LZ5YqLFy5HCxGy2Mf56QE6uN2pvjOZI9mISLvtFoUAfRLmbSmSfNKcKSIZoxx+NLQIcLffjZBZ3n6YshceV43ShFa90HIbxC3aA6+Cu8kRi+4loqcImyj0/pnKa2L5ohxJA1bDrG6X4Lw0NDhxrq/SJA5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJ1N5RJu; arc=pass smtp.client-ip=209.85.208.173
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3967738c801so19694831fa.2
        for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 02:06:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781860010; cv=none;
        d=google.com; s=arc-20240605;
        b=TGfhBfO9r0IwgUcxq1rG8QqQvLVscX8TCtyKhKbh6bxHT/rtijCmXwsmx4rolRVloq
         pFJqrxay+XRvb7AFcX6/eph97KSol403JVJzjDsxiJ6wgOy8nwTrtwllBTJETkRA2yzl
         BzL9kOBBafE+fPR0rSCQiiUlC5xlg3RxHxMsfzI4TjZgNnrmZC12P5HT8qPtM2KpIMZn
         F0T7giAS/aH46M0hO3fetbaqoRtViQV1yb76/c2bbaxz6nYGPRgpTp1mCoAh38oC5NJg
         pjXwaqNilV1Ofo24fpjlyKYzv5gHVWu5N3hAoPgzis1otoUhN+H6C+7UHWRBJbWibeVc
         shdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UacI82GZ1TrwcIPOa1WAvWCBhpkSRdv0khLRx4rIDg0=;
        fh=md7Q2maOEghtJPEXbCSvT0oD/44nj3wPhoRpL/PzvI0=;
        b=irhHlVM+AJBSU2eDzAvCYqhvzHzT8n3YMAChpyvWy6HpmLgxQgsKF42fVRj0i6HEu7
         oWdHRd3NtjO214zeuDhAXhQ2KruIFjDgEe86Km5CLeIfyF13oj/lLgBaLYwLJLk+nr2w
         x/thp67+60qaBvp1pRZRBA6CNdimlRS8Esk0J1KNBaOhuY/Uw53UcyOY3uhCZrMTaGcQ
         EF8pDj/j6iY0KkNonSCNN2ZbBjOHpccaMf/8Qbx4aK441i/zj6qmVMcw8W0eNGZ3n7wT
         bbOGADuVDsHwdk+Ld1Yi3uByYvnV5xAZidlD0gGPhM5mF6cEUCa3C+sBkCGSzncqiNJO
         513A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781860010; x=1782464810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UacI82GZ1TrwcIPOa1WAvWCBhpkSRdv0khLRx4rIDg0=;
        b=ZJ1N5RJuT+ufv61lVEHToE5TWt55jNyAx8y4/PAi16+mJ2DeHsXMZMKNOnTFtMvS07
         9Ggio0vk/BiXchKDPUSfdEfPtg5YFWr6K/Sv76uOYkN3iDNiqZ0d2GHpaMpjDihK0cuy
         DpXRuLcufm8GBot2K7mUKZ8S1cXJ3ZhSB5HPwilEcfqQn4NwLgTp7fXAE9IK98s/ddNP
         eRmQjweBOSRIJTC+BS5S2xul30rb+61x02Zq+HZXYx7MCVAXul3vp8DyBgrdBLeC1c2X
         19FlzLNgYV5AafT5o4U9KjJ86Wtf2cRhhVW5vEmi/QJz7HGpzh0qVFYAJaWsjPp02cf8
         zSjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781860010; x=1782464810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UacI82GZ1TrwcIPOa1WAvWCBhpkSRdv0khLRx4rIDg0=;
        b=HCvNoHWHIMOwxAWkjFCZlHJUFThpKpz8kX5x70M7xmvhClLvSDUHzcgX6sDLPZXovM
         Z4Ov7qoIt0EgoVC8kznEPtpYq42kcliwSZfgHXYlGTZoCbcQXP/VmyRAxrP6hctfQ7j+
         4VDKSNv2R2qxw38v+pQHiSKpzYKBREbBBIFOMhMFqHzNh0UttEwlNB5O5OEjRZQJE80/
         s8TIFQw6YiDIYCQqgPuEgNfZyYo3GcJQJrUYdiZ2vsPwBIDpB+Qj6C2ONqjx2crau6YR
         74YlGWifkPXZH/HNI+uaEA3xLQqme+BjJMQDM3b+x/J7J/iaNdQideHMoPzOBuVHZotH
         7k3Q==
X-Forwarded-Encrypted: i=1; AFNElJ+tF/KsojZbkxogvk3RrqeX+9ypO2FzHHD9uEhrOxgXjP7IdVC9JD4te7Zx6EkTDKsOHcKQTPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YznugUvQkfs+KyNgM1T7+zu35FbCLwaJ2dYgf7s2DhBRtiTKKU7
	yuRzPz+Wak+P/kK7rNUsTxhlkr5c3QoOoWByPr/njmNbnDmMiAML9uzMj3uLPgDRPSqOFX4c3Ze
	/dbwN6nnYKbP5aN0rVNE1ZdRH7cWsi98=
X-Gm-Gg: AfdE7ck0c/bx1BMms8LkjlG8ZtVc29E1jrKCQcmoMCpGBO0z00Cy0lK46DIFiZi4qPy
	KJcbRgz/MynxwueEgRfUDPLmXXj1NfaHhFnbOYP73D1/d5rmNDc2ThxtcocCkXN1jQQJ6v5vVSy
	x6xuHnnUb42uVFHFzYs9+ycZA6etH4Id5tBUgJqoMgG4kVYJBgpOW5H6CKAxj6xJ5+ysrW6J6dR
	ElCDuipAMy+m6E3g6bbJk3Ka2wY12ObpKnrmPlZJK5neDw7R3ahmBqXiDX/UYPWHG+RjaY=
X-Received: by 2002:a05:651c:160d:b0:399:87c9:4573 with SMTP id
 38308e7fff4ca-3998bee73e4mr6417491fa.22.1781860009524; Fri, 19 Jun 2026
 02:06:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1781788385.git.qianyuluo3@gmail.com> <46eb334399ce0e25e0897b42f21020541d159300.1781788385.git.qianyuluo3@gmail.com>
 <CAHsH6Gvsf-JEQyetucAVT6mjaJDi=gMT1pDWFDagb1fhjmveGg@mail.gmail.com>
In-Reply-To: <CAHsH6Gvsf-JEQyetucAVT6mjaJDi=gMT1pDWFDagb1fhjmveGg@mail.gmail.com>
From: Qianyu Luo <qianyuluo3@gmail.com>
Date: Fri, 19 Jun 2026 17:06:40 +0800
X-Gm-Features: AVVi8Cd7CgmdIKU_a_M1Jph7bhsriy3x4t2YQF0PvSdLDyzd2Ok1NYafC-jAvcg
Message-ID: <CAPOno=q0NxA_LOJ3QaM9Jgk1oM4ZQiW9igipGfxV7+yGvjr+0g@mail.gmail.com>
Subject: Re: [PATCH 1/1] xfrm: nat_keepalive: avoid double free on send error
To: Eyal Birger <eyal.birger@gmail.com>
Cc: Ren Wei <n05ec@lzu.edu.cn>, netdev@vger.kernel.org, steffen.klassert@secunet.com, 
	herbert@gondor.apana.org.au, davem@davemloft.net, yuantan098@gmail.com, 
	bird@lzu.edu.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300655-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[qianyuluo3@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:eyal.birger@gmail.com,m:n05ec@lzu.edu.cn,m:netdev@vger.kernel.org,m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:yuantan098@gmail.com,m:bird@lzu.edu.cn,m:eyalbirger@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lzu.edu.cn,vger.kernel.org,secunet.com,gondor.apana.org.au,davemloft.net,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qianyuluo3@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid,lzu.edu.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B29D66A4DA4

On Fri, Jun 19, 2026 at 1:21=E2=80=AFAM Eyal Birger <eyal.birger@gmail.com>=
 wrote:
>
> On Thu, Jun 18, 2026 at 9:36=E2=80=AFAM Ren Wei <n05ec@lzu.edu.cn> wrote:
> >
> > From: Qianyu Luo <qianyuluo3@gmail.com>
> >
> > nat_keepalive_send() frees the keepalive skb whenever the IPv4 or IPv6
> > send helper reports an error.
> >
> > That cleanup is only correct before the skb is handed to the output
> > path. Once ip_build_and_send_pkt() or ip6_xmit() takes ownership, the
> > networking stack may already have consumed the skb before returning an
> > error, so freeing it again is unsafe.
> >
> > Handle the pre-handoff failure cases inside nat_keepalive_send_ipv4()
> > and nat_keepalive_send_ipv6(), where the caller still owns the skb, and
> > keep nat_keepalive_send() responsible only for family dispatch and the
> > unsupported-family cleanup path.
>
> Thanks for the fix!
>
> >
> > Fixes: f531d13bdfe3 ("xfrm: support sending NAT keepalives in ESP in UD=
P states")
> > Cc: stable@vger.kernel.org
> > Reported-by: Yuan Tan <yuantan098@gmail.com>
> > Reported-by: Xin Liu <bird@lzu.edu.cn>
> > Signed-off-by: Qianyu Luo <qianyuluo3@gmail.com>
> > Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> > ---
> >  net/xfrm/xfrm_nat_keepalive.c | 15 +++++++++------
> >  1 file changed, 9 insertions(+), 6 deletions(-)
> >
> > diff --git a/net/xfrm/xfrm_nat_keepalive.c b/net/xfrm/xfrm_nat_keepaliv=
e.c
> > index 458931062a04..f71328096f11 100644
> > --- a/net/xfrm/xfrm_nat_keepalive.c
> > +++ b/net/xfrm/xfrm_nat_keepalive.c
> > @@ -55,8 +55,10 @@ static int nat_keepalive_send_ipv4(struct sk_buff *s=
kb,
> >                            ka->encap_sport, sock_net_uid(net, NULL));
> >
> >         rt =3D ip_route_output_key(net, &fl4);
> > -       if (IS_ERR(rt))
> > +       if (IS_ERR(rt)) {
> > +               kfree_skb(skb);
> >                 return PTR_ERR(rt);
> > +       }
> >
> >         skb_dst_set(skb, &rt->dst);
> >
> > @@ -100,6 +102,7 @@ static int nat_keepalive_send_ipv6(struct sk_buff *=
skb,
> >         sock_net_set(sk, net);
> >         dst =3D ip6_dst_lookup_flow(net, sk, &fl6, NULL);
> >         if (IS_ERR(dst)) {
> > +               kfree_skb(skb);
> >                 local_unlock_nested_bh(&nat_keepalive_sk_ipv6.bh_lock);
>
> Any reason to do the kfree under lock?
>

Thank you for your reply! I did this without particular reason.
Just to keep the pre-handoff cleanup in the same error path.
kfree_skb() does not need the bh lock there, so I can move it after the
unlock in v2 if you need!

> Eyal

