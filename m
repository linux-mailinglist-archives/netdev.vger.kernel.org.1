Return-Path: <netdev+bounces-295177-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9/wrI0RWIWpoEAEAu9opvQ
	(envelope-from <netdev+bounces-295177-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 12:41:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4791B63F21D
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 12:41:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=padl.com header.s=default header.b=c4JEmpOd;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295177-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295177-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=padl.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A5F43037ED0
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 10:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2208D3BADB3;
	Thu,  4 Jun 2026 10:37:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BAA3542D1;
	Thu,  4 Jun 2026 10:37:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780569459; cv=none; b=tUqkX8xYbjIWGmBi8Kii8j4CUGbytGCNZa93N/fZYOhDX8HbRykPf/Doy6IJ+xO4dt1dQGwlUlnBUKN/bg0wvvjCmHdGPyyi9cddxZ7CqUFLpq9FgqYluKB6U0nGkdSkgbtso3v6Z6zyPv0tkFVG9I9VCU1Zj15o2MPKC3C9pn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780569459; c=relaxed/simple;
	bh=xBdOVJi2ZWjXtAvFskpGT4bQJfPgetQIH36aB7GNwAI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=bLdXNvUb6yRGxqpmhiEJg1vMVanprBV8Gw7pRVy3ktBj2maTrP0Yzmu2fdO29b+lzerWOrAxBsM3VlmSPWWCbjk56H3Dy1T8PuJC74IzX1reXvr9WvjyzY8HBLVXc6Xai4lNjErcdkTJX7u+MiRtUs0YXHrA5RgrUklZhbUSrLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=c4JEmpOd; arc=none smtp.client-ip=216.154.215.154
Received: from smtpclient.apple (119-18-22-158.771216.mel.static.aussiebb.net [119.18.22.158])
	by us.padl.com (Postfix) with ESMTPSA id CAF0260C6D;
	Thu,  4 Jun 2026 06:37:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1780569453; bh=xBdOVJi2ZWjXtAvFskpGT4bQJfPgetQIH36aB7GNwAI=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=c4JEmpOd38gqv+fSNBwepO6gGvuuPWFdmWOR8q4NScYyUFRChT+Fvz/fcA5+0UEzO
	 MWPogEhDpkUTbuR8/rPv2uhjdYf5ExYjt3RyPr2nZAACpMaWqFFr1wFHeCC6fF3eYd
	 0LTLs6CwYZ6NsmMueG0uiPECFGrUzuFrxyFfjc6tI8r41cNH19DAN6926mZhTZ2BgX
	 JZg5O1NWMC7ohnNbS4GAqGtxcFIm5V4yrDuexp9qh1ay6W8n3BtxOVepTHUt97+kPJ
	 44bp9RWXaMrq7MwSM42KtLjRHyYOZwQOGDvD3hBn3n+lmca4/cF164sLLwBhV8Z+nf
	 zQsLOhfidfGWg==
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
In-Reply-To: <20260604-net-next-mv88e6xxx-pcp-prio-v1-0-f9d10fe6cdc8@luminex.be>
Date: Thu, 4 Jun 2026 20:37:17 +1000
Cc: Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Cedric Jehasse <cedric.jehasse@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <02BDD59A-30A9-46F9-8413-28A867B50CD5@padl.com>
References: <20260604-net-next-mv88e6xxx-pcp-prio-v1-0-f9d10fe6cdc8@luminex.be>
To: cedric.jehasse@luminex.be
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
	TAGGED_FROM(0.00)[bounces-295177-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:cedric.jehasse@gmail.com,m:cedric.jehasse@luminex.be,m:cedricjehasse@gmail.com,s:lists@lfdr.de];
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
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4791B63F21D



> On 4 Jun 2026, at 6:30=E2=80=AFpm, Cedric Jehasse via B4 Relay =
<devnull+cedric.jehasse.luminex.be@kernel.org> wrote:
>=20
> There's another patch series [1] on the mailing list that uses the =
same
> IEEE PRI Mapping table to implement MPQRIO. To me the dcb pcp app =
feels
> like the natural way to configure the pcp to QPri mappings in the
> switch

I=E2=80=99m not familiar with the API or user tools, but the fact it =
supports both global and ingress mappings makes it seem like a better =
option, agreed.

It seems like we maybe could support MQPRIO properly with TCAM but =
perhaps that isn=E2=80=99t really necessary (certainly not for my =
all-ports-in-bridge use case, where there isn=E2=80=99t a distinction =
between ingress and egress priority mappings).

I still need to find a similarly natural way to expose the switch=E2=80=99=
s AVB capabilities / 802.1Qat admission control. Perhaps there is none =
and it will need to remain a local patch.=

