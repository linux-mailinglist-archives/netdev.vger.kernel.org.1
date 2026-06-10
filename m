Return-Path: <netdev+bounces-297626-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id w0WcChNFKWp+TQMAu9opvQ
	(envelope-from <netdev+bounces-297626-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 13:05:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AAA566892F
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 13:05:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=schleissheimer.onmicrosoft.com header.s=selector1-schleissheimer-onmicrosoft-com header.b=QBYNsBng;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297626-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297626-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=schleissheimer.de (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B06963135B12
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 10:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2853DCD89;
	Wed, 10 Jun 2026 10:57:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from FR4P281CU032.outbound.protection.outlook.com (mail-germanywestcentralazon11022099.outbound.protection.outlook.com [40.107.149.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578192BDC2A
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 10:56:57 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781089021; cv=fail; b=sIb6Nza4kTep+2kdAvYVJQOqPoRikjfTO+sY3Y+OK1f/GGN14EotzFvye3O8S66rAbRNS8bL8ral/zzULRnd9W97j715KLbH3Px4XZ2TvuAKNX438s6CnOeqN9CnR3gEfRpiEhstffiEmE+yW2+zUcqYk+cnb3ZvBpIlkLGzINY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781089021; c=relaxed/simple;
	bh=deACWIGcpXF4jjjtXZ9DCT+zPQUctxWqUPTMa0eOEVs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ma6xV4CYQG5A+XaoO6ASHCRbIQ5LmSBOe5Lcs4cxDlcC8kM1EunteW7RfD36WKZaeLkGuTEaMiei7vVrdTh8b9xFeiEOsKG5YPDzcKOV3RWu8kM/4ac+AVM9NG58wUyXg0qnzAyBTiFBvwwxpW30mz48pDc+Zc1mgmvMCJPq6hI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schleissheimer.de; spf=pass smtp.mailfrom=schleissheimer.de; dkim=pass (1024-bit key) header.d=schleissheimer.onmicrosoft.com header.i=@schleissheimer.onmicrosoft.com header.b=QBYNsBng; arc=fail smtp.client-ip=40.107.149.99
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vMEH3WWys3b5bvu54ZBoIykPcnV408+9k/QgcF0fi1xyQRTNza+edvtVDkquaNezU283oYxv53ZLNm4nerl2VMZO3vZ+CJI2MB+GUCvPVkAIMHlciSpsiX3pq86l5uvzaW/uZTlW7yFmh7568slVXIomQPYn6sjIc1TsD/CEFjiGAQbctUgXNwpLbsZBawgcm50dQsyxHoCXv18vmZ7Yj+wYpmA6rCPQym7qw6apzejmzcdLjR8o1sCyIEQkejaxpB6WbH5XEm5R3OS2PbXk+2PICMqruWM2y8mhQWwvD9zVwwG2j0yRGTQN5sDmSgjyOUaHLPXsfNTf9lUEdfkBnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GUOdRqdvX8KCprl1DxvIa0HSBn5K1fb7/nyCygyJ7co=;
 b=Mh44zVxGohhGPKW+fNN916bRo+RogA3W5VzKITdH88gYcg2h02kf3drpM/hlLjYd2//vIJBla2LsxbiCmZ4QRqXbE58vIWutfJ09u69jUjwFfRKm0VSwfxoN172OlU6Wp2lFkQLhu79EVLaTNF70DZaJamzcggy/9nQkzOteM4X/TbDahnMeCVsPfnhTQQ55fRlqiOMMSYgEPJ/WNubNu4XdoOI8YZsx1sHaLKNfjYu6mSg+OE4dpfQch8uYXh5bhKIrsEoK43esv7++byScx5tG0WvXKHAxWcewFQjjjmX05J47RSjzaS2mGLZgW2UK84aShm4J7rSQJ5VXE3d/sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=schleissheimer.de; dmarc=pass action=none
 header.from=schleissheimer.de; dkim=pass header.d=schleissheimer.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=schleissheimer.onmicrosoft.com; s=selector1-schleissheimer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUOdRqdvX8KCprl1DxvIa0HSBn5K1fb7/nyCygyJ7co=;
 b=QBYNsBng8WMwwWTdAjjO7rNWs+WbR1jcRvymCb/QK9eWaKUlN9hhA3ZYoDRolRmRBJdS9I8NXFzux8kuX973mecPqpxW1C4QW+2CSNZqm7BUFvN44QhPmUma8NVaR1hTuZ8wkFHyBV375V7QULCE/z/fOMM4WT4uSBOIBl/zfZw=
Received: from BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:52::10)
 by FR2P281MB0283.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.11; Wed, 10 Jun 2026 10:56:54 +0000
Received: from BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM
 ([fe80::2bc1:32a6:153:c3e9]) by BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM
 ([fe80::2bc1:32a6:153:c3e9%4]) with mapi id 15.21.0092.014; Wed, 10 Jun 2026
 10:56:53 +0000
From: Sven Schuchmann <schuchmann@schleissheimer.de>
To: Andrew Lunn <andrew@lunn.ch>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: AW: assert in phylink.c with lan7801 and dp83tc811 since kernel 6.18
Thread-Topic: assert in phylink.c with lan7801 and dp83tc811 since kernel 6.18
Thread-Index: AQHc3HSt2FaNRg+Hc0Clgdk/8rilD7X/aQMAgAEuzo+AAGP6gIA22u/Z
Date: Wed, 10 Jun 2026 10:56:53 +0000
Message-ID:
 <BEZP281MB2245F1C5486730A42CF105F1D91A2@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
References:
 <BEZP281MB224533D524B27CFC6E47B447D93E2@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
 <57fb63c2-7a05-4bbe-ba2d-fc61ce1e3ba1@lunn.ch>
 <BEZP281MB22458F571CC8251C141D933CD93F2@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
 <62b15f5f-c9db-4443-b0ee-ac7044459c08@lunn.ch>
In-Reply-To: <62b15f5f-c9db-4443-b0ee-ac7044459c08@lunn.ch>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEZP281MB2245:EE_|FR2P281MB0283:EE_
x-ms-office365-filtering-correlation-id: f43a2bdb-3893-4385-3505-08dec6defb9e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|22082099003|18002099003|38070700021|4143699003|56012099006;
x-microsoft-antispam-message-info:
 b+3NjXreU/LO1K2YBRDTqc+MJ5f8Ye3mKC+geOoJNWArL2GYjPBEn5KmfWJP6NfCixGQswgGok9a/2aAhkbxXtmGRBBau5eQBe6kfvZ86LhRJw174vy0qpdAfcMsNS7S0PlrLyjP/GGHfUIS0UZqbNM30bLStws+7kijU1nbtpjHR6IpJy2QgMWqbk46wAWstR0x/+gT2zHZwuVqQXGpS24LYRHNjsdTF4sbix2jN30upkjiPn9LOEx74g3IqwrVmSYNfwFs+dqf96j5rpxRdUoBzz714+FSbvbUX9HF3FMOqxli3PTIJ+na5O8HSxfEVEpRv9F7vmw1/6P8tH/HGMJSxp7ZRlD1IlTxnhz2eyGeANMZv4PzV5q5CbevCXDemEuyWs8BDqBI3KKZKd9AizXs3J0zWI6E3/v9Z014DLULOj0yqvybEC6GsjZ1eRasmMRa753FxiMxKwvK1dMN4MZm4t1nNbZw05yZFk9DmFXe3AnOPEA6gM0NktkxxtB8MOb+HR210wKeavbzuB6SrMsxlhbEtJfXYvDfzoFvDus7IFV6T3B7NuBwhnU21mGX1AUxvFBwhvLM4VXF74CV94Av7SDbpt7Gjd3PSZiVJ8mnIzBN33EWnAVahc+ITltQbHa55M9sp1FhdCT3fKPp425EiCp0NUqHrYK4T/+kjql/cv5dP+qPuS1YLFkH0/B+HjrdUdiRBJmpdicihbvXszoLzMt33CcXBdzn7rUWkDhiRW7LgrY7k3S7j0UHgFtG
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(38070700021)(4143699003)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?k0mmnr3laQUdsrbcVF58wPorf4IdQAbhsPYTpBfq1Pouontsl0ih5toOsp?=
 =?iso-8859-1?Q?LhjstTg3D56nIfgQHY6Ku8rVLAVWCLE1K9uC5FNT3fwvPqBKKT91x0dtDu?=
 =?iso-8859-1?Q?eC9Dq2x5Gw6CuF7Phpl+s4P6pkvaZaHgKxNflWtOzUNcde1xERHws5LxS6?=
 =?iso-8859-1?Q?j7HVKC4NhjAG7fSvw7INie4udjUI9Wms/Mq9JOGSFBrPkko5DvH9hNQKX1?=
 =?iso-8859-1?Q?XN0JUppVr8bg42VvGnPZWww/cA+8hXIRUMTWYxvxILD0acvuk8TSd0MJRW?=
 =?iso-8859-1?Q?oUcEUWA+DssfVplS2lKTEcMNZzyUNFxvQEC5vclUwTiRez9XvHuD8BWo43?=
 =?iso-8859-1?Q?oZHpKmSsCbJYci9ujOhf9nncPm0hWFusE1bNldbhBr/z60o+tLXB3VGRWR?=
 =?iso-8859-1?Q?J8WCxFmSYCSuvNOm22InvfMxoaHc7cysT7lhbpC/3AEIRi8cchbEg1LA4Z?=
 =?iso-8859-1?Q?Fpgwqg5p0OAgekCcJZTeUFzTL3BG/rv8Rv6KBDnmX5YdnwH3VFPKQB/As/?=
 =?iso-8859-1?Q?7FaZPEJxg1H9Bb6VprnZyCOiO9k2y1hlPW9snz11owQoRejuCUBOl01WiT?=
 =?iso-8859-1?Q?/gOBzXcwqFQIzECIdm+ATVyqDF1AvUSt+kQI1b1YnCelsL0b2r+/3zpTOf?=
 =?iso-8859-1?Q?S4GalPoUBC7hPu3pXmjkiNyu7Refho/FTnM8ZDPzXyiI1QB3qLISyzH2zI?=
 =?iso-8859-1?Q?m7ZRsu2n3HpH0u3OCP8MYlExqHFQijfEpnhmGZoXPRP9o2kv2uaEplUUfZ?=
 =?iso-8859-1?Q?iAqR0NcfGwH5fC/rFzWMtF80opPHICMpHjY+X7o0/LXEF+4+2n2obADiYX?=
 =?iso-8859-1?Q?PeDEnB1lDjxXKLnNmFogGHQJDt5TRChcEQpdjVi/rMpOTiXCGGRQJSnWUz?=
 =?iso-8859-1?Q?S2pF4PVvGq8MMYJlDgfVdF34HDCa63P0LWzOPrXMhuPf3Yjq95PjQ2Qa9F?=
 =?iso-8859-1?Q?fhLcgpRch5gyMkGfb0hYyR+O203xRFiESKWuQmACXFa8YkuHqxLxPfEbI+?=
 =?iso-8859-1?Q?DNE6hefgjrqEPu9Fx7rUEBq8bUnwxsbqB/8UOc4tBAp5vEcKIZXTHpLjOQ?=
 =?iso-8859-1?Q?yanvC1soWCv2yVu7gVLFMoV//3khzzYxaKC6R6r4BKimLWNy3rfSDR/Ehi?=
 =?iso-8859-1?Q?Pi59zCfGs2/e/QU1/MgB12My0h6C/rGjc6AOkBugBo4N2Ab0wa7joZ/NJe?=
 =?iso-8859-1?Q?zk3IUYkDXMbu71SEfDLue1x0r4raitVrh/fVSlBr93TCjQApa7duRC22jL?=
 =?iso-8859-1?Q?0YImNMtgdMEyDBhPxbUXqfd7feBQmP+M5Q5kuMhnHQOAUD/5vaCPUsr3WL?=
 =?iso-8859-1?Q?14vrHEsQ77qofkTnuOAsXI7FbhWYPV6eRIFHd+DideHRe3U2ScWyrDEO+c?=
 =?iso-8859-1?Q?IuctvmnSLURQ9vwkI8qZstltDjpDGyhPd3CsfOTyTBNCn/YUZz68OPp1eO?=
 =?iso-8859-1?Q?lCNR83bbhwgMtHb50fA/uUpMxa5pDZ29jHvIaA4WSk3RGT9f589X94UCVN?=
 =?iso-8859-1?Q?NrWqvwHCvErJnxaMLn0W07KPzMsQySpMmqYs0C95wfoMPwCcLI0k0tlCPN?=
 =?iso-8859-1?Q?HT2TYaQ4roqiPtB5zFq5JKywoB8gfbgZGdkDxXnYACnbZsjoeo8kaPAe0S?=
 =?iso-8859-1?Q?pVPCIEyZM3or35MfSp1BG33jaiOXqUwg7+r5bzfpVNrRapjdkcfu6lf2M3?=
 =?iso-8859-1?Q?ySnC0WOtcVSJ/HVc9nuU7fpWSHVXx7XMS+QtYNQfAdlulFjjhVkBzjvdYx?=
 =?iso-8859-1?Q?ckstObsumpRzflY3GuD6J3ql4E7i5ZXygnSG0+g2My9NmpcIJFl7zCxsTm?=
 =?iso-8859-1?Q?HNmMfKG8TQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: schleissheimer.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f43a2bdb-3893-4385-3505-08dec6defb9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2026 10:56:53.9488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ba05321a-a007-44df-8805-c7e62d5887b5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: witv6bmwyVeM421Iq4kUl4CHr514HfOQaloeU6z060ZGdVNcYsdGJULJ7vuBGvBT8bI7dCyG6Ku2pjyNWexrHt4w1G5UU/KDTRKK9+tvizg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB0283
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[schleissheimer.onmicrosoft.com:s=selector1-schleissheimer-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[schleissheimer.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[schuchmann@schleissheimer.de,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-297626-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[schuchmann@schleissheimer.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[schleissheimer.onmicrosoft.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,lunn.ch:email,schleissheimer.de:from_mime,schleissheimer.de:email,schleissheimer.onmicrosoft.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8AAA566892F

Hi Andrew,=0A=
I think the patch ("net: usb: lan78xx: Fix cleanup in lan78xx_phy_init")=0A=
you did is worth going mainline. Shouldn't it?=0A=
Regards,=0A=
   Sven=0A=
=0A=
________________________________________=0A=
Von: Andrew Lunn <andrew@lunn.ch>=0A=
Gesendet: Mittwoch, 06. Mai 2026 15:15=0A=
An: Sven Schuchmann <schuchmann@schleissheimer.de>=0A=
Cc: netdev@vger.kernel.org <netdev@vger.kernel.org>=0A=
Betreff: Re: assert in phylink.c with lan7801 and dp83tc811 since kernel 6.=
18=0A=
=0A=
...=0A=
=0A=
From ea55645b23092a0de7aa3ab0eaf7bcb73a7fb0e1 Mon Sep 17 00:00:00 2001=0A=
From: Andrew Lunn <andrew@lunn.ch>=0A=
Date: Wed, 6 May 2026 08:10:29 -0500=0A=
Subject: [PATCH] net: usb: lan78xx: Fix cleanup in lan78xx_phy_init=0A=
If phylink_connect_phy() fails, phylink_disconnect() should not be=0A=
called. Rather than use lan78xx_phy_uninit() which does too much, add=0A=
the cleanup at the end of the function and only undo what was=0A=
successfully done.=0A=
Signed-off-by: Andrew Lunn <andrew@lunn.ch>=0A=
---=0A=
 drivers/net/usb/lan78xx.c | 14 ++++++++------=0A=
 1 file changed, 8 insertions(+), 6 deletions(-)=0A=
diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c=0A=
index bcf293ea1bd3..9cfc122d76ef 100644=0A=
--- a/drivers/net/usb/lan78xx.c=0A=
+++ b/drivers/net/usb/lan78xx.c=0A=
@@ -2842,7 +2842,7 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)=
=0A=
 =0A=
        ret =3D lan78xx_mac_prepare_for_phy(dev);=0A=
        if (ret < 0)=0A=
-               goto phylink_uninit;=0A=
+               goto destroy_phylink;=0A=
 =0A=
        /* If no PHY is found, set up a fixed link. It is very specific to=
=0A=
         * the LAN7801 and is used in special cases like EVB-KSZ9897-1 wher=
e=0A=
@@ -2852,7 +2852,7 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)=
=0A=
        if (!phydev) {=0A=
                ret =3D lan78xx_set_fixed_link(dev);=0A=
                if (ret < 0)=0A=
-                       goto phylink_uninit;=0A=
+                       goto destroy_phylink;=0A=
 =0A=
                /* No PHY found, so set up a fixed link and return early.=
=0A=
                 * No need to configure PHY IRQ or attach to phylink.=0A=
@@ -2871,17 +2871,19 @@ static int lan78xx_phy_init(struct lan78xx_net *dev=
)=0A=
        if (ret) {=0A=
                netdev_err(dev->net, "can't attach PHY to %s, error %pe\n",=
=0A=
                           dev->mdiobus->id, ERR_PTR(ret));=0A=
-               goto phylink_uninit;=0A=
+               goto destroy_phylink;=0A=
        }=0A=
 =0A=
        ret =3D lan78xx_configure_leds_from_dt(dev, phydev);=0A=
        if (ret < 0)=0A=
-               goto phylink_uninit;=0A=
+               goto disconnect_phylink;=0A=
 =0A=
        return 0;=0A=
 =0A=
-phylink_uninit:=0A=
-       lan78xx_phy_uninit(dev);=0A=
+disconnect_phylink:=0A=
+       phylink_disconnect_phy(dev->phylink);=0A=
+destroy_phylink:=0A=
+       phylink_destroy(dev->phylink);=0A=
 =0A=
        return ret;=0A=
 }=0A=
--=0A=
2.53.0=0A=

