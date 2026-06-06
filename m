Return-Path: <netdev+bounces-296076-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8tKJLjPUI2rvzQEAu9opvQ
	(envelope-from <netdev+bounces-296076-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 10:02:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DDE764CE22
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 10:02:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=padl.com header.s=default header.b="F75/otmZ";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296076-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296076-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=padl.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23E0530238F0
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 08:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C77330BF67;
	Sat,  6 Jun 2026 08:02:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93A826ED5D;
	Sat,  6 Jun 2026 08:02:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780732964; cv=none; b=YtWC80nF6HXHuEDBo12H55LDE7W7zIHApScIATt/wxchAHYK6YV5gEkjeS7CMls31fInuEt7EClx45tpEyF6C/aDHzTEO3kj95VSS5gDh9bDEgnLf+y3uBJDuf74GN3yQr+K2e+pmfFKz2WEeffMT5TvdD5syf6kL9yYt5S1m6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780732964; c=relaxed/simple;
	bh=95/Bc8g7qS6AmG65Mi9qNIx2fcFhFDs2MrupCjJhEWw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=jtDXWKi+ZPENTpo22rjeeouEBZKnPk9jynYnQ8vEzYsJWL1y7NPnpHBGs7Gh5yeCG2DeD0W0RmAe+viLBNdCeatT9sq9iMj3S+xyEXujt3YaIO3ma1euhXipDjjrG0ChNXfrULk7MsPm8VH59iABEVFOiv8CCcHSPCBvD1MHsjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=F75/otmZ; arc=none smtp.client-ip=216.154.215.154
Received: from smtpclient.apple (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id 3EA6D62226;
	Sat,  6 Jun 2026 04:02:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1780732961; bh=C6knqyYtwWysw/J/UjxZx6ooyQA0Q9w3FH7GFrPkXpU=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=F75/otmZ69bK9Ai62vs7YMDminLgns083w1PKEkqL6BgWthAVQoOxSO7uUnhNsAbh
	 SK0e0Dsp427FJjWJnPDYuvLH1J9RHDzHGCJ95Nb5jqpOJQIfBaLxnRZSdP68P1xUHY
	 O1vzG1MJd9gdMjrxk2fveu+H/PF2VJdf+zNsipZsb20J31tESJa6+vyZuU84mNju0s
	 KjjrYO/dCuD79XFdbrzGHDSZuDTeZ/hCGMDeuR/iHjXtjjssQupuN2+nt/U0LTa61z
	 GO2tGIOuH+d7WpK+UxOhJf45nOR7IcNIwX6fOH1vpOCFtLV9DHfYUG9dscKvBjqGZS
	 jrqtVjul/VCEA==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH net-next v2 3/6] net: bridge: add 802.1Qat stream
 reservation admission control
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <d0e650fb-4011-4d64-9780-a0ddd0ca1cf3@lunn.ch>
Date: Sat, 6 Jun 2026 18:02:24 +1000
Cc: Cedric Jehasse <cedric.jehasse@gmail.com>,
 Nikolay Aleksandrov <razor@blackwall.org>,
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
Message-Id: <CCF20D32-6C9F-49DC-9838-592EFB5E88D2@padl.com>
References: <20260602-mv88e6xxx-8021qat-mqprio-v2-0-72be14522e7c@padl.com>
 <20260602-mv88e6xxx-8021qat-mqprio-v2-3-72be14522e7c@padl.com>
 <537410c3-ff4e-43fd-834e-775cd1bbe89e@blackwall.org>
 <E1253C6D-F6F0-407A-AABF-FCAB57100A1C@padl.com>
 <n2pi7h5nvxg3xvshtcxqeizpukp6hphqa7kodbe7b3ioc3kcq5@n34fgocvaicm>
 <d0e650fb-4011-4d64-9780-a0ddd0ca1cf3@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
X-Mailer: Apple Mail (2.3826.700.81)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[padl.com,reject];
	R_DKIM_ALLOW(-0.20)[padl.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296076-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:cedric.jehasse@gmail.com,m:razor@blackwall.org,m:jiri@resnulli.us,m:ivecera@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:idosch@nvidia.com,m:andrew+netdev@lunn.ch,m:dsahern@kernel.org,m:shuah@kernel.org,m:olteanv@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bridge@lists.linux.dev,m:linux-kselftest@vger.kernel.org,m:max@huntershome.org,m:kieran@sienda.com,m:andrew@lunn.ch,m:cedricjehasse@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[gmail.com,blackwall.org,resnulli.us,redhat.com,davemloft.net,google.com,kernel.org,nvidia.com,lunn.ch,vger.kernel.org,lists.linux.dev,huntershome.org,sienda.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
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
	APPLE_MAILER_COMMON(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,padl.com:mid,padl.com:from_mime,padl.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2DDE764CE22


> So it sounds like you first need to work on the software
> implementation and expand the simplified version with the features you
> need. You can then add support to accelerate this by offloading it to
> the hardware.

Agreed.

The definition of Dynamic Reservation Entries in 802.1Q (clause 8.8.7) =
might support the addition of a new MDB (or even FDB) entry state to the =
kernel:

- add MDB_DYNAMIC_RESERVATION (a state, not a flag);
- the software bridge only _classifies_ packets against  =
MDB_DYNAMIC_RESERVATION entries, and only when MDB is authoritative. =
Classification sets dynamic_reservation_hit on tc_skb_ext;
- dynamic_reservation_hit is visible to the flow dissector so can be =
used for policy enforcement.

Advantages:

- the new MDB state maps well to 802.1Q;
- minimal changes to bridge;
- actual policy (reclassify, drop, etc) is left to the user;
- doesn=E2=80=99t require a new tc-flower entry for each stream DA;
- entry state maps 1:1 to mv88e6xxx AVB_NRL ATU EntryState.

Disadvantages:

- no unicast support, although potentially can be extended (there are =
some subtleties);
- mv88e6xxx support would either require rich enough tc-flower support =
in TCAM, intercepting TCA_FLOWER_DYNAMIC_RESERVATION_HIT and mapping to =
native AVB admission control, or a per-port devlink parameter (not so =
nice).

This is implemented and working with the software bridge, I still =
haven=E2=80=99t quite figured out the right mapping for mv88e6xxx.

Luke

PS. I previously incorrectly asserted that 802.1Q required dropping =
frames with AVB/SRP PCPs but without valid dynamic reservation entries. =
802.1Q discussions priority mapping in clause 6.9.4 for traffic from SRP =
boundary ports (those not participating in SRP). In practice I think =
this should all be policy, e.g. you might want to reprioritise valid =
DSCP traffic from within a SRP domain, or drop instead of reprioritise, =
etc.=

