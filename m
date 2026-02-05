Return-Path: <netdev+bounces-257119-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mO7hFO53hGkX3AMAu9opvQ
	(envelope-from <netdev+bounces-257119-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 11:58:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C511FF18ED
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 11:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F9E0300B840
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 10:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94173A9D99;
	Thu,  5 Feb 2026 10:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmo-cybersecurity.com header.i=@gmo-cybersecurity.com header.b="Iqd8myfw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369753A9D83
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 10:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770289131; cv=pass; b=gHEGIPSVWHfqB42BQod63uBKIlczURaDI1m5sz/BSCTe4+0JNKEUCGbVq7J3FzhhVxyg9aczPi8JI+R88DbKegdlX8jWicZ8V+Hy3pPgSjUsNL8ihoOTkfqfMcognaUluivgnkRXj1p0dh+jRIGIyRMUT7YNsdFCK1rN4zaUTwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770289131; c=relaxed/simple;
	bh=f7IERFkoKWuYh6afEXqBJPo+eY//jSTQG8wEYDW5HLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hEpcrmw/QbNf+iHXcDRvqoIXJ+6oeLnPoJxN9y6ebRuELMkJvnb0MfffDydcwtsHY5xp9JRxIq4Sp63gyuCjSiQ6w2GTAlyibpVTfqjlZYmJVEe3B6JYv9z9BONGuh5FqbpmQOVbLRnlCsxEJBpr9tiKUAGVdR+NBjYbPK1hqmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmo-cybersecurity.com; spf=pass smtp.mailfrom=gmo-cybersecurity.com; dkim=pass (2048-bit key) header.d=gmo-cybersecurity.com header.i=@gmo-cybersecurity.com header.b=Iqd8myfw; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmo-cybersecurity.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmo-cybersecurity.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4359a16a400so843531f8f.1
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 02:58:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770289129; cv=none;
        d=google.com; s=arc-20240605;
        b=goehX/QAucylfhD6i6YrTkzRR7dvK0eBdpORuC3qnj7xbEIFArb76oW9kSdlWUfzqe
         2BOaB0w+/kqCtKxKUjTH3yewWqYTU3MhBr6KgKriGB67QuQwwqw9Qs0w9C0PlEa7MOYk
         LzOXEFyZID2i/O21gNpbsata2yhrjq106ga9pdHw/mjVtb7iWydBveUq9j9Dht9CvlZ9
         fP85B4NVDbxWmmVTEAnY18cbVp6PJLz/+rm+yBNONs7T6pdRoT7mTjRvUgSdSJ/ne/Ob
         msDFcew58wixonQol4NIPEhTaoSHklxlaXuUl0RTGWGTNT32EKqSu9k/nKBwLCpR5d6V
         TCLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WiTTXwCZq94jW+6QcbUtWuFwcyG4YV/KN+PPy271Tdc=;
        fh=nRQazM8UkziWXsX/egYj9dukqwvkxVZTbQfYtqqYcXA=;
        b=gSMNOMINc7Ow4uaCFeaqmABZjSnBFwDIxv1LQNpfiqmyKWXqJEs+TFO1YXfzEJYckG
         S1RFB4afDfPHWlmMebhtnBZ/IXvsfqwyDznbw+q1qFBGDDXTo398yibQn6Mz7f66fi+U
         HuGBBO5zbCD4lV8tVcgkxvZLHhcyx0bUkVpwUmLi4xbxQeqPwMMFgSGH5pGclUG4CA4P
         eU6NN9EmuhzPqim1C8dOY1Otqmw5cEv5r8nvwecJmSWvyZD8cPPqeLjJq1NnkwtJh4sc
         2SViOJZByNVeQsyiBnwH4aEW2MDzlBbMNIk8wqqXNnxPANtNGks0PYHJBqVWz+64bCdF
         MLPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmo-cybersecurity.com; s=google; t=1770289129; x=1770893929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WiTTXwCZq94jW+6QcbUtWuFwcyG4YV/KN+PPy271Tdc=;
        b=Iqd8myfwYmb8gigwKUN5r4AX4Qx0HAnbH0S/VcEDHsRzcuYQkGP9r2Ecbgy8jd01la
         Rw4ACetbMXjin8l4o0lOc5MaXQ8p5DB34YpMGRv+Wr7hJvdPwbu9LfKtGiv9Y3iG2YUx
         YptPsFXkVnZLhA+BDejH6Hj3StqnYXw9SnirItAjf6ex1V1V/dqBOtQD7mlz6SAK5T/d
         9b6NDBWB9EojT9mApu1Xb2yhVF+YWrJ8nStTloJeuDGYllU/4Wqh+XGSaPg0IcwOj2XQ
         YO9mWT8RAiGWSTXWrCi1XgacDeXRIosyFWl2JlxUHJIdkX+7lX0MJZd9Ohmv27rF9jrZ
         +DjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770289129; x=1770893929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WiTTXwCZq94jW+6QcbUtWuFwcyG4YV/KN+PPy271Tdc=;
        b=AQL7UoWP9Qx29R0X3ttPXXZfctWzr9+jbOyQsJn668OmITvbJ3b0hVjeys0ti4J2Id
         78vqHAekKyAI1xtWusaNYuCLRXerQweE2Il3wjPBYSuoP45TY11V/+cFQ7lr4eQU9nPz
         XgGR3iVBF1EtHaxD3loy5GZKfEND1wl7PV/aJELgNw4AMh0HACRzOCAlaPQeXWiE8JrC
         /+1i/L/4bGciQeVBiw+ku61YVEzdkPjH9hi5GVWC1W888hyrO2nnh2xfg0J6JXPMvmEF
         qZaYMjbjqXrAUUAACJS6WWtVOeZI+cNVo9J+/R0uHHJmCCVez1kVLzhpPdFsVDyyDmB2
         JDzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcFMZ/L/NfauFpeyERw5FG65TiR3zctHbgaoCAwMBd/LAVaKz5ympgfUV/Quzeed4NPY1zVHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJNifhzoy6rJ9XsL7jZDSg2ykIM+NuBC/mZgiUa+UBF84SkqVL
	l2XSzJGIAkTXib8l3YOotYnDHRzaHvv3E67RlE4XvrIyTqEVupZ2pqmSzGGopBvw7xCnL2ta+G0
	tCytdrmUbiu4QZNn5vjHzxnwjFVEB140aS5txlnIqgA==
X-Gm-Gg: AZuq6aKbu7exuewF6e2HPiHNsZwrgWO9Q/q2zxWDoL+r67VM43gjPA0bUTnYqlYg8KS
	7SGRm+GfQYAOuCjExmTG643CorqPFfSrVWhDgdy1bVXJpCQwT4eCOkkQ/wiZ7iquvt4LZjsWFMg
	dYkM9z8hA+XtsGnKQNF2zyHXHBQInG2Scx2zZsusjQ02A2lBQnIKeiiVW5wsk6rr2J0hfns5Weq
	TO4ecXCJrRuV5xHaoG2CfCVP8v0vj8vaB4lA1TTW4j6v93PfH6YfY2eGjPP24jGjhY0MCe6wNYv
	PNuGnOh9mHgOTmIIrVYIN/0Z/58ypg==
X-Received: by 2002:a05:6000:26cc:b0:435:f29d:8c41 with SMTP id
 ffacd0b85a97d-4361805fb9dmr10120762f8f.62.1770289129411; Thu, 05 Feb 2026
 02:58:49 -0800 (PST)
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
Date: Thu, 5 Feb 2026 19:57:00 +0900
X-Gm-Features: AZwV_Qg9cMfh_v5rIvU3S4MIo5NQn_wXpmiZB4togABFg0ybx0v9KuNnfX2vPQM
Message-ID: <CAA3_Gno0c6uGwuxBcsDgZt2a_VriABPek31-1w-R8c9CdJw5Ow@mail.gmail.com>
Subject: [PATCH net 1/2] net: bonding: fix type-confusion in bonding header_ops
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257119-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmo-cybersecurity.com:email,gmo-cybersecurity.com:dkim,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C511FF18ED
X-Rspamd-Action: no action

Add two members to struct bonding, bond_header_ops and
header_slave_dev, to avoid type-confusion while keeping track of the
slave's header_ops.

Fixes: 1284cd3a2b740 (bonding: two small fixes for IPoIB support)
Signed-off-by: Kota Toda <kota.toda@gmo-cybersecurity.com>
Signed-off-by: Yuki Koike <yuki.koike@gmo-cybersecurity.com>
Co-developed-by: Yuki Koike <yuki.koike@gmo-cybersecurity.com>
Reviewed-by: Paolo Abeni <pabeni@redhat.com>
Reported-by: Kota Toda <kota.toda@gmo-cybersecurity.com>
---
 drivers/net/bonding/bond_main.c | 66 ++++++++++++++++++++++++++++++++-
 include/net/bonding.h           |  5 +++
 2 files changed, 70 insertions(+), 1 deletion(-)

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

