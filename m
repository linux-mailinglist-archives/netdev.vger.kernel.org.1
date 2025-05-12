Return-Path: <netdev+bounces-189626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBAA0AB2D7B
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 04:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 619DF17225D
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 02:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4DA25334E;
	Mon, 12 May 2025 02:26:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573EB70825
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 02:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747016808; cv=none; b=gDlTuesBMmj2TBBMAiAFkaNPFhGOhqtWaxU8/y6e2vr+tFNYzv1Zee/9gxw2ZxMVZjDLRw0KnlfET4OiQQkqgCVjmuZvVD+rkr35ilw6J5YDy9uWqWvXh6HLdcetMW3ZmF6MWVdio3bR2TFDQZlXBtNsvoYPhvs9IN5KOr4rS6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747016808; c=relaxed/simple;
	bh=de7TBUm8LJing725D2jejYw1ay62rJmOAUJcva2Ru44=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=pH3XnAD5yhvFGchHj7Ou0sNDgl/NcpW0W5zPmPadsZC1J7uEv3hDjcLKok7lxYizk3wVIbznW+2et2r7kD38wjbup75/9nyhop9UIjGBS00TDntmFmrFvP3Qrtek6e/3p3usUlv0zpL7SvZxmXG1WA6no/vpKRTNg8otTuFKu/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=none smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpgz1t1747016719t1271c9ad
X-QQ-Originating-IP: Q155Ok2CSHLKDr4pELiL86iKK6+IWkQZJlKNOvG85xc=
Received: from smtpclient.apple ( [111.202.70.100])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 12 May 2025 10:25:17 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3493817473279601546
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [PATCH net-next 1/4] net: bonding: add broadcast_neighbor option
 for 802.3ad
From: Tonghao Zhang <tonghao@bamaicloud.com>
In-Reply-To: <ea87b2d2-9b17-4f16-9e40-fe7212f2788d@lunn.ch>
Date: Mon, 12 May 2025 10:25:16 +0800
Cc: Jay Vosburgh <jv@jvosburgh.net>,
 netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B43CC0DC-286B-44FF-8FA8-1B1BC0C990BF@bamaicloud.com>
References: <20250510044504.52618-1-tonghao@bamaicloud.com>
 <20250510044504.52618-2-tonghao@bamaicloud.com> <1133230.1746881077@vermin>
 <CE4DB782-91EB-4DBD-9C26-CA4C4612D58C@bamaicloud.com>
 <ea87b2d2-9b17-4f16-9e40-fe7212f2788d@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MVbvI5amSZ2YmY6YRLetviQaThRmXIzMV2MhFugSEF6AK/Pd6HszblPY
	QEDiOIOYKy4VyYyZUBMhUqeEAN4cDTsC5teF7kJlpifMD53dG8wZyZtBByaDXtEv2M35tXC
	3CO2aanl/cR38E7qQq1B0tQYCd8DDSZRAPJvFl2siNLjHv/266zd5n4bT+QMMYjlGC6760e
	jr5rFPb3ZGExhDO1kSzfKo+ii7JQ7czc1TG1hNZnXwigOzZ0rfGjb9hz+04pb32XhsNeVw1
	CoCGfKG3FfDGlA7AJf0noInKC4V6lrWqw5TMtT0fWuLTd6JII/7yfOoooVVCPKCKtTCCoph
	dNmsXsnYd18pKUFY5Trsi02xBLp2npe+Egxus2IRtpGiLlEiySkwbqjnBKQ4t1BASJtd+xM
	BiLra7uyczPS2MGOXzeYzNKLWkovUxvXbrsom2PA16FJZJ23xt64Pi3yITYDUoEYaDrqZas
	eOjS7F7e39fT+0ReTjFFwuK3vanJY9qM7a4hrSmA5MXyHqbsvDLpHTZW72akUlQ31UPpUDT
	bVelElov318GpePJ/XbqlHVn9yl6nGZvqLyQTdN6t+RQL3WauClauyrrUhBBFSxFk6kBzgO
	7fSF+++Z5OiTKXsawvDGOmnPPlqQCxWEWpxKURv45e4OVhZx7VWe5sDxWou/mOoJ0B59cdP
	N5DN6MruUmOcZIWArAh7ZVpTq8ASo+UGDuoaMcHEDZW0jrQ6y69rigm9Ei+Q4uSLkcNEKQg
	3MdBa/J2COJ9o+hjjC+1ejjmZakFG9tSFXrPi8uPUKM7K7MdnVaH5diJcrh80R3GV0ZeCF8
	TztdluMC9C9l6qAPWJKnz1L+TMNYTthjlyp71OhD7sMFYlqy4o7zmqcbDjEbxnHR9RhlZrk
	DTqm95lAvZb0rKy09x5CM+l6Fn3rxqRYfIBgrb+q6twGD7jBRjoQDBDFJ0lHBHyT+UqJeUQ
	r5lA=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0



