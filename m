Return-Path: <netdev+bounces-285763-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMytIDzI/WlSjAAAu9opvQ
	(envelope-from <netdev+bounces-285763-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 13:25:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6354F5BD2
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 13:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11DDF300F503
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 11:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA23395D87;
	Fri,  8 May 2026 11:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=desarrollaria.com header.i=y2k@desarrollaria.com header.b="q8leFCbc"
X-Original-To: netdev@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF68282F05;
	Fri,  8 May 2026 11:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778239298; cv=none; b=pc4xRZnmsR+SDqxdjIdbChxZvkTZZwiUnlZ3YRAiC4OliUP/+z3W4eiUe/WeI1hSHWUnkiuZBxXTY86GYPCJeAtmi9WKe7HXimmzm+GHHfpNaXY2YzH29W43sLvBVM+M+IFzq29DtF+JrfoBxWj+V+hfWQIXbUrNtNXeWq9hgnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778239298; c=relaxed/simple;
	bh=gzDbhQIoIGWMSRircUWTa1O74IhGW+YFHmHbNp9z2cM=;
	h=Date:Message-ID:From:To:Cc:Subject:Content-Type; b=tpNWBOBrWHhXiKGgpxZgNNUOsDZUtCSl5MpajbbIhDDAw8s6nteD1YZNTYy3gqeLvtQQcJbmurRUkzIr+Nps13o6Gb4vF3j1f2FtfVn94SI4QU/EBPwSkXTDcZqiVeaDdLaAdfWBvRBK3eKCDIYgSDjI2cJEGsx6236b0kYlRHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desarrollaria.com; spf=pass smtp.mailfrom=desarrollaria.com; dkim=pass (2048-bit key) header.d=desarrollaria.com header.i=y2k@desarrollaria.com header.b=q8leFCbc; arc=none smtp.client-ip=212.227.126.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=desarrollaria.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=desarrollaria.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desarrollaria.com;
	s=s1-ionos; t=1778239283; x=1778844083; i=y2k@desarrollaria.com;
	bh=weV1CskBejzvSQS/4D3AQl2jH3o7iHunH2yC9B3HlFI=;
	h=X-UI-Sender-Class:Date:Message-ID:From:To:Cc:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=q8leFCbc8U3PzEdSlnkmRjo/zGqOp1jfa6IttdELZc7fuB18KIDmmCrYMjYhvUtd
	 z+PJ42xGcH8pRjfkRkGpt/ZOGnb1sDsD4UnGW25+OOED8X20IQE1/7J4qvYn+/ZkX
	 QpaXBo2s2BujrTBPBuFqWCE/IRTDbcvLCNe8e+necPbJ7nLenwM7cmzB3afF6rptA
	 KOXULHNgNiB4XEoUheIdcFS3GGWc9n+Rz/UWUAPw9HPxEcmxpCBBkCQ6uAimwRIIO
	 4cHzKl8v6FQGKhhVlztwH/KCjhWkZVkcLFsDHIZCYNRFmwImUodzI5gZ32lyps9Nz
	 +KOVjOsohos4pz6ZIA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue009
 [212.227.15.136]) with ESMTPSA (Nemesis) id 1MXp1Q-1vnCPf2BUS-00K6HF; Fri, 08
 May 2026 13:21:23 +0200
Date: Fri, 08 May 2026 13:21:21 +0200
Message-ID: <863d7892459fd7627388d8b0c1670292.y2k@desarrollaria.com>
From: y2k <y2k@desarrollaria.com>
To: dsahern@kernel.org
Cc: idosch@nvidia.com, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: ipv6: ip6mr: Call ip6mr_fib_lookup() under RCU in pim6_rcv() and reg_vif6_xmit()
Content-Type: text/plain; charset=UTF-8
X-Provags-ID: V03:K1:7PRER3YMWhF8Go32xvQbWA10liFdpO2yjDHvfks5Y9VrKxoFcDY
 slH5aaIOeCl38l8JQqAZ7SCjLHBkUiY3D9EjNEg5jomftrE3R07DJiP9EM1G/n9jV/wFGJW
 tfbQUnkgzRxkHFog/5D1obInVsyfsPqvuUQoclwUPqDVNh7v9iLdvB2Uaq3N1jLVmTiFPBV
 aKeDZeP2D91lSaBImHaBg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OO5xyz/qqSE=;WaVOQdmKTR8HeEtr+qaQMRMuZmN
 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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: DC6354F5BD2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[desarrollaria.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[desarrollaria.com:s=s1-ionos];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[desarrollaria.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285763-lists,netdev=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[y2k@desarrollaria.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,desarrollaria.com:email,desarrollaria.com:mid,desarrollaria.com:dkim]
X-Rspamd-Action: no action

Commit 019c892e4654 ("ipmr: Call ipmr_fib_lookup() under RCU.") fixed
the same issue in IPv4's reg_vif_xmit(). The IPv6 counterpart has the
same problem in two places.

In pim6_rcv() (net/ipv6/ip6mr.c:578) and reg_vif6_xmit()
(net/ipv6/ip6mr.c:624), ip6mr_fib_lookup() is called without holding
rcu_read_lock().

When CONFIG_IP6_MROUTE_MULTIPLE_TABLES=3Dn, ip6mr_fib_lookup() accesses
net->ipv6.mrt6 directly without rcu_dereference(), while the IPv4
equivalent correctly uses rcu_dereference(net->ipv4.mrt). This
inconsistency means IPv6 multicast routing lacks proper RCU protection.

In reg_vif6_xmit(), rcu_read_lock() is acquired at line 628 after the
ip6mr_fib_lookup() call at line 624 =E2=80=94 too late. In pim6_rcv(), the=
re
is no rcu_read_lock() before ip6mr_fib_lookup() at line 578 at all.

Suggested fix for reg_vif6_xmit():

  + rcu_read_lock();
    if (ip6mr_fib_lookup(net, &fl6, &mrt) < 0) {
  +   rcu_read_unlock();
      goto tx_err;
    }
    DEV_STATS_ADD(dev, tx_bytes, skb->len);
    DEV_STATS_INC(dev, tx_packets);
  - rcu_read_lock();
    ip6mr_cache_report(mrt, skb, READ_ONCE(mrt->mroute_reg_vif_num),
                       MRT6MSG_WHOLEPKT);
    rcu_read_unlock();

Suggested fix for pim6_rcv():

  + rcu_read_lock();
    if (ip6mr_fib_lookup(net, &fl6, &mrt) < 0) {
  +   rcu_read_unlock();
      goto drop;
    }

Additionally, net->ipv6.mrt6 should be accessed via rcu_dereference()
in ip6mr_fib_lookup() to match the IPv4 pattern in ipmr_fib_lookup().

Thanks,
y2k
y2k@desarrollaria.com

