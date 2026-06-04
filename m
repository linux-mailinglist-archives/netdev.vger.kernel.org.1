Return-Path: <netdev+bounces-295446-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NpiMEXj+IWqaRQEAu9opvQ
	(envelope-from <netdev+bounces-295446-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 00:38:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F7A643D30
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 00:38:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=padl.com header.s=default header.b=glT+AJxW;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295446-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295446-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=padl.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EBB243047416
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 22:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9F5331209;
	Thu,  4 Jun 2026 22:35:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5F53264E9;
	Thu,  4 Jun 2026 22:35:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780612537; cv=none; b=Slh2+V39zzD6dXIaVj8dHfjxDb6LwqOEZJWnZpo056WqqQmNkw7GSuQH9JMwS4p7Im2guPwaEKbyZdfU3ezUSCX1TzJezqk7BqJ0j5bp9GTNdMnlQpK343XdXudVRjy3xI/SnOaPE7X2Hrnv8+9J7SY7bLe1Ku5I6suglCXbrIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780612537; c=relaxed/simple;
	bh=ciZzg09MAAvt+vyghwNT92rYo/+tPywPbXDM8F4zh5U=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=E06f95InlAGiPFU2czKi+oBFqchfRIxE82QayooH9V4oVwEjADNziml4ZDsgVx/k79mzrvl3XhKK3RqGMQc8jKz7zNmQPBcSbGSB4hVnGzDdcmEdbDNJb+19rf0kykGw7hpVtfcvf1qtlfcBphXGJewNRh2X/U3cd7Mci+dXe54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=glT+AJxW; arc=none smtp.client-ip=216.154.215.154
Received: from smtpclient.apple (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id 2035D60C6D;
	Thu,  4 Jun 2026 18:35:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1780612535; bh=sH+qURpHn4C/SMC8gzzMSu1/+Xp+M0GnEEang0MI7Xs=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=glT+AJxWwpTy5Pb05ULm22g738tIgNUNEDcflmpD0NGTfLJFYmxogXhN7g7WqfWdM
	 77PYRiqKaJ35POEAnPXhAse7uuw9yCweoSUi0+eYDe6kh+UQHeo5uStIpsEd60FGxF
	 wUthPRhGhB1CN7cgVFB8RLScsHEJ97yK5N0h0FR7+5hDBPTHAw8SoN+Obf5rIIqIPG
	 qHiWp/kgINlpkoU3nAHi9D1SoBDyqTMjbdViWHpn1LeosEzX3VqKBtivgE2t+DvTQt
	 V3tLUev9Hg05LfsPzM69GRxq4McG5iGMqQKlJM55sRoFreroxtVoxNZUUf0cRANC9I
	 2pqPDY/QFTL0A==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH net-next v6 1/2] net: dsa: mv88e6xxx: use the hw tx queues
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <20260604-net-next-mv88e6xxx-cbs-v6-1-b68c01142d1e@luminex.be>
Date: Fri, 5 Jun 2026 08:35:21 +1000
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
 =?utf-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Cedric Jehasse <cedric.jehasse@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D247F38C-8606-4648-8EB9-EFB42772B0EA@padl.com>
References: <20260604-net-next-mv88e6xxx-cbs-v6-0-b68c01142d1e@luminex.be>
 <20260604-net-next-mv88e6xxx-cbs-v6-1-b68c01142d1e@luminex.be>
To: cedric.jehasse@luminex.be
X-Mailer: Apple Mail (2.3826.700.81)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[padl.com,reject];
	R_DKIM_ALLOW(-0.20)[padl.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295446-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kabel@kernel.org,m:cedric.jehasse@gmail.com,m:cedric.jehasse@luminex.be,m:cedricjehasse@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,padl.com:mid,padl.com:dkim,padl.com:from_mime,padl.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 93F7A643D30



> On 4 Jun 2026, at 11:44=E2=80=AFpm, Cedric Jehasse via B4 Relay =
<devnull+cedric.jehasse.luminex.be@kernel.org> wrote:
>=20
> From: Cedric Jehasse <cedric.jehasse@luminex.be>
>=20
> When transmitting fill in the PRI field in the dsa tag to select the
> egress queue is sent to.
> =46rom the datasheets i've looked at these switches have 4 or 8 =
transmit
> queues per port.
> Note: skbs with skb->fw_offload_fwd_mark set use the DSA_CMD_FORWARD
> tag. These are processed as normal ingress frames, meaning the queue
> they end up in can still be altered by other switch config. eg. =
priority
> overrides, tcam policies.
> This isn't done for vlan tagged frames because this would overwrite =
the
> PCP value in the vlan tag (The PRI field in the dsa
> tag is used as the PCP value in the vlan tag).
>=20
> Signed-off-by: Cedric Jehasse <cedric.jehasse@luminex.be>
> ---
> drivers/net/dsa/mv88e6xxx/chip.c | 35 =
+++++++++++++++++++++++++++++++++++
> drivers/net/dsa/mv88e6xxx/chip.h |  1 +
> net/dsa/tag_dsa.c                | 11 ++++++++++-
> 3 files changed, 46 insertions(+), 1 deletion(-)

Reviewed-by: Luke Howard <lukeh@padl.com>


