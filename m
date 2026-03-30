Return-Path: <netdev+bounces-273273-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PvQHB+rymkx/AUAu9opvQ
	(envelope-from <netdev+bounces-273273-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 18:55:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DC135F1D5
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 18:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 61ACA300B8CF
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 16:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D65C3DBD68;
	Mon, 30 Mar 2026 16:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="j5OiwXCp"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1992D3264FF
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 16:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774889675; cv=none; b=NMLW4BBEE6+UKbBr0WZeXqHkfkZcCx2v+w9xunkDyttSoT/JrQvRU/lo4lgQj8KuiJDeCI+dy5UHxliuxGcN70n7KKtH9+wRxtcAeKmrC5iyB678AGIuSQLr7aAPpbTT+kLrzZPhQo24f93YLB8tq5ukXkUoxRmB1UWWagtp6go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774889675; c=relaxed/simple;
	bh=ezEcdU5y/fz5h6pQ2oWZt+F1dMLRbrd6wR856hyoTLg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AlA2KunInyMr5w9AvfhcTY9QYTmmpVNJmNVP2M230zSJqaDugP/IN1Yf3pqaUwy+qM8+yTNegBK6qPJ39J5Zs0vAjpGObLT9C7qSP6/ZehnIYOlfV/glaE6mudGKSM0mx8d3k+ZDp3DCj9Bzmjs8JiiGDJwl4Ws+LLPLKKg8ebo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=j5OiwXCp; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 00937207B2;
	Mon, 30 Mar 2026 18:54:24 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p-OLV_oJtwaM; Mon, 30 Mar 2026 18:54:19 +0200 (CEST)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 2C3222053D;
	Mon, 30 Mar 2026 18:54:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 2C3222053D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1774889659;
	bh=5MnQFK0tJF+HY2BvA28njrud2IyPR8neYrAr+fh19LI=;
	h=Date:From:To:CC:Subject:Reply-To:References:In-Reply-To:From;
	b=j5OiwXCpDdH5wsIUJPnBbnPVndsNjNtgODrzM1MZo52/EtkOF7TB6W+0kejCtU5WH
	 pZMwK/pQ/5q2/hsRM+ItbMqAreU4tXr+s7eqLM6fuQ4Nip3IDFOswP+NCq4QNuWf7f
	 KFGFZiYBP19wIxrjSRwqaCDYQ/iVJoUZ/pRAvuxiBZELDEihuFNPusEEm6c0jY7S+F
	 gZgVdP+8kx6XYB5aRBTZySYXdJB0g2akjGZSLOKvlOkbbED4lhn0XGoXnSgsBJmgHl
	 j/eX8QexCTRJ4gsywOA6Bf6+jYW4TUmFg7WzyTr7MEjVEmhjEzn+7Md5XZANJf24+1
	 ly6A1wD8j7Rxg==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 18:54:18 +0200
Date: Mon, 30 Mar 2026 18:54:12 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Yan Yan <evitayan@google.com>
CC: Nathan Harold <nharold@google.com>, Tobias Brunner
	<tobias@strongswan.org>, <antony.antony@secunet.com>, Steffen Klassert
	<steffen.klassert@secunet.com>, <paul@nohats.ca>, <netdev@vger.kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<saakashkumar@marvell.com>, <akamluddin@marvell.com>, <greg@kroah.com>
Subject: Re: [REGRESSION] Discussion on "xfrm: Duplicate SPI Handling"
Message-ID: <acqqpAHmKnduKxRp@moon.secunet.de>
Reply-To: <antony.antony@secunet.com>
References: <CADHa2dChQ=4UVY5X5Ad=jryGRCBPQ37Z_Sw60-6h6h_EcUFG9g@mail.gmail.com>
 <aYC0OvkVPkOnVU-i@moon.secunet.de>
 <CADHa2dBN+_9H-_L19Rg3vfvzC1N5FzG+rzW9Pff8pyM3KL9Ocw@mail.gmail.com>
 <fcc761de-f677-4fc9-969b-47c2b56f54be@strongswan.org>
 <CADHa2dBzJBF6po_qDcn97C15U05EZOzuY-opGW1uc3WAYTPx_g@mail.gmail.com>
 <7b4667b9-c4f2-4c56-a0ea-6e9bdc8b5241@strongswan.org>
 <CADhJOfbv8A+2X7xwtoEpLUV1D1vesMjj=nSYc--iOHF6R+VKLw@mail.gmail.com>
 <CADHa2dBA=MpBz3_j2kbLr-wb2nsmnYBhyhWb6pjWekEzurBr9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="x9mIL//YNEqMojR5"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADHa2dBA=MpBz3_j2kbLr-wb2nsmnYBhyhWb6pjWekEzurBr9w@mail.gmail.com>
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-02.secunet.de
 (10.32.0.172)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-diff];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273273-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[secunet.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[antony.antony@secunet.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antony.antony@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 68DC135F1D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--x9mIL//YNEqMojR5
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi,
I looked into this. I feel a simple solution is use x->dir as Nathan
proposed.
When dir is not set we get  pre
commit 94f39804d891 ("xfrm: Duplicate SPI Handling") behaviour.

When XFRM_SA_DIR is set alloc_spi() returns per direction unique spi. 

Another benfit is, this would also keep PF_KEY use case as it was before that comit.
Here is simple RFC patch attached.

How does this look?

strongswan 6.0.0, from Dec 2024, sets x->dir. 
Aakash would this work for for marvell? 

regads,
-antony

On Fri, Mar 27, 2026 at 17:05:13 -0700, Yan Yan wrote:
>    Hi all,
>    I wanted to send a friendly ping to see if we are aligning on making
>    the strict global SPI uniqueness requirement optional, perhaps via a
>    toggle or by leveraging the XFRM_SA_DIR attribute as previously
>    discussed.
>    Are there any other questions or concerns regarding this approach, or
>    anything else we should clarify to ensure backward compatibility while
>    meeting the needs of modern standards?
>    Best,
>    Yan
> 
>    On Tue, Feb 24, 2026 at 3:53 PM Nathan Harold <[1]nharold@google.com>
>    wrote:
> 
>      > That should still be allowed when using the intended APIs (i.e.
>      ALLOCSPI
>      > for the inbound and NEWSA for the outbound SA).  ALLOCSPI might
>      enforce
>      > a unique SPI without considering the address, as that's intended
>      for
>      > local, inbound SAs, where the kernel has full control (looking at
>      the
>      > the patch, it's certainly not ideal, as it goes through all
>      installed
>      > SAs to find a duplicate and it prevents an inbound SPI that
>      matches an
>      > existing outbound SPI - I guess that could be resolved by using
>      separate
>      > tables for in- and outbound SAs).  But that must not prevent
>      installing
>      > outbound SAs with the same SPI to another peer using NEWSA, which
>      still
>      > uses a hash that includes the destination address (that must
>      always be
>      > the case because peers are free to allocate whatever SPI they
>      want).
>      Agreed that there are some unfortunate limitations with the current
>      patch. Keying off the inclusion of XFRM_SA_DIR would resolve the
>      issue
>      you noted (conflating inbound and outbound SPIs) and function as an
>      opt-in for this enforcement. Whatever the mechanism though, the new
>      behavior should be opt-in rather than opt-out in order to maintain
>      backwards compatibility.
>      > In my opinion, you are using the API incorrectly...  I also
>      > don't think there are any benefits in that "consistent larval
>      lifecycle"
>      > (if you found any, please let us know).
>      The Android architecture is multi-tenant and allows userspace apps
>      to
>      establish SAs. At the time we designed it, this felt like the
>      cleanest
>      way to facilitate leak-free resource management because the chain of
>      associations between kernel resources could be symmetrical (and
>      managing them was already quite complicated). Mea culpa (Nathan).
>      But,
>      correctly or not, it has/had worked for many years.
>      > By the way, are you using the min/max option for inbound SAs as
>      well,
>      > with an SPI generated in userland?  That would seem like a
>      violation of
>      > the intention of the API as well (i.e. letting the kernel control
>      the
>      > local SPIs).
>      We provide following two Android APIs for app developers:
>      [2]https://developer.android.com/reference/android/net/IpSecManager#
>      allocateSecurityParameterIndex(java.net.InetAddress)
>      [3]https://developer.android.com/reference/android/net/IpSecManager#
>      allocateSecurityParameterIndex(java.net.InetAddress,%20int)
>      Indeed, allocateSecurityParameterIndex is direction-agnostic; both
>      overloads are implemented internally by including the min and max
>      values in ALLOCSPI. For the variant where app developers provide a
>      specific SPI (which is also useful in testing), Android simply sets
>      both the min and max parameters to that exact value. Our
>      understanding
>      of #xfrm_alloc_spi  is that min/max are required for ALLOCSPI, and
>      otherwise ENOENT will be returned.
>      Note that we also use the DADDR as a mandatory part of the tuple
>      because of the issue mentioned above: SPIs are only unique in
>      conjunction with a DADDR, regardless of direction, and accordingly,
>      that’s how Android is expecting the uniqueness requirement be
>      enforced. In this way, 5 duplicate SPIs can be used on 5 unique IP
>      addresses on the same machine; therefore, a strict "SPI only"
>      interpretation for ALLOCSPI (or SPI handling in general) is curious.
>      We feel that ALLOCSPI should really enforce the same uniqueness
>      requirements as the SAD.
>      Best,
>      Nathan and Yan
>      -Nathan
>      On Wed, Feb 18, 2026 at 12:42 AM Tobias Brunner
>      <[4]tobias@strongswan.org> wrote:
>      >
>      > Hi Yan,
>      >
>      > > For every inbound SA, we allocate SPIs before negotiation. For
>      > > outbound SAs, we allocate SPIs once requested by the peer. We
>      only
>      > > require the (SPI, destination address) combo to be unique. Thus,
>      we
>      > > may have an inbound and outbound SA sharing an SPI with
>      different
>      > > destinations, or multiple outbound SAs to different peers
>      sharing an
>      > > SPI.
>      >
>      > That should still be allowed when using the intended APIs (i.e.
>      ALLOCSPI
>      > for the inbound and NEWSA for the outbound SA).  ALLOCSPI might
>      enforce
>      > a unique SPI without considering the address, as that's intended
>      for
>      > local, inbound SAs, where the kernel has full control (looking at
>      the
>      > the patch, it's certainly not ideal, as it goes through all
>      installed
>      > SAs to find a duplicate and it prevents an inbound SPI that
>      matches an
>      > existing outbound SPI - I guess that could be resolved by using
>      separate
>      > tables for in- and outbound SAs).  But that must not prevent
>      installing
>      > outbound SAs with the same SPI to another peer using NEWSA, which
>      still
>      > uses a hash that includes the destination address (that must
>      always be
>      > the case because peers are free to allocate whatever SPI they
>      want).
>      >
>      > >> If so, why would you use ALLOCSPI and not just install the
>      outbound SA? Is it to avoid differences for in- and outbound SAs
>      (ALLOCSPI+UPDSA vs. NEWSA)?"
>      > >
>      > > Exactly—it is primarily for code symmetry. By using ALLOCSPI +
>      UPDSA
>      > > for both directions, we maintain a consistent larval lifecycle
>      and
>      > > make it easier to maintain.
>      >
>      > In my opinion, you are using the API incorrectly.  ALLOCSPI is
>      intended
>      > to allocate a free local SPI for an inbound SA.  That is, reserve
>      it
>      > before and while the details of the SA are negotiated with the
>      peer
>      > using IKE.  This step isn't necessary for outbound SAs and forcing
>      such
>      > an allocation, after all the details are known, to the responder's
>      SPI
>      > (which I assume you do via min/max option) doesn't feel right.  I
>      also
>      > don't think there are any benefits in that "consistent larval
>      lifecycle"
>      > (if you found any, please let us know).  And the difference
>      between
>      > UPDSA and NEWSA is the nlmsg_type (there are some attributes that
>      are
>      > different for in- and outbound SAs, especially if you set the
>      direction
>      > in newer kernels, but that's the case regardless of the message
>      type).
>      >
>      > By the way, are you using the min/max option for inbound SAs as
>      well,
>      > with an SPI generated in userland?  That would seem like a
>      violation of
>      > the intention of the API as well (i.e. letting the kernel control
>      the
>      > local SPIs).
>      >
>      > As the XFRM API basically mirrors PF_KEYv2 here, you can find more
>      about
>      > the two ways to install SAs in RFC 2367 (SADB_GETSPI/UPDATE vs.
>      SADB_ADD).
>      >
>      > Regards,
>      > Tobias
>      >
> 
>    --
> 
>    --
>    Best,
>    Yan
> 
> References
> 
>    1. mailto:nharold@google.com
>    2. https://developer.android.com/reference/android/net/IpSecManager#allocateSecurityParameterIndex(java.net.InetAddress)
>    3. https://developer.android.com/reference/android/net/IpSecManager#allocateSecurityParameterIndex(java.net.InetAddress, int)
>    4. mailto:tobias@strongswan.org

--x9mIL//YNEqMojR5
Content-Type: text/x-diff; charset="us-ascii"
Content-Disposition: attachment;
	filename="0001-xfrm-allow-same-SPI-value-for-inbound-and-outbound-S.patch"

From b712c3ff7d586c8ed62005e6a37ae01c4a771ce8 Mon Sep 17 00:00:00 2001
From: Antony Antony <antony.antony@secunet.com>
Date: Wed, 25 Mar 2026 06:02:07 +0100
Subject: [PATCH] xfrm: allow same SPI value for inbound and outbound SAs

Commit 94f39804d891 ("xfrm: Duplicate SPI Handling") introduced
xfrm_state_lookup_spi_proto() to fix duplicate SPI allocation for
inbound SAs with different destination addresses.  It enforces global
uniqueness by (spi, proto) across all states regardless of direction.

When x->dir is set, use xfrm_state_lookup_spi_proto() with a strict
per-direction match so that IN and OUT SAs can share a SPI value.

When x->dir is not set, also legacy states created via PF_KEY or without
direction, restore pre-94f39804d891 behavior and check uniqueness by
(daddr, spi, proto) via xfrm_state_lookup(). Extract the mark from
x->mark as required by xfrm_state_lookup().

Move the x->dir assignment in xfrm_alloc_userspi() to before
xfrm_alloc_spi() lookup using dir when it is set.

Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
 net/xfrm/xfrm_state.c | 14 ++++++++++++--
 net/xfrm/xfrm_user.c  |  6 +++---
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 98b362d51836..1cc4a06f9163 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1698,7 +1698,9 @@ struct xfrm_state *xfrm_state_lookup_byspi(struct net *net, __be32 spi,
 }
 EXPORT_SYMBOL(xfrm_state_lookup_byspi);
 
-static struct xfrm_state *xfrm_state_lookup_spi_proto(struct net *net, __be32 spi, u8 proto)
+static struct xfrm_state *xfrm_state_lookup_spi_proto(struct net *net,
+						      __be32 spi, u8 proto,
+						      u8 dir)
 {
 	struct xfrm_state *x;
 	unsigned int i;
@@ -1707,6 +1709,8 @@ static struct xfrm_state *xfrm_state_lookup_spi_proto(struct net *net, __be32 sp
 	for (i = 0; i <= net->xfrm.state_hmask; i++) {
 		hlist_for_each_entry_rcu(x, &net->xfrm.state_byspi[i], byspi) {
 			if (x->id.spi == spi && x->id.proto == proto) {
+				if (x->dir != dir)
+					continue;
 				if (!xfrm_state_hold_rcu(x))
 					continue;
 				rcu_read_unlock();
@@ -2577,6 +2581,7 @@ int xfrm_alloc_spi(struct xfrm_state *x, u32 low, u32 high,
 	struct xfrm_state *x0;
 	int err = -ENOENT;
 	u32 range = high - low + 1;
+	u32 mark = x->mark.v & x->mark.m;
 	__be32 newspi = 0;
 
 	spin_lock_bh(&x->lock);
@@ -2598,7 +2603,12 @@ int xfrm_alloc_spi(struct xfrm_state *x, u32 low, u32 high,
 		newspi = htonl(spi);
 
 		spin_lock_bh(&net->xfrm.xfrm_state_lock);
-		x0 = xfrm_state_lookup_spi_proto(net, newspi, x->id.proto);
+		if (x->dir)
+			x0 = xfrm_state_lookup_spi_proto(net, newspi,
+							 x->id.proto, x->dir);
+		else
+			x0 = xfrm_state_lookup(net, mark, &x->id.daddr, newspi,
+					       x->id.proto, x->props.family);
 		if (!x0) {
 			x->id.spi = newspi;
 			h = xfrm_spi_hash(net, &x->id.daddr, newspi, x->id.proto, x->props.family);
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 403b5ecac2c5..98b90c747aad 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -1873,13 +1873,13 @@ static int xfrm_alloc_userspi(struct sk_buff *skb, struct nlmsghdr *nlh,
 		goto out_noput;
 	}
 
+	if (attrs[XFRMA_SA_DIR])
+		x->dir = nla_get_u8(attrs[XFRMA_SA_DIR]);
+
 	err = xfrm_alloc_spi(x, p->min, p->max, extack);
 	if (err)
 		goto out;
 
-	if (attrs[XFRMA_SA_DIR])
-		x->dir = nla_get_u8(attrs[XFRMA_SA_DIR]);
-
 	resp_skb = xfrm_state_netlink(skb, x, nlh->nlmsg_seq);
 	if (IS_ERR(resp_skb)) {
 		err = PTR_ERR(resp_skb);
-- 
2.39.5


--x9mIL//YNEqMojR5--

