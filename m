Return-Path: <netdev+bounces-296166-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nypwADa1JGpc+gEAu9opvQ
	(envelope-from <netdev+bounces-296166-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 02:03:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 861E164E8B2
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 02:02:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=padl.com header.s=default header.b=VWXVQPtv;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296166-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-296166-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=padl.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E152D300F5C0
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 00:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3AF61FCE;
	Sun,  7 Jun 2026 00:02:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F003E256D;
	Sun,  7 Jun 2026 00:02:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780790576; cv=none; b=BhGu7mlVlF/OvklpeVOJ4FLcZHYWAaAUr/oZs9CBxploxopp4eGWnimTs5CS+eelPSRxa0uYdXtTJqDRsj84P/uH2KK+B52BSIXzsuothT7mFrvDLE4Pk07IUl/kWRbSDeCF1D7I7S4RPJf9GSz9UH8QDzqM7mJUDX+78MaJOrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780790576; c=relaxed/simple;
	bh=8hVkpC7bX4xMCmPcT0UthYQRtEB1BSpcwEOBuRelzb8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=PTIEGFmG6fgCTib1AawZ4QIcmVVJdDRcebVb1LHFB7eV1nlyzjNs6nMPTa+C6cSysr4K90MbabHgx8iupkbPufgM5+iv+g5WS15k6D7/38y6O48geEgQSY7dl4A8xUJs32ha6jAPuoGhJ+Jeek6mnC0lvfzIIW6cyg1rcDv8X1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=VWXVQPtv; arc=none smtp.client-ip=216.154.215.154
Received: from smtpclient.apple (119-18-22-158.771216.mel.static.aussiebb.net [119.18.22.158])
	by us.padl.com (Postfix) with ESMTPSA id 737086087D;
	Sat,  6 Jun 2026 20:02:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1780790571; bh=8hVkpC7bX4xMCmPcT0UthYQRtEB1BSpcwEOBuRelzb8=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=VWXVQPtvK2agwHU1t52PLHkKapCjGdjM54Ae2bIw1HIWYkpYv9u2o9chr1iqt3hjH
	 S1xRc4k52BwlDyBguEw7rPC6IYR3MPK/riOck1+X60Xa5fcf42PU3UDH10RAJNWfu8
	 kXRvGLXg+LZfZvwOP62aRVBZS50YpSHI7YAKg4LKsbMgiFs5fUSHhBx6owxScpIsqc
	 CaD9ahafkW86aPBUEQWzcdH9fzwRuVvSS6SQAv3Y8tWJ3NhcEBa3oNsaT97C4dNeL+
	 bYmEugDzZVAWQsV2grSnt66M/dfjf2D6RfUqhvOYbwqEHvLw3T5tZkFCpiGHECoE58
	 FVujk2R2DhfMg==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH net-next v2 3/6] net: bridge: add 802.1Qat stream
 reservation admission control
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <aiSbrmlOunfxwvGu@penguin>
Date: Sun, 7 Jun 2026 10:02:32 +1000
Cc: Andrew Lunn <andrew@lunn.ch>,
 Cedric Jehasse <cedric.jehasse@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Ivan Vecera <ivecera@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 David Ahern <dsahern@kernel.org>,
 Shuah Khan <shuah@kernel.org>,
 Vladimir Oltean <olteanv@gmail.com>,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 bridge@lists.linux.dev,
 linux-kselftest@vger.kernel.org,
 Max Hunter <max@huntershome.org>,
 Kieran Tyrrell <kieran@sienda.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0A7F24BE-2F75-4120-8615-758DA6F28D0C@padl.com>
References: <20260602-mv88e6xxx-8021qat-mqprio-v2-0-72be14522e7c@padl.com>
 <20260602-mv88e6xxx-8021qat-mqprio-v2-3-72be14522e7c@padl.com>
 <537410c3-ff4e-43fd-834e-775cd1bbe89e@blackwall.org>
 <E1253C6D-F6F0-407A-AABF-FCAB57100A1C@padl.com>
 <n2pi7h5nvxg3xvshtcxqeizpukp6hphqa7kodbe7b3ioc3kcq5@n34fgocvaicm>
 <d0e650fb-4011-4d64-9780-a0ddd0ca1cf3@lunn.ch>
 <CCF20D32-6C9F-49DC-9838-592EFB5E88D2@padl.com>
 <a63eed7d-b674-4830-a690-1b55dfdc9a72@blackwall.org>
 <77CCA8EB-145D-4B76-B6F4-9B775C361995@padl.com> <aiSbrmlOunfxwvGu@penguin>
To: Nikolay Aleksandrov <razor@blackwall.org>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[padl.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[padl.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296166-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:cedric.jehasse@gmail.com,m:jiri@resnulli.us,m:ivecera@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:idosch@nvidia.com,m:andrew+netdev@lunn.ch,m:dsahern@kernel.org,m:shuah@kernel.org,m:olteanv@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bridge@lists.linux.dev,m:linux-kselftest@vger.kernel.org,m:max@huntershome.org,m:kieran@sienda.com,m:razor@blackwall.org,m:cedricjehasse@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,resnulli.us,redhat.com,davemloft.net,google.com,kernel.org,nvidia.com,vger.kernel.org,lists.linux.dev,huntershome.org,sienda.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[padl.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,padl.com:mid,padl.com:from_mime,padl.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 861E164E8B2

Hi Nikolay,

> For the MDB to have a dynamic reservation entry means someone must've =
added it,
> these are not dynamically learned, so you can just as well build the =
table
> in a more appropriate place which can tag or filter the packet.

Fair enough, also a reasonable argument :) Without 802.1Q Dynamic =
Reservation Entries having first-class support in the MDB, I don=E2=80=99t=
 think there=E2=80=99s an abstraction that also maps well to the =
mv88e6xxx.

I=E2=80=99ll keep thinking about it, but for now this had probably best =
remain a local patch. [1] Thanks for taking the time to give feedback, I =
learned a lot.

Cheers,
Luke

[1] https://github.com/PADL/linux/tree/b4/mv88e6xxx-8021qat-mqprio=

