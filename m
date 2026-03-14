Return-Path: <netdev+bounces-267718-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IEACD5DtWkQygAAu9opvQ
	(envelope-from <netdev+bounces-267718-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 12:15:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0A928CD61
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 12:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B24D3027DB2
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 11:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0290422689C;
	Sat, 14 Mar 2026 11:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AbHRYMaB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD92231827
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 11:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773486906; cv=pass; b=pZOwxl751rAgIhibCN9ty1Q4dlWxjCkrhAvC+GuSUJmwXj5jUYEMOfydt0dOp0sUTisfSxQEf/H5HAdWMfSj5eiSuQZxXdkn48ZrrnegQjOHTaVuqBHZQIRhfiltdHacj1tZMdgE/Cq2XpeW/Zgyh31jNCIFe5kMWUPeo/bX9YM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773486906; c=relaxed/simple;
	bh=U6CmkChaDwpK61rE4mlttg0yNSxEmeXKQtVYqRmBTPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KpxC31RmopSfJvaqYcTBGq8Bw2PcrDKV8Qqy12vqEMud9xkoMGdWEZnON/CG/adOL/C6HqgbAdGf9x5s65ed9fxXHqwof/pCKui1LYqcL9jvPOdPYHJLQ2w/Jot10NzozvPZkZF/2JP/fCo9cEV/GhaLtmQkW/q8JYtSWXrq9ho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AbHRYMaB; arc=pass smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-899efe93d4eso38660196d6.2
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 04:15:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773486904; cv=none;
        d=google.com; s=arc-20240605;
        b=jfmBalE2f+Y3yt2sgF+sCo/Ae1tm2YdP/CbG21TxcBxrnk/XghFCxtbD26eC+QuAWR
         b/aPNtkaxNFf7ySBfEJYbt56UEwkbNlIfxdHEZfcQrL3Q6bMQ1YHQu/sta6VOOX4EpYO
         l6L4i3lXd+d9S5eSLgLuIcE3p4PbgqzCvXqHKCkLUH76PXKmKS0Bt5Lx+e7xoHLyidbW
         6voJZLUaYdcn89TTVkVleBlM4Qpo5vcJWh5OopZ4hwOI+37ddA+aJhgF9M6Lf4WQ0ZG0
         RR9cFqg8Iu4S0cr6IOyuIb5BnV1ML0RtBTtaKcmtv64VMQGWp6OZQc0R+WKNhctH6kvs
         EYOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CUlpKYJ0evY3P6kBrTLMBroQFAjZkRoOxIUOEtfrB0Y=;
        fh=29bbWsD+MbT6OFxfz0zZZCvVLyomyAxdKQ3BPqMrVgw=;
        b=Pth6Kv1gi0SwjLA0S326EtkLIsoyDiAUjKi8GAeFS+oD/Y0HUB13f7PRfJguGs0M+h
         WfM4QAtZi81El3ly1RX4Qfk5GGOY4Zmu0YZ3R36KmUDegQUft5pAqPt+f23CUNGpKSrz
         58t8kaf0NVTbpzJ3a1b3jl6zAPjWLkyRrvabaHWXPWz/CA0XCOYjurMvQAqkw+zyFQqt
         0i/anitjTgQj5xnhhTrcDTUxR60G57spZ9WmRc5r9Jr5sFxOmTb8vXl/Ji7r5hubAkPX
         5UJBJRbFopCuwPlL8iGt+mhqSTPJiRjsx9qwqiAqjOG0/uRB+BkjXlbydJHL/SVpoFEb
         Hr0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773486904; x=1774091704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CUlpKYJ0evY3P6kBrTLMBroQFAjZkRoOxIUOEtfrB0Y=;
        b=AbHRYMaBKY5VlF7jVW6Wy/YkgS5QcPBN3Cd2cmP7Nv8NqTLIrOtk6HsyCCYZHMM3W/
         G5pvTEDRnArNAcLr/gCfT/iwQkeCKOBDijzAfNIo6UAcuqCTs04PBB5XXJ/mj0P3wklq
         Al1CGLW2XsYh5dZTxC15qXJjk7lj+cEj/IF4urUsB2CHqbab1ykzW1s132jdbmgWxdPY
         5ogYZmZIiqdMrThmOKAA0vBk05g4BW5VJRBrD1K7uPJel7LUASYlkirJC0bju3+qUgu3
         VIyapDBB62thKP9QV0L46wzQOR1ebzghQ++M8Qk5tmElfH1GV+x9LiKi/PuOlTZs8Jz0
         ihHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773486904; x=1774091704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CUlpKYJ0evY3P6kBrTLMBroQFAjZkRoOxIUOEtfrB0Y=;
        b=nrBXdfw24+mP3hcBk2JiQD6UDZXJ5C22+f+39mNfsTRM3X+kaDBRaBK5QQMJ/jmdqk
         idSGasmQnS5hmB7ld6S97MXZw2x4rfjmDSvsF62vxzYiH6YXl/iNp7pPhqfim6V6l2R5
         7gpa64h8lHYwiwA1z7yku29L+McqJ+R0nUOLb5xoG1h91TnQj4PI1Mr9xq7c7HQMTdgp
         bqNqmfWnE1tbuywGq8H440N5m3QHVk9ppbSkuwrQbtC9uinL7mMVRgkpgnIaZs1BUKqu
         0BLiTUSdpI2iFx4bx0JhS3ReDWLWWJsGrLdWdhKGxOsudPv1/hwx2Kd6Z6ZQLkM/fcpV
         NLCw==
X-Gm-Message-State: AOJu0YynMhXNpRC72lW3ZzyULQcHm+2krBrbzRALl3VAOGs/XHEZBVyo
	nO3us29ALd0Uz0swHb27ZxlSsBhh/H1JzKhA0PUZ4N8Bdo1gzcbzi6twaE73QA3Z2r6E6dmbXcQ
	9f3Ev4S/OArYP58ABiO9QcNSEa9JTy3QDcax8G5Js
X-Gm-Gg: ATEYQzwH7jWlgsZ1qAuUtgOnzJ0+kkvivTgeIC/pr1rnID76WqdYsxR3R/nAWdMyb3l
	Cqt2a1RehPzReaWCFyidT1G9YmuhomMfOo5pdSqFAa4vIPu3rlcxeehkzIuPl+gr4uUg5qXB8Ps
	9QUjily/+QgLzaCZM51VfQbACQKw28mJhuqN2xuHBKo7OYEZzzEZHDB9coxSHHOt4c41r5duwEV
	xUBKCeD84BTgkO8Wga8neDdY89G0viR7bjPfkfAafdWrAUweEzaxuUl56lue/pWvSlzovRbCy1o
	DLgKqh8=
X-Received: by 2002:a05:622a:612:b0:509:2d05:6979 with SMTP id
 d75a77b69052e-50957d161ffmr85753981cf.26.1773486903513; Sat, 14 Mar 2026
 04:15:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260314062306.212765-1-jiayuan.chen@linux.dev> <CANn89iJR9bjtoZGsybdpX6T4rg1+kzXL0qV00Bs_Fiduf_+2zw@mail.gmail.com>
In-Reply-To: <CANn89iJR9bjtoZGsybdpX6T4rg1+kzXL0qV00Bs_Fiduf_+2zw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 14 Mar 2026 12:14:52 +0100
X-Gm-Features: AaiRm50gWOcSTD1OjEkYBuPGUisYeu4Xc_tzd8_jLAO6ue8C6D_V7oyFQRUQy1o
Message-ID: <CANn89iJwZfWtGrQw+hA9DumTuYKZm5MLh8O7nkz9mPCHHazUWw@mail.gmail.com>
Subject: Re: [PATCH net v1] team: fix header_ops type confusion with
 non-Ethernet ports
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Jiayuan Chen <jiayuan.chen@shopee.com>, 
	syzbot+3d8bc31c45e11450f24c@syzkaller.appspotmail.com, 
	Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267718-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,3d8bc31c45e11450f24c];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,shopee.com:email]
