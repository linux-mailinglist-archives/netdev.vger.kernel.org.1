Return-Path: <netdev+bounces-274917-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Iw/Cmxqz2lPwAYAu9opvQ
	(envelope-from <netdev+bounces-274917-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 09:21:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC07391B03
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 09:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB9DC3013690
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 07:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41091373C16;
	Fri,  3 Apr 2026 07:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v1sHzYFV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8473C332EC8
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 07:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775200827; cv=pass; b=YeqWTG7K6l8JSqWV6+SVzAPk8iHmRCTMOqjpSyp9x0udf8zXglPHN5hLGVsdVB96VKJCXplvcJGLNhnz8mrTVgIGUgozVfR3w7dmVQMtzbJgWu8wHs2DGxyJ02bNiAibbg03Cy2soU2KGRwzeI2ap6nZPRSwjTY1e8KFcIWCDIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775200827; c=relaxed/simple;
	bh=/PJLEBPPQA80fc6IEnQqFw7SkNn9XdR+IV/v+6bXQMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uoEnHbNtZiG3+RZALWYNziqeGJwtMcR42OfYd9a6D/mqh7YMPTrJzgUtkABHUZ0i+YHv1zOut4FEosZQMENMyKzIpIC2sf0GUFeMRluc9xDtVVusiZhfPB9eZ6HzXyu1e8Z80B6Vmc90GIrirNdihTjSUtac2tbqqecrqJYTciw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v1sHzYFV; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50335b926c2so13992651cf.2
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 00:20:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775200824; cv=none;
        d=google.com; s=arc-20240605;
        b=hBj+coDIQyEVLZJ1RvFcTAnnMXso/6pD57cJopQ/XYHWwDbQQ45ZWZNCVI9QWHrjmx
         4/af3MmadCMKKmz+sLSIymHd4vEitLi3bt1SfscfZcFUpvBnoOPqH3OieP4S5ufGKLFN
         bRfL8V7k/8MxdJsJMMSJ1PMSO5IPNUxCrNN8IAfvxUQ2pVWQ0A1OreEKBRZKb/rh/2qW
         /vYWn3mPE3Mb2mx81NeUX1eDN2pz5yvPwIezkrq9kJZ04Tdm00hVQvid933EgfREAGCj
         4L5oCtg3fsQ//DsiiNWKBT1pYvob+Dj2cfTlGOZeNNFeElx02UMSaTwEZsvcTDtUjWIC
         vWMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UBeLfxkkc9vz/78ZEjGJfv2xum3ef060RpanVhN5jyU=;
        fh=thk4qHmA7myEapgMXLXMnO4Me/J4lvMWXs1ZRzQxxb8=;
        b=DXYsYTthU+TPoeFm8UpVRhxSrWit7PLXU40h7qVsf3m+BeaNG5KHYSAgqigm3nh0Os
         eJNO4FLzC5wjQ45A0hLvU0t+5e0A0rRSn3tvaBLjYsFH/z0wvnqvSdX556KlRXqf5EBN
         ZJ1qqylZiBUuIjJC53xtuXcrSz1Obm2p6mJHJP1kheKyQWPOhhppTwFg8G7CqaZIN9fi
         bket0qHa3G6ssAuC0nZdlP+Jdnc9lvTtlJ+OqqA8bjfY8tQipVtN88+3T7GeSvH2fwMM
         pIw4gPJhWN59uzDJ4bvGYm9BZ6WPjUzXgrW9/EB0zTwTz45oLrCO9zfvwfK7lAAtC1ok
         tLgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775200824; x=1775805624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UBeLfxkkc9vz/78ZEjGJfv2xum3ef060RpanVhN5jyU=;
        b=v1sHzYFVGLRdzUkpZf9qYrVIZWrnYWGehPsfZHUJr+BUTDBBKLBwoFdNXDKCrwOSLw
         C59+i+EFz5LgBy7Ng06fOTDjhz+yN6TOiNFqOzoaFXL+aCH7chzyXJa4reb9mQOF1GAN
         sDkingyVp1/VXT0vRsrIQQIJZb7Gneh8KMb4S5QK3RLHC1vOl+iYgNPKTBjk8x5/LPS0
         or6PNqMPfCLfbRNm4SgNV1EZ1PueclUmfcjpX0jbn4QdF1OtJwvVBlFeNajBnZg6EYvQ
         +YBxjJR08ZgEGX2n3O/LpjrnbwVd1dSAmtvjtD4qfwQkf56OvOyXY0MzIrHSqsxRvIof
         80pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775200824; x=1775805624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UBeLfxkkc9vz/78ZEjGJfv2xum3ef060RpanVhN5jyU=;
        b=aLw6ZjZ3bOfOUXgJRblDviBKIhmsr0nP5Bb1iC2pKYkAH77h53X5IMwnw5i2zCNh76
         mNddk2OGrOyNyzyCn0FYO5pF5O9n8xXpKDWKE/UH6OumuAG4Oxh6af0zRgiOQFe8V3fk
         5UY21/AAxC6AXoxrM2ooZ/f4GFuXl8xnFdYykBkDxr4E993sxVhdTVAmcc9RtJ6JtuZo
         HB83murKIjSzXzWlqldOb6m5MdJzWtcYM4qKWoyYwQBVcc47pBdOY8hXAVy/CpZFGkQo
         CH9CAdEET118O43key+n89HtfFiLTRE1s2fZ56buEmMfByubhd3Gmz36IKYLcLyBNQwc
         M76g==
X-Forwarded-Encrypted: i=1; AJvYcCWbkTtD1LsP67b0KGNluJ68vMkyyp2hgpvYeeWmIY/WD15xhbguuNJ64M6OBmBl/CJ6rO1yYeo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygk+KoxluPEmMIpnVYsoy4XUXYLxkgsqxlaMb6B5LmzOKF7V3r
	7cYP2UMvtaxKHmySb4obLc5l5kRdikHi8wh/v8YKqAsdpC6eF4+iIxUGxCPwBV/tnnwRTULfiG7
	0k+WlaKpGoCXrONpRfKEkObbUAfa01zScy9DG+Dij
X-Gm-Gg: ATEYQzzZSEMTmhLtwdPJKudqcwsWcwp2KB4GEQt6w/XF33fgw0W+I+IldpjoNiOr54/
	lYGTXiDnhEVEboNPyF82j4oB8sgG66ZdCZp44JEnAFoi5DVCazon+CbLR7+l2XJYieP66zJh4Fc
	CjWvel1HRbZOwS+0p/PmepBjB7esIAo5Ei61HSoqAB9SkTkZSygQ7DOOvsQvnERjo2liWSjVr5v
	BfZzy4UQvs2Q6St6HcoqEWZ4DUKCADUXoqFjdvoW9KVRll4C/eIXDUU6mI+Mc4HU+iDbT9yS47q
	8bYwV0o=
X-Received: by 2002:a05:622a:aa07:10b0:50b:4764:877 with SMTP id
 d75a77b69052e-50d62c858a5mr24447631cf.49.1775200823974; Fri, 03 Apr 2026
 00:20:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403043237.3909226-1-edumazet@google.com> <20260403043237.3909226-2-edumazet@google.com>
 <CANn89iK00Ttiq6CBkKZ1KdPbVwOgEMYwQP=6PK8fpYf2Fp9mDw@mail.gmail.com>
In-Reply-To: <CANn89iK00Ttiq6CBkKZ1KdPbVwOgEMYwQP=6PK8fpYf2Fp9mDw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 3 Apr 2026 00:20:13 -0700
X-Gm-Features: AQROBzC3LdhA0OxT7OYEOuqdMaBqdcXeZUOR7QXsxBrb-xj7btGPhF9uVunIKw0
Message-ID: <CANn89iLUN1F-NzdCpaPhZBFVZR6KjEuyPNhNXtWr6Hu4BFdyMw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/9] net: tso: add tso_features_check()
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Joe Damato <joe@dama.to>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,dama.to,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-274917-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: BCC07391B03
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 2, 2026 at 11:41=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Apr 2, 2026 at 9:32=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
> >
> > net/core/tso.c users expecting headers size is smaller
> > than TSO_HEADER_SIZE must fallback to GSO when headers
> > are too big.
> >
> > Provide tso_features_check() for drivers .ndo_features_check().
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  include/net/tso.h | 11 +++++++++++
> >  net/core/tso.c    | 12 ++++++++++++
> >  2 files changed, 23 insertions(+)
> >
> > diff --git a/include/net/tso.h b/include/net/tso.h
> > index e7e157ae0526c8d655aca67a8a49191ec870746b..9be7cb6553975a2a82e0987=
214fee6883bf74404 100644
> > --- a/include/net/tso.h
> > +++ b/include/net/tso.h
> > @@ -28,4 +28,15 @@ void tso_build_hdr(const struct sk_buff *skb, char *=
hdr, struct tso_t *tso,
> >  void tso_build_data(const struct sk_buff *skb, struct tso_t *tso, int =
size);
> >  int tso_start(struct sk_buff *skb, struct tso_t *tso);
> >
> > +static inline int tso_compute_hdr_len(const struct sk_buff *skb)
> > +{
> > +       int tlen =3D skb_is_gso_tcp(skb) ? tcp_hdrlen(skb) : sizeof(str=
uct udphdr);
> > +       int hdr_len =3D skb_transport_offset(skb) + tlen;
> > +
> > +       return hdr_len;
> > +}
> > +
> > +netdev_features_t tso_features_check(struct sk_buff *skb,
> > +                                    struct net_device *dev,
> > +                                    netdev_features_t features);
> >  #endif /* _TSO_H */
> > diff --git a/net/core/tso.c b/net/core/tso.c
> > index 6df997b9076e9842f3de7bb3e34599d8ff4e4fd4..81e2cc66d0dd29eeb647232=
e04032b1412382a6f 100644
> > --- a/net/core/tso.c
> > +++ b/net/core/tso.c
> > @@ -87,3 +87,15 @@ int tso_start(struct sk_buff *skb, struct tso_t *tso=
)
> >         return hdr_len;
> >  }
> >  EXPORT_SYMBOL(tso_start);
> > +
> > +netdev_features_t tso_features_check(struct sk_buff *skb,
> > +                                    struct net_device *dev,
> > +                                    netdev_features_t features)
> > +{
> > +       if (skb_is_gso(skb)) {
> > +               if (tso_compute_hdr_len(skb) > TSO_HEADER_SIZE)
> > +                       features &=3D ~NETIF_F_GSO_MASK;
> > +       }
> > +       return features;
>
> I forgot that netif_skb_features() uses:
>
> if (dev->netdev_ops->ndo_features_check)
>     features &=3D dev->netdev_ops->ndo_features_check(skb, dev,
>                                             features);
> else
>     features &=3D dflt_features_check(skb, dev, features);
>
> So I need to call vlan_features_check() from tso_features_check()

I could be wrong though, vlan_features_check() is about  skbs with
multiple vlan tags,
and net/core/tso.c should support them just fine.

