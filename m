Return-Path: <netdev+bounces-294464-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HBmaGBBsH2pClwAAu9opvQ
	(envelope-from <netdev+bounces-294464-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 01:49:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AD68C632FCD
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 01:49:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=padl.com header.s=default header.b=Ps3+sYrY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294464-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294464-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=padl.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B2053046345
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 23:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5830635B654;
	Tue,  2 Jun 2026 23:49:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5178248B;
	Tue,  2 Jun 2026 23:49:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780444171; cv=none; b=DcYimDISkY30eFIcKLePv0knuiyS8Nr1eM9opJjyC4O+UIa4lBEd7FTPMjxPwzvVLfwxEM3RM2TmNo+O+M1GFZVdAc4iOPb0+jyQsQ+I3mAOKjFFdemJov4/FSnwDXfjAqaHlrYTyXTQa1ZVQ+eiVz/wH5cCjzjT0tD284P8Lso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780444171; c=relaxed/simple;
	bh=JN++q9ViOYyXmmlhWxb4sc7AKbNJ1H/BZasY2l0ayeo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=gOkGVFIAx1rRnAKR6uFrQTFUZr1yvu+QYE9JNX36h4Y3AYc0xJcjGnjQo4N+ogdORinx5VdyLVa94sub2kMP+fF8+hyREUBNtOVNvwAGQB3/8xMX+LYpQzXzKAmy+yfz1zJ6+tShbTeb7uiJbxZWydd7xRSIfulFCDdkhvQgEl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=Ps3+sYrY; arc=none smtp.client-ip=216.154.215.154
Received: from auth (localhost [127.0.0.1]) by us.padl.com (8.14.7/8.14.7) with ESMTP id 652NmoD3010575
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 3 Jun 2026 00:48:52 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 652NmoD3010575
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1780444150; bh=JN++q9ViOYyXmmlhWxb4sc7AKbNJ1H/BZasY2l0ayeo=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=Ps3+sYrYuR3H3YCBAlVsDgpMVkOGZ3MV7Ld0Z4ioop5zQJyhZ5vc3B242tEBo1dqo
	 bsXAZgnhRDBBkk3fYc6cPQ6JGuBUCZf6esSO2Z4APqveUPSiw7I+iFZeF7BemvEy8O
	 KOmRA7LTXTMUejNlFaUAmeVaA3bPNTMibL2AEgLCty6ZffJuAHgNodpOqkrXVWKhlG
	 RcggvDOhUqKXNTyuGEqOgZhehvMtpfMQ7JAUK/Ni+ghrgqh4YUlfxW5VBMdz6108NJ
	 p9C5lpMURWlA9yXgEhTbf+9jEY9dLcVUcXClj3tRLNS1XKBn3tzBFynSZrlqG89k7f
	 tAme8GNcbBciw==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH net-next v2 5/6] net: dsa: mv88e6xxx: MQPRIO support
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <A662D3F9-18DD-43C9-A43D-912E5A8A4360@padl.com>
Date: Wed, 3 Jun 2026 09:48:39 +1000
Cc: Jiri Pirko <jiri@resnulli.us>, Ivan Vecera <ivecera@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bridge@lists.linux.dev, linux-kselftest@vger.kernel.org,
        Max Hunter <max@huntershome.org>, Kieran Tyrrell <kieran@sienda.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8C6AD966-2C28-4BEF-95C4-1B2AC3751513@padl.com>
References: <20260602-mv88e6xxx-8021qat-mqprio-v2-0-72be14522e7c@padl.com>
 <20260602-mv88e6xxx-8021qat-mqprio-v2-5-72be14522e7c@padl.com>
 <t44kmhk6gqxnwhdvo7svouexwelwsya7zgukpbv3cxpfsmutqa@y3rjoj3tvqce>
 <A662D3F9-18DD-43C9-A43D-912E5A8A4360@padl.com>
To: Cedric Jehasse <cedric.jehasse@gmail.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[padl.com,reject];
	R_DKIM_ALLOW(-0.20)[padl.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-294464-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_RECIPIENTS(0.00)[m:jiri@resnulli.us,m:ivecera@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:razor@blackwall.org,m:idosch@nvidia.com,m:andrew+netdev@lunn.ch,m:dsahern@kernel.org,m:shuah@kernel.org,m:andrew@lunn.ch,m:olteanv@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bridge@lists.linux.dev,m:linux-kselftest@vger.kernel.org,m:max@huntershome.org,m:kieran@sienda.com,m:cedric.jehasse@gmail.com,m:cedricjehasse@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[padl.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[resnulli.us,redhat.com,davemloft.net,google.com,kernel.org,blackwall.org,nvidia.com,lunn.ch,gmail.com,vger.kernel.org,lists.linux.dev,huntershome.org,sienda.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	APPLE_MAILER_COMMON(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AD68C632FCD



> On 3 Jun 2026, at 7:12=E2=80=AFam, Luke Howard <lukeh@padl.com> wrote:
>=20
>> In case of per port priority mapping, i don't know if this is working =
as
>> expected, as the IEEE priority mapping is done at ingress.
>> Eg. i think if MQPRIO channel mode is used to configure a pcp to =
queue mapping
>> on port 1 and a different mapping on port 2. Traffic received on port =
1 that
>> gets forwarded to port 2 and egresses port 2 will end up in the queue
>> configured by the mapping on port 1. As mqprio is an egress qdisc, i =
don't
>> think that's expected.
>=20
> Good point, it=E2=80=99s interesting there is egress mapping on the =
6390 but only for FPri to DSCP. The Frame Priority Table set ordinal one =
would expect for egress QPri mapping is =E2=80=9Creserved for future =
use=E2=80=9D. (Be nice if it were an undocumented feature.)
>=20
> I will remove the per-port mapping for the 6390 so all ports share the =
same mapping as they do on the 6352.

There is actually a slight impedance mismatch here which I hadn=E2=80=99t =
previously considered.

MQPRIO is a per-port Qdisc, but the FPri/QPri mappings on the switches =
are global (even, as you point out, on the 6390 as far as egress queues =
are concerned). Whilst we do validate that any MQPRIO-configured port =
has the same mapping, we can=E2=80=99t do anything about ports on which =
MQPRIO has not been configured (otherwise we would never be able to =
configure the first port). These ports implicitly inherit the per-switch =
mapping.

I think this is acceptable because, if one has not configured MQPRIO, =
one should have no expectation about which egress queue traffic ends up =
in. But there=E2=80=99s an alternative, more invasive, solution where =
the MQPRIO configuration is attached to the bridge itself, and is copied =
to (but not writable on) the user ports. This would require =
dsa_switch_ops changes.

Luke=

