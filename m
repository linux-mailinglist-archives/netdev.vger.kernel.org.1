Return-Path: <netdev+bounces-129680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C55DE9857AE
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 13:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 011CD1C212AC
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 11:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCCA155306;
	Wed, 25 Sep 2024 11:10:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9FE13212A
	for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 11:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727262610; cv=none; b=F1Rs7Ev+hPu6yDcceOj6J46z/AW7xUlRPnNWwdSQAi+4KCEGdM24VuphTnhPlW4WdlCXIaMQ8CUCkF0SV01fJPb8C4z7fjuIR2Ky6Gsp+BW4F6Cb3LfjEjjkdueSwzz4HbOvDcvaxGFLdAtTeVBLoTePRa8eQtqW0GynpzbcDQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727262610; c=relaxed/simple;
	bh=fJk2zjrxTxlUEqwavBdpWd+Dykc8cDQFojaLS+hA+ZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2s8mPVfy9rB680MMf6dvurXiCWDBP5iAZ8yzOWwJ5mnQHO+nz8YXWb9L/LHWMhpnXWLNRyPiEJqmrsRnU36ChLhtMGnh1EaHgwUkFwhKpdWrAITkuQS/H5jgRdcfmC6O3tStRXonmJSMDcow2gdtwvdYqidu+VG70YWb4Vrs3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-359-ytwXiWDXNqSUweQjYaaLlw-1; Wed,
 25 Sep 2024 07:08:56 -0400
X-MC-Unique: ytwXiWDXNqSUweQjYaaLlw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1B83819772D7;
	Wed, 25 Sep 2024 11:08:55 +0000 (UTC)
Received: from hog (unknown [10.39.192.29])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 486C030001A4;
	Wed, 25 Sep 2024 11:08:50 +0000 (UTC)
Date: Wed, 25 Sep 2024 13:08:48 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: steffen.klassert@secunet.com, pabeni@redhat.com,
	syzbot <syzbot+cc39f136925517aed571@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, edumazet@google.com, herbert@gondor.apana.org.au,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] UBSAN: shift-out-of-bounds in
 xfrm_selector_match (2)
Message-ID: <ZvPvQMDvWRygp4IC@hog>
References: <00000000000088906d0622445beb@google.com>
 <66f33458.050a0220.457fc.001e.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <66f33458.050a0220.457fc.001e.GAE@google.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

2024-09-24, 14:51:20 -0700, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    151ac45348af net: sparx5: Fix invalid timestamps
> git tree:       net-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=15808a80580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=37c006d80708398d
> dashboard link: https://syzkaller.appspot.com/bug?extid=cc39f136925517aed571
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=122ad2a9980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1387b107980000

syzbot managed to create an SA with:

usersa.sel.family = 0
usersa.sel.prefixlen_s = 128
usersa.family = AF_INET

Because of the AF_UNSPEC selector, verify_newsa_info doesn't put
limits on prefixlen_{s,d}. But then copy_from_user_state sets
x->sel.family to usersa.family (AF_INET).

So I think verify_newsa_info should do the same conversion before
checking prefixlen:


diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 55f039ec3d59..8d06a37adbd9 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -201,6 +201,7 @@ static int verify_newsa_info(struct xfrm_usersa_info *p,
 {
 	int err;
 	u8 sa_dir = attrs[XFRMA_SA_DIR] ? nla_get_u8(attrs[XFRMA_SA_DIR]) : 0;
+	u16 family = p->sel.family;
 
 	err = -EINVAL;
 	switch (p->family) {
@@ -221,7 +222,10 @@ static int verify_newsa_info(struct xfrm_usersa_info *p,
 		goto out;
 	}
 
-	switch (p->sel.family) {
+	if (!family && !(p->flags & XFRM_STATE_AF_UNSPEC))
+		family = p->family;
+
+	switch (family) {
 	case AF_UNSPEC:
 		break;
 


Steffen, does that make sense?


Without this, we have prefixlen=128 when we get to addr4_match, which
does a shift of (32 - prefixlen), so we get

UBSAN: shift-out-of-bounds in ./include/net/xfrm.h:900:23
shift exponent -96 is negative


Maybe a check for prefixlen < 128 would also be useful in the
XFRM_STATE_AF_UNSPEC case, to avoid the same problems with syzbot
passing prefixlen=200 for an ipv6 SA. I don't know how
XFRM_STATE_AF_UNSPEC is used, so I'm not sure what restrictions we can
put. If we end up with prefixlen = 100 used from ipv4 we'll still have
the same issues.



>  __ip4_datagram_connect+0x96c/0x1260 net/ipv4/datagram.c:49
>  __ip6_datagram_connect+0x194/0x1230
>  ip6_datagram_connect net/ipv6/datagram.c:279 [inline]
>  ip6_datagram_connect_v6_only+0x63/0xa0 net/ipv6/datagram.c:291

This path also looks a bit dubious. From the reproducer, we have a
rawv6 socket trying to connect to a v4mapped address, despite having
ip6_datagram_connect_v6_only as its ->connect.

pingv6 sockets also use ip6_datagram_connect_v6_only and set
sk->sk_ipv6only=1 (in net/ipv4/ping.c ping_init_sock), but rawv6 don't
have this, so __ip6_datagram_connect can end up in
__ip4_datagram_connect. I guess it would make sense to set it in rawv6
too. rawv6_bind already rejected v4mapped addresses.

And then we could add a DEBUG_NET_WARN_ON_ONCE(!ipv6_only_sock(sk)) in
ip6_datagram_connect_v6_only, or maybe even call ipv6_addr_type to
reject v4mapped addresses and reject them like the non-AF_INET6 case.

-- 
Sabrina


