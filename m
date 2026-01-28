Return-Path: <netdev+bounces-254194-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GoAAynpeWkF1AEAu9opvQ
	(envelope-from <netdev+bounces-254194-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 11:47:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1175A9FA81
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 11:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4B2F23004C89
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 10:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0E732ED2C;
	Wed, 28 Jan 2026 10:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmo-cybersecurity.com header.i=@gmo-cybersecurity.com header.b="ORnL4hUk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B22528CF6F
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 10:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769597220; cv=pass; b=HlzOMhCYK5DsWQDm3c9FmOznXlT6uFoWN9hDcvoDHWGkphR1F8Dyifma5MU3Ky9NKHh8TbfoSztOLHfbMoYM5WGq/TfC7RtW/ajpL3+nE+ICEUqXE1D4d6k1/ucjGt8dd5i9qBikQ3VttFiU6XWWq2FyUXFVRHzhmkwSPbVCBnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769597220; c=relaxed/simple;
	bh=p1n1yzln6y96T9gevVkb+vNWCaWT8w9GqED8f4PRFic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GgUqopUn+JJZ9X5NCmcOnjqRdD0Dv5wiWRiunhrkU6F7MooQMbJ7skhteNeSwV8aPS8wbI2aAYqOves4lVnKGfpzYXJEYoO5QSYAiWM7ZtcclKE+zX8PLSnn/sHpODVa6W7jwk2xvTsD238ep/4qpaL0GsSK4AB3B8o412L+6gU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmo-cybersecurity.com; spf=pass smtp.mailfrom=gmo-cybersecurity.com; dkim=pass (2048-bit key) header.d=gmo-cybersecurity.com header.i=@gmo-cybersecurity.com header.b=ORnL4hUk; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmo-cybersecurity.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmo-cybersecurity.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-432d2c7a8b9so6417070f8f.2
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 02:46:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769597216; cv=none;
        d=google.com; s=arc-20240605;
        b=VHyMw8+mQUXvXByacP9GVPMwjLIyYL5DJDgO7v7czfZHWf8HNpHWNSMDlEMrr9hwpD
         oGUH3D3wYqtzCfSwfSAmVI7LTI/hFxYgdJ342T8BSUOrprCfEWGfDjUEb99DPhKZLplV
         FQtCqWbbMI0FLs8GItVGsNHzVmKMq84mV5NVbDpByq5VlpGiTBx7XFbRdLjNat2Hp1lE
         HMDVK18sBxwgwZbOAqBHSKCtLb1o1bp7MEd+f+I4nkBOkk4TC26XBGYyBsGCIbw2QAzv
         CyJICUJ2xW9erqOC2a5rc9kR5y4stc+frIlOXiNDIqwDmQpAAdaHBPIJb2kz5KuxWtya
         tlHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1OvFUZYg6fJv2f9rEBKQHhZkzXVYdvHIMVsSi2LhF6I=;
        fh=dRom7g0dEJOZnlgO65vaIilXQOnplrqzdCgWEiB4xBk=;
        b=htf3jLHYUFIUPGkLSrpqZeni+IpqMXDW/giM7axoN2LVxQxmWT2JWPFYBX54Lb8b1N
         G/0k6CvNBq85uhy6IegV8Ell9JyAE/Ay7xLOgM2j4Bv1yOnYU2/UuK1837i6MXi7b+Lb
         8b+/7BgMQiikNCOBa9ADVdsakWfC3LPi6X4M4KLbaBNryKts39MHbOliYJOCqbCAfh3U
         GTqKjjBSF3el75/aJTlM70LaFNToMjZTDFRZVVFNgLBPStSx+f9yU/0ALef3zHjdBay4
         YHaJtUD/scgvMEXo3JloZW/Cg2W5sY8oPqkuomzCcyqw9hRCo1cYf22DCFM+OQj/zzWW
         pU3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmo-cybersecurity.com; s=google; t=1769597216; x=1770202016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1OvFUZYg6fJv2f9rEBKQHhZkzXVYdvHIMVsSi2LhF6I=;
        b=ORnL4hUks/mar80FhNlDu39g2HIukoKgcYLLiIsdJeLZdagMrJ7NTuqIo6oc0lJTre
         A6P8WxQ50hNip0H78DSa8DFXqBWOaqYWAqFMZSwUREcv6PX+tUQ5/NpHNn///T7vxgkO
         W0ay2KGtM9Qm954ALWwxbzlJOHNT9bJ2n71v79pQVkcvmYmIdolSqi3Vd0ZaGggR8nIQ
         yp1KFHOiTU4gqeWtITCoDyqX35VN4i44HrhlGMN+yo+4OIy3WVqi21L7fViKVcz9MyA+
         hkMxwkNrsk6YkpJhB0PpB/Mslh4WIme4DAMMa2UkyXoYdKeE8s41W4puwH52LuEjgbaB
         S5ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769597216; x=1770202016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1OvFUZYg6fJv2f9rEBKQHhZkzXVYdvHIMVsSi2LhF6I=;
        b=Eu0iRce6aVmDEonawAxFjFRaAqSWMcplWmnL0QKOBPuwoizQitAmaQ/+JWEZ+rsEOc
         pmYrk8YwMmzbJ/MQKEUvx/f7nEvm81YxnF3W9M9CfxmT49gytym/7Q8Sj562F095qaep
         fudqGK3OMtpZrADT1YWzzKq2T8UqWK5s295GYtRpptS1Bhbgonddsak820+th25NE/bv
         mmaWZR4pdZRnd3ZLZOwxEXnq2LOyqvoCA4qWGBQLo/iN3cTaYGKetK4mcvJYE74HYMIH
         mN6FPQaIUikeTpdFxIhCeICIrcApzTx5cZnfCrqdwDooaO24FMrrG/KV/oYxa63Q+ZwJ
         1HJg==
X-Forwarded-Encrypted: i=1; AJvYcCW7Tali3zaeaq7/1LYBB6G7kCQMlEKTzvPBYwtbndnMN8JjaSFmhEq3MVujzMlRB26JVWx5NMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0Tu87/ugZOQKQRb+6UfsdiZM2rC+b27wcKv4xXHSDJvl1SHwP
	sq5cAZa1UJqc+Ge7eqbsWddrhV2PO+zITHAYKid6wZiLqLlvPe6IMGctfkAEOIXvKYJsEH7b9/7
	VT9LwdR9AXjM1l6HCRxHVZnZsQlIKhCaUwrwAMoC4/g==
X-Gm-Gg: AZuq6aLIhaU6doXJdWy3Ta1ceBjVW7jS9xHMpGdr3WLCq3sa5BLEFT9YkMRK5nu20YP
	amY3uQiwZOvq4h6cZvijdLXB3PSsQaC25KYzcIgyJwYycnv/KaIA6+4yNWgbgLK7KZU1Skn1gPX
	d3NAZLaGpaAjY+SiAsJb0wdCzBYvb7MYQXUZUooiwOiV00QK9qFXoGN35CYLiyo7Af4hbyeWI9x
	DOjYts8+FMGM6kfNVYu5Sb1gtL5FV35JgNJLAUNMSlnD8KfZgzbpXW+F8oy1MdW+k6C6wOvKQ==
X-Received: by 2002:a05:6000:2585:b0:431:907:f308 with SMTP id
 ffacd0b85a97d-435dd1d3769mr6596963f8f.61.1769597215620; Wed, 28 Jan 2026
 02:46:55 -0800 (PST)
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
 <CAA3_GnpijQeBNVOqy6QtUMDjhy_ku_b54uf30zfEq=etMTqKrA@mail.gmail.com> <CANn89iK-Ojmi4kCZwXhFq-pG5PacLs=m71Jtw4zRpxaPEbJdhg@mail.gmail.com>
In-Reply-To: <CANn89iK-Ojmi4kCZwXhFq-pG5PacLs=m71Jtw4zRpxaPEbJdhg@mail.gmail.com>
From: =?UTF-8?B?5oi455Sw5pmD5aSq?= <kota.toda@gmo-cybersecurity.com>
Date: Wed, 28 Jan 2026 19:46:44 +0900
X-Gm-Features: AZwV_QjGf4LRbQaMPq0f1jpV7LLwQ739Fy582bccAaN1j3tf4WwEQUmPl2Ft0m0
Message-ID: <CAA3_GnpJ-RV=1xaf4DKRd30RgH0HoAxXJA1tx0cvBCX05OcYuA@mail.gmail.com>
Subject: Re: [PATCH net] bonding: Fix header_ops type confusion
To: Eric Dumazet <edumazet@google.com>
Cc: pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	=?UTF-8?B?5bCP5rGg5oKg55Sf?= <yuki.koike@gmo-cybersecurity.com>, 
	=?UTF-8?B?5oi455Sw5pmD5aSq?= <kota.toda@gmo-cybersecurity.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	URI_HIDDEN_PATH(1.00)[https://storage.googleapis.com/kernelctf-build/releases/lts-6.12.65/.config];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmo-cybersecurity.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmo-cybersecurity.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254194-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kota.toda@gmo-cybersecurity.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmo-cybersecurity.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmo-cybersecurity.com:email,gmo-cybersecurity.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,storage.googleapis.com:url]
X-Rspamd-Queue-Id: 1175A9FA81
X-Rspamd-Action: no action

Here is the patch with the barriers added, based on v6.12.67.

However, as Yuki said, we are wondering if this would be considered an
acceptable change
from the perspective of the maintainers (or in terms of Linux kernel
culture). This is because
the patch adds `READ_ONCE` to several locations outside of bonding subsyste=
m.
Please let me know if you have any concerns regarding this point.

>  Also, please clarify what happens with stacks of two or more bonding dev=
ices ?

To clarify, currently the `header_ops` of the bottom-most
interface are used regardless of the number of bonding layers.
This patch changes it so that `&bond->bond_header_ops` is used
as the bond device's `header_ops`, regardless of the stack depth.

```
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_mai=
n.c
index f17a170d1..5ecc64e38 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1616,14 +1616,70 @@ static void bond_compute_features(struct bonding *b=
ond)
     netdev_change_features(bond_dev);
 }

+static int bond_hard_header(struct sk_buff *skb, struct net_device *dev,
+        unsigned short type, const void *daddr,
+        const void *saddr, unsigned int len)
+{
+    struct bonding *bond =3D netdev_priv(dev);
+    struct net_device *slave_dev;
+
+    slave_dev =3D bond->header_slave_dev;
+
+    return dev_hard_header(skb, slave_dev, type, daddr, saddr, len);
+}
+
+static void bond_header_cache_update(struct hh_cache *hh, const
+struct net_device *dev,
+        const unsigned char *haddr)
+{
+    const struct bonding *bond =3D netdev_priv(dev);
+    void (*cache_update)(struct hh_cache *hh,
+        const struct net_device *dev,
+        const unsigned char *haddr);
+    struct net_device *slave_dev;
+
+    slave_dev =3D bond->header_slave_dev;
+
+    if (!slave_dev->header_ops || !(cache_update =3D
READ_ONCE(slave_dev->header_ops->cache_update)))
+        return;
+
+    cache_update(hh, slave_dev, haddr);
+}
+
+
 static void bond_setup_by_slave(struct net_device *bond_dev,
                 struct net_device *slave_dev)
 {
+    struct bonding *bond =3D netdev_priv(bond_dev);
     bool was_up =3D !!(bond_dev->flags & IFF_UP);

     dev_close(bond_dev);

-    bond_dev->header_ops        =3D slave_dev->header_ops;
+    /* Some functions are given dev as an argument
+    * while others not. When dev is not given, we cannot
+    * find out what is the slave device through struct bonding
+    * (the private data of bond_dev). Therefore, we need a raw
+    * header_ops variable instead of its pointer to const header_ops
+    * and assign slave's functions directly.
+    * For the other case, we set the wrapper functions that pass
+    * slave_dev to the wrapped functions.
+    */
+    bond->bond_header_ops.create =3D bond_hard_header;
+    bond->bond_header_ops.cache_update =3D bond_header_cache_update;
+    if (slave_dev->header_ops) {
+        WRITE_ONCE(bond->bond_header_ops.parse, slave_dev->header_ops->par=
se);
+        WRITE_ONCE(bond->bond_header_ops.cache, slave_dev->header_ops->cac=
he);
+        WRITE_ONCE(bond->bond_header_ops.validate,
slave_dev->header_ops->validate);
+        WRITE_ONCE(bond->bond_header_ops.parse_protocol,
slave_dev->header_ops->parse_protocol);
+    } else {
+        WRITE_ONCE(bond->bond_header_ops.parse, NULL);
+        WRITE_ONCE(bond->bond_header_ops.cache, NULL);
+        WRITE_ONCE(bond->bond_header_ops.validate, NULL);
+        WRITE_ONCE(bond->bond_header_ops.parse_protocol, NULL);
+    }
+
+    bond->header_slave_dev      =3D slave_dev;
+    bond_dev->header_ops        =3D &bond->bond_header_ops;

     bond_dev->type            =3D slave_dev->type;
     bond_dev->hard_header_len   =3D slave_dev->hard_header_len;
@@ -2682,6 +2738,14 @@ static int bond_release_and_destroy(struct
net_device *bond_dev,
     struct bonding *bond =3D netdev_priv(bond_dev);
     int ret;

+    /* If slave_dev is the earliest registered one, we must clear
+    * the variables related to header_ops to avoid dangling pointer.
+    */
+    if (bond->header_slave_dev =3D=3D slave_dev) {
+        bond->header_slave_dev =3D NULL;
+        bond_dev->header_ops =3D NULL;
+    }
+
     ret =3D __bond_release_one(bond_dev, slave_dev, false, true);
     if (ret =3D=3D 0 && !bond_has_slaves(bond) &&
         bond_dev->reg_state !=3D NETREG_UNREGISTERING) {
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
diff --git a/include/net/bonding.h b/include/net/bonding.h
index 95f67b308..c37800e17 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -215,6 +215,11 @@ struct bond_ipsec {
  */
 struct bonding {
     struct   net_device *dev; /* first - useful for panic debug */
+    struct   net_device *header_slave_dev;  /* slave net_device for
header_ops */
+    /* maintained as a non-const variable
+    * because bond's header_ops should change depending on slaves.
+    */
+    struct   header_ops bond_header_ops;
     struct   slave __rcu *curr_active_slave;
     struct   slave __rcu *current_arp_slave;
     struct   slave __rcu *primary_slave;
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
```

2026=E5=B9=B41=E6=9C=8819=E6=97=A5(=E6=9C=88) 18:30 Eric Dumazet <edumazet@=
google.com>:
>
> On Mon, Jan 19, 2026 at 6:36=E2=80=AFAM =E6=88=B8=E7=94=B0=E6=99=83=E5=A4=
=AA <kota.toda@gmo-cybersecurity.com> wrote:
> >
> > Thanks for your quick response.
> >
> > The following information is based on Linux kernel version 6.12.65,
> > the latest release in the 6.12 tree.
> > The kernel config is identical to that of the kernelCTF instance
> > (available at: https://storage.googleapis.com/kernelctf-build/releases/=
lts-6.12.65/.config)
> >
> >
> > This type confusion occurs in several locations, including,
> > for example, `ipgre_header` (`header_ops->create`),
> > where the private data of the network device is incorrectly cast as
> > `struct ip_tunnel *`.
> >
> > ```
> > static int ipgre_header(struct sk_buff *skb, struct net_device *dev,
> >       unsigned short type,
> >       const void *daddr, const void *saddr, unsigned int len)
> > {
> >   struct ip_tunnel *t =3D netdev_priv(dev);
> >   struct iphdr *iph;
> >   struct gre_base_hdr *greh;
> > ...
> > ```
> >
> > When a bond interface is given to this function,
> > it should not reference the private data as `struct ip_tunnel *`,
> > because the bond interface uses the private data as `struct bonding *`.
> > (quickly confirmed by seeing drivers/net/bonding/bond_netlink.c:909)
> >
> > ```
> > struct rtnl_link_ops bond_link_ops __read_mostly =3D {
> >     .kind            =3D "bond",
> >     .priv_size        =3D sizeof(struct bonding),
> > ...
> > ```
> >
> > The stack trace below is the backtrace of all stack frame during a
> > call to `ipgre_header`.
> >
> > ```
> > ipgre_header at net/ipv4/ip_gre.c:890
> > dev_hard_header at ./include/linux/netdevice.h:3156
> > packet_snd at net/packet/af_packet.c:3082
> > packet_sendmsg at net/packet/af_packet.c:3162
> > sock_sendmsg_nosec at net/socket.c:729
> > __sock_sendmsg at net/socket.c:744
> > __sys_sendto at net/socket.c:2213
> > __do_sys_sendto at net/socket.c:2225
> > __se_sys_sendto at net/socket.c:2221
> > __x64_sys_sendto at net/socket.c:2221
> > do_syscall_x64 at arch/x86/entry/common.c:47
> > do_syscall_64 at arch/x86/entry/common.c:78
> > entry_SYSCALL_64 at arch/x86/entry/entry_64.S:121
> > ```
> >
> > This causes memory corruption during subsequent operations.
> >
> > The following stack trace shows a General Protection Fault triggered
> > when sending a packet
> > to a bonding interface that has an IPv4 GRE interface as a slave.
> >
> > ```
> > [    1.712329] Oops: general protection fault, probably for
> > non-canonical address 0xdead0000cafebabe: 0000 [#1] SMP NOPTI
> > [    1.712972] CPU: 0 UID: 1000 PID: 205 Comm: exp Not tainted 6.12.65 =
#1
> > [    1.713344] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> > BIOS Arch Linux 1.17.0-2-2 04/01/2014
> > [    1.713890] RIP: 0010:skb_release_data+0x8a/0x1c0
> > [    1.714162] Code: c0 00 00 00 49 03 86 c8 00 00 00 0f b6 10 f6 c2
> > 01 74 48 48 8b 70 28 48 85 f6 74 3f 41 0f b6 5d 00 83 e3 10 40 f6 c6
> > 01 75 24 <48> 8b 06 ba 01 00 00 00 4c 89 f7 48 8b 00 ff d0 0f 1f 00 41
> > 8b6
> > [    1.715276] RSP: 0018:ffffc900007cfcc0 EFLAGS: 00010246
> > [    1.715583] RAX: ffff888106fe12c0 RBX: 0000000000000010 RCX: 0000000=
000000000
> > [    1.716036] RDX: 0000000000000017 RSI: dead0000cafebabe RDI: ffff888=
1059c4a00
> > [    1.716504] RBP: ffffc900007cfe10 R08: 0000000000000010 R09: 0000000=
000000000
> > [    1.716955] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000=
000000002
> > [    1.717429] R13: ffff888106fe12c0 R14: ffff8881059c4a00 R15: ffff888=
106e57000
> > [    1.717866] FS:  0000000038e54380(0000) GS:ffff88813bc00000(0000)
> > knlGS:0000000000000000
> > [    1.718350] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [    1.718703] CR2: 00000000004bf480 CR3: 00000001009ec001 CR4: 0000000=
000772ef0
> > [    1.719109] PKRU: 55555554
> > [    1.719297] Call Trace:
> > [    1.719461]  <TASK>
> > [    1.719611]  sk_skb_reason_drop+0x58/0x120
> > [    1.719891]  packet_sendmsg+0xbcb/0x18f0
> > [    1.720166]  ? pcpu_alloc_area+0x186/0x260
> > [    1.720421]  __sys_sendto+0x1e2/0x1f0
> > [    1.720691]  __x64_sys_sendto+0x24/0x30
> > [    1.720948]  do_syscall_64+0x58/0x120
> > [    1.721174]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > [    1.721509] RIP: 0033:0x42860d
> > [    1.721713] Code: c3 ff ff ff ff 64 89 02 eb b9 0f 1f 00 f3 0f 1e
> > fa 80 3d 5d 4a 09 00 00 41 89 ca 74 20 45 31 c9 45 31 c0 b8 2c 00 00
> > 00 0f 05 <48> 3d 00 f0 ff ff 77 6b c3 66 2e 0f 1f 84 00 00 00 00 00 55
> > 489
> > [    1.722837] RSP: 002b:00007fff597e95e8 EFLAGS: 00000246 ORIG_RAX:
> > 000000000000002c
> > [    1.723315] RAX: ffffffffffffffda RBX: 00000000000003e8 RCX: 0000000=
00042860d
> > [    1.723721] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000=
000000310
> > [    1.724103] RBP: 00007fff597e9880 R08: 0000000000000000 R09: 0000000=
000000000
> > [    1.724565] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ff=
f597e99f8
> > [    1.725010] R13: 00007fff597e9a08 R14: 00000000004b7828 R15: 0000000=
000000001
> > [    1.725441]  </TASK>
> > [    1.725594] Modules linked in:
> > [    1.725790] ---[ end trace 0000000000000000 ]---
> > [    1.726057] RIP: 0010:skb_release_data+0x8a/0x1c0
> > [    1.726339] Code: c0 00 00 00 49 03 86 c8 00 00 00 0f b6 10 f6 c2
> > 01 74 48 48 8b 70 28 48 85 f6 74 3f 41 0f b6 5d 00 83 e3 10 40 f6 c6
> > 01 75 24 <48> 8b 06 ba 01 00 00 00 4c 89 f7 48 8b 00 ff d0 0f 1f 00 41
> > 8b6
> > [    1.727285] RSP: 0018:ffffc900007cfcc0 EFLAGS: 00010246
> > [    1.727623] RAX: ffff888106fe12c0 RBX: 0000000000000010 RCX: 0000000=
000000000
> > [    1.728052] RDX: 0000000000000017 RSI: dead0000cafebabe RDI: ffff888=
1059c4a00
> > [    1.728467] RBP: ffffc900007cfe10 R08: 0000000000000010 R09: 0000000=
000000000
> > [    1.728908] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000=
000000002
> > [    1.729323] R13: ffff888106fe12c0 R14: ffff8881059c4a00 R15: ffff888=
106e57000
> > [    1.729744] FS:  0000000038e54380(0000) GS:ffff88813bc00000(0000)
> > knlGS:0000000000000000
> > [    1.730236] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [    1.730597] CR2: 00000000004bf480 CR3: 00000001009ec001 CR4: 0000000=
000772ef0
> > [    1.730988] PKRU: 55555554
> > ```
> >
>
> OK thanks.
>
> I will repeat my original feedback : I do not see any barriers in the
> patch you sent.
>
> Assuming bond_setup_by_slave() can be called multiple times during one
> master lifetime, I do not think your patch is enough.
>
> Also, please clarify what happens with stacks of two or more bonding devi=
ces ?

