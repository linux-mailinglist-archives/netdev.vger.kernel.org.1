Return-Path: <netdev+bounces-295802-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id k0rANpu9Imr/cwEAu9opvQ
	(envelope-from <netdev+bounces-295802-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 14:14:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 419A9647FE2
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 14:14:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=padl.com header.s=default header.b=y9Bu3EFF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295802-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295802-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=padl.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6A8B3055815
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 12:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20C64DA550;
	Fri,  5 Jun 2026 12:06:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367994A3410;
	Fri,  5 Jun 2026 12:06:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780661166; cv=none; b=fPhsl3IOxYvAWq55swUV96Z8wxhyBPdAh8aszVWbPaS7pJcG4k/rrNXSPsHs0unGBm+KNJ59g+qbsac3e0JoaAa6URG19WquOUzewJS5p/caz8iVFpIiSvSQ32oidqC1joqiE892WcLBQRM79Zqj5UbfUHSje1Y5JdtjWbMC3qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780661166; c=relaxed/simple;
	bh=Vxh3wg9HhEr1qAX4WFzBiSO8Vz9T8RHOzpTn4p1z3tg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=YLfdWN3196xMaPEqGgutMSYjB0BsTwCE+g9UFvpGQzFrNtxJlqTJwd0KgULqaH0rq/iqm9aiXGyGCGmCnxCv81xzVn/uXlp1IaieX/9laTy8qdDDZbpeRyG+28fSmk07jgZO7kUvdCF3YrS8j4KTla29rtWQYzbCBG0wLbg5x48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=y9Bu3EFF; arc=none smtp.client-ip=216.154.215.154
Received: from smtpclient.apple (119-18-22-158.771216.mel.static.aussiebb.net [119.18.22.158])
	by us.padl.com (Postfix) with ESMTPSA id 5A7B760C11;
	Fri,  5 Jun 2026 08:05:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1780661155; bh=Vxh3wg9HhEr1qAX4WFzBiSO8Vz9T8RHOzpTn4p1z3tg=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=y9Bu3EFFo/XPLXE6WcTk9fDcnEGy/hmWKfOwBDzLbTIuIF78Ms1Co57a9r0yrpZE9
	 C8tA84J+e/6YSe12URoFkXpJDrdCKgNJOC0LbF8eB64d+1J/OdAs7+UQcTzLIfsbAH
	 Y2QZHGKdTkFqehfxNwcDdLHCOvoqYVKov8c9JWvWHEO9MF79FFlhpK01BimML8BDxR
	 4aptKO3jP+CSX8iSL0KfIlYiv9yURIAZRsNT9kXHbDlcAW0UWUZ9bhwAsj1q/VFBwf
	 jHONYOv1o6vYGLvwgwncQYgZT3u3/rM5J+5B1l4AvZZXCWKeaAEIqb5tbevBKXkt6h
	 CbTq54tBhlnvw==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH net-next 0/2] net: dsa: mv88e6xxx: add support for dcb pcp
 app
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <B9290FD7-FB84-4FF7-BA30-529484B8A01F@padl.com>
Date: Fri, 5 Jun 2026 22:05:35 +1000
Cc: Cedric Jehasse <cedric.jehasse@gmail.com>,
 cedric.jehasse@luminex.be,
 Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Max Hunter <max@huntershome.org>,
 Kieran Tyrrell <kieran@sienda.com>,
 Nikolay Aleksandrov <razor@blackwall.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DC4059EC-F03D-4F7C-8F76-3D8C30E94A14@padl.com>
References: <20260604-net-next-mv88e6xxx-pcp-prio-v1-0-f9d10fe6cdc8@luminex.be>
 <02BDD59A-30A9-46F9-8413-28A867B50CD5@padl.com>
 <v4fqikeec52ginmogfvsfe5gobul2nqspe2ebzpzpja52lxacb@wq2elxqwrucf>
 <E43832AD-0F8A-465F-95E3-2AF5E72FB7B9@padl.com>
 <4d6e6d83-af79-4a06-9736-d6d81e705a61@lunn.ch>
 <B9290FD7-FB84-4FF7-BA30-529484B8A01F@padl.com>
To: Andrew Lunn <andrew@lunn.ch>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[padl.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[padl.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295802-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmail.com,luminex.be,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org,huntershome.org,sienda.com,blackwall.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:cedric.jehasse@gmail.com,m:cedric.jehasse@luminex.be,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:max@huntershome.org,m:kieran@sienda.com,m:razor@blackwall.org,m:andrew@lunn.ch,m:cedricjehasse@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[padl.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 419A9647FE2


> On 5 Jun 2026, at 11:13=E2=80=AFam, Luke Howard <lukeh@padl.com> =
wrote:
>=20
>> Ideally, the user should not need to know if some functionality has
>> been accelerated by offloading it to hardware. They just configure it
>> using the standard Linux model of the feature.
>=20
> Absolutely, and that was the model I used when building a SRP daemon, =
which I first tested with the software bridge and some i210s.

Which does beg the question why I hadn=E2=80=99t considered the =
admission control issue when originally implementing against the =
software bridge. That=E2=80=99s my bad, and perhaps had I discovered =
tc-flower earlier I would have a different mental model of how to map =
this to mv88e6xxx.

Also whilst the admission control is necessary to correctly implement =
802.1Qat and pass the Avnu test suites, it might not matter for many =
networks.

I will think about how to implement these semantics with tc-flower/TCAM, =
likely after I take a look at submitting your DSA in-band/Marvell RMU =
patches.

Luke=

