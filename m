Return-Path: <netdev+bounces-299702-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +j91EX+sMGqKWAUAu9opvQ
	(envelope-from <netdev+bounces-299702-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 03:53:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1B468B591
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 03:53:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=igDKuBK6;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299702-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299702-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D63230D3B9A
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 01:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BD437C0F0;
	Tue, 16 Jun 2026 01:53:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011006.outbound.protection.outlook.com [40.107.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5161337BE7A
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 01:52:59 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781574780; cv=fail; b=L+CQjN5lfSFCffIfgrqe6qBv3YiyqsHr9DEpo9Az3PTFU1rD3GeO5HCgsZBN49Zh2aixn00Cbhs1oQrGiRnDGoN49J2g3zFqxgnRwzV+e0TiJ2HH3iBlTjeAeuEQQfjtcVJ+aUDdYaojCbJvMOZq+sMW0Y3IBjPgdUoQC+XFgvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781574780; c=relaxed/simple;
	bh=A4fjv3BgaKDB8ptDlkqlw3ywz2HWvO4p6Ccoly0Xy1g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U/tXjoBNw7VS4gszkib2ARx0R2gUG8uFKGAyz5xd56bl5XZT2pZOB8rI+sxnAjmDgyTzf4UiE70LzPaXfI8rc4CBlkcUnuA9bqcWHOroyDKo1Fnx9ns50glq0mUZcs9NWXUoA55ddko0j2f9jh6aExESyWvN5ry58pyfYn4jOlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=igDKuBK6; arc=fail smtp.client-ip=40.107.130.6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S6/r5K4P5s47BnDHmFc0eQy7/2G8iD/GnzZY0L3vjOZj40H/0iXgU61wVBqueWhCtRcuecMEjAuEF0VeN0l5SD2NdKCQ6OOUjdCN5daiC4wYWPcI1/xDqUKb4MYcCjxr0BLUHJ2D4cyWnG6wmY3wXPZd6CVwyTfkj3QjhXAXCQ2UWl9npyPGN+ZIAxkT2YBWtUVCsbCObIgTn/Ka2wLctNjYRzn6o9J0QdHsamCvR2EikpEFHKgcAU/lqVRkOL/3xDKoBK/bMlNgHaOsk2X4Z9FL7ukPkL0KtVRYIjMgGsm53GrUkiSK3Owuq+OY8hXbBYVQGemKJq9ei9zo0pbPkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EzWCwnXTCt8eejE+dIotj2mH9GK4Vu4IcV7OEHTEW60=;
 b=rJpFlrKYaoKrD5ZrZZ00FmzREMvsZ65wyh+crRnbm7P/IXR59dIub0e7dc8OHZxZTSaCkpH1Livh7LOlGHzn2CcScgk5mncRnUrwY+PlBYvR6U+o0ID/KuXvV2iLCxrdHuo6T1YeCeiy0non+woJGhVaxUK4PgEqm+0xX4LKjjobMe6xwN0HIejT+fhOtHLxRrdEQ0oNO98tHvucXGkOjUlMNPjKMb4pnnInamceUUgyqW0hfsjDjoTxbVWKNBTwSylAjfRuprVGHCCcCwtC0N6jLm+oppxgX97ZfB6pik1GvspEju4TwA+DTu8ttSYH3yUgvv4MeXURXZUOMjSRmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EzWCwnXTCt8eejE+dIotj2mH9GK4Vu4IcV7OEHTEW60=;
 b=igDKuBK6f8NlwZmvub33Few4tBLzMsZG0UkFvZpWh2MLjglGTFqvLMftI/D3IUMLcZuMd1VhWQeztHEjVPqRTVhkoZrGsCBcEZRa0IsnlI1awhRadHxEQAyph4o2MWaMiTN8cAOD7BxQH1R9UPoIrHx/Wka3UNi8DN9m1Hm3pbb9qzLImKjqFynt1ApHeG8sVIN58fqa0hhJR2DiIPI7d2w98XiVw8E/sww3MyzwoOZI7det+1p/eEt1tPtCud/+RMMJdJug1KFvZFnKCk45a4FrBd3cWbIWEHkWL4kh0PhPgg33HaYzASCZ4MeX/L+0Y6yYmIgEVSUkbRGDj5pq4g==
Received: from DU2PR04MB8629.eurprd04.prod.outlook.com (2603:10a6:10:2dc::6)
 by DBBPR04MB7900.eurprd04.prod.outlook.com (2603:10a6:10:1e8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 01:52:55 +0000
Received: from DU2PR04MB8629.eurprd04.prod.outlook.com
 ([fe80::9d04:7526:a901:fe47]) by DU2PR04MB8629.eurprd04.prod.outlook.com
 ([fe80::9d04:7526:a901:fe47%6]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 01:52:55 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Linus Walleij <linusw@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Sashiko AI Review
	<sashiko-bot@kernel.org>, Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean
	<olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Florian Fainelli
	<florian.fainelli@broadcom.com>, Jonas Gorski <jonas.gorski@gmail.com>, Hauke
 Mehrtens <hauke@hauke-m.de>, Kurt Kanzenbach <kurt@linutronix.de>, Woojung
 Huh <woojung.huh@microchip.com>, "UNGLinuxDriver@microchip.com"
	<UNGLinuxDriver@microchip.com>, "Chester A. Unal"
	<chester.a.unal@arinc9.com>, Daniel Golle <daniel@makrotopia.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Clark Wang
	<xiaoning.wang@nxp.com>, =?iso-8859-1?Q?Cl=E9ment_L=E9ger?=
	<clement.leger@bootlin.com>, George McCollister
	<george.mccollister@gmail.com>, David Yang <mmyangfl@gmail.com>
Subject: RE: [PATCH net] net: dsa: Fix skb ownership in taggers
Thread-Topic: [PATCH net] net: dsa: Fix skb ownership in taggers
Thread-Index: AQHc/RcBTOLg74hGDkWhQct8osUROLZAaB3Q
Date: Tue, 16 Jun 2026 01:52:55 +0000
Message-ID:
 <DU2PR04MB86299B366507B27AF2A3D6D588E52@DU2PR04MB8629.eurprd04.prod.outlook.com>
References: <20260616-dsa-fix-free-skb-v1-1-fd30b35dcf66@kernel.org>
In-Reply-To: <20260616-dsa-fix-free-skb-v1-1-fd30b35dcf66@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8629:EE_|DBBPR04MB7900:EE_
x-ms-office365-filtering-correlation-id: b99511a9-0359-424a-e64f-08decb49fc0e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|376014|23010399003|38070700021|22082099003|18002099003|11063799006|56012099006;
x-microsoft-antispam-message-info:
 djiELcDhJDybCtnuDmmrgEDbBoDUjtEJ2+ODE8fyIgxPK3GvA459RvLqj25nOxeUboX+FIgGKRAPvDK9T1f2sxjAsjGXd1wW42D5gIUVDP37NKVcxBtrhO8jWH0ruel/zjkIcT1xI2ZLIKfGJDVJE49DvExGgvGjOJMlRjS6x6oZBgEwjHwBfQyvm4qPwQSSl3cx8fb92nr0pIZ9KB7XuuB+FUH+nDqpRvzjWINfvB9LZbb/vi6zH9lCMs1BHwmYTK6YslxdI5jK0oYFw5kPJmcoxRlpB+EnpTbWm/RLmX9wS/b/1drwxQY6X60VGXSp4a/irgtFntkHLL/Hh5ZWUQH6qthHFnSDp/8jPPrj08QXs46c2WBCLT461/KNenL+2JN9Lt09jz2aMaBYeUimxa7rldJuotf7WMVFzW2BA0ApGBT1/Gx//UNDV+1IuvCOIY3TssgJUnERR4Z5MGManwOkIbS9+Io5zd6lNnfIZqXpgHUyWbjjtTg2u8SM+mrG0dpVF5pZsrFsW67KH1OUjjn0ern2MNiSxVPPvesn2ZNepn+hM+H1zgGMmMaXNp1dW2jCBrjM9m5IbzbbYXsRr4LWVMQSMDj1ncQEateTt7L4/oXQUJ8eArdWx2KUdCBpW42asonz3jnDCtzZqMa9+j2CvDCpLQPZ/aELiVmN1isqkWjXoAZfxW96evN3dkUo4YGdDFmSiUN0ctk319eicglQtfKcWLx5LwjzA/xGn+Hn0NTd5+Ji0ha1vZe7href
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8629.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(376014)(23010399003)(38070700021)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?tN7R3KGGxEx56WYRroP2nW8ZUNcISv3/vNbA+mWhFr8Jjq5Zh/NE02FizU?=
 =?iso-8859-1?Q?qDR2gJa80wI5/+WnpPkK4sA4ipEOOqAQzzk1ZM1vlwv9b5HC/KV2ydFw4w?=
 =?iso-8859-1?Q?j49DKbf1YMgdPOn2cZKkGca2c/YkAEVFl1bGyW8g37MnFwBcCykmYbuIBx?=
 =?iso-8859-1?Q?omTgh76vuaHE2QRJmJsI3DTyC79vGNXIbRI/w0S3ETCIuPFlPhiCo85EeD?=
 =?iso-8859-1?Q?PRgb0n1fPqBLQgA0r7bGSrMAyZ8uYBFpufWUJYb4eZlW9+zi9bqCX/8Y4K?=
 =?iso-8859-1?Q?uFH8G+O5o8sFTcUCFpIGMx64X2YXHxIGCzlWMGtXjmuj3mVQuFOcPs/4Vw?=
 =?iso-8859-1?Q?IsP2mD5KtJnVXagbmDvrp3MXf5W2stEk0jD1hj2kMHdy1UPEz+7uXDvwnA?=
 =?iso-8859-1?Q?WvZIAWdR78YELBIhb5EpHF88xLDll/AHowyGAMMwX7imzyFNRSrIY/fFfL?=
 =?iso-8859-1?Q?52yOjNz5b2w+rDEopio+BC0ZlmUBQCQGxFJLt7yPUDss7LWrcZZ0aivKPB?=
 =?iso-8859-1?Q?a46TqeAQ4NMV3NgEHGvV+yrWM2mshy4jqIqy5qyY+hfsJNqVhB1II3mea+?=
 =?iso-8859-1?Q?XAhVf0gwEM4oYX5Gd79EKYRdJ9u5V36uOEJoIR2kB/++a2aNCeQY7GKnwH?=
 =?iso-8859-1?Q?/jGIFT5IwDql6AYF2OGNtqOjTeP75NcJVDqFlKzhrnbs9m4WSSZpQLjsDW?=
 =?iso-8859-1?Q?oDIjZ8GlLIlEP8UZLhBhQdWKrlyWsKXUXVxUpd0Xxl7DFeWrevbbyfRa75?=
 =?iso-8859-1?Q?ZPXvdhvqD03NXjTbZA2QaCyYC8tIO8O8amhJa0vvrArV09I9jDHh9QFF9M?=
 =?iso-8859-1?Q?KLR/RRULBVMC/jIUrAdgT3uNuz+qykjj4ePU2vuMWM0EJ7cwsnY/CeLrvP?=
 =?iso-8859-1?Q?lwgayECyt8Ny7NNP5flE/NTPJ25gn+9NF0yPyBDpt6QQvczpZdH8D/R2/z?=
 =?iso-8859-1?Q?Y4Xyf9EEvmzKSG4Mnz9YIAD50iFeoC1M0Jc5t9o3mVQwgpebEV4TCz3meu?=
 =?iso-8859-1?Q?bRNpdQr/P7Sffk9oQGeDXawd9W6vwfpTcUUxNx1tKOB4b/Iw5LV7bkD005?=
 =?iso-8859-1?Q?ThwMjxRGaUdxW/YLhzEF3+NYR7Djx89j9eBQQkr60T5puOqDGZ11Qh0hnX?=
 =?iso-8859-1?Q?PBAmzZQg5+eWne4Ubt5B/PP3icF77ABf5WCm810ceMQ3pI9f4Kups4EO35?=
 =?iso-8859-1?Q?hu7PpeKIXddjzdQAQBERat0OUhAxsK7W7UxeAYTSNeZOcULvltkoInsP/9?=
 =?iso-8859-1?Q?WNJRhE1LL8wm7HFm0Tjmva02mp6ghV9HVQmYnYoMAQapl88lRYfhKKkNUN?=
 =?iso-8859-1?Q?KNiSVOfYNYSLT/u0rQosO4ocHuWggu1PdTXuL/lroHwRHWhZMhAekZfq79?=
 =?iso-8859-1?Q?sh0xsER1lquOqMc0TKZATqTMaFCEgELF4DJpt+N6SqYXmOTZ2bC00tONBc?=
 =?iso-8859-1?Q?Jr5jAIalH+9Y7POtr4eR9tEW50K2TqMnpuW1LHhP0asC2QVJg1B8uz2Gd7?=
 =?iso-8859-1?Q?+8zclSmqD6W6W78XQhhsbiPbR4zJFmND+CvAiFldo+tKKgA18lyY0gQaxY?=
 =?iso-8859-1?Q?93YZs60iqSMSrBLkRJ9gn6QsMU30BTvDrfP8aVJsEXaWSTfFQEgnJZvSFh?=
 =?iso-8859-1?Q?KI2tSEhO3kCpkgYpqg2nC+LyDUyi8pd4zB7iTIDoFfwr8c8IQUqLfTeKfV?=
 =?iso-8859-1?Q?tGR/sRU9d/y6cU1DBUSmLfYaVBs8yH6WpyHH61Fi3DehUcRoJaM9nA/2kQ?=
 =?iso-8859-1?Q?LB57p/+OqgowmQUjIN+c3LDC6EuxWDuLqdhddPqsnK6Jeo?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8629.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b99511a9-0359-424a-e64f-08decb49fc0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2026 01:52:55.4868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qp4x/9fxF9p228kz9DOaOQSjXWHhbXjP7ChRncFFLFog98IkHTaxqUrMQiLSJAZX0sARVleq31ad/Pwlga0Zyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7900
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299702-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linusw@kernel.org,m:netdev@vger.kernel.org,m:sashiko-bot@kernel.org,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:florian.fainelli@broadcom.com,m:jonas.gorski@gmail.com,m:hauke@hauke-m.de,m:kurt@linutronix.de,m:woojung.huh@microchip.com,m:UNGLinuxDriver@microchip.com,m:chester.a.unal@arinc9.com,m:daniel@makrotopia.org,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:xiaoning.wang@nxp.com,m:clement.leger@bootlin.com,m:george.mccollister@gmail.com,m:mmyangfl@gmail.com,m:jonasgorski@gmail.com,m:matthiasbgg@gmail.com,m:georgemccollister@gmail.com,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,broadcom.com,hauke-m.de,linutronix.de,microchip.com,arinc9.com,makrotopia.org,collabora.com,nxp.com,bootlin.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8E1B468B591

> diff --git a/net/dsa/tag_netc.c b/net/dsa/tag_netc.c
> index ccedfe3a80b6..b1bc67e28866 100644
> --- a/net/dsa/tag_netc.c
> +++ b/net/dsa/tag_netc.c
> @@ -130,14 +130,17 @@ static struct sk_buff *netc_rcv(struct sk_buff *skb=
,
>  	int tag_len, sw_id, port;
>  	int type, subtype;
>=20
> -	if (unlikely(!pskb_may_pull(skb, NETC_TAG_MAX_LEN)))
> +	if (unlikely(!pskb_may_pull(skb, NETC_TAG_MAX_LEN))) {
> +		kfree_skb(skb);
>  		return NULL;
> +	}
>=20
>  	tag_cmn =3D dsa_etype_header_pos_rx(skb);
>  	if (ntohs(tag_cmn->tpid) !=3D ETH_P_NXP_NETC) {
>  		dev_warn_ratelimited(&ndev->dev, "Unknown TPID 0x%04x\n",
>  				     ntohs(tag_cmn->tpid));
>=20
> +		kfree_skb(skb);
>  		return NULL;
>  	}
>=20
> @@ -150,13 +153,16 @@ static struct sk_buff *netc_rcv(struct sk_buff *skb=
,
>  		dev_warn_ratelimited(&ndev->dev,
>  				     "VEPA switch ID is not supported yet\n");
>=20
> +		kfree_skb(skb);
>  		return NULL;
>  	}
>=20
>  	port =3D FIELD_GET(NETC_TAG_PORT, tag_cmn->switch_port);
>  	skb->dev =3D dsa_conduit_find_user(ndev, sw_id, port);
> -	if (!skb->dev)
> +	if (!skb->dev) {
> +		kfree_skb(skb);
>  		return NULL;
> +	}
>=20
>  	type =3D FIELD_GET(NETC_TAG_TYPE, tag_cmn->type);
>  	subtype =3D FIELD_GET(NETC_TAG_SUBTYPE, tag_cmn->type);
> @@ -164,11 +170,14 @@ static struct sk_buff *netc_rcv(struct sk_buff *skb=
,
>  		dsa_default_offload_fwd_mark(skb);
>  	} else if (type =3D=3D NETC_TAG_TO_HOST) {
>  		/* Currently only subtype0 supported */
> -		if (subtype !=3D NETC_TAG_TH_SUBTYPE0)
> +		if (subtype !=3D NETC_TAG_TH_SUBTYPE0) {
> +			kfree_skb(skb);
>  			return NULL;
> +		}
>  	} else {
>  		dev_warn_ratelimited(&ndev->dev,
>  				     "Unexpected  tag type %d\n", type);
> +		kfree_skb(skb);
>  		return NULL;
>  	}

It would be better to add a label and use the goto statement for unified pr=
ocessing.


