Return-Path: <netdev+bounces-294511-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7CogH+iHH2qHmwAAu9opvQ
	(envelope-from <netdev+bounces-294511-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 03:48:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D36E0633850
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 03:48:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=padl.com header.s=default header.b=HZYcnj18;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294511-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294511-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=padl.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27B0B305A8D2
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 01:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B8D37F013;
	Wed,  3 Jun 2026 01:41:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868B437E319;
	Wed,  3 Jun 2026 01:41:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780450896; cv=none; b=mhav45RB047tPlkJGjxn1juDzOWAss8bnd6wc5gzMvDifid9w+xDykEzd1ZKgJyFNGdAEtwe+41Ggl20osWauoRaCqLWro2+mHsFR/yJB/ion33DMuljnKMdp2BPT0rltZbtI0u4R/taK9KRx2YNExQLxzV3cxaar38yEIEVjRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780450896; c=relaxed/simple;
	bh=antjUfKm4W1pYTqXE3aEg6NNOtkzJSasuEtZZhVeWPo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=f0uoNX9SG7AZGQ5yBwo5CCpm5gE7sIMVUqvnsWi5UDksgxMIqSpl2SWky8H4dKQ8BkAmv2MzthAGjAO3+VFhQ9I2KCZME7U6Jibz+SsBgvbB2/S3CvGHSIEtLJ0M12gTus4bS5/OrMe8au+TZovmPvWON+Cl4vIaVDdhXeKHuoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=HZYcnj18; arc=none smtp.client-ip=216.154.215.154
Received: from auth (localhost [127.0.0.1]) by us.padl.com (8.14.7/8.14.7) with ESMTP id 6531ejR5029996
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 3 Jun 2026 02:40:48 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 6531ejR5029996
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1780450862; bh=antjUfKm4W1pYTqXE3aEg6NNOtkzJSasuEtZZhVeWPo=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=HZYcnj18IitgOS7y9h3kj9PC7MkBsLr0ZomZLhWAz6cVgJAEBnvbPmmhk/86wwVZ/
	 fhbmfhGqW9Ivv20UURwfmRjBkrlTvzmEsQPvws7Vv1WeWXVfnF1qbfow2nr/TjiLWo
	 REhTyfcWjq+1dZA7TI6viZfkcojvQiXaXlkKIqpRWZnvsQqrWxp7rFjJFxCjyQxK8/
	 SNAx9/AWWsgR8nI0jHJNBVA4lP155dM8eqOJGp6ZZCUCHsPddHwgwckc30IUrhHrLb
	 nGUAEwZL91Ic69VLMzokm1Y8lL5AuRW+YIiUYzyThIgudVoOsPdHymkJo63BOODK9v
	 +Z/Z7+fiMAF8g==
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
In-Reply-To: <0402DFFF-634A-40C4-BC1E-B038F20926FF@padl.com>
Date: Wed, 3 Jun 2026 11:40:35 +1000
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
Message-Id: <89BA4203-110E-4767-895C-A2808602FAF8@padl.com>
References: <20260602-mv88e6xxx-8021qat-mqprio-v2-0-72be14522e7c@padl.com>
 <20260602-mv88e6xxx-8021qat-mqprio-v2-5-72be14522e7c@padl.com>
 <t44kmhk6gqxnwhdvo7svouexwelwsya7zgukpbv3cxpfsmutqa@y3rjoj3tvqce>
 <A662D3F9-18DD-43C9-A43D-912E5A8A4360@padl.com>
 <8C6AD966-2C28-4BEF-95C4-1B2AC3751513@padl.com>
 <29c09316-c911-456e-acc5-e18402da4bd4@lunn.ch>
 <0402DFFF-634A-40C4-BC1E-B038F20926FF@padl.com>
To: Andrew Lunn <andrew@lunn.ch>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[padl.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[padl.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294511-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:cedric.jehasse@gmail.com,m:jiri@resnulli.us,m:ivecera@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:razor@blackwall.org,m:idosch@nvidia.com,m:andrew+netdev@lunn.ch,m:dsahern@kernel.org,m:shuah@kernel.org,m:olteanv@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bridge@lists.linux.dev,m:linux-kselftest@vger.kernel.org,m:max@huntershome.org,m:kieran@sienda.com,m:andrew@lunn.ch,m:cedricjehasse@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,resnulli.us,redhat.com,davemloft.net,google.com,kernel.org,blackwall.org,nvidia.com,lunn.ch,vger.kernel.org,lists.linux.dev,huntershome.org,sienda.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[padl.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D36E0633850


> On 3 Jun 2026, at 10:15=E2=80=AFam, Luke Howard <lukeh@padl.com> =
wrote:
>=20
>> On 3 Jun 2026, at 9:55=E2=80=AFam, Andrew Lunn <andrew@lunn.ch> =
wrote:
>>=20
>>> But there=E2=80=99s an alternative, more invasive, solution where =
the MQPRIO
>>> configuration is attached to the bridge itself.
>>=20
>> What about ports which are not attached to a bridge? They are just
>> standalone, have an IP address of their own, etc.
>=20
> That is a good point. So, barring a switch feature I=E2=80=99ve not =
yet found, I think the only options are either to drop MQPRIO offload, =
or to accept that ports with no MQPRIO mapping inherit the per-switch =
mapping. Arguably that=E2=80=99s the case today anyway (each chip has =
its own default frame priority to queue mapping), so the user should =
have no expectation of queue assignment on a port that hasn=E2=80=99t =
been configured.

We could add (e.g.) bridge_setup_tc to dsa_switch_ops, which (in the =
mv88e6xxx implementation) could validate the bridge contained all user =
ports. But it would not be possible to block a port from leaving as =
port_bridge_leave cannot return an error, and tearing MQPRIO config down =
silently would be a different sort of bad.=

