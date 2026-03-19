Return-Path: <netdev+bounces-269224-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PZMKgxHu2kliQIAu9opvQ
	(envelope-from <netdev+bounces-269224-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 01:45:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 108D82C4273
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 01:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC425311D70E
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 00:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B212023536B;
	Thu, 19 Mar 2026 00:44:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw2.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1A72B9B7
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 00:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773881043; cv=none; b=sfAl7JcEImtB9zDqVPgiwNnq8aZBbOBpwP0rjk1eE69pUDquPrzRPsOBxwp0aVQaS+cq/61LlT9N1IE5WIEuXDhJnKqU1uRgIazkjwUJ09pUIk9w7Vz/2lIJ/1jaJIGOj+QVK3bJwsYAXuys0bMFUabcHOzLhZD5rlcTPo/PFmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773881043; c=relaxed/simple;
	bh=R0gyezNUjoeHfKtZpni3CaO3nviThjHMgM9T+bNatbk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kvZT9fjP/3lbslsRtgADLP32tjsD7ihTiBuHIzwPPpJyyg4yHhP1JIyt4JsWwYkmSZQ5dYaSbV2A1Tm/JVXh4mDYOKq5AgZqqUJRpuLTvdgvtplx7cAhAPky8ipZjTSn7Xi6w54vZ4XFGt6mudpZkpMR5elgQaKNblAYD6xE1/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
	by mailgw2.hygon.cn (Postfix) with ESMTP id 4fbn4T3gz3z1YQpmD;
	Thu, 19 Mar 2026 08:43:37 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
	by mailgw2.hygon.cn (Postfix) with ESMTP id 4fbn4R20Mbz1YQpmD;
	Thu, 19 Mar 2026 08:43:35 +0800 (CST)
Received: from cncheex05.Hygon.cn (unknown [172.23.18.115])
	by maildlp1.hygon.cn (Postfix) with ESMTPS id 1F2895959;
	Thu, 19 Mar 2026 08:43:28 +0800 (CST)
Received: from cncheex04.Hygon.cn (172.23.18.114) by cncheex05.Hygon.cn
 (172.23.18.115) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 19 Mar
 2026 08:43:35 +0800
Received: from cncheex04.Hygon.cn ([fe80::1b6f:6c58:58a4:430d]) by
 cncheex04.Hygon.cn ([fe80::1b6f:6c58:58a4:430d%10]) with mapi id
 15.02.1544.036; Thu, 19 Mar 2026 08:43:34 +0800
From: Zhud <zhud@hygon.cn>
To: Jakub Kicinski <kuba@kernel.org>
CC: "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>, "eperezma@redhat.com" <eperezma@redhat.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "willemb@google.com"
	<willemb@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, Jing Li
	<lijing@hygon.cn>, Zhiwei Ying <yingzhiwei@hygon.cn>
Subject: RE: [PATCH net v3] virtio-net: enable NETIF_F_GRO_HW only if
 GRO-related offloads are supported
Thread-Topic: [PATCH net v3] virtio-net: enable NETIF_F_GRO_HW only if
 GRO-related offloads are supported
Thread-Index: AQHctgIsDY8nIT6XukqVKwAnhqpvxrWyyXQAgACy7rA=
Date: Thu, 19 Mar 2026 00:43:34 +0000
Message-ID: <738926a1932e4c7a94f0ad8929b38171@hygon.cn>
References: <20260317113433.927022-1-zhud@hygon.cn>
 <20260317153126.61f7d3de@kernel.org>
In-Reply-To: <20260317153126.61f7d3de@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[hygon.cn : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-269224-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	NEURAL_SPAM(0.00)[0.055];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhud@hygon.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hygon.cn:mid]
X-Rspamd-Queue-Id: 108D82C4273
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> On Tue, 17 Mar 2026 19:34:33 +0800 Di Zhu wrote:
> > In such a setup, reporting NETIF_F_GRO_HW as available for the device
> > is too optimistic and misleading to the user.
>=20
> This is not a sufficient justification to make this a fix.
> As Michael was already alluding to HW GRO usually covers fewer
> protocols and is less effective than SW GRO. Normal config is
> to have both enabled. Please explain if there's anything special
> about virtio here, because I haven't heard of people disabling
> SW GRO because HW GRO is already enabled.

"Thanks, Jakub. You're right, that was a poorly chosen example to justify t=
his as a fix,=20
and I see your point regarding HW GRO vs SW GRO. There isn't anything speci=
al about
virtio here that would necessitate disabling SW GRO in normal cases; my ini=
tial thought=20
was more about the potential for user confusion in specific testing scenari=
os.


>=20
> I think this should continue to target net-next with no Fixes tag.

I'll drop the Fixes tag and target net-next in V2. I'll also move the=20
hw_features initialization before register_netdevice() as discussed,=20
to ensure the driver follows the proper pattern."


