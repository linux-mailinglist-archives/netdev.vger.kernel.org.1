Return-Path: <netdev+bounces-257120-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2ApiH055hGlU3AMAu9opvQ
	(envelope-from <netdev+bounces-257120-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 12:04:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0309DF1A1A
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 12:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6D61301FF86
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 10:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBA13A9D9A;
	Thu,  5 Feb 2026 10:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmo-cybersecurity.com header.i=@gmo-cybersecurity.com header.b="iDcMxGw9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7323A9D8C
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 10:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770289145; cv=pass; b=bdpxFbTgEmlGWS+O6IpeQntp4d6164OkJRG59CC8RNho1meAl0K3WWDfn4mRBerSWZT6P34FZVpf8cDbV5uvAkmXAg+HciJzUfRFkGqvWqwyDSL7VkwLKoDAOLqJx+Gd918YvQOgomGAak4i6UK3x+iUQGMAIw9R/2KWx/xLeFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770289145; c=relaxed/simple;
	bh=GVBWX5tRLfEHRRoxbjV+QEXaQ6F+VIaBvY+pbfFy5V4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JEs15NdTV9A4kFlYLeWC/YGcS4uN8XoRp9xZt4sq0MJxNZGIfewJm0wzjXVEO++JZzTCI6OUDdX/+WD9F5Qi2KwqRY7qTOo32N9GK99tEQlC17a+3SzVWG/0+IV++xeRh7uoLRYH371i+9PyV+vJG6UgHagKSldPYiX6tpoXdsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmo-cybersecurity.com; spf=pass smtp.mailfrom=gmo-cybersecurity.com; dkim=pass (2048-bit key) header.d=gmo-cybersecurity.com header.i=@gmo-cybersecurity.com header.b=iDcMxGw9; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmo-cybersecurity.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmo-cybersecurity.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-432d2c7dd52so862519f8f.2
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 02:59:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770289143; cv=none;
        d=google.com; s=arc-20240605;
        b=hGiqZlNYYsvV6SBqjjtecXmea9Xc54NubjyQ9Q8jBP/x3MYGXyIQ27xAl4/Mx4e10/
         eZV/mdOVweKGDoRqSxk+Fx0ADraWkx8TWiNlv39Q0sjFhm0TDQv0FmIOKmcjhSX8wImc
         AVoAfjsBLwzfbrcARlReQSjRcFsD+F/Co12GYpNXjsYFw2AeiepZibIxJdaGpuv0s1DN
         C/PsXTRRc3AiOypfotq+prliT2d+xjA17J+39nr//UKfU8079wC7pzZMtSLQChPgjKTS
         C2hZ+deMVu0CVZt1aylmVCqWNRfUvfJurhsWfuAWlDKu2OLquemI8BN4OsGYfG5LlTfZ
         8FVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pYmS/kTSJY4JVBdH8Z7sKyLmRYOkO5gpX4XwJktm7bI=;
        fh=grYeGaqeO2SHJ5uj44wBocEC8FwcNHkZ5Urmr8NZ9wo=;
        b=gY8mn+qfBTQfZyk7cElaovUDuypyDr7+JHbDPcu8Byre7Rd0M5zSXARiHuMmKsZmhX
         nixeNovGEfTFl9VEUcA7jpFefiLTiNuBet0sEo/rkMdWC+vP+OPa3O4QWikPLQBOOG/v
         L5Yp9AkpVcoANe+/Kgik5kRM2PEfHFsf2QLhSJ7soN5tITEMaBj4c5NwMTyCexBAYz/F
         G2D7k77tvTaaBrhjItSQQHZhJShW4fHeroF8BwquzqKiaPVXGpoX2gOvbyasxQqlQjk6
         6VGzk4r5b18eXxe7yW24Pjdk1hMofdmMI5ua7we5xqTx+4rsa5uDLfNFp7zbMiQGdjTn
         /Yow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmo-cybersecurity.com; s=google; t=1770289143; x=1770893943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pYmS/kTSJY4JVBdH8Z7sKyLmRYOkO5gpX4XwJktm7bI=;
        b=iDcMxGw9f3rRIUkoGUkdiUcbhsBASa4p65+b+eMBc4/dQzwFPozlTjfdEqA2Ury1b+
         NsH6ixXqHkBaQc2oS7Wdox6+F0mIlNYCvaSsnCVjEACYbNyy5c0ydK9+PYg/V/zoKesd
         piYC3lLBbOdnMeW0uFmUi7+S3jBLW0Bt2FN+wkgBDxnvHh9EyY0OoeRsMJcXRfI84nML
         vGDWIE9QlGso6ZpWF4Odjf18cVptaUGYA0SfmGNgllvnjf7BggRgz0pcD2vgRzoO1pCW
         /C63JMZbG1AQFv8zjD6Kumc740+0uOY+YjIkTZ5hNAoZCqlg704oa5ORt0J8BghvDk7L
         fEOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770289143; x=1770893943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pYmS/kTSJY4JVBdH8Z7sKyLmRYOkO5gpX4XwJktm7bI=;
        b=QKC2G8TGbmAhNk0k4PxdowxqB/ZlwHClr7JEvudkwxyKI64qtvyq703QkdiSt0/io4
         kBOstD3X1H6A+b+05qYSSWuZykBTfI5CZk2OGUZQvCBkoDz6gOJOgRaP4Ef4vNJsxFui
         qUi/IKleXmpCSKKZrRiKSNydNYp8kSJZ5NyAifZew8fWHGk9Nhei4T8rJ9uL2+QCyBHv
         GCLeSNoOzMan7mEnpyvdhh5R7p1z0K6WLjd8sClCfqeUvesFYzGuym7XGV3kEpJU9hOc
         fSuKhTurBmDrrw8osYrSVVZqNAEHNTATIKZfI7fKTWzr9e5VEbzn7EjF0vbRdg8zJk6K
         xBEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVz5LIO/CeRk8ZZ+rE9HiEB0wLRMux+U0a5cxqeqSc9Ws6ihQ9MF+TTWwAHqM5elH/cUs3FJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZoQPf446GNNnoHPNKoAMvSJ0r72Zn5dAq4ASg2FryZo+/ixuY
	avjl5NvriiiJnl43t54evuVCiMdddkC2gY/FEXkCFJpPQgSIMesH+QSwmI7zp4OwWdzPjUDHmBE
	FfLrNYL5OzuN/EQN1thl8qqoz+ImjT11DRbKBTak+QQ==
X-Gm-Gg: AZuq6aJTw3Hnw+xN54EHSdXKN5YKUHOxm8ZRB5MTChZKFOz3HKwcoQFRUaCculXsW3I
	346fPz6rmOjIaAU5v7Y+ICqNlLGfxfNzwrRcRHxwA1+GssU5I5t+FviKcFkHcAM391cv8/iaeQJ
	7Up+X9p3NJmleGHRiOK4AFXz2gv0Y/jc5wZNSgtKUWRIt/mY6+DP7ri5053SEQMdoT4CiD16UnA
	LOw1cVLG7QUiOAsPasgrae3R2/tCMtMcF8g5TkuZwCOh9NMTyopDPGhneixDNd4leExWlsgB24S
	cBxFmlefkmedW2UkTaIx6miJXVvVTQ==
X-Received: by 2002:a5d:64c3:0:b0:435:bd00:cb4 with SMTP id
 ffacd0b85a97d-43617e3c8bdmr9988955f8f.23.1770289143011; Thu, 05 Feb 2026
 02:59:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAA3_Gnogt7GR0gZVZwQ4vXXav6TpXMK6t=QTLsqKOaX3Bo_tNA@mail.gmail.com>
 <CANn89iLVq=3d7Ra7gKmTpLcMzuWv+KamYs=KjUHH2z3cPpDBDA@mail.gmail.com>
 <CAA3_GnrVyeXtLjhZ_d9=0x58YmK+a9yADfp+LRCBHQo_TEDyvw@mail.gmail.com>
 <CANn89iJN-fcx-szsR3Azp8wQ0zhXp0XiYJofQU1zqqtdj7SWTA@mail.gmail.com>
 <CACwEKLp42TwpK_3FEp85bq81eA1zg3777guNMonW9cm2i7aN2Q@mail.gmail.com>
 <CAA3_Gnqo37RxLi2McF0=oRPZSw_P3Kya_3m3JBA2s6c0vaf5sw@mail.gmail.com>
 <CANn89iL8FnPG9bD6zW0eHmeSNzc33SJgrUR7Aab4PFG-O4nfTw@mail.gmail.com>
 <CAA3_GnpijQeBNVOqy6QtUMDjhy_ku_b54uf30zfEq=etMTqKrA@mail.gmail.com>
 <CANn89iK-Ojmi4kCZwXhFq-pG5PacLs=m71Jtw4zRpxaPEbJdhg@mail.gmail.com>
 <CAA3_GnpJ-RV=1xaf4DKRd30RgH0HoAxXJA1tx0cvBCX05OcYuA@mail.gmail.com> <CANn89iLVEJKoBtYNbAdLgxsPr03Fkgi9CJmTh1a0y0L5fV-HNA@mail.gmail.com>
In-Reply-To: <CANn89iLVEJKoBtYNbAdLgxsPr03Fkgi9CJmTh1a0y0L5fV-HNA@mail.gmail.com>
From: =?UTF-8?B?5oi455Sw5pmD5aSq?= <kota.toda@gmo-cybersecurity.com>
Date: Thu, 5 Feb 2026 19:58:00 +0900
X-Gm-Features: AZwV_QhOK9EgJ8bvAM8tTRxdaFCK_KRTKp9-RYdG7jfSIDMzcFsSk7QsBQk6Uuo
Message-ID: <CAA3_GnpjEcK01bJOyxDvDO70E0kqUey8r7W_WukUJzq3=wH+QQ@mail.gmail.com>
Subject: [PATCH net 2/2] net: add READ_ONCE for header_ops callbacks
To: Eric Dumazet <edumazet@google.com>
Cc: pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	=?UTF-8?B?5bCP5rGg5oKg55Sf?= <yuki.koike@gmo-cybersecurity.com>, 
	=?UTF-8?B?5oi455Sw5pmD5aSq?= <kota.toda@gmo-cybersecurity.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmo-cybersecurity.com,quarantine];
	R_DKIM_ALLOW(-0.20)[gmo-cybersecurity.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257120-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kota.toda@gmo-cybersecurity.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmo-cybersecurity.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmo-cybersecurity.com:email,gmo-cybersecurity.com:dkim,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0309DF1A1A
X-Rspamd-Action: no action

Use READ_ONCE when loading header_ops callbacks to avoid races with
concurrent updates.

Signed-off-by: Kota Toda <kota.toda@gmo-cybersecurity.com>
Signed-off-by: Yuki Koike <yuki.koike@gmo-cybersecurity.com>
Co-developed-by: Yuki Koike <yuki.koike@gmo-cybersecurity.com>
---
 include/linux/netdevice.h | 24 +++++++++++++++---------
 include/net/cfg802154.h   |  2 +-
 net/core/neighbour.c      |  6 +++---
 net/ipv4/arp.c            |  2 +-
 net/ipv6/ndisc.c          |  2 +-
 5 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 77a99c8ab..0d2c1c852 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3150,35 +3150,41 @@ static inline int dev_hard_header(struct
sk_buff *skb, struct net_device *dev,
                   const void *daddr, const void *saddr,
                   unsigned int len)
 {
-    if (!dev->header_ops || !dev->header_ops->create)
+    int (*create)(struct sk_buff *skb, struct net_device *dev,
+        unsigned short type, const void *daddr,
+        const void *saddr, unsigned int len);
+    if (!dev->header_ops || !(create =3D READ_ONCE(dev->header_ops->create=
)))
         return 0;

-    return dev->header_ops->create(skb, dev, type, daddr, saddr, len);
+    return create(skb, dev, type, daddr, saddr, len);
 }

 static inline int dev_parse_header(const struct sk_buff *skb,
                    unsigned char *haddr)
 {
+    int (*parse)(const struct sk_buff *skb, unsigned char *haddr);
     const struct net_device *dev =3D skb->dev;

-    if (!dev->header_ops || !dev->header_ops->parse)
+    if (!dev->header_ops || !(parse =3D READ_ONCE(dev->header_ops->parse))=
)
         return 0;
-    return dev->header_ops->parse(skb, haddr);
+    return parse(skb, haddr);
 }

 static inline __be16 dev_parse_header_protocol(const struct sk_buff *skb)
 {
+    __be16    (*parse_protocol)(const struct sk_buff *skb);
     const struct net_device *dev =3D skb->dev;

-    if (!dev->header_ops || !dev->header_ops->parse_protocol)
+    if (!dev->header_ops || !(parse_protocol =3D
READ_ONCE(dev->header_ops->parse_protocol)))
         return 0;
-    return dev->header_ops->parse_protocol(skb);
+    return parse_protocol(skb);
 }

 /* ll_header must have at least hard_header_len allocated */
 static inline bool dev_validate_header(const struct net_device *dev,
                        char *ll_header, int len)
 {
+    bool    (*validate)(const char *ll_header, unsigned int len);
     if (likely(len >=3D dev->hard_header_len))
         return true;
     if (len < dev->min_header_len)
@@ -3189,15 +3195,15 @@ static inline bool dev_validate_header(const
struct net_device *dev,
         return true;
     }

-    if (dev->header_ops && dev->header_ops->validate)
-        return dev->header_ops->validate(ll_header, len);
+    if (dev->header_ops && (validate =3D READ_ONCE(dev->header_ops->valida=
te)))
+        return validate(ll_header, len);

     return false;
 }

 static inline bool dev_has_header(const struct net_device *dev)
 {
-    return dev->header_ops && dev->header_ops->create;
+    return dev->header_ops && READ_ONCE(dev->header_ops->create);
 }

 /*
diff --git a/include/net/cfg802154.h b/include/net/cfg802154.h
index 76d2cd2e2..dec638763 100644
--- a/include/net/cfg802154.h
+++ b/include/net/cfg802154.h
@@ -522,7 +522,7 @@ wpan_dev_hard_header(struct sk_buff *skb, struct
net_device *dev,
 {
     struct wpan_dev *wpan_dev =3D dev->ieee802154_ptr;

-    return wpan_dev->header_ops->create(skb, dev, daddr, saddr, len);
+    return READ_ONCE(wpan_dev->header_ops->create)(skb, dev, daddr,
saddr, len);
 }
 #endif

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 96786016d..ff948e35e 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -1270,7 +1270,7 @@ static void neigh_update_hhs(struct neighbour *neigh)
         =3D NULL;

     if (neigh->dev->header_ops)
-        update =3D neigh->dev->header_ops->cache_update;
+        update =3D READ_ONCE(neigh->dev->header_ops->cache_update);

     if (update) {
         hh =3D &neigh->hh;
@@ -1540,7 +1540,7 @@ static void neigh_hh_init(struct neighbour *n)
      * hh_cache entry.
      */
     if (!hh->hh_len)
-        dev->header_ops->cache(n, hh, prot);
+        READ_ONCE(dev->header_ops->cache)(n, hh, prot);

     write_unlock_bh(&n->lock);
 }
