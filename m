Return-Path: <netdev+bounces-296731-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QIAdKBMzJ2r2tAIAu9opvQ
	(envelope-from <netdev+bounces-296731-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 23:24:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A00BB65AA8F
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 23:24:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=padl.com header.s=default header.b=GuN3h7UU;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296731-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296731-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=padl.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C2403031339
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 21:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6953A382F;
	Mon,  8 Jun 2026 21:22:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACFE3A3826;
	Mon,  8 Jun 2026 21:22:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780953774; cv=none; b=UDXoy9V8DV3M0tjTpnH7XQDcPcVZp0V/jzvGzlWu38WqVpPLcEJPIph9YvIX63bWhrNf7w+CZ509qYn/EcaEHz8Fr/Ahbo/LHRyhdhilLW9f6y5vDuBqiQVMU+wNw5nRuDaIYl1tcTBAbzquZBht77FES8bv1+pievAf8DyxMqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780953774; c=relaxed/simple;
	bh=8EIjrvUetgeNkzalIfRFNRue5/oVT2LXCEbrwIazQkg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Kt/65KNvYCyD9oz+n8j8tLRrWr3IaW+8jWstgzSczTBT8lFiaYNnAXk2LMUQtf5tzoQm6/UANfJpGqYxtRZJ2OLh8mXidbUaoD+dQP+dpOcARhiGTlxUgBToVP1kVU9usBAUkmx8fEyZaa9AFtTu8AFCt2yNzau0t48QkN9R/tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=GuN3h7UU; arc=none smtp.client-ip=216.154.215.154
Received: from smtpclient.apple (119-18-22-158.771216.mel.static.aussiebb.net [119.18.22.158])
	by us.padl.com (Postfix) with ESMTPSA id B842F60961;
	Mon,  8 Jun 2026 17:22:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1780953762; bh=8EIjrvUetgeNkzalIfRFNRue5/oVT2LXCEbrwIazQkg=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=GuN3h7UUAl/L/yJCtI+77MqQzOTSs+3WPPcM8hK0RFgBFvgQ+dbgxExqsxp3GBHUX
	 4xg1gE7svWnajYoSBYOb2Q23RBNVkrl8n8x1Bbs0hZ7pDSWTemgBYT4T1cpBNEPsgr
	 V9MDWFJA8NM6Xnrbm2IMXTvroRzb+X9fVQa1qYXs6xEPO2VZt9opMhdFf7yBD8yl3J
	 a17vMKb/EkKfx8hHrf3A5QHxMJADDs9CU1nBklLfDvjg04njwFxLZ30jTok9PEaerm
	 hv/Vj8EpjEVIzsz5rwjgtw5u/YN+OfkEF6/OaSpsO07ymp1w4ZSD8HhcCXVamERER7
	 N5uMPWZ2VqqXg==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH net-next 0/2] net: dsa: mv88e6xxx: add support for dcb pcp
 app
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <EA180F4E-7922-4A97-8912-E2D850E7F563@padl.com>
Date: Tue, 9 Jun 2026 07:22:22 +1000
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
Message-Id: <4BD5E3E3-DB11-489B-9B6C-14A93C406940@padl.com>
References: <20260604-net-next-mv88e6xxx-pcp-prio-v1-0-f9d10fe6cdc8@luminex.be>
 <EA180F4E-7922-4A97-8912-E2D850E7F563@padl.com>
To: cedric.jehasse@luminex.be
X-Mailer: Apple Mail (2.3826.700.81.1.4)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[padl.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[padl.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296731-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:cedric.jehasse@gmail.com,m:cedric.jehasse@luminex.be,m:cedricjehasse@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,padl.com:dkim,padl.com:email,padl.com:mid,padl.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A00BB65AA8F



> On 7 Jun 2026, at 13:12, Luke Howard <lukeh@padl.com> wrote:
>=20
>=20
>=20
>> On 4 Jun 2026, at 6:30=E2=80=AFpm, Cedric Jehasse via B4 Relay =
<devnull+cedric.jehasse.luminex.be@kernel.org> wrote:
>>=20
>> To me the dcb pcp app feels like the natural way to configure the pcp =
to QPri mappings in the switch.
>=20
> Revisiting this, I think the DCB PCP to PRIO mapping should instead =
configure the Port IEEE Priority Remapping registers (6352) or Ingress =
PCP mapping (6390). There=E2=80=99s nothing in dcb-app(8) that suggests =
to me that PRIO implies queue just because the PCP selector was used.

I=E2=80=99m wrong, DCB priorities are not PCP priorities, the closest =
analogue is QPri. Comment withdrawn.

Luke=

