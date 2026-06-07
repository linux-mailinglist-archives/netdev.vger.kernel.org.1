Return-Path: <netdev+bounces-296175-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id x98GFcDhJGrYAwIAu9opvQ
	(envelope-from <netdev+bounces-296175-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 05:13:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0BA64EBA3
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 05:13:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=padl.com header.s=default header.b=aWyuE36M;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296175-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296175-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=padl.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A565B300DA54
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 03:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8B2347BC1;
	Sun,  7 Jun 2026 03:12:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3655D343D64;
	Sun,  7 Jun 2026 03:12:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780801979; cv=none; b=ayTLg+XOsVklJDzPu/ZN6X5rfkNlCslKH97SJiUWBSAqXJxmczV/18/oaQ1GzAqaGmQIxbPyWiD3Zh87qmSEsLY7BBcvfrBmbtlGMO+FICEKjKjcKYBpI7pvqQMRVooBR9qod6a9l8tsPQ+/s1CBJ80IQPaDpkWY3Z+IRP/8D3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780801979; c=relaxed/simple;
	bh=SiCYoI5wk+Lxj9Sf2fcjaD8OVSPKZY9LJIduoW6yyl8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=VIJpU5MxlR6UqiIi4UevL10NXv+nTScT6V7bfLFUpZl1HWT21GF7XQxYOMAxqhCTk4RbpoxA3hJKPqzo/BYW6Yko4WVYdNmURt1YIpQsQMWoa+oVY4Aek8ZFXQs+ecmwjy3jwln/PisDAOAlZZseMCitKqZhca0ijg3p+7Q/9oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=aWyuE36M; arc=none smtp.client-ip=216.154.215.154
Received: from smtpclient.apple (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id 44ED76087D;
	Sat,  6 Jun 2026 23:12:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1780801976; bh=SiCYoI5wk+Lxj9Sf2fcjaD8OVSPKZY9LJIduoW6yyl8=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=aWyuE36MrbE0DjmlZh5SPz+ZT+GCrwPEPVD6UJObhTw/j4ERLjGJtt1Bjnh1jULrq
	 rM/3aQ2W1uvEMUpeW9iOZL3ufCfrA+SnfETtbUV4RhZTrWdFLypdV7LPCAlbtvXTb9
	 yop3zqXJRAVhRebRueKocXiGTVE40iFp5BExVf4WGD9R+tp6VdMc6KXOv+o8eV9g5m
	 Ui/0vKCQgHqam8EH2xjonYKyCZQxnMb7A0J00iXW8qIJlwDGCeg4KBNUkyoPy9l0eC
	 WgtZfSDTMH7PNy+EiUrThTguKzdM6v0yeT1FKGlkzA7IR4cTdAejWJL3CKpFUef6xg
	 /1WDdxySmg0PA==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH net-next 0/2] net: dsa: mv88e6xxx: add support for dcb pcp
 app
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <20260604-net-next-mv88e6xxx-pcp-prio-v1-0-f9d10fe6cdc8@luminex.be>
Date: Sun, 7 Jun 2026 13:12:41 +1000
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
Message-Id: <EA180F4E-7922-4A97-8912-E2D850E7F563@padl.com>
References: <20260604-net-next-mv88e6xxx-pcp-prio-v1-0-f9d10fe6cdc8@luminex.be>
To: cedric.jehasse@luminex.be
X-Mailer: Apple Mail (2.3826.700.81)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[padl.com,reject];
	R_DKIM_ALLOW(-0.20)[padl.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296175-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:cedric.jehasse@gmail.com,m:cedric.jehasse@luminex.be,m:cedricjehasse@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AC0BA64EBA3



> On 4 Jun 2026, at 6:30=E2=80=AFpm, Cedric Jehasse via B4 Relay =
<devnull+cedric.jehasse.luminex.be@kernel.org> wrote:
>=20
> To me the dcb pcp app feels like the natural way to configure the pcp =
to QPri mappings in the switch.

Revisiting this, I think the DCB PCP to PRIO mapping should instead =
configure the Port IEEE Priority Remapping registers (6352) or Ingress =
PCP mapping (6390). There=E2=80=99s nothing in dcb-app(8) that suggests =
to me that PRIO implies queue just because the PCP selector was used.

This is a bit unfortunate as configuring the PCP to QPri would be =
useful. But we could get the same end result by mapping to FPri and =
accepting the default FPri/QPri mapping.

(The 6352 data sheet is confusing when it refers to the IEEE-PRI =
register setting the =E2=80=9Cframe=E2=80=99s priority=E2=80=9D, but the =
width of the field implies it is indeed QPri.)

I do (now) agree that MQPRIO is not the place to configure this.

Luke=

