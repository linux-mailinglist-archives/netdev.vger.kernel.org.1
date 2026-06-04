Return-Path: <netdev+bounces-295467-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2kcJA6UBImoHRgEAu9opvQ
	(envelope-from <netdev+bounces-295467-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 00:52:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C2D643DEC
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 00:52:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=padl.com header.s=default header.b=kTYAXuMs;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295467-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-295467-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=padl.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 016663015AA1
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 22:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57FE30D3EA;
	Thu,  4 Jun 2026 22:52:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CC72EA171;
	Thu,  4 Jun 2026 22:52:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780613534; cv=none; b=V40JZE6Fn7rpJNsV/alckPtfPWozYvJqfLqknPisEQedfJoWwWEJoRwvSI2PXP5fAUFIuTGkPbmGjoJAiLECQ4pf5BNEZWHG0wd69SMhqK+z9KKFi7fCqbXcrqm7j7o7gUrXtr6f766uTk7NTrQpSpOrrCxl8a4cK3IU1yBJ9dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780613534; c=relaxed/simple;
	bh=OEm1hdLn46Ff+W5Kx9p8C2M4P47h2b5Qaf5LFifR0nc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ba5wgFlhgItI+r5U/PNxIwAZWM+nIObe+ZmlMZ6UdglvKc5ijUQ/TLcb11b8Uqdqj1NXVfHnHGCBj4uFAelEJUd3SEqk5TJt76mKXVUzvIm8xOR2LGh7DxXdFvBYZ0z09BqyigVthfBfVDYhfON8VOhy2BkjKpNcCzK9Js7DnPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=kTYAXuMs; arc=none smtp.client-ip=216.154.215.154
Received: from smtpclient.apple (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id D2DF960C6D;
	Thu,  4 Jun 2026 18:52:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1780613531; bh=HMJb5ahSNURO+v12SkoNhUjqk5ykiyADfmMXFoQmvOk=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=kTYAXuMsJ6t6QzFi2meSE+6bqSyaFb/75Y+b88APEz4vv44dLQwNzsNYh3DcvBhRu
	 OTcv35sQ2DAplU9HFIv91FrJGRa1Yomw5bXN3Am8cQON3MHIxlu543rHXl54dEGTy5
	 zICOuA6uKmoqC9Mo2s2lA65MGHj106d7g9Tmmn79vpefGh8kuqgvbjcHmaxAb1ouBP
	 pE2SvfdAKnEzbxsHRAmhILnIl9aHnM2n/PKkVtWNCQamS0t4oIPT0rrXrlptT1HoYJ
	 QfS57Fo9uWz/ZBvt8R10Aqnaf6ntUh7oJClU66er/J9MX+eQ3HzagtiClq0V6nWKM8
	 uGElNrxIlm+SQ==
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
In-Reply-To: <v4fqikeec52ginmogfvsfe5gobul2nqspe2ebzpzpja52lxacb@wq2elxqwrucf>
Date: Fri, 5 Jun 2026 08:51:56 +1000
Cc: cedric.jehasse@luminex.be,
 Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E43832AD-0F8A-465F-95E3-2AF5E72FB7B9@padl.com>
References: <20260604-net-next-mv88e6xxx-pcp-prio-v1-0-f9d10fe6cdc8@luminex.be>
 <02BDD59A-30A9-46F9-8413-28A867B50CD5@padl.com>
 <v4fqikeec52ginmogfvsfe5gobul2nqspe2ebzpzpja52lxacb@wq2elxqwrucf>
To: Cedric Jehasse <cedric.jehasse@gmail.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[padl.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[padl.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-295467-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:cedric.jehasse@luminex.be,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:cedric.jehasse@gmail.com,m:cedricjehasse@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[luminex.be,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[padl.com:mid,padl.com:from_mime,padl.com:dkim,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C6C2D643DEC

Hi Cedric,

> On 4 Jun 2026, at 10:01=E2=80=AFpm, Cedric Jehasse =
<cedric.jehasse@gmail.com> wrote:
>=20
> On Thu, Jun 04, 2026 at 08:37:17PM +1000, Luke Howard wrote:
>> I still need to find a similarly natural way to expose the switch=E2=80=
=99s AVB capabilities / 802.1Qat admission control. Perhaps there is =
none and it will need to remain a local patch.
>=20
> There's a devlink port param command. I've been wondering if this =
could be used
> to set a port's AvbMode. However:
> * at the moment there are no drivers supporting this.
>  eg. devlink_nl_port_param_set_doit and other return this isn't =
supported
> * i don't know if AvbMode is a valid use for devlink port param, and =
if it
>  would get accepted

mv88e6xxx already exposes the ATU_hash driver-specific devlink =
parameter, so there is a precedent which augurs well.

A per-port AVB mode devlink could configure:

- AVB mode to enhanced
- iso ptrs to number of enabled ports * N (currently we use N=3D64)
- enabling interpreting AVB_NRL entries as AVB with G1_ATU_CTL_MAC_AVB

The leaves two issues:

- if at least one port has AVB mode set, we could install permanent MDB =
entries as AVB_NRL. But here we have the old problem, that AVB mode is =
on the ingress port, whereas MDB entries are on the egress port.
- also the AVB FPri and QPri values would need to be configured, either =
via another devlink parameter or MQPRIO

This approach would integrate well with your CBS and DCB patches. Having =
said that, AVB mode could likely be reimplemented with TCAM, and =
(assuming an SRP daemon that knew how to install those flower entries) =
that might be a more portable and idiomatic solution. I am not sure how =
it would perform compared to the native AVB admission control in the =
switch.

Luke=

