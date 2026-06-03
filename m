Return-Path: <netdev+bounces-294513-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4Jr4JD6NH2plnAAAu9opvQ
	(envelope-from <netdev+bounces-294513-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 04:11:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA78F63399F
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 04:11:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=padl.com header.s=default header.b=lNRyan4r;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294513-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294513-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=padl.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB40C302E933
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 02:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F463D6CC2;
	Wed,  3 Jun 2026 02:10:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E946E3AB271;
	Wed,  3 Jun 2026 02:10:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780452625; cv=none; b=YQHJDU99l7Dp/KoABMB62ajnbHZZ+GV8LqrKROETIR6/p7VI/fgG3iNT/m/2bMUUsBzMExBk5yUU/VeZJXuvmO1BYGTeqnubKTwG4rzH8Qv6tMQJyYp51mlR039br/DQak5TfH7aWRZJjDRMulzeg8PV2zVthV4RZ2Dv3Whz9GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780452625; c=relaxed/simple;
	bh=s4CAiE4vIRteIubAn5/oiZKBCwwuTGAWnOK8l9l4tyM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=mVkMAt22MHzeKGiZ7UywuNW9oQun+Dx3AvFiPnnHHTNgL2d76F3bbUQEqU0LdHETlFmN+oEXXEEFXERbdBAZE/AJZAwHJs4aH2MSLRM+W8oiEOlUpigSt4OlClR54AUyOaC45La8o0+JV3ACinLHa44Yghbb6e2tXe+0908BD8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=lNRyan4r; arc=none smtp.client-ip=216.154.215.154
Received: from auth (localhost [127.0.0.1]) by us.padl.com (8.14.7/8.14.7) with ESMTP id 65329tGr002922
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 3 Jun 2026 03:09:57 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 65329tGr002922
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1780452607; bh=s4CAiE4vIRteIubAn5/oiZKBCwwuTGAWnOK8l9l4tyM=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=lNRyan4rtgIg/ve5PAW1Auf5u87osem4kwJWhSBpQWnIYL9UYghA/nHaEpn2DDcmT
	 9N/MZjNzGtpTitFMlzGh5xbMcf/P+bOPbVqep7eARojp0BB1WsFmNNm/ADt/s/HQlD
	 U+p6Xf90/d3o+54GAjdN4Ca8+BqaDrLvU79WadAUSY3j2gwYOm6Flr4SkcKYi1e9lq
	 AhGEbZrsLW0XbtoCHvbr1vmvTE9kdGR3AKKaLKS/JquMnExO7F3xzeNmhtK5SvvjE/
	 0e25o4CmDPEN9gLWpcGeZQjlXLtJxyecIXTfnQNIiqfQkw2GCbEuozKjq2LQpcNDqQ
	 GhjHZ2+5p2PIA==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH net-next v2 5/6] net: dsa: mv88e6xxx: MQPRIO support
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <A662D3F9-18DD-43C9-A43D-912E5A8A4360@padl.com>
Date: Wed, 3 Jun 2026 12:09:44 +1000
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
Message-Id: <2AC04CE3-1760-49B4-A25D-170629AAD38A@padl.com>
References: <20260602-mv88e6xxx-8021qat-mqprio-v2-0-72be14522e7c@padl.com>
 <20260602-mv88e6xxx-8021qat-mqprio-v2-5-72be14522e7c@padl.com>
 <t44kmhk6gqxnwhdvo7svouexwelwsya7zgukpbv3cxpfsmutqa@y3rjoj3tvqce>
 <A662D3F9-18DD-43C9-A43D-912E5A8A4360@padl.com>
To: Cedric Jehasse <cedric.jehasse@gmail.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[padl.com,reject];
	R_DKIM_ALLOW(-0.20)[padl.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294513-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jiri@resnulli.us,m:ivecera@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:razor@blackwall.org,m:idosch@nvidia.com,m:andrew+netdev@lunn.ch,m:dsahern@kernel.org,m:shuah@kernel.org,m:andrew@lunn.ch,m:olteanv@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bridge@lists.linux.dev,m:linux-kselftest@vger.kernel.org,m:max@huntershome.org,m:kieran@sienda.com,m:cedric.jehasse@gmail.com,m:cedricjehasse@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[padl.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[resnulli.us,redhat.com,davemloft.net,google.com,kernel.org,blackwall.org,nvidia.com,lunn.ch,gmail.com,vger.kernel.org,lists.linux.dev,huntershome.org,sienda.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EA78F63399F



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

I misread the data sheet. Egress PCP to FPRI mapping is possible =
per-port on the 6390 family. This doesn=E2=80=99t resolve the other =
issue (MQPRIO-less ports on the 6352 family). But it is good news and I =
will revise accordingly in the next patch revision.=

