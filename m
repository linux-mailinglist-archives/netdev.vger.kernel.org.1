Return-Path: <netdev+bounces-294539-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PHCBGg2gH2qpoAAAu9opvQ
	(envelope-from <netdev+bounces-294539-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 05:31:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D90633EF7
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 05:31:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=padl.com header.s=default header.b=Foso4T0d;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294539-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294539-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=padl.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A80ED3073703
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 03:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CD73F4127;
	Wed,  3 Jun 2026 03:30:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E423438BF;
	Wed,  3 Jun 2026 03:30:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780457451; cv=none; b=bwqGgUAMOQFXfUjUKb8ExE+aEAeSaGknXjQ5uwsOzUPy734N4WhQTn2Mpx1mwNwaHE0eo16L/3XW7uNU/ZtOlbmz1Ffjr8isOtN5N3vISaVJNEcPWe96EhG9U8zd0E/DHgT/5gBF6gP+AWjlcvSuprB6eJdsNa6qTuKMGxDdyfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780457451; c=relaxed/simple;
	bh=gqIbzrXWPAjinn/p8sMbvR/ov2hajbGhcdxtuYxTUTc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=I8S5e8FufnrphDydsPH1fyyW2W0RmE5KFjqOguF78CxIXW6QCWNU8enmQJ3iMU826y3kV3Dr7r0oyKWntXyB91vRD5sAqKhSqvw7QBG+x/agmTTqjfM3lJnCeLOkhzKHKWnv0aTx60Q6o3z3EdzHynGEa+uUhtnXIUpPmuYdaq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=Foso4T0d; arc=none smtp.client-ip=216.154.215.154
Received: from auth (localhost [127.0.0.1]) by us.padl.com (8.14.7/8.14.7) with ESMTP id 6533U3NK016913
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 3 Jun 2026 04:30:06 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 6533U3NK016913
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1780457425; bh=wx5DCxJt3YBq96RHEuIIDg/BZOK9odKQ5UsrE25SgK4=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=Foso4T0d818lz5Kaxvgkp4h+J28ag6wakQFjxAz3Ob02+thhxQrkElR4PdcvAWwpw
	 s3eNbvcsWiShMirHBrEEjC0tdJFXZZFS9qQDFYt0aa5xhQjuA0y7TDJHCaCJ8FGoZ0
	 w4jgrQHVBXhn3bubbpjyXsOSNlQPB4a1arIpesetTFfRHGZuNozyLDueqoYE83xsNG
	 5F/9mOG9eh7/EDDQVPkIQYtaTC5Pszhm6NC8bXX69D1Pe6M6PkHgMUlD8z+iGYTflx
	 pffnBX5vf2OQdTv/IR3xR3p/9YRVGjjZCBuOgJgm83M85HA1szU/ELzbJQlouSii6m
	 A1X3jI7hQGHgg==
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
In-Reply-To: <72af0cfc-9011-4713-9862-710eea5f1cb0@lunn.ch>
Date: Wed, 3 Jun 2026 13:29:53 +1000
Cc: Cedric Jehasse <cedric.jehasse@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
        Ivan Vecera <ivecera@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bridge@lists.linux.dev,
        linux-kselftest@vger.kernel.org, Max Hunter <max@huntershome.org>,
        Kieran Tyrrell <kieran@sienda.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1735AAB7-948A-4634-8920-D4BF9731A28D@padl.com>
References: <20260602-mv88e6xxx-8021qat-mqprio-v2-0-72be14522e7c@padl.com>
 <20260602-mv88e6xxx-8021qat-mqprio-v2-5-72be14522e7c@padl.com>
 <t44kmhk6gqxnwhdvo7svouexwelwsya7zgukpbv3cxpfsmutqa@y3rjoj3tvqce>
 <A662D3F9-18DD-43C9-A43D-912E5A8A4360@padl.com>
 <8C6AD966-2C28-4BEF-95C4-1B2AC3751513@padl.com>
 <29c09316-c911-456e-acc5-e18402da4bd4@lunn.ch>
 <0402DFFF-634A-40C4-BC1E-B038F20926FF@padl.com>
 <89BA4203-110E-4767-895C-A2808602FAF8@padl.com>
 <72af0cfc-9011-4713-9862-710eea5f1cb0@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
X-Mailer: Apple Mail (2.3826.700.81)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[padl.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[padl.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294539-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_RECIPIENTS(0.00)[m:cedric.jehasse@gmail.com,m:jiri@resnulli.us,m:ivecera@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:razor@blackwall.org,m:idosch@nvidia.com,m:andrew+netdev@lunn.ch,m:dsahern@kernel.org,m:shuah@kernel.org,m:olteanv@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bridge@lists.linux.dev,m:linux-kselftest@vger.kernel.org,m:max@huntershome.org,m:kieran@sienda.com,m:andrew@lunn.ch,m:cedricjehasse@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,resnulli.us,redhat.com,davemloft.net,google.com,kernel.org,blackwall.org,nvidia.com,lunn.ch,vger.kernel.org,lists.linux.dev,huntershome.org,sienda.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[padl.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	APPLE_MAILER_COMMON(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,lunn.ch:email,padl.com:mid,padl.com:from_mime,padl.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C4D90633EF7



> On 3 Jun 2026, at 12:41=E2=80=AFpm, Andrew Lunn <andrew@lunn.ch> =
wrote:
>=20
>> We could add (e.g.) bridge_setup_tc to dsa_switch_ops, which (in the
>> mv88e6xxx implementation) could validate the bridge contained all
>> user ports. But it would not be possible to block a port from
>> leaving as port_bridge_leave cannot return an error, and tearing
>> MQPRIO config down silently would be a different sort of bad.
>=20
> There can be multiple bridges, even as far as one bridge per port.

Right, per the above mv88e6xxx would return -EOPNOTSUPP if the bridge =
did not contain all DSA user ports. But without a means to block the =
removal of ports from bridges it would not be possible to maintain this =
invariant.

> For switch wide properties, you basically have to allow the first user
> to configure it, refcount additional users get added and removed, and
> only allow the last user to change it.

Indeed, that=E2=80=99s what this series does. But it comes with the =
discussed caveat that ports without MQPRIO (whether or not they are part =
of a bridge) implicitly inherit the global FPri to QPri mapping. I think =
that is  acceptable given that users should have no expectaitons about =
the default mapping, but others may disagree.

> The alternative is return -EOPNOTSUPP, and let the kernel do it in
> software, if a user wants something different to the global
> setting. The hardware is only there to accelerate what Linux can
> already do in software. That is the model we use.

Yes, this is how it is implemented.

Luke

