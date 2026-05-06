Return-Path: <netdev+bounces-284807-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFLmCDM1+2nfXgMAu9opvQ
	(envelope-from <netdev+bounces-284807-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 14:33:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A504DA3F2
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 14:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08B52302ED50
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 12:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308A6329C71;
	Wed,  6 May 2026 12:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schleissheimer.onmicrosoft.com header.i=@schleissheimer.onmicrosoft.com header.b="RjC7Rq1y"
X-Original-To: netdev@vger.kernel.org
Received: from FR5P281CU006.outbound.protection.outlook.com (mail-germanywestcentralazon11022088.outbound.protection.outlook.com [40.107.149.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504DB33A6E0
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 12:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.149.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778070640; cv=fail; b=hSl6LJWHmED4Dc/nAXBPENN+gekYMDbb9cQkkWQCsxJLfAu+6NtkvVtPTZHungvFPE5l9NqclQSVroAvR3DBD3V/uzvISIKOfhhdoAaWXteOQ7rJVsTG2bn8hg0owzPTaOJAfvOsZMksO5OF7sFrVQ7g+/f4cmzkiIVZ0g1ykks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778070640; c=relaxed/simple;
	bh=XK3rfzWl9CEhYeKd1VYBX0k61hDfhymOrQabxp2qe50=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TUDthMznzDv6RwfiiIj6Nre9oESzjekG8bJyqJXXjFHzcP8LvRDOveLAIZH3pAiqq8D/tGYC5V68ST3MF9ZUA8Fo8YLWIl+8FwzG/8UKAs2bALm3wn6EFHR8DNpmHOly0rAVSyjqCbY4kDuosLvHkCgQ7XD4pHj0487yVvOaFjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schleissheimer.de; spf=pass smtp.mailfrom=schleissheimer.de; dkim=pass (1024-bit key) header.d=schleissheimer.onmicrosoft.com header.i=@schleissheimer.onmicrosoft.com header.b=RjC7Rq1y; arc=fail smtp.client-ip=40.107.149.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schleissheimer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schleissheimer.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QogTNy+w3jpiXUM+ePwEbFIgnc2+9gSUoVQTQUykKAXwF0ZaMVw0J39jwY+1KtZv3KFiWQCkFmO689tLw5A6Q5Mu1qZzfmdHLEs/f+PDVQP7KQc/H0HWaT6CzN2evrNMlS5Kz9S6+SY6SPLQVQmS2YRIPhBT//Y2SWTC8I4LA3+/Zhrg6sYAp51nMewcrrKLMiIcckZ1rkAokihJrqfiZXdauZ2q7OHFTC/oHQAtWgHEpbjtxo34MjXmK0Sn2wOSMWO8YxcMbXGvW35xABiTXz/X7RilfHx221QI52AvjXhkbImqbCyWB+tZD+INkvgquZ/R7eBZOkp0SacHGsV53w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nw6lG2yPqG7MQbj4TFKTXsAqTV+8WHRPTXnG5dumxyg=;
 b=kBmHn4GrCnSvwpWSkjmFPBPhNzMNYmU7II1TLeaydch3wBGhL9DszZTxhrKsuWkfUsxkAO738PtforqpyvZUfmvRUNvuA5nujq8rCmzw26GV4Jv7A2mHffpDF5LNxHRnWJjdn6e2FScWS+5TANqVeiRLxzfPLi6VyjOAxgJmnWIybXzJs4qSDxJC9sQ1+R6FTPb3qVFp1Y9YC/lxXkwx1lErrYzvx0kr2PUDlMq7d18LK3dfPm2bqavs7+ZSeFLuHxP2dgm6+3HMLvoV2+FiVcMRq+3UVvgCkYLYV7VvsdXGd/4DVHwZLz8xACgNH2eZkyWspaGFt69q2gAPJrrklA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=schleissheimer.de; dmarc=pass action=none
 header.from=schleissheimer.de; dkim=pass header.d=schleissheimer.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=schleissheimer.onmicrosoft.com; s=selector1-schleissheimer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nw6lG2yPqG7MQbj4TFKTXsAqTV+8WHRPTXnG5dumxyg=;
 b=RjC7Rq1yf/aqsH+fp4UqY7+Ldv3643yldFWcIjkJeQdOxdzKOik5qw5XlFtDYRNTa64DM3HiAv/a5nw8WNhL4V5HWOMVHUcxKzOeCroBLtL8UG6P7oEIicdX4p3vs+vIkD6usXDZTpsC19eP2WwfJ4Ud+n8Rf9GBol+gLnzJejw=
Received: from BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:52::10)
 by BEXP281MB5158.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 12:30:33 +0000
Received: from BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM
 ([fe80::2bc1:32a6:153:c3e9]) by BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM
 ([fe80::2bc1:32a6:153:c3e9%4]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 12:30:33 +0000
From: Sven Schuchmann <schuchmann@schleissheimer.de>
To: Andrew Lunn <andrew@lunn.ch>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: AW: assert in phylink.c with lan7801 and dp83tc811 since kernel 6.18
Thread-Topic: assert in phylink.c with lan7801 and dp83tc811 since kernel 6.18
Thread-Index: AQHc3HSt2FaNRg+Hc0Clgdk/8rilD7X/aQMAgAGFVA8=
Date: Wed, 6 May 2026 12:30:33 +0000
Message-ID:
 <BEZP281MB224573FE237813F5DE192A95D93F2@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
References:
 <BEZP281MB224533D524B27CFC6E47B447D93E2@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
 <57fb63c2-7a05-4bbe-ba2d-fc61ce1e3ba1@lunn.ch>
In-Reply-To: <57fb63c2-7a05-4bbe-ba2d-fc61ce1e3ba1@lunn.ch>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=schleissheimer.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEZP281MB2245:EE_|BEXP281MB5158:EE_
x-ms-office365-filtering-correlation-id: 192286f4-5548-42a6-41ca-08deab6b4494
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 5B/liCiEeLuAxNxtQmgbALGLl2m9inDcfx4LlEqzMo+haySeF3fr6u9dChOqD2vYSR3GX1HN3OlaBh4ue/JZY79ncHuFoSN/wzyAFxPoGhno1V1b1c18mkFMwj9SydEQS/vaG+eKlEDPI0fOUFkhz71Fnhg2jU0Qsh5QWsAo7KwLDBV1gAxkR1K1Kf7YtH25sFGsT4RW5ELrKxoAsSE+JuPt2kYlhtDVWcLETNbv4DnsPlT0mqG/0GtKUYwBgamMMwlnlGFZDm7zkBo0KKdiA1Y6UCbdDRWo77YgJGnI9Qqcau3pzN+2TQpls8E0ijJRzIqtQ6GUw/iERgRWXxNXfAkIIrW4xz7bTJ+mrIVU57XXxc/7O5COPpbK9LrVQV0qzBV8brxs5uOkpiUAwU1quMFO6lzNgT4X8ngqLVOvU9cp0/gbqfJ7oQqawzoY/Dvynjm3g5vSf9fZbRGwz3YDRYgnzqTsZxxUXzlCS0+4tdfVELZ/F66qkl9cZhpSUgkeK3a1do2arybEtn2n4gb7spKagM+IMshMp4w40PzZXPlil3mH018WZiFf8oRiENlf7CNEl3PL6GuvYQw7+ZVAK+s51ZlZMs5m8Ums9xeEXo6apHZaKY+ihP4NI6T/YDZ7sXp9TVKvBo1MMnP9LXqqJDCMWjQCb9WWcICoj/CxX+EC2MXmSQe1D//OwRfeCVO9VXCwYhdk8mxVCTN899wRyDqg568xSCOvu2nTiTc/7NomP6njTV2+0uhkihD/8sq5
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?byi2uCkNkVw4RczYNqmFS4Pk/MWSo151UaW30s6FneJ/11Ad2zz9TBZA5K?=
 =?iso-8859-1?Q?lX/tynAh2gmHOdtwxAlHPpMmM5A5x3E9S5NEjGpylO1DgWDEuA4jURVdg9?=
 =?iso-8859-1?Q?iDeGG2dInnnY6GELHCRI/x5Q/EzKrWT21kypDtxWiqNX5ASpivjk+0Anqm?=
 =?iso-8859-1?Q?/J2S6jViQmD6lb7wsMz9Id1vTAJv8EZP6xidg3W56im/0pCvNHdLFtVPfJ?=
 =?iso-8859-1?Q?p1pvE6qxqGBVzG6SeLjyegGY7kd+nDz1oJTIh6Zif4yDSFWrvvywrbyAmE?=
 =?iso-8859-1?Q?RXN1Dgchaf+cJH6ulVg+rJaMlAW+jks4woT734RcG7Iego7/ssZXA4/pRG?=
 =?iso-8859-1?Q?/6j0dtv1UH/0eTqXCaPGEAKei4zBhuFC8rC7fb5YShRTAAR+jPFCw/u6O5?=
 =?iso-8859-1?Q?qDZA2gnvcmpEsJyTU8dubLoukpDC2DqHBzh9LW/5Bs6VXI0ga/U+Jf4a2r?=
 =?iso-8859-1?Q?x193c28I8HJp/+xKVXcd2Ns9xUoiwzdtAalJxdlCJmiBQ7ZjH2CxDegvfq?=
 =?iso-8859-1?Q?/oe9H96ToaFQ4TiABzPmSsEiZrStINIK1GrgZ7CLKrdURdten9MjddIQhi?=
 =?iso-8859-1?Q?yRpBylgS44IVzIc5g9BvXiXXYc6P82ZOmDC8ghKmw41+Iq1mddQSmAU0CS?=
 =?iso-8859-1?Q?Htd0kZSz7jft2L3rQmOSwpRuytvync/VU5dFP31e/fENSwXcwXBl+AqEXc?=
 =?iso-8859-1?Q?39r4L3wEP+QJElhMFM4gXAHtg6MeEhO0lFf9sdQZcp7wglOrdBAmA5LNr4?=
 =?iso-8859-1?Q?TnT0Q7tNhW/UyMqeSrM4ggB8uWJ8rEJZd30gYVw7+etPFYfM8OG/td17Lt?=
 =?iso-8859-1?Q?+SjvPeWRtel/E0hRVgdovKWmGAb4AA7g6y5hQhx8W0vuKEw9IOsObt83XY?=
 =?iso-8859-1?Q?OoBuCLpCIMGQ3C5nBli4ARdOcaToNbNXPbgShR6Y0XiRkgVVegWJtoI9cS?=
 =?iso-8859-1?Q?rrhfHwQ/Oe3f/lLSudydgFndrErIKn3b66mizmjfy54zsN5JSmhAWMU4Zg?=
 =?iso-8859-1?Q?qaKaYy5g9nLjww5ZAApnAXxvvXniBS+diJgNAVPyDfUgw6npFeflCkS7/r?=
 =?iso-8859-1?Q?H/xUeWR9K2BdwfYcLZmOO7rgzqO7quPEfNot5djf5EOowRAsN6DGWr2A+C?=
 =?iso-8859-1?Q?fyrSqEHGXO2Nkedu8W6cFlHCYuqrBluFyd1d7JNBIgJCdEOg8t3nqwdiZL?=
 =?iso-8859-1?Q?057nG518Jpgrsk12XhFqRmE0PXV5T8eBCP41T7pF9BgJktrdcz92CLJNST?=
 =?iso-8859-1?Q?uG0GLsB05ihYsbQTVHgoJOSrRzOLLCd45kTc/iGTXF76++kpu5zZWr50+c?=
 =?iso-8859-1?Q?CSnPjMjG7HypLb5U2B20vWfSzf5NMNhOI6jCTBXxiow4lMP0ZMCvjDyh0i?=
 =?iso-8859-1?Q?lLInhYgBAFYklwPQSaI3s0AEdjzmLdv+rmkJMO/VXjQIYmkavXXXElOzI5?=
 =?iso-8859-1?Q?uc71e5tLCGAh1c4umpnPVM7z79Kf8T89cAe2EUgCdlKlzK149RR1Y5MoxK?=
 =?iso-8859-1?Q?SIoeuYO52wM+KqkJdD60SnBTqy/Em0gPKXrQvpff02B993qwfAKlSeNB5u?=
 =?iso-8859-1?Q?3q6y3L4yVvaiYtHIjiuHu6O4J74GtSJIlEhT1mMuY8Rwzem1qnXfcKqJIT?=
 =?iso-8859-1?Q?N5DF/sIoJoY7N9OUUh5LmMeRNYgCWMEh9VYM4PyadKXNqJ1/FP3LX8uGm+?=
 =?iso-8859-1?Q?bp+8+LyiC9SG9+nDgnYfA4BAbeNGJOkuAJHSjU0sRl3LkcfqhdyPsZsUGx?=
 =?iso-8859-1?Q?JUoqvIOSjLaUeRo/dnLb3uqUwgc0mcwv3D82S2ueaNYFDEgHO683mwCAS6?=
 =?iso-8859-1?Q?9xRZSF92Og=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 192286f4-5548-42a6-41ca-08deab6b4494
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2026 12:30:33.3012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ba05321a-a007-44df-8805-c7e62d5887b5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fDZYo0au572EXgBXHzirI+Sub0nI/Y1u1LnDyWX7H3LVmbseV9hE3Fn0sWDt2KvT3xxVehz4w46XAdNJOgmx2sy1WGv+TzL0v6rUAF+qCjk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEXP281MB5158
X-Rspamd-Queue-Id: 75A504DA3F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[schleissheimer.onmicrosoft.com:s=selector1-schleissheimer-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[schleissheimer.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-284807-lists,netdev=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[schuchmann@schleissheimer.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[schleissheimer.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM:mid,schleissheimer.onmicrosoft.com:dkim,schleissheimer.de:email]

Hi Andrew,=0A=
=0A=
I came up with this:=0A=
=0A=
diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c=0A=
index 261af300ab00..734cb62a1043 100644=0A=
--- a/drivers/net/usb/lan78xx.c=0A=
+++ b/drivers/net/usb/lan78xx.c=0A=
@@ -2862,7 +2862,9 @@ static int lan78xx_phylink_setup(struct lan78xx_net *=
dev)=0A=
 static void lan78xx_phy_uninit(struct lan78xx_net *dev)=0A=
 {=0A=
        if (dev->phylink) {=0A=
+               rtnl_lock();=0A=
                phylink_disconnect_phy(dev->phylink);=0A=
+               rtnl_unlock();=0A=
                phylink_destroy(dev->phylink);=0A=
                dev->phylink =3D NULL;=0A=
        }=0A=
=0A=
and it seems to prevent the cash. What do you think?=0A=
=0A=
=0A=
Reards,=0A=
=0A=
   Sven=0A=
=0A=
Von:=A0Andrew Lunn <andrew@lunn.ch>=0A=
Gesendet:=A0Dienstag, 05. Mai 2026 15:13=0A=
An:=A0Sven Schuchmann <schuchmann@schleissheimer.de>=0A=
Cc:=A0netdev@vger.kernel.org <netdev@vger.kernel.org>=0A=
Betreff:=A0Re: assert in phylink.c with lan7801 and dp83tc811 since kernel =
6.18=0A=
=0A=
=0A=
On Tue, May 05, 2026 at 09:53:06AM +0000, Sven Schuchmann wrote:=0A=
=0A=
> Hello,=0A=
> I have a raspberrypi and switched from kernel 6.12 to 6.18 and now I have=
 a crash in phylink.c.=0A=
=0A=
Please could you try 7.0.3, or better still, 7.1-rcX. We need to=0A=
determine if the problem has already been fixed and just needs=0A=
backporting, or is it a new problem.=0A=
=0A=
> I am using a MAC:lan7801 and PHY:dp83tc811 and now it crashes like this:=
=0A=
>=0A=
> [ =A0 =A03.019174] usb 1-1.3: New USB device found, idVendor=3D0424, idPr=
oduct=3D7801, bcdDevice=3D 3.00=0A=
> [ =A0 =A03.021152] usb 1-1.3: New USB device strings: Mfr=3D1, Product=3D=
2, SerialNumber=3D3=0A=
> [ =A0 =A03.023192] usb 1-1.3: Product: LAN7801=0A=
> [ =A0 =A03.025019] usb 1-1.3: Manufacturer: Microchip=0A=
> [ =A0 =A03.026772] usb 1-1.3: SerialNumber: 00800F780100=0A=
> [ =A0 =A03.078542] lan78xx 1-1.3:1.0 (unnamed net_device) (uninitialized)=
: int urb period 64=0A=
> [ =A0 =A03.091434] lan78xx 1-1.3:1.0 (unnamed net_device) (uninitialized)=
: validation of rgmii-id with support 0000000,00000000,00000000,00006280 an=
d advertis =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0ement 0000000,00000000,00000000,00006280 failed: -EINVAL=0A=
=0A=
This appears to be the real problem.=0A=
=0A=
> [ =A0 =A03.098928] lan78xx 1-1.3:1.0 (unnamed net_device) (uninitialized)=
: can't attach PHY to usb-001:004, error -EINVAL=0A=
> [ =A0 =A03.101094] ------------[ cut here ]------------=0A=
> [ =A0 =A03.103163] RTNL: assertion failed at drivers/net/phy/phylink.c (2=
337)=0A=
=0A=
and this is a knock on problem, which normally you don't see.=0A=
Please could you make line 1 of drivers/net/phy/phylink.c.=0A=
=0A=
#define DEBUG 1=0A=
=0A=
That will give us additional debug info.=0A=
=0A=
=A0=A0=A0=A0 Andrew=0A=
=0A=

