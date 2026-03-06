Return-Path: <netdev+bounces-264705-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIuwMxuLqml0TQEAu9opvQ
	(envelope-from <netdev+bounces-264705-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 09:06:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5B021CD51
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 09:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D165301A281
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 08:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762A6372B3A;
	Fri,  6 Mar 2026 08:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="moBebrA3"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC58375AAD
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 08:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772784402; cv=none; b=YtJVbnHJLCPwEptemtmHSllWiKF9VI0HIujs2kH4kxjeKKDbIPuGhJVkBlUGsaByVz2VvbJTHwBaRkBcvZbF3jpixNedackcdd2Gk8c/cDMWiDAxwV3XJY+b1ZMtVnO+KpR0KFFaCLvnMPgdh82qn4Zv4FhaMqRsRA9/c6VFK4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772784402; c=relaxed/simple;
	bh=YCScPXVM4hOLfO/yydHOsvKwR5YXuOuJJXZd9iRbi84=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=Jk+fH5yWZcoQVA/1PUDD5YxJaIxy3dGTUX7xZRSnqvhjSWspHzBiaN+hW+lVweJ87GpyW4TCTobBtTKnEUbXalRYZbhEOzh1A8q1wpTia9mZSIOEYNbOq5IfwRL6RsYlPlKYB1xYS/KW9HY/BsJ3nn6PM9n7VpCrg3/RXd19xnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=moBebrA3; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772784397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DW00uR8BvA5m7KptmQqZEldoo1+9rhV1LmSSrZmrVsY=;
	b=moBebrA32CSwUx1ml+wTgo4mIv6eRTm6CgYwi9+0asdku2KzSHZQzrTFXHZf3mxUYW/juZ
	s8FdfA78PDlGFGEnvLPEj3EYYVoqNjlFywB6JLJNdNDcHEXblHGi/3A3yAJLEZpF7x4sYi
	zIN+Yn64663HqdgPbdOMjA4NiGbAIw8=
Date: Fri, 06 Mar 2026 08:06:35 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <f43e3d020dd701d2fe69fd6e6b941321804555c9@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v4 0/2] net: bonding: fix type-confusion in bonding
 header_ops
To: "Jay Vosburgh" <jv@jvosburgh.net>
Cc: "Jeff Garzik" <jeff@garzik.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Yuki Koike"
 <yuki.koike@gmo-cybersecurity.com>
In-Reply-To: <1356396.1772744345@famine>
References: <20260305110751.167489-1-kota.toda@gmo-cybersecurity.com>
 <1356396.1772744345@famine>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 6E5B021CD51
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.dev:?];
	TAGGED_FROM(0.00)[bounces-264705-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DMARC_DNSFAIL(0.00)[linux.dev : SPF/DKIM temp error,none];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.842];
	R_DKIM_TEMPFAIL(0.00)[linux.dev:s=key1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:email,jvosburgh.net:email,syzkaller.appspot.com:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

March 6, 2026 at 04:59, "Jay Vosburgh" <jv@jvosburgh.net mailto:jv@jvosbu=
rgh.net?to=3D%22Jay%20Vosburgh%22%20%3Cjv%40jvosburgh.net%3E > wrote:


>=20
>=20Kota Toda <kota.toda@gmo-cybersecurity.com> wrote:
>=20
>=20>=20
>=20> In bond_setup_by_slave(), the slave=E2=80=99s header_ops are uncond=
itionally
> > copied into the bonding device. As a result, the bonding device may i=
nvoke
> > the slave-specific header operations on itself, causing
> > netdev_priv(bond_dev) (a struct bonding) to be incorrectly interprete=
d
> > as the slave's private-data type.
> >=20
>=20> This type-confusion bug can lead to out-of-bounds writes into the s=
kb,
> > resulting in memory corruption.
> >=20
>=20 A few days ago, Jiayuan Chen <jiayuan.chen@linux.dev> posted a
> fix for what sounds like the same problem[0]. Their solution appears to
> be much less complicated.
>=20
>=20 I also wonder how this bug was discovered. The code in question
> hasn't changed in many years, and now there are two independent fixes
> within a week.

This issue has existed for years, but was likely masked by other bugs in =
the IP GRE
module.
https://syzkaller.appspot.com/bug?extid=3D4c63f36709a642f801c5
https://syzkaller.appspot.com/bug?id=3D77135d6c2fc52eff1b3c561912fbec3976=
1e0461

The recent commit e67c577d8989 ("ipv4: ip_gre: make ipgre_header() robust=
"), which
introduced pskb_expand_head, has made the wrong type-casting issue more a=
pparent.

v2 was sent:
https://lore.kernel.org/netdev/20260306021508.222062-1-jiayuan.chen@linux=
.dev/


> [0] https://lore.kernel.org/netdev/20260228095854.391093-1-jiayuan.chen=
@linux.dev/
>=20
>=20>=20
>=20> Patch 1 stores the slave's header_ops in struct bonding and sets
> > wrapper callbacks in bond_In bond_setup_by_slave(), the slave=E2=80=
=99s
> > header_ops are unconditionally
> > copied into the bonding device. As a result, the bonding device may i=
nvoke
> > the slave-specific header operations on itself, causing
> > netdev_priv(bond_dev) (a struct bonding) to be incorrectly interprete=
d
> > as the slave's private-data type.
> >=20
>=20> Patch 2 uses READ_ONCE when loading header_ops callbacks
> > to avoid races with concurrent updates.
> >=20
>=20 With the READ_ONCE changes in a separate patch, does that mean
> that patch 1 by itself is subject to race conditions that would result
> in errors? If so, that's not acceptable, every patch must stand alone
> and not break the kernel.
>=20
>=20 -J
>=20
>=20>=20
>=20> Fixes: 1284cd3a2b74 ("bonding: two small fixes for IPoIB support")
> > Signed-off-by: Kota Toda <kota.toda@gmo-cybersecurity.com>
> > Co-developed-by: Yuki Koike <yuki.koike@gmo-cybersecurity.com>
> > Signed-off-by: Yuki Koike <yuki.koike@gmo-cybersecurity.com>
> >=20
>=20> Kota Toda (2):
> >  net: bonding: fix type-confusion in bonding header_ops
> >  net: add READ_ONCE for header_ops callbacks
> >=20
>=20>  drivers/net/bonding/bond_main.c | 67 +++++++++++++++++++++++++++++=
+++-
> >  include/linux/netdevice.h | 41 ++++++++++++++------
> >  include/net/bonding.h | 5 +++
> >  include/net/cfg802154.h | 2 +-
> >  net/core/neighbour.c | 6 +--
> >  net/ipv4/arp.c | 2 +-
> >  net/ipv6/ndisc.c | 2 +-
> >  7 files changed, 106 insertions(+), 19 deletions(-)
> >=20
>=20> --=20
>=20> 2.53.0
> >=20
>=20---
>  -Jay Vosburgh, jv@jvosburgh.net
>