> 2025=E5=B9=B45=E6=9C=8811=E6=97=A5 =E4=B8=8B=E5=8D=8811:53=EF=BC=8CAndre=
w Lunn <andrew@lunn.ch> =E5=86=99=E9=81=93=EF=BC=9A
>=20
>> static inline bool bond_should_broadcast_neighbor(struct bonding =
*bond,
>>                                                  struct sk_buff *skb)
>> {
>>        if (!bond->params.broadcast_neighbor ||
>>            BOND_MODE(bond) !=3D BOND_MODE_8023AD)
>>                return false;
>=20
> I think you missed the point. You have added these two tests to every
> packet on the fast path. And it is very likely to return false. Is
> bond.params.broadcast_neighbor likely to be in the cache? A cache miss
> is expensive. Is bond.params.mode also likely to be in cache? You
> placed broadcast_neighbor at the end of params, so it is unlikely to
> be in the same cache line as bond.params.mode. So two cache misses.
>=20
> What Jay would like is that the cost on the fast path is ~0 for when
> this feature is not in use. Jump labels can achieve this. It inserts
> either a NOP or a jump instruction, which costs nearly nothing, and
> then uses self modifying code to swap between a NOP or a jump. You can
> keep a global view of is any bond is using this new mode? If no, this
No, no mode uses jump labels instead of bond.params checking.
> test is eliminated. If yes, you do the test.
I test the lacp mode with broadcast_neighbor enabled, there is no =
performance drop. This patch has been running in our production =
environment for a long time. We only use this option in lacp mode, for =
performance, the code can be modified as follows:
diff --git a/drivers/net/bonding/bond_main.c =
b/drivers/net/bonding/bond_main.c
index ce31445e85b6..8743bf007b7e 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -5330,11 +5330,12 @@ static struct slave =
*bond_xdp_xmit_3ad_xor_slave_get(struct bonding *bond,
        return slaves->arr[hash % count];
 }

-static inline bool bond_should_broadcast_neighbor(struct bonding *bond,
-                                                 struct sk_buff *skb)
+static inline bool bond_should_broadcast_neighbor(struct sk_buff *skb,
+                                                 struct net_device =
*dev)
 {
-       if (!bond->params.broadcast_neighbor ||
-           BOND_MODE(bond) !=3D BOND_MODE_8023AD)
+       struct bonding *bond =3D netdev_priv(dev);
+
+       if (!bond->params.broadcast_neighbor)
                return false;

        if (skb->protocol =3D=3D htons(ETH_P_ARP))
@@ -5408,9 +5409,6 @@ static netdev_tx_t bond_3ad_xor_xmit(struct =
sk_buff *skb,
        struct bond_up_slave *slaves;
        struct slave *slave;

-       if (bond_should_broadcast_neighbor(bond, skb))
-               return bond_xmit_broadcast(skb, dev);
-
        slaves =3D rcu_dereference(bond->usable_slaves);
        slave =3D bond_xmit_3ad_xor_slave_get(bond, skb, slaves);
        if (likely(slave))
@@ -5625,6 +5623,9 @@ static netdev_tx_t __bond_start_xmit(struct =
sk_buff *skb, struct net_device *dev
        case BOND_MODE_ACTIVEBACKUP:
                return bond_xmit_activebackup(skb, dev);
        case BOND_MODE_8023AD:
+               if (bond_should_broadcast_neighbor(skb, dev))
+                       return bond_xmit_broadcast(skb, dev);
+               fallthrough;
        case BOND_MODE_XOR:
                return bond_3ad_xor_xmit(skb, dev);
        case BOND_MODE_BROADCAST:
>=20
> 	Andrew
>=20
>=20


