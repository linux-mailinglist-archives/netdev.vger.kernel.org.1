Return-Path: <netdev+bounces-296161-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7IrMABCWJGra8wEAu9opvQ
	(envelope-from <netdev+bounces-296161-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 23:50:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C28B64E6F5
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 23:50:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=temperror ("DNS error when getting key") header.d=padl.com header.s=default header.b=mbjMyF3y;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296161-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296161-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=temperror reason="SPF/DKIM temp error" header.from=padl.com (policy=temperror);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12885300E72F
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 21:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D6B3D25CB;
	Sat,  6 Jun 2026 21:50:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9CB24A05D;
	Sat,  6 Jun 2026 21:49:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780782600; cv=none; b=U7Yr229s78bkkUo5zzhjkz5lit+S5Vy0zXlX6Cg6BUpVd+TRx1KM4dwIgbt7vqsJkYcX9b4SqYxNZUK2WcoCLaAEvttk9F/iFnihOpHI2xbpoevF5cpGbwXTIjeGoI1yIkBp1t/cJ3MYsFTcNMpKRiACIyMilfORsbIE8itjvnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780782600; c=relaxed/simple;
	bh=kH5GmUToAQsCMzn7xCEan3Jr1hpM1EsUkr9u9YaFl0M=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=rUqA0xzLcCUK/0p6zSxHReV2sxC2uG413cseOwJY7a+Op6Bqm21IpKlfUxnFb5K6T3Kf2T7ylI+RSEWHJolX1ZMNEzsBsh1+l0hFGkoT2r28AxG87bsOZ6a4oVQ2NMTgzoyLFWcArGarxADlCON09IjEX28P5Dcq3IceNxp/WOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=mbjMyF3y; arc=none smtp.client-ip=216.154.215.154
Received: from smtpclient.apple (119-18-22-158.771216.mel.static.aussiebb.net [119.18.22.158])
	by us.padl.com (Postfix) with ESMTPSA id 7472E6087D;
	Sat,  6 Jun 2026 17:49:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1780782590; bh=an/MtvlsiwLyCHyABUS6ubjscBO1uA5s1tL3O5ntGDQ=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=mbjMyF3yQ4WxkFozgne07Bh1Pf/rPOy7p3+5wh57ELRXl2Rt8mVqnRZH07SIukO83
	 lLwni9P7jK9t+Imwa8Cn9ZWzhQlNfnbZL2azTR/+ZrYgZd6J/o6Mps11bB6+DOtuIa
	 1FPnSndTUkQ6vE9x4pCtdeCdfvDNFALAkgSvL09rkOF6CuS7849ABlomenzcU4NN9m
	 bmaCjtxFBr19fPA8s4jIAocQc67wzhi8jx1icW2Iv/ouH84YtlDzgvGWtvx7DhwIqx
	 iot0EhCgG305s+xLG1xiE6G4MpAxsMlALY7fwXPtBAXJv3dZPZUgHqvn5ci2mIeaJQ
	 gBhN0Ppf0OTQg==
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
In-Reply-To: <a63eed7d-b674-4830-a690-1b55dfdc9a72@blackwall.org>
Date: Sun, 7 Jun 2026 07:49:26 +1000
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
Message-Id: <77CCA8EB-145D-4B76-B6F4-9B775C361995@padl.com>
References: <20260602-mv88e6xxx-8021qat-mqprio-v2-0-72be14522e7c@padl.com>
 <20260602-mv88e6xxx-8021qat-mqprio-v2-3-72be14522e7c@padl.com>
 <537410c3-ff4e-43fd-834e-775cd1bbe89e@blackwall.org>
 <E1253C6D-F6F0-407A-AABF-FCAB57100A1C@padl.com>
 <n2pi7h5nvxg3xvshtcxqeizpukp6hphqa7kodbe7b3ioc3kcq5@n34fgocvaicm>
 <d0e650fb-4011-4d64-9780-a0ddd0ca1cf3@lunn.ch>
 <CCF20D32-6C9F-49DC-9838-592EFB5E88D2@padl.com>
 <a63eed7d-b674-4830-a690-1b55dfdc9a72@blackwall.org>
To: Nikolay Aleksandrov <razor@blackwall.org>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-296161-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,resnulli.us,redhat.com,davemloft.net,google.com,kernel.org,nvidia.com,vger.kernel.org,lists.linux.dev,huntershome.org,sienda.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:cedric.jehasse@gmail.com,m:jiri@resnulli.us,m:ivecera@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:idosch@nvidia.com,m:andrew+netdev@lunn.ch,m:dsahern@kernel.org,m:shuah@kernel.org,m:olteanv@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bridge@lists.linux.dev,m:linux-kselftest@vger.kernel.org,m:max@huntershome.org,m:kieran@sienda.com,m:razor@blackwall.org,m:cedricjehasse@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[padl.com:?];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DMARC_DNSFAIL(0.00)[padl.com : SPF/DKIM temp error,reject];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_DKIM_TEMPFAIL(0.00)[padl.com:s=default];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,padl.com:from_mime,padl.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5C28B64E6F5



> On 6 Jun 2026, at 6:21=E2=80=AFpm, Nikolay Aleksandrov =
<razor@blackwall.org> wrote:
>=20
> On 06/06/2026 11:02, Luke Howard wrote:
>> The definition of Dynamic Reservation Entries in 802.1Q (clause =
8.8.7) might support the addition of a new MDB (or even FDB) entry state =
to the kernel:
>> - add MDB_DYNAMIC_RESERVATION (a state, not a flag);
>> - the software bridge only _classifies_ packets against  =
MDB_DYNAMIC_RESERVATION entries, and only when MDB is authoritative. =
Classification sets dynamic_reservation_hit on tc_skb_ext;
>> - dynamic_reservation_hit is visible to the flow dissector so can be =
used for policy enforcement.
>=20
> See, saying the bridge has to classify doesn't sound right. Why not do =
the
> classification where such operations are usually done, e.g. tc?
> You have to manually designate these entries anyway.

s/classify/mark, i.e. marking a forwarding bit for tc to match, a la =
l2_miss.

tc can=E2=80=99t see into the MDB to tell if a DA has a dynamic =
reservation entry so, without an explicit DRE bit, the SRP daemon would =
need to maintain a flower permit filter per DRE. Not needing this allows =
the user to set a single policy filter prior to starting SRP, e.g.:

tc filter add dev lan0 egress protocol 802.1Q pref 1 handle 1 flower =
vlan_prio 3 dynamic_reservation_hit 0 action drop

It also maps cleanly to chips that support 802.1Qav with priority =
regeneration or filtering, but which can=E2=80=99t support tc-flower.=

