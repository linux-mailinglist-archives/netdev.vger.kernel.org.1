Return-Path: <netdev+bounces-305371-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CkoaDq3FTGr4pQEAu9opvQ
	(envelope-from <netdev+bounces-305371-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 11:23:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F351719B52
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 11:23:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=chelsio.com header.s=selector1 header.b=tupVakLI;
	dmarc=pass (policy=reject) header.from=chelsio.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305371-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305371-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B9ED304F8A8
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 09:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A8732860B;
	Tue,  7 Jul 2026 09:16:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022130.outbound.protection.outlook.com [40.93.195.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161A0332EC8
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 09:15:58 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783415760; cv=fail; b=BUBXO9TFU4h6YVYN4Rp74Y7PWNyaZmHwVnQFx2W1CqOCpiklCOu9yYqISMh0jGzvxJTYTo+FsI7cCJeR06h+J0tFyK/JFlkIIC5eGGyOZQviJW//FZzPqyotSZv/ggJyajxaOHbsOjvleLG79OwPbDqgA1Af0ja/i/M3B+DEdro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783415760; c=relaxed/simple;
	bh=qrC9Vjpo2AZJNxSWUQW4xHOmkY/REbOSy3626c+hdYU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AGymlbzz0CwW/2jW+MjqtlpkDyTGTwuF7bXbJkoZEeooUy6ywTTSNIxsvcOVUNvFQgC2954ZknyxueEBYlfLT7/hKUndsQhlsRG6RBSHiy4xtPXexvkMvM5b86hvOFZ4kTGreGlub9bwDtvdX9yV43Z12uS7NKJMXNATd/sWqeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com; spf=pass smtp.mailfrom=chelsio.com; dkim=pass (1024-bit key) header.d=chelsio.com header.i=@chelsio.com header.b=tupVakLI; arc=fail smtp.client-ip=40.93.195.130
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DSLwFZLk/BgzAbiuOiMLkpsqhuN2fdi17swdLDiZmZ9tsI1nKIF0icI60iccxLLNmhO2GqvbRMUvCsMpExZfV1X8pMb4mo7G42anDN+13R0AWpn8M6QOmx+sml8UTEhs4vTXL+9/vTMh9EioYxaCnV3H7rJgQXhcoTaHFXzPORwYDSEZUpIJTvlWPpAUQLmBiJSdUxEk3f8mADIwqHnh/qoaYe5oWcwcUgqnDz5CCsfKs/DFTH8qZm5bEh6PkLuW81ChoUhdbv2OF6D56PevZiIKnmFiuZ0pmldHtZKbH8jPXN6JUOiJzBkV9g1rhOZs8BVjwuGFdKDC3ZZNhCDZtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFYvB9/xVDvmjnqNxX7oyhC2s3QwPOxzXbJzueV6c+Q=;
 b=ar0A5tNS1jfNGjd/pWHPqmzioihBhbqkAc0Yi0Nokgi5NxIrqF+jqHW8FV1SPlVrduKMcK5U9WIDoEJjQmVtOuuIEHu2QboxYs/YNhGLM762Gio+V5cbHwtGFQqqdNxY17quZ1q2deAmz34HjfZd2YeOhrxz7Tj1AQCtPLXIyF+KnhsIzPc99TUpyuYe5JgrAUKbj5Nx3SBv8o95IJt4gZVQ/JD2/UvBE5S2inCqq2Gd1YbwL9SsLv1OZ9uwqlYA+2l4a1tyatN6ZGOrSiRh1sPtBushxvKQuHd8UC64T/5FodNBafqZrw2r5ucbM0pewFtgjBrDLXQhCxc7h2mHqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chelsio.com; dmarc=pass action=none header.from=chelsio.com;
 dkim=pass header.d=chelsio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chelsio.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFYvB9/xVDvmjnqNxX7oyhC2s3QwPOxzXbJzueV6c+Q=;
 b=tupVakLI2h1Hj+x0PWqK9j6xfCagOw8WVljp1RErfZ9fHSLSxkxXs+UurVaLBZ6ohEtrodaQliKtSd78CwkcMPrvJy/ziqdG1KnlxUdtYrUQcSmvsyyX+B8AFwF1g39gyG2iX0KnJyQznWMzZBZ6NRgaprzlnT9o/bbyXtWzav8=
Received: from SJ1PR12MB6194.namprd12.prod.outlook.com (2603:10b6:a03:458::12)
 by CH1PR12MB9624.namprd12.prod.outlook.com (2603:10b6:610:2b3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 7 Jul
 2026 09:15:55 +0000
Received: from SJ1PR12MB6194.namprd12.prod.outlook.com
 ([fe80::2201:99d6:c63e:3d2a]) by SJ1PR12MB6194.namprd12.prod.outlook.com
 ([fe80::2201:99d6:c63e:3d2a%4]) with mapi id 15.21.0181.008; Tue, 7 Jul 2026
 09:15:55 +0000
From: Harsha Mahadeva <h.mahadeva@chelsio.com>
To: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, Potnuri Bharat Teja <bharat@chelsio.com>
Subject: Re: [PATCH net v2] cxgb4: flower: fix 802.1ad VLAN TPID matching in
 tc flower filters
Thread-Topic: [PATCH net v2] cxgb4: flower: fix 802.1ad VLAN TPID matching in
 tc flower filters
Thread-Index: AQHdCd5BGQATcD2K/kKiqREETdqvHbZZ1wkAgAf2nTU=
Date: Tue, 7 Jul 2026 09:15:54 +0000
Message-ID:
 <SJ1PR12MB619479EB2F45728D34E2ED5897F02@SJ1PR12MB6194.namprd12.prod.outlook.com>
References: <20260702044955.20119-1-h.mahadeva@chelsio.com>
 <PH0PR11MB590242E0F82125E42DB3F820F0F52@PH0PR11MB5902.namprd11.prod.outlook.com>
In-Reply-To:
 <PH0PR11MB590242E0F82125E42DB3F820F0F52@PH0PR11MB5902.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6194:EE_|CH1PR12MB9624:EE_
x-ms-office365-filtering-correlation-id: c88a190b-962f-4dde-427f-08dedc085953
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|18002099003|22082099003|38070700021|6133799003|56012099006|4143699003;
x-microsoft-antispam-message-info:
 crocx1OTYmByO26AOUqpxdgUQpPTwbnuso5ic8RYkcKuNSt0ygUozda64R1W7XdUKS1XmjYt+M3a+bC37hYMsRkqKNNEwx+EbVGTwew0cNEta4iC2bBitMv1oX0Fr2yp6tDaVGngprrKb6Mve9cuvZhmkeY6oaPTMWb8XrWfnnjudrryDDk0FivgrXWVV82xuzZ3tW2oJc31bZLSxfIryVJrcPHcsJhJDZ7qKjweoKIFPEIAUdnA1nMS0WsrkcPhG6anjQ2sF5yfQdvmx0325rxmh8NLDxGBJPWy49jViK0bFbS2ktUDQOfziKDF2M0GhWg0EeRk9K3wTQfMaKOiMFXKosqCLridapTPGOuDxlstGtjd7OR8faUB6j1Caio9idH06hyEx9nYUS652rVjHE01WiDCuqpZg4+oxqEy93re/SgWBs3W43lcxxDeCu3wo0lV/tZeOaCBHxUU0MkdWy+NFZ71vSYoHhQ4JxYcPgJoy2iE3EqTT/Ox7RLhIntNDgomGexYGo/TD/03OfRDB3hy8hzaFfoUk4u2PLQxedFuaMJA9VPOZ7+D54cjL9mKwFznhhFHoglX+3TzZP9XRbKjRNEeohvCsyydUXSycmfMKNgqMhPndzf5WLMC8cAnwNHeOGAVQVqx0G356AwNoq7HRE0XIOQoLK2TAWRszOXNd9T6OX64OTUVNgcDu1AKj+qrBbFhgJF2ekFJem/i8tTYGK0oqsywjFy5Mg3EdVA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(38070700021)(6133799003)(56012099006)(4143699003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?aTopldYzIbOd3vQl2ptB4DI53JaHLV5uBhavLEW1rNxLZ4V2j/B3P3eqLd?=
 =?iso-8859-1?Q?ZfvTvICM4ZjDSixx26+v5kaokNXFQvFby+kfLiCDIJimXeLS9IKNNIsLmM?=
 =?iso-8859-1?Q?/XUDJU4u9PNB6YCBuuBkd18vjAWRdHQv9Xgf933UQww0HBb82J9fKmR0k1?=
 =?iso-8859-1?Q?RPhhnnZHeIVUaxoD68RLOSDisHAHMWP6xO96KvyadZYUy7SGKpIKe5qWcF?=
 =?iso-8859-1?Q?bCZWrejMkpi4eD2cnOyE32Hni33q2Sod2sYaGtzV3R/y59euy29JvU63g3?=
 =?iso-8859-1?Q?qpZXb4j8hwtQqN6HHoNTe44JO+jM3cPc+qBWIbQRkt3T9IDkroawjMkvNi?=
 =?iso-8859-1?Q?BSAdrmw+RMWT3jV6ffzaCAqbuj9gBCAZpH9A4yJbrpJf0TkTDcHNjv+6DQ?=
 =?iso-8859-1?Q?U/i25Sa9E1Gmcz3a1vw2TYkUiOTouaXjXGODUAIW7j+01+hEXz4t/VCIgF?=
 =?iso-8859-1?Q?Ycowf5gk33hZ/Ax/p7lWFQI1LEXABzs1+yAFHjCkF8B5GDgQaKx8/5xJ0q?=
 =?iso-8859-1?Q?zqMpAacD6aF51dbDcghCGUunph+S8ica18B26kmy8YEo8VUBvDyiojMxDu?=
 =?iso-8859-1?Q?3YWuTU4GjsvtzfU7VgAVQefhYPL0WFR1AcfmbZNcTIAvYBY0UOcG3zIiS0?=
 =?iso-8859-1?Q?TMMJnnU1+v5rTNjGye3ptyZHR0TBFd+da9C7/apJ/KclH4ipIM+pvBg2rL?=
 =?iso-8859-1?Q?FGhvQ4DCiUfGiRfDZqbbJWOSiKKVDEknMuh7BSDi477WzFK9OHJUrzEds3?=
 =?iso-8859-1?Q?ej9MUhsop3Z2ckEsowKDIxlWLPmyIevcwqI7z8kqWyOHpu0ipZy2dau3j3?=
 =?iso-8859-1?Q?9U+tC/s3UOry6P20q+OrD0ewk68GZtSUTXjpd1dz4L6hDzSSEcQ+M4oBRO?=
 =?iso-8859-1?Q?rrqT2KqfAUWQwa4JsPcTG5i1ocXIOmAfv0HmNE+yuNyChHsnRQAWKuy33S?=
 =?iso-8859-1?Q?++0ikzBbJ+7/LeSW84xj6WGIcTJYh1pPS3WFDzN0iaQKzA8tyzepWsmNSo?=
 =?iso-8859-1?Q?a2JZr9QTLj/cmmkUaGAPVR+mU42N9jgw0lYVCKF9DoEiOWpORFCGW9OLfT?=
 =?iso-8859-1?Q?a5JEc3ic1BPzyLsYSF+5Q3SojTkDZYiYqCO4Hr32rNOoJPrUN+lhA2f7vZ?=
 =?iso-8859-1?Q?hg635EyJ3ljeYorrVm1++KUUu0U/gW9skwpqfuAWpgHijxusPmJGBsuBmc?=
 =?iso-8859-1?Q?Tz+EkpuSyfDHbB4a21k4qqJ54Su2EgQ/yT1TnBqFQf4o6UouC3R1NJ6qnK?=
 =?iso-8859-1?Q?PFIGrjWubCMrTQyCKw4q88OyqjY8FG4oXb5ahwb8IchLlxRmBoKkOLcHQK?=
 =?iso-8859-1?Q?ILdrwCuBV3Qivw4WFgHCVY48zILRbjkXHUgtbz3N/8PEPgVPbRHCoIUa/k?=
 =?iso-8859-1?Q?xL7eS1yg9GFeJsqugk9N0c3u5EsSPQY/640frVHN+BW1qNCpaBqCNxBiKc?=
 =?iso-8859-1?Q?tI0XTFRqIRuQo44wV12UBKTWr299UvivrrgNRcj4DAqpua68R+UFVjLUOO?=
 =?iso-8859-1?Q?Lou6mpJ2pB0wtv3UqivpUtyRJJlMo0300xSTMz/KfvCsPmCTZTIa3yaXWo?=
 =?iso-8859-1?Q?82oBQAplGU7gCBf8+OFRIB4hqywke769CAvZ6r8peo9H90ExCnpZso2gsP?=
 =?iso-8859-1?Q?2WHxahFo5sutyC1tpggWylwB4h6iDouZIad6qYX2Ovmwiy/cR1LNTH6vrC?=
 =?iso-8859-1?Q?7ho9kaZ68cRTFGbUgAw7iltVMd/BzMN3RWMDvGif0R6JwF7a5ryO9KqdZX?=
 =?iso-8859-1?Q?G01jJGgJPFvcxGtqhDbAaUA63ZqsWX/rp4YPB/uuDiqAHe1YdVcPXQZ8Zz?=
 =?iso-8859-1?Q?vNUsBWqlPQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: chelsio.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c88a190b-962f-4dde-427f-08dedc085953
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2026 09:15:54.9287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 065db76d-a7ae-4c60-b78a-501e8fc17095
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AwSXgCoqYDlRtOsH3ung+5mi53Frc/Zig1akTMD17d7mRys1wUZpHweVg0m4JL6r8VDen/ijYFE12lWUEAJQ5ttS0JrC1vz/CrktKIfZD+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9624
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[chelsio.com,reject];
	R_DKIM_ALLOW(-0.20)[chelsio.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-305371-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jedrzej.jagielski@intel.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:bharat@chelsio.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[h.mahadeva@chelsio.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[h.mahadeva@chelsio.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[chelsio.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,SJ1PR12MB6194.namprd12.prod.outlook.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9F351719B52

On Thursday, July 07/02/26, 2026 at 13:05:42 +0530, Jagielski, Jedrzej wrot=
e:=0A=
> From: Harsha M <h.mahadeva@chelsio.com> =0A=
> Sent: Thursday, July 2, 2026 6:49 AM=0A=
> =0A=
> >The cxgb4 driver does not correctly handle tc flower filters that=0A=
> >match on an 802.1ad (Q-in-Q) outer VLAN tag. While the VLAN VID is=0A=
> >processed, the specified 802.1ad TPID is not programmed into the=0A=
> >adapter's outer VLAN matching configuration, resulting in incorrect=0A=
> >filter matches.=0A=
> >=0A=
> >Fix this by configuring the port-specific OVLAN register with the=0A=
> >requested TPID value, enabling OVLAN matching through the RX control=0A=
> >register, and populating the filter specification with the outer VLAN=0A=
> >VID and valid-bit match fields when an 802.1ad TPID is requested.This=0A=
> >restores correct matching for tc flower filters that specify an 802.1ad=
=0A=
> >outer VLAN tag=0A=
> >=0A=
> =0A=
> Hi=0A=
=0A=
Hi Jedrzej,=0A=
Thanks for reviewing the patch=0A=
> =0A=
> would be nice to have fixes tag=0A=
=0A=
Sure, I'll add the appropriate Fixes: tag in the next revision=0A=
> =0A=
> >Signed-off-by: Harsha M <h.mahadeva@chelsio.com>=0A=
> >Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>=0A=
> >---=0A=
> >v2:=0A=
> >- Compare vlan_tpid with 'cpu_to_be16(ETH_P_8021AD)'=0A=
> >- Program the OVLAN register using the ETH_P_8021AD constant=0A=
> >  and TPID mask as 0xffff instead of deriving the value from the=0A=
> >  filter key and mask=0A=
> >v1:=0A=
> >https://lore.kernel.org/all/20260629184417.31b21223@kernel.org/=0A=
> >---=0A=
> > .../ethernet/chelsio/cxgb4/cxgb4_tc_flower.c  | 61 +++++++++++++------=
=0A=
> > drivers/net/ethernet/chelsio/cxgb4/t4_regs.h  |  3 +=0A=
> > 2 files changed, 46 insertions(+), 18 deletions(-)=0A=
> >=0A=
> >diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c b/driv=
ers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c=0A=
> >index 3307e5042681..8c5cfa6982e7 100644=0A=
> >--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c=0A=
> >+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c=0A=
> >@@ -40,6 +40,7 @@=0A=
> > #include "cxgb4.h"=0A=
> > #include "cxgb4_filter.h"=0A=
> > #include "cxgb4_tc_flower.h"=0A=
> >+#include "t4_regs.h"=0A=
> > =0A=
> > #define STATS_CHECK_PERIOD (HZ / 2)=0A=
> > =0A=
> >@@ -266,24 +267,48 @@ static void cxgb4_process_flow_match(struct net_de=
vice *dev,=0A=
> > 					       VLAN_PRIO_SHIFT);=0A=
> > 		vlan_tci_mask =3D match.mask->vlan_id | (match.mask->vlan_priority <<=
=0A=
> > 						     VLAN_PRIO_SHIFT);=0A=
> >-		fs->val.ivlan =3D vlan_tci;=0A=
> >-		fs->mask.ivlan =3D vlan_tci_mask;=0A=
> >-=0A=
> >-		fs->val.ivlan_vld =3D 1;=0A=
> >-		fs->mask.ivlan_vld =3D 1;=0A=
> >-=0A=
> >-		/* Chelsio adapters use ivlan_vld bit to match vlan packets=0A=
> >-		 * as 802.1Q. Also, when vlan tag is present in packets,=0A=
> >-		 * ethtype match is used then to match on ethtype of inner=0A=
> >-		 * header ie. the header following the vlan header.=0A=
> >-		 * So, set the ivlan_vld based on ethtype info supplied by=0A=
> >-		 * TC for vlan packets if its 802.1Q. And then reset the=0A=
> >-		 * ethtype value else, hw will try to match the supplied=0A=
> >-		 * ethtype value with ethtype of inner header.=0A=
> >-		 */=0A=
> >-		if (fs->val.ethtype =3D=3D ETH_P_8021Q) {=0A=
> >-			fs->val.ethtype =3D 0;=0A=
> >-			fs->mask.ethtype =3D 0;=0A=
> >+=0A=
> >+		if (match.key->vlan_tpid =3D=3D cpu_to_be16(ETH_P_8021AD)) {=0A=
> >+			struct adapter *adap =3D netdev2adap(dev);=0A=
> >+			u32 ovlan_reg, ctl_reg, val, port_id;=0A=
> >+=0A=
> >+			if (!adap) {=0A=
> =0A=
> is such scenario really even possible?=0A=
=0A=
You're right. netdev2adap(dev) should always return a valid adapter in this=
 path, so I'll remove the unnecessary NULL check=0A=
> =0A=
> >+				netdev_err(dev, "%s: adap not found\n", __func__);=0A=
> >+				return;=0A=
> >+			}=0A=
> >+=0A=
> >+			val =3D (0xffff << 16) | ETH_P_8021AD;=0A=
> >+			port_id =3D netdev2pinfo(dev)->port_id;=0A=
> >+			fs->val.ovlan =3D vlan_tci;=0A=
> >+			fs->mask.ovlan =3D vlan_tci_mask;=0A=
> >+			fs->val.ovlan_vld =3D 1;=0A=
> >+			fs->mask.ovlan_vld =3D 1;=0A=
> >+			ovlan_reg =3D PORT_REG(port_id, MPS_PORT_RX_OVLAN0_A);=0A=
> >+			ctl_reg =3D PORT_REG(port_id, MPS_PORT_RX_CTL_A);=0A=
> >+			t4_write_reg(adap, ovlan_reg, val);=0A=
> >+			val =3D t4_read_reg(adap, ctl_reg);=0A=
> >+			t4_write_reg(adap, ctl_reg, val | 1);=0A=
> >+			t4_tp_wr_bits_indirect(adap, TP_INGRESS_CONFIG_A, 1U << 9, 0);=0A=
> >+		} else {=0A=
> >+			fs->val.ivlan =3D vlan_tci;=0A=
> >+			fs->mask.ivlan =3D vlan_tci_mask;=0A=
> >+			fs->val.ivlan_vld =3D 1;=0A=
> >+			fs->mask.ivlan_vld =3D 1;=0A=
> >+=0A=
> >+			/* Chelsio adapters use ivlan_vld bit to match vlan packets=0A=
> >+			 * as 802.1Q. Also, when vlan tag is present in packets,=0A=
> >+			 * ethtype match is used then to match on ethtype of inner=0A=
> >+			 * header ie. the header following the vlan header.=0A=
> >+			 * So, set the ivlan_vld based on ethtype info supplied by=0A=
> >+			 * TC for vlan packets if its 802.1Q. And then reset the=0A=
> >+			 * ethtype value else, hw will try to match the supplied=0A=
> >+			 * ethtype value with ethtype of inner header.=0A=
> >+			 */=0A=
> >+=0A=
> =0A=
> isn't this already fs->val.ethtype !=3D ETH_P_8021Q branch and fs has not=
=0A=
> been modified since entering?=0A=
=0A=
This branch is based on match.key->vlan_tpid !=3D ETH_P_8021AD, not on fs->=
val.ethtype=0A=
> =0A=
> >+			if (fs->val.ethtype =3D=3D ETH_P_8021Q) {=0A=
> >+				fs->val.ethtype =3D 0;=0A=
> >+				fs->mask.ethtype =3D 0;=0A=
> >+			}=0A=
> > 		}=0A=
> > 	}=0A=
> > =0A=
> >diff --git a/drivers/net/ethernet/chelsio/cxgb4/t4_regs.h b/drivers/net/=
ethernet/chelsio/cxgb4/t4_regs.h=0A=
> >index 695916ba0405..38c585f3b1ad 100644=0A=
> >--- a/drivers/net/ethernet/chelsio/cxgb4/t4_regs.h=0A=
> >+++ b/drivers/net/ethernet/chelsio/cxgb4/t4_regs.h=0A=
> >@@ -1921,6 +1921,9 @@=0A=
> > #define MAC_PORT_PTP_SUM_LO_A 0x990=0A=
> > #define MAC_PORT_PTP_SUM_HI_A 0x994=0A=
> > =0A=
> >+#define MPS_PORT_RX_OVLAN0_A 0x120=0A=
> >+#define MPS_PORT_RX_CTL_A    0X100=0A=
> >+=0A=
> > #define MPS_CMN_CTL_A	0x9000=0A=
> > =0A=
> > #define COUNTPAUSEMCRX_S    5=0A=
> >-- =0A=
> >2.43.5=0A=
> =0A=
> =0A=

