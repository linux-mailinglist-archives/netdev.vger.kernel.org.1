Return-Path: <netdev+bounces-294538-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +ppZI++fH2qXoAAAu9opvQ
	(envelope-from <netdev+bounces-294538-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 05:30:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE57B633ECA
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 05:30:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=padl.com header.s=default header.b=d8rdz33I;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294538-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294538-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=padl.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8989304E6E2
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 03:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85E93D6474;
	Wed,  3 Jun 2026 03:30:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BE435A3B8;
	Wed,  3 Jun 2026 03:30:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780457450; cv=none; b=sjchPXjfd8SV/cnf71Ma6k2tZe/GFyD5bPBPnmG5NRbUGKpplyh2NoHHATNXPhZ+3g3U5yTS+vECdwSmsrT6zyIPyH4UX4EZpKxT27cPJCYBjPFvPmwP9sIHOKeWD3n3GAhThZP4CA1EVYomAR7Slg70HXOfe6UDMHXKdil11vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780457450; c=relaxed/simple;
	bh=HckXV8SgUm6gBOsERf+KnMnS8zcCmg+Nd4fBgn+6UKE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=LyNQyJx3GjnANAjf8KmChfpnGYH2l1FKZ1Am69wN1Mzba0R9UscoKQF6q5xOyAkRvCht6Aos5DG04m55ToEpaDP4hZqoTRSJD58QXN/yfq5P+cEZyMtJaBZBi1t2ScfA8cR1dli91ZGCWGHEZLPah6hwPQcoKe6Sd9l5WrzR84U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=d8rdz33I; arc=none smtp.client-ip=216.154.215.154
Received: from auth (localhost [127.0.0.1]) by us.padl.com (8.14.7/8.14.7) with ESMTP id 6533U3NL016913
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 3 Jun 2026 04:30:28 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 6533U3NL016913
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1780457433; bh=HckXV8SgUm6gBOsERf+KnMnS8zcCmg+Nd4fBgn+6UKE=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=d8rdz33IM4nuvC2/SuI5GfmrcXoUs7Y+TClzQ9w/tqCO76IXp8eP+1V77i1IbHrfL
	 TYAi+ZIBdZbbTv68ZfRXmhwsDc3k2ify599r8hP/NEVGJ8bkmIZossNsjQ/TIW3TJs
	 kbqtkEByC+SkJxeGOnQBV8UExxPI22phHCxEOPtYn3mYrRap8Fns8DwJ1bZpXnB5Ln
	 Wy+cqdZ5dKhJXZMJuOosMd7efPWTG5pVLAWf8/8QOGD0RC2hSae3AURl9EcAnhRQc9
	 4erwzfqDqJ/HFntNib8RkbVFNZwQoWzqo1EO3/Yg9Nd59zuO0ba5j8KF+N8KkDWKxj
	 PmXH62RMp/vWw==
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
In-Reply-To: <2AC04CE3-1760-49B4-A25D-170629AAD38A@padl.com>
Date: Wed, 3 Jun 2026 13:30:17 +1000
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
Message-Id: <C9A205F0-0F73-423D-86C4-A0062E8475C9@padl.com>
References: <20260602-mv88e6xxx-8021qat-mqprio-v2-0-72be14522e7c@padl.com>
 <20260602-mv88e6xxx-8021qat-mqprio-v2-5-72be14522e7c@padl.com>
 <t44kmhk6gqxnwhdvo7svouexwelwsya7zgukpbv3cxpfsmutqa@y3rjoj3tvqce>
 <A662D3F9-18DD-43C9-A43D-912E5A8A4360@padl.com>
 <2AC04CE3-1760-49B4-A25D-170629AAD38A@padl.com>
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
	FORGED_RECIPIENTS(0.00)[m:jiri@resnulli.us,m:ivecera@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:razor@blackwall.org,m:idosch@nvidia.com,m:andrew+netdev@lunn.ch,m:dsahern@kernel.org,m:shuah@kernel.org,m:andrew@lunn.ch,m:olteanv@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bridge@lists.linux.dev,m:linux-kselftest@vger.kernel.org,m:max@huntershome.org,m:kieran@sienda.com,m:cedric.jehasse@gmail.com,m:cedricjehasse@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-294538-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_THREE(0.00)[4];
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
X-Rspamd-Queue-Id: DE57B633ECA


>> Good point, it=E2=80=99s interesting there is egress mapping on the =
6390 but only for FPri to DSCP. The Frame Priority Table set ordinal one =
would expect for egress QPri mapping is =E2=80=9Creserved for future =
use=E2=80=9D. (Be nice if it were an undocumented feature.)
>=20
> I misread the data sheet. Egress PCP to FPRI mapping is possible =
per-port on the 6390 family. This doesn=E2=80=99t resolve the other =
issue (MQPRIO-less ports on the 6352 family). But it is good news and I =
will revise accordingly in the next patch revision.


I did not misread the data sheet. The 6390 family does not support =
egress FPri to QPri mapping. It supports egress FPri to _PCP_ mapping =
(i.e. the internal and wire representations of the priority can differ). =
Clearly needed a third coffee.

Luke=

