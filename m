Return-Path: <netdev+bounces-54040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD07805B2A
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 18:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48485B21027
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 17:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD87268B67;
	Tue,  5 Dec 2023 17:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embedd.com header.i=@embedd.com header.b="HTe6Ekar";
	dkim=pass (1024-bit key) header.d=embedd.com header.i=@embedd.com header.b="lcmjBcLh"
X-Original-To: netdev@vger.kernel.org
Received: from mail.as201155.net (mail.as201155.net [185.84.6.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE84B18D
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 09:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=embedd.com;
	s=dkim1; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ozlpccOc57vALYVDByoFC351FCd7Cc1UYQhrqYThCwc=; b=HTe6EkarLNVlnZmCoY9NZNjc5q
	yaoRGUtKidEYITDIltpElIpcNiX2KCk/TSoryaLLgS5XWeVPR7fjKmOKYIL4CJYJbt1zyLciUUQtH
	i4DMT6WpxIZ9Sm25ZHTjW9nMoYVtuFMu6fqrVuRVc59n+HHMPJvO9B5UTJALuWtdnFasXSmPBjUVV
	lNZtuX6VHJWC+8rz5ALVokvwNjkcKFuBfmde5HlWLOdcH2hazSpln9ko2pXxYOHtigbhNkS541fLK
	82WqAh8XribmpV27Qmk7qtz4QJyhG13VNszFPFVYTabXbBQKW1z8Zw5Sve/NDG6B7ip6BWTWKFc/R
	iy8po6nA==;
Received: from smtps.newmedia-net.de ([2a05:a1c0:0:de::167]:36568 helo=webmail.newmedia-net.de)
	by mail.as201155.net with esmtps  (TLS1) tls TLS_RSA_WITH_AES_256_CBC_SHA
	(Exim 4.96)
	(envelope-from <dd@embedd.com>)
	id 1rAZIg-0005wV-3C;
	Tue, 05 Dec 2023 18:33:39 +0100
X-SASI-Hits: BODYTEXTP_SIZE_3000_LESS 0.000000, BODY_SIZE_1100_1199 0.000000,
	BODY_SIZE_2000_LESS 0.000000, BODY_SIZE_5000_LESS 0.000000,
	BODY_SIZE_7000_LESS 0.000000, CTE_QUOTED_PRINTABLE 0.000000,
	CT_TEXT_PLAIN_UTF8_CAPS 0.000000, DKIM_ALIGNS 0.000000,
	DKIM_SIGNATURE 0.000000, HTML_00_01 0.050000, HTML_00_10 0.050000,
	IN_REP_TO 0.000000, LEGITIMATE_SIGNS 0.000000, MSG_THREAD 0.000000,
	MULTIPLE_RCPTS 0.100000, MULTIPLE_REAL_RCPTS 0.000000, NO_CTA_FOUND 0.000000,
	NO_CTA_URI_FOUND 0.000000, NO_FUR_HEADER 0.000000, NO_URI_FOUND 0.000000,
	NO_URI_HTTPS 0.000000, OUTBOUND 0.000000, OUTBOUND_SOPHOS 0.000000,
	REFERENCES 0.000000, RETURN_RECEIPT 0.500000, SENDER_NO_AUTH 0.000000,
	SUSP_DH_NEG 0.000000, __BODY_NO_MAILTO 0.000000,
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
	__URI_NO_MAILTO 0.000000, __USER_AGENT 0.000000, __X_MAILSCANNER 0.000000
X-SASI-Probability: 10%
X-SASI-RCODE: 200
X-SASI-Version: Antispam-Engine: 5.1.4, AntispamData: 2023.12.5.170315
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=embedd.com; s=mikd;
	h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID; bh=ozlpccOc57vALYVDByoFC351FCd7Cc1UYQhrqYThCwc=;
	b=lcmjBcLhWKf/9FWqBwLHOQTmezb619k9uDQ6FojmA27lWFjvupNFIuR7YmCRLcAItR6vcgpLYZ7/RoL/V/M48UMep/l9AIlmpvLXlGpT7EzPjzVHztDNaEOIEIThD2AbuhHtSEPZeZm22/39/uhxRcFSqQ6Eu+5HGWqretCV8fo=;
Message-ID: <e37d2c6678f33b490e8ab56cd1472429ca3dcc7a.camel@embedd.com>
Subject: Re: [PATCH] net: dsa: microchip: fix NULL pointer dereference on
 platform init
From: Daniel Danzberger <dd@embedd.com>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, 
	netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli
	 <f.fainelli@gmail.com>
Date: Tue, 05 Dec 2023 18:33:18 +0100
In-Reply-To: <20231205165540.jnmzuh4pb5xayode@skbuf>
References: <20231204154315.3906267-1-dd@embedd.com>
	 <20231204174330.rjwxenuuxcimbzce@skbuf>
	 <577c2f8511b700624cdfdf75db5b1a90cf71314b.camel@embedd.com>
	 <20231205165540.jnmzuh4pb5xayode@skbuf>
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
X-NMN-MailScanner-ID: 1rAZIN-0005Mp-VR
X-NMN-MailScanner: Found to be clean
X-NMN-MailScanner-From: dd@embedd.com
X-Received:  from localhost.localdomain ([127.0.0.1] helo=webmail.newmedia-net.de)
	by webmail.newmedia-net.de with esmtp (Exim 4.72)
	(envelope-from <dd@embedd.com>)
	id 1rAZIN-0005Mp-VR; Tue, 05 Dec 2023 18:33:20 +0100

On Tue, 2023-12-05 at 18:55 +0200, Vladimir Oltean wrote:
> On Tue, Dec 05, 2023 at 09:00:39AM +0100, Daniel Danzberger wrote:
> > > Is this all that's necessary for instantiating the ksz driver through
> > > ds->dev->platform_data? I suppose not, so can you post it all, please=
?
> > Yes, that NULL pointer was the only issue I encountered.
>=20
> I was just thinking, the KSZ9477 has internal PHYs on ports 0-4, and an
> internal MDIO bus registered in ksz_mdio_register(). The bus registration
> won't work without OF, since it returns early when not finding
> of_get_child_by_name(dev->dev->of_node, "mdio").
Interesting, I did not notice that.
After the NULL pointer issue was fixed the switch just worked.
>=20
> Don't you need the internal PHY ports to work?
For now the switch seems to run just fine, with port 0 being the CPU port a=
nd 1-4 being used as
regular switch ports.
I will do some more testing this week however...

And probably checkout some DTS files that use that switch to see what other=
 options I might need
when going the platform_data path.

>=20

--=20
Regards

Daniel Danzberger
embeDD GmbH, Alter Postplatz 2, CH-6370 Stans