X-Rspamd-Queue-Id: 8D0A928CD61
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 14, 2026 at 11:19=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Sat, Mar 14, 2026 at 7:23=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.=
dev> wrote:
> >
> > From: Jiayuan Chen <jiayuan.chen@shopee.com>
> >
> > Similar to commit 950803f72547 ("bonding: fix type confusion in bond_se=
tup_by_slave()"),
> > team has the same class of header_ops type confusion.
> >
> > For non-Ethernet ports, team_setup_by_port() copies port_dev->header_op=
s
> > directly. When the team device later calls dev_hard_header()/dev_parse_=
header(),
> > these callbacks can run with the team net_device instead of the real lo=
wer
> > device, so netdev_priv(dev) is interpreted as the wrong private type an=
d
> > can crash.
> >
> > Fix this by introducing team header_ops wrappers for create/parse, sele=
cting
> > a team port under RCU, and calling the lower device callbacks with port=
->dev,
> > so each callback always sees the correct net_device context.
> >
> > Reproducer:
> > set -euxo pipefail
> > for d in t0 b0 g0 d0; do
> > ip link del "$d" 2>/dev/null || true
> > done
> >
> > modprobe bonding || true
> > modprobe team || true
> > modprobe ip_gre || true
> > modprobe dummy || true
> > ip link add d0 type dummy
> > ip addr add 10.10.10.1/24 dev d0
> > ip link set d0 up
> > ip link add g0 type gre local 10.10.10.1
> > ip link add b0 type bond mode active-backup
> > ip link add t0 type team
> > ip link set g0 master b0
> > ip link set b0 master t0
> > ip link set g0 up
> > ip link set b0 up
> > ip link set t0 up
>
> I have a bad feeling about the bonding patch.
>
> Let's not copy paste it to team before clearing these feelings.
>
> Can you add tests with a stack of two bonding devices ?
>
> Because I think bond_header_parse() would enter an infinite recursion loo=
p,
> because skb->dev always points to the head of the tree ?
> Unless I am missing something obvious.
> Sorry this is weekend time.
>

I think the following (WIP, untested) patch is needed.

I will complete it and send it ASAP.

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_mai=
n.c
index 707419270ebf217a71b0593880c7a9a1481b7171..33f414d03ab913c58cf2406a4ab=
25e611c528159
100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1530,9 +1530,11 @@ static int bond_header_create(struct sk_buff
*skb, struct net_device *bond_dev,
        return ret;
 }

-static int bond_header_parse(const struct sk_buff *skb, unsigned char *had=
dr)
+static int bond_header_parse(const struct sk_buff *skb,
+                            const struct net_device *dev,
+                            unsigned char *haddr)
 {
-       struct bonding *bond =3D netdev_priv(skb->dev);
+       struct bonding *bond =3D netdev_priv(dev);
        const struct header_ops *slave_ops;
        struct slave *slave;
        int ret =3D 0;
@@ -1542,7 +1544,7 @@ static int bond_header_parse(const struct
sk_buff *skb, unsigned char *haddr)
        if (slave) {
                slave_ops =3D READ_ONCE(slave->dev->header_ops);
                if (slave_ops && slave_ops->parse)
-                       ret =3D slave_ops->parse(skb, haddr);
+                       ret =3D slave_ops->parse(skb, slave->dev, haddr);
        }
        rcu_read_unlock();
        return ret;
diff --git a/include/linux/etherdevice.h b/include/linux/etherdevice.h
index 9a1eacf35d37087ba8877bf31c017445929041ed..df8f88f63a7063fbd1df5248d2f=
c02c859a7bc74
100644
--- a/include/linux/etherdevice.h
+++ b/include/linux/etherdevice.h
@@ -42,7 +42,8 @@ extern const struct header_ops eth_header_ops;

 int eth_header(struct sk_buff *skb, struct net_device *dev, unsigned
short type,
               const void *daddr, const void *saddr, unsigned len);
-int eth_header_parse(const struct sk_buff *skb, unsigned char *haddr);
+int eth_header_parse(const struct sk_buff *skb, const struct net_device *d=
ev,
+                    unsigned char *haddr);
 int eth_header_cache(const struct neighbour *neigh, struct hh_cache *hh,
                     __be16 type);
 void eth_header_cache_update(struct hh_cache *hh, const struct net_device =
*dev,
diff --git a/include/linux/if_ether.h b/include/linux/if_ether.h
index 61b7335aa037c7232a0caa45572043057c02dde3..ca9afa824aa4faf832658043bda=
6fb430633e476
100644
--- a/include/linux/if_ether.h
+++ b/include/linux/if_ether.h
@@ -40,7 +40,8 @@ static inline struct ethhdr *inner_eth_hdr(const
struct sk_buff *skb)
        return (struct ethhdr *)skb_inner_mac_header(skb);
 }

-int eth_header_parse(const struct sk_buff *skb, unsigned char *haddr);
+int eth_header_parse(const struct sk_buff *skb, const struct net_device *d=
ev,
+                    unsigned char *haddr);

 extern ssize_t sysfs_format_mac(char *buf, const unsigned char *addr, int =
len);

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d7aac6f185bcab8a93a204c349272fc7c1b15ee7..7ca01eb3f7d2b22a188502583dc=
95121adff7cc9
100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -311,7 +311,9 @@ struct header_ops {
        int     (*create) (struct sk_buff *skb, struct net_device *dev,
                           unsigned short type, const void *daddr,
                           const void *saddr, unsigned int len);
-       int     (*parse)(const struct sk_buff *skb, unsigned char *haddr);
+       int     (*parse)(const struct sk_buff *skb,
+                        const struct net_device *dev,
+                        unsigned char *haddr);
        int     (*cache)(const struct neighbour *neigh, struct
hh_cache *hh, __be16 type);
        void    (*cache_update)(struct hh_cache *hh,
                                const struct net_device *dev,
@@ -3445,7 +3447,7 @@ static inline int dev_parse_header(const struct
sk_buff *skb,

        if (!dev->header_ops || !dev->header_ops->parse)
                return 0;
-       return dev->header_ops->parse(skb, haddr);
+       return dev->header_ops->parse(skb, dev, haddr);
 }

 static inline __be16 dev_parse_header_protocol(const struct sk_buff *skb)
diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index 13a63b48b7eeb896dfe98eb0070a261eed2c384b..9d159d1cc57d42747f794cdf43f=
e0ccaf04818b2
100644
--- a/net/ethernet/eth.c
+++ b/net/ethernet/eth.c
@@ -198,7 +198,8 @@ EXPORT_SYMBOL(eth_type_trans);
  * @skb: packet to extract header from
  * @haddr: destination buffer
  */
-int eth_header_parse(const struct sk_buff *skb, unsigned char *haddr)
+int eth_header_parse(const struct sk_buff *skb, const struct net_device *d=
ev,
+                    unsigned char *haddr)
 {
        const struct ethhdr *eth =3D eth_hdr(skb);
        memcpy(haddr, eth->h_source, ETH_ALEN);
diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index e13244729ad8d5b1c2b9c483d25bff0e438134b5..35f0baa99d4092fd499a4795f7f=
52db33a1fe4e2
100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -919,7 +919,8 @@ static int ipgre_header(struct sk_buff *skb,
struct net_device *dev,
        return -(t->hlen + sizeof(*iph));
 }

-static int ipgre_header_parse(const struct sk_buff *skb, unsigned char *ha=
ddr)
+static int ipgre_header_parse(const struct sk_buff *skb, const struct
net_device *dev,
+                             unsigned char *haddr)
 {
        const struct iphdr *iph =3D (const struct iphdr *) skb_mac_header(s=
kb);
        memcpy(haddr, &iph->saddr, 4);

