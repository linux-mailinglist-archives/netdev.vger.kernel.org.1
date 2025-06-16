Return-Path: <netdev+bounces-197928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1D1ADA62C
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 04:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46C227A6E1D
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 02:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9466D27A112;
	Mon, 16 Jun 2025 02:08:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9E4263C69
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 02:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750039685; cv=none; b=UiBsmZFXEA0RApZtB1Egmd5nhBrWk7TiuZ4vEULDJ+/z0SDDe4Z7OfU6Uf6+VA1Q5o90Eco+MLcr2B6m7Ml7EGpuN7GWgLHgtPz5GJxiiGAY7ednQcPScOCAb7NB1LuC9UpfQJv/5I//9XGM8JOpVNaP3bQhIbwbgHM8A/FTE6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750039685; c=relaxed/simple;
	bh=h6HiMg5hqocGZ3813lP1lmu8DKVQX0Y9Ih977MAhtkM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=HLrhjrRqDt8ktOD48PY0NgIAxcv/g+gRsmpI+wF7snMaEUM6yM9gHulRfoV1nH0IyOuH7Z4pxb66qsM+diUMLrPztMWw2oco2HULyG5+s52pvqH+9eLp7sCaOPZ/N4GBONTAlGWlGhsXY33K/hJJIjoEY6KVsgVSJKmBVwsQMro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpsz17t1750039645t08f9708f
X-QQ-Originating-IP: 9kba30fIfcRT75y/niAAWfIULHrAr7CyphCDo7N/bCM=
Received: from smtpclient.apple ( [36.110.17.29])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 16 Jun 2025 10:07:23 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16735000456199326041
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [net-next v6 0/4] add broadcast_neighbor for no-stacking
 networking arch
From: Tonghao Zhang <tonghao@bamaicloud.com>
In-Reply-To: <cover.1749525581.git.tonghao@bamaicloud.com>
Date: Mon, 16 Jun 2025 10:07:13 +0800
Cc: Jay Vosburgh <jv@jvosburgh.net>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Zengbing Tu <tuzengbing@didiglobal.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <17E0F9C1-EB57-4ABC-BF6B-F54BCA9C6307@bamaicloud.com>
References: <cover.1749525581.git.tonghao@bamaicloud.com>
To: netdev@vger.kernel.org
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NiJgP/70eYXdk1TI7QBxxfWld12KKitoeMgY3WBTRTmbh7Z5EHM69c61
	KVzuBYCPLlhZBa9fViswTv063RwUOY837cWdpnLhfIR3qUq/cxm/VMFGtqJoZf+BdHr025r
	N5pfhXN4cHd3Qte4uD/tNUZ9HV9uFX044mtoW7KXEwWWpaz3Z24a9Gmsw15zEo0fKfhfFvR
	PTP2gdsuypbNTwD2ES6/ihoxAcAv/Znz9QYTZL05fBraLUxGtZk8p1tKttB09+leer4j4PJ
	48zwFuieqQuNB7aZn+JEWzKQC9DKT1s5FtL2rfGP/oCoFo25ICDBARoV6XhqxD/ckqdEBon
	mX/vZ4h7Ionk1hYuVTHkxezH9JFhefvqakmgvVCEE5T0ToGwyANqNpqTx9FzbQi3I5M2pjt
	iqfgazOvi8eOXuF9rDQOYZCdoQH2UoqAnyDt5qHuT5bLEBTsj2N4zclnraWaWrdHDNaxF7+
	HI2calqXXJhB/dnDMhqivQa8zbb++IZebYjRvdYRg7d6eiCs2m4V7aWink1OPQ7tmcuQLFq
	a3mLO2r/DIOKH9nJpO2GwTL218w/FQZbgI53G3lATzG1qNbBSZkonV+fvz9cXK/xNdwzwzf
	zWRxdOPIwV1NIOYl//iAlJUBDLdIt4M7GlHeDnILCrxrg9M2QxgO9CaAH8y6k/tNquHEqjc
	RVPQ4nb55DASUkmNC2MaHjUK1iqTdCDwtU2ByvJiFZdyLAuJ14R5oyjGOFRq9YaKmX13PH+
	PxE3zalURCvLkzaQXlI4uAa7cJb/8O1gO3okEaevHxxfQgWWo7rx1kN/ZwUnaptFDtAUh8j
	I9RnIdyyLnCqPrIkpo8ZrOuk/E5aZWvjPXP5ciRgDq8AbwgPtV19nCIzsvPLetXmLU1U8JI
	bNBvXN91S2bhDYJ3Nli5+b/+Te8JAc1lgVWZs8nDHWg0iM6rLaBiEQuv+pDz3ZEDSTfOP6Z
	0rxn1pcG2N/A9bJ76h/2rPpGmvfRTkxSAJoc=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

ping

> 2025=E5=B9=B46=E6=9C=8810=E6=97=A5 11:44=EF=BC=8CTonghao Zhang =
<tonghao@bamaicloud.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> For no-stacking networking arch, and enable the bond mode 4(lacp) in
> datacenter, the switch require arp/nd packets as session =
synchronization.
> More details please see patch.
>=20
> v6 change log:
> - del unnecessary rcu_read_lock in bond_xmit_broadcast =20
>=20
> v5 change log:
> - format commit message of all patches
> - use skb_header_pointer instead of pskb_may_pull
> - send only packets to active slaves instead of all ports, and add =
more commit log
>=20
> v4 change log:
> - fix dec option in bond_close
>=20
> v3 change log:
> - inc/dec broadcast_neighbor option in bond_open/close and UP state.
> - remove explicit inline of bond_should_broadcast_neighbor
> - remove sysfs option
> - remove EXPORT_SYMBOL_GPL
> - reorder option bond_opt_value
> - use rcu_xxx in bond_should_notify_peers.
>=20
> v2 change log:
> - add static branch for performance
> - add more info about no-stacking arch in commit message
> - add broadcast_neighbor info and format doc
> - invoke bond_should_broadcast_neighbor only in BOND_MODE_8023AD mode =
for performance
> - explain why we need sending peer notify when failure recovery
> - change the doc about num_unsol_na
> - refine function name to ad_cond_set_peer_notif
> - ad_cond_set_peer_notif invoked in ad_enable_collecting_distributing
> - refine bond_should_notify_peers for lacp mode.
>=20
> Cc: Jay Vosburgh <jv@jvosburgh.net>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> Cc: Zengbing Tu <tuzengbing@didiglobal.com>
>=20
> Tonghao Zhang (4):
>  net: bonding: add broadcast_neighbor option for 802.3ad
>  net: bonding: add broadcast_neighbor netlink option
>  net: bonding: send peer notify when failure recovery
>  net: bonding: add tracepoint for 802.3ad
>=20
> Documentation/networking/bonding.rst | 11 +++-
> drivers/net/bonding/bond_3ad.c       | 19 ++++++
> drivers/net/bonding/bond_main.c      | 87 ++++++++++++++++++++++++----
> drivers/net/bonding/bond_netlink.c   | 16 +++++
> drivers/net/bonding/bond_options.c   | 35 +++++++++++
> include/net/bond_options.h           |  1 +
> include/net/bonding.h                |  3 +
> include/trace/events/bonding.h       | 37 ++++++++++++
> include/uapi/linux/if_link.h         |  1 +
> 9 files changed, 197 insertions(+), 13 deletions(-)
> create mode 100644 include/trace/events/bonding.h
>=20
> --=20
> 2.34.1
>=20
>=20
>=20


