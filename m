Return-Path: <netdev+bounces-287122-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPHKACkjA2oF1AEAu9opvQ
	(envelope-from <netdev+bounces-287122-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 14:55:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C645207D3
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 14:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0149D30C1BDC
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D5D3911A7;
	Tue, 12 May 2026 12:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Wxto0oRV"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64AE3911D9;
	Tue, 12 May 2026 12:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778589891; cv=none; b=h2j0JlTqWC4qlY1Mla8vp2nkak5OVTpNfbRrfgtAFMHNFgFNiX9usBFgDLmX6cr3rWE2mUss3uhXuoA5l0aIqr6fswzRLs+fWTuP+uJlMZ+czCpENaBFuPZt3ZNUckuE3zXnuw05GFYDwBuZD29wp6hvVYNm/HDf4aiI9do3BsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778589891; c=relaxed/simple;
	bh=Q0obD3xzN18rb3XSvaXpjpOgoMjOJVx1jBabrGM3jQw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gWPvVLfj67Gyy56fo3raYkgfnpz8juzhLE6j0svIiEeP6e/6hZq/I2i6f2ml21x7waovssh4HGaUKVbDFQ0m5lGqeZ/lOAQEG5+TIdJXb7siTTJZiOdSE708a/AzpBDmANwC4os6r0df9eYVQHWwD7BvBxRGqqK9Bxtes7zJ1Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Wxto0oRV; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1778589870;
	bh=1UThKq31Wk9hNnaI3jbgCJkR9UC1fzXczgv8uwTYgnA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Wxto0oRVOlhPnjZ0+B2S1LexLO+MOilJe02L/A36FV9sz/eO/UT9a3N/TAOTQoDWx
	 ThNBqJMBh53MTtp8JISh4b+WTzAzc7AdEXHjBEg2uFPCPr1advglt0tWlYWg3syPte
	 LOY03ZLy7dwYPU8b4jKe7AhPWwCf6g8xg4kSQxyo=
X-QQ-mid: zesmtpip3t1778589855t9dd58392
X-QQ-Originating-IP: Ag63rSN4qCk1EFrhJNSHdwBags9UmwA96BsdR6ZI5DY=
Received: from PEN202512010004 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 12 May 2026 20:44:13 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3155177221628480154
EX-QQ-RecipientCnt: 13
From: Xu Rao <raoxu@uniontech.com>
To: davem@davemloft.net
Cc: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kuniyu@google.com,
	willemb@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dsahern@kernel.org,
	idosch@nvidia.com,
	Xu Rao <raoxu@uniontech.com>,
	syzbot+e2af46126e0644cbebdd@syzkaller.appspotmail.com
Subject: [PATCH net v2] ipv6: addrconf: skip autoconf on unregistering devices
Date: Tue, 12 May 2026 20:44:10 +0800
Message-ID: <1BEC9A31C1E03F38+20260512124410.719476-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: M5AoSkhGr8pkymhH0hMlH35t/aljJ7xydmP1mTCVY5dDmqbOofZ9y1YP
	YUAuUead4wN8HKcyQWlJZlnrZKZzKnLlHPF6ePt9UrZMwnD8/MU9lrm3xAWEcFEMJB41nrY
	HD9/DGvQjuzJhy+/JiZqqMw9xJn5MIaKkUBh7og+niQndDPzWqRPKbNtZgQUk+DvI3iya/5
	qRdyUfKJweBPL2zCMJHH6L7o15wg4sSl1P2Ywvi3lqGv/J8dJ6X5ZjbCQ6BsW24MZaXh/Nk
	ZFg4rCnPZP9AB0Tlh5baOJ20doyS1eZPEVffY1AMokPo8tHBl/pLd0dQ3cmJb6FJbAX+XNt
	o9NSQMMG9z7LNHgqyOKPNE0gCoww6Zpz8f8ROg1BjhgEpvOyb2isbVP4CS1uGeAMc73ykKE
	sJDUeZvqEyxIu7WH8s2FRaqdILa+DcWUfXlD6vQMNG6Rf2y8PFpyUNZ5s8q8SYCfQOttF4O
	p2sfRz0Pq+Rkposg0FYRp0NwqOCKkTe7dRw8GA1Tnqv84VUFDRQWPY9QHTwK/0pfk9vRLKt
	CkRQHb4wp+ftTco6pY6sWaxOJdg8S/MalFYdHp/PTtR3/rBX/9X+/0iZE1G7pnyxqGWaqel
	GGfb4lpDJcuQN7pT6CeALspv0W+QGB5iKISMug2KXuGC7eHj2Q8qgQHKqaTNqEv9yqPTo95
	zhhkTCuoQzIE0xcsz8qKkwSzvKGX2X3Gwiz4lu42Q+bDGCAuyA/BTmn8D6ldIDnmPLOuEfZ
	ZSxM2EJ0RJHfxpmrEn1Vn581Jlzla1Szttq5Y8dfPbOq5xac3s22Od9drg4NHiC8zHxn0OK
	LPKhX3h4+O7BsV0ehTpmYBzzMZbDMGKjVB2WytLoTaMqLu9Y74wCy7HVcGn88FMxrXBhW+a
	TAc1+V7ld/k/hQtcFRmEkMax1D0ZQHsONjRYwkqPykB8qr2FwXhF/kgovLkNsYL7eVs8/vR
	XQ6UTesdnUO4B8cSs8T/OP1OJ6KrfYUeTie6rDSMf+Z8s2Uk6orrhrTVYJS2NMrQhovI4Rx
	j+8rISYQ==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: 14C645207D3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-287122-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raoxu@uniontech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[uniontech.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev,e2af46126e0644cbebdd];
	NEURAL_HAM(-0.00)[-0.993];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[uniontech.com:email,uniontech.com:mid,uniontech.com:dkim]
X-Rspamd-Action: no action

syzbot reports that unregister_netdevice() can wait forever for a
netdevsim device whose reference count never drops to zero.

The leaked reference is held by an IPv6 local route created from
addrconf.  A late NETDEV_CHANGE notification can still reach
addrconf_notify() after the device has entered NETREG_UNREGISTERING.
The handler can then run automatic address configuration, add a
link-local address and install its host route after unregister teardown
has already started.  The route nexthop takes a netdev reference in
fib6_nh_init(), and there might not be a later ifdown pass to remove
the newly created address and route.

Do not run MTU, UP or CHANGE based IPv6 autoconfiguration once the
device is unregistering.  Keep NETDEV_DOWN and NETDEV_UNREGISTER
handling unchanged so the teardown path can still remove existing IPv6
state.

Reported-by: syzbot+e2af46126e0644cbebdd@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e2af46126e0644cbebdd
Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
v2:
- Drop READ_ONCE() around dev->reg_state.  addrconf_notify() is called
  from the netdevice notifier path, so a plain load is sufficient.
- Do not add a Fixes tag.  The issue does not appear to be caused by a
  single commit, but by a long-standing unregister-time lifecycle gap.

 net/ipv6/addrconf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 5476b6536eb7..a517e57cf86a 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -3666,6 +3666,9 @@ static int addrconf_notify(struct notifier_block *this, unsigned long event,
 		break;

 	case NETDEV_CHANGEMTU:
+		if (dev->reg_state == NETREG_UNREGISTERING)
+			break;
+
 		/* if MTU under IPV6_MIN_MTU stop IPv6 on this interface. */
 		if (dev->mtu < IPV6_MIN_MTU) {
 			addrconf_ifdown(dev, dev != net->loopback_dev);
@@ -3691,6 +3694,9 @@ static int addrconf_notify(struct notifier_block *this, unsigned long event,
 		fallthrough;
 	case NETDEV_UP:
 	case NETDEV_CHANGE:
+		if (dev->reg_state == NETREG_UNREGISTERING)
+			break;
+
 		if (idev && idev->cnf.disable_ipv6)
 			break;

--
2.50.1