@@ -1556,7 +1556,7 @@ int neigh_resolve_output(struct neighbour
*neigh, struct sk_buff *skb)
         struct net_device *dev =3D neigh->dev;
         unsigned int seq;

-        if (dev->header_ops->cache && !READ_ONCE(neigh->hh.hh_len))
+        if (READ_ONCE(dev->header_ops->cache) && !READ_ONCE(neigh->hh.hh_l=
en))
             neigh_hh_init(neigh);

         do {
diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index 7822b2144..421bea6eb 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -278,7 +278,7 @@ static int arp_constructor(struct neighbour *neigh)
             memcpy(neigh->ha, dev->broadcast, dev->addr_len);
         }

-        if (dev->header_ops->cache)
+        if (READ_ONCE(dev->header_ops->cache))
             neigh->ops =3D &arp_hh_ops;
         else
             neigh->ops =3D &arp_generic_ops;
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index d961e6c2d..d81f509ec 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -361,7 +361,7 @@ static int ndisc_constructor(struct neighbour *neigh)
             neigh->nud_state =3D NUD_NOARP;
             memcpy(neigh->ha, dev->broadcast, dev->addr_len);
         }
-        if (dev->header_ops->cache)
+        if (READ_ONCE(dev->header_ops->cache))
             neigh->ops =3D &ndisc_hh_ops;
         else
             neigh->ops =3D &ndisc_generic_ops;
