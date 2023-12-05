Return-Path: <netdev+bounces-54150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6995806188
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 23:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C9251F2155C
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 22:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D59D6E2C3;
	Tue,  5 Dec 2023 22:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embedd.com header.i=@embedd.com header.b="zEZIocHb";
	dkim=pass (1024-bit key) header.d=embedd.com header.i=@embedd.com header.b="Y+QIj6nA"
X-Original-To: netdev@vger.kernel.org
Received: from mail.as201155.net (mail.as201155.net [185.84.6.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721D21B5
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 14:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=embedd.com;
	s=dkim1; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=BvcoJcG4CZKF4cdKSJfgMlbU7qClM1U2uu51lNz6aho=; b=zEZIocHbl81wOfzMAwaScIyQzq
	/IdsGf6n/tpTyCTfi7KUzF3kTI8S8AXZ8oLhn8xnGmdcB0sKNzgh69tkgWa7wcpgWn8V7LnE+318q
	n/RV13BEkPlUpt+W2d/9xoFdBZVhFlkeF68VfTS6Ot62A8j2dxw9YP8Xkws5+ssdshjT+/6sNxMvm
	umVSmvtNlE5GsGbePWGkiMEabKord99BC83vx3zqJHs4UvXlZUz1PBQAZ0xxED/T2ve1n0Y8aZ8V2
	jQFsdgS2K7ZHHgm7R83XDxGhH9CJ4nVVp6qHZk040/Y576BbPXqe8GMCTUHLwQ7l2VP5d3pEAWJ8f
	HrBMS0tw==;
Received: from smtps.newmedia-net.de ([2a05:a1c0:0:de::167]:43068 helo=webmail.newmedia-net.de)
	by mail.as201155.net with esmtps  (TLS1) tls TLS_RSA_WITH_AES_256_CBC_SHA
	(Exim 4.96)
	(envelope-from <dd@embedd.com>)
	id 1rAdiG-0000eM-1i;
	Tue, 05 Dec 2023 23:16:20 +0100
X-SASI-Hits: BODY_SIZE_3000_3999 0.000000, BODY_SIZE_5000_LESS 0.000000,
	BODY_SIZE_7000_LESS 0.000000, CTE_QUOTED_PRINTABLE 0.000000,
	CT_TEXT_PLAIN_UTF8_CAPS 0.000000, DKIM_ALIGNS 0.000000,
	DKIM_SIGNATURE 0.000000, HTML_00_01 0.050000, HTML_00_10 0.050000,
	IN_REP_TO 0.000000, LEGITIMATE_SIGNS 0.000000, MSG_THREAD 0.000000,
	MULTIPLE_RCPTS 0.100000, MULTIPLE_REAL_RCPTS 0.000000, NO_CTA_FOUND 0.000000,
	NO_CTA_URI_FOUND 0.000000, NO_FUR_HEADER 0.000000, NO_URI_HTTPS 0.000000,
	OUTBOUND 0.000000, OUTBOUND_SOPHOS 0.000000, REFERENCES 0.000000,
	RETURN_RECEIPT 0.500000, SENDER_NO_AUTH 0.000000, SUSP_DH_NEG 0.000000,
	__ANY_URI 0.000000, __BODY_NO_MAILTO 0.000000,
	__BOUNCE_CHALLENGE_SUBJ 0.000000, __BOUNCE_NDR_SUBJ_EXEMPT 0.000000,
	__BULK_NEGATE 0.000000, __CC_NAME 0.000000, __CC_NAME_DIFF_FROM_ACC 0.000000,
	__CC_REAL_NAMES 0.000000, __CT 0.000000, __CTE 0.000000,
	__CT_TEXT_PLAIN 0.000000, __DKIM_ALIGNS_1 0.000000, __DKIM_ALIGNS_2 0.000000,
	__DQ_NEG_DOMAIN 0.000000, __DQ_NEG_HEUR 0.000000, __DQ_NEG_IP 0.000000,
	__FORWARDED_MSG 0.000000, __FROM_DOMAIN_NOT_IN_BODY 0.000000,
	__FROM_NAME_NOT_IN_ADDR 0.000000, __FUR_RDNS_SOPHOS 0.000000,
	__HAS_CC_HDR 0.000000, __HAS_FROM 0.000000, __HAS_MSGID 0.000000,
	__HAS_REFERENCES 0.000000, __HEADER_ORDER_FROM 0.000000,
	__IN_REP_TO 0.000000, __MAIL_CHAIN 0.000000, __MIME_BOUND_CHARSET 0.000000,
	__MIME_TEXT_ONLY 0.000000, __MIME_TEXT_P 0.000000, __MIME_TEXT_P1 0.000000,
	__MIME_VERSION 0.000000, __MULTIPLE_RCPTS_CC_X2 0.000000,
	__NOTIFICATION_TO 0.000000, __NO_HTML_TAG_RAW 0.000000,
	__OUTBOUND_SOPHOS_FUR 0.000000, __OUTBOUND_SOPHOS_FUR_IP 0.000000,
	__OUTBOUND_SOPHOS_FUR_RDNS 0.000000, __RCVD_PASS 0.000000,
	__REFERENCES 0.000000, __SANE_MSGID 0.000000, __SCAN_D_NEG 0.000000,
	__SCAN_D_NEG2 0.000000, __SCAN_D_NEG_HEUR 0.000000,
	__SCAN_D_NEG_HEUR2 0.000000, __SUBJ_ALPHA_END 0.000000,
	__SUBJ_ALPHA_NEGATE 0.000000, __SUBJ_REPLY 0.000000, __TO_GMAIL 0.000000,
	__TO_MALFORMED_2 0.000000, __TO_NAME 0.000000,
	__TO_NAME_DIFF_FROM_ACC 0.000000, __TO_REAL_NAMES 0.000000,
	__URI_NO_MAILTO 0.000000, __URI_NO_WWW 0.000000, __USER_AGENT 0.000000,
	__X_MAILSCANNER 0.000000
X-SASI-Probability: 10%
X-SASI-RCODE: 200
X-SASI-Version: Antispam-Engine: 5.1.4, AntispamData: 2023.12.5.200915
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=embedd.com; s=mikd;
	h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID; bh=BvcoJcG4CZKF4cdKSJfgMlbU7qClM1U2uu51lNz6aho=;
	b=Y+QIj6nAZmSzCCgo10c+cP021sEgaqo58SSF0wCasqD6BB4Vz91MyOUvhBtk2pToa6HZ+PxwQvaxex/mWri4EUdt+5OPbDnM5LJF1AQDhHJnH6tFfaWQr/HHL2ixdWRZxKXhj5ub7QkGqlhfpOcZDM0pRXefa1I3Sdo21zZk8rE=;
Message-ID: <52f88c8bf0897f1b97360fd4f94bdfe2e18f6cc0.camel@embedd.com>
Subject: Re: [PATCH] net: dsa: microchip: fix NULL pointer dereference on
 platform init
From: Daniel Danzberger <dd@embedd.com>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, 
	netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli
	 <f.fainelli@gmail.com>
Date: Tue, 05 Dec 2023 23:15:58 +0100
In-Reply-To: <20231205181735.csbtkcy3g256kwxl@skbuf>
References: <20231204154315.3906267-1-dd@embedd.com>
	 <20231204174330.rjwxenuuxcimbzce@skbuf>
	 <577c2f8511b700624cdfdf75db5b1a90cf71314b.camel@embedd.com>
	 <20231205165540.jnmzuh4pb5xayode@skbuf>
	 <e37d2c6678f33b490e8ab56cd1472429ca3dcc7a.camel@embedd.com>
	 <20231205181735.csbtkcy3g256kwxl@skbuf>
Disposition-Notification-To: dd@embedd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1-1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received-SPF: pass (webmail.newmedia-net.de: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dd@embedd.com; helo=webmail.newmedia-net.de;
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: dd@embedd.com
X-SA-Exim-Scanned: No (on webmail.newmedia-net.de); SAEximRunCond expanded to false
X-NMN-MailScanner-Information: Please contact the ISP for more information
X-NMN-MailScanner-ID: 1rAdhx-0006vv-Hf
X-NMN-MailScanner: Found to be clean
X-NMN-MailScanner-From: dd@embedd.com
X-Received:  from localhost.localdomain ([127.0.0.1] helo=webmail.newmedia-net.de)
	by webmail.newmedia-net.de with esmtp (Exim 4.72)
	(envelope-from <dd@embedd.com>)
	id 1rAdhx-0006vv-Hf; Tue, 05 Dec 2023 23:16:01 +0100

On Tue, 2023-12-05 at 20:17 +0200, Vladimir Oltean wrote:
> On Tue, Dec 05, 2023 at 06:33:18PM +0100, Daniel Danzberger wrote:
> > On Tue, 2023-12-05 at 18:55 +0200, Vladimir Oltean wrote:
> > > On Tue, Dec 05, 2023 at 09:00:39AM +0100, Daniel Danzberger wrote:
> > > > > Is this all that's necessary for instantiating the ksz driver thr=
ough
> > > > > ds->dev->platform_data? I suppose not, so can you post it all, pl=
ease?
> > > > Yes, that NULL pointer was the only issue I encountered.
> > >=20
> > > I was just thinking, the KSZ9477 has internal PHYs on ports 0-4, and =
an
> > > internal MDIO bus registered in ksz_mdio_register(). The bus registra=
tion
> > > won't work without OF, since it returns early when not finding
> > > of_get_child_by_name(dev->dev->of_node, "mdio").
> > Interesting, I did not notice that.
> > After the NULL pointer issue was fixed the switch just worked.
> > >=20
> > > Don't you need the internal PHY ports to work?
> > For now the switch seems to run just fine, with port 0 being the CPU po=
rt and 1-4 being used as
> > regular switch ports.
> > I will do some more testing this week however...
>=20
> What does "regular switch ports" mean? L2 forwarding between them?
> Could you give us an "ip addr" output?
root@t2t-ngr421:~# ip a s
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group d=
efault qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host proto kernel_lo=20
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1502 qdisc mq state UP group=
 default qlen 1000
    link/ether 00:13:95:55:cf:d7 brd ff:ff:ff:ff:ff:ff
    inet6 fe80::213:95ff:fe55:cfd7/64 scope link proto kernel_ll=20
       valid_lft forever preferred_lft forever
3: lan1@eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue mast=
er br-lan state UP group
default qlen 1000
    link/ether 00:13:95:55:cf:d7 brd ff:ff:ff:ff:ff:ff
4: lan2@eth0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue ma=
ster br-lan state
LOWERLAYERDOWN group default qlen 1000
    link/ether 00:13:95:55:cf:d7 brd ff:ff:ff:ff:ff:ff
5: lan3@eth0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue ma=
ster br-lan state
LOWERLAYERDOWN group default qlen 1000
    link/ether 00:13:95:55:cf:d7 brd ff:ff:ff:ff:ff:ff
6: lan4@eth0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue ma=
ster br-lan state
LOWERLAYERDOWN group default qlen 1000
    link/ether 00:13:95:55:cf:d7 brd ff:ff:ff:ff:ff:ff
7: br-lan: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state U=
P group default qlen 1000
    link/ether 00:13:95:55:cf:d7 brd ff:ff:ff:ff:ff:ff
    inet 192.168.20.1/24 brd 192.168.20.255 scope global br-lan
       valid_lft forever preferred_lft forever
    inet6 fd4e:2bf5:cc74::1/60 scope global noprefixroute=20
       valid_lft forever preferred_lft forever
    inet6 fe80::213:95ff:fe55:cfd7/64 scope link proto kernel_ll=20
       valid_lft forever preferred_lft forever

The lan* devices are then bridged together:

root@t2t-ngr421:~# brctl show
bridge name	bridge id		STP enabled	interfaces
br-lan		7fff.00139555cfd7	no		lan4
							lan2
							lan3
							lan1


--=20
Regards

Daniel Danzberger
embeDD GmbH, Alter Postplatz 2, CH-6370 Stans