--
2.53.0


2026=E5=B9=B42=E6=9C=883=E6=97=A5(=E7=81=AB) 2:11 Eric Dumazet <edumazet@go=
ogle.com>:
>
> On Wed, Jan 28, 2026 at 11:46=E2=80=AFAM =E6=88=B8=E7=94=B0=E6=99=83=E5=
=A4=AA <kota.toda@gmo-cybersecurity.com> wrote:
> >
> > Here is the patch with the barriers added, based on v6.12.67.
> >
> > However, as Yuki said, we are wondering if this would be considered an
> > acceptable change
> > from the perspective of the maintainers (or in terms of Linux kernel
> > culture). This is because
> > the patch adds `READ_ONCE` to several locations outside of bonding subs=
ystem.
> > Please let me know if you have any concerns regarding this point.
> >
> > >  Also, please clarify what happens with stacks of two or more bonding=
 devices ?
> >
> > To clarify, currently the `header_ops` of the bottom-most
> > interface are used regardless of the number of bonding layers.
> > This patch changes it so that `&bond->bond_header_ops` is used
> > as the bond device's `header_ops`, regardless of the stack depth.
>
> Could you try to cook a patch series perhaps ?
>
> The READ_ONCE()/WRITE_ONCE() on dev->header_ops->cache could be done sepa=
rately.
>
> Thanks.

